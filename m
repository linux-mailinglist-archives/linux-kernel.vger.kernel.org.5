Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F329E7C94AE
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 15:07:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233208AbjJNNHe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Oct 2023 09:07:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233046AbjJNNHc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Oct 2023 09:07:32 -0400
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com [209.85.161.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA223B7
        for <linux-kernel@vger.kernel.org>; Sat, 14 Oct 2023 06:07:29 -0700 (PDT)
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-57e460ac8c3so3976131eaf.0
        for <linux-kernel@vger.kernel.org>; Sat, 14 Oct 2023 06:07:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697288849; x=1697893649;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1/6ceZHQviZHWBwoxE7adPRErfGv6u0OyUKTGWcI8bI=;
        b=SaGPj8czntGPirEgIsyuxn1hb1Wxx1zM23aP4pJOe2WO9M6cNoFryngi7e/5DeCafj
         KtppJjL+/ukKfEm6rcunPpZm75S5oZj+5IdHck+KpGOkW1p3/vAmY1DMhfL1Bo+2JvCO
         CDnnD7iZFcYhxHKLmAIruNKYZ9xxT935CZHGSswnFU8XUMC/ZRv89JHMbJLxMFbKfOyv
         TwI5YREjH6bGCnnH1jM5cwcn/pnvWPLQmNdEk/OuBnlx9byqPP4rMmy2J+6UZxLB7wSR
         8dLCnvmL/Fq57XchC6Vl7SONAlzeocaeLyDqDeYLgfc1HE8hP/OJFRvHCinNlVQwCt3w
         4LxQ==
X-Gm-Message-State: AOJu0YxxLq+8em15t1wPxV5QAowqJWha4A/VElCeTLHAeR0VQt3x4IwZ
        sDgjpIvcx0Ti6X3ewBA4Vv+gjXjklDnuhXoPlHHVXs405eye
X-Google-Smtp-Source: AGHT+IEVCXmtDm4/SgXnVdwVBjmB+6iLQnnDacoQ6B2a0YxsIaEpL48b/OQOJ6nt9o5XmKqieSHSUI18COA2sWNw0RWueMJ/nlKJ
MIME-Version: 1.0
X-Received: by 2002:a05:6870:d782:b0:1e9:6b2f:5ad7 with SMTP id
 bd2-20020a056870d78200b001e96b2f5ad7mr4590286oab.1.1697288848970; Sat, 14 Oct
 2023 06:07:28 -0700 (PDT)
Date:   Sat, 14 Oct 2023 06:07:28 -0700
In-Reply-To: <000000000000ea44c905ffd26705@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ec9cb90607acdac9@google.com>
Subject: Re: [syzbot] [batman?] INFO: rcu detected stall in rtnl_newlink (3)
From:   syzbot <syzbot+afb3084a933aa2bdacc6@syzkaller.appspotmail.com>
To:     a@unstable.cc, b.a.t.m.a.n@lists.open-mesh.org,
        bpf@vger.kernel.org, davem@davemloft.net, dsahern@kernel.org,
        edumazet@google.com, kuba@kernel.org, kuniyu@amazon.com,
        linux-kernel@vger.kernel.org, mareklindner@neomailbox.ch,
        netdev@vger.kernel.org, pabeni@redhat.com, sven@narfation.org,
        sw@simonwunderlich.de, syzkaller-bugs@googlegroups.com,
        vinicius.gomes@intel.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit e739718444f7bf2fa3d70d101761ad83056ca628
Author: Kuniyuki Iwashima <kuniyu@amazon.com>
Date:   Sat Jul 29 00:07:05 2023 +0000

    net/sched: taprio: Limit TCA_TAPRIO_ATTR_SCHED_CYCLE_TIME to INT_MAX.

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15b26a4d680000
start commit:   d528014517f2 Revert ".gitignore: ignore *.cover and *.mbx"
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=d576750da57ebbb5
dashboard link: https://syzkaller.appspot.com/bug?extid=afb3084a933aa2bdacc6
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15849d08a80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13184990a80000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: net/sched: taprio: Limit TCA_TAPRIO_ATTR_SCHED_CYCLE_TIME to INT_MAX.

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
