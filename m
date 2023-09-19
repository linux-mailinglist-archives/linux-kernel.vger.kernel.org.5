Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A02347A5C59
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 10:19:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230433AbjISIT2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 04:19:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231618AbjISITN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 04:19:13 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5866D182
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 01:19:05 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-40472c3faadso53494385e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 01:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1695111543; x=1695716343; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uQ3b5XDPJFH4ZPU40U25cW209fS7oBevnKSE6H0Fn+w=;
        b=KzoOHEfhKeHgv3tW4kwS9gSnmAtZ5Rq+pU6CPB/nWtxEUsL/EwlR9Dd03v5Z5FCR3w
         tBHZjwTkWTKkr5hmuryTkvMnPbfUnTQcwBkWDVPVGQxyBfRYVFzIjXBWHblINS93SKte
         DoHXm8RvZNysOQq8W+HleSyqmNje4rSGg3DiB+WVmTNAPQDB1Ffa23sEQZslg+Bs149B
         908eW/TAKcGqJApx6IooII/tMUGE6xSasunCs4/8EPWFo3Lrh+gQQn6Il2af8n4v+QOw
         jJsPmXw038aahZzML2ZivL1jYA7AfM6x6Eq8h76vr/kaIh9Ndn9aUNLrjrikihJkynWD
         /GKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695111543; x=1695716343;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uQ3b5XDPJFH4ZPU40U25cW209fS7oBevnKSE6H0Fn+w=;
        b=UoOSVFc3mU6MbAPKW7ibNsh0fRajybkSFri44JfZgYoa7A/huDZDLChecy5pbxgC5A
         RManPczjkm8B7dDwxKVESUzl1Jneoksu5Pma9/t2Xy1sGzX2fc5Lm6edVH4c6MoQsPyk
         hIoXCavxsu4qQj4pIja9qKw0L2T7kMi4afn6l9297XDqZi4SK5FGd2fDdZHFTXLKdS3W
         0RmQ1j2UfrybWs+pVp8MYRCE9o1IibxQpL5t+LEsOWjj65V3iIeqWuJpEb8sFCVfHkg3
         JDsmcF8wQPfZlyxYTAwkDUc5FQ5vqKlH7gLHWjFiP91WVcpj6flsq5YiAdFhdIWq4M5m
         duYA==
X-Gm-Message-State: AOJu0Yw+Y0ZlZFZKhahwpzMwqMOeoDWqXO0mqnmBCtgAv8jOJ04d84ep
        PkhgbUfxTIUp3wfpbxXJf6+z8g==
X-Google-Smtp-Source: AGHT+IHklgOzUf9luSSlKnZeygLJj0Nt/0Wm4ps2AhD3B7IuMCckbwf6QblDuTUO9BIOKq3Oel6UOQ==
X-Received: by 2002:a7b:ca4a:0:b0:401:c297:affb with SMTP id m10-20020a7bca4a000000b00401c297affbmr10412073wml.37.1695111543658;
        Tue, 19 Sep 2023 01:19:03 -0700 (PDT)
Received: from heron.intern.cm-ag (p200300dc6f209c00529a4cfffe3dd983.dip0.t-ipconnect.de. [2003:dc:6f20:9c00:529a:4cff:fe3d:d983])
        by smtp.gmail.com with ESMTPSA id i10-20020a5d558a000000b003141e629cb6sm14762549wrv.101.2023.09.19.01.19.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 01:19:02 -0700 (PDT)
From:   Max Kellermann <max.kellermann@ionos.com>
To:     Xiubo Li <xiubli@redhat.com>, Ilya Dryomov <idryomov@gmail.com>,
        Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.com>,
        Dave Kleikamp <shaggy@kernel.org>
Cc:     Max Kellermann <max.kellermann@ionos.com>,
        ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org, jfs-discussion@lists.sourceforge.net
Subject: [PATCH] fs: apply umask if POSIX ACL support is disabled
Date:   Tue, 19 Sep 2023 10:18:59 +0200
Message-Id: <20230919081900.1096840-1-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 fs/ceph/super.h           | 1 +
 fs/ext2/acl.h             | 1 +
 fs/jfs/jfs_acl.h          | 1 +
 include/linux/posix_acl.h | 1 +
 4 files changed, 4 insertions(+)

diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index 51c7f2b14f6f..e7e2f264acf4 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -1194,6 +1194,7 @@ static inline void ceph_forget_all_cached_acls(struct inode *inode)
 static inline int ceph_pre_init_acls(struct inode *dir, umode_t *mode,
 				     struct ceph_acl_sec_ctx *as_ctx)
 {
+	*mode &= ~current_umask();
 	return 0;
 }
 static inline void ceph_init_inode_acls(struct inode *inode,
diff --git a/fs/ext2/acl.h b/fs/ext2/acl.h
index 4a8443a2b8ec..694af789c614 100644
--- a/fs/ext2/acl.h
+++ b/fs/ext2/acl.h
@@ -67,6 +67,7 @@ extern int ext2_init_acl (struct inode *, struct inode *);
 
 static inline int ext2_init_acl (struct inode *inode, struct inode *dir)
 {
+	inode->i_mode &= ~current_umask();
 	return 0;
 }
 #endif
diff --git a/fs/jfs/jfs_acl.h b/fs/jfs/jfs_acl.h
index f892e54d0fcd..10791e97a46f 100644
--- a/fs/jfs/jfs_acl.h
+++ b/fs/jfs/jfs_acl.h
@@ -17,6 +17,7 @@ int jfs_init_acl(tid_t, struct inode *, struct inode *);
 static inline int jfs_init_acl(tid_t tid, struct inode *inode,
 			       struct inode *dir)
 {
+	inode->i_mode &= ~current_umask();
 	return 0;
 }
 
diff --git a/include/linux/posix_acl.h b/include/linux/posix_acl.h
index 0e65b3d634d9..54bc9b1061ca 100644
--- a/include/linux/posix_acl.h
+++ b/include/linux/posix_acl.h
@@ -128,6 +128,7 @@ static inline void cache_no_acl(struct inode *inode)
 static inline int posix_acl_create(struct inode *inode, umode_t *mode,
 		struct posix_acl **default_acl, struct posix_acl **acl)
 {
+	*mode &= ~current_umask();
 	*default_acl = *acl = NULL;
 	return 0;
 }
-- 
2.39.2

