Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CF7A8065E6
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 04:58:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376436AbjLFD6H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 22:58:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjLFD6F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 22:58:05 -0500
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com [209.85.167.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D454DD40
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 19:58:10 -0800 (PST)
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-3b8960f1a65so7702621b6e.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 19:58:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701835090; x=1702439890;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kowtJ3erIuB+junPJVnmZj+8P3bHd7MVP6/UASYAO2Y=;
        b=ATnqEgfxZVdyWFtD+m4P167CA/iTLJeIkqJYhAOP9j3iY4GxNDQBIx2t5hO1eZ/cG9
         YdNVwtW0cGmN+LxMq9OsYsYzQSGiHDJ1XXfXrxGHx3IYwf55h+B+uTsTM+mRhCSmpkfP
         Y6fgYswwsmXxxePpGeffOnCg5Noc050FB441GZLG5J6J2zr3RNGNnIpsM5MZpL/V9Mub
         D3J8YCBteSoeoNUEP6UhQUIgop5Hite/4X0ExEXWH6zFO5H0VO2HIHHDqglpHPUQKRTf
         //52CfiL0ap7bf6vigM+/JrWsqtMkHPl+M89ksGbeUhO+QAcdHobc9KFWGe8J409maMO
         2T0g==
X-Gm-Message-State: AOJu0YyIwyxG9SuS23iE0r3w5DF3O4J1OJjbQ1SCA4tRYKl4fUkRRgFe
        YpP6EfqJdIwdFHvrwZoraA20h1uCUszoqBPiTClfZmhrF6Gb
X-Google-Smtp-Source: AGHT+IFgghFouIRUn3iqyZ5s/Hsf85PRJMmibbGXKnnfFoA3CNAysUkTLcYkwd+dQjrhhNtZ+Mk7dCqwuInXNtLFga8mnTqxKONF
MIME-Version: 1.0
X-Received: by 2002:a05:6808:2009:b0:3b8:931d:d1db with SMTP id
 q9-20020a056808200900b003b8931dd1dbmr299703oiw.3.1701835090175; Tue, 05 Dec
 2023 19:58:10 -0800 (PST)
Date:   Tue, 05 Dec 2023 19:58:10 -0800
In-Reply-To: <000000000000797bd1060a457c08@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000042dd9060bcf5c23@google.com>
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Write in sco_sock_timeout
From:   syzbot <syzbot+4c0d0c4cde787116d465@syzkaller.appspotmail.com>
To:     davem@davemloft.net, eadavis@qq.com, edumazet@google.com,
        hdanton@sina.com, johan.hedberg@gmail.com, kuba@kernel.org,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        lizhi.xu@windriver.com, luiz.dentz@gmail.com,
        luiz.von.dentz@intel.com, marcel@holtmann.org,
        netdev@vger.kernel.org, pabeni@redhat.com,
        syzkaller-bugs@googlegroups.com, yuran.pereira@hotmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=2.3 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        RCVD_IN_SORBS_WEB,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this issue to:

commit 9a8ec9e8ebb5a7c0cfbce2d6b4a6b67b2b78e8f3
Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Date:   Thu Mar 30 21:15:50 2023 +0000

    Bluetooth: SCO: Fix possible circular locking dependency on sco_connect_cfm

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=179a65d2e80000
start commit:   bee0e7762ad2 Merge tag 'for-linus-iommufd' of git://git.ke..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=145a65d2e80000
console output: https://syzkaller.appspot.com/x/log.txt?x=105a65d2e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b50bd31249191be8
dashboard link: https://syzkaller.appspot.com/bug?extid=4c0d0c4cde787116d465
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1504504ae80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14685f54e80000

Reported-by: syzbot+4c0d0c4cde787116d465@syzkaller.appspotmail.com
Fixes: 9a8ec9e8ebb5 ("Bluetooth: SCO: Fix possible circular locking dependency on sco_connect_cfm")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
