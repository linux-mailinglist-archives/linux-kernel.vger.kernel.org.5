Return-Path: <linux-kernel+bounces-55691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B55C884C015
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 23:33:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A31B288BF7
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 22:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 802601C2A6;
	Tue,  6 Feb 2024 22:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dAbjJP2F"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68FA51C29C
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 22:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707258786; cv=none; b=tDBNYJGxXeP1byklM1S2b8T1c0XEAjBAFISBQkl40oFOrKUgYDpheLS0K9h0t0HqxN7E4LkxxPVbQl3z+i/oBg5W+5nWSJRMk1zSMLPy5Ztdbr+XpXadelizEDSy83VsxOmMI1C0QL6iD9CSBleq0m2VyYs6zL+g9JaA8XJU/C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707258786; c=relaxed/simple;
	bh=sukycBZ4DQwhrKijFq94qphTf/v5PohQw/3KG49HqcA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=g23cIlUHkelbzxPZm1eVmQJR8dIqUXgxJ7XqZPR50QLGzO51XYDI4R019vgQu+ImaKlZJm1n2LSIe19J4TqBJu7eqg14/9Z0v9ob8xPjzdkx8ud7/gMcykN8Jk0uv4CNwttGOCUuf5iu4PvuBGO/vnAVGwDXSR6I3kynRTVs6pI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dAbjJP2F; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-296c2b74448so1083649a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 14:33:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707258784; x=1707863584; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=00pmZ6kibv+G4s9omY1rvgDUEdmKCy0BpQNbUzvHf2k=;
        b=dAbjJP2FjvUbWZ5/xlj6zKL4uz+PsmKUwIhiDyxC8zgL9JMA1+U7gytU4oTc1LW60H
         75IAexDRyQmRjVTQEbKyTvV3fjncv+fedDJMvePXHo1CLzl1m75VjFrNn7nch+xeNFcU
         OCM6K17P5yuz56w5GZUptlCpY+ZysHnw8kGY4uOnWJY9IA9LbLww40QXPH4cDBHmLf3F
         X26/TwEc+fGgy422shTBaAmTzY2G0Ox8qjABs7V8cy7PUk2I7eieRuNMSe29EHIYRjQ6
         IniX0JEdhDGIXOuQLDaiMjXXZ7o4cws4hG8OrHCzLepS5X0qC26akGOjqES8btFKRFWL
         xzOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707258784; x=1707863584;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=00pmZ6kibv+G4s9omY1rvgDUEdmKCy0BpQNbUzvHf2k=;
        b=T8RL2SpfpnIJwTI1SWCibAv64Ly3qVe+OhZyXq/XmGtbea2i4oI48tBtOi3aJboFP8
         Dfsp/A3OZ0sTNlvmXSg3Jxr+viqp8TUwiJH0KogzS6DXYD+kNJq85/l1/CakDfDHrMWh
         w+eHwzsjafmHPDCfkS6zsLqugeVoL+KBTtqh9O0NBjIaUIFzUgUIE9YpaJVK1HHB34VB
         Bx4MBciCMUSNBzfICq/qC6pQvFNwykBcgrpn6bZvLaofpAdYehiu/7uakbYwi2AQvosA
         u1NQ32ib66mdFLoo8oI+M44TukxL3wKzGYNM9KKU1PNBmkrmDhysKbkL34xXefF2+wCb
         l3rQ==
X-Gm-Message-State: AOJu0YzKr5Uo59d1KcfymziiXplvmHFIKwW/MyGz7tarNqkuvH564pUY
	i8Cy3be8ficRfqWvFsCKF/mRyKod6bDPdAnIHGmS6f3jQYuOFffGeHNWKRSU
X-Google-Smtp-Source: AGHT+IGgc/izjSH8pQnpq08ELcEm7vCo3Fyc8MzvjLN09UD4s8l+Wk5PMEV/tTi7YFLNc5uHpVBzTA==
X-Received: by 2002:a17:90a:3189:b0:296:9bc8:c16d with SMTP id j9-20020a17090a318900b002969bc8c16dmr984401pjb.26.1707258784206;
        Tue, 06 Feb 2024 14:33:04 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXc6fivOnbrdtPy6PSV7U7G5sDFUskyySDlpl9XItR4RSmzcx7WMPVFXScv6FmQATmvQ9oKEViDUfNAso87u1Z0mEqh74yLewWSU9k55Kdg4ukOvCfb2h7wDftWZXIUJ2u2PHzIwashMdbsNPBlEmCqnlDUUc4acxza8JQoQVtzXxOfsw==
