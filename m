Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C1FE7E88C8
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Nov 2023 04:07:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345363AbjKKDHD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 22:07:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230227AbjKKDHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 22:07:01 -0500
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A16673C0C
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 19:06:58 -0800 (PST)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-5b62a669d61so2420662a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 19:06:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699672018; x=1700276818;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wwERRtL3OVkJy6Sh3HcW4Qh1bkiQFTgdH6hf4VVBAIo=;
        b=AsQu1hlLk72xc4zafy5thIXphZnIClj0JD7QKLpYUSZN7ED6B3hwIvpa53GcfSHbVV
         gI1KRvYSFYUR/9Aa0pUnZJkL3TfaQjknGEDPkMxYmQglN9kwS4Rwz+B995Do30AtTIP+
         zj/qkWdcTH4vC3gXy4OV1esA5mR73oxHp1OPyiGthKLTedobIxLSRfPg5pF0VHun8vtn
         Hs6+HEbp3i5ilJhoq76mv16/4JYCX8kIRWC1efyPnQebMfWoaU6VLsJuI5yOtpefVKld
         +5+E7+nAnGvTsDMS5893Mky165y9L+bNYV3fKog0+Kq6ob+J1FF5R2VRuRIyz6HLu7QN
         Xn6Q==
X-Gm-Message-State: AOJu0YzJUPFSM8SNB/O73l2GM3dTL4sd2teMBqargdT25oTbr5Xyjc/C
        efD+6YIGp8OtwElR6Bfufxk+EF391ACoVkitE4vmeWuAiJqluhk=
X-Google-Smtp-Source: AGHT+IHdxChc5QcaPbCRbIgi+aVBbqq9FG1CDtMEVOPuBhAC6clusbLc4XuIwNJZWU/ZrD44+7kbHqYyCyfOUmstxr7qFvMQv+ls
MIME-Version: 1.0
X-Received: by 2002:a63:e313:0:b0:5bd:39ba:ac0a with SMTP id
 f19-20020a63e313000000b005bd39baac0amr260319pgh.2.1699672018180; Fri, 10 Nov
 2023 19:06:58 -0800 (PST)
Date:   Fri, 10 Nov 2023 19:06:58 -0800
In-Reply-To: <0000000000001959d30609bb5d94@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e0e4360609d7bae2@google.com>
Subject: Re: [syzbot] [PATCH] test 305230142ae0
From:   syzbot <syzbot+4d81015bc10889fd12ea@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
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
+static bool exist_qgroup_rb(struct btrfs_fs_info *fs_info, u64 qgroupid)
+{
+	return find_qgroup_rb(fs_info, qgroupid);
+}
 #endif
-- 
2.25.1

