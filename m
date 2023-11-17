Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7DFA7EEDBF
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 09:49:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345709AbjKQItK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 03:49:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230383AbjKQItI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 03:49:08 -0500
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 025281A1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 00:49:05 -0800 (PST)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-5bddc607b45so2263616a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 00:49:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700210944; x=1700815744;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5Ym+eEngmFhnbHeC4nMT4pNbV5P6+1WlnQaLhNaxmSE=;
        b=rpzm6iOVeJWVRJV9sYpfoIt/yuXvKfYk/E5imiCGOJaP5KpaGefujPR413NEsuXiNJ
         Zf9mG4J9DLF1mu46CxYTMv8UN1TV8EspbR8ZjEhMqgt78QGPw9yu5dnPvrxwCOcTaME5
         agq3lkud8Q2dhMGXZTNuhOVh56GlqHw0Q7i2w1c0yc5/HZgkkKLA6IvJE0U2pj4XVA4D
         qw94GFa7+Zt4ukdBEccxEJiODGQl47w+IMOvO+PKlxEXohK+Nio/VShrc9SeAxG6QN5J
         RP1iQJTzWRx2RPi4/a/jwWDU2yMkcNuqk4eiblUuVteL0RN4EYzGL98INrO15b3nBjfD
         /vdA==
X-Gm-Message-State: AOJu0Yz/XVjvGTCDxaxad9oHhg8GsWPfZF9z6bJ4w827LIL4hhfYyqaS
        tx2B4dzpvYrejE+KIbXzZnyBEdhXE9wDWJ2a801tJ5GxwR2O
X-Google-Smtp-Source: AGHT+IH00GIpXJ0tra0/kHyJUpp48mrBTXuig30wf7+4zNGKw8bEou2RIeIVqr7zj6SvjMo8V1uF+uaf7R8M2SYiSNdF/Vvu6IhO
MIME-Version: 1.0
X-Received: by 2002:a65:414a:0:b0:5bd:57e3:d89f with SMTP id
 x10-20020a65414a000000b005bd57e3d89fmr929288pgp.8.1700210944552; Fri, 17 Nov
 2023 00:49:04 -0800 (PST)
Date:   Fri, 17 Nov 2023 00:49:04 -0800
In-Reply-To: <000000000000a25ea7060a430d3c@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000064b787060a55354e@google.com>
Subject: Re: [syzbot] [kernel?] inconsistent lock state in ptrace_attach
From:   syzbot <syzbot+cbb25bb9b4d29a773985@syzkaller.appspotmail.com>
To:     boqun.feng@gmail.com, brauner@kernel.org,
        linux-kernel@vger.kernel.org, longman@redhat.com,
        michael.christie@oracle.com, mingo@redhat.com, mst@redhat.com,
        oleg@redhat.com, peterz@infradead.org,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        wander@redhat.com, will@kernel.org
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

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=132b7d84e80000
start commit:   f31817cbcf48 Add linux-next specific files for 20231116
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=10ab7d84e80000
console output: https://syzkaller.appspot.com/x/log.txt?x=172b7d84e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f59345f1d0a928c
dashboard link: https://syzkaller.appspot.com/bug?extid=cbb25bb9b4d29a773985
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1014d797680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11b1ec67680000

Reported-by: syzbot+cbb25bb9b4d29a773985@syzkaller.appspotmail.com
Fixes: 2d25a889601d ("ptrace: Convert ptrace_attach() to use lock guards")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
