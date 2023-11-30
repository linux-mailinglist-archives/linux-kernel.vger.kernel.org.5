Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E0467FE9B6
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 08:28:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344727AbjK3H2F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 02:28:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231706AbjK3H2E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 02:28:04 -0500
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96C21B9
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 23:28:10 -0800 (PST)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-28568b43a46so765011a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 23:28:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701329290; x=1701934090;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ixYvf/J8abI64uMWMZeI/HJ7Oi+NPdZy2LXBXb3PpQE=;
        b=N044Ix3iRNzzOOBA3w9G+XjavCNjaM14RVkPvdqaCkji04A7p2YxY54OgTszMkEYRr
         5QtW/Pa8vBB49bHruhMV99Ijcg0NUd/i88lk9LS04JKbKUUMc+GkO/4jjzM1TBS48jY0
         ap1yhibG/UeWaJZu5khCi8FK3ga+XbmK461niAXZSyNgKNVAQjuOu/anT1rUtFb2BL5j
         GWLCLcfUDhgQgtzAUsV/9InWDhZ/yvqk6j/PKlv+5o9gs/KzUpE9JlXDywXOkkV046jv
         aqM4C9ZI81PINpCGy0HQjQaGlI9ZJ7JQPQH0th0bhgBMxJOVZcafiOv7w6haJG+2IIfj
         3KbA==
X-Gm-Message-State: AOJu0Yw28ri1O+OW8uJcXSZjUPGxd8lfkgZQyv9Uod4+JTtRoSeC4kKU
        gSZg3hjlqfFkwJb46jvJEHR5KvMbEaopRGqD2jryOOtTxscF1S0=
X-Google-Smtp-Source: AGHT+IFQH8VR6O1jPWhQd7fk4IZdLJk8GzrYzS8MBhw467AZy5fl4Yh1BK+XOYNGM35QqVJy2A2npqJORHaow49PsyXEAQ290lTb
MIME-Version: 1.0
X-Received: by 2002:a17:903:182:b0:1d0:758:488e with SMTP id
 z2-20020a170903018200b001d00758488emr1555907plg.13.1701329290211; Wed, 29 Nov
 2023 23:28:10 -0800 (PST)
Date:   Wed, 29 Nov 2023 23:28:10 -0800
In-Reply-To: <000000000000db858c05f06f30b0@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fd370a060b59978b@google.com>
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
+	mutex_unlock(&sbi->s_lock);
 	if (__exfat_write_inode(inode, inode_needs_sync(inode)))
 		return -EIO;
 
