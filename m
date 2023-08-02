Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4453B76D023
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 16:35:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233978AbjHBOfh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 10:35:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233854AbjHBOfd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 10:35:33 -0400
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com [209.85.210.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3329419B0
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 07:35:32 -0700 (PDT)
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-6b9f057f6daso12519581a34.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Aug 2023 07:35:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690986931; x=1691591731;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kMzVnXoXwmrDEP/EBdZT0/0KvQJuotKfTHODxNRgwrQ=;
        b=DMueAPYpyF0hRlizoy31yhc7Nq+12KO2Hqi0AM0UlTqa67SSUzvCefGOhn0yZ3g9f6
         DqpQA0dghktV1Dfwh4pw6Io8eWnsjgRTR4cncgz1v314T2H8ony5QNKBcdFj3vELofLe
         8ypFRj9rupDOnIXKR6r2bzEDRr7Tw8udh0puUaqlKmIFhcZ5kOvr9axsAPDovmknT0Bc
         msr9rzpBgchU2mkKuzFKpe+ACAKSPKOsM5UHnKp72eH4yVv5zHEKH4NG4Yz8pS72It4k
         m8E+F3d2E11nrAZIPkTXviTaFgugWPbERWrqZtXWlN4fzmh2mIm8IxuY8e5YNWv5UiQe
         MXYQ==
X-Gm-Message-State: ABy/qLaj2VjJpgWhZqKSswYOyL85+zBQgJJJOHhKBicESrhwUWAwxK9X
        4WNnRvTahQF20hDAW9L6FhPb8cXKcIHBBvVuM7rUFijTEa+z
X-Google-Smtp-Source: APBJJlFzh1WWYcMl7B/lP9jcvknVyu6XVG3DLcNWnDU6HKWjBszAOCCUF9w3ZlWwsVd4D1WBmvjV8y+rzl9+7AJJQDJVNiDRbtHu
MIME-Version: 1.0
X-Received: by 2002:a9d:7b59:0:b0:6b7:4ec4:cbb1 with SMTP id
 f25-20020a9d7b59000000b006b74ec4cbb1mr16261534oto.7.1690986931595; Wed, 02
 Aug 2023 07:35:31 -0700 (PDT)
Date:   Wed, 02 Aug 2023 07:35:31 -0700
In-Reply-To: <000000000000672c810601db3e84@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000060bb2a0601f1936f@google.com>
Subject: Re: [syzbot] [btrfs?] kernel BUG in btrfs_cancel_balance
From:   syzbot <syzbot+d6443e1f040e8d616e7b@syzkaller.appspotmail.com>
To:     clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this issue to:

commit b19c98f237cd76981aaded52c258ce93f7daa8cb
Author: Josef Bacik <josef@toxicpanda.com>
Date:   Fri Jun 23 05:05:41 2023 +0000

    btrfs: fix race between balance and cancel/pause

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12223eb9a80000
start commit:   5d0c230f1de8 Linux 6.5-rc4
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=11223eb9a80000
console output: https://syzkaller.appspot.com/x/log.txt?x=16223eb9a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1e3d5175079af5a4
dashboard link: https://syzkaller.appspot.com/bug?extid=d6443e1f040e8d616e7b
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1167e711a80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16a90161a80000

Reported-by: syzbot+d6443e1f040e8d616e7b@syzkaller.appspotmail.com
Fixes: b19c98f237cd ("btrfs: fix race between balance and cancel/pause")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
