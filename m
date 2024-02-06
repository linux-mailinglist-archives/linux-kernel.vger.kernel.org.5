Return-Path: <linux-kernel+bounces-54273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B57D484AD22
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 04:53:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 721CA283DA5
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 03:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0859C745EC;
	Tue,  6 Feb 2024 03:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g0kcoV/g"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 402416E2D0;
	Tue,  6 Feb 2024 03:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707191601; cv=none; b=N3IX0RowkkbKDOk6AvWln2i3qwUvJPjODN9Pe51M/pTF1QhcU/en+53cKtm5NY1TngjxuApXQGTAJEC6nB5vZU5b7bR9BP4+7UT9jlmsS/pBQX1qLNMNAaxSsIwhaaVH4PAUsB9yHJzStvLXeo0to3NTfrlKIcHv9DcF7/8kfgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707191601; c=relaxed/simple;
	bh=/k++I+FlpxJrLePv6Y8ZWwlFxvuSh3CWBS9wIPPph6k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=p02GxGXeeBEoUBXp/MnFPdq+Y39zDndntH7Fh2nXiLDsCMLnTfeP7s3FleW5QF1UC6hjc8bWUGeVU8Isw2X/ZamsvdB9ADiXg3jojvs4MDgCynxHel8gKcN/EoQsPEwkmOQT9i67Gd1VmvWja74PRy9+Xb8vTU83HgNgBJ4Qv+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g0kcoV/g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08E44C433F1;
	Tue,  6 Feb 2024 03:53:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707191600;
	bh=/k++I+FlpxJrLePv6Y8ZWwlFxvuSh3CWBS9wIPPph6k=;
	h=From:To:Cc:Subject:Date:From;
	b=g0kcoV/g2XabtIjn66NwsnSiaoUP0ML/i0+W8/WTGNZwmds5SyPwvE4hH8wVwAem1
	 yir8NozK989nuDd+vL2czGitX8NXYPITfAKVQMpbyS4GPC5nKhP59xQX3n+UgJ0KId
	 kn3W2uNoDrJFF7Nyhs8bRxyxIt6X4enJKbYcvi/gDWHJDWjQRIwz5bvsSceAKxMU4A
	 Sxw6NEBK2Ip/xtgb1f7hrLLXkdm70oI8MyN/ISYFu7vAGlnsC+qmeYlKOmlY561MC5
	 hAPQlzdWbB7/KPT3/gQTycNAaJndbB8GQ90WuHjp2mWF4jdieMZ/KmPZzxdjgt6ii6
	 wEIUIKP1fxaVQ==
From: Chao Yu <chao@kernel.org>
To: "James E . J . Bottomley" <jejb@linux.ibm.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>
Subject: [PATCH v6] scsi: support packing multi-segment in UNMAP command
Date: Tue,  6 Feb 2024 11:53:04 +0800
Message-Id: <20240206035304.2503296-1-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As SCSI SBC4 specification section 5.30.2 describes that it can
support unmapping one or more LBA range in single UNMAP command.

However, previously we only pack one LBA range in UNMAP command
by default no matter device gives the block limits that says it
can support unmapping multiple LBA ranges with a single UNMAP
command.

This patch sets max_discard_segments config according to block
limits of device, and supports unmapping multiple LBA ranges with
a single UNMAP command.

Signed-off-by: Chao Yu <chao@kernel.org>
---
v6:
- in this version, we fix a compatibility issue: for a scsi device
which doesn't support handling multiple ranges in single UNMAP
command, it should to load start LBA and length of target range
from rq.__sector and rq.__data_len, instead of bi_sector and
bi_size in first bio in bio chain, otherwise if there is multiple
bios were chained in request, we may miss to add ranges of following
bios in the chain into UNMAP command.
 drivers/scsi/sd.c | 46 +++++++++++++++++++++++++++++++++++-----------
 drivers/scsi/sd.h |  1 +
 2 files changed, 36 insertions(+), 11 deletions(-)

diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index 542a4bbb21bc..5d5420b36070 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -832,6 +832,8 @@ static void sd_config_discard(struct scsi_disk *sdkp, unsigned int mode)
 	q->limits.discard_granularity =
 		max(sdkp->physical_block_size,
 		    sdkp->unmap_granularity * logical_block_size);
