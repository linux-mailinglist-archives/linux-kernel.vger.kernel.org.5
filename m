Return-Path: <linux-kernel+bounces-93099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8247872B0A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 00:28:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA3031C248AD
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 23:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0073212D77F;
	Tue,  5 Mar 2024 23:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mipPC2ae"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AF8012D201
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 23:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709681306; cv=none; b=Nw+mRV4HADmLYwoW0oFqMm2R6DmTMpk96wuJZ5Tko325jc3C00u2MZKP46TTOaRB7ArLcsV8MSucBsLgsqldqmHF6jS2tSVEXSp/cxIBgvctFNi1wqIMaH5fYqkpkLl+Pw+o5t/s9Fb7ZzgAjyNtU5atwepfsa+hiVX/AwPaT4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709681306; c=relaxed/simple;
	bh=27L4pOWFrwC1g57YyoUEfbh9+oQq5Vs01mlHipPt88w=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nHBbsx9aWXvznIbR4AG1cbIgBu/ammxrHAYUkl+CPO8rxQohUNbUpq5YBwUxF/VwAiS8wCRuYHnWYwHuTHkOLzVHf76m9Psb87K9v0hx0rxDCoC35kS/9uiiOrrzsGhFaLfzgYhkOisveGPS4jiNLEQwwQWiaPwBFWHX4du02kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mipPC2ae; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4BF5C433C7;
	Tue,  5 Mar 2024 23:28:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709681305;
	bh=27L4pOWFrwC1g57YyoUEfbh9+oQq5Vs01mlHipPt88w=;
	h=Date:From:To:Subject:References:In-Reply-To:From;
	b=mipPC2aeXfg/7ogYaUxPffwb4ewFUdxkoopES4d2yjjGNWMDBUD9/977cG1YZ5YYp
	 FSoYNZs41dCN82TsO1nsFEJIYttizB+LEXOIxilmMZze8Ll+7h3UcHVgZZWovJ/DHE
	 fqbmo3C/Z0Dx6RqayCFs4RPzr60E4y0FRFY00aGblAIX+5OzChpMYEggRpmWIRszq+
	 Wc8B9b0mw5MFe9INHJqtxZitApnz+ZERmvY7utXw4CG4PP739LJRGauLT7VvdPK0+q
	 lAiL4e/wAmDeJIDECZ/EgV171VN4drAwHG7FJncSebVbyXa4OV34SFXzVKNXwMGnl0
	 fJwbdLBkfbT6w==
Date: Tue, 5 Mar 2024 15:28:24 -0800
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH v2] f2fs: add a proc entry show disk map
Message-ID: <ZeeqmMT8sdPyPKi0@google.com>
References: <20240305001709.637722-1-jaegeuk@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240305001709.637722-1-jaegeuk@kernel.org>

This patch adds the disk map of block address ranges configured by multiple
partitions.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---

 from v1:
  - add more layout information

 fs/f2fs/sysfs.c | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index 10f308b3128f..a568ce96cf56 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -1492,6 +1492,50 @@ static int __maybe_unused discard_plist_seq_show(struct seq_file *seq,
 	return 0;
 }
 
+static int __maybe_unused disk_map_seq_show(struct seq_file *seq,
+						void *offset)
+{
+	struct super_block *sb = seq->private;
+	struct f2fs_sb_info *sbi = F2FS_SB(sb);
+	int i;
+
+	seq_printf(seq, "Address Layout   : %5luB Block address (# of Segments)\n",
+					F2FS_BLKSIZE);
+	seq_printf(seq, " SB            : %12s\n", "0/1024B");
+	seq_printf(seq, " seg0_blkaddr  : 0x%010x\n", SEG0_BLKADDR(sbi));
+	seq_printf(seq, " Checkpoint    : 0x%010x (%10d)\n",
+			le32_to_cpu(F2FS_RAW_SUPER(sbi)->cp_blkaddr), 2);
+	seq_printf(seq, " SIT           : 0x%010x (%10d)\n",
+			SIT_I(sbi)->sit_base_addr,
+			le32_to_cpu(F2FS_RAW_SUPER(sbi)->segment_count_sit));
+	seq_printf(seq, " NAT           : 0x%010x (%10d)\n",
+			NM_I(sbi)->nat_blkaddr,
+			le32_to_cpu(F2FS_RAW_SUPER(sbi)->segment_count_nat));
+	seq_printf(seq, " SSA           : 0x%010x (%10d)\n",
+			SM_I(sbi)->ssa_blkaddr,
+			le32_to_cpu(F2FS_RAW_SUPER(sbi)->segment_count_ssa));
+	seq_printf(seq, " Main          : 0x%010x (%10d)\n",
+			SM_I(sbi)->main_blkaddr,
+			le32_to_cpu(F2FS_RAW_SUPER(sbi)->segment_count_main));
+	seq_printf(seq, " # of Sections : %12d\n",
+			le32_to_cpu(F2FS_RAW_SUPER(sbi)->section_count));
+	seq_printf(seq, " Segs/Sections : %12d\n",
+			SEGS_PER_SEC(sbi));
+	seq_printf(seq, " Section size  : %12d MB\n",
+			SEGS_PER_SEC(sbi) << 1);
+
+	if (!f2fs_is_multi_device(sbi))
+		return 0;
+
+	seq_puts(seq, "\nDisk Map for multi devices:\n");
+	for (i = 0; i < sbi->s_ndevs; i++)
+		seq_printf(seq, "Disk:%2d (zoned=%d): 0x%010x - 0x%010x on %s\n",
+			i, bdev_is_zoned(FDEV(i).bdev),
+			FDEV(i).start_blk, FDEV(i).end_blk,
+			FDEV(i).path);
+	return 0;
+}
+
 int __init f2fs_init_sysfs(void)
 {
 	int ret;
@@ -1573,6 +1617,8 @@ int f2fs_register_sysfs(struct f2fs_sb_info *sbi)
 				victim_bits_seq_show, sb);
 	proc_create_single_data("discard_plist_info", 0444, sbi->s_proc,
 				discard_plist_seq_show, sb);
+	proc_create_single_data("disk_map", 0444, sbi->s_proc,
+				disk_map_seq_show, sb);
 	return 0;
 put_feature_list_kobj:
 	kobject_put(&sbi->s_feature_list_kobj);
-- 
2.44.0.278.ge034bb2e1d-goog


