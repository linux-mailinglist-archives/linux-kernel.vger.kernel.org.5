Return-Path: <linux-kernel+bounces-114035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC2588887FB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:15:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 752C01F268DA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:15:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03A0022C673;
	Sun, 24 Mar 2024 23:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J2NJFAA1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A261FC0FD;
	Sun, 24 Mar 2024 23:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321314; cv=none; b=Prf/t13xzHdrKmHM6RlSBepTeUNFxO8jw8ljSaLDXnQ4MXQKrIZBvB/GKuI6SbejRUCI3i0zQbr4aHCUtFYl4din+jvLCCFAS0MqpCSxDWq+PFhWmZSbknQHLoYrGU9rcZSaduDdhTj+16s8tjmXne9jlog/CTXQWT6PSY7OsC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321314; c=relaxed/simple;
	bh=/d0AEGoBRuH3lFe8OUNhobKL/Wwa069uJ2JkGwpBGnI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qZ6zxub8pd9jjxpBc8HGlEPoQflad6+MaCAtJDnDD8hhMdSggwOojvogK7NqYsUT4e5LSn2436uqJ9w3eFxRN7wTv5SCl92Uo5RMpeC47qFA8bJyA4XZtL9jYt1JVBA4aYQ2b90O3ZksVyuyrhUPUnNoqI3C5ovGMdCWNKTkn4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J2NJFAA1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72D25C43390;
	Sun, 24 Mar 2024 23:01:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321313;
	bh=/d0AEGoBRuH3lFe8OUNhobKL/Wwa069uJ2JkGwpBGnI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=J2NJFAA15OGtzNi11/6vSrFLu7/HB/2G6N/NDaGeQFd4jQtzG+nc0gtPQR/1mzUgf
	 gt7Gd701v2l6RdSCbfUx57ZXzMGmU704pXb0JvFlZVvmDgidtTlsybLZobaZ7wr81C
	 SoxD1P3TAWVgmI5tHCRwPS/QKe3tGzxnWax62PciYORt1XArdkxZ+H3f+/SgCOMp2o
	 +MlROU/c1g7K3fAtiOqzR0zSylDfA0hB6+fwTVp3Ovl/hFhrDzMPnXYUoISn/dgrFC
	 4yR47WhkYnplCjNGAjNOrL3fNJ9dJr4joKzpbVKZr6PkVK+VVpdE2z2qknxqqUy6pr
	 Cc6MTAEqBjz+Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Mikulas Patocka <mpatocka@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 036/638] dm-verity, dm-crypt: align "struct bvec_iter" correctly
Date: Sun, 24 Mar 2024 18:51:13 -0400
Message-ID: <20240324230116.1348576-37-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Mikulas Patocka <mpatocka@redhat.com>

[ Upstream commit 787f1b2800464aa277236a66eb3c279535edd460 ]

"struct bvec_iter" is defined with the __packed attribute, so it is
aligned on a single byte. On X86 (and on other architectures that support
unaligned addresses in hardware), "struct bvec_iter" is accessed using the
8-byte and 4-byte memory instructions, however these instructions are less
efficient if they operate on unaligned addresses.

(on RISC machines that don't have unaligned access in hardware, GCC
generates byte-by-byte accesses that are very inefficient - see [1])

This commit reorders the entries in "struct dm_verity_io" and "struct
convert_context", so that "struct bvec_iter" is aligned on 8 bytes.

[1] https://lore.kernel.org/all/ZcLuWUNRZadJr0tQ@fedora/T/

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Signed-off-by: Mike Snitzer <snitzer@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/dm-crypt.c  | 4 ++--
 drivers/md/dm-verity.h | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/md/dm-crypt.c b/drivers/md/dm-crypt.c
index 5a296db23feb3..aa6bb5b4704ba 100644
--- a/drivers/md/dm-crypt.c
+++ b/drivers/md/dm-crypt.c
@@ -53,11 +53,11 @@
 struct convert_context {
 	struct completion restart;
 	struct bio *bio_in;
-	struct bio *bio_out;
 	struct bvec_iter iter_in;
+	struct bio *bio_out;
 	struct bvec_iter iter_out;
-	u64 cc_sector;
 	atomic_t cc_pending;
+	u64 cc_sector;
 	union {
 		struct skcipher_request *req;
 		struct aead_request *req_aead;
diff --git a/drivers/md/dm-verity.h b/drivers/md/dm-verity.h
index 4620a98c99561..db93a91169d5e 100644
--- a/drivers/md/dm-verity.h
+++ b/drivers/md/dm-verity.h
@@ -80,12 +80,12 @@ struct dm_verity_io {
 	/* original value of bio->bi_end_io */
 	bio_end_io_t *orig_bi_end_io;
 
+	struct bvec_iter iter;
+
 	sector_t block;
 	unsigned int n_blocks;
 	bool in_tasklet;
 
-	struct bvec_iter iter;
-
 	struct work_struct work;
 
 	char *recheck_buffer;
-- 
2.43.0


