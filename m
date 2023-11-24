Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED5D17F6A9E
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 03:23:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230176AbjKXCXE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 21:23:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjKXCXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 21:23:01 -0500
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 108DC1A5
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 18:23:08 -0800 (PST)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-5c1b986082dso1262670a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 18:23:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700792587; x=1701397387;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YCxfKihPbjIwpQDGt4RhoWw7YYRf68ochVH+b7hzmIA=;
        b=Xaehiwtu2vCFLQW7TWrJn1wRaZWUxKhaG7XTpy7/DKxl9Nq8ek+m4NCzXUehpGUHnM
         fRTt/1y+QJ8fSN5UNFLuz1b46Q+nJC/GNuQyWoguNkl9TCBheLNLH8hsQckASo/W06uM
         9/zDezAQ7XFkBH58kBAXmnhu9KZ1rGucEZx0jDYG4o0wWO2fA2UG4ygUYShicJA0DW/U
         W6ArpsEK6HHiO3I1lsHWThqOfGUZm9ibcdZEuzPHPXHJsExf7qaCWZjUWYj/U1xykEJJ
         jNzO9jqvJVgghj8lRP47YsDD0ooSLRClIUeNMRzGGdZl1ADEJo9ecCkSG9GRsgAZx805
         865Q==
X-Gm-Message-State: AOJu0YzT1wnoZWPuXDhk3K7OyMiffsP23PBEITqR8EARiTG56NqT6fEV
        hwmRUjuob2k7s44dfGEW53X2xGCtAo/Omc1pz/4IaCMCSO4DC28=
X-Google-Smtp-Source: AGHT+IHX4ht44SHfeRo33dgfe8kmzCoQTjGJlKSS0ipdn0nvvjUuUE7ava+8gbO+7otxAt5gZP8aXZFtM+t06fZYqDLxBRGRBkH4
MIME-Version: 1.0
X-Received: by 2002:a63:d349:0:b0:5aa:ea99:9eca with SMTP id
 u9-20020a63d349000000b005aaea999ecamr933394pgi.2.1700792587574; Thu, 23 Nov
 2023 18:23:07 -0800 (PST)
Date:   Thu, 23 Nov 2023 18:23:07 -0800
In-Reply-To: <20231124020744.3444746-1-lizhi.xu@windriver.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000004e292060adca2a4@google.com>
Subject: Re: [syzbot] [ntfs3?] WARNING in indx_insert_into_buffer
From:   syzbot <syzbot+c5b339d16ffa61fd512d@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, lizhi.xu@windriver.com,
        syzkaller-bugs@googlegroups.com
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

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING in indx_insert_into_buffer

R13: 000000000000000b R14: 00007fd9bef9bf80 R15: 00007ffebe4b2ef8
 </TASK>
------------[ cut here ]------------
memcpy: detected field-spanning write (size 3960) of single field "hdr1" at fs/ntfs3/index.c:1914 (size 16)
WARNING: CPU: 2 PID: 5485 at fs/ntfs3/index.c:1914 indx_insert_into_buffer.isra.0+0xfb5/0x1280 fs/ntfs3/index.c:1914
Modules linked in:
CPU: 2 PID: 5485 Comm: syz-executor.0 Not tainted 6.7.0-rc1-syzkaller-00344-g037266a5f723-dirty #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
RIP: 0010:indx_insert_into_buffer.isra.0+0xfb5/0x1280 fs/ntfs3/index.c:1914
Code: c1 ca c1 fe c6 05 a3 cb 3d 0c 01 90 48 8b 74 24 70 b9 10 00 00 00 48 c7 c2 80 cf 03 8b 48 c7 c7 e0 cf 03 8b e8 8c e9 87 fe 90 <0f> 0b 90 90 e9 1b fe ff ff 48 c7 44 24 68 00 00 00 00 31 db e9 10
RSP: 0018:ffffc900038af6e8 EFLAGS: 00010282
RAX: 0000000000000000 RBX: 00000000fffffff4 RCX: ffffffff814ca799
RDX: ffff8880222e4dc0 RSI: ffffffff814ca7a6 RDI: 0000000000000001
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000005 R12: ffff88802706dc00
R13: ffff88801884e8a0 R14: ffff88802c277800 R15: ffff88803cbfc018
FS:  00007fd9be1fe6c0(0000) GS:ffff88806b800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055d70cb94300 CR3: 0000000022a5c000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 indx_insert_entry+0x1a5/0x460 fs/ntfs3/index.c:1983
 ni_add_name+0x4d9/0x820 fs/ntfs3/frecord.c:3055
 ni_rename+0xa1/0x1a0 fs/ntfs3/frecord.c:3087
 ntfs_rename+0x91f/0xec0 fs/ntfs3/namei.c:322
 vfs_rename+0x13e0/0x1c30 fs/namei.c:4844
 do_renameat2+0xc3c/0xdc0 fs/namei.c:4996
 __do_sys_rename fs/namei.c:5042 [inline]
 __se_sys_rename fs/namei.c:5040 [inline]
 __x64_sys_rename+0x81/0xa0 fs/namei.c:5040
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x40/0x110 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7fd9bee7cae9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fd9be1fe0c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000052
RAX: ffffffffffffffda RBX: 00007fd9bef9bf80 RCX: 00007fd9bee7cae9
RDX: 0000000000000000 RSI: 0000000020000a40 RDI: 0000000020000300
RBP: 00007fd9be1fe120 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000002
R13: 000000000000000b R14: 00007fd9bef9bf80 R15: 00007ffebe4b2ef8
 </TASK>


Tested on:

commit:         037266a5 Merge tag 'scsi-fixes' of git://git.kernel.or..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1108b462e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=af04b7c4d36966d8
dashboard link: https://syzkaller.appspot.com/bug?extid=c5b339d16ffa61fd512d
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=106b88ece80000

