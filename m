Return-Path: <linux-kernel+bounces-87521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8F3886D572
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 22:02:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D6381F2546C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 21:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C1EB16F0D5;
	Thu, 29 Feb 2024 20:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pvm6vBCl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 563E916F0B8;
	Thu, 29 Feb 2024 20:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709239322; cv=none; b=ndkZ13xHRlH7YztQ/2gzw6Fh6sbvlBK6ZdItvDBulRvEqJbW745vxiblIZjk3ojaG/rARLPi0yU1YIWMZDnDKkBxolXC70tD40uYLjB8QPh7fEh/n+0hBVApmksqeUHNsxpQj8PrGjgeSK0/PCa4OhzAP+HzxrxqidExXvvzcvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709239322; c=relaxed/simple;
	bh=X1byIlXeIz167Amrt02P8NABM5QDhaNslmYNbZSOmCA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VPWKMNN/JV+dK2iSgx9MdAfcBax6h99GeJtsVE6aYvXdVoQyFGEbwct04y1U7a4p/Psi/Gq5l98J91SYkeseHmEFH3EVXOB/O9rDvUfwMpqN/I2XRpWgQL+LZhFw62eE3yQeQmBOOrT+b8pU4gYaMKNLd5v9cJJ3WZxBHzrnGEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pvm6vBCl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6D5BC433A6;
	Thu, 29 Feb 2024 20:42:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709239321;
	bh=X1byIlXeIz167Amrt02P8NABM5QDhaNslmYNbZSOmCA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pvm6vBCluo2Dh+IqLcpLQVGzLpTOSbnd0smGDIipAvT9PabsG1H6/1MB4higBbAPh
	 xWJSs9ZAw2pLy6a9hmym5Ugrt2Xci85ksirIqzpC9JIXmP3ZwlCT9jXBaosB7nXbkq
	 7WBrsQx6rb7qf65Le1Z0ejMnq+vTjHPrMLLcG26iYeejAezZUQnQf+XqcnKXSM6U2k
	 FA1f/QtWVB+VBMb1lA8PDPCCEo4ChF8m1PlmNPv7zviryOYGDCtk5E5goi1c3yORqp
	 MN8FU6hx3CZjl5XAzn6T0sMYBf9rf+eVILKBQwCn6GhGmyu/E2hbkfcFsQQaWW66jc
	 FUMqRRxXZG54g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Mikulas Patocka <mpatocka@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	agk@redhat.com,
	dm-devel@lists.linux.dev
Subject: [PATCH AUTOSEL 5.4 6/6] dm-verity, dm-crypt: align "struct bvec_iter" correctly
Date: Thu, 29 Feb 2024 15:41:46 -0500
Message-ID: <20240229204150.2862196-6-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240229204150.2862196-1-sashal@kernel.org>
References: <20240229204150.2862196-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.269
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
index 4301f22bbfa6c..41647cb576bd0 100644
--- a/drivers/md/dm-crypt.c
+++ b/drivers/md/dm-crypt.c
@@ -46,11 +46,11 @@
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
index 74ad36b6dbf53..fee7c7a81ce4e 100644
--- a/drivers/md/dm-verity.h
+++ b/drivers/md/dm-verity.h
@@ -73,11 +73,11 @@ struct dm_verity_io {
 	/* original value of bio->bi_end_io */
 	bio_end_io_t *orig_bi_end_io;
 
+	struct bvec_iter iter;
+
 	sector_t block;
 	unsigned n_blocks;
 
-	struct bvec_iter iter;
-
 	struct work_struct work;
 
 	/*
-- 
2.43.0


