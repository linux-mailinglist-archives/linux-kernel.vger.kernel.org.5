Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 058427775D0
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 12:30:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234901AbjHJKa0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 06:30:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233670AbjHJKaY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 06:30:24 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8378183;
        Thu, 10 Aug 2023 03:30:23 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-4fe1489ced6so1113675e87.0;
        Thu, 10 Aug 2023 03:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691663422; x=1692268222;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CRzl5nclzSE8hR4x9ZVgXPrQ5iiewuXgP2wU5BbYhG0=;
        b=RBZanUwVFFXs1CRlsPWTD1D4rm2iN8WnvSdWQcm0eWFng4V+8snaze27DhZdpgd4ql
         LiAAA84oogziTrjzAYDplxwlOL+RUshSgz5D9g1xNtRVZ+YTt8SEekOhYSScCcjmvQBx
         nFDVyk5Eya1Eca3Ogiexf66I+S57NXp/C4j3YNdwSVfJ7n7rD5ItvmgEIG+BUpK2g30i
         v9Sbj8UDpaX2IYGvxwxrB5baM+875Zoo6S8mD4FwiLVFzzrkkmAyTt2UdIplwaErP6tF
         hZnVcytuHZiN13jh3ArDdaowG6WW3/d2z0u3lJza8KSn+Rsuz6/5YvT9JS6wU8KO4xip
         n8uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691663422; x=1692268222;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CRzl5nclzSE8hR4x9ZVgXPrQ5iiewuXgP2wU5BbYhG0=;
        b=VAmo+4mYrvap4PtMSxMjkkIRF5C/925/LGVfBVvHk32uxUC4dCnkdwtMub/PY8skK8
         vhKcsin6e2ZmS6l9wzVnNB66atytg0+6HhZ+MnBLYISVS9Gvp8i8hquhIewGCVIg7X4K
         XgYHCPZhXK5qDt17xAMj4SIaRmZagXP8VfmG1s6cnSCwFqBvuXB1/jrnX7J5K/2mezGd
         nTdiSNoQVqBYxMhXooUrLEbQPkqabkIaevqYk//2NWYhdFVMMO9vUiP/oJA2YpRt6vJ2
         OMl0BLGT23Wy8H1avso000VfO+pD1Nao7/MZOlm5PT143RvwDSQusqTZp7XTMn5aWEpe
         w47A==
X-Gm-Message-State: AOJu0Yy/yF0P/Ww9RfvaCaxr2/qNKpO/lBKoiGGk/9pODYASVCFTi2ly
        jqhSz0IkBijfitWL8RDOQzzqPLbLPfBsIAE0WNU=
X-Google-Smtp-Source: AGHT+IFF5T/KYxxDfL/io4fonk+A+iEVXXLlCbBtzsEf41My95uCty3JM29JO4VXWW0h5riEia+ThqYWu8HJZjYDFDA=
X-Received: by 2002:a05:6512:5c6:b0:4fb:8939:d95c with SMTP id
 o6-20020a05651205c600b004fb8939d95cmr1358995lfo.30.1691663421398; Thu, 10 Aug
 2023 03:30:21 -0700 (PDT)
MIME-Version: 1.0
From:   Yikebaer Aizezi <yikebaer61@gmail.com>
Date:   Thu, 10 Aug 2023 18:30:10 +0800
Message-ID: <CALcu4raN3=04gp5=f=sDMtTuTG0VZpunwqSVd8MNVcnfPe+t4w@mail.gmail.com>
Subject: possible deadlock in raw_setsockopt
To:     socketcan@hartkopp.net, mkl@pengutronix.de, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org,
        "pabeni@redhat.com" <pabeni@redhat.com>, linux-can@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

When using Healer to fuzz the Linux-6.5-rc3,  the following crash
was triggered.

HEAD commit: 6eaae198076080886b9e7d57f4ae06fa782f90ef (tag: v6.5-rc3)
git tree: upstream
console output:
https://drive.google.com/file/d/1d9rLH0SYwNhTm2datRKbVpET1irbx_tA/view?usp=drive_link
kernel config: https://drive.google.com/file/d/1OQIne-cVGeH6R4nqGGm6Igm3DnsozLhJ/view?usp=drive_link
C reproducer: https://drive.google.com/file/d/1iewyTDtNLkXAJSMnREXKNYcUwfN1mAqA/view?usp=drive_link
Syzlang reproducer:
https://drive.google.com/file/d/17p1lUipZkXyl9xE0_Qanerbg75W6ER5y/view?usp=drive_link

