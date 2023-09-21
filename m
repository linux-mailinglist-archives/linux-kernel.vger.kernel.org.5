Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE2817A99B4
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 20:17:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbjIUSRv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 14:17:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230377AbjIUSRd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 14:17:33 -0400
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com [209.85.160.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B0F079603
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 11:16:25 -0700 (PDT)
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-1c8f953e111so1693394fac.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 11:16:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695320123; x=1695924923;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5Q3qFJHo3XVshohtuwZiN/FL0niZyPiXxa7GA+BqUwY=;
        b=mP6HJ0yvQGkEa5ExKV/rRLk6iS3zsFhIUwpnZ1GTeRfF1+FEf5WUkYQ1Anyl7NHtSa
         we2OJcPpJ2OQ3Wl20/sLgDJmZn+sx0NZWMsCsGtRAKmmkjffzhPi7ghNxmEohf5ahPkL
         ZtOIcipB8Yb7sGRkHwqkGqT14dOvaaGE40KQGzU34DFeZ8skmNhfvJvKvCiF9QiWiIwC
         7P23zXxk81891P+DMQdZr4l4M3532kAh1v0FEariaC3aIblgZkaqqH6wvhFquCvnm9MA
         eFXTguB6kLQXgb6Bim8vVzFh/YoECCh2r+Bj3995UF5d9scxq4o6UFo8u4mMZ5ZGYiVA
         Bwsg==
X-Gm-Message-State: AOJu0YyOSpJ47syPkXAOUVQA0dTBMchR5p89o0m2/u/bnI0IkG1XzlNd
        GKcOAwVpjIIsgT5VvOu+KLPW9cDh534QwqQtYKcG1io7BQqI
X-Google-Smtp-Source: AGHT+IHHPQ+f83WOGBx5Q3jkh5OIGbhQpryoZz5a7eZICtLdsOv/3A7TNMHxgGgwmTb+a5OxHenITAsJd3MG+L4ZYu+uSSaU8Nmx
MIME-Version: 1.0
X-Received: by 2002:a05:6870:a8b2:b0:1c5:e4a5:6990 with SMTP id
 eb50-20020a056870a8b200b001c5e4a56990mr2450683oab.5.1695320123192; Thu, 21
 Sep 2023 11:15:23 -0700 (PDT)
Date:   Thu, 21 Sep 2023 11:15:23 -0700
In-Reply-To: <000000000000172fc905f8a19ab5@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b93c240605e27901@google.com>
Subject: Re: [syzbot] [btrfs?] WARNING in btrfs_commit_transaction (2)
From:   syzbot <syzbot+dafbca0e20fbc5946925@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, clm@fb.com, dsterba@suse.com,
        josef@toxicpanda.com, kristian@klausen.dk,
        linux-block@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this issue to:

commit 2b9ac22b12a266eb4fec246a07b504dd4983b16b
Author: Kristian Klausen <kristian@klausen.dk>
Date:   Fri Jun 18 11:51:57 2021 +0000

    loop: Fix missing discard support when using LOOP_CONFIGURE

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15dfb0f4680000
start commit:   57012c57536f Merge tag 'net-6.5-rc4' of git://git.kernel.o..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=17dfb0f4680000
console output: https://syzkaller.appspot.com/x/log.txt?x=13dfb0f4680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5f28dfd7d77a7042
dashboard link: https://syzkaller.appspot.com/bug?extid=dafbca0e20fbc5946925
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=173a6716a80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=111c7c7ea80000

Reported-by: syzbot+dafbca0e20fbc5946925@syzkaller.appspotmail.com
Fixes: 2b9ac22b12a2 ("loop: Fix missing discard support when using LOOP_CONFIGURE")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
