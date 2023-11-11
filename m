Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDA077E87DE
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Nov 2023 02:44:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345339AbjKKBo5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 20:44:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjKKBoy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 20:44:54 -0500
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBF394496
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 17:44:51 -0800 (PST)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-1cc2786a8ebso29375565ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 17:44:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699667091; x=1700271891;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DSKrAPEQX8JBY5dcPA6aCmIIR2K68WR/P/3sBLwglFU=;
        b=LbRv9rpYPtiMZu9s50aWxmYr+lquNRS9cifSAJxb7nW1Es50ybFIAR24U8QkZRgQ6p
         rdALQMKNtPC+bk5g2OuO96fTcQnpmR1kroNFXUEs8v4wvjj3iiHJavmnmDy4mak3Go70
         BKEPpsbQ3vSzHjvEYrJRPsFQzkSPZCUaRK2eMpiWy0qSQlyulWf7IqVYVWF9lCEoBZpb
         gzMq2FvYHGhW2z/40S6bOyPV2VPpHgq4G17Jnn+wYlksGiddNpX2RzAaqFSOMhAST8Z6
         nh7hUN6sXciPfiZkMH9D27Itosd4cLoQyMlpAQVtMl2BXO+LApvkxt9gAhFt7hmoR/d5
         t8dA==
X-Gm-Message-State: AOJu0YwzJ8grE5JEgrjnzq1HIb6DT1hPIzzuOj+aIB5iZN9mhKaJyIQd
        ToyCTZKGI8HoOzMTLI1hLgX/oNEI+ORXp+8jFRl9PKKvYgWh/gQ=
X-Google-Smtp-Source: AGHT+IHF7sNNJYHiLxgR3CX22ONBmEoxR6PfYWTyLpKY7gdVn9zz+BQvt5745ORrzRHJrCF9ScqOK+yd03pMYkR18w2wrYD0vL2s
MIME-Version: 1.0
X-Received: by 2002:a17:903:130d:b0:1ce:701:99c2 with SMTP id
 iy13-20020a170903130d00b001ce070199c2mr228997plb.7.1699667091399; Fri, 10 Nov
 2023 17:44:51 -0800 (PST)
Date:   Fri, 10 Nov 2023 17:44:51 -0800
In-Reply-To: <0000000000001959d30609bb5d94@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000382a850609d69558@google.com>
Subject: Re: [syzbot] [PATCH] test 305230142ae0
From:   syzbot <syzbot+4d81015bc10889fd12ea@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
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
index 401ea09ae4b8..d2b6e4d18c89 100644
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
diff --git a/fs/btrfs/qgroup.h b/fs/btrfs/qgroup.h
index 855a4f978761..05b4b8dd0fcb 100644
--- a/fs/btrfs/qgroup.h
+++ b/fs/btrfs/qgroup.h
@@ -425,4 +425,6 @@ bool btrfs_check_quota_leak(struct btrfs_fs_info *fs_info);
 int btrfs_record_squota_delta(struct btrfs_fs_info *fs_info,
 			      struct btrfs_squota_delta *delta);
 
+static struct btrfs_qgroup *find_qgroup_rb(struct btrfs_fs_info *fs_info,
+                                            u64 qgroupid);
 #endif
-- 
2.25.1