If you fix this issue, please add the following tag to the commit:
Reported-by: Yikebaer Aizezi <yikebaer61@gmail.com>

WARNING: possible circular locking dependency detected
6.5.0-rc3 #1 Not tainted
------------------------------------------------------
syz-executor/13006 is trying to acquire lock:
ffff88801ca69130 (sk_lock-AF_CAN){+.+.}-{0:0}, at: lock_sock
home/smyl/linux-image/linux-6.5-rc3/./include/net/sock.h:1708 [inline]
ffff88801ca69130 (sk_lock-AF_CAN){+.+.}-{0:0}, at:
raw_setsockopt+0x3b6/0x1050
home/smyl/linux-image/linux-6.5-rc3/net/can/raw.c:607

but task is already holding lock:
ffffffff8cdca268 (rtnl_mutex){+.+.}-{3:3}, at:
raw_setsockopt+0x3ac/0x1050
home/smyl/linux-image/linux-6.5-rc3/net/can/raw.c:606

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (rtnl_mutex){+.+.}-{3:3}:
       __mutex_lock_common
home/smyl/linux-image/linux-6.5-rc3/kernel/locking/mutex.c:603
[inline]
       __mutex_lock+0x14f/0x1440
home/smyl/linux-image/linux-6.5-rc3/kernel/locking/mutex.c:747
       raw_release+0x1bd/0x940
home/smyl/linux-image/linux-6.5-rc3/net/can/raw.c:391
       __sock_release+0xcd/0x290
home/smyl/linux-image/linux-6.5-rc3/net/socket.c:654
       sock_close+0x18/0x20
home/smyl/linux-image/linux-6.5-rc3/net/socket.c:1386
       __fput+0x391/0x9d0
home/smyl/linux-image/linux-6.5-rc3/fs/file_table.c:384
       task_work_run+0x153/0x230
home/smyl/linux-image/linux-6.5-rc3/kernel/task_work.c:179
       resume_user_mode_work
home/smyl/linux-image/linux-6.5-rc3/./include/linux/resume_user_mode.h:49
[inline]
       exit_to_user_mode_loop
home/smyl/linux-image/linux-6.5-rc3/kernel/entry/common.c:171 [inline]
       exit_to_user_mode_prepare+0x210/0x240
home/smyl/linux-image/linux-6.5-rc3/kernel/entry/common.c:204
       __syscall_exit_to_user_mode_work
home/smyl/linux-image/linux-6.5-rc3/kernel/entry/common.c:286 [inline]
       syscall_exit_to_user_mode+0x19/0x50
home/smyl/linux-image/linux-6.5-rc3/kernel/entry/common.c:297
       do_syscall_64+0x42/0xb0
home/smyl/linux-image/linux-6.5-rc3/arch/x86/entry/common.c:86
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

-> #0 (sk_lock-AF_CAN){+.+.}-{0:0}:
       check_prev_add
home/smyl/linux-image/linux-6.5-rc3/kernel/locking/lockdep.c:3142
[inline]
       check_prevs_add
home/smyl/linux-image/linux-6.5-rc3/kernel/locking/lockdep.c:3261
[inline]
       validate_chain
home/smyl/linux-image/linux-6.5-rc3/kernel/locking/lockdep.c:3876
[inline]
       __lock_acquire+0x2ecd/0x5b90
home/smyl/linux-image/linux-6.5-rc3/kernel/locking/lockdep.c:5144
       lock_acquire
home/smyl/linux-image/linux-6.5-rc3/kernel/locking/lockdep.c:5761
[inline]
       lock_acquire+0x1ad/0x520
home/smyl/linux-image/linux-6.5-rc3/kernel/locking/lockdep.c:5726
       lock_sock_nested+0x34/0xe0
home/smyl/linux-image/linux-6.5-rc3/net/core/sock.c:3492
       lock_sock
home/smyl/linux-image/linux-6.5-rc3/./include/net/sock.h:1708 [inline]
       raw_setsockopt+0x3b6/0x1050
home/smyl/linux-image/linux-6.5-rc3/net/can/raw.c:607
       __sys_setsockopt+0x252/0x510
