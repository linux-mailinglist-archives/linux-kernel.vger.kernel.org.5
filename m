Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 773127D7D21
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 08:59:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344159AbjJZG7g convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 26 Oct 2023 02:59:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjJZG7e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 02:59:34 -0400
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com [209.85.160.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34B9F129
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 23:59:32 -0700 (PDT)
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-1e9d9455085so624262fac.2
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 23:59:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698303571; x=1698908371;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mg4dqADrWVVQFvwUDMmazDT6n+A6BU7HqszKhe39EAk=;
        b=uZRtlcv14Djs3FdDeEJ+g6Ujda/ZyPn6gohfhee2Fdl88MA52QVjDli2Bu2awsmLze
         qO+QhtbOPjy5jLhMjJ+1C3g2NehTvfhuL9c0sp5Yn4BnbanLiHA8wUQu0vmC2+yvbWHY
         4Dl2F3NEPSDSZHsCVitMWL83m5P23Q24KDJdQtQ9Mp9PDQe7E/xms0MaFf2qM/YjMUt+
         3m455KTRxgLqdnklF6p2mK0Cib+5bcXuDnoZW0qrh2CzbAYuGy8JJG6gf9jxczPrrh/R
         mvtV3ylkhB7H2VPeyoI7SpenlCh+47edOmSmNCpwQivZ7CB/KsZV7f/3fyE2MWNkqHAP
         Mrig==
X-Gm-Message-State: AOJu0Yyune2JuX0sPMFV/RNHdmcjyTbmlnIyCmG1Q+Ftqp+rXr/qEfEg
        /icJM+0NEmL4wA+6XbUtIDrlYcckACJS+rNsUdgrmjbK0TTm
X-Google-Smtp-Source: AGHT+IHp42mn/AOQMp/Gy+pIgTER3CgUE07jlE0pfwGuoDZyiIaKHT4W8OY7jzoJ5tQHqlAfyspW2vZKdlZR85jhZJ/GMbMFDJg/
MIME-Version: 1.0
X-Received: by 2002:a05:6870:179c:b0:1e9:a917:d59b with SMTP id
 r28-20020a056870179c00b001e9a917d59bmr8164456oae.3.1698303571383; Wed, 25 Oct
 2023 23:59:31 -0700 (PDT)
Date:   Wed, 25 Oct 2023 23:59:31 -0700
In-Reply-To: <0000000000000f188605ffdd9cf8@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000017dd680608991d75@google.com>
Subject: Re: [syzbot] [f2fs?] possible deadlock in f2fs_add_inline_entry
From:   syzbot <syzbot+a4976ce949df66b1ddf1@syzkaller.appspotmail.com>
To:     arthurgrillo@riseup.net, chao@kernel.org, hdanton@sina.com,
        jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        lizhi.xu@windriver.com, mairacanal@riseup.net, mcanal@igalia.com,
        penguin-kernel@i-love.sakura.ne.jp, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit a0e6a017ab56936c0405fe914a793b241ed25ee0
Author: Maíra Canal <mcanal@igalia.com>
Date:   Tue May 23 12:32:08 2023 +0000

    drm/vkms: Fix race-condition between the hrtimer and the atomic commit

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=166c090d680000
start commit:   28f20a19294d Merge tag 'x86-urgent-2023-08-26' of git://gi..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=21a578092dd61d05
dashboard link: https://syzkaller.appspot.com/bug?extid=a4976ce949df66b1ddf1
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15a09340680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=118909eba80000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: drm/vkms: Fix race-condition between the hrtimer and the atomic commit

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
