Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A9A6753C8E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 16:07:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235536AbjGNOHn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 10:07:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234943AbjGNOHl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 10:07:41 -0400
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com [209.85.210.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7BE71989
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 07:07:36 -0700 (PDT)
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-6b75153caabso3152504a34.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 07:07:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689343656; x=1691935656;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0IOprrGGFnJfjtmwD1fUwfmPU7ypMqJTctMsOUFhMYs=;
        b=aEbpKB1Gmc1pgDVgQCctRH0QAjENL55HipyjjMpk+UfjSPB0Xj5Agz3h1jRJ7Dbeah
         S+J0gi1nsXzNptu2rqi+BgIqut71arZTWSCvhmjNWypThNTaETicHY5jC35wB/4BnwSP
         uImjyuZpV1HPCFzvAUhGau6rH0vRsoCnhW6GSrV5DvJVAguFR5G9UzP5NC98d8g+Kl0A
         agAU+ivRHncLrhQ1ZCEjKVucRAJUeVzKhmy50+zjYAAl+R+qeuQoiM03dHzG+E8r/0OC
         VnQaFYG5+h3mz2V2SBnDCG6rVDoqHbRVzS4+Shemu7NsmbASUGZkI+u6OT5kpEuLdNPQ
         sclw==
X-Gm-Message-State: ABy/qLas/Iq+fEH8GnFuoIpe/FsRchnKqkw9UeJXVuNapDQUnoYFJskO
        uxIlbVVEzNZalY/SnRuGGpl15V+Ja4tK5y0g6iW78MYD9GTO
X-Google-Smtp-Source: APBJJlF1wPeUkxXiemiD+WX9+Ix0pvCKt0Kf7QBQmQ79wbSRipTvlhdd2qP6SyM5cV0i5dmwv4KRRpoQc1x3w3jvc+B2yk/Zmk2e
MIME-Version: 1.0
X-Received: by 2002:a05:6870:98b5:b0:1b0:59e5:2300 with SMTP id
 eg53-20020a05687098b500b001b059e52300mr4191351oab.8.1689343656165; Fri, 14
 Jul 2023 07:07:36 -0700 (PDT)
Date:   Fri, 14 Jul 2023 07:07:36 -0700
In-Reply-To: <0000000000001b4f6505fd59fb12@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000878978060072f85a@google.com>
Subject: Re: [syzbot] [ext4?] WARNING: locking bug in __ext4_ioctl
From:   syzbot <syzbot+a537ff48a9cb940d314c@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this issue to:

commit aff3bea95388299eec63440389b4545c8041b357
Author: Theodore Ts'o <tytso@mit.edu>
Date:   Wed May 24 03:49:51 2023 +0000

    ext4: add lockdep annotations for i_data_sem for ea_inode's

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=121e2492a80000
start commit:   a901a3568fd2 Merge tag 'iomap-6.5-merge-1' of git://git.ke..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=111e2492a80000
console output: https://syzkaller.appspot.com/x/log.txt?x=161e2492a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=12d3428a307a1111
dashboard link: https://syzkaller.appspot.com/bug?extid=a537ff48a9cb940d314c
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1489ffb8a80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=145c302ca80000

Reported-by: syzbot+a537ff48a9cb940d314c@syzkaller.appspotmail.com
Fixes: aff3bea95388 ("ext4: add lockdep annotations for i_data_sem for ea_inode's")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
