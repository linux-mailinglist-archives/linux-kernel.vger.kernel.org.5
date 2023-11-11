Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 661D37E8951
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Nov 2023 06:07:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230297AbjKKFEf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Nov 2023 00:04:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbjKKFEc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Nov 2023 00:04:32 -0500
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D91553C15
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 21:04:29 -0800 (PST)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-28035cf4306so3443316a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 21:04:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699679069; x=1700283869;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cppaf70FMfubnxWjlk2mRgI1rT/pt4p4L8LawsuULfg=;
        b=OJ7ShD1AGQylei13OepEfbzyMkvypzSztN5y7UruBI49z8TGdLNv+ogoBsAqgbGBBw
         jGgBVAVVI/OSiEJ9yfqftYPzO7/MkyMvmtywbIRolqJp444HG+76krnfnAgrrIBEoi0w
         GpW4o89eYTYlKSObtedoFUSS7Kud9+hHHmZTT/EHHq+tp6rm/3QSSp4YeS+1ayUGIMvL
         x1t471xV16PSjVHkjp35F+kj7IuCX4oUnnjv/L0lmfI4A7yVUJ1veqmXlwnl0KsfUseE
         A0Vb+78Z53BYFZuzsR8reyGHQBqvfevwl/aFZnvJ6IJN1VO47zPeeGo6l351uQxjCUbb
         HpDA==
X-Gm-Message-State: AOJu0YwMdfP/GVHw3GKc6YKkz/lq4dcQtlZL8sRYV+A5QHBb6+jFVpGr
        IOya1nQBW+iCiZW2dR0Wqon6OXL/2nZEX+5lSc8laHNGiay2cvY=
X-Google-Smtp-Source: AGHT+IEfzE8EyrzI3WKUrjS/b5/giazQ9EKDnwZn6lzDUHBgfGZVHp1ol0QqpaRW3iGpV9L+jse3A6iRYu0inwF7Rfe4y9zDhVDM
MIME-Version: 1.0
X-Received: by 2002:a17:903:4285:b0:1cc:166f:91c8 with SMTP id
 ju5-20020a170903428500b001cc166f91c8mr280800plb.1.1699679069510; Fri, 10 Nov
 2023 21:04:29 -0800 (PST)
Date:   Fri, 10 Nov 2023 21:04:29 -0800
In-Reply-To: <0000000000001959d30609bb5d94@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002ba4c10609d95fcf@google.com>
Subject: Re: [syzbot] [PATCH] test 305230142ae0
From:   syzbot <syzbot+4d81015bc10889fd12ea@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: [PATCH] test 305230142ae0
Author: eadavis@qq.com

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 305230142ae0

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 401ea09ae4b8..97050a3edc32 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -4931,7 +4931,8 @@ int btrfs_get_free_objectid(struct btrfs_root *root, u64 *objectid)
 		goto out;
 	}
 
-	*objectid = root->free_objectid++;
+	while (find_qgroup_rb(root->fs_info, root->free_objectid++));
+	*objectid = root->free_objectid;
 	ret = 0;
 out:
 	mutex_unlock(&root->objectid_mutex);
diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index edb84cc03237..3705e7d57057 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -171,7 +171,7 @@ qgroup_rescan_init(struct btrfs_fs_info *fs_info, u64 progress_objectid,
 static void qgroup_rescan_zero_tracking(struct btrfs_fs_info *fs_info);
 
 /* must be called with qgroup_ioctl_lock held */
-static struct btrfs_qgroup *find_qgroup_rb(struct btrfs_fs_info *fs_info,
+struct btrfs_qgroup *find_qgroup_rb(struct btrfs_fs_info *fs_info,
 					   u64 qgroupid)
 {
 	struct rb_node *n = fs_info->qgroup_tree.rb_node;
diff --git a/fs/btrfs/qgroup.h b/fs/btrfs/qgroup.h
index 855a4f978761..96c6aa31ca91 100644
--- a/fs/btrfs/qgroup.h
+++ b/fs/btrfs/qgroup.h
@@ -425,4 +425,6 @@ bool btrfs_check_quota_leak(struct btrfs_fs_info *fs_info);
 int btrfs_record_squota_delta(struct btrfs_fs_info *fs_info,
 			      struct btrfs_squota_delta *delta);
 
+struct btrfs_qgroup *find_qgroup_rb(struct btrfs_fs_info *fs_info,
+                                            u64 qgroupid);
 #endif
-- 
2.25.1

