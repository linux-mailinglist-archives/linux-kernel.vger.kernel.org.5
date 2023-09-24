Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E91497AC7A1
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 12:59:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbjIXK70 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 06:59:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjIXK7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 06:59:25 -0400
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com [209.85.160.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 515FC103
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 03:59:18 -0700 (PDT)
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-1bf2e81ce63so9892873fac.1
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 03:59:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695553157; x=1696157957;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Jlk+O3J+o0kkp1OKytTuo5mn2nF+ogupL5uOl8zcGuA=;
        b=Yr03ydFDBVJKlxejOCEMrBiZnWhqejCbs01cHS7tZhgZbovnLs34rdfHVuSXh28r9I
         mU5XCYKeCmzZJVC4LDVkGlyqNzPVbXi0w7OVXpXGD/QuGWRqz95bPPKefG89o4/Uwlxa
         3sZojTQYL4Wu15K9UhxI8OqI5wiPlQpJ0PvrtGKctyrHbwRPVkiay1NvPwUN6G5Vub1p
         3KEIJX+upbkiSrsPmEmyPMp1kV1ThbAuuukJuJvdJL69Mdxf36jM3OBeL02gaDfE7tMH
         KU4MCa8lhWVCCVMT/XCsr1aOjoTW6JjeDef7PB4w+kIdraN3XQqmK5ysgxQKTW1RRX+z
         fbeA==
X-Gm-Message-State: AOJu0YxAvc1IBjokXIDuuYvLSqnvsxQRu+ZobfJ5g0JP2qHtOAwHYQ71
        8CZlAUiTLxLnighyBv89r1yV+KidbkgYahnMzdgYtqRrXwVb
X-Google-Smtp-Source: AGHT+IGp8vx1D9jMEB/i7wblpIR1qbSKkkYzRnZBs6mxLXQ6LjSZuwUrXWRzpxMUsQ4CTqUu0G4qMtnatkOXoDUjowcVzPeX9afh
MIME-Version: 1.0
X-Received: by 2002:a05:6870:9a93:b0:1d6:a9da:847 with SMTP id
 hp19-20020a0568709a9300b001d6a9da0847mr2947177oab.0.1695553157625; Sun, 24
 Sep 2023 03:59:17 -0700 (PDT)
Date:   Sun, 24 Sep 2023 03:59:17 -0700
In-Reply-To: <0000000000000c439a05daa527cb@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a87e66060618bb7e@google.com>
Subject: Re: [syzbot] [netfilter?] INFO: rcu detected stall in gc_worker (3)
From:   syzbot <syzbot+eec403943a2a2455adaa@syzkaller.appspotmail.com>
To:     bpf@vger.kernel.org, coreteam@netfilter.org, davem@davemloft.net,
        dvyukov@google.com, edumazet@google.com, fw@strlen.de,
        gautamramk@gmail.com, hdanton@sina.com, jhs@mojatatu.com,
        jiri@resnulli.us, kadlec@netfilter.org, kuba@kernel.org,
        lesliemonis@gmail.com, linux-kernel@vger.kernel.org,
        mohitbhasi1998@gmail.com, netdev@vger.kernel.org,
        netfilter-devel@vger.kernel.org, pabeni@redhat.com,
        pablo@netfilter.org, paulmck@kernel.org, sdp.sachin@gmail.com,
        syzkaller-bugs@googlegroups.com, tahiliani@nitk.edu.in,
        tglx@linutronix.de, vsaicharan1998@gmail.com,
        xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this issue to:

commit ec97ecf1ebe485a17cd8395a5f35e6b80b57665a
Author: Mohit P. Tahiliani <tahiliani@nitk.edu.in>
Date:   Wed Jan 22 18:22:33 2020 +0000

    net: sched: add Flow Queue PIE packet scheduler

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15c5748e680000
start commit:   d4a7ce642100 igc: Fix Kernel Panic during ndo_tx_timeout c..
git tree:       net
final oops:     https://syzkaller.appspot.com/x/report.txt?x=17c5748e680000
console output: https://syzkaller.appspot.com/x/log.txt?x=13c5748e680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=77b9a3cf8f44c6da
dashboard link: https://syzkaller.appspot.com/bug?extid=eec403943a2a2455adaa
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1504b511a80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=137bf931a80000

Reported-by: syzbot+eec403943a2a2455adaa@syzkaller.appspotmail.com
Fixes: ec97ecf1ebe4 ("net: sched: add Flow Queue PIE packet scheduler")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
