Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E8FB7E41DD
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 15:31:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234394AbjKGObH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 09:31:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbjKGObE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 09:31:04 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D1A5C1
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 06:30:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699367415;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=ZQt7pg+hz5jNDMSq3EOjA/DhangBBizVIEI+137usOY=;
        b=NSkVJ5+ftE4JkhKMQ3cbTufoCWpr/+yEx8qOU6q7C10vLgZzfqPLSrgzjZhvzyYOC3gP5u
        1T2E3EFQ/j36/UlNL75HyNh4L72uoI0tcJKMz2UUkwhctj7pouJkLmshHHJUHCjykrmuvW
        4K6uNHwArFo9+aNEOkEne3NzVwxECPQ=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-483-eWpDmqKMP-CSizhvGahpMQ-1; Tue, 07 Nov 2023 09:30:13 -0500
X-MC-Unique: eWpDmqKMP-CSizhvGahpMQ-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-280351c9fa1so4426694a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 06:30:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699367412; x=1699972212;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZQt7pg+hz5jNDMSq3EOjA/DhangBBizVIEI+137usOY=;
        b=WmbDiYrvrYu7zf3gQ4wKflMR5DxRNoC2CO0aFOmRKc/li8mhWZ/9lu9E03cpO+quFK
         w4rabLBTSptXWujeYNLPXL5i5t+sObfQBPtxcKMszQqhDDTpykePGWGrKvlaDNJY+d1E
         BF3nr6SzAkQgUtzZxAFJzRP/+GkWXMrAe98JGW4bi2i1lK0Y8BnSrVFXvyTJk42x1v33
         kmo7Bfq4AkrNq/zm7o3qSWaXlKSGA8564+2qX2XFHpmvk2Oq1eoeA7h8zFANImmVrZrX
         v9q3/QVWnUcTSJsuG+0XyHyX0K10N3hufN8JcurP79oTzzCXCSn5BU1htQMkGJm825GG
         9CUQ==
X-Gm-Message-State: AOJu0Yw6ETOkIi5qDJ2HCSSmHeTUkKXBJicjDq29J/VU6rQYyaJShSrq
        ArrqIIeoBhjAqWttz5RyXH+VtImOw7dVA+TOmE+H7PQmKDKvIcAcaKdNPY0OarWXMa8Fsoh262B
        lsNLIbZTlw/SWxft272kI3i7j
X-Received: by 2002:a17:90b:384b:b0:280:fc91:ad5d with SMTP id nl11-20020a17090b384b00b00280fc91ad5dmr4664059pjb.19.1699367412371;
        Tue, 07 Nov 2023 06:30:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEuwPioMxYU0e32tVho4oh9okqj5EPRVrzMFmBiBPbOflyaQu6oF+fw0oH5qrNe5mI5XH8QUw==
X-Received: by 2002:a17:90b:384b:b0:280:fc91:ad5d with SMTP id nl11-20020a17090b384b00b00280fc91ad5dmr4664041pjb.19.1699367412059;
        Tue, 07 Nov 2023 06:30:12 -0800 (PST)
Received: from kernel-devel.local ([240d:1a:c0d:9f00:245e:16ff:fe87:c960])
        by smtp.gmail.com with ESMTPSA id f92-20020a17090a706500b0026f90d7947csm7762399pjk.34.2023.11.07.06.30.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 06:30:11 -0800 (PST)
From:   Shigeru Yoshida <syoshida@redhat.com>
To:     linkinjeon@kernel.org, sj1557.seo@samsung.com
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shigeru Yoshida <syoshida@redhat.com>
Subject: [PATCH] exfat: Fix uninit-value access in __exfat_write_inode()
Date:   Tue,  7 Nov 2023 23:30:02 +0900
Message-ID: <20231107143002.1342295-1-syoshida@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

KMSAN reported the following uninit-value access issue:

