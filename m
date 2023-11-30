Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D401C7FEB0E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 09:43:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345002AbjK3InM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 03:43:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344989AbjK3InJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 03:43:09 -0500
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 063D5A2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 00:43:16 -0800 (PST)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-1cfba9f385aso7778625ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 00:43:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701333795; x=1701938595;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mkxVeHpdPTesg4Gj8MIqsgF3u8iigyFeiw0iWW5TmH0=;
        b=wlAfHoNVV6a13qCNUztRvCCn67uZvLxJ/zQj+X8Nv021xfa5FDRHM3ouGzBKP5mToy
         0ridUg0V36z0647cUNiQt7vUuOSde44WKIVEreB3rap6lXPDBszd7CgGnzv9I2plqhP6
         y0MFBebpQcPQw8BG4mOb55OOnomdZyGy76yyGOmleaUxs2H2AsdJCpdL/mR4D0FNrEfq
         ZdNGCmSwAZqGOp8wwnX80Sc17JQRwNPu6xBdb9gels9F11Q/BcB8SoqzLemfxEX7RUJs
         TttHcTedZx8t/SAXlR73/tn+IYFZEQmuBGZys6aPrFppWQVtYd1RxoKfLQ/mL+ZZxDwi
         QSPA==
X-Gm-Message-State: AOJu0Yy1/O3EuKrRd1mmIHW36sriKGbQTlX9IiYhW/97DQjofRgk3NQJ
        6q+B1PuiE/5rNJPGJ7RjqY0lfAETzZau1U1UQvfCzICJdDsXPHQ=
X-Google-Smtp-Source: AGHT+IHKNX1LFrnC+6j0ZHuGLay0h1R4FKweLM2ug51lIvwd0+CH3655n+jYmFErvfeRdE8Okj/WciD0yfANoaMdDitCYXcO4MdO
MIME-Version: 1.0
X-Received: by 2002:a17:903:451:b0:1cf:923e:fafc with SMTP id
 iw17-20020a170903045100b001cf923efafcmr4210356plb.7.1701333795618; Thu, 30
 Nov 2023 00:43:15 -0800 (PST)
Date:   Thu, 30 Nov 2023 00:43:15 -0800
In-Reply-To: <000000000000db858c05f06f30b0@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000884543060b5aa428@google.com>
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
index bfdfafe00993..4bdcdf126a21 100644
--- a/fs/exfat/file.c
+++ b/fs/exfat/file.c
@@ -132,14 +132,18 @@ int __exfat_truncate(struct inode *inode)
 			clu.dir += num_clusters;
 			clu.size -= num_clusters;
 		} else {
+			mutex_unlock(&sbi->s_lock);
 			while (num_clusters > 0) {
 				last_clu = clu.dir;
+				mutex_lock(&sbi->s_lock);
 				if (exfat_get_next_cluster(sb, &(clu.dir)))
 					return -EIO;
+				mutex_unlock(&sbi->s_lock);
 
 				num_clusters--;
 				clu.size--;
 			}
+			mutex_lock(&sbi->s_lock);
 		}
 	} else {
 		ei->flags = ALLOC_NO_FAT_CHAIN;
