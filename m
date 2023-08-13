Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ECFE77A68F
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 15:38:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231161AbjHMNi2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 09:38:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjHMNi1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 09:38:27 -0400
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B07A1716
        for <linux-kernel@vger.kernel.org>; Sun, 13 Aug 2023 06:38:30 -0700 (PDT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-1bdc89af101so13490115ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 13 Aug 2023 06:38:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691933909; x=1692538709;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=neJnpZX6yQ9QkvvT9QAkP8Ws3ecBujJ1QULkPMiV29E=;
        b=N2vsbZlfinlb4XtZS4PEggC1HpyNfqKPGNor6i3EdXVhRdapq/h5cdrrBWp53WLXNP
         AGsjz7J+rKulqpLf+i5V05BoxBY5XeeBcu89flKJevTvfHwMS3ZzC2y5hEc4E0GWQZdD
         XaIbccFXvNjIs2/vjjr3ee5UXh8GyY7bybNNB8B2d9WAzgYvV7BfbcrJZgTfHJrRBKj3
         vsZuHTASXkfSApL6zuRthOBQkb4f/SDPKS8gdKKTOEZz1bizX0UbiAfBAjbVNjJ7qaQX
         ijsa2IVWjG8kp0CCj+xB2NSCjujni0/NbIeYe9B9zuEytxzEpci2Da63Ra2AM33otJDu
         ZImw==
X-Gm-Message-State: AOJu0YxxTwqIB0GScB22pk9TBAMyap8pripGg/O1lnMky5jQ6g0UYEIL
        OF1yXqm0QxvyYKcFS+rwcgMEqSzva7lKQEAHW2d7zNoDLXgV
X-Google-Smtp-Source: AGHT+IFvUtqXr76zu2wT3itQvPjtzRoxdBW7cC6qINSUywu2YLhPJ1DCvGf+u/vcRaSITgKK9wNgpHfjYiUe7vo70HM9pGod+tZJ
MIME-Version: 1.0
X-Received: by 2002:a17:902:d4c4:b0:1bb:a78c:7a3e with SMTP id
 o4-20020a170902d4c400b001bba78c7a3emr2668812plg.3.1691933909651; Sun, 13 Aug
 2023 06:38:29 -0700 (PDT)
Date:   Sun, 13 Aug 2023 06:38:29 -0700
In-Reply-To: <00000000000094ac8b05ffae2bf2@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ab16cf0602ce0f9d@google.com>
Subject: Re: [syzbot] [modules?] general protection fault in sys_finit_module
From:   syzbot <syzbot+9e4e94a2689427009d35@syzkaller.appspotmail.com>
To:     bpf@vger.kernel.org, chris@chrisdown.name,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        llvm@lists.linux.dev, mcgrof@kernel.org, nathan@kernel.org,
        ndesaulniers@google.com, syzkaller-bugs@googlegroups.com,
        torvalds@linux-foundation.org, trix@redhat.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit f1962207150c8b602e980616f04b37ea4e64bb9f
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue Jul 4 13:37:32 2023 +0000

    module: fix init_module_from_file() error handling

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=148a0a03a80000
start commit:   995b406c7e97 Merge tag 'csky-for-linus-6.5' of https://git..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=71a52faf60231bc7
dashboard link: https://syzkaller.appspot.com/bug?extid=9e4e94a2689427009d35
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17d6670ca80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=103be50b280000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: module: fix init_module_from_file() error handling

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
