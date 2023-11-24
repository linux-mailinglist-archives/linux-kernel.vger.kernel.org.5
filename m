Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA39B7F6AC1
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 03:51:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbjKXCvA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 21:51:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjKXCu6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 21:50:58 -0500
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A408A2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 18:51:05 -0800 (PST)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-5c1bfc5066aso1264353a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 18:51:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700794265; x=1701399065;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZT7/1Extjw+CWr0c9tbkooCQtoL7AbWNS9SN/d77Bns=;
        b=JlIZKfDVw1Xsq3umnxMvu8ol763gqIMJepbhyjZ3G1/k+brafxb1GIvVVk96quk6J2
         8oVVLJK/+cji5axcTShAzbD3Rkv9dN++8+SErjI4UMdF7yT5kB4chXoXzEsutF/jzYbC
         NKzDAq65ZDcDYSFjSHaPehgoQXpHx1yI0mHAs7rfiALV1Nea/GmRBXGSEMACy+BMZsx7
         1XvyDC3Iugojkajw3mTEgX2U0UebPOlknptDTPJM2ARj6xSfd4hDNbfdWA9bn50u73hy
         OhK4Eojyl6jvaSxrfH2tnf+J4BExs1zuMP58nAL1Aglj5YQfAsCTaPkPnvKOy478u6gw
         2qKA==
X-Gm-Message-State: AOJu0YwkLlGQvQeP0jZvk6Ar5yt41Yxui2H4AnXBUauVGSnugz/J0bAJ
        xJYwJKgRzlGsKFnb83yfBYrd2xQ2RvjxZxGuTjbIpay4U+SMzZE=
X-Google-Smtp-Source: AGHT+IFmiTmxHQzoO3x2h2r0uTKDc/wg4I3LFGVjgQWq3V6HMsujGvrYtdgzdHgEPd4sOGjMPwZlkX40RcT4ri0AOjv4UDyLzYyJ
MIME-Version: 1.0
X-Received: by 2002:a63:4749:0:b0:5bd:bf22:2b8b with SMTP id
 w9-20020a634749000000b005bdbf222b8bmr199289pgk.4.1700794264883; Thu, 23 Nov
 2023 18:51:04 -0800 (PST)
Date:   Thu, 23 Nov 2023 18:51:04 -0800
In-Reply-To: <000000000000fb2f84060ad4da7f@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000feec07060add05ad@google.com>
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
Author: lizhi.xu@windriver.com

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 037266a5f723

diff --git a/fs/ntfs3/index.c b/fs/ntfs3/index.c
index cf92b2433f7a..a2fe5458d41c 100644
--- a/fs/ntfs3/index.c
+++ b/fs/ntfs3/index.c
@@ -1905,6 +1905,8 @@ indx_insert_into_buffer(struct ntfs_index *indx, struct ntfs_inode *ni,
 	}
 
 	if (err) {
+		if (used1 > le32_to_cpu(hdr1->used))
+			used1 = le32_to_cpu(hdr1->used);
 		/*
 		 * Undo critical operations.
 		 */
