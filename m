Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5928078FECD
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 16:16:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348538AbjIAOQi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 10:16:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237531AbjIAOQi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 10:16:38 -0400
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D227210EF
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 07:16:34 -0700 (PDT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-1bde8160fbdso23069645ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Sep 2023 07:16:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693577794; x=1694182594;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fcvgDbvbUw5Qcf0anbgZcfJ9WNarMzjdamecOvB7IYI=;
        b=a0w+JVxhyAfzmAe9BNPeZuA2y8ClcJ3ZQxlo7Q+HoD3lFVl21OPHU704SDoUgvRCt/
         zqncYvj7tuFgA/N2rhxPrYI3pa+vrb3H2VhHQdJc/HYPglwMVnAW8r5mNQVZkgoWlrwk
         URtbNGDZ9+GVDi3krPfOu6foT9NruGFQFZjwZCbqrsYlvDn82bNKv94vfwHwsHe1/zU/
         wjcHuZyHTXvGLWVvglyp0HMjNZxPZCvjXr3DwuD8ZKs1TrUMdss3a1OaU5nAwZzEqK68
         DVs4JkrCjvp+1b0qA/DLJjhbcISE39aymnNWwiiIij/j+BWe4kGESskSpAI3ZiH8UNX4
         ivKA==
X-Gm-Message-State: AOJu0Yzi+8dvrcpk4WfDp+mXC0rQWqX8ipCj1KPot9T9xXh+RoDjZ2yg
        QcQWvr0Wo0P1LZqAXg8ugkDwDdOtMO5yv5+t0N6nfBClPy99
X-Google-Smtp-Source: AGHT+IFc7YjlSjHvDvP7cirzcdCjKk2D/fDe+yk6UxvIvAemHVScjMtitmUI/slD7b32dT0fMgTPgbdH3RXPR+jluBVxNY9SvuDQ
MIME-Version: 1.0
X-Received: by 2002:a17:902:dacb:b0:1b8:929f:1990 with SMTP id
 q11-20020a170902dacb00b001b8929f1990mr922243plx.6.1693577794354; Fri, 01 Sep
 2023 07:16:34 -0700 (PDT)
Date:   Fri, 01 Sep 2023 07:16:34 -0700
In-Reply-To: <0000000000001f4d4806037fc7b8@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d5052e06044cced1@google.com>
Subject: Re: [syzbot] [mm?] kernel BUG in free_unref_page_prepare
From:   syzbot <syzbot+7423f066b632d9ff23d5@syzkaller.appspotmail.com>
To:     42.hyeyoo@gmail.com, akpm@linux-foundation.org, bhe@redhat.com,
        dyoung@redhat.com, hughd@google.com, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        llvm@lists.linux.dev, lrh2000@pku.edu.cn, mike.kravetz@oracle.com,
        muchun.song@linux.dev, nathan@kernel.org, ndesaulniers@google.com,
        pcc@google.com, syzkaller-bugs@googlegroups.com, trix@redhat.com,
        vgoyal@redhat.com, willy@infradead.org
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

syzbot has bisected this issue to:

commit 3a77b282e256d880791a4c5aa10ede13d6417425
Author: Matthew Wilcox (Oracle) <willy@infradead.org>
Date:   Wed Aug 16 15:11:58 2023 +0000

    mm: free up a word in the first tail page

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13297387a80000
start commit:   7271b2a53042 Add linux-next specific files for 20230818
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=10a97387a80000
console output: https://syzkaller.appspot.com/x/log.txt?x=17297387a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1936af09cdef7dd6
dashboard link: https://syzkaller.appspot.com/bug?extid=7423f066b632d9ff23d5
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=112386f3a80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15044717a80000

Reported-by: syzbot+7423f066b632d9ff23d5@syzkaller.appspotmail.com
Fixes: 3a77b282e256 ("mm: free up a word in the first tail page")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
