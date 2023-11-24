Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C543A7F729A
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 12:21:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345763AbjKXLVS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 06:21:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230366AbjKXLVO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 06:21:14 -0500
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 564FE10F1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 03:21:20 -0800 (PST)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-1ccdf149e60so20756175ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 03:21:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700824880; x=1701429680;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tW1cfX71P9lrzXii1iWpq/1vUgPfSjvcfgFoCbeo6eo=;
        b=UhY1qlKL1mOyBWss26dQGzKY851V20ZCfEWYAfer/Ij+TjltRrg9xsC/zGCrWoxRsR
         4sjtvV/SJgdXkHfAiFYKbVLfQEIQ4FnafXpLQEb/KR9bWkv0jiPXtTcQG3uRTZkneyXh
         k+mEZqnQa7O9tZZDUFXyccJ2m0yXCn7VTw7h4RYgpWggh0jTijKnY+ukvWU6HOLdQxKn
         N/0uf/su6drwbPX+iJudjBBII/LRVaSauwV4c6ueEghR7kvrT0RiRQsQyCPNRHcoJ7ON
         ipD2I6xUd9ex5P79d+rG4s96CTHdobKeJc7RCBPdvOSBzjkW1OpeHER5XMPTKeLZxwh0
         F1eg==
X-Gm-Message-State: AOJu0Yz9+nTFgyN8gdpQCcnT8NQIRgviUZO4gHucTyvcqjYLTcdXUhPy
        SYkPa8Ggd42XTNqWHVxckJ6b0Lc8gl0H/zV2QZS8AHpx2KFsFb4=
X-Google-Smtp-Source: AGHT+IFqBX9qAeMlqC6LCnBRgwMYzduUHbMf5hg9hJWJmEIT5oDTyGi2898hVYVSVE3Xy78Hlz+j8bne8YXe/zfP/EwIMSX13ohL
MIME-Version: 1.0
X-Received: by 2002:a17:903:2308:b0:1cf:75b0:42fc with SMTP id
 d8-20020a170903230800b001cf75b042fcmr593374plh.4.1700824879918; Fri, 24 Nov
 2023 03:21:19 -0800 (PST)
Date:   Fri, 24 Nov 2023 03:21:19 -0800
In-Reply-To: <000000000000fb2f84060ad4da7f@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000caf352060ae426aa@google.com>
Subject: Re: [syzbot] [ntfs3?] WARNING in indx_insert_into_buffer
From:   syzbot <syzbot+c5b339d16ffa61fd512d@syzkaller.appspotmail.com>
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

Subject: [ntfs3?] WARNING in indx_insert_into_buffer
Author: eadavis@qq.com

please test WARNING in indx_insert_into_buffer

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 037266a5f723

diff --git a/fs/ntfs3/index.c b/fs/ntfs3/index.c
index cf92b2433f7a..350ec6798ffe 100644
--- a/fs/ntfs3/index.c
+++ b/fs/ntfs3/index.c
@@ -1865,6 +1865,7 @@ indx_insert_into_buffer(struct ntfs_index *indx, struct ntfs_inode *ni,
 	hdr_insert_head(hdr2, de_t, to_copy);
 
 	/* Remove all entries (sp including) from hdr1. */
+	printk("u1: %d, tc: %d, ss: %d\n", used1, to_copy, sp_size);
 	used = used1 - to_copy - sp_size;
 	memmove(de_t, Add2Ptr(sp, sp_size), used - le32_to_cpu(hdr1->de_off));
 	hdr1->used = cpu_to_le32(used);
@@ -1892,6 +1893,8 @@ indx_insert_into_buffer(struct ntfs_index *indx, struct ntfs_inode *ni,
 	 * We've finished splitting everybody, so we are ready to
 	 * insert the promoted entry into the parent.
 	 */
+	printk("l: %d, e: %d, h1: %p, h1s: %p, u1: %d, %d\n", level, err, hdr1, hdr1_saved, 
+				used1, le32_to_cpu(hdr1->used));
 	if (!level) {
 		/* Insert in root. */
 		err = indx_insert_into_root(indx, ni, up_e, NULL, ctx, fnd, 0);
@@ -1909,6 +1912,8 @@ indx_insert_into_buffer(struct ntfs_index *indx, struct ntfs_inode *ni,
 		 * Undo critical operations.
 		 */
 		indx_mark_free(indx, ni, new_vbn >> indx->idx2vbn_bits);
+		printk("%d, e: %d, h1: %p, h1s: %p, u1: %d, %d\n", level, err, hdr1, hdr1_saved, 
+				used1, le32_to_cpu(hdr1->used));
 		memcpy(hdr1, hdr1_saved, used1);
 		indx_write(indx, ni, n1, 0);
 	}
@@ -1916,6 +1921,7 @@ indx_insert_into_buffer(struct ntfs_index *indx, struct ntfs_inode *ni,
 out:
 	kfree(up_e);
 	kfree(hdr1_saved);
+	printk("h1: %p, e: %d", hdr1, err);
 
 	return err;
 }

