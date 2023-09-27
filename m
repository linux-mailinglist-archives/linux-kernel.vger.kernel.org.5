Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8305F7B064C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 16:12:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232051AbjI0OM0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 10:12:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232001AbjI0OMY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 10:12:24 -0400
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com [209.85.160.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1CF6139
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 07:12:22 -0700 (PDT)
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-1dd51b98342so12089119fac.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 07:12:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695823942; x=1696428742;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x5+JvUZEOKzPf2ex0W9pSMvC1OvUezS3byGKI63FJl0=;
        b=fOVKcD5tRxEpE37WT82BlxNfw1hNk79tHo+2lBei4tZ049TtA0YmH8qqtfzlp8+Ly/
         q7GvqAFMA7B1W7d+wH0tpbYCPIgV2889spxInh+r9Pm2OlwP0sHP6CjLCOWEFXgDglzR
         mTYnQsnvn+SqpY4vTVdkIMPaBELqB/3rl6nRBos9qXfpbevavDE7SkXS1Ev9u84hfZd8
         4WytJJuI0NX5i/V/l9wqic/ZC8VJwqsBtl+d0jyS1Hpf23kUubiSmVPb52h9dRIWuMzq
         oAv7PLdbVEaH30zHorg+8X9QOYJMg+EmVP+MNs8q89FgW4gdbGB1R82A4Q4LeRKuVF6Z
         qulg==
X-Gm-Message-State: AOJu0YxfMx6Fl4ff12+jlAEvffpp7bl/3xgwjtsELW06p+k31f7gPyMc
        Xgsxau6ONpLcm90HZ0pNihi9zSaaUObw5yeSzcESSjfbmCeB
X-Google-Smtp-Source: AGHT+IEXT9cv/7otRKCHIMyXe4a6OuyJUAPxPGuY/5OBjjcTazh1xGVVg8YXZdg52Yezvlv1nQK+3H0kUU4kY2hV/Fo/BtkLW7aV
MIME-Version: 1.0
X-Received: by 2002:a05:6870:a88d:b0:1bf:a06f:ce6f with SMTP id
 eb13-20020a056870a88d00b001bfa06fce6fmr748507oab.9.1695823942234; Wed, 27 Sep
 2023 07:12:22 -0700 (PDT)
Date:   Wed, 27 Sep 2023 07:12:22 -0700
In-Reply-To: <00000000000029708206031ad94a@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000adbe11060657c7b6@google.com>
Subject: Re: [syzbot] [kernel?] INFO: rcu detected stall in toggle_allocation_gate
From:   syzbot <syzbot+52d2f6feb48dc7328968@syzkaller.appspotmail.com>
To:     bp@alien8.de, dave.hansen@linux.intel.com, davem@davemloft.net,
        hdanton@sina.com, hpa@zytor.com, jhs@mojatatu.com,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        netdev@vger.kernel.org, pctammela@mojatatu.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        victor@mojatatu.com, vladimir.oltean@nxp.com, x86@kernel.org
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

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15dd4876680000
start commit:   950fe35831af Merge branch 'ipv6-expired-routes'
git tree:       net-next
kernel config:  https://syzkaller.appspot.com/x/.config?x=fe63ad15dded26b6
dashboard link: https://syzkaller.appspot.com/bug?extid=52d2f6feb48dc7328968
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13d34703a80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13a9a040680000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: net/sched: fix a qdisc modification with ambiguous command request

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
