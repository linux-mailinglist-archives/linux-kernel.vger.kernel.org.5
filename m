Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B956E7F6A0B
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 02:12:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbjKXBMR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 20:12:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjKXBMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 20:12:14 -0500
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B94A41BE
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 17:12:21 -0800 (PST)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-6c4ddeb8ce6so1967683b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 17:12:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700788341; x=1701393141;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PRB03y88QGf05ZztmpI+UY19ebOFV2OolNCdYddihNI=;
        b=OYUN2/k8kX0Z+hBWOUNRprOD2Z18OITno0uW6s+3UVsq9ltQLiOtGALV7MctSD2+sw
         hOe5Ubjb5hHyZkZmHrOnkP+kxIixXcqoJu3kpgSyXve9YOGBSjX8L1S4UjsXXB6Vilbj
         US0Dc1vbIob++MGXNCCuO+O4XPY/B/2SO4vNVwsiDRizcDUpm20jKsjnjTaYVulhIaVZ
         jVnreMxgZUosN+2t8foIyxxfVwrfclMJ37PpzqUU9RxnY0LJ+r8LALwdZD6IyFDAeotP
         d3y+RGLbpWkx/a+YIZTu7B+adAtWWGeR52Z9L+3cLzciw+pQokiwIO4Oa3JYkulmpl1y
         m32g==
X-Gm-Message-State: AOJu0YxcBTgBVUVKBJ3N9kRjh1hlkwdKPtt+qOJ2M9zjaJycAQrt3ILZ
        2fqRs7cxbjyKH3yQi5INxF8PsEz0XXtrFijWvOdAH+SMEeCmDOs=
X-Google-Smtp-Source: AGHT+IHlRqSC/KnChVesOsxlQXltggSSXePbrV6Khk08kkbvQzED/kzvZE4tHdbY/2/61csoKUxD1P1tSdoMf1Eq25GsnKUNwTit
MIME-Version: 1.0
X-Received: by 2002:a05:6a00:2d28:b0:6cb:60a2:3a4 with SMTP id
 fa40-20020a056a002d2800b006cb60a203a4mr331027pfb.4.1700788341182; Thu, 23 Nov
 2023 17:12:21 -0800 (PST)
Date:   Thu, 23 Nov 2023 17:12:21 -0800
In-Reply-To: <000000000000fb2f84060ad4da7f@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ea17f4060adba4d9@google.com>
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
index cf92b2433f7a..e6b59cb87769 100644
--- a/fs/ntfs3/index.c
+++ b/fs/ntfs3/index.c
@@ -1905,6 +1905,8 @@ indx_insert_into_buffer(struct ntfs_index *indx, struct ntfs_inode *ni,
 	}
 
 	if (err) {
+		if (err == -ENOMEM || err == -EINVAL)
+			goto out;
 		/*
 		 * Undo critical operations.
 		 */
