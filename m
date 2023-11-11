Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A9457E88BB
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Nov 2023 03:56:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230401AbjKKC4v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 21:56:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbjKKC4s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 21:56:48 -0500
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38D474C00
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 18:56:07 -0800 (PST)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-1cc5ac304e8so27218855ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 18:56:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699671366; x=1700276166;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=omctVZ5SsqVpi9ywJV9a6B8dgbL8JWO06aB9T40Wn+Y=;
        b=dPs3lCsMYUK08JeZumYtTrTEKGcrPNfoAbJWZkhhsetu9YZeKUgSy2J/azqRU1dtIl
         YFpSOFu//HvdmoMaJ0iclthzS+EdLaU7fMlCc+A+rFoczzPHCBLe1nEyKyZg9Q6niIYb
         D0A4Qy8vdao3TMEzihmnEpNLzhc5NP27U1qSahjMDC1bPB1VMU7Zgv9hooH/fqvpAguF
         TSXopzl3RxI8TR6YLSThut849AVj3Endcs5/WSAyU5sz/V/EJzLHQLlwcxXYNcEULgSQ
         l0rwUJ6DUzE0d/nxZkpBw0O7k7/Cd91onhG6UZIehB8xfEbAhU8iRPijqimy9g5by2V5
         Ol2w==
X-Gm-Message-State: AOJu0YwcSp92gDMxRjAtXcSwvLv3Jie24cIIgJLtx5dvlFeS2rbgSKJB
        5bgOdahjr2uJEP0OcMjVtsJJHAKYA/kVS4wjU2kbuRAfqqq0tgA=
X-Google-Smtp-Source: AGHT+IFOf6wTSUkETCnvFCoJTMWdYN89AuA0z5THctiGQ2AVPZq8SOkQ/o5DSXM2+YvM4eGeh5Qt2GbaWIynGEAk3QRH47KCbpqv
MIME-Version: 1.0
X-Received: by 2002:a17:903:2790:b0:1cc:a1cf:5e92 with SMTP id
 jw16-20020a170903279000b001cca1cf5e92mr279895plb.9.1699671366613; Fri, 10 Nov
 2023 18:56:06 -0800 (PST)
Date:   Fri, 10 Nov 2023 18:56:06 -0800
In-Reply-To: <0000000000001959d30609bb5d94@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000ac1500609d79461@google.com>
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
diff --git a/fs/btrfs/qgroup.h b/fs/btrfs/qgroup.h
index 855a4f978761..a8da8e11734a 100644
--- a/fs/btrfs/qgroup.h
+++ b/fs/btrfs/qgroup.h
@@ -425,4 +425,11 @@ bool btrfs_check_quota_leak(struct btrfs_fs_info *fs_info);
 int btrfs_record_squota_delta(struct btrfs_fs_info *fs_info,
 			      struct btrfs_squota_delta *delta);
 
+static struct btrfs_qgroup *find_qgroup_rb(struct btrfs_fs_info *fs_info,
+                                            u64 qgroupid);
+
+bool exist_qgroup_rb(struct btrfs_fs_info *fs_info, u64 qgroupid)
+{
+	return find_qgroup_rb(fs_info, qgroupid);
+}
 #endif
-- 
2.25.1

