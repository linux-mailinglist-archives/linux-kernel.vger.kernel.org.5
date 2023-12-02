Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13BDC801EAE
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 22:33:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231727AbjLBVdA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 16:33:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjLBVc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 16:32:59 -0500
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com [209.85.161.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FEEBE5
        for <linux-kernel@vger.kernel.org>; Sat,  2 Dec 2023 13:33:05 -0800 (PST)
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-587a58f3346so4203597eaf.1
        for <linux-kernel@vger.kernel.org>; Sat, 02 Dec 2023 13:33:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701552784; x=1702157584;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zKqRgYm0AgRjE4xdVrUEcvGqaGktrF3meejJYcgoL68=;
        b=oUHzmqFRVPBwo7BkhYo/SnUztDkYgHMEtSBBtqUvM+UrvKv+883B6tU4LEbvl/XT4q
         96gn4ZR0fTRLiC7xyqM9nLdYWyXHXJ9JIaaKXzixjYe6ydDVmpUJFPaLremyrlDvqa6K
         BRYV4YVLxBrnRfJkVk5oWUtQfvxPvzfEYWB3u/qgzBFVhXnuX/cVKpouDmnSxmx2K/k9
         aOIhP3Fw6CKFWIgEj3GlOtCGT3MHYy83tP8LDWmFkLWNZFcFxmy33cLt1DOCWt6Tj+rh
         II+JYmUksy18BcGQbY13Xj6SYjl8TaHOGrV0sfnmjROiYsU43VVVFcCXyiPDNSPyjVn5
         aRZw==
X-Gm-Message-State: AOJu0Yzd03tM4mkgXXaHODJNNoWAJW5PBDqSet+ug6Srqt9FD/AHBTTl
        JR6+EBUWyUWaG+FwcW33GMJ80LSMQKpArCcT1Rcu47fCjgMa
X-Google-Smtp-Source: AGHT+IFqucHa4qMk8RwcwCv8DbQzN4BAF0j4cNTlp1+iRF4gCgFVtyQXoYcZ5tycjVuxqOzZsBm5nFDyG77vYxFKL9qzpSe1l8Zl
MIME-Version: 1.0
X-Received: by 2002:a4a:b243:0:b0:58d:6882:9000 with SMTP id
 i3-20020a4ab243000000b0058d68829000mr1032039ooo.0.1701552784595; Sat, 02 Dec
 2023 13:33:04 -0800 (PST)
Date:   Sat, 02 Dec 2023 13:33:04 -0800
In-Reply-To: <000000000000f0bfe70605025941@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004ae32c060b8da1dc@google.com>
Subject: Re: [syzbot] [gfs2?] kernel BUG in gfs2_quota_cleanup
From:   syzbot <syzbot+3b6e67ac2b646da57862@syzkaller.appspotmail.com>
To:     agruenba@redhat.com, eadavis@qq.com, gfs2@lists.linux.dev,
        juntong.deng@outlook.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, rpeterso@redhat.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this issue to:

commit bdcb8aa434c6d36b5c215d02a9ef07551be25a37
Author: Juntong Deng <juntong.deng@outlook.com>
Date:   Sun Oct 29 21:10:06 2023 +0000

    gfs2: Fix slab-use-after-free in gfs2_qd_dealloc

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=169c7b52e80000
start commit:   994d5c58e50e Merge tag 'hardening-v6.7-rc4' of git://git.k..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=159c7b52e80000
console output: https://syzkaller.appspot.com/x/log.txt?x=119c7b52e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c2c74446ab4f0028
dashboard link: https://syzkaller.appspot.com/bug?extid=3b6e67ac2b646da57862
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1268c086e80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=164b3faae80000

Reported-by: syzbot+3b6e67ac2b646da57862@syzkaller.appspotmail.com
Fixes: bdcb8aa434c6 ("gfs2: Fix slab-use-after-free in gfs2_qd_dealloc")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
