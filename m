Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EFF07E8E1A
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Nov 2023 04:36:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230050AbjKLDf0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Nov 2023 22:35:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbjKLDfY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Nov 2023 22:35:24 -0500
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9AE130EA
        for <linux-kernel@vger.kernel.org>; Sat, 11 Nov 2023 19:35:21 -0800 (PST)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-6c334d2fd40so3909775b3a.2
        for <linux-kernel@vger.kernel.org>; Sat, 11 Nov 2023 19:35:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699760121; x=1700364921;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OOPUD452I3VBWOL7j/tj1A+pZ858/UhX5bs7AcetyN4=;
        b=aBzVAYUOBl/A/OYvIhrEIg6nDGGWDHVfpEAdf0Xl9r51dy+rfD+5wcArz6d+U8E/Di
         7rL7QvSBPRRZfYlNM0dMEVeMRtgD/ctS2ZZWG4hgHuWKaFGua4KWuuAT21vMCLA+zM4y
         0f9384wen7Um9fqC/5g2sObjo3V5pzkSQyfP8UA9lEVaWxGmBTFBUOnNwJxboiKtvHn1
         9Oxc3h5oL7fdiZbH+0S//T8xeMEkS+2wK6LIl58PtJG1BW8JdQfuSf/hj5QUQFYUnJrR
         tYkv5kkBI40AIK4/Unda420Uda8xH8szZOpE7H7SjQPTJuAMjW9xwLTppkPlUReHbeSC
         feuA==
X-Gm-Message-State: AOJu0YwJgGLCQYdseuB57Gs/uzbiW1H5K1AKT4P2A1XiL2L1xAqR/VmW
        4bpYZqMuM7LzqX8oAuvLN6RA9JJ6eWZAy/vx/tWw9afkjQXdKMk=
X-Google-Smtp-Source: AGHT+IEMiiUu8g0rTmJ58VR8i9A3W6HbEXkKHDbXzIwVwu2aEYMF7hsw9D5AuWxSL4fYjngbNp0uO+opne0P+oJzyGw7j14er+06
MIME-Version: 1.0
X-Received: by 2002:a05:6a00:2809:b0:68f:f868:a4fb with SMTP id
 bl9-20020a056a00280900b0068ff868a4fbmr783919pfb.5.1699760121444; Sat, 11 Nov
 2023 19:35:21 -0800 (PST)
Date:   Sat, 11 Nov 2023 19:35:21 -0800
In-Reply-To: <0000000000001959d30609bb5d94@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003e00f60609ec3e04@google.com>
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
+	while (prealloc && !btrfs_get_free_objectid(fs_info->tree_root, 
+				&objid) && objid <= qgroupid);
 	prealloc = NULL;
 
 	ret = btrfs_sysfs_add_one_qgroup(fs_info, qgroup);
-- 
2.25.1