home/smyl/linux-image/linux-6.5-rc3/net/socket.c:2263
       __do_sys_setsockopt
home/smyl/linux-image/linux-6.5-rc3/net/socket.c:2274 [inline]
       __se_sys_setsockopt
home/smyl/linux-image/linux-6.5-rc3/net/socket.c:2271 [inline]
       __x64_sys_setsockopt+0xb9/0x150
home/smyl/linux-image/linux-6.5-rc3/net/socket.c:2271
       do_syscall_x64
home/smyl/linux-image/linux-6.5-rc3/arch/x86/entry/common.c:50
[inline]
       do_syscall_64+0x35/0xb0
home/smyl/linux-image/linux-6.5-rc3/arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(rtnl_mutex);
                               lock(sk_lock-AF_CAN);
                               lock(rtnl_mutex);
  lock(sk_lock-AF_CAN);

 *** DEADLOCK ***

1 lock held by syz-executor/13006:
 #0: ffffffff8cdca268 (rtnl_mutex){+.+.}-{3:3}, at:
raw_setsockopt+0x3ac/0x1050
home/smyl/linux-image/linux-6.5-rc3/net/can/raw.c:606

stack backtrace:
CPU: 0 PID: 13006 Comm: syz-executor Not tainted 6.5.0-rc3 #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
Call Trace:
 <TASK>
 __dump_stack home/smyl/linux-image/linux-6.5-rc3/lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x92/0xf0
home/smyl/linux-image/linux-6.5-rc3/lib/dump_stack.c:106
 check_noncircular+0x2ef/0x3d0
home/smyl/linux-image/linux-6.5-rc3/kernel/locking/lockdep.c:2195
 check_prev_add
home/smyl/linux-image/linux-6.5-rc3/kernel/locking/lockdep.c:3142
[inline]
 check_prevs_add
home/smyl/linux-image/linux-6.5-rc3/kernel/locking/lockdep.c:3261
[inline]
 validate_chain
home/smyl/linux-image/linux-6.5-rc3/kernel/locking/lockdep.c:3876
[inline]
 __lock_acquire+0x2ecd/0x5b90
home/smyl/linux-image/linux-6.5-rc3/kernel/locking/lockdep.c:5144
 lock_acquire home/smyl/linux-image/linux-6.5-rc3/kernel/locking/lockdep.c:5761
[inline]
 lock_acquire+0x1ad/0x520
home/smyl/linux-image/linux-6.5-rc3/kernel/locking/lockdep.c:5726
 lock_sock_nested+0x34/0xe0
home/smyl/linux-image/linux-6.5-rc3/net/core/sock.c:3492
 lock_sock home/smyl/linux-image/linux-6.5-rc3/./include/net/sock.h:1708
[inline]
 raw_setsockopt+0x3b6/0x1050
home/smyl/linux-image/linux-6.5-rc3/net/can/raw.c:607
 __sys_setsockopt+0x252/0x510
home/smyl/linux-image/linux-6.5-rc3/net/socket.c:2263
 __do_sys_setsockopt
home/smyl/linux-image/linux-6.5-rc3/net/socket.c:2274 [inline]
 __se_sys_setsockopt
home/smyl/linux-image/linux-6.5-rc3/net/socket.c:2271 [inline]
 __x64_sys_setsockopt+0xb9/0x150
home/smyl/linux-image/linux-6.5-rc3/net/socket.c:2271
 do_syscall_x64
home/smyl/linux-image/linux-6.5-rc3/arch/x86/entry/common.c:50
[inline]
 do_syscall_64+0x35/0xb0
home/smyl/linux-image/linux-6.5-rc3/arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x47959d
Code: 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa 48 89 f8 48
89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
01 f0 ff ff 73 01 c3 48 c7 c1 b4 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f1c93598068 EFLAGS: 00000246 ORIG_RAX: 0000000000000036
RAX: ffffffffffffffda RBX: 000000000059c0a0 RCX: 000000000047959d
RDX: 0000000000000002 RSI: 0000000000000065 RDI: 0000000000000003
RBP: 000000000059c0a0 R08: 0000000000000004 R09: 0000000000000000
R10: 00000000200001c0 R11: 0000000000000246 R12: 000000000059c0ac
R13: 000000000000000b R14: 0000000000437250 R15: 00007f1c93578000
 </TASK>