Received: from daehojeong-desktop.mtv.corp.google.com ([2620:0:1000:8411:6e38:9e6f:4818:7d04])
        by smtp.gmail.com with ESMTPSA id n3-20020a170902dc8300b001d6f091ca04sm32371pld.13.2024.02.06.14.33.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 14:33:03 -0800 (PST)
From: Daeho Jeong <daeho43@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	kernel-team@android.com
Cc: Daeho Jeong <daehojeong@google.com>,
	Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 1/3] f2fs: separate f2fs_gc_range() to use GC for a range
Date: Tue,  6 Feb 2024 14:32:55 -0800
Message-ID: <20240206223257.3461359-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Daeho Jeong <daehojeong@google.com>

Make f2fs_gc_range() an extenal function to use it for GC for a range.

Signed-off-by: Daeho Jeong <daehojeong@google.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/gc.c | 49 ++++++++++++++++++++++++++++---------------------
 1 file changed, 28 insertions(+), 21 deletions(-)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index a079eebfb080..a46d5053f965 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -1983,10 +1983,34 @@ void f2fs_build_gc_manager(struct f2fs_sb_info *sbi)
 	init_atgc_management(sbi);
 }
 
+static int f2fs_gc_range(struct f2fs_sb_info *sbi,
+		unsigned int start_seg, unsigned int end_seg, bool dry_run)
+{
+	unsigned int segno;
+
+	for (segno = start_seg; segno <= end_seg; segno += sbi->segs_per_sec) {
+		struct gc_inode_list gc_list = {
+			.ilist = LIST_HEAD_INIT(gc_list.ilist),
+			.iroot = RADIX_TREE_INIT(gc_list.iroot, GFP_NOFS),
+		};
+
+		do_garbage_collect(sbi, segno, &gc_list, FG_GC, true);
+		put_gc_inode(&gc_list);
+
+		if (!dry_run && get_valid_blocks(sbi, segno, true))
+			return -EAGAIN;
+
+		if (fatal_signal_pending(current))
+			return -ERESTARTSYS;
+	}
+
+	return 0;
+}
+
 static int free_segment_range(struct f2fs_sb_info *sbi,
-				unsigned int secs, bool gc_only)
+				unsigned int secs, bool dry_run)
 {
-	unsigned int segno, next_inuse, start, end;
+	unsigned int next_inuse, start, end;
 	struct cp_control cpc = { CP_RESIZE, 0, 0, 0 };
 	int gc_mode, gc_type;
 	int err = 0;
@@ -2012,25 +2036,8 @@ static int free_segment_range(struct f2fs_sb_info *sbi,
 		f2fs_allocate_segment_for_resize(sbi, type, start, end);
 
 	/* do GC to move out valid blocks in the range */
-	for (segno = start; segno <= end; segno += sbi->segs_per_sec) {
-		struct gc_inode_list gc_list = {
-			.ilist = LIST_HEAD_INIT(gc_list.ilist),
-			.iroot = RADIX_TREE_INIT(gc_list.iroot, GFP_NOFS),
-		};
-
-		do_garbage_collect(sbi, segno, &gc_list, FG_GC, true);
-		put_gc_inode(&gc_list);
-
-		if (!gc_only && get_valid_blocks(sbi, segno, true)) {
-			err = -EAGAIN;
-			goto out;
-		}
-		if (fatal_signal_pending(current)) {
-			err = -ERESTARTSYS;
-			goto out;
-		}
-	}
-	if (gc_only)
+	err = f2fs_gc_range(sbi, start, end, dry_run);
+	if (err || dry_run)
 		goto out;
 
 	stat_inc_cp_call_count(sbi, TOTAL_CALL);
-- 
2.43.0.594.gd9cf4e227d-goog


