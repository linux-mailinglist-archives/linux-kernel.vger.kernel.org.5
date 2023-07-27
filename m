Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35EA0765E85
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 23:56:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231602AbjG0V4q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 17:56:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232699AbjG0V4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 17:56:32 -0400
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com [209.85.161.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0E7835BE
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 14:56:25 -0700 (PDT)
Received: by mail-oo1-f69.google.com with SMTP id 006d021491bc7-565c44558b0so2337678eaf.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 14:56:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690494985; x=1691099785;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NTZFcDWEnalsrrsj91+aV+exj/gSz6DkLyYFyJHhczQ=;
        b=H8XIth6GlgVIfcl+lmNVMzUi/Qy424kkgIenkrjZBkf7gjdOIT5a7jzc9dBzzIERgk
         xnEIHphbZr7fPsxxZC53Yu2JiEk7Pk7dFAFlGRO1gPdAgRNLEl3+pqL2XDgkZmR7p5cp
         /CQz0T59iJ1NaFpWymrm8poK4xDFJEX6wNy3z5pebKJGFcu49f5SdR19UarTY+durdIX
         S5QVzFDZRIUvih/698vnoPSKCuFwVl+YJuHnWkWYdU2EurJNpGZOZM9HWIJ87h76XH2l
         KmX/0CPccLv4vXEXHtrstep5dNlwaanW4x8tm2pVYOhv+tVcq4b66befOHr9d/oPyBo/
         Dyow==
X-Gm-Message-State: ABy/qLYwz9UnDB0y/jKSKP8Ien8cCVkwEVvk6NN93yIvTwf1Ptg4YC1t
        7sB/Uzwl+feWG+YOkWuBYH9d7BdehupoHRl5gvEc7OsPTL8f
X-Google-Smtp-Source: APBJJlH27w/I6S9cUeylwXarAxaDlL/rMDcRdn6KLWkdjH2BJtEUNIhS7lk/MWp1h0vRqgIhlJrFWuq2xzxANoqLIN7JnzjhDHdp
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1b24:b0:3a3:7087:bbfb with SMTP id
 bx36-20020a0568081b2400b003a37087bbfbmr1067033oib.6.1690494985416; Thu, 27
 Jul 2023 14:56:25 -0700 (PDT)
Date:   Thu, 27 Jul 2023 14:56:25 -0700
In-Reply-To: <000000000000b4e906060113fd63@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000019b5b106017f096a@google.com>
Subject: Re: [syzbot] [nilfs?] KASAN: slab-use-after-free Read in
 nilfs_load_inode_block (2)
From:   syzbot <syzbot+74db8b3087f293d3a13a@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, konishi.ryusuke@gmail.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nilfs@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this issue to:

commit 28a65b49eb53e172d23567005465019658bfdb4d
Author: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date:   Thu Apr 27 01:15:26 2023 +0000

    nilfs2: do not write dirty data after degenerating to read-only

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=177150e5a80000
start commit:   5f0bc0b042fc mm: suppress mm fault logging if fatal signal..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=14f150e5a80000
console output: https://syzkaller.appspot.com/x/log.txt?x=10f150e5a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5d10d93e1ae1f229
dashboard link: https://syzkaller.appspot.com/bug?extid=74db8b3087f293d3a13a
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15176d81a80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=132d93d9a80000

Reported-by: syzbot+74db8b3087f293d3a13a@syzkaller.appspotmail.com
Fixes: 28a65b49eb53 ("nilfs2: do not write dirty data after degenerating to read-only")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
