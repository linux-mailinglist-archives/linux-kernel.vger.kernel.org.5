Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 365BC811E74
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 20:15:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442042AbjLMTO7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 14:14:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233779AbjLMTO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 14:14:58 -0500
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59095CF
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 11:15:04 -0800 (PST)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-5be39dea00dso2827989a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 11:15:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702494904; x=1703099704;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P+qA+3s/ioGOJ3uxe2remjMWpiOFwkSY74KtXvjignU=;
        b=h3tOUJeETMOhNZT3vIvWM+kZPvwIOrDy5sZReY6pn1sp8Mh9/8f9iS3LCaLjNODBPu
         PkuZs3IATH9xiDLrZk4MhK4pWiDtv/c3DDnraB7ECQpl8ArkizHdxy4diKnoEm2MzwAZ
         xBOR8sL7rYL86x8kXKO/sxPUGBs+0He8nExjEpO8UrwtSgtKEpOwOuj8I8pYlver7OnE
         2gyOa+cL6WAW7hhPSa19p49FWzyUrL7/IE0CpvsB182DjztteZw8/QR+kIQ1jahqtepR
         KCt2lo32L602gShSN/pBj9Snwn9F4dxpc3K1IVKat7U2VclaMfLGHjJ8GLfOj/G2+aSi
         ukog==
X-Gm-Message-State: AOJu0Yx+T7+fa2I0/QOsunG9DPUa0Cs4K3lrN4o+1QwYfXq2WUTfLjAh
        ZR1ZmhTRe3oD/0QnDSqz95qcjXl/TgZ7UXGJ7vYDA97H5SOS
X-Google-Smtp-Source: AGHT+IHBMQwvlrMxR7i+6p1V4vI9Tfpi3BvMvOp82p8mZb0GiGk6YjOqZFMXqwV63GJQQo5TKhZ8D8Ggu99JrTwyA+M1hWIlSDRr
MIME-Version: 1.0
X-Received: by 2002:a17:903:32c8:b0:1d0:902c:e834 with SMTP id
 i8-20020a17090332c800b001d0902ce834mr487525plr.12.1702494903910; Wed, 13 Dec
 2023 11:15:03 -0800 (PST)
Date:   Wed, 13 Dec 2023 11:15:03 -0800
In-Reply-To: <000000000000169326060971d07a@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fac6ee060c68fb16@google.com>
Subject: Re: [syzbot] [btrfs?] kernel BUG in __extent_writepage_io
From:   syzbot <syzbot+06006fc4a90bff8e8f17@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, clm@fb.com, dsterba@suse.com, hch@lst.de,
        josef@toxicpanda.com, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        senozhatsky@chromium.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=2.3 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_WEB,SORTED_RECIPS,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this issue to:

commit 95848dcb9d676738411a8ff70a9704039f1b3982
Author: Christoph Hellwig <hch@lst.de>
Date:   Sat Aug 5 05:55:37 2023 +0000

    zram: take device and not only bvec offset into account

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1325355ce80000
start commit:   eaadbbaaff74 Merge tag 'fuse-fixes-6.7-rc6' of git://git.k..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=10a5355ce80000
console output: https://syzkaller.appspot.com/x/log.txt?x=1725355ce80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=53ec3da1d259132f
dashboard link: https://syzkaller.appspot.com/bug?extid=06006fc4a90bff8e8f17
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12cc9deae80000

Reported-by: syzbot+06006fc4a90bff8e8f17@syzkaller.appspotmail.com
Fixes: 95848dcb9d67 ("zram: take device and not only bvec offset into account")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
