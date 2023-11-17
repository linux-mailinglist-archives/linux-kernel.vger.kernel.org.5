Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B84377EEAAA
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 02:25:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345627AbjKQBZK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 20:25:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345553AbjKQBZJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 20:25:09 -0500
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A32E182
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 17:25:06 -0800 (PST)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-5bd26ef66d1so2176343a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 17:25:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700184305; x=1700789105;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RJo6nMVJndBB899kUvGypW1akG0rhdJo5ej1y6RnVs8=;
        b=MTg2DYCW9LP3/TTzRPYOygmlRj7XmUadR39S3aUkCIBaC9Etv4hiViex+YCWlgDSV/
         dsdj34TgaKhQaMUIRP7K0Ds8JhfIoO2Lc9v5ZrZibZK9o2oTepY8aWwxER6Pz2BXk8GB
         cQgv5IhSoIDoB+TnlTJeGe1XwXUOgoqv7/YRGwgqx0WxnULt9kTZZ9hT9iPH1iLsGsA2
         Hb/H4NeVdNB3mJSeYXAD0KOBYMlTSkHNS/P/n94Nw3itU1UfJ0yzAY0snG2lecLVOF+G
         Tm55WKfjjaTdAbXb3WJxUn74zFSyTBFNolJVZ9ioOWfh5ZTfBH1ct9gFBruNYK8kRDTi
         0m6A==
X-Gm-Message-State: AOJu0YynX3eAEJ9CJOvnwKaM63W+eN5sLZPnFVsunhqvQE9VhfDnsku7
        PtSYvoetcIYCHzGDNna2L4cgBOKGd1BkwURn2SzASRhsPPSN
X-Google-Smtp-Source: AGHT+IEZQ7oXyxiWxmK+3mMIwuVi6kepyoGWFMrMJQaY2uJPqBt2+V4JzH085Nym1mQ8E5BzfIOpvnSSsyjKyBqYg+qJJuLDlN0A
MIME-Version: 1.0
X-Received: by 2002:a17:903:2681:b0:1ce:1892:2fb1 with SMTP id
 jf1-20020a170903268100b001ce18922fb1mr2611444plb.0.1700184305580; Thu, 16 Nov
 2023 17:25:05 -0800 (PST)
Date:   Thu, 16 Nov 2023 17:25:05 -0800
In-Reply-To: <000000000000f5b0d0060a430995@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009642b4060a4f017f@google.com>
Subject: Re: [syzbot] [cgroups?] possible deadlock in cgroup_free
From:   syzbot <syzbot+cef555184e66963dabc2@syzkaller.appspotmail.com>
To:     boqun.feng@gmail.com, brauner@kernel.org, cgroups@vger.kernel.org,
        hannes@cmpxchg.org, linux-kernel@vger.kernel.org,
        lizefan.x@bytedance.com, longman@redhat.com,
        michael.christie@oracle.com, mingo@redhat.com, mst@redhat.com,
        oleg@redhat.com, peterz@infradead.org,
        syzkaller-bugs@googlegroups.com, tj@kernel.org, wander@redhat.com,
        will@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this issue to:

commit 2d25a889601d2fbc87ec79b30ea315820f874b78
Author: Peter Zijlstra <peterz@infradead.org>
Date:   Sun Sep 17 11:24:21 2023 +0000

    ptrace: Convert ptrace_attach() to use lock guards

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=130edb3f680000
start commit:   f31817cbcf48 Add linux-next specific files for 20231116
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=108edb3f680000
console output: https://syzkaller.appspot.com/x/log.txt?x=170edb3f680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f59345f1d0a928c
dashboard link: https://syzkaller.appspot.com/bug?extid=cef555184e66963dabc2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13fd7920e80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17d80920e80000

Reported-by: syzbot+cef555184e66963dabc2@syzkaller.appspotmail.com
Fixes: 2d25a889601d ("ptrace: Convert ptrace_attach() to use lock guards")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
