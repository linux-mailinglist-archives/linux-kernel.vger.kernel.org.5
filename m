Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73F6A7EA8AE
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 03:18:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231651AbjKNCSD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 21:18:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbjKNCSC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 21:18:02 -0500
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39CAEF3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 18:18:00 -0800 (PST)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-5b7fb057153so6022050a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 18:18:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699928280; x=1700533080;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8IQBKmMVHldNmqwsu1FOhAa3LFwsAemxqs/7UxPZ5rQ=;
        b=fNOMR9YGA2SyydsPWMh2DLeGGEKhQ7xIMFLAVtzZOTnaXh+fG8FH/HLwoW5AORg80W
         cDe7t7lVRRwVAGjf65k5vB8bM/3VgC2iiDgoGGiCjIhvXn4qT1NpLDcOy+8/WiqFc4yB
         GCr0uTnJFiXSs+UwKeYCHhDvnx6K2Xsk9e8UWxO2xJiJfkibCGP97BEDFbLcTpKe2/ah
         M1W6ixg2VvxV9dqEw6j/DhvM5LewHP90sgwb/56X4eTVwShIFWN6KZonlHdPILTChhdA
         Ii2fMxJ7hMab+pXmFzyFUMTSTyZUfBm2uck6UXQAIh9o9AjnT1RUkE91mjjjguAT/dDO
         UWIQ==
X-Gm-Message-State: AOJu0YzUVubbjuaH3DDwUQbtaxvVzGQDsRITQ+qddAVYcZEawUVwXedT
        Rk3h3HtgJid2DoeBSC5wrEOQBa4pkeWey2ke2bMLOeV3zbCY5xI=
X-Google-Smtp-Source: AGHT+IFciV0KAGsBwG8Ae+V1FhtbDkGvyebLRU3JNX8mqi/2UfqSK/ThqDjrCWEPL+FQw96D+H9pPAKKW33KYCVZZ7DBrffQEfP6
MIME-Version: 1.0
X-Received: by 2002:a63:4142:0:b0:585:6402:41e4 with SMTP id
 o63-20020a634142000000b00585640241e4mr216050pga.7.1699928279838; Mon, 13 Nov
 2023 18:17:59 -0800 (PST)
Date:   Mon, 13 Nov 2023 18:17:59 -0800
In-Reply-To: <000000000000ae5995060a125650@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000437473060a1365b7@google.com>
Subject: Re: [syzbot] [PATCH] Test np in autofs_fill_super
From:   syzbot <syzbot+662f87a8ef490f45fa64@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
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

Subject: [PATCH] Test np in autofs_fill_super
Author: eadavis@qq.com

please test null ptr in autofs_fill_super

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 4bbdb725a36b

diff --git a/fs/autofs/inode.c b/fs/autofs/inode.c
index a5083d447a62..f2e89a444edf 100644
--- a/fs/autofs/inode.c
+++ b/fs/autofs/inode.c
@@ -331,6 +331,9 @@ static int autofs_fill_super(struct super_block *s, struct fs_context *fc)
 		goto fail;
 
 	root_inode = autofs_get_inode(s, S_IFDIR | 0755);
+	if (!root_inode)
+		goto fail;
+
 	root_inode->i_uid = ctx->uid;
 	root_inode->i_gid = ctx->gid;
 

