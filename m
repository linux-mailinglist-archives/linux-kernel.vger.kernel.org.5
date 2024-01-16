Return-Path: <linux-kernel+bounces-26730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92BFA82E5A6
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 01:49:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 19D15B226C9
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 00:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B473F1D6A8;
	Tue, 16 Jan 2024 00:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pc1vAcSK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E311D55C;
	Tue, 16 Jan 2024 00:24:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFDB2C433F1;
	Tue, 16 Jan 2024 00:24:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705364673;
	bh=My/GFt1IQOVLc+gYzB6g6/sg0L7W9/aHk/58FNKbkTQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Pc1vAcSK3uuSU9L413MPd6ohMMRLL7hQCDJLItkUoffxTY0NXAl2uEVkcTsEw07Mc
	 U3KiIuNZiPKFwaJS988IomDK2jEvX4LyPLqOYDrAUBG/2YfsNvTNB7cxrgynAFTU+X
	 cRf4X6kQmlHTY1DTxyoeA2sjKCMupy4cSLCkhnS95r9c/1KcPxvnN8AXJ11WZFcmp9
	 0pNjeQcym9wsrwyvH8gkFDGv7VkRVOWWLAbEO2pD5JBMyTpbZopDYZcb0GgJwldeeH
	 8y5O+mY94ZY0pPyUU6C/VhJvIaZ9L5bnCKZw9HqPx5+KhOmZK8B7nTXha59QjAvxjO
	 iH/lxrX4t8kIQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>,
	davem@davemloft.net,
	mpe@ellerman.id.au,
	linux-crypto@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH AUTOSEL 6.6 08/19] crypto: p10-aes-gcm - Avoid -Wstringop-overflow warnings
Date: Mon, 15 Jan 2024 19:23:43 -0500
Message-ID: <20240116002413.215163-8-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116002413.215163-1-sashal@kernel.org>
References: <20240116002413.215163-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.12
Content-Transfer-Encoding: 8bit

From: "Gustavo A. R. Silva" <gustavoars@kernel.org>

[ Upstream commit aaa03fdb56c781db4a4831dd5d6ec8817918c726 ]

The compiler doesn't know that `32` is an offset into the Hash table:

 56 struct Hash_ctx {
 57         u8 H[16];       /* subkey */
 58         u8 Htable[256]; /* Xi, Hash table(offset 32) */
 59 };

So, it legitimately complains about a potential out-of-bounds issue
if `256 bytes` are accessed in `htable` (this implies going
`32 bytes` beyond the boundaries of `Htable`):

arch/powerpc/crypto/aes-gcm-p10-glue.c: In function 'gcmp10_init':
arch/powerpc/crypto/aes-gcm-p10-glue.c:120:9: error: 'gcm_init_htable' accessing 256 bytes in a region of size 224 [-Werror=stringop-overflow=]
  120 |         gcm_init_htable(hash->Htable+32, hash->H);
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
arch/powerpc/crypto/aes-gcm-p10-glue.c:120:9: note: referencing argument 1 of type 'unsigned char[256]'
arch/powerpc/crypto/aes-gcm-p10-glue.c:120:9: note: referencing argument 2 of type 'unsigned char[16]'
arch/powerpc/crypto/aes-gcm-p10-glue.c:40:17: note: in a call to function 'gcm_init_htable'
   40 | asmlinkage void gcm_init_htable(unsigned char htable[256], unsigned char Xi[16]);
      |                 ^~~~~~~~~~~~~~~

Address this by avoiding specifying the size of `htable` in the function
prototype; and just for consistency, do the same for parameter `Xi`.

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Closes: https://lore.kernel.org/linux-next/20231121131903.68a37932@canb.auug.org.au/
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/crypto/aes-gcm-p10-glue.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/crypto/aes-gcm-p10-glue.c b/arch/powerpc/crypto/aes-gcm-p10-glue.c
index 4b6e899895e7..f62ee54076c0 100644
--- a/arch/powerpc/crypto/aes-gcm-p10-glue.c
+++ b/arch/powerpc/crypto/aes-gcm-p10-glue.c
@@ -37,7 +37,7 @@ asmlinkage void aes_p10_gcm_encrypt(u8 *in, u8 *out, size_t len,
 				    void *rkey, u8 *iv, void *Xi);
 asmlinkage void aes_p10_gcm_decrypt(u8 *in, u8 *out, size_t len,
 				    void *rkey, u8 *iv, void *Xi);
-asmlinkage void gcm_init_htable(unsigned char htable[256], unsigned char Xi[16]);
+asmlinkage void gcm_init_htable(unsigned char htable[], unsigned char Xi[]);
 asmlinkage void gcm_ghash_p10(unsigned char *Xi, unsigned char *Htable,
 		unsigned char *aad, unsigned int alen);
 
-- 
2.43.0