=====================================================
BUG: KMSAN: uninit-value in exfat_set_entry_time+0x309/0x360 fs/exfat/misc.c:99
 exfat_set_entry_time+0x309/0x360 fs/exfat/misc.c:99
 __exfat_write_inode+0x7ae/0xdb0 fs/exfat/inode.c:59
 __exfat_truncate+0x70e/0xb20 fs/exfat/file.c:163
 exfat_truncate+0x121/0x540 fs/exfat/file.c:211
 exfat_setattr+0x116c/0x1a40 fs/exfat/file.c:312
 notify_change+0x1934/0x1a30 fs/attr.c:499
 do_truncate+0x224/0x2a0 fs/open.c:66
 handle_truncate fs/namei.c:3280 [inline]
 do_open fs/namei.c:3626 [inline]
 path_openat+0x56c6/0x5f20 fs/namei.c:3779
 do_filp_open+0x21c/0x5a0 fs/namei.c:3809
 do_sys_openat2+0x1ba/0x2f0 fs/open.c:1440
 do_sys_open fs/open.c:1455 [inline]
 __do_sys_creat fs/open.c:1531 [inline]
 __se_sys_creat fs/open.c:1525 [inline]
 __x64_sys_creat+0xe3/0x140 fs/open.c:1525
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x44/0x110 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

Uninit was stored to memory at:
 exfat_set_entry_time+0x302/0x360 fs/exfat/misc.c:99
 __exfat_write_inode+0x7ae/0xdb0 fs/exfat/inode.c:59
 __exfat_truncate+0x70e/0xb20 fs/exfat/file.c:163
 exfat_truncate+0x121/0x540 fs/exfat/file.c:211
 exfat_setattr+0x116c/0x1a40 fs/exfat/file.c:312
 notify_change+0x1934/0x1a30 fs/attr.c:499
 do_truncate+0x224/0x2a0 fs/open.c:66
 handle_truncate fs/namei.c:3280 [inline]
 do_open fs/namei.c:3626 [inline]
 path_openat+0x56c6/0x5f20 fs/namei.c:3779
 do_filp_open+0x21c/0x5a0 fs/namei.c:3809
 do_sys_openat2+0x1ba/0x2f0 fs/open.c:1440
 do_sys_open fs/open.c:1455 [inline]
 __do_sys_creat fs/open.c:1531 [inline]
 __se_sys_creat fs/open.c:1525 [inline]
 __x64_sys_creat+0xe3/0x140 fs/open.c:1525
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x44/0x110 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

Local variable ts created at:
 __exfat_write_inode+0x102/0xdb0 fs/exfat/inode.c:29
 __exfat_truncate+0x70e/0xb20 fs/exfat/file.c:163

CPU: 0 PID: 13839 Comm: syz-executor.7 Not tainted 6.6.0-14500-g1c41041124bd #10
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-1.fc38 04/01/2014
=====================================================

Commit 4c72a36edd54 ("exfat: convert to new timestamp accessors") changed
__exfat_write_inode() to use new timestamp accessor functions.

As for mtime, inode_set_mtime_to_ts() is called after
exfat_set_entry_time(). This causes the above issue because `ts` is not
initialized when exfat_set_entry_time() is called. The same issue can occur
for atime.

This patch resolves this issue by calling inode_get_mtime() and
inode_get_atime() before exfat_set_entry_time() to initialize `ts`.

Fixes: 4c72a36edd54 ("exfat: convert to new timestamp accessors")
Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>
---
 fs/exfat/inode.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/exfat/inode.c b/fs/exfat/inode.c
index 875234179d1f..e7ff58b8e68c 100644
--- a/fs/exfat/inode.c
+++ b/fs/exfat/inode.c
@@ -56,18 +56,18 @@ int __exfat_write_inode(struct inode *inode, int sync)
 			&ep->dentry.file.create_time,
 			&ep->dentry.file.create_date,
 			&ep->dentry.file.create_time_cs);
+	ts = inode_get_mtime(inode);
 	exfat_set_entry_time(sbi, &ts,
 			     &ep->dentry.file.modify_tz,
 			     &ep->dentry.file.modify_time,
 			     &ep->dentry.file.modify_date,
 			     &ep->dentry.file.modify_time_cs);
-	inode_set_mtime_to_ts(inode, ts);
+	ts = inode_get_atime(inode);
 	exfat_set_entry_time(sbi, &ts,
 			     &ep->dentry.file.access_tz,
 			     &ep->dentry.file.access_time,
 			     &ep->dentry.file.access_date,
 			     NULL);
-	inode_set_atime_to_ts(inode, ts);
 
 	/* File size should be zero if there is no cluster allocated */
 	on_disk_size = i_size_read(inode);
-- 
2.41.0

