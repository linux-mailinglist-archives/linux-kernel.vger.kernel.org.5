Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F22EF7FCB23
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 00:57:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376658AbjK1X5A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 18:57:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345005AbjK1X47 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 18:56:59 -0500
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64695198D
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 15:57:05 -0800 (PST)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-1cfc42c748eso33125805ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 15:57:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701215825; x=1701820625;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vN2Ir+Y4JmS/bZdrwe9hRvn9LSobTrbuzI+1V9ZVUoI=;
        b=MlEtP165QUTa+Vqv4TOkdX8Yy6y4s535BWvPvhtZzY8TE2MfbDXyZJKXHt26T3Awc9
         66Q64TjpEuNajUeOOxtaeBK0re4V4/id9FrHg/+axkVlq5UaDnBpJJuE1A2dcsWpbdK9
         /ETzzfRIolln7TKyCD3vZp9iWVb3PuP6++Ib+r/xDXZrg20J3cuw4Mmnckj6M2GENFXA
         qi0voGc7Lpli4X73f1ARkcIBkq2h4JQaInCPEVyaPYGBY7S8tNGufNpWf/yz2KwFq4FZ
         NHigVXlAjXQdeQ7MUTViu+aH6x0jQE7VO/Ybs1VWmepVD6Gfi3eL6s1yKcwZtza1kfJg
         TV+Q==
X-Gm-Message-State: AOJu0YxGPQZ7WsO0SlC2ZYngWwluJlsFXPLbSaWzpo3zd93ikLSI04nB
        tNzjv268lZZzmAqPrvK4rLoqfcw3EdFIKGj21avpkGgasEnS
X-Google-Smtp-Source: AGHT+IEBmKxuYKtQ/S0w/Sxr+C51n7BNjuA3UdTFIXPrhy6pf4y+36y7PctlYRTxRWgVazDQbWRHjB0qaDOjWNcdvHmORUl52cwI
MIME-Version: 1.0
X-Received: by 2002:a17:903:4282:b0:1cc:2f2a:7d33 with SMTP id
 ju2-20020a170903428200b001cc2f2a7d33mr3456055plb.2.1701215825023; Tue, 28 Nov
 2023 15:57:05 -0800 (PST)
Date:   Tue, 28 Nov 2023 15:57:04 -0800
In-Reply-To: <000000000000efc64705ff8286a1@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000efd864060b3f2cf0@google.com>
Subject: Re: [syzbot] [wireless?] WARNING in rate_control_rate_init (2)
From:   syzbot <syzbot+62d7eef57b09bfebcd84@syzkaller.appspotmail.com>
To:     davem@davemloft.net, edumazet@google.com, johannes.berg@intel.com,
        johannes@sipsolutions.net, kuba@kernel.org,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        llvm@lists.linux.dev, nathan@kernel.org, ndesaulniers@google.com,
        netdev@vger.kernel.org, pabeni@redhat.com,
        syzkaller-bugs@googlegroups.com, trix@redhat.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=2.3 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_WEB,SORTED_RECIPS,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this issue to:

commit b303835dabe0340f932ebb4e260d2229f79b0684
Author: Johannes Berg <johannes.berg@intel.com>
Date:   Sat Jul 23 20:08:49 2022 +0000

    wifi: mac80211: accept STA changes without link changes

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=125a86dce80000
start commit:   a214724554ae Merge tag 'wireless-next-2023-11-27' of git:/..
git tree:       net-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=115a86dce80000
console output: https://syzkaller.appspot.com/x/log.txt?x=165a86dce80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=abf6d5a82dab01fe
dashboard link: https://syzkaller.appspot.com/bug?extid=62d7eef57b09bfebcd84
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10a4fc64e80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1363b22ce80000

Reported-by: syzbot+62d7eef57b09bfebcd84@syzkaller.appspotmail.com
Fixes: b303835dabe0 ("wifi: mac80211: accept STA changes without link changes")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
