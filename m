Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69EC67689E6
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 04:13:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229459AbjGaCNc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 22:13:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjGaCNa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 22:13:30 -0400
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com [209.85.210.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B50C7E50
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 19:13:29 -0700 (PDT)
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-6b9f057f6daso7905413a34.0
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 19:13:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690769609; x=1691374409;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GPkgU757mcAfVErB4JqXmP6kqt1Ainnk7Zov9FfgpnM=;
        b=as8SJJJItNktXHJhDYsmRgAduWey9F/N/vumcPCFnd9/q/ywFxvfSq+NGgyKIGxYR7
         vBh6Lmg/6SwgpfvgeRw+13UrLtBJkOklrUgg4UhDTtO0mZDUR3XClUbMM5eFUS2XGVNo
         Nt4VuKTdmSy+X/g1Sntci5+Wy9Yenk1EEgzB9rdcH9Jh7RZ6Y93tnHM9dBw8Jhm58Aoc
         tMx6oe7HOjxVs5gl41MaRplOR6Xs29O4AoPV6kjU3PO7j56ViIZZxe53yRkv9l5a2HZ7
         9MUrV77QihzA2DxNLU8LfkOVBQZ4o3TVPqU1fnAISyHy4OHr6h4o77IvrdESBniehvHB
         EooQ==
X-Gm-Message-State: ABy/qLbUTb1fR3wLt8ry3BXke3yeaFkflbu0VfDRU00mPrKf16KPyMZb
        X/XCFkuvZR8JjTxtvnsLzEf9VujDir3UpD9pWVcD1WODZSTW
X-Google-Smtp-Source: APBJJlGXOGBA2AgNlWNY31LIsNq0WRqp6IlSCViwbyXiU2fsMGi3dC8fkFp/KA9wRkqtorpwD5/slNt3e/VUr55xOY+neabpk0dh
MIME-Version: 1.0
X-Received: by 2002:a05:6870:76b3:b0:1bb:3cab:49b0 with SMTP id
 dx51-20020a05687076b300b001bb3cab49b0mr10439028oab.6.1690769609114; Sun, 30
 Jul 2023 19:13:29 -0700 (PDT)
Date:   Sun, 30 Jul 2023 19:13:29 -0700
In-Reply-To: <000000000000a3d67705ff730522@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f2ca8f0601bef9ca@google.com>
Subject: Re: [syzbot] [btrfs?] kernel BUG in prepare_to_merge
From:   syzbot <syzbot+ae97a827ae1c3336bbb4@syzkaller.appspotmail.com>
To:     clm@fb.com, dsterba@suse.com, hch@lst.de,
        johannes.thumshirn@wdc.com, josef@toxicpanda.com,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this issue to:

commit 85724171b302914bb8999b9df091fd4616a36eb7
Author: Christoph Hellwig <hch@lst.de>
Date:   Tue May 23 08:40:18 2023 +0000

    btrfs: fix the btrfs_get_global_root return value

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12343ac5a80000
start commit:   d192f5382581 Merge tag 'arm64-fixes' of git://git.kernel.o..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=11343ac5a80000
console output: https://syzkaller.appspot.com/x/log.txt?x=16343ac5a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a4507c291b5ab5d4
dashboard link: https://syzkaller.appspot.com/bug?extid=ae97a827ae1c3336bbb4
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1230cc11a80000

Reported-by: syzbot+ae97a827ae1c3336bbb4@syzkaller.appspotmail.com
Fixes: 85724171b302 ("btrfs: fix the btrfs_get_global_root return value")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
