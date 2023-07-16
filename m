Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4A79754D27
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jul 2023 04:40:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbjGPCjc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jul 2023 22:39:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjGPCjb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jul 2023 22:39:31 -0400
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com [209.85.160.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AAA62706
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jul 2023 19:39:30 -0700 (PDT)
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-1b03f7fb970so5504286fac.1
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jul 2023 19:39:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689475169; x=1692067169;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xG09JZxqOrw1L6EfbniONqYxyep/zmWpR23t4FhnfmI=;
        b=C/wacyR/IzZCO84x1+/qajvNplbkk3utW4gw3xVXxyPZAUWLLi6a3sSDifQibJNRGk
         YQTn0e1mpy3vdZgrsd6tdiNVz2MLTYBq4WHFQf5ix8ihTqmLWOo6gl/PxAGKTv0FcM14
         XB/7Pzwa8qsm2KZ20ZNq49GY3+S0EfgUekGSeYtyiLJz9X7pka9JjNAs85hYYKGGmIzH
         oc1G/qhy6XkWmRY1BNapFEm3AJE5Y3Za/tGZ2H+3ldaQLmRgKLzJIgYgcThM1AtEQsBr
         eJlm4Zm13thodj75/rJCT8r1GJ+H7Kbo6lgjxdXEEX6mAAiJuUZCV5whS3pxvi1jV/cL
         BGRA==
X-Gm-Message-State: ABy/qLY2shDf7C9CH+w4cfdWVQndTgoDc1U2WXXuFSissliBIQf8AwFw
        gXq9CRE9uOXuHC51akMP2duT9OgcF01g0flTppJd5sjVW+R/
X-Google-Smtp-Source: APBJJlGGhOt82SBtGgxfZ9Q2rPKFkTyiJ4HHXp0D60srI/u6r+nhGseV+PrEoM9VlWPSOBAAbABGg9sx+Rx1D9L9/9DFFu7IuGPv
MIME-Version: 1.0
X-Received: by 2002:a05:6870:b7ae:b0:1b0:328b:876a with SMTP id
 ed46-20020a056870b7ae00b001b0328b876amr7963469oab.1.1689475169698; Sat, 15
 Jul 2023 19:39:29 -0700 (PDT)
Date:   Sat, 15 Jul 2023 19:39:29 -0700
In-Reply-To: <20230716020304.64-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000058c8a8060091977a@google.com>
Subject: Re: [syzbot] [wireless?] WARNING in sta_info_insert_rcu (3)
From:   syzbot <syzbot+2676771ed06a6df166ad@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
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

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING in ieee80211_link_release_channel

wlan1: Creating new IBSS network, BSSID 50:50:50:50:50:50
wlan1: authenticate with 08:02:11:00:00:01
wlan1: failed to insert STA entry for the AP (error -22)
------------[ cut here ]------------
WARNING: CPU: 1 PID: 5411 at net/mac80211/chan.c:2021 ieee80211_link_release_channel+0x19f/0x200 net/mac80211/chan.c:2021
Modules linked in:
CPU: 1 PID: 5411 Comm: kworker/1:4 Not tainted 6.5.0-rc1-syzkaller-00006-g3f01e9fed845-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/03/2023
Workqueue: events cfg80211_conn_work
RIP: 0010:ieee80211_link_release_channel+0x19f/0x200 net/mac80211/chan.c:2021
Code: ff ff ff ff 48 8d b8 f0 1c 00 00 e8 db 25 78 00 31 ff 41 89 c5 89 c6 e8 af de d7 f7 45 85 ed 0f 85 6d ff ff ff e8 31 e3 d7 f7 <0f> 0b e9 61 ff ff ff 48 c7 c7 70 b3 ab 8e e8 5e 76 2b f8 e9 3a ff
RSP: 0018:ffffc9000531f2a0 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffff888077f0e3a8 RCX: 0000000000000000
RDX: ffff88801f54d940 RSI: ffffffff89add36f RDI: 0000000000000005
RBP: ffff888077f0cc80 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000000 R11: 000000000000001f R12: ffff888077f0d580
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055caf027a950 CR3: 000000002c7e4000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 ieee80211_prep_connection+0x62a/0x14f0 net/mac80211/mlme.c:7065
 ieee80211_mgd_auth+0xa1a/0x1470 net/mac80211/mlme.c:7205
 rdev_auth net/wireless/rdev-ops.h:481 [inline]
 cfg80211_mlme_auth+0x3b3/0x710 net/wireless/mlme.c:284
 cfg80211_conn_do_work+0x64e/0xfe0 net/wireless/sme.c:181
 cfg80211_conn_work+0x27f/0x3d0 net/wireless/sme.c:273
 process_one_work+0xaa2/0x16f0 kernel/workqueue.c:2597
 worker_thread+0x687/0x1110 kernel/workqueue.c:2748
 kthread+0x33a/0x430 kernel/kthread.c:389
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
 </TASK>


Tested on:

commit:         3f01e9fe Merge tag 'linux-watchdog-6.5-rc2' of git://w..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1738ebe4a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=87ef4ae61b35aae1
dashboard link: https://syzkaller.appspot.com/bug?extid=2676771ed06a6df166ad
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1684f646a80000

