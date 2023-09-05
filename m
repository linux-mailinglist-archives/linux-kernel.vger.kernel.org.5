Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3906792C34
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:11:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353663AbjIERGT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 13:06:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245241AbjIEBzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 21:55:37 -0400
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CABDACC6
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 18:55:31 -0700 (PDT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-1bf75ca4e4fso21670365ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Sep 2023 18:55:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693878931; x=1694483731;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sPNtMyx9dQhQPl1DJA90m5nAO5TU7mG9kQJJOwLb8ao=;
        b=OeJ5dhiTR9dqA0Pn39Rg9q7Q2zvnpxmjYjlyRgW4mjavUeLbmlk9v6hhHFqYubB4H+
         O99yHs1lhR7j1e579vPltxJwAxGDWjibNKyGUE/JfBJivpSkYvfhHknYGzkaXRS/+mgk
         GvfaQ9VeZPf5e2TJozs9TsFyMtN/c03n15of9tq24fjF3+B9X3NtIXdqKKSHsh4v0m9K
         jBn5m88QAipSmUzmcnWnTbuvilHVEeuhDrU/4JmDhBHSyVieWcwxmmUww0d7GzeFe0MW
         QirjiMkcsEyM+X+qCDX3HJj8IixoKgjodMEk3wz8fEvDFf+h45pC9ID7ddnJR0bO7NSv
         mILA==
X-Gm-Message-State: AOJu0Yx1aAeSlPqK2JmtfSBfEojyDP1wpnl+dVuP/dtsXcLPKIiGOh7T
        7Et9/Sth+dnVaCZbuKRyhKr+ArPSO5jPnYxcl8zGtQOsXL1s
X-Google-Smtp-Source: AGHT+IECie8x8G3Kd40oJ7FUPl9fPThLlspd8nesueC4aMYrTQx5d/3TjEaL/75cAMFp/sMx4sp81gZ0M+9VNXOrsJsAqh+LD5hT
MIME-Version: 1.0
X-Received: by 2002:a17:902:e808:b0:1b9:fef8:9af1 with SMTP id
 u8-20020a170902e80800b001b9fef89af1mr4179166plg.5.1693878931294; Mon, 04 Sep
 2023 18:55:31 -0700 (PDT)
Date:   Mon, 04 Sep 2023 18:55:31 -0700
In-Reply-To: <00000000000050a49105f63ed997@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fe1297060492eb88@google.com>
Subject: Re: [syzbot] [gfs2?] general protection fault in gfs2_dump_glock (2)
From:   syzbot <syzbot+427fed3295e9a7e887f2@syzkaller.appspotmail.com>
To:     agruenba@redhat.com, cluster-devel@redhat.com, elver@google.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        peterz@infradead.org, rpeterso@redhat.com,
        syzkaller-bugs@googlegroups.com, valentin.schneider@arm.com
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

commit a8b76910e465d718effce0cad306a21fa4f3526b
Author: Valentin Schneider <valentin.schneider@arm.com>
Date:   Wed Nov 10 20:24:44 2021 +0000

    preempt: Restore preemption model selection configs

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1633aaf0680000
start commit:   58390c8ce1bd Merge tag 'iommu-updates-v6.4' of git://git.k..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1533aaf0680000
console output: https://syzkaller.appspot.com/x/log.txt?x=1133aaf0680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5eadbf0d3c2ece89
dashboard link: https://syzkaller.appspot.com/bug?extid=427fed3295e9a7e887f2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=172bead8280000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14d01d08280000

Reported-by: syzbot+427fed3295e9a7e887f2@syzkaller.appspotmail.com
Fixes: a8b76910e465 ("preempt: Restore preemption model selection configs")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
