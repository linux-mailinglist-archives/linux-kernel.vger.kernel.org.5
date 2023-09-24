Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 297AE7AC5F2
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 02:02:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbjIXACc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 20:02:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjIXACa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 20:02:30 -0400
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com [209.85.167.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB01C124
        for <linux-kernel@vger.kernel.org>; Sat, 23 Sep 2023 17:02:23 -0700 (PDT)
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-3adbc8aaf29so7553896b6e.3
        for <linux-kernel@vger.kernel.org>; Sat, 23 Sep 2023 17:02:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695513743; x=1696118543;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TRTLhAaHmBf6L92pgz9HMkE8lNZQYMRgmuo+q5ZisvY=;
        b=JrwrB7jx/uKKXoAILLkYaV8l18/sG7owMEHE6whGEtlvRcwItQalLA845ZcwthN8d9
         ZjidhURYM3mvL1cLHaPSS6reB1gavXO2OXq1aKmV39lhT9wxIdkxie/g+0rkeLgn0d2H
         uOWvX11PW82Z2JRR3LCNcTf5N0+G9uQ+Y9lc4hAydEre5CyKex2SufmCWpJmoetNpMDV
         Ml6glGJHhLLwR3ALKPqmDneexV7yAEwoh8cBMd85Yvf07aPaA3YwhKaW4N3LMb5ujngv
         pLiaaqgi67cBqrW6kQ9FWJmdjfY3hbNKP009v4OoW+R69xKn4VNzn35HILXFVAzgWhL6
         C/UQ==
X-Gm-Message-State: AOJu0Yz5vgqMigHeWovWijkSrxQccNA5B9XwTf4XGGehJudnU6RrD20P
        a1Iw2Npu5DmLlI7urVw05YaR0SkWMxZtE3kYmpoZtGxS2Qac
X-Google-Smtp-Source: AGHT+IGfx89OEM0dgcl6E42YsvcsU1YHXoQ79b1Iq0lAsZKrrx1aIx1LBPvW3hRAJipQ9VuzTrj5v2LLTyX1cbAPAO3EopyoxB0h
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1786:b0:3ad:f6ad:b9cc with SMTP id
 bg6-20020a056808178600b003adf6adb9ccmr1827021oib.10.1695513743310; Sat, 23
 Sep 2023 17:02:23 -0700 (PDT)
Date:   Sat, 23 Sep 2023 17:02:23 -0700
In-Reply-To: <0000000000007fcc9c05f909f7f3@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000061c35a06060f8eb3@google.com>
Subject: Re: [syzbot] [reiserfs?] KASAN: null-ptr-deref Read in fix_nodes
From:   syzbot <syzbot+5184326923f180b9d11a@syzkaller.appspotmail.com>
To:     jack@suse.cz, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, reiserfs-devel@vger.kernel.org,
        rkovhaev@gmail.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this issue to:

commit d24396c5290ba8ab04ba505176874c4e04a2d53c
Author: Rustam Kovhaev <rkovhaev@gmail.com>
Date:   Sun Nov 1 14:09:58 2020 +0000

    reiserfs: add check for an invalid ih_entry_count

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15244cfa680000
start commit:   b6dad5178cea Merge tag 'nios2_fix_v6.4' of git://git.kerne..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=17244cfa680000
console output: https://syzkaller.appspot.com/x/log.txt?x=13244cfa680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ac246111fb601aec
dashboard link: https://syzkaller.appspot.com/bug?extid=5184326923f180b9d11a
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10bbc887280000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15c9558b280000

Reported-by: syzbot+5184326923f180b9d11a@syzkaller.appspotmail.com
Fixes: d24396c5290b ("reiserfs: add check for an invalid ih_entry_count")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
