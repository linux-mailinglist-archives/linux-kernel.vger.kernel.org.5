Return-Path: <linux-kernel+bounces-91439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 234A987117F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 01:17:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B13D0281F60
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 00:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24C5E10E4;
	Tue,  5 Mar 2024 00:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rh16Qq+Q"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AB6F635
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 00:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709597833; cv=none; b=RL2vKgcYl8wfAVkN2F+B5iFz+GCf0F82k7zEBQDjqLadqx9wA1dhA6x49Oxt4FDeQYto7A/27Ay5nL75Beb9wg3+felMeTfe9k9jTcv4YepAjja+FeZaUbju9F2Qzuet8Q3bHjXCo0I448bFQhMPMZa6Ze+zRHRstC/X9Ldc2/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709597833; c=relaxed/simple;
	bh=X24FBJ7XKj3QZoWahGRowLBOY8gsvUFkYviO7f+NmHI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YV/5g+SXdd8AwOW8fmzPITDDpPOnUiZpSf7aqHm6qCfH5Tj9hAts5HJyJ/uOcGG78ZYHdSnujbvMhLwEVp/gKhC4JwXeV0mH/kabv69pez3vLvWww8WvJ6nF2igUf2tkiBzXqrjHwC13WiGbcbnIUfLNogOhrIAOnsJD5zLoTUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rh16Qq+Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5B3AC433C7;
	Tue,  5 Mar 2024 00:17:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709597832;
	bh=X24FBJ7XKj3QZoWahGRowLBOY8gsvUFkYviO7f+NmHI=;
	h=From:To:Cc:Subject:Date:From;
	b=Rh16Qq+QpyKJbfey5Su2Sp04RYCIIfFAzU9qcg7OcmOtsMQlXIYp4+bCZcghLTvo4
	 NSC9pvM1mWWGLX3fHP0wojBk/mDWI75mgUuuUliUSTpmKKdteUqaoxPeQRq1lhPA5t
	 AortwTaUJrHTrX61rm/yIYsKytn+RZrg/7dYGSWfzOyxdmTirsI0gZtb/wf4Yn3mME
	 s+haz5gntfbcqfebHLHDOLWE9jsHh3HkOyW4RulZNmD4K60obOP4/bwp2uKGgg7PWS
	 3V6h8DWWeXDBltPErP/DXxT19tDfZH20XpHustHpT+atpmcJaaImKIOT9apFC9PhB8
	 IpQT1MIEMD/QQ==
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: add a proc entry show disk map
Date: Mon,  4 Mar 2024 16:17:08 -0800
Message-ID: <20240305001709.637722-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds the disk map of block address ranges configured by multiple
partitions.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/sysfs.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index 10f308b3128f..e81af6adb85b 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -1492,6 +1492,27 @@ static int __maybe_unused discard_plist_seq_show(struct seq_file *seq,
 	return 0;
 }
 
+static int __maybe_unused disk_map_seq_show(struct seq_file *seq,
+						void *offset)
+{
+	struct super_block *sb = seq->private;
+	struct f2fs_sb_info *sbi = F2FS_SB(sb);
+	int i;
+
+	seq_puts(seq, "Disk Map for multi devices:\n");
+	if (!f2fs_is_multi_device(sbi))
+		return 0;
+
+	for (i = 0; i < sbi->s_ndevs; i++) {
+		seq_printf(seq, "%2d (zoned=%d): %20x - %20x",
+			i, bdev_is_zoned(FDEV(i).bdev),
+			FDEV(i).start_blk, FDEV(i).end_blk);
+		seq_putc(seq, '\n');
+	}
+	return 0;
+}
+
+
 int __init f2fs_init_sysfs(void)
 {
 	int ret;
@@ -1573,6 +1594,8 @@ int f2fs_register_sysfs(struct f2fs_sb_info *sbi)
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


