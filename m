Return-Path: <linux-kernel+bounces-115048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D081888CC2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:30:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D6D11F29671
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D37D2EFB62;
	Mon, 25 Mar 2024 01:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kZvd0NKQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4222817DC1E;
	Sun, 24 Mar 2024 23:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323844; cv=none; b=TPCTcnZVUeTadOERO9Fmm20xVX9bRKCbnVC94OzyY/RHHviQedPofF6KqTBYuSYUM3cC37MU382OBpsdgTu/pyApal25Wuo2dhpsi1NIjeN/tovSjA0pKdUR9ZyCYoCWL+F0mm09NoPaiWj5tMQZcB2tJplBpXku9etUr0HTZ2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323844; c=relaxed/simple;
	bh=CBebaG+0xbdd5y6jn27EFF7OtljaxvopzEok4XjCYh4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MQemNIU0t7FqcnSAWv3WnYvSHmlLQHHaxgycM8egW/vKVBLL8Y8pAjwJ0IAWc8ypYcZUX+rJuhxBPGfZMlGaXJTGIKLtk1v2Jj6kUUrJ3vaIaIba2A83l9QgSgBeH6QylIv3NcUoLh3CSZ2WpiehDVk7OQCpE+R9rx+JL7+XD+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kZvd0NKQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FB28C43399;
	Sun, 24 Mar 2024 23:44:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323843;
	bh=CBebaG+0xbdd5y6jn27EFF7OtljaxvopzEok4XjCYh4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kZvd0NKQ+gUCZPSaqH9LHE5L02tnyvuOlYudjUYk6xjbW8KXrOS7YWft+mR+g4L4x
	 zORy6RW68KqBli0W3MCeKa3JaTul+Bum1CYpMettWSJDThzcMUK9d9v2hFaUPU/KgH
	 bVT7ypB/ZgKrz2Yyy/vGEvTiVRC3j/61toLsaEy4EfmzzlxzWzZr80FrmKSUFiGMIg
	 MoB4/esZ6aM8biG78FXHuDdNUeIPH2m5a9V5yyqMV3LbG3Sf1A4D7gZxEsxDEMeB2I
	 3d9KA2QRbPVSx8hwYQzVYvC+gmGCdjR1oPN5w0fgGuy0cg/OowWgpd+f15jCoaqhtD
	 oiceCQduEpJjA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	Dmitry Antipov <dmantipov@yandex.ru>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 221/238] soc: fsl: dpio: fix kcalloc() argument order
Date: Sun, 24 Mar 2024 19:40:09 -0400
Message-ID: <20240324234027.1354210-222-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234027.1354210-1-sashal@kernel.org>
References: <20240324234027.1354210-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

[ Upstream commit 72ebb41b88f9d7c10c5e159e0507074af0a22fe2 ]

A previous bugfix added a call to kcalloc(), which starting in gcc-14
causes a harmless warning about the argument order:

drivers/soc/fsl/dpio/dpio-service.c: In function 'dpaa2_io_service_enqueue_multiple_desc_fq':
drivers/soc/fsl/dpio/dpio-service.c:526:29: error: 'kcalloc' sizes specified with 'sizeof' in the earlier argument and not in the later argument [-Werror=calloc-transposed-args]
  526 |         ed = kcalloc(sizeof(struct qbman_eq_desc), 32, GFP_KERNEL);
      |                             ^~~~~~
drivers/soc/fsl/dpio/dpio-service.c:526:29: note: earlier argument should specify number of elements, later size of each element

Since the two are only multiplied, the order does not change the
behavior, so just fix it now to shut up the compiler warning.

Dmity independently came up with the same fix.

Fixes: 5c4a5999b245 ("soc: fsl: dpio: avoid stack usage warning")
Reported-by: Dmitry Antipov <dmantipov@yandex.ru>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/soc/fsl/dpio/dpio-service.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/fsl/dpio/dpio-service.c b/drivers/soc/fsl/dpio/dpio-service.c
index 779c319a4b820..6cdd2c517ba68 100644
--- a/drivers/soc/fsl/dpio/dpio-service.c
+++ b/drivers/soc/fsl/dpio/dpio-service.c
@@ -485,7 +485,7 @@ int dpaa2_io_service_enqueue_multiple_desc_fq(struct dpaa2_io *d,
 	struct qbman_eq_desc *ed;
 	int i, ret;
 
-	ed = kcalloc(sizeof(struct qbman_eq_desc), 32, GFP_KERNEL);
+	ed = kcalloc(32, sizeof(struct qbman_eq_desc), GFP_KERNEL);
 	if (!ed)
 		return -ENOMEM;
 
-- 
2.43.0


