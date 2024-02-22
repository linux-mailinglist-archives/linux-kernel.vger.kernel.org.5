Return-Path: <linux-kernel+bounces-76498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD14585F7F1
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 13:19:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B21028891C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 12:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58796612F6;
	Thu, 22 Feb 2024 12:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X20vHx/M"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B54612E1
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 12:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708604343; cv=none; b=QE+9h+bI8R58VBXw4DZpg7XKOcagxHatJTQ0YiB33aE38gG3ZpjuJVb+RXKyjxvrO2SVE/2sbnRkyEf6tvrBBA7W9myj2c0dnuLYbqv7DCqP+YIhoP1YDs3byr8SXiRNGW7gN/9RrJJ02KhuGDHHFeRyDSna0bMrwU8sHMWmJ7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708604343; c=relaxed/simple;
	bh=UBGAWY7QBAf6w4r+D7RUjGAJRqIj79Menb0OJmr4XXg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DN6zBxqPn9USfwe54MVHpEfNhXYSYyerI6F2SKrKSgSGuE4fnKxf0iSBzbS8OA19s5HCvjQ8Zaq4pvHkNY+SnwUvyR1QoFe7h7yH5RwdoNhlynkaY8tbwsVJZdFTaQRERDg2GX+y5MK7KnA02SS561R9i8pwup4emb+jcDzVLnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X20vHx/M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC1AEC43390;
	Thu, 22 Feb 2024 12:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708604343;
	bh=UBGAWY7QBAf6w4r+D7RUjGAJRqIj79Menb0OJmr4XXg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=X20vHx/MBMMZ9nbQR/BWo7scTGZoMiocWVi8XVG4+OvGHF7/2fY+wuifhcYWYiVEB
	 ZhuGf9JD6G6eOp1Vn9Eq8eUOW5WYx5c47nQFFqCcID+CZAziyakODU/e5Je+xdtrBb
	 t6gQTyKPqiH/5Tw5ZbfBZzX8qLeNI/eZC7TZ62EeOSCpO4xYY97Ee28kMJEWxnn++w
	 2TJog2bmir0d4VzHaq2oKeAACSLr09o0krBNqJH+gc0MUPzYu+JdglCZRuACek91hn
	 XeLiUZhX+J6EbunerVYYgqWkdnCpH+uV8IT59d3MOalDNjtcm4DuOcX2y6oI4J3xXa
	 vgMovY33b0kVg==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>
Subject: [PATCH 4/4] f2fs: introduce FAULT_NO_SEGMENT
Date: Thu, 22 Feb 2024 20:18:51 +0800
Message-Id: <20240222121851.883141-4-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240222121851.883141-1-chao@kernel.org>
References: <20240222121851.883141-1-chao@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use it to simulate no free segment case during block allocation.

Signed-off-by: Chao Yu <chao@kernel.org>
---
 Documentation/ABI/testing/sysfs-fs-f2fs | 1 +
 Documentation/filesystems/f2fs.rst      | 1 +
 fs/f2fs/f2fs.h                          | 1 +
 fs/f2fs/segment.c                       | 5 +++++
 fs/f2fs/super.c                         | 1 +
 5 files changed, 9 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
index 15044d7d4977..96b54259a02a 100644
--- a/Documentation/ABI/testing/sysfs-fs-f2fs
+++ b/Documentation/ABI/testing/sysfs-fs-f2fs
@@ -718,6 +718,7 @@ Description:	Support configuring fault injection type, should be
 		FAULT_LOCK_OP                    0x000020000
 		FAULT_BLKADDR_VALIDITY           0x000040000
 		FAULT_BLKADDR_CONSISTENCE        0x000080000
+		FAULT_NO_SEGMENT                 0x000100000
 		===========================      ===========
 
 What:		/sys/fs/f2fs/<disk>/discard_io_aware_gran
diff --git a/Documentation/filesystems/f2fs.rst b/Documentation/filesystems/f2fs.rst
index 1b3b73aa3ab9..bc074b8eedbb 100644
--- a/Documentation/filesystems/f2fs.rst
+++ b/Documentation/filesystems/f2fs.rst
@@ -205,6 +205,7 @@ fault_type=%d		 Support configuring fault injection type, should be
 			 FAULT_LOCK_OP                    0x000020000
 			 FAULT_BLKADDR_VALIDITY           0x000040000
 			 FAULT_BLKADDR_CONSISTENCE        0x000080000
+			 FAULT_NO_SEGMENT                 0x000100000
 			 ===========================      ===========
 mode=%s			 Control block allocation mode which supports "adaptive"
 			 and "lfs". In "lfs" mode, there should be no random
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 6390c3d551cb..fdc9a4dc981d 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -62,6 +62,7 @@ enum {
 	FAULT_LOCK_OP,
 	FAULT_BLKADDR_VALIDITY,
 	FAULT_BLKADDR_CONSISTENCE,
+	FAULT_NO_SEGMENT,
 	FAULT_MAX,
 };
 
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 71f523431e87..8ad88d5d4d1d 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -2653,6 +2653,11 @@ static int get_new_segment(struct f2fs_sb_info *sbi,
 
 	spin_lock(&free_i->segmap_lock);
 
+	if (time_to_inject(sbi, FAULT_NO_SEGMENT)) {
+		ret = -ENOSPC;
+		goto out_unlock;
+	}
+
 	if (!new_sec && ((*newseg + 1) % SEGS_PER_SEC(sbi))) {
 		segno = find_next_zero_bit(free_i->free_segmap,
 			GET_SEG_FROM_SEC(sbi, hint + 1), *newseg + 1);
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index bb056700b459..dc4fb9a661f2 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -63,6 +63,7 @@ const char *f2fs_fault_name[FAULT_MAX] = {
 	[FAULT_LOCK_OP]			= "lock_op",
 	[FAULT_BLKADDR_VALIDITY]	= "invalid blkaddr",
 	[FAULT_BLKADDR_CONSISTENCE]	= "inconsistent blkaddr",
+	[FAULT_NO_SEGMENT]		= "no free segment",
 };
 
 void f2fs_build_fault_attr(struct f2fs_sb_info *sbi, unsigned int rate,
-- 
2.40.1


