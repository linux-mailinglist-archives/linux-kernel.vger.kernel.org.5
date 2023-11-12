Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5B067E8E16
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Nov 2023 04:33:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbjKLDcn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Nov 2023 22:32:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbjKLDcl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Nov 2023 22:32:41 -0500
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45CE430EA
        for <linux-kernel@vger.kernel.org>; Sat, 11 Nov 2023 19:32:39 -0800 (PST)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2800e025bc7so3130515a91.2
        for <linux-kernel@vger.kernel.org>; Sat, 11 Nov 2023 19:32:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699759959; x=1700364759;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bMJhLHBS58QL5C2PYrP1dR+dZaF5b3ETKbm8tBfK3dk=;
        b=izXZhahhcQIkpWc1V6UAl+B6VGxFtp91poCeDsr9z5KUSH1KmF58ydskNtIRWqAxdh
         V7wsR19MUN5SztNxbruEqQ4WSKWBugye8dBsR1Cf+2vQeDQGoWkDsER2rpQ0InY76xF0
         5K2Vh7AwxP/tmRgaTt1vNb1ejjv8nUplvma1J39SCNo6N2u3k6GXmCu71DvDu5g5ikHA
         BlBsZBblEeCsFmz+XcBtkoZj3woOTd3lMR+lQluROJ6JNMPI2jehB/3a2qV/bg8Wx9C7
         1LlaaCiXL/NO4//ln0JX7Xxr8ugFz7Lsv5c+HFCIRTLTmQOTLOSv0uorCYqL4TIWjTqN
         vwiw==
X-Gm-Message-State: AOJu0Yx2kRol1JmPEmJ4dsj41MLmUCzFYI092tw3gZuivW7ldmGK8Q6z
        162bRTy2E+Eadb4CUpH28YRRPnyW5gLyjHRnEU+G39u5GM79Rao=
X-Google-Smtp-Source: AGHT+IElzvsk0t0sZqnhDAJGHgmsK5GFu7jckttkJGsqpRbtNJK3M1C1oNlHBigPocsjPwwEPU/V8WF14+HrDD12iklmoHPYI7lR
MIME-Version: 1.0
X-Received: by 2002:a17:90b:350e:b0:26d:a6b:9a47 with SMTP id
 ls14-20020a17090b350e00b0026d0a6b9a47mr1001876pjb.2.1699759958877; Sat, 11
 Nov 2023 19:32:38 -0800 (PST)
Date:   Sat, 11 Nov 2023 19:32:38 -0800
In-Reply-To: <0000000000001959d30609bb5d94@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008d6c4d0609ec3496@google.com>
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

diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index edb84cc03237..9be5a836c9c0 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -218,6 +218,7 @@ static struct btrfs_qgroup *add_qgroup_rb(struct btrfs_fs_info *fs_info,
 			p = &(*p)->rb_right;
 		} else {
 			kfree(prealloc);
+			prealloc = NULL;
 			return qgroup;
 		}
 	}
@@ -1697,6 +1698,7 @@ int btrfs_create_qgroup(struct btrfs_trans_handle *trans, u64 qgroupid)
 	struct btrfs_root *quota_root;
 	struct btrfs_qgroup *qgroup;
 	struct btrfs_qgroup *prealloc = NULL;
+	u64 objid;
 	int ret = 0;
 
 	if (btrfs_qgroup_mode(fs_info) == BTRFS_QGROUP_MODE_DISABLED)
@@ -1727,6 +1729,8 @@ int btrfs_create_qgroup(struct btrfs_trans_handle *trans, u64 qgroupid)
 	spin_lock(&fs_info->qgroup_lock);
 	qgroup = add_qgroup_rb(fs_info, prealloc, qgroupid);
 	spin_unlock(&fs_info->qgroup_lock);
+	while (!prealloc && !btrfs_get_free_objectid(fs_info->tree_root, 
+				&objid) && objid <= qgroupid);
 	prealloc = NULL;
 
 	ret = btrfs_sysfs_add_one_qgroup(fs_info, qgroup);
-- 
2.25.1

