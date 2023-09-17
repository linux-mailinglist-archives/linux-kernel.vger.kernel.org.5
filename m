Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3314E7A33BF
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Sep 2023 07:00:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231524AbjIQFAJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Sep 2023 01:00:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231608AbjIQE7y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Sep 2023 00:59:54 -0400
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com [209.85.160.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E86D4195
        for <linux-kernel@vger.kernel.org>; Sat, 16 Sep 2023 21:59:47 -0700 (PDT)
Received: by mail-oa1-f69.google.com with SMTP id 586e51a60fabf-1d64f81e0daso4725599fac.0
        for <linux-kernel@vger.kernel.org>; Sat, 16 Sep 2023 21:59:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694926784; x=1695531584;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qhjs5oB6nHi9MI2ElOnnGkx1j5k5OVubLeOM7LmB94I=;
        b=BYzI19CCFdvZl2cg4QNIKRcCrdKZ+48KejGQtRI4HuazfeQ1qDz5us1IeTKFrcFWpu
         +c6ETNeYRK9cMN3pSpnURH2YNjqR0LIqmlnZJQFRFWRXQTYoOuR/WROgpMflbDUXzd8/
         4ADrilpCjBjPTlLLvBMkhsnnIWxpAH330sEqJ65BXiCNvzQYLZWwg6N3yIEULpXvVN7G
         EJy+fK1i/Ikmg2tZIwrjkqZL+BW/qDZD2vlasylpuXOOOGGmuhv1b3RIKCyrhG05bKHU
         BDrJJbFnApq1VjHEjRRFiikUNR1BQhJZtJFabFvNv6FG/M/a7S59TAWMIimBOKIfkW6g
         h6vg==
X-Gm-Message-State: AOJu0YxfD8bD2JynhR3oV9xKmFukiAqgo1CuuiRMQyGjdM66TcVSEMIu
        T9kNU8CG0xKa20XbITBfsyjs+QSANhcqBv+3v7H14oS9O1s0
X-Google-Smtp-Source: AGHT+IEnRt6ieGV5LcPDf5SE4daLegAon37/uUhaCG0SHEvQeQTLeUYVwdxbjdY19HkbVtDc5f8aY7qAsAB0BGRIQuCivmzo2vje
MIME-Version: 1.0
X-Received: by 2002:a05:6870:5155:b0:1d0:ce36:3f0f with SMTP id
 z21-20020a056870515500b001d0ce363f0fmr2193610oak.10.1694926784344; Sat, 16
 Sep 2023 21:59:44 -0700 (PDT)
Date:   Sat, 16 Sep 2023 21:59:44 -0700
In-Reply-To: <00000000000011da7605ffa4d289@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e6b834060586e462@google.com>
Subject: Re: [syzbot] [bluetooth?] BUG: sleeping function called from invalid
 context in hci_cmd_sync_submit
From:   syzbot <syzbot+e7be5be00de0c3c2d782@syzkaller.appspotmail.com>
To:     atul.droid@gmail.com, davem@davemloft.net, edumazet@google.com,
        johan.hedberg@gmail.com, kuba@kernel.org,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        luiz.dentz@gmail.com, luiz.von.dentz@intel.com,
        marcel@holtmann.org, netdev@vger.kernel.org, pabeni@redhat.com,
        rauji.raut@gmail.com, syzkaller-bugs@googlegroups.com
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

commit a13f316e90fdb1fb6df6582e845aa9b3270f3581
Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Date:   Tue Jun 27 00:25:06 2023 +0000

    Bluetooth: hci_conn: Consolidate code for aborting connections

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10885e54680000
start commit:   bd6c11bc43c4 Merge tag 'net-next-6.6' of git://git.kernel...
git tree:       net-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=12885e54680000
console output: https://syzkaller.appspot.com/x/log.txt?x=14885e54680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=634e05b4025da9da
dashboard link: https://syzkaller.appspot.com/bug?extid=e7be5be00de0c3c2d782
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15bd8168680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17f4d048680000

Reported-by: syzbot+e7be5be00de0c3c2d782@syzkaller.appspotmail.com
Fixes: a13f316e90fd ("Bluetooth: hci_conn: Consolidate code for aborting connections")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
