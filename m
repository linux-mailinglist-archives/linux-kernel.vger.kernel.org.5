Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80CE87FE9F9
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 08:56:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234991AbjK3Hzy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 02:55:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231806AbjK3Hzu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 02:55:50 -0500
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E61110F9
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 23:55:52 -0800 (PST)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-1cff35371aeso6973385ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 23:55:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701330952; x=1701935752;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dA+vPCLU/f6Yj1BbW2YhSxBQTt1cBuwejD5YAdXVdl4=;
        b=tDkYQFiu2SQTUSnRV8I/K4I2//jivGZ1BeyvSdl34jZbTgz+THK0kEBvrWWfdcSh3k
         m1CvyNe/UExnHDxbhNl2UyTlJQ6G2N/EF4yeHir7FQw/K07H3uHsAHuHGN5zikUH2h/4
         x1DQCyUqnOD6iD7oAgh6Qy6VutoO/YpNkkw4Sn2qRZsYY2mO3VMUilFjoQve3mty80Il
         m9KnMvJBuqjon4IKYYJ4YTdNpuGPwxD7Kl6YpYzb3WXWWsE8PGEKKR6calMkIMhjxAsY
         HbjwSEWwrc9Rlw+r2Jx7AS11rZkilk1XCKc/jHykjc/1zmgtXLX49DaJU2oefi9ahms5
         0LxQ==
X-Gm-Message-State: AOJu0YzFxcWNrttKocn5GHgDd4ALsGH17Prcx3TIX6905kK4bs3pxp06
        p1N+y/rtf+ZOxP83Qx21zSQqijAQYlgDcuMmzTaKM3ajwkZ4LFA=
X-Google-Smtp-Source: AGHT+IHTeXSRrm5vroVwTUiTD7Z+TydmhjCjfqVid67MQ1RC5AHJswGV8DDTARuk4tmpB2pQ9LNgZ+Eavj4ddEurex7brZvfPPFU
MIME-Version: 1.0
X-Received: by 2002:a17:902:6944:b0:1cf:6969:598 with SMTP id
 k4-20020a170902694400b001cf69690598mr4392609plt.7.1701330951829; Wed, 29 Nov
 2023 23:55:51 -0800 (PST)
Date:   Wed, 29 Nov 2023 23:55:51 -0800
In-Reply-To: <000000000000db858c05f06f30b0@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000078063060b59fb38@google.com>
Subject: Re: [syzbot] task hung in exfat_write_inode
From:   syzbot <syzbot+2f73ed585f115e98aee8@syzkaller.appspotmail.com>
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

Subject: task hung in exfat_write_inode
Author: lizhi.xu@windriver.com

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git f9ff5644bcc0

diff --git a/fs/exfat/file.c b/fs/exfat/file.c
index bfdfafe00993..a3ace4fc555c 100644
--- a/fs/exfat/file.c
+++ b/fs/exfat/file.c
@@ -116,6 +116,7 @@ int __exfat_truncate(struct inode *inode)
 
 	exfat_chain_set(&clu, ei->start_clu, num_clusters_phys, ei->flags);
 
+	mutex_unlock(&sbi->s_lock);
 	if (i_size_read(inode) > 0) {
 		/*
 		 * Truncate FAT chain num_clusters after the first cluster
@@ -134,8 +135,10 @@ int __exfat_truncate(struct inode *inode)
 		} else {
 			while (num_clusters > 0) {
 				last_clu = clu.dir;
+				mutex_lock(&sbi->s_lock);
 				if (exfat_get_next_cluster(sb, &(clu.dir)))
 					return -EIO;
+				mutex_unlock(&sbi->s_lock);
 
 				num_clusters--;
 				clu.size--;
@@ -160,6 +163,7 @@ int __exfat_truncate(struct inode *inode)
 	 * __exfat_write_inode() is called for directory entry, bitmap
 	 * and FAT to be written in a same writeback.
 	 */
+	mutex_lock(&sbi->s_lock);
 	if (__exfat_write_inode(inode, inode_needs_sync(inode)))
 		return -EIO;
 
