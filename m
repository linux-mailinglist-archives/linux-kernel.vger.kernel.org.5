Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CE527A31C5
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 20:00:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236712AbjIPSAY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Sep 2023 14:00:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231652AbjIPR74 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Sep 2023 13:59:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 766DBCDE
        for <linux-kernel@vger.kernel.org>; Sat, 16 Sep 2023 10:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694887144;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=uxC3KkgcEVk/woa2gOxR4oEmhN+ppIRoS6d7Lsp8+jk=;
        b=ZAB+IaNbZavaBi3m6wGUZlCIdi3FHp0Jqk6cuZK22KCFvBCgCpE6x1/w+gdu87CJSzvFFt
        2cnEdMYX0V6Uo1zNhCxTM743p73hwT/CGGi0MXYQfqJPyiYH9EFMV0hmCQVAft2u6GJYhE
        yqwgi0pPc66xVzJhLBnKz0Plat0z4XM=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-583-cqmp7cImNdin5c9zXDkffw-1; Sat, 16 Sep 2023 13:59:02 -0400
X-MC-Unique: cqmp7cImNdin5c9zXDkffw-1
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-1c41538c7eeso24369185ad.1
        for <linux-kernel@vger.kernel.org>; Sat, 16 Sep 2023 10:59:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694887141; x=1695491941;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uxC3KkgcEVk/woa2gOxR4oEmhN+ppIRoS6d7Lsp8+jk=;
        b=P/udCxt0fHjI5eulWTP3MJ9+Tilpalts9YQNq06Lav5vWNERdTiU0Sd6Fu3qHNz6A0
         LYZasKindZ+eSNobOWL+eCOdg8hG6EPDC1gEk1wZfQlJWVjuPks51gzp23JOj+dviErK
         V9o2g5ju50Jv3BQiiSo3ZOvZiYBJYYjj5+myOPfe6ex/UeRoLYlV8wUVK5C2AOIRzQOs
         PoONTGRu8fL8nBl/M0YRKiZWPRXuaua9VO7bFnNB1XSvXqYtrvOilFKczxm7zKcASR2H
         o2G5t5Np6fljWxLZJrkZNuhq8/ZBlZ6n/M4oBxBk2RKtbAdIpeo1C2rLndVtlFq8AMMR
         FEfQ==
X-Gm-Message-State: AOJu0YxiaP+CpLvl8RkUi4uzNybUhLL5wAC7Gub5QCxMKMrLDFbk7CKJ
        P+HIKbBrM8imC8vDJVsUOVJg2KzKcOE/iEgU7EQb1+DfehJVrV9UfoVtDIBzds2Vaj1tR+8yF7f
        iQtPSM7YzKfJ/sw6wMzkZXizFAn5QvTzN
X-Received: by 2002:a17:902:b284:b0:1c0:953d:58 with SMTP id u4-20020a170902b28400b001c0953d0058mr4864512plr.0.1694887141105;
        Sat, 16 Sep 2023 10:59:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHPk14frCdL1OB9hOXeYU8B5nEszOYgyqoW2r0dhAy/z9+/X7Gm77SjyEdqKN5zCh9sOkGjJg==
X-Received: by 2002:a17:902:b284:b0:1c0:953d:58 with SMTP id u4-20020a170902b28400b001c0953d0058mr4864503plr.0.1694887140831;
        Sat, 16 Sep 2023 10:59:00 -0700 (PDT)
Received: from kernel-devel.local ([240d:1a:c0d:9f00:245e:16ff:fe87:c960])
        by smtp.gmail.com with ESMTPSA id jw16-20020a170903279000b001b016313b1dsm5345546plb.86.2023.09.16.10.58.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Sep 2023 10:59:00 -0700 (PDT)
From:   Shigeru Yoshida <syoshida@redhat.com>
To:     almaz.alexandrovich@paragon-software.com
Cc:     ntfs3@lists.linux.dev, linux-kernel@vger.kernel.org,
        Shigeru Yoshida <syoshida@redhat.com>,
        syzbot+9ccdd15480e9d9833822@syzkaller.appspotmail.com
Subject: [PATCH] fs/ntfs3: Fix memory leak in ntfs_fill_super()
Date:   Sun, 17 Sep 2023 02:58:52 +0900
Message-ID: <20230916175852.1607269-1-syoshida@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot reported memory leak in ntfs_fill_super(). ntfs_fill_super() calls
wnd_init() and this allocates memory. So, we need to free those memory on the
error handling path in ntfs_fill_super().

Fixes: 82cae269cfa9 ("fs/ntfs3: Add initialization of super block")
Reported-and-tested-by: syzbot+9ccdd15480e9d9833822@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=9ccdd15480e9d9833822
Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>
---
 fs/ntfs3/super.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
index cfec5e0c7f66..a9610f5f4cc0 100644
--- a/fs/ntfs3/super.c
+++ b/fs/ntfs3/super.c
@@ -1563,6 +1563,13 @@ static int ntfs_fill_super(struct super_block *sb, struct fs_context *fc)
 	iput(inode);
 out:
 	kfree(boot2);
+
+	if (sbi->mft.bitmap.inited)
+		wnd_close(&sbi->mft.bitmap);
+
+	if (sbi->used.bitmap.inited)
+		wnd_close(&sbi->used.bitmap);
+
 	return err;
 }
 
-- 
2.41.0

