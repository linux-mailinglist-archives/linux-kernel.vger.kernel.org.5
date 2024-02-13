Return-Path: <linux-kernel+bounces-63998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E120E853898
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 18:38:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99F512828E9
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 17:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AD5A604B2;
	Tue, 13 Feb 2024 17:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gcp2NCuA"
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CA5760270
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 17:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707845898; cv=none; b=Irp0mNrGaXFnXmG9Y57ykuQNNQKEue75puEFBK9fnqkHcXwMHGuFKkeGfprDYMsI9hysFEesP7RYWwEEIjn/LEVD98tLoCJrYP8QJN0q4+2tovRwt7o22WYaQFWU2k/IO5mGE/xeyFGsYfEgF7PuMsmvzVLx+x9Gp5x/BCNVEok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707845898; c=relaxed/simple;
	bh=GGZXavwH2wnOBhvMLP1tok9fBEDPJbr/LjEdpsP726Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Khl/8PqfkZ+YsBz5b3BLFUrTZBJVRgVDskDd5D6KmbyfVs6gvuqa6wMRgc6Bowk+KNzXNGWFJHD3C8xAM1a2oRLxDW7IgzMFhssQrGWoMcORHd78YjHgihhCTlqhf9wnO7DTHd0TkaflJ0KQ9bEPfrMIf0JDrZtRgUi02o2zaR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gcp2NCuA; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-290d59df3f0so3332696a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 09:38:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707845896; x=1708450696; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vBDyj3Iv7QB4U+Y1PAOul+HNZzqp+6gSDSC9V0g8NJY=;
        b=gcp2NCuAVYhMiVB5R6iRHLEx4mwxSl3CpPOyczh71EGU6SWbCqEYIyF5I3K2i8DRmv
         WQnJdM/mbkW6HSJlHqlryr9BRsIRxXFdY8NsiF+Wb1EPht/f4mJqpuravw3OTcj0PQVz
         A9CsweYq0qULvVPPVA7ZoR0BoQ1e4314R0lDGXmWwXtd4nataMwUqrfaQCyFA3JMXkC5
         udHvH8u9n0ibacQnr+XbOuzuxkBMl/GIZq+rYDuwdgX7u7g6y0JOdH9u6VTiCE/vbla1
         qZ6blw6803XMKQZulWimyoGpNMj5Ep9qjRrKBo4/GZ9Hz6tEg4g3COjZO+1VM/XFWT/O
         xSGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707845896; x=1708450696;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vBDyj3Iv7QB4U+Y1PAOul+HNZzqp+6gSDSC9V0g8NJY=;
        b=GJRqIrsd6ZxxnDZIVFvaVppIvr3xZ6SpR2HoJyklBiVnSonXP7hXpPJX6azN6XYjED
         pc/P5AA/umkNUzAJLqM/ydxc6J6+wUfm/TVNkCppQIMNgkI3+D1YJOwdxcUUKFHN64Ht
         G2SbxJCO9phTeskwzEwf26NsGcd4u5IdyCiJ6J2qGjkbSVGqZOqGzif5berQiE32Jwyf
         yVm+6COA67q/1p+himz6elF125GUsLfd4rQnhZufbUMl/haGPWdEkFAvaN6gM4H3nPA1
         /3js6JsHVI17ODZ8bdYP/vg8Z/HaobN1MP8JAii7eqE4nObVfZIv+PstFZcxBQJiYUCF
         FpAg==
X-Gm-Message-State: AOJu0Yzjrtt+D/bu2mtWU3HGLoJlC9Pviu7UzMLniCJaZFy3IYSopw6o
	AmZhrf2Fyi/drtCJzLUIDair3EsiIMfB2CLDpgeTyEz/caF/w5IfkbN0+Ogh
X-Google-Smtp-Source: AGHT+IFW3W85BONrKtua73JEpUlNUnM0AJHEdGsV1qPTe08O6+wHY1sVAFgjb3rFc25HUMnNh6gW6g==
X-Received: by 2002:a17:90b:1881:b0:297:2748:3a0b with SMTP id mn1-20020a17090b188100b0029727483a0bmr144667pjb.44.1707845896405;
        Tue, 13 Feb 2024 09:38:16 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX6V7Ro+C296FFuXGiC612aVz9WWS1Ry0aaZwCBOUaZLpQuhQiuvzDwAuYlSpUFkwY/RCLyJzCk1kegA0Z6NQ5PCI+3pToXjgETVYRLhxy0yE2sESy7xK0duaSBHRE050nW61lCUD3u/iX+NQ0JDQH+wiBxf84x30ioBGPtbEjFhSNrEg==
Received: from daehojeong-desktop.mtv.corp.google.com ([2620:0:1000:8411:1deb:64bb:dfd3:ad56])
        by smtp.gmail.com with ESMTPSA id a18-20020a17090acb9200b00298cc2b7e94sm198137pju.34.2024.02.13.09.38.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 09:38:16 -0800 (PST)
From: Daeho Jeong <daeho43@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	kernel-team@android.com
Cc: Daeho Jeong <daehojeong@google.com>,
	Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH v3 1/2] f2fs: separate f2fs_gc_range() to use GC for a range
Date: Tue, 13 Feb 2024 09:38:11 -0800
Message-ID: <20240213173812.1432663-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
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
index 8a9cdc5a72c5..a089a938355b 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -1961,10 +1961,34 @@ void f2fs_build_gc_manager(struct f2fs_sb_info *sbi)
 	init_atgc_management(sbi);
 }
 
+static int f2fs_gc_range(struct f2fs_sb_info *sbi,
+		unsigned int start_seg, unsigned int end_seg, bool dry_run)
+{
+	unsigned int segno;
+
+	for (segno = start_seg; segno <= end_seg; segno += SEGS_PER_SEC(sbi)) {
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
@@ -1990,25 +2014,8 @@ static int free_segment_range(struct f2fs_sb_info *sbi,
 		f2fs_allocate_segment_for_resize(sbi, type, start, end);
 
 	/* do GC to move out valid blocks in the range */
-	for (segno = start; segno <= end; segno += SEGS_PER_SEC(sbi)) {
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
2.43.0.687.g38aa6559b0-goog


