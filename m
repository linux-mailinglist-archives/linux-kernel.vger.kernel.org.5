Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D56D7EDAF7
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 05:47:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230272AbjKPErb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 23:47:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbjKPEr3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 23:47:29 -0500
Received: from mail-pg1-f205.google.com (mail-pg1-f205.google.com [209.85.215.205])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14C648F
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 20:47:26 -0800 (PST)
Received: by mail-pg1-f205.google.com with SMTP id 41be03b00d2f7-5bdfe231998so492299a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 20:47:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700110045; x=1700714845;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B60E/VSdBhhfKFYxTN6YDvuRBN0E3qm6OgTMvsAq+pU=;
        b=o02z75NWh6OjgvdY7/5FvsC7M5dJA8AipmGpL9RZBI/87hCTzqQY7wMtUfl9owIq5Y
         k2JjdvBWAeE3o3LuG3HRyzRJUL3Ed3i6+fKJZWhKnsRz8wxZ4jr/89v8Z5lBH+yL1rDF
         +6ky3VcFbi1UVIR4W9HSBJgr60TreUT7bj9lNsgw19gz2FNPCEUk8XcnVITejpEfFcMl
         2YnhboBsSynThZ3F/5JFo4sKT9sSaAhUT9JhVDDXEQIxrTcS8LCQm9FWSA8emwfWSJ6/
         kBY/t8ZS6Mp3R+4QNWzeboGoDrX9OOhPE3xjBKTmZHEavY0/8/1vaW9Us37mIgqw8HFW
         gnQQ==
X-Gm-Message-State: AOJu0Yx4zkF1pZq0jVK/ffeIQE2QeamMqNrz4TUY3BN8tU0DhtIBMOc7
        3ONzNDJP0L7SJ62aBt7GGOHEWCfLtcWhar3Ft9p6q2z0Hsdk
X-Google-Smtp-Source: AGHT+IHPtyQjXNQZPaOSDXTVSo/+hmMbdHFhPf7MQsja0dDhW1Ykr1q//Kd4+tGp+xY4ldpBErXeZFx0yDI+amb/6KjaSarLSwIN
MIME-Version: 1.0
X-Received: by 2002:a63:2603:0:b0:5bd:29ba:452a with SMTP id
 m3-20020a632603000000b005bd29ba452amr143632pgm.6.1700110045561; Wed, 15 Nov
 2023 20:47:25 -0800 (PST)
Date:   Wed, 15 Nov 2023 20:47:25 -0800
In-Reply-To: <000000000000bc90a60607f41fc3@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000584a26060a3db788@google.com>
Subject: Re: [syzbot] [kasan?] [mm?] WARNING in __kfence_free (3)
From:   syzbot <syzbot+59f37b0ab4c558a5357c@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, andreyknvl@gmail.com,
        dvyukov@google.com, elver@google.com, glider@google.com,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, muchun.song@linux.dev,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    c42d9eeef8e5 Merge tag 'hardening-v6.7-rc2' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13de8198e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=65a222833c8bc575
dashboard link: https://syzkaller.appspot.com/bug?extid=59f37b0ab4c558a5357c
compiler:       aarch64-linux-gnu-gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15bd8f98e80000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/384ffdcca292/non_bootable_disk-c42d9eee.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e62e8cdf4401/vmlinux-c42d9eee.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d4650ef9b454/Image-c42d9eee.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+59f37b0ab4c558a5357c@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 138 at mm/kfence/core.c:1147 __kfence_free+0x7c/0xb4 mm/kfence/core.c:1147
Modules linked in:
CPU: 0 PID: 138 Comm: kworker/u4:6 Not tainted 6.7.0-rc1-syzkaller-00019-gc42d9eeef8e5 #0
Hardware name: linux,dummy-virt (DT)
Workqueue: events_unbound bpf_map_free_deferred
pstate: 81400009 (Nzcv daif +PAN -UAO -TCO +DIT -SSBS BTYPE=--)
pc : __kfence_free+0x7c/0xb4 mm/kfence/core.c:1147
lr : kfence_free include/linux/kfence.h:187 [inline]
lr : __slab_free+0x48c/0x508 mm/slub.c:3614
sp : ffff800082c3bbb0
x29: ffff800082c3bbb0 x28: faff000002c03e00 x27: 0000000000000000
x26: f4ff000002c18028 x25: ffff00007ff8f138 x24: ffff00007ff8f000
x23: 0000000000000001 x22: ffff00007ff8f000 x21: ffff00007ff8f000
x20: ffff80008024297c x19: fffffc0001ffe3c0 x18: 0000000000000000
x17: 0000000000000000 x16: 0000000000000000 x15: 00000000200122aa
x14: 0000000000000273 x13: 0000000000000000 x12: 0000000000000001
x11: 0000000000000001 x10: 40fbfcfeb3055ba3 x9 : 0000000000000000
x8 : ffff800082c3bc90 x7 : 0000000000000000 x6 : 0000000000000000
x5 : ffff80008024297c x4 : ffff00007f868000 x3 : ffff8000824a02b8
x2 : f0ff000008cd7140 x1 : ffff00007f8a1350 x0 : ffff00007ff8f000
Call trace:
 __kfence_free+0x7c/0xb4 mm/kfence/core.c:1147
 kfence_free include/linux/kfence.h:187 [inline]
 __slab_free+0x48c/0x508 mm/slub.c:3614
 do_slab_free mm/slub.c:3757 [inline]
 slab_free mm/slub.c:3810 [inline]
 __kmem_cache_free+0x220/0x230 mm/slub.c:3822
 kfree+0x5c/0x74 mm/slab_common.c:1056
 kvfree+0x3c/0x4c mm/util.c:653
 bpf_map_area_free+0x10/0x1c kernel/bpf/syscall.c:325
 htab_map_free+0x134/0x298 kernel/bpf/hashtab.c:1556
 bpf_map_free_deferred+0x44/0x60 kernel/bpf/syscall.c:701
 process_one_work+0x148/0x258 kernel/workqueue.c:2630
 process_scheduled_works kernel/workqueue.c:2703 [inline]
 worker_thread+0x2b4/0x3cc kernel/workqueue.c:2784
 kthread+0x114/0x118 kernel/kthread.c:388
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:857
---[ end trace 0000000000000000 ]---


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
