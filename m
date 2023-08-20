Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C0F8781CF0
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Aug 2023 10:26:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbjHTI0T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Aug 2023 04:26:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230144AbjHTI0Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Aug 2023 04:26:16 -0400
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EBD5448C
        for <linux-kernel@vger.kernel.org>; Sun, 20 Aug 2023 01:24:24 -0700 (PDT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-68a4025bb30so187014b3a.3
        for <linux-kernel@vger.kernel.org>; Sun, 20 Aug 2023 01:24:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692519863; x=1693124663;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eUalpL+5Gi7lf4XJx93fopaSHZM9ZNT+DieLwJD0p4s=;
        b=dQf88KxeuuxMe6m56OQyDFY0n0xHHrAQvwzy0CHBBwaR+2Rxsmp39XxlRuFNm2UolB
         v8GuZUkU5tCHDkk9LVUV5rFKOWFfDx7eKJSyrISyAe7m6YM4GVHZlJiAdUwbjzHdAYqh
         3L6Z8eDy8CPwZbvP5qPwW4PSMh9sAuHdN/9EPoZeEJkAlf083nUtkwb0h2d2VxPrX5ws
         jqwqi6Nl+bM35U3jNOreWr8qXnXHgN3vSD9h9wpFE3mKmhVtDc7X35p7Qng9p4LLefab
         yNygTTRTrHUYbG9uruu5gHXuTfqa9MGA2CX1OSKT0fQIC50yMzLhngRvj+7zDtk/PJej
         /RFg==
X-Gm-Message-State: AOJu0YzQd+mXDmmWs/bVcHX6zrQoVBxjuuStNm/2FChlBnlWc8bTvr6l
        jfGRyR2gO4D2vWorrZBfrsMGBYbg5I2XhXWFZulNEAxG/fvg
X-Google-Smtp-Source: AGHT+IGg1EOuskTWqZbF2bfnbP5Y87prUDdSkdSIu+bVOlVgOtenVJAJW14yVxcre5N5i80uRFvtcB6EvEKB8g1TgK0qiTjnc/X4
MIME-Version: 1.0
X-Received: by 2002:a05:6a00:13a4:b0:687:31c0:782f with SMTP id
 t36-20020a056a0013a400b0068731c0782fmr2368999pfg.6.1692519863718; Sun, 20 Aug
 2023 01:24:23 -0700 (PDT)
Date:   Sun, 20 Aug 2023 01:24:23 -0700
In-Reply-To: <0000000000002d884205ffc75b9a@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000040996a0603567d52@google.com>
Subject: Re: [syzbot] [mm?] KASAN: slab-out-of-bounds Read in mt_validate_nulls
From:   syzbot <syzbot+609e63261638ff3d5436@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, ghandatmanas@gmail.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com, syzkaller@googlegroups.com,
        torvalds@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit ae80b404198434e49e903dc3b1ba83e2c7bb3ee2
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon Jul 3 17:08:50 2023 +0000

    mm: validate the mm before dropping the mmap lock

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17b0da65a80000
start commit:   a901a3568fd2 Merge tag 'iomap-6.5-merge-1' of git://git.ke..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=7406f415f386e786
dashboard link: https://syzkaller.appspot.com/bug?extid=609e63261638ff3d5436
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10342968a80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17d4cf70a80000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: mm: validate the mm before dropping the mmap lock

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
