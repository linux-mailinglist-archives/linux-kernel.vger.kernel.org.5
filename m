Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33F127F32E9
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 16:58:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234847AbjKUP6O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 10:58:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234843AbjKUP6J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 10:58:09 -0500
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C19A1D40
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 07:58:05 -0800 (PST)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-6bd5730bef9so6811307b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 07:58:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700582285; x=1701187085;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Mtd40gvVZOgliZlu2JdNIeTyUfDE7Z/9wGS/OB7/wxc=;
        b=mMjXnsBMppWrVZ/sjrnLm4RnP8anghLkYRmqjDDRs0kIYUBEkNnyaC3P56pXD7P29d
         A8I8+CQQyWXgWlhQCVk/K6xR9nTH5bbKfGiOp0LJCD83ttyvAXKNeOTg4CFgsrjpB7UZ
         SmujbTuD0gbX3idvGZemcoyAEDPcdyiA3ouq6lv/BimA7vRkuH960RM8xdanAeQQ2yq/
         EUfZ/tG3zYIpDJwy78vIbWHiopFKqQDY3mUs/k2Z73cIesCT/W9ghiYX50Eb+uCHpxkC
         Ws4h1WfGWJ2poIKLH9XWi7tfxwNLfkJ1kZ780/B+JeMb75bddTvHdvun+6sr/g8Vxrav
         0p1g==
X-Gm-Message-State: AOJu0YyKGyrRh5wA3YrgevkbsR37Tp6/AFXTFS2FxeviWti9cg5BMOEm
        c62BOWecSyWSubbQ/bbIw3fbMQ2uq9hQaoNMwCkxFfL4Rm8O
X-Google-Smtp-Source: AGHT+IHELjvdHTY2zj4TwvzBjmYjsWI+xOBCOLYeJxvpvDnYxDNJqankuMtl8QGZRNJdh1bCLF9cVLeOAEq8HhRNWKvvoyLJKEAC
MIME-Version: 1.0
X-Received: by 2002:a05:6a00:10c1:b0:690:bc3f:4fe2 with SMTP id
 d1-20020a056a0010c100b00690bc3f4fe2mr1005253pfu.1.1700582285241; Tue, 21 Nov
 2023 07:58:05 -0800 (PST)
Date:   Tue, 21 Nov 2023 07:58:05 -0800
In-Reply-To: <000000000000b0cabf05f90bcb15@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000005f3f6060aabab28@google.com>
Subject: Re: [syzbot] [ntfs3?] general protection fault in ni_readpage_cmpr
From:   syzbot <syzbot+af224b63e76b2d869bc3@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org,
        almaz.alexandrovich@paragon-software.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        neilb@suse.de, ntfs3@lists.linux.dev,
        syzkaller-bugs@googlegroups.com, torvalds@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit 013ff63b649475f0ee134e2c8d0c8e65284ede50
Author: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Date:   Fri Jun 30 12:17:02 2023 +0000

    fs/ntfs3: Add more attributes checks in mi_enum_attr()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14b8bcbf680000
start commit:   1b29d271614a Merge tag 'staging-6.4-rc7' of git://git.kern..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=ac246111fb601aec
dashboard link: https://syzkaller.appspot.com/bug?extid=af224b63e76b2d869bc3
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1241fd03280000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1476e8f3280000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs/ntfs3: Add more attributes checks in mi_enum_attr()

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
