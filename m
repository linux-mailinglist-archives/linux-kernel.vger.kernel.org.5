Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD3047A6ACA
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 20:40:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232276AbjISSkq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 14:40:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbjISSkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 14:40:45 -0400
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com [209.85.161.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E4299D
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 11:40:39 -0700 (PDT)
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-5712ca7aba8so144406eaf.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 11:40:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695148838; x=1695753638;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IaIoKNYeLS5sH/XJ+eUU4nVbsgYjjg2oMliRDd8I4aE=;
        b=SoawsuA/KMFZxNpNP7vxjsmXWbi86fWSC2frWLEmGtWXUlQvfmV1JcSe1i4sGo4fzy
         XyMCT/rFy8px/9hdlt2JT4rfIc0aS/H8WO2MUIVub5BFPeOXiXFXZ0QGXOt33VKQoDQg
         NDCH5jkcfxS3mBwmCaSX0SKfbV6oo+TMM0rp8CQAo1VZ8krzMqNLhvqgg2KWwmeKyAfm
         670pourrHtD3gT8yFG/Ly9kDM2KF+fxH9fg9YoEp4xF1nEjHtsYvltLhSBky3Sg5D+RU
         4bocs3rJEbMbzNZkUSrEStKLPgivGj7IBeJA5MTs9LdEG0mzgPUcEE0njWS22HMDdH9I
         p2MA==
X-Gm-Message-State: AOJu0YxrjohMPf2xqyx6QTdCk1g0RWkwWMDbailn/9hAaWEit/0WBQ+N
        C6dAFUsKjsHlZdu78kJe/HbSNA1Cs6F9ufDxZm0RhMvUkZ4GfLc=
X-Google-Smtp-Source: AGHT+IHElozDWZ4ARLzJqH8kpR1ziTXW32liJCwAjlNBPb4ayKMDwuq534Hzpig5uKKXP2Mma1N03Ttr0TNb3hY7/9F5v9jPC8ap
MIME-Version: 1.0
X-Received: by 2002:a05:6808:30a1:b0:3a7:361:f50 with SMTP id
 bl33-20020a05680830a100b003a703610f50mr1523003oib.3.1695148838485; Tue, 19
 Sep 2023 11:40:38 -0700 (PDT)
Date:   Tue, 19 Sep 2023 11:40:38 -0700
In-Reply-To: <albu6mqbrom746yngcfgtuhn6ydpf4ewapqj6wk6etlkw7qda4@tzlqwq6u5s54>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005c048a0605ba98f0@google.com>
Subject: Re: [syzbot] [media?] [usb?] KASAN: slab-out-of-bounds Read in imon_probe
From:   syzbot <syzbot+59875ffef5cb9c9b29e9@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-usb@vger.kernel.org, mchehab@kernel.org,
        ricardo@marliere.net, sean@mess.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING in imon_probe

WARNING: CPU: 0 PID: 1384 at kernel/locking/mutex.c:582 __mutex_lock_common kernel/locking/mutex.c:582 [inline]
WARNING: CPU: 0 PID: 1384 at kernel/locking/mutex.c:582 __mutex_lock+0x63e/0xa56 kernel/locking/mutex.c:747
Modules linked in:
CPU: 0 PID: 1384 Comm: kworker/0:2 Not tainted 6.6.0-rc2-next-20230919-syzkaller-g29e400e3ea48 #0
Hardware name: riscv-virtio,qemu (DT)
Workqueue: usb_hub_wq hub_event
epc : __mutex_lock_common kernel/locking/mutex.c:582 [inline]
epc : __mutex_lock+0x63e/0xa56 kernel/locking/mutex.c:747
 ra : __mutex_lock_common kernel/locking/mutex.c:582 [inline]
 ra : __mutex_lock+0x63e/0xa56 kernel/locking/mutex.c:747
epc : ffffffff8362613e ra : ffffffff8362613e sp : ff200000040e6bc0
 gp : ffffffff861a8a20 tp : ff60000013168000 t0 : ffffffff852a92a0
 t1 : 00000000000f0000 t2 : 2d2d2d2d2d2d2d2d s0 : ff200000040e6d40
 s1 : ff600000223f69a8 a0 : 0000000000000001 a1 : 00000000000f0000
 a2 : ffffffff80077fb0 a3 : 0000000000000002 a4 : 0000000000000000
 a5 : 0000000000000000 a6 : 0000000000000003 a7 : 0000000000000000
 s2 : ff200000040e6cc0 s3 : 0000000000000000 s4 : ff200000040e6c50
 s5 : ffffffff861d5880 s6 : 0000000000000002 s7 : 0000000000000000
 s8 : 1fe400000081cd80 s9 : ff60000022f6b000 s10: 0000000000000001
 s11: ffffffffffffffed t3 : ffffffff80158656 t4 : ffebffff0f9ac56a
 t5 : ffebffff0f9ac56b t6 : ff200000040e6778
status: 0000000200000120 badaddr: 0000000000000000 cause: 0000000000000003
[<ffffffff8362613e>] __mutex_lock_common kernel/locking/mutex.c:582 [inline]
[<ffffffff8362613e>] __mutex_lock+0x63e/0xa56 kernel/locking/mutex.c:747
[<ffffffff8362656a>] mutex_lock_nested+0x14/0x1c kernel/locking/mutex.c:799
[<ffffffff82205abc>] imon_init_intf1 drivers/media/rc/imon.c:2321 [inline]
[<ffffffff82205abc>] imon_probe+0x128/0x1ab2 drivers/media/rc/imon.c:2449
[<ffffffff81d8ec8c>] usb_probe_interface+0x208/0x552 drivers/usb/core/driver.c:396
[<ffffffff816837fa>] call_driver_probe drivers/base/dd.c:579 [inline]
[<ffffffff816837fa>] really_probe+0x1c8/0x7c6 drivers/base/dd.c:658
[<ffffffff81683f36>] __driver_probe_device+0x13e/0x2ae drivers/base/dd.c:800
[<ffffffff81684106>] driver_probe_device+0x60/0x1a6 drivers/base/dd.c:830
[<ffffffff816843b4>] __device_attach_driver+0x168/0x218 drivers/base/dd.c:958
[<ffffffff8167f734>] bus_for_each_drv+0x12c/0x1ae drivers/base/bus.c:457
[<ffffffff81684c30>] __device_attach+0x184/0x390 drivers/base/dd.c:1030
[<ffffffff81685146>] device_initial_probe+0x1c/0x26 drivers/base/dd.c:1079
[<ffffffff816817f8>] bus_probe_device+0x120/0x122 drivers/base/bus.c:532
[<ffffffff8167c302>] device_add+0xce6/0x105c drivers/base/core.c:3624
[<ffffffff81d8acba>] usb_set_configuration+0xb48/0xfb6 drivers/usb/core/message.c:2207
[<ffffffff81da5b7a>] usb_generic_driver_probe+0xb2/0x124 drivers/usb/core/generic.c:238
[<ffffffff81d8e09e>] usb_probe_device+0x9e/0x1fc drivers/usb/core/driver.c:293
[<ffffffff816837fa>] call_driver_probe drivers/base/dd.c:579 [inline]
[<ffffffff816837fa>] really_probe+0x1c8/0x7c6 drivers/base/dd.c:658
[<ffffffff81683f36>] __driver_probe_device+0x13e/0x2ae drivers/base/dd.c:800
[<ffffffff81684106>] driver_probe_device+0x60/0x1a6 drivers/base/dd.c:830
[<ffffffff816843b4>] __device_attach_driver+0x168/0x218 drivers/base/dd.c:958
[<ffffffff8167f734>] bus_for_each_drv+0x12c/0x1ae drivers/base/bus.c:457
[<ffffffff81684c30>] __device_attach+0x184/0x390 drivers/base/dd.c:1030
[<ffffffff81685146>] device_initial_probe+0x1c/0x26 drivers/base/dd.c:1079
[<ffffffff816817f8>] bus_probe_device+0x120/0x122 drivers/base/bus.c:532
[<ffffffff8167c302>] device_add+0xce6/0x105c drivers/base/core.c:3624
[<ffffffff81d73702>] usb_new_device+0x5c8/0xd38 drivers/usb/core/hub.c:2589
[<ffffffff81d77fdc>] hub_port_connect drivers/usb/core/hub.c:5440 [inline]
[<ffffffff81d77fdc>] hub_port_connect_change drivers/usb/core/hub.c:5580 [inline]
[<ffffffff81d77fdc>] port_event drivers/usb/core/hub.c:5740 [inline]
[<ffffffff81d77fdc>] hub_event+0x2016/0x30aa drivers/usb/core/hub.c:5822
[<ffffffff800c4484>] process_one_work+0x54c/0xd66 kernel/workqueue.c:2630
[<ffffffff800c51a4>] process_scheduled_works kernel/workqueue.c:2703 [inline]
[<ffffffff800c51a4>] worker_thread+0x506/0x980 kernel/workqueue.c:2784
[<ffffffff800db770>] kthread+0x1bc/0x22c kernel/kthread.c:388
[<ffffffff80005d5a>] ret_from_fork+0xa/0x1c arch/riscv/kernel/entry.S:264


Tested on:

commit:         29e400e3 Add linux-next specific files for 20230919
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git next-20230919
console output: https://syzkaller.appspot.com/x/log.txt?x=15aa5754680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cb7d3cfa08298a9
dashboard link: https://syzkaller.appspot.com/bug?extid=59875ffef5cb9c9b29e9
compiler:       riscv64-linux-gnu-gcc (Debian 12.2.0-13) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: riscv64

Note: no patches were applied.
