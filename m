Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B005F78E3FD
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 02:31:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344982AbjHaAbj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 20:31:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236952AbjHaAbh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 20:31:37 -0400
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com [209.85.210.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD2B2BE
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 17:31:34 -0700 (PDT)
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-6bb23d4b3b7so470539a34.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 17:31:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693441894; x=1694046694;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n+Ys1cwjPfgqv/vEsA4s7A+pElm5Cn9tj91Zioe86LI=;
        b=hJ+yQ8jEmw14tO5b0glMev0w/1TZcbQLl6SZCYiaWJ6qQr1n85FwAk186bT5oKugqs
         9owJ1keXbx+fJPEiw1pswHhL1pWllV8Hr2jj52ieDtGOOwBFa92sIPAiCdnlgXOLSp+w
         jZWMdZ6p0MTvhOBt0tFFZgmlDdGaahmBvayPKD2bQ3focAB0oJpTgY025kQfBu9yygy8
         uolzWWDWJvGtQdlHfUNII8moLFlkI10NEz0ScRJa0GEnw/T55MKAN2sBAVE/UJzPR0fR
         iNxotI52TbIfXYxsWXu06OrpHvTK1ylD08hl6n9vZummiv1wHN/qheOg5ZaWyIn9bE//
         5WkA==
X-Gm-Message-State: AOJu0YzHGxE3pxFlaEQ6kpEQJctUan/41uM/2bk6FNgvuF3MId/FU0Zm
        gFSgHaK6DWcYKo/JeaOY07sm1j8LO8C5xnqZq3NYrzzBhSnU
X-Google-Smtp-Source: AGHT+IH/xFTz4XQxoutjF9VYd71vW+qQX2pv9ulRwbHgizHfCMrd72ah6dGGlmAvpkUjeFfrdGqRibIV1gy5WEuRRlQQHGWoS/Gy
MIME-Version: 1.0
X-Received: by 2002:a9d:4d0e:0:b0:6b9:a422:9f with SMTP id n14-20020a9d4d0e000000b006b9a422009fmr374752otf.1.1693441894159;
 Wed, 30 Aug 2023 17:31:34 -0700 (PDT)
Date:   Wed, 30 Aug 2023 17:31:34 -0700
In-Reply-To: <0000000000009531dc0602016bb0@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008c9d5106042d2abb@google.com>
Subject: Re: [syzbot] [ntfs3?] BUG: unable to handle kernel NULL pointer
 dereference in hdr_find_e (2)
From:   syzbot <syzbot+60cf892fc31d1f4358fc@syzkaller.appspotmail.com>
To:     almaz.alexandrovich@paragon-software.com, astrajoan@yahoo.com,
        ivan.orlov0322@gmail.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ntfs3@lists.linux.dev,
        skhan@linuxfoundation.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=2.4 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_WEB,SORTED_RECIPS,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this issue to:

commit 6e5be40d32fb1907285277c02e74493ed43d77fe
Author: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Date:   Fri Aug 13 14:21:30 2021 +0000

    fs/ntfs3: Add NTFS3 in fs/Kconfig and fs/Makefile

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=151f20a8680000
start commit:   4b954598a47b Merge tag 'exfat-for-6.5-rc5' of git://git.ke..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=171f20a8680000
console output: https://syzkaller.appspot.com/x/log.txt?x=131f20a8680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1e3d5175079af5a4
dashboard link: https://syzkaller.appspot.com/bug?extid=60cf892fc31d1f4358fc
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11ee0aa6a80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=100eaedea80000

Reported-by: syzbot+60cf892fc31d1f4358fc@syzkaller.appspotmail.com
Fixes: 6e5be40d32fb ("fs/ntfs3: Add NTFS3 in fs/Kconfig and fs/Makefile")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
