Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B99497B3AC8
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 21:45:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233834AbjI2Tp0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 15:45:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232985AbjI2TpZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 15:45:25 -0400
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com [209.85.160.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EF43B4
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 12:45:20 -0700 (PDT)
Received: by mail-oa1-f69.google.com with SMTP id 586e51a60fabf-1d66b019a27so30652939fac.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 12:45:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696016719; x=1696621519;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uOUbdmuYhfXA8PXd4YARC5tF6kjo7P/y7HVDRuq7ymQ=;
        b=VO5aehqLYa5nzHmoTnh8DZVd1pfVI6BaCdWy0t26JI8ADpWTvrkurx1zQUJS9jtKqn
         MwYepwVd8+w/r7D5YsR+cD47JiOEAdtlgnfbTGRlg6CybHFOLsk4zS2+Uf2+1v9ycWRW
         v4B+nzw4gPCy0orlx5FO+EcIVQtpINVowM1Qbmva1mKrQyKnIaaSGIKSvk/BLA1IiRtG
         g0PJD4xIgopaH3RG9TzDRkwUSfWqnr5WViVsw4zpVhIZ1fNosdEgWXbcxSmiYfvbWqRx
         PyXp/AXD/bi24imC6YEA4YrWZYgjRCsy3mXuGOat6cS2yAypYYZ5Tl/VURTI7LGF33Qx
         ZedA==
X-Gm-Message-State: AOJu0Yy6ym75koutkfBKAfBuTM9BaQox4Ju6R5S9bQ+QlcpIrOC8Hjik
        a054V0Lds2l+NyLH+3DKm2MN/+/GEbJZ3byCP+yf1IO5azey
X-Google-Smtp-Source: AGHT+IFYMqItjJEVGHOIHmUPeuMNaMxy8KqwKD+rwjOwwTOlXsRSXiwCv6oua1+5pQPktR4BQVSd+yRH6/cIOImXUzqYibBfr/5x
MIME-Version: 1.0
X-Received: by 2002:a05:6870:98ae:b0:1b0:9643:6f69 with SMTP id
 eg46-20020a05687098ae00b001b096436f69mr1969651oab.4.1696016719665; Fri, 29
 Sep 2023 12:45:19 -0700 (PDT)
Date:   Fri, 29 Sep 2023 12:45:19 -0700
In-Reply-To: <00000000000021dc2806031ad901@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001be691060684aa2c@google.com>
Subject: Re: [syzbot] [wireguard?] INFO: rcu detected stall in
 wg_ratelimiter_gc_entries (2)
From:   syzbot <syzbot+c1cc0083f159b67cb192@syzkaller.appspotmail.com>
To:     Jason@zx2c4.com, daniel.wippermann@resol.de, davem@davemloft.net,
        edumazet@google.com, hdanton@sina.com, jason@zx2c4.com,
        jhs@mojatatu.com, jiri@nvidia.com, kuba@kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        pabeni@redhat.com, pctammela@mojatatu.com,
        syzkaller-bugs@googlegroups.com, victor@mojatatu.com,
        vladimir.oltean@nxp.com, wireguard@lists.zx2c4.com
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

syzbot suspects this issue was fixed by commit:

commit da71714e359b64bd7aab3bd56ec53f307f058133
Author: Jamal Hadi Salim <jhs@mojatatu.com>
Date:   Tue Aug 22 10:12:31 2023 +0000

    net/sched: fix a qdisc modification with ambiguous command request

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=129c464e680000
start commit:   8a519a572598 net: veth: Page pool creation error handling ..
git tree:       net
kernel config:  https://syzkaller.appspot.com/x/.config?x=3e670757e16affb
dashboard link: https://syzkaller.appspot.com/bug?extid=c1cc0083f159b67cb192
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=129f8553a80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1205baada80000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: net/sched: fix a qdisc modification with ambiguous command request

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
