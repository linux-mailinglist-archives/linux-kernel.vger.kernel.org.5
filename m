Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 668B87E8861
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Nov 2023 03:38:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345458AbjKKCiA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 21:38:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjKKCh6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 21:37:58 -0500
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F15073C0E
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 18:37:55 -0800 (PST)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-1cc385e90e2so27925045ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 18:37:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699670275; x=1700275075;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DSKrAPEQX8JBY5dcPA6aCmIIR2K68WR/P/3sBLwglFU=;
        b=JmJVHq9YRxzVJtXWvj3czoMyqp/sz9JsDJTL885e5EEMiB8mWBWq+FQTYcJFk4It2K
         IaiFlHZRjWIUGyjILLjDt5Zi4bAGhk0xEpH6QcWIRi0W/CWbUC5SvUU232eSGtPTCVWL
         pOp0CHAxPC8D97MOuk2Qim0qbRn75Z/NG1N7Z5czzYw333CaAobYEl0AbwuRTKsADRYe
         hNbtCucEue6sQxde1SIo66M9rk/BKo5vFer78DaM8bSjMgsNAXNhEaAbzKYQfKEvNwyd
         CCyYjh45OvsSnXUorM324s3Fm8iJZE4RLnb3X/8WZlCYvHOlSiR3nwP6wbPIxHmigsoJ
         W0GA==
X-Gm-Message-State: AOJu0YwnH0Q1mlCzV4sbs38gPH87rrPuOfNc59LuVt1Clo9SIeu9UZw2
        5VoDBr/ajMT2pwRQ/GeI636h/ZbJdg/O+HvZcvBM05TB+KiahXk=
X-Google-Smtp-Source: AGHT+IHYHeEqvu83f0vaaqhxL1NS19rN5uc3EdvBLCqTArooc9M4DIEzRvdmqG89ywBFoz6ZT5+qj0rdZRKSHUFmYTghwufWC/65
MIME-Version: 1.0
X-Received: by 2002:a17:903:428d:b0:1cc:3135:acbc with SMTP id
 ju13-20020a170903428d00b001cc3135acbcmr268618plb.9.1699670275632; Fri, 10 Nov
 2023 18:37:55 -0800 (PST)
Date:   Fri, 10 Nov 2023 18:37:55 -0800
In-Reply-To: <0000000000001959d30609bb5d94@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000003bc4c0609d753f2@google.com>
Subject: Re: [syzbot] [PATCH] test 305230142ae0
From:   syzbot <syzbot+4d81015bc10889fd12ea@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
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

