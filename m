Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 552FA7F0A2B
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 01:46:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231629AbjKTAqN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 19:46:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjKTAqL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 19:46:11 -0500
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F1D6115
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 16:46:08 -0800 (PST)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-5c1b986082dso4151037a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 16:46:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700441167; x=1701045967;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2txSm9UGUwpLgLdAOJ0OSwaBHLVEwFDxBDR6/HY/ML4=;
        b=sk1D0EZ8r8FlJoSObLBKO/oxPcInYtqj+8ysilG1NguO8JW53dyaEOOcWBAlbWbfpk
         uovdLjJ6GdkbMR+0OeYbCUW3RyzafFMFmqSbyeUvhr39KAGoT8OtDjO86V8vvTxBifMq
         oRpQkdfFkcbLYI3bD5W9ZjF8HljVqFyTWye3VM0yM/6y5rubo88sR6bFeWWp0AjmYsD6
         z7LrVrcvm0V+n8NgIJI43K05wbeKXxagNBvh6Jwh07BED8n+ZkOtnJfWBowoKvOBwFe6
         RASd39TWEHOgK8+nOi+67Ji25j0kZbZegp6jVkKyxnCrc4jRJtpfevoA9AmWNq8QxF7e
         7+1A==
X-Gm-Message-State: AOJu0YzQf8v+Bnhv/vtqSSl17FU+AWalBUrUFISiCzH0nRQkrXw2yn70
        jMhk5oVI7vVnUFFjcCqYf85i0LKY2arQBkwDPtfOrrwbSVcc
X-Google-Smtp-Source: AGHT+IHYvIaqMCBB8Jfg4ekh+NG8JNofrsRjFclRyaEgn7EwGNfT1ENUkbiwoHBcAi9NPZcuWup9IQv6qu0HTxFbWlt4eeIz1fLE
MIME-Version: 1.0
X-Received: by 2002:a65:689a:0:b0:5be:4f:8c34 with SMTP id e26-20020a65689a000000b005be004f8c34mr1288013pgt.6.1700441167626;
 Sun, 19 Nov 2023 16:46:07 -0800 (PST)
Date:   Sun, 19 Nov 2023 16:46:07 -0800
In-Reply-To: <000000000000cf826706067d18fd@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c206db060a8acf37@google.com>
Subject: Re: [syzbot] [btrfs?] WARNING in btrfs_release_global_block_rsv
From:   syzbot <syzbot+10e8dae9863cb83db623@syzkaller.appspotmail.com>
To:     clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, nborisov@suse.com,
        syzkaller-bugs@googlegroups.com
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

commit c18e3235646a8ba74d013067a6475c8d262d3776
Author: Josef Bacik <josef@toxicpanda.com>
Date:   Thu Dec 2 20:34:32 2021 +0000

    btrfs: reserve extra space for the free space tree

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10528fb7680000
start commit:   23dfa043f6d5 Merge tag 'i2c-for-6.7-rc2' of git://git.kern..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=12528fb7680000
console output: https://syzkaller.appspot.com/x/log.txt?x=14528fb7680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d05dd66e2eb2c872
dashboard link: https://syzkaller.appspot.com/bug?extid=10e8dae9863cb83db623
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17722e24e80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11201350e80000

Reported-by: syzbot+10e8dae9863cb83db623@syzkaller.appspotmail.com
Fixes: c18e3235646a ("btrfs: reserve extra space for the free space tree")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
