Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDD437A26DB
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 21:02:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236877AbjIOTC0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 15:02:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236963AbjIOTB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 15:01:57 -0400
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 698CD2D71
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 12:01:30 -0700 (PDT)
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-3acac5d0b87so3228835b6e.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 12:01:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694804489; x=1695409289;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jIsxNI68mB9Kq0lc2JZJzazFfrMrZvjV6QtMhALsulY=;
        b=A5yWfe0Nj4PBhnT3W+rlMc+4S1g4E0mRyKk9OUfO2Li3Su6wWaUXgrezhUqn26khsa
         iiHTatszuxgXga5kXV9sPYtympAw34MK7Qh5tPOT8HiR/19o8YMigrxMFukP8E6c423B
         yClUk9fyl9VM5e5pDQEoODjzbjtjlofWPbHlPzPPwJSeJ/DRR3Sop/hZglDncAdPHrHK
         4ASqf+ldLd5WeIb5fTQIsmIoznXh+uSn2teuk76FJLsUD6P6j2Orvw2cZeIlygxG7o8V
         fvH/TjaEfIS6ban5VzgLLbtgNepGHKdULe0X3ZYsIFFJAhU5zlF9ugCFZ219BdrTnJkw
         k3LA==
X-Gm-Message-State: AOJu0YzzBPe+amA4GB47keBSLWf9iLC9uutCxnTgViV/71I8xV7/cW0V
        ak9z8SfoojBjwTSd4TNSqpIY28WTDKHXO2r7QZ402FPQfedX
X-Google-Smtp-Source: AGHT+IEdW28QExD1CG+iyseqF14sfY7RwaCtlPwhqEcqryljdpqrzAKD69SsLJPnECJiegiA/z1xDUUpJu2RDnGpl364+DDKioM6
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1589:b0:3ad:aeed:7ed9 with SMTP id
 t9-20020a056808158900b003adaeed7ed9mr1009026oiw.2.1694804489679; Fri, 15 Sep
 2023 12:01:29 -0700 (PDT)
Date:   Fri, 15 Sep 2023 12:01:29 -0700
In-Reply-To: <0000000000005c2d1f05e8945724@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000925bf206056a6b69@google.com>
Subject: Re: [syzbot] [ntfs3?] BUG: unable to handle kernel NULL pointer
 dereference in __d_instantiate
From:   syzbot <syzbot+29dc75ed37be943c610e@syzkaller.appspotmail.com>
To:     adilger@dilger.ca, almaz.alexandrovich@paragon-software.com,
        edward.lo@ambergroup.io, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        nathan@kernel.org, ndesaulniers@google.com, ntfs3@lists.linux.dev,
        syzkaller-bugs@googlegroups.com, trix@redhat.com,
        viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit 54e45702b648b7c0000e90b3e9b890e367e16ea8
Author: Edward Lo <edward.lo@ambergroup.io>
Date:   Thu Sep 22 16:50:23 2022 +0000

    fs/ntfs3: Validate resident attribute name

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12403c74680000
start commit:   f9ff5644bcc0 Merge tag 'hsi-for-6.2' of git://git.kernel.o..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=c163713cf9186fe7
dashboard link: https://syzkaller.appspot.com/bug?extid=29dc75ed37be943c610e
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1077def7880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10175baf880000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs/ntfs3: Validate resident attribute name

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
