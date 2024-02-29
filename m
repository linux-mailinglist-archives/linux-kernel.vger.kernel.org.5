Return-Path: <linux-kernel+bounces-87504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74CA486D53E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 21:58:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A552B1C222AF
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 20:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80BA01690BB;
	Thu, 29 Feb 2024 20:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="loHF5EoD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F561690A1;
	Thu, 29 Feb 2024 20:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709239283; cv=none; b=uTA56ZdOEZVVWGcQeZduxKzOkl4NlT68ApRukDnIGZZc89fcQWnSyx0SYtzFJ4NEV2pg3Zv9lmIkGVM3MjA3xc9ElEU0ndJEc1hxONSC3t2C074nB/QCcpAyy92HqVeWTYzXPDdL8gDPley81TQy3sTwL1wbdsvED7knBhEmLlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709239283; c=relaxed/simple;
	bh=HgQFFOvD9t8faJspiAQnniBSfen1VpgZbB5fk8QC1SU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LZAWxAWQF+PmQ6r9vTF7rsU0gPV4TGKl2OZMd06eDemSFnjsPpWbej2QvIUBHYWDdk5V29HEynNXS3xxZqXEVhX3dAblJ3f1YeodCNEr/I417jz1uwiRXLSOPewKpL69/DcxKvgfDV/EFoAdqwoieF+KcwxzCL1T0XxO0QE1I6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=loHF5EoD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0835C433C7;
	Thu, 29 Feb 2024 20:41:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709239283;
	bh=HgQFFOvD9t8faJspiAQnniBSfen1VpgZbB5fk8QC1SU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=loHF5EoDaIXAyYzmohrUeGMbfpS2DCH0ODtWbS5bAurrJlp7Re2+weKy5WmXVLUoX
	 sSI0MuEDZd325096tMum7utDdnH9a3ebObSnw7auBBANrgXM0KLtWLirJ5yfEwXshx
	 r15ACfMks6dZaLZUZaR7OLKFYL1JIjUnkRvwDppHSaQii5mGBlrJ3t2x/TrNdfkx1Z
	 agO6enq0Bxm1uzK6BttVBFglE1RDzOM+gK8VJn+d1G3yUrMiuVVluWArK/gnyYeXOl
	 /pEPI7rZvQl0Iyf19YV2KsD9eEoHZgNklxjU7I8wjWdiqVqg/21ehPTOeGvGyswAzV
	 67ajeROpmcZfA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Mikulas Patocka <mpatocka@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	agk@redhat.com,
	dm-devel@lists.linux.dev
Subject: [PATCH AUTOSEL 5.15 9/9] dm-verity, dm-crypt: align "struct bvec_iter" correctly
Date: Thu, 29 Feb 2024 15:41:05 -0500
Message-ID: <20240229204107.2861780-9-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240229204107.2861780-1-sashal@kernel.org>
References: <20240229204107.2861780-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.149
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
index a428770102a37..edb70cacd805d 100644
--- a/drivers/md/dm-crypt.c
+++ b/drivers/md/dm-crypt.c
@@ -49,11 +49,11 @@
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
index 78d1e51195ada..f61c89c79cf5b 100644
--- a/drivers/md/dm-verity.h
+++ b/drivers/md/dm-verity.h
@@ -74,11 +74,11 @@ struct dm_verity_io {
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


