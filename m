Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BFAB7F882F
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 04:35:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231671AbjKYDfA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 22:35:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjKYDe6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 22:34:58 -0500
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DE281720
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 19:35:05 -0800 (PST)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-5bdd8eee498so2181598a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 19:35:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700883304; x=1701488104;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o94EDKPNFEfR9PCCBpGy/li5oOEReETxlw/hJs2LCVI=;
        b=KDBKWb7zMU5wwrbVsxIM3kkjEIuHQNFmIbHXKZgxjKN00hrjkccSG0i/nej/tCTrH4
         1iea9QKhXCdZJohKPU7eD+my+g6vcrvURQ8/xj7+YmUDy7AUCGb4/qSBKCnK0T9I0z09
         w7IyZ0cS21xPLQrOXqaHGb0QKnWa64/0Cf6rtCQ+fqxyEqK+Ogblg95XbZo7Bl+uI4UO
         RbBWqOXwXgCFV3tHmfnUaE7UAx/W4Xb64TbVvtslQU/sb0XJHwSBAA3EYydvbfxyW0Ag
         w+XD2yTR1plipU0DihM+MY148saFGmIARqbShLSWYtlZu86S6HJq5iLaGDXpdZUmHPGA
         iSbg==
X-Gm-Message-State: AOJu0Yy2Onorw630ltuXMS7VNSLipqRM3J2fq1y+hbNV9yAUqvLScpvy
        IomtM6YORKVCbFDOnJBBBHcROsq3AS+ISIkXz7q68wRnxHsloQw=
X-Google-Smtp-Source: AGHT+IGg13zl7EBqcCNXZXdoaQDaNiZgEgZv1MemX/T2zGY0K2FatsDuycrtXggOgHmFyHGY4B0CeRA7rcX6Eji+kn6SC+Mtdpd6
MIME-Version: 1.0
X-Received: by 2002:a63:5848:0:b0:5b8:fe99:152d with SMTP id
 i8-20020a635848000000b005b8fe99152dmr769412pgm.7.1700883304631; Fri, 24 Nov
 2023 19:35:04 -0800 (PST)
Date:   Fri, 24 Nov 2023 19:35:04 -0800
In-Reply-To: <000000000000fb2f84060ad4da7f@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002d53a1060af1c1b3@google.com>
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
index cf92b2433f7a..67c27e6ce497 100644
--- a/fs/ntfs3/index.c
+++ b/fs/ntfs3/index.c
@@ -1816,6 +1816,9 @@ indx_insert_into_buffer(struct ntfs_index *indx, struct ntfs_inode *ni,
 	 * - Insert sp into parent buffer (or root)
 	 * - Make sp a parent for new buffer
 	 */
+	printk("l: %d, u1: %d, t: %d, do: %d\n", 
+		level, le32_to_cpu(hdr1->used), le32_to_cpu(hdr1->total), 
+		le32_to_cpu(hdr1->de_off));
 	sp = hdr_find_split(hdr1);
 	if (!sp)
 		return -EINVAL;
@@ -1833,6 +1836,8 @@ indx_insert_into_buffer(struct ntfs_index *indx, struct ntfs_inode *ni,
 		goto out;
 	}
 
+	printk("l: %d, u1: %d, sps: %d, t: %d, do: %d\n", 
+		level, used1, sp_size, le32_to_cpu(hdr1->total), le32_to_cpu(hdr1->de_off));
 	if (!hdr1->flags) {
 		up_e->flags |= NTFS_IE_HAS_SUBNODES;
 		up_e->size = cpu_to_le16(sp_size + sizeof(u64));
@@ -1895,6 +1900,10 @@ indx_insert_into_buffer(struct ntfs_index *indx, struct ntfs_inode *ni,
 	if (!level) {
 		/* Insert in root. */
 		err = indx_insert_into_root(indx, ni, up_e, NULL, ctx, fnd, 0);
+		printk("%d, u1: %d, sps: %d, t: %d, do: %d\n", 
+		level, used1, sp_size, le32_to_cpu(hdr1->total), le32_to_cpu(hdr1->de_off));
+		if (err == -ENOMEM)
+			goto out;
 	} else {
 		/*
 		 * The target buffer's parent is another index buffer.

