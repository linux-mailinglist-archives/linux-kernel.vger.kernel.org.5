Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7ABC7EBC6E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 04:55:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234379AbjKODyL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 22:54:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjKODyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 22:54:09 -0500
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90EAED9
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 19:54:06 -0800 (PST)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-5b9344d72bbso7800255a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 19:54:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700020446; x=1700625246;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l61plfqF5nHarfz7jpK6i+deFeBGlZF1Gciyjaej1pU=;
        b=jZWaBQXbrjiAwnzXr88TFaRb94PJbB+e3BdcEWpjCdcM0cHFPjwKv1IrHNYgUTLv6P
         IkhhN+B5xMDQcQYtKVBSDzsxW5RmAezrXCKy3CX8vNgF8rsJStrvW2njU6ZD+3qnaiKC
         4HiTojVogdI8fTXUQqPSGDaejf54cRtlDIzxWOei0DBp8rVdoZpI7dxlwQbLDcH91/Zt
         mjF0nxBVdMTSMdO7v0UF697bcgyKHsPItzlVAuxkMxFwiGpM1MQhSWAvUp6GwbAXjfZO
         M9kw+TOabaPlqsoB7NRPLK/bzt0wMVTLv5/E5nlnkGw8CmICTH+qpFR+sOiqMqTQzaWS
         IFjQ==
X-Gm-Message-State: AOJu0YyKZe0Jv6A/cxgjuc+WFXRVJnRB0pdlZ8cpekXzM+/ZNkXWvtTc
        w0j664i4Buv6dPg7HvxnPsXs+LUwAJB13TDEBVB/HnA6vBGb
X-Google-Smtp-Source: AGHT+IF7oCUwCwgZD8xczyFHrZBrkFObiOTryGSeBv2U1eTP1+U0YLkF1/pd5Ws0MaLMfr04sNagBgqsvJlTEqQVYDltsdAuSXeY
MIME-Version: 1.0
X-Received: by 2002:a65:40c3:0:b0:5b9:63f2:e4cc with SMTP id
 u3-20020a6540c3000000b005b963f2e4ccmr1080000pgp.2.1700020446008; Tue, 14 Nov
 2023 19:54:06 -0800 (PST)
Date:   Tue, 14 Nov 2023 19:54:05 -0800
In-Reply-To: <0000000000008981d905ffa345de@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000cb9c3d060a28dad8@google.com>
Subject: Re: [syzbot] [can?] possible deadlock in j1939_sk_errqueue (2)
From:   syzbot <syzbot+1591462f226d9cbf0564@syzkaller.appspotmail.com>
To:     arnd@arndb.de, astrajoan@yahoo.com,
        bridge@lists.linux-foundation.org, davem@davemloft.net,
        dvyukov@google.com, edumazet@google.com, hdanton@sina.com,
        ivan.orlov0322@gmail.com, kernel@pengutronix.de, kuba@kernel.org,
        linux-can@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux@rempel-privat.de, mkl@pengutronix.de,
        mudongliangabcd@gmail.com, netdev@vger.kernel.org,
        nikolay@nvidia.com, o.rempel@pengutronix.de, pabeni@redhat.com,
        robin@protonic.nl, roopa@nvidia.com, skhan@linuxfoundation.org,
        socketcan@hartkopp.net, stephen@networkplumber.org,
        syzkaller-bugs@googlegroups.com, syzkaller@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this issue to:

commit 2030043e616cab40f510299f09b636285e0a3678
Author: Oleksij Rempel <o.rempel@pengutronix.de>
Date:   Fri May 21 11:57:20 2021 +0000

    can: j1939: fix Use-after-Free, hold skb ref while in use

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1438c947680000
start commit:   1b907d050735 Merge tag '6.7-rc-smb3-client-fixes-part2' of..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1638c947680000
console output: https://syzkaller.appspot.com/x/log.txt?x=1238c947680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=88e7ba51eecd9cd6
dashboard link: https://syzkaller.appspot.com/bug?extid=1591462f226d9cbf0564
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17fea8fb680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1633dc70e80000

Reported-by: syzbot+1591462f226d9cbf0564@syzkaller.appspotmail.com
Fixes: 2030043e616c ("can: j1939: fix Use-after-Free, hold skb ref while in use")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
