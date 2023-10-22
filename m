Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A122D7D2302
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Oct 2023 13:54:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231678AbjJVLwf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 07:52:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231321AbjJVLwe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 07:52:34 -0400
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com [209.85.161.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4368E112
        for <linux-kernel@vger.kernel.org>; Sun, 22 Oct 2023 04:52:32 -0700 (PDT)
Received: by mail-oo1-f71.google.com with SMTP id 006d021491bc7-581ff5ab8d3so4473667eaf.1
        for <linux-kernel@vger.kernel.org>; Sun, 22 Oct 2023 04:52:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697975551; x=1698580351;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IXk6ipW0WGEi096jxXY2WBNHGYG5TkCETUVTeM32tA0=;
        b=p9RmkTkhKre6IU+rjdKikbMijxls2MrToY2JtXzM8Qep8tUFCQPVeYLr9ftzSRIGR0
         BklNawXtld0dxPnP6WgNBfKjQKNJ3+Vud3dChoDLuVSTP+iCH9agnHSpIsKUtbOTE5XM
         0p6Yh/tC3DKrm/Fvbuq0r55PSdxI32zribklG6/euzCPfOxKEliCiZdNF/RdeCivPxZH
         DgXH2qv03Mdr/5Y506MQ3MXaEWyhd+XIejMj4xwkyO0G89Nn5xd8UkWvEFPwIhP8JIYP
         olUAdYGiG6jNy0MnlqMopmLt97So7Yr1KmnIvcIaKgn5L6fH6sGv2NrhLyqIOfZc5rbr
         yhxg==
X-Gm-Message-State: AOJu0YwF45/xZDgIyNypnrDjHlenT0jnuQMxSlVHZVrR1cuz5kmZPfTK
        g7yyL8lO7QPbdcY7QLGW1CoRspdy/aEJ7xGMHZgHCcWRsZhB
X-Google-Smtp-Source: AGHT+IEvMT+swEq07R5cFoGX9zXWQzPjIfXPkahPbW7Kk4Q7RWNC6vbYiKNsJ9CIG1L3psFE+kMdNeFhLTSurFuYmMgxx1r9D47G
MIME-Version: 1.0
X-Received: by 2002:a05:6871:3308:b0:1e9:e1dd:b953 with SMTP id
 nf8-20020a056871330800b001e9e1ddb953mr2956608oac.1.1697975551329; Sun, 22 Oct
 2023 04:52:31 -0700 (PDT)
Date:   Sun, 22 Oct 2023 04:52:31 -0700
In-Reply-To: <000000000000438c4a06031aff8b@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000930e6f06084cbd43@google.com>
Subject: Re: [syzbot] [kernel?] INFO: rcu detected stall in schedule (6)
From:   syzbot <syzbot+77195ae75047f1438785@syzkaller.appspotmail.com>
To:     davem@davemloft.net, edumazet@google.com, hdanton@sina.com,
        jiri@nvidia.com, kuba@kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, pabeni@redhat.com, peterz@infradead.org,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de
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

commit c2368b19807affd7621f7c4638cd2e17fec13021
Author: Jiri Pirko <jiri@nvidia.com>
Date:   Fri Jul 29 07:10:35 2022 +0000

    net: devlink: introduce "unregistering" mark and use it during devlinks iteration

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12ed7a99680000
start commit:   a785fd28d31f Merge tag 'for-6.5-rc5-tag' of git://git.kern..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=11ed7a99680000
console output: https://syzkaller.appspot.com/x/log.txt?x=16ed7a99680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3e670757e16affb
dashboard link: https://syzkaller.appspot.com/bug?extid=77195ae75047f1438785
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15ec36ada80000

Reported-by: syzbot+77195ae75047f1438785@syzkaller.appspotmail.com
Fixes: c2368b19807a ("net: devlink: introduce "unregistering" mark and use it during devlinks iteration")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
