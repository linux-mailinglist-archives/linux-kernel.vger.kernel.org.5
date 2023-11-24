Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 900517F75FB
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 15:09:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230470AbjKXOIz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 09:08:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbjKXOIx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 09:08:53 -0500
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F82F1988
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 06:09:00 -0800 (PST)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-6cbca33ad5dso1899137b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 06:09:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700834940; x=1701439740;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8KcPMZCHPGWTD3C6Ux9O3vZed3K2HK6tUPfCZOJMlBQ=;
        b=DEGVOd8EBFqsApDIFtZS6OSutIm8CvFSwKX5Uje+a24OCebMf0RCSWZcMXr2wZYQ9n
         RxgBII1Py96tQ+ZPmg4TultDGxDgcbVVNe6rTa7pVnPz52b0wtIL5NjraQb/ttGvAFow
         5AKxv8T8j64L0knKd22SfN2jasIHtwFzgLdyrc8rOEbdP2S/GBWdJsUM3ADFHtAm7y4c
         EkuAbmNcue00zDeKgAS8PxlSEIO4pBKuYd7wLlcaa3MAga/wgWSg+zdcyS3HIgnwgFue
         WxRX+/w8HEzENOWpto/2CqhnW3ipgJBMRoZKHrdzjXoqTmWPADuRZeP9SkqWcfHv+Ul2
         zb1g==
X-Gm-Message-State: AOJu0YxapSdqBUXSOXshH8bn/CoEkkYXK9/ODki2EY4Inf8/nzhFna27
        7JsxAnIxOwiZUyEgAOMtNhJpGiufvcU3bmagmeWVNe7yxU10MAM=
X-Google-Smtp-Source: AGHT+IFZ9XxIMgsaruRXcpYvWWo+yiwgfPAoUSbUX28VwRYkwhAzyQxf4Bg3ACoHVY5jTCC1UhDZqVvRj2d+QAAdc4GQpLE+y/gB
MIME-Version: 1.0
X-Received: by 2002:a05:6a00:1d82:b0:6cb:457d:cff8 with SMTP id
 z2-20020a056a001d8200b006cb457dcff8mr1631951pfw.3.1700834939969; Fri, 24 Nov
 2023 06:08:59 -0800 (PST)
Date:   Fri, 24 Nov 2023 06:08:59 -0800
In-Reply-To: <000000000000fb2f84060ad4da7f@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006b25a7060ae67eae@google.com>
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
index cf92b2433f7a..92448d922aec 100644
--- a/fs/ntfs3/index.c
+++ b/fs/ntfs3/index.c
@@ -1909,6 +1909,10 @@ indx_insert_into_buffer(struct ntfs_index *indx, struct ntfs_inode *ni,
 		 * Undo critical operations.
 		 */
 		indx_mark_free(indx, ni, new_vbn >> indx->idx2vbn_bits);
+		printk("h1: %s\n", (char *)hdr1);
+		printk("h1s: %s\n", (char *)hdr1_saved);
+		if (!level && err == -ENOMEM)
+			goto out;
 		memcpy(hdr1, hdr1_saved, used1);
 		indx_write(indx, ni, n1, 0);
 	}

