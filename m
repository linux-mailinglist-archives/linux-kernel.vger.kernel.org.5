Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA04C78CFB6
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 00:58:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239978AbjH2W5j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 18:57:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241067AbjH2W52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 18:57:28 -0400
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68533139
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 15:57:26 -0700 (PDT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-26f2dfb1fdbso5788716a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 15:57:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693349846; x=1693954646;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cAx6PSOlRe1SoOmdVLTfSTqRq8XYYm/GJtA05ydLXZQ=;
        b=bmQcpiiBmrdsRrFcsiPgHKAC4CHWLSW+oTKZZM/FSQtD3rgw8knnrCVbe4gGG6ip4j
         50bTXwUyt6TP/ZrSZumTELUK7Q+9sHwjp2Fkp0H/P/gc9IRWBSWn0JdJSJmtEgu/Sm0K
         /IL0cVD/4kuJ2os/X9jv+bXKe5YN5ZvVQ8gngCoL5gIQVsvkf4oguDnvP+S1iLayhoX5
         BSPWiQhjdhWH2MJX2kIpyU5vgPNhkKV8cQDkGsCn5XaOsSQWicd0SWUo8CZIeYXyY82q
         +iQlvr1sSYQNhIWzafjDU5mMeohrGSacAnYvTVt0DUfNnJivBBva1VdVhYlUMfGPvS8c
         1iwg==
X-Gm-Message-State: AOJu0Yx0dCEBP6VIYggEULoS003kaHVCn+jFAmruIdGg0Gd/Dyxj4TM8
        8kGbQNQfE6qo9nSq4DACFLtrp8xwwWWbotc2FV5rDX1FI+he
X-Google-Smtp-Source: AGHT+IEzdCowiZmXUDDhkbYINfZE/r+09JEfRrBJG3TV1PZiXW7dTgVeIl0Jj6WsJu8Hs/EFNhtwmwBtC0shQ2WpNjmc8DS1vxGs
MIME-Version: 1.0
X-Received: by 2002:a17:90a:c908:b0:268:5c5d:25cf with SMTP id
 v8-20020a17090ac90800b002685c5d25cfmr153388pjt.4.1693349845961; Tue, 29 Aug
 2023 15:57:25 -0700 (PDT)
Date:   Tue, 29 Aug 2023 15:57:25 -0700
In-Reply-To: <00000000000017ad3f06040bf394@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000c97a4060417bcaf@google.com>
Subject: Re: [syzbot] [net] INFO: rcu detected stall in sys_close (5)
From:   syzbot <syzbot+e46fbd5289363464bc13@syzkaller.appspotmail.com>
To:     brauner@kernel.org, davem@davemloft.net, edumazet@google.com,
        eric.dumazet@gmail.com, gautamramk@gmail.com, hdanton@sina.com,
        jhs@mojatatu.com, jiri@resnulli.us, kuba@kernel.org,
        lesliemonis@gmail.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, mohitbhasi1998@gmail.com,
        netdev@vger.kernel.org, pabeni@redhat.com, sdp.sachin@gmail.com,
        syzkaller-bugs@googlegroups.com, tahiliani@nitk.edu.in,
        viro@zeniv.linux.org.uk, vsaicharan1998@gmail.com,
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

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=101bb718680000
start commit:   727dbda16b83 Merge tag 'hardening-v6.6-rc1' of git://git.k..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=121bb718680000
console output: https://syzkaller.appspot.com/x/log.txt?x=141bb718680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=45047a5b8c295201
dashboard link: https://syzkaller.appspot.com/bug?extid=e46fbd5289363464bc13
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14780797a80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17c1fc9fa80000

Reported-by: syzbot+e46fbd5289363464bc13@syzkaller.appspotmail.com
Fixes: ec97ecf1ebe4 ("net: sched: add Flow Queue PIE packet scheduler")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
