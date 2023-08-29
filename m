Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF42A78C1A8
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 11:40:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234281AbjH2JkJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 05:40:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234927AbjH2Jj5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 05:39:57 -0400
Received: from mail-pl1-f205.google.com (mail-pl1-f205.google.com [209.85.214.205])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69EA510E
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 02:39:54 -0700 (PDT)
Received: by mail-pl1-f205.google.com with SMTP id d9443c01a7336-1c08a6763b3so52022915ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 02:39:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693301994; x=1693906794;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tnAtP1aZZWHUth6zJwSWbwkUuNeahcFCzK9nRGeZZTo=;
        b=PDI8c/12isBmOOZY1fPSKwT6Xnbl9lxPAEsV9udfCIaK7aHkulUGiCw7aNGZLv7LWx
         RVY6onfZUK5JA0Fsb5O/J7mHCNwek3r1mic8i5hg+1G0I4tollIfF6zXlz4QBZ0ePiVK
         Fuz+nhUBq+QeOpd72Iey/vSkwI+aLqtA3ho5bbLZ+mNtSkqfctkw/woR3cRBTE/GUz+g
         N8D+Lxim9KjDkcWDhHHBUuH0DhE64C8drKez3wJGemHerXAZsqreugzEldYTvUG+xo1b
         oYJpNQc2NzuEur99A3tlOvALJ2IZWIo5wX22++pEhTohDescDV6o0xZ4u27cXSC1ZFUK
         doog==
X-Gm-Message-State: AOJu0YwEvjg+gvqpoIEcxLV8izhK7lWfkIipCOJWvpP2yQi4Pf6iMcrG
        qmH+nPyz9iNtNgzzYqO1FBIS6niTEp41pYp7lyELNYUmegJP
X-Google-Smtp-Source: AGHT+IHV/i9lnyr2VOinyBuKVM5stvWJjOLu1kw4w5lCLKNaRzlspvJOQMADtR/M/sNK6hlILay+wDZax3nQ1tNeC3PTlb22Oh7e
MIME-Version: 1.0
X-Received: by 2002:a17:903:234e:b0:1bb:a13a:c21e with SMTP id
 c14-20020a170903234e00b001bba13ac21emr9497452plh.10.1693301993926; Tue, 29
 Aug 2023 02:39:53 -0700 (PDT)
Date:   Tue, 29 Aug 2023 02:39:53 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d87a7f06040c970c@google.com>
Subject: [syzbot] [bpf?] KCSAN: data-race in bpf_percpu_array_update /
 bpf_percpu_array_update (2)
From:   syzbot <syzbot+97522333291430dd277f@syzkaller.appspotmail.com>
To:     andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
        daniel@iogearbox.net, haoluo@google.com, john.fastabend@gmail.com,
        jolsa@kernel.org, kpsingh@kernel.org, linux-kernel@vger.kernel.org,
        martin.lau@linux.dev, sdf@google.com, song@kernel.org,
        syzkaller-bugs@googlegroups.com, yhs@fb.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_DIGITS,
        FROM_LOCAL_HEX,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    727dbda16b83 Merge tag 'hardening-v6.6-rc1' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=136f39dfa80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=dea9c2ce3f646a25
dashboard link: https://syzkaller.appspot.com/bug?extid=97522333291430dd277f
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/9923a023ab11/disk-727dbda1.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/650dbc695d77/vmlinux-727dbda1.xz
kernel image: https://storage.googleapis.com/syzbot-assets/361da71276bf/bzImage-727dbda1.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+97522333291430dd277f@syzkaller.appspotmail.com

==================================================================
BUG: KCSAN: data-race in bpf_percpu_array_update / bpf_percpu_array_update

write to 0xffffe8fffe7425d8 of 8 bytes by task 8257 on cpu 1:
 bpf_long_memcpy include/linux/bpf.h:428 [inline]
 bpf_obj_memcpy include/linux/bpf.h:441 [inline]
 copy_map_value_long include/linux/bpf.h:464 [inline]
 bpf_percpu_array_update+0x3bb/0x500 kernel/bpf/arraymap.c:380
 bpf_map_update_value+0x190/0x370 kernel/bpf/syscall.c:175
 generic_map_update_batch+0x3ae/0x4f0 kernel/bpf/syscall.c:1749
 bpf_map_do_batch+0x2df/0x3d0 kernel/bpf/syscall.c:4648
 __sys_bpf+0x28a/0x780
 __do_sys_bpf kernel/bpf/syscall.c:5241 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5239 [inline]
 __x64_sys_bpf+0x43/0x50 kernel/bpf/syscall.c:5239
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

write to 0xffffe8fffe7425d8 of 8 bytes by task 8268 on cpu 0:
 bpf_long_memcpy include/linux/bpf.h:428 [inline]
 bpf_obj_memcpy include/linux/bpf.h:441 [inline]
 copy_map_value_long include/linux/bpf.h:464 [inline]
 bpf_percpu_array_update+0x3bb/0x500 kernel/bpf/arraymap.c:380
 bpf_map_update_value+0x190/0x370 kernel/bpf/syscall.c:175
 generic_map_update_batch+0x3ae/0x4f0 kernel/bpf/syscall.c:1749
 bpf_map_do_batch+0x2df/0x3d0 kernel/bpf/syscall.c:4648
 __sys_bpf+0x28a/0x780
 __do_sys_bpf kernel/bpf/syscall.c:5241 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5239 [inline]
 __x64_sys_bpf+0x43/0x50 kernel/bpf/syscall.c:5239
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

value changed: 0x0000000000000000 -> 0xfffffff000002788

Reported by Kernel Concurrency Sanitizer on:
CPU: 0 PID: 8268 Comm: syz-executor.4 Not tainted 6.5.0-syzkaller-00453-g727dbda16b83 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/26/2023
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the bug is already fixed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