+	blk_queue_max_discard_segments(q, min_t(u32, U16_MAX,
+				sdkp->max_unmap_block_desc_count));
 	sdkp->provisioning_mode = mode;
 
 	switch (mode) {
@@ -891,9 +893,12 @@ static blk_status_t sd_setup_unmap_cmnd(struct scsi_cmnd *cmd)
 	struct scsi_device *sdp = cmd->device;
 	struct request *rq = scsi_cmd_to_rq(cmd);
 	struct scsi_disk *sdkp = scsi_disk(rq->q->disk);
-	u64 lba = sectors_to_logical(sdp, blk_rq_pos(rq));
-	u32 nr_blocks = sectors_to_logical(sdp, blk_rq_sectors(rq));
-	unsigned int data_len = 24;
+	struct bio *bio;
+	unsigned short segments = blk_rq_nr_discard_segments(rq);
+	unsigned int data_len = 8 + 16 * segments;
+	unsigned int descriptor_offset = 8;
+	u64 lba;
+	u32 nr_blocks;
 	char *buf;
 
 	buf = sd_set_special_bvec(rq, data_len);
@@ -902,12 +907,28 @@ static blk_status_t sd_setup_unmap_cmnd(struct scsi_cmnd *cmd)
 
 	cmd->cmd_len = 10;
 	cmd->cmnd[0] = UNMAP;
-	cmd->cmnd[8] = 24;
+	cmd->cmnd[7] = data_len >> 8;
+	cmd->cmnd[8] = data_len & 0xff;
+
+	put_unaligned_be16(6 + 16 * segments, &buf[0]);
+	put_unaligned_be16(16 * segments, &buf[2]);
 
-	put_unaligned_be16(6 + 16, &buf[0]);
-	put_unaligned_be16(16, &buf[2]);
-	put_unaligned_be64(lba, &buf[8]);
-	put_unaligned_be32(nr_blocks, &buf[16]);
+	if (segments > 1) {
+		__rq_for_each_bio(bio, rq) {
+			lba = sectors_to_logical(sdp, bio->bi_iter.bi_sector);
+			nr_blocks = sectors_to_logical(sdp, bio_sectors(bio));
+
+			put_unaligned_be64(lba, &buf[descriptor_offset]);
+			put_unaligned_be32(nr_blocks, &buf[descriptor_offset + 8]);
+			descriptor_offset += 16;
+		}
+	} else {
+		lba = sectors_to_logical(sdp, blk_rq_pos(rq));
+		nr_blocks = sectors_to_logical(sdp, blk_rq_sectors(rq));
+
+		put_unaligned_be64(lba, &buf[descriptor_offset]);
+		put_unaligned_be32(nr_blocks, &buf[descriptor_offset + 8]);
+	}
 
 	cmd->allowed = sdkp->max_retries;
 	cmd->transfersize = data_len;
@@ -3066,7 +3087,7 @@ static void sd_read_block_limits(struct scsi_disk *sdkp)
 	sdkp->opt_xfer_blocks = get_unaligned_be32(&vpd->data[12]);
 
 	if (vpd->len >= 64) {
-		unsigned int lba_count, desc_count;
+		unsigned int lba_count;
 
 		sdkp->max_ws_blocks = (u32)get_unaligned_be64(&vpd->data[36]);
 
@@ -3074,9 +3095,12 @@ static void sd_read_block_limits(struct scsi_disk *sdkp)
 			goto out;
 
 		lba_count = get_unaligned_be32(&vpd->data[20]);
-		desc_count = get_unaligned_be32(&vpd->data[24]);
 
-		if (lba_count && desc_count)
+		/* Extract the MAXIMUM UNMAP BLOCK DESCRIPTOR COUNT. */
+		sdkp->max_unmap_block_desc_count =
+					get_unaligned_be32(&vpd->data[24]);
+
+		if (lba_count && sdkp->max_unmap_block_desc_count)
 			sdkp->max_unmap_blocks = lba_count;
 
 		sdkp->unmap_granularity = get_unaligned_be32(&vpd->data[28]);
diff --git a/drivers/scsi/sd.h b/drivers/scsi/sd.h
index 409dda5350d1..c17f605f2bae 100644
--- a/drivers/scsi/sd.h
+++ b/drivers/scsi/sd.h
@@ -119,6 +119,7 @@ struct scsi_disk {
 	u32		opt_xfer_blocks;
 	u32		max_ws_blocks;
 	u32		max_unmap_blocks;
+	u32		max_unmap_block_desc_count;
 	u32		unmap_granularity;
 	u32		unmap_alignment;
 	u32		index;
-- 
2.40.1


