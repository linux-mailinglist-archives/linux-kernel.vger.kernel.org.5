Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91F09779EB1
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 11:51:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236739AbjHLJv3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 05:51:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjHLJv1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 05:51:27 -0400
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 433F1AF
        for <linux-kernel@vger.kernel.org>; Sat, 12 Aug 2023 02:51:31 -0700 (PDT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-26b06bb1972so2870848a91.0
        for <linux-kernel@vger.kernel.org>; Sat, 12 Aug 2023 02:51:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691833891; x=1692438691;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QR7Jc1vXxo0aDPQdMwxp89Yuch6sITXUZ93/IQ44yYs=;
        b=AetHYcqZlLZY3ZC1VvKROP2GZZLvUsnhbmtgcHZeGG/BXsIfx9TyNxAkxqqOPqJ17L
         o0BSIcrEirfvsKN0uAn0cqVN4bCwGvM2xJAzSLVHo2AYbh7MdVEPC3OvulcQhJ/4Jgx5
         zhg34JyHvwDlyl4dkZyya9i1eLSQeZLB2cOVKppL7BPfXDnbt8XZcNR3ajRo/jUR9jsd
         x8zMFoFuwCTZv7wNlQcSdo/JJnnQh/XsLv/9X9bBtmlhYQ6UAnuzN6tI6kQP+heGzQan
         sEwns3X4ayrBSCwU00nz8rrSM7iOzSg3Ip4T3Fk5/sS/OBKyKAN1Cb6o5Jzl7t9P6UQ1
         3TDw==
X-Gm-Message-State: AOJu0Yzjk8yTDwGQuqQIeftbpL6OcB3IWcKo6H6nptN+xcvswKlr0Blp
        Zl4NAeSdZ/kjweDMXUKjdKcSHd+SagnfCAZZu4+sQms0Iq5C
X-Google-Smtp-Source: AGHT+IHALHpoCwhShDFEGgDOt2ZbFeaOEdtaxOTMKph4e5BOl1uedD/sil3YuojOjSpfvCPW6fWCTC9sNw3JkwTgnRhMhksgWyTb
MIME-Version: 1.0
X-Received: by 2002:a17:90a:f0c4:b0:268:5919:a271 with SMTP id
 fa4-20020a17090af0c400b002685919a271mr936991pjb.8.1691833890791; Sat, 12 Aug
 2023 02:51:30 -0700 (PDT)
Date:   Sat, 12 Aug 2023 02:51:30 -0700
In-Reply-To: <0000000000007c27e105faa4aa99@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000014678c0602b6c643@google.com>
Subject: Re: [syzbot] [usb?] KASAN: slab-use-after-free Write in usb_anchor_suspend_wakeups
From:   syzbot <syzbot+d6b0b0ea0781c14b2ecf@syzkaller.appspotmail.com>
To:     arnd@arndb.de, christian.brauner@ubuntu.com,
        gregkh@linuxfoundation.org, hdanton@sina.com,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        mpe@ellerman.id.au, oleg@redhat.com,
        syzkaller-bugs@googlegroups.com, web@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this issue to:

commit 9b4feb630e8e9801603f3cab3a36369e3c1cf88d
Author: Christian Brauner <christian.brauner@ubuntu.com>
Date:   Fri May 24 09:31:44 2019 +0000

    arch: wire-up close_range()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1323329ba80000
start commit:   89d77f71f493 Merge tag 'riscv-for-linus-6.4-mw1' of git://..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=10a3329ba80000
console output: https://syzkaller.appspot.com/x/log.txt?x=1723329ba80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d963e7536cbe545e
dashboard link: https://syzkaller.appspot.com/bug?extid=d6b0b0ea0781c14b2ecf
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11471b84280000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10b98e2c280000

Reported-by: syzbot+d6b0b0ea0781c14b2ecf@syzkaller.appspotmail.com
Fixes: 9b4feb630e8e ("arch: wire-up close_range()")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
