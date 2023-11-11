Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 634947E88FC
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Nov 2023 04:48:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbjKKDkY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 22:40:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjKKDkX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 22:40:23 -0500
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 681CB2D7F
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 19:40:20 -0800 (PST)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-5bddc607b45so2953088a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 19:40:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699674020; x=1700278820;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1K4WiiDJprvX5jtXJczsWfdelDd4m2WNLPMiaBmmZIM=;
        b=tPISw6Tip2kjyuGa2nQ9sWx9KMiyboeX0quqpT5WJBLlE/qP8GTB8vCiaAFo5sme5l
         EwS9N7qNTRN3EAwjtGNwI6RX3N+YDnQArZWM0w3JldZDyMC9CL392lKdqWWAxyHT+D7e
         cLXUQAJlhIAyALG2QPDdd14tnc3gX89cFXYUekKsTbDK6Pb8ZPQujUIYyTcxeKGoYdTh
         YJuleN7APbbGenY6Ru2Y5ItdJ1Qi7rWtaQmmbTWPqhXy18RV2IufnHJ/I7i5ax2VKTJ+
         WeQJJn4CWBcVFt+QOtEb6sAjeUObmHDqNO2oE2B+Ibxvw7k0uyX1gdVk4JDCqw9y+gDh
         Amlw==
X-Gm-Message-State: AOJu0YzTuF4ayUHU9JN7B/OAcs9qJMUnKWkGFpYQS86t8aXDFeza2aLs
        mUMRFRN4lDC2YtXPW8L3R6TW8UYPObo0Und/n5whvsVZ2RWpL8M=
X-Google-Smtp-Source: AGHT+IH5U+zojziEAe9p93Epig8Mp5iEdaxFX3zi+Emg8vM3MIspJk7yPMPMZCm5axNhAMYrmnUK8vx9WAsupS5B5oRi8QlRhRgy
MIME-Version: 1.0
X-Received: by 2002:a05:6a02:521:b0:5bd:d7de:a5f with SMTP id
 bx33-20020a056a02052100b005bdd7de0a5fmr351245pgb.0.1699674019998; Fri, 10 Nov
 2023 19:40:19 -0800 (PST)
Date:   Fri, 10 Nov 2023 19:40:19 -0800
In-Reply-To: <0000000000001959d30609bb5d94@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003234d30609d83244@google.com>
Subject: Re: [syzbot] [PATCH] test 305230142ae0
From:   syzbot <syzbot+4d81015bc10889fd12ea@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
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
index 401ea09ae4b8..3bc6abbd64db 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -4931,7 +4931,8 @@ int btrfs_get_free_objectid(struct btrfs_root *root, u64 *objectid)
 		goto out;
 	}
 
-	*objectid = root->free_objectid++;
+	while (exist_qgroup_rb(root->fs_info, root->free_objectid++));
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
index 855a4f978761..f2a95fe165f0 100644
--- a/fs/btrfs/qgroup.h
+++ b/fs/btrfs/qgroup.h
@@ -425,4 +425,11 @@ bool btrfs_check_quota_leak(struct btrfs_fs_info *fs_info);
 int btrfs_record_squota_delta(struct btrfs_fs_info *fs_info,
 			      struct btrfs_squota_delta *delta);
 
+struct btrfs_qgroup *find_qgroup_rb(struct btrfs_fs_info *fs_info,
+                                            u64 qgroupid);
+
+static bool exist_qgroup_rb(struct btrfs_fs_info *fs_info, u64 qgroupid)
+{
+	return find_qgroup_rb(fs_info, qgroupid);
+}
 #endif
-- 
2.25.1

