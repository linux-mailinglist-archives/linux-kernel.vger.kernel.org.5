Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B48347B53C1
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 15:15:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237319AbjJBNId (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 09:08:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236163AbjJBNIc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 09:08:32 -0400
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com [209.85.160.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D292693
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 06:08:29 -0700 (PDT)
Received: by mail-oa1-f71.google.com with SMTP id 586e51a60fabf-1e113662d75so6179851fac.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Oct 2023 06:08:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696252109; x=1696856909;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rorPIP5j5NnvLe/VG3SBvJuviukORjr0ptic0PGw4zI=;
        b=tfaq34E3WtygjWgUiLd35zvL7FRWfSUGIbKzYP2ES9nXX9AeuxxUNYUzjY3A4VQ3RV
         0vaZjV6hwGrdaTauPdPBrn9nJRrTo/I7/x9f/495iE+eGQT98szzhbrHKzFN1GghG+k1
         K2VLjevLvEfyYw7+1LLB5lLTuC22lk+sGGWO3fSwTzgBDvSqdvaGWyQPzsuTqUlj+w+u
         kuiN+qohSDIWUHand4uupLALC88AeenWftL6BcJFUcK278dOTi+JEh1DtnOWM4HrxVyy
         KzHFRhe5DiyUhnWLttrijWPdXfVLo6rTZep+xKkeq1LfFt/Js4LSGnUI3B1ansaPrDl2
         XvXQ==
X-Gm-Message-State: AOJu0YyzTAic+KGgOSYal/n7Pg1LFemYaBTptM4NIigWi3XXprszl7gg
        YZuJyEGqVcZx+3G00KCqWO+kS9in6KPuPCtCdutLpazIbKUy
X-Google-Smtp-Source: AGHT+IH15olfXP89zOaUgPnZ+A3LWHTnmJnCU4ut1cZEZzpYg/G4sHkoNl3GWJ2A8/7WTnzttgIAQ3N4O8oSXKkeG9zcRAHK4fyE
MIME-Version: 1.0
X-Received: by 2002:a05:6870:5aad:b0:1c0:e7d3:3b2d with SMTP id
 dt45-20020a0568705aad00b001c0e7d33b2dmr4872328oab.7.1696252109232; Mon, 02
 Oct 2023 06:08:29 -0700 (PDT)
Date:   Mon, 02 Oct 2023 06:08:29 -0700
In-Reply-To: <000000000000c4c9d405f2643e01@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006ba21a0606bb78f9@google.com>
Subject: Re: [syzbot] [bridge?] possible deadlock in br_multicast_rcv (3)
From:   syzbot <syzbot+d7b7f1412c02134efa6d@syzkaller.appspotmail.com>
To:     amcohen@nvidia.com, axboe@fb.com,
        bridge@lists.linux-foundation.org, davem@davemloft.net,
        dsahern@kernel.org, edumazet@google.com, hch@lst.de,
        hdanton@sina.com, idosch@nvidia.com, ivecera@redhat.com,
        jiri@resnulli.us, kbusch@kernel.org, kuba@kernel.org,
        lengchao@huawei.com, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, llvm@lists.linux.dev,
        nathan@kernel.org, ndesaulniers@google.com, netdev@vger.kernel.org,
        pabeni@redhat.com, razor@blackwall.org, roopa@nvidia.com,
        sagi@grimberg.me, syzkaller-bugs@googlegroups.com, trix@redhat.com
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

commit 0ae3eb7b4611207e140e9772398b9f88b72d6839
Author: Amit Cohen <amcohen@nvidia.com>
Date:   Mon Feb 1 19:47:49 2021 +0000

    netdevsim: fib: Perform the route programming in a non-atomic context

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13afdae6680000
start commit:   2faac9a98f01 Merge tag 'keys-fixes-20230321' of git://git...
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=106fdae6680000
console output: https://syzkaller.appspot.com/x/log.txt?x=17afdae6680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=aaa4b45720ca0519
dashboard link: https://syzkaller.appspot.com/bug?extid=d7b7f1412c02134efa6d
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14aea34ec80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13001e91c80000

Reported-by: syzbot+d7b7f1412c02134efa6d@syzkaller.appspotmail.com
Fixes: 0ae3eb7b4611 ("netdevsim: fib: Perform the route programming in a non-atomic context")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
