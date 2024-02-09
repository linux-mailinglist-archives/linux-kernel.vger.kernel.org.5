Return-Path: <linux-kernel+bounces-58943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0CBF84EEF4
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 03:43:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D2BD28CEE4
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 02:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57536184D;
	Fri,  9 Feb 2024 02:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HUXtGzl1"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C93715CB
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 02:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707446576; cv=none; b=p+eiGRr4rfXqA+GRg/yqMBdJorDJATuxKITLW4bO0r0Ec0ZSzvy9UgDZibPzT1av+ffqtlhxgX5jCHZ7ipQwA9bsiM0qPNNIPz/NbFvb5EgeaXe1C8/Ol3se0dDF3c7kdm8iPjeww9w31OtpUGbMrylCbntHPg6zzRiQ4MWmGEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707446576; c=relaxed/simple;
	bh=GGZXavwH2wnOBhvMLP1tok9fBEDPJbr/LjEdpsP726Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uPnoaaLkF1hROruE+SSpVmxUQj5k2fzdKmMzJXIppbe9pXtXev2rRPJ6GUAGJr/wUwvg39eYpDHhF+lMMeI5YIqYcisPfQAjmWTFYAFhywnMtPaRh/jpPLXHfA6rx9oXFIpYo544K8iO1nZsWjJXUaAR3byKSE/V5S/YXdNoqSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HUXtGzl1; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6e062fa6e00so312198b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Feb 2024 18:42:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707446574; x=1708051374; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vBDyj3Iv7QB4U+Y1PAOul+HNZzqp+6gSDSC9V0g8NJY=;
        b=HUXtGzl1ZyUuCdioXSzKL3RneHkNTxXjPOPXmBeupb06MQ97jUHAV1QTlNBq7XH1Cy
         MPjVfjsrZbsvqlAp/RHVGYaZ6j+SPAiY38W0MC8aHIrqWDXEMG6Nls1dGSP0NDhqVYOe
         BbnwkgpKA1MKBQbr0sq2zLYayCaz2aNO3NZqq32nzM6ERJpVSQxWSmoYki/tAkjSGuid
         r7dxJWpDcEmO9Qoygu7gavQwywrIxBbyRJWt/8eBs0prF+N7ZOpMdRmFe/sbiL9yCC5Y
         N1a0rG4Sa+PPgeBEdGVltbfrFZxe1Hoj3YBh5RioZmARD0U5zqvISEn2o1+/LZO5hmPU
         ikRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707446574; x=1708051374;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vBDyj3Iv7QB4U+Y1PAOul+HNZzqp+6gSDSC9V0g8NJY=;
        b=cL+IofOWfTFE3qqDSWi1JzHEnDO0KSYrtdt/9MTwEVsv4a6QdnnbffoHe94tBhPYLL
         TH4hy4Fa4sTuj13A5JsV2zcZIpG4ET3xf9jglUMf6d79CHtCclF42jNZJbHFEzj8sekC
         0Q70dIlcdqr/qsc39AZsnXAtjGEO6q0pFj1uiHGe8zt2K+GnPKTsGRxyGLLJE4FLcaX7
         p0oTNNbMeSNxXGFr5rgHP4lsJYEnlZWbDjJyGX/3o6KGXoaXGHWvwEmMZQQ0MlQdabnk
         gjiNw535R2Tq/6gnxeablLUfNXn3Y/O/uLSx6PbzWMp4CqfWhX+msl7ARsyjXgB9J85u
         PQrg==
X-Gm-Message-State: AOJu0YwrwgjKC9o+Sl4k0SzoByvuKkAFaeDWMHxvvRS3Fs1bUMOdYVGp
	zPjbAWHC8Q9LZkiCOCE2RSCZ9pVyyN4nZj82qtIZg9rAlNibEFM2V40r/Wv2
X-Google-Smtp-Source: AGHT+IHrDj9IlQkFHQtCcC/zy9KM2UXDK/Y87EJn1nmRW6+FzpCS2mU3H7Ljz+0IN9fVd8avLcqKbw==
X-Received: by 2002:a05:6a00:10c5:b0:6db:d040:4d05 with SMTP id d5-20020a056a0010c500b006dbd0404d05mr448678pfu.22.1707446574237;
        Thu, 08 Feb 2024 18:42:54 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV+VsKHdVQvMC/78ocjiVjk/KLdMxA8f6hwUqQ/IjHhCJmRQlNHHD/WEV0r/2pERktgn2HAl/iFkpXo5P4jTEOGqpsvPqznpjb22+NhV8pjuWU6lpht6/oc1V5iKPpxgUXixjq2ls6VbbIHmE4YXzVjRbyMBs1648Sa5rv5Hf7WAUtEwQ==
Received: from daehojeong-desktop.mtv.corp.google.com ([2620:0:1000:8411:20e:63ed:be25:710f])
        by smtp.gmail.com with ESMTPSA id t28-20020a62d15c000000b006d9a7a48bbesm521505pfl.116.2024.02.08.18.42.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 18:42:53 -0800 (PST)
From: Daeho Jeong <daeho43@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	kernel-team@android.com
Cc: Daeho Jeong <daehojeong@google.com>,
	Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH v2 1/2] f2fs: separate f2fs_gc_range() to use GC for a range
Date: Thu,  8 Feb 2024 18:42:25 -0800
Message-ID: <20240209024227.66741-1-daeho43@gmail.com>
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


