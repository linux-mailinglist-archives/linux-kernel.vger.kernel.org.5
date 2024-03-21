Return-Path: <linux-kernel+bounces-110283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FFDE885C9C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 16:52:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA2F7285F38
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 15:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5205A128837;
	Thu, 21 Mar 2024 15:52:07 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58F7A12881C
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 15:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711036326; cv=none; b=bOWXt3Pao75rdFnwo9s4cuwHCcbX3SJMNCnpxRvSvg4TEDFeO8RieRdfYDAZSxXifk9kpdxG1tVNP8twfE4QEdfCD5pRfRoMDLX95iFE1M9D+HL9iPFO9soDXB42SJf1pPt4/Dkzgi37bgLr6lzSPiIgHZSXZVE4PAsVblMVnv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711036326; c=relaxed/simple;
	bh=SW7G2NpQcyvKxiOVQGQh09Yb7BN9oXu0iTxTrX826pI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=HqbmA/MzJYebaCbT18OEaqmfaH718BRMaKtUMhmPmYjZuQWWvItxu8qs8vEpjKEFiKwAG4W3hqV2dL26ZleB9mav1HAfmA1mpMSTd3x/8cYFyhKgxwYj6Kdpu4H7fgnQHfQAeG9q7VK5aMTzBuBt76NYqcJGiDcFd6YO02yzXz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7c7f57fa5eeso94717639f.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 08:52:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711036323; x=1711641123;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NRBXYzwuwkIUajGJBQlAOZP0d92Vihvufqff2lu8PaM=;
        b=D7vzFpym9DybkOgyxF4OtwBVf+oyJi2P5KAQbcv7+W1csoDUOlCQT0fRymHc9Xw8KN
         NfZuRW7z/owS/EikeTtQPPfcFLDzOIMwxf/FoEFz/LGe0/Ck981gulnDDnLxZ8NgLk2L
         PLzx1TxfgYeDAwdHcZBoP33dVPA0JSua/766VNJlMEgE6We9+9pOLL4KcZ+RhKC0f31l
         huO7JnAwD0akVFGGc56v385fgiKrwgxqeGyONUyvdjXoN6Wz98pgD88u05pKotd+knXT
         je5XgBHALd2ruC5zqRo39u51J4nOE0T5gkNA6+3GubkrxEnuSFQiD5bvekb5Noji6666
         5Hxg==
X-Forwarded-Encrypted: i=1; AJvYcCWzAULROFlEurN8koxWpQW+1BpZGjfxMSY8lc59yWhwyHgYxVwv61XVHO8idxoCSccXzO7UtUAhZALyjlAQKkHl9xcRNia9KU3aptBd
X-Gm-Message-State: AOJu0Yyhnn/sB1QXgaPR7hgF+Uz7ko8PXGjd/lu64lcB+Bbw+v5So+/r
	8t6Brf6y/yxLHSTochoRhrJEokogXDiIjruZxx0lHb0W5cVV/8J0NMYul6oReZCCrZ05BQMHjZl
	Tmkr72loq5phtcq75h3oR/2EBXqKu4UbdX3XHj6z5/F31tgAWcW6qjf0=
X-Google-Smtp-Source: AGHT+IH1r23OJUWZzVh2G5ICNlqNk8vOWnEjv03jzcduoCAX576kxNXySPfhbrCaWyFPZgzTgAQt0C6E/7S4icHiqsLTHN79J2wr
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:4108:b0:476:e064:b02b with SMTP id
 ay8-20020a056638410800b00476e064b02bmr914353jab.0.1711036323400; Thu, 21 Mar
 2024 08:52:03 -0700 (PDT)
Date: Thu, 21 Mar 2024 08:52:03 -0700
In-Reply-To: <20240321120722.GC1465092@fedora>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000041255406142db082@google.com>
Subject: Re: [syzbot] [virtualization?] upstream boot error: WARNING: refcount
 bug in __free_pages_ok
From: syzbot <syzbot+70f57d8a3ae84934c003@syzkaller.appspotmail.com>
To: jasowang@redhat.com, linux-kernel@vger.kernel.org, 
	michael.christie@oracle.com, mst@redhat.com, osalvador@suse.de, 
	pbonzini@redhat.com, stefanha@redhat.com, syzkaller-bugs@googlegroups.com, 
	virtualization@lists.linux.dev, xuanzhuo@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

bcore: registered new interface driver viperboard
[    7.297712][    T1] usbcore: registered new interface driver dln2
[    7.299149][    T1] usbcore: registered new interface driver pn533_usb
[    7.304759][  T924] kworker/u4:1 (924) used greatest stack depth: 22768 =
bytes left
[    7.308971][    T1] nfcsim 0.2 initialized
[    7.310068][    T1] usbcore: registered new interface driver port100
[    7.311312][    T1] usbcore: registered new interface driver nfcmrvl
[    7.318405][    T1] Loading iSCSI transport class v2.0-870.
[    7.334687][    T1] virtio_scsi virtio0: 1/0/0 default/read/poll queues
[    7.344927][    T1] ------------[ cut here ]------------
[    7.345739][    T1] refcount_t: decrement hit 0; leaking memory.
[    7.346982][    T1] WARNING: CPU: 0 PID: 1 at lib/refcount.c:31 refcount=
_warn_saturate+0xfa/0x1d0
[    7.348761][    T1] Modules linked in:
[    7.349418][    T1] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.8.0-rc5-=
syzkaller-00257-g217b2119b9e2 #0
[    7.351070][    T1] Hardware name: Google Google Compute Engine/Google C=
ompute Engine, BIOS Google 02/29/2024
[    7.352824][    T1] RIP: 0010:refcount_warn_saturate+0xfa/0x1d0
[    7.353979][    T1] Code: b2 00 00 00 e8 97 2d fc fc 5b 5d c3 cc cc cc c=
c e8 8b 2d fc fc c6 05 0d d9 d6 0a 01 90 48 c7 c7 a0 46 fd 8b e8 e7 2c c0 f=
c 90 <0f> 0b 90 90 eb d9 e8 6b 2d fc fc c6 05 ea d8 d6 0a 01 90 48 c7 c7
[    7.358181][    T1] RSP: 0000:ffffc90000066e10 EFLAGS: 00010246
[    7.360206][    T1] RAX: 67b097fa09053300 RBX: ffff88814073377c RCX: fff=
f8880166c0000
[    7.362234][    T1] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000=
0000000000000
[    7.363496][    T1] RBP: 0000000000000004 R08: ffffffff81589d62 R09: 1ff=
ff9200000cd14
[    7.365139][    T1] R10: dffffc0000000000 R11: fffff5200000cd15 R12: fff=
fea000501edc0
[    7.366612][    T1] R13: ffffea000501edc8 R14: 1ffffd4000a03db9 R15: 000=
0000000000000
[    7.368171][    T1] FS:  0000000000000000(0000) GS:ffff8880b9400000(0000=
) knlGS:0000000000000000
[    7.370111][    T1] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    7.371030][    T1] CR2: ffff88823ffff000 CR3: 000000000df34000 CR4: 000=
00000003506f0
[    7.372121][    T1] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000=
0000000000000
[    7.373506][    T1] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 000=
0000000000400
[    7.374889][    T1] Call Trace:
[    7.375371][    T1]  <TASK>
[    7.375798][    T1]  ? __warn+0x162/0x4b0
[    7.376442][    T1]  ? refcount_warn_saturate+0xfa/0x1d0
[    7.377482][    T1]  ? report_bug+0x2b3/0x500
[    7.378161][    T1]  ? refcount_warn_saturate+0xfa/0x1d0
[    7.379268][    T1]  ? handle_bug+0x3e/0x70
[    7.379887][    T1]  ? exc_invalid_op+0x1a/0x50
[    7.380563][    T1]  ? asm_exc_invalid_op+0x1a/0x20
[    7.381253][    T1]  ? __warn_printk+0x292/0x360
[    7.381912][    T1]  ? refcount_warn_saturate+0xfa/0x1d0
[    7.382752][    T1]  __free_pages_ok+0xc36/0xd60
[    7.384180][    T1]  make_alloc_exact+0xc4/0x140
[    7.385037][    T1]  vring_alloc_queue_split+0x20a/0x600
[    7.386037][    T1]  ? __pfx_vring_alloc_queue_split+0x10/0x10
[    7.387029][    T1]  ? vp_find_vqs+0x4c/0x4e0
[    7.387719][    T1]  ? virtscsi_probe+0x3ea/0xf60
[    7.388408][    T1]  ? virtio_dev_probe+0x991/0xaf0
[    7.389665][    T1]  ? really_probe+0x29e/0xc50
[    7.390429][    T1]  ? driver_probe_device+0x50/0x430
[    7.391176][    T1]  vring_create_virtqueue_split+0xc6/0x310
[    7.392014][    T1]  ? ret_from_fork+0x4b/0x80
[    7.392800][    T1]  ? __pfx_vring_create_virtqueue_split+0x10/0x10
[    7.394115][    T1]  vring_create_virtqueue+0xca/0x110
[    7.395151][    T1]  ? __pfx_vp_notify+0x10/0x10
[    7.395888][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    7.396674][    T1]  setup_vq+0xe9/0x2d0
[    7.397283][    T1]  ? __pfx_vp_notify+0x10/0x10
[    7.397938][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    7.398806][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    7.399938][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    7.400951][    T1]  vp_setup_vq+0xbf/0x330
[    7.401889][    T1]  ? __pfx_vp_config_changed+0x10/0x10
[    7.403092][    T1]  ? ioread16+0x2f/0x90
[    7.403909][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    7.405136][    T1]  vp_find_vqs_msix+0x8b2/0xc80
[    7.405892][    T1]  vp_find_vqs+0x4c/0x4e0
[    7.406823][    T1]  virtscsi_init+0x8db/0xd00
[    7.407669][    T1]  ? __pfx_virtscsi_init+0x10/0x10
[    7.408413][    T1]  ? __pfx_default_calc_sets+0x10/0x10
[    7.409369][    T1]  ? scsi_host_alloc+0xa57/0xea0
[    7.410333][    T1]  ? vp_get+0xfd/0x140
[    7.410899][    T1]  virtscsi_probe+0x3ea/0xf60
[    7.411673][    T1]  ? __pfx_virtscsi_probe+0x10/0x10
[    7.412520][    T1]  ? kernfs_add_one+0x159/0x8b0
[    7.413222][    T1]  ? virtio_no_restricted_mem_acc+0x9/0x10
[    7.414081][    T1]  ? virtio_features_ok+0x10c/0x270
[    7.414875][    T1]  virtio_dev_probe+0x991/0xaf0
[    7.415574][    T1]  ? __pfx_virtio_dev_probe+0x10/0x10
[    7.416501][    T1]  really_probe+0x29e/0xc50
[    7.417330][    T1]  __driver_probe_device+0x1a2/0x3e0
[    7.418134][    T1]  driver_probe_device+0x50/0x430
[    7.418922][    T1]  __driver_attach+0x45f/0x710
[    7.419731][    T1]  ? __pfx___driver_attach+0x10/0x10
[    7.420653][    T1]  bus_for_each_dev+0x239/0x2b0
[    7.421541][    T1]  ? __pfx___driver_attach+0x10/0x10
[    7.422345][    T1]  ? __pfx_bus_for_each_dev+0x10/0x10
[    7.423094][    T1]  ? do_raw_spin_unlock+0x13b/0x8b0
[    7.423964][    T1]  bus_add_driver+0x347/0x620
[    7.424702][    T1]  driver_register+0x23a/0x320
[    7.425353][    T1]  ? __pfx_virtio_scsi_init+0x10/0x10
[    7.426126][    T1]  virtio_scsi_init+0x65/0xe0
[    7.426855][    T1]  ? __pfx_virtio_scsi_init+0x10/0x10
[    7.427617][    T1]  do_one_initcall+0x238/0x830
[    7.428285][    T1]  ? __pfx_virtio_scsi_init+0x10/0x10
[    7.429095][    T1]  ? __pfx_do_one_initcall+0x10/0x10
[    7.430084][    T1]  ? lockdep_hardirqs_on_prepare+0x43c/0x780
[    7.431238][    T1]  ? __pfx_parse_args+0x10/0x10
[    7.431953][    T1]  ? do_initcalls+0x1c/0x80
[    7.432616][    T1]  ? rcu_is_watching+0x15/0xb0
[    7.433413][    T1]  do_initcall_level+0x157/0x210
[    7.434175][    T1]  do_initcalls+0x3f/0x80
[    7.434918][    T1]  kernel_init_freeable+0x42f/0x5d0
[    7.435664][    T1]  ? __pfx_kernel_init_freeable+0x10/0x10
[    7.436745][    T1]  ? __pfx_lockdep_hardirqs_on_prepare+0x10/0x10
[    7.437747][    T1]  ? __pfx_kernel_init+0x10/0x10
[    7.438487][    T1]  ? __pfx_kernel_init+0x10/0x10
[    7.439268][    T1]  ? __pfx_kernel_init+0x10/0x10
[    7.439947][    T1]  kernel_init+0x1d/0x2b0
[    7.440600][    T1]  ret_from_fork+0x4b/0x80
[    7.441572][    T1]  ? __pfx_kernel_init+0x10/0x10
[    7.442531][    T1]  ret_from_fork_asm+0x1b/0x30
[    7.443322][    T1]  </TASK>
[    7.443865][    T1] Kernel panic - not syncing: kernel: panic_on_warn se=
t ...
[    7.444976][    T1] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.8.0-rc5-=
syzkaller-00257-g217b2119b9e2 #0
[    7.446451][    T1] Hardware name: Google Google Compute Engine/Google C=
ompute Engine, BIOS Google 02/29/2024
[    7.447782][    T1] Call Trace:
[    7.448300][    T1]  <TASK>
[    7.448752][    T1]  dump_stack_lvl+0x1e7/0x2e0
[    7.449206][    T1]  ? __pfx_dump_stack_lvl+0x10/0x10
[    7.449206][    T1]  ? __pfx__printk+0x10/0x10
[    7.449206][    T1]  ? _printk+0xd5/0x120
[    7.449206][    T1]  ? vscnprintf+0x5d/0x90
[    7.449206][    T1]  panic+0x349/0x860
[    7.449206][    T1]  ? __warn+0x171/0x4b0
[    7.449206][    T1]  ? __pfx_panic+0x10/0x10
[    7.449206][    T1]  ? show_trace_log_lvl+0x4e4/0x520
[    7.449206][    T1]  ? ret_from_fork_asm+0x1b/0x30
[    7.449206][    T1]  __warn+0x31c/0x4b0
[    7.449206][    T1]  ? refcount_warn_saturate+0xfa/0x1d0
[    7.449206][    T1]  report_bug+0x2b3/0x500
[    7.449206][    T1]  ? refcount_warn_saturate+0xfa/0x1d0
[    7.458645][    T1]  handle_bug+0x3e/0x70
[    7.458645][    T1]  exc_invalid_op+0x1a/0x50
[    7.458645][    T1]  asm_exc_invalid_op+0x1a/0x20
[    7.458645][    T1] RIP: 0010:refcount_warn_saturate+0xfa/0x1d0
[    7.458645][    T1] Code: b2 00 00 00 e8 97 2d fc fc 5b 5d c3 cc cc cc c=
c e8 8b 2d fc fc c6 05 0d d9 d6 0a 01 90 48 c7 c7 a0 46 fd 8b e8 e7 2c c0 f=
c 90 <0f> 0b 90 90 eb d9 e8 6b 2d fc fc c6 05 ea d8 d6 0a 01 90 48 c7 c7
[    7.458645][    T1] RSP: 0000:ffffc90000066e10 EFLAGS: 00010246
[    7.458645][    T1] RAX: 67b097fa09053300 RBX: ffff88814073377c RCX: fff=
f8880166c0000
[    7.458645][    T1] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000=
0000000000000
[    7.468739][    T1] RBP: 0000000000000004 R08: ffffffff81589d62 R09: 1ff=
ff9200000cd14
[    7.468739][    T1] R10: dffffc0000000000 R11: fffff5200000cd15 R12: fff=
fea000501edc0
[    7.468739][    T1] R13: ffffea000501edc8 R14: 1ffffd4000a03db9 R15: 000=
0000000000000
[    7.468739][    T1]  ? __warn_printk+0x292/0x360
[    7.468739][    T1]  __free_pages_ok+0xc36/0xd60
[    7.468739][    T1]  make_alloc_exact+0xc4/0x140
[    7.468739][    T1]  vring_alloc_queue_split+0x20a/0x600
[    7.468739][    T1]  ? __pfx_vring_alloc_queue_split+0x10/0x10
[    7.468739][    T1]  ? vp_find_vqs+0x4c/0x4e0
[    7.468739][    T1]  ? virtscsi_probe+0x3ea/0xf60
[    7.478647][    T1]  ? virtio_dev_probe+0x991/0xaf0
[    7.478647][    T1]  ? really_probe+0x29e/0xc50
[    7.478647][    T1]  ? driver_probe_device+0x50/0x430
[    7.478647][    T1]  vring_create_virtqueue_split+0xc6/0x310
[    7.478647][    T1]  ? ret_from_fork+0x4b/0x80
[    7.478647][    T1]  ? __pfx_vring_create_virtqueue_split+0x10/0x10
[    7.478647][    T1]  vring_create_virtqueue+0xca/0x110
[    7.478647][    T1]  ? __pfx_vp_notify+0x10/0x10
[    7.478647][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    7.478647][    T1]  setup_vq+0xe9/0x2d0
[    7.478647][    T1]  ? __pfx_vp_notify+0x10/0x10
[    7.478647][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    7.488714][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    7.488714][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    7.488714][    T1]  vp_setup_vq+0xbf/0x330
[    7.488714][    T1]  ? __pfx_vp_config_changed+0x10/0x10
[    7.488714][    T1]  ? ioread16+0x2f/0x90
[    7.488714][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    7.488714][    T1]  vp_find_vqs_msix+0x8b2/0xc80
[    7.488714][    T1]  vp_find_vqs+0x4c/0x4e0
[    7.488714][    T1]  virtscsi_init+0x8db/0xd00
[    7.488714][    T1]  ? __pfx_virtscsi_init+0x10/0x10
[    7.488714][    T1]  ? __pfx_default_calc_sets+0x10/0x10
[    7.498614][    T1]  ? scsi_host_alloc+0xa57/0xea0
[    7.498614][    T1]  ? vp_get+0xfd/0x140
[    7.498614][    T1]  virtscsi_probe+0x3ea/0xf60
[    7.498614][    T1]  ? __pfx_virtscsi_probe+0x10/0x10
[    7.498614][    T1]  ? kernfs_add_one+0x159/0x8b0
[    7.498614][    T1]  ? virtio_no_restricted_mem_acc+0x9/0x10
[    7.498614][    T1]  ? virtio_features_ok+0x10c/0x270
[    7.498614][    T1]  virtio_dev_probe+0x991/0xaf0
[    7.498614][    T1]  ? __pfx_virtio_dev_probe+0x10/0x10
[    7.498614][    T1]  really_probe+0x29e/0xc50
[    7.498614][    T1]  __driver_probe_device+0x1a2/0x3e0
[    7.508689][    T1]  driver_probe_device+0x50/0x430
[    7.508689][    T1]  __driver_attach+0x45f/0x710
[    7.508689][    T1]  ? __pfx___driver_attach+0x10/0x10
[    7.508689][    T1]  bus_for_each_dev+0x239/0x2b0
[    7.508689][    T1]  ? __pfx___driver_attach+0x10/0x10
[    7.508689][    T1]  ? __pfx_bus_for_each_dev+0x10/0x10
[    7.508689][    T1]  ? do_raw_spin_unlock+0x13b/0x8b0
[    7.508689][    T1]  bus_add_driver+0x347/0x620
[    7.508689][    T1]  driver_register+0x23a/0x320
[    7.508689][    T1]  ? __pfx_virtio_scsi_init+0x10/0x10
[    7.508689][    T1]  virtio_scsi_init+0x65/0xe0
[    7.518645][    T1]  ? __pfx_virtio_scsi_init+0x10/0x10
[    7.518645][    T1]  do_one_initcall+0x238/0x830
[    7.518645][    T1]  ? __pfx_virtio_scsi_init+0x10/0x10
[    7.518645][    T1]  ? __pfx_do_one_initcall+0x10/0x10
[    7.518645][    T1]  ? lockdep_hardirqs_on_prepare+0x43c/0x780
[    7.518645][    T1]  ? __pfx_parse_args+0x10/0x10
[    7.518645][    T1]  ? do_initcalls+0x1c/0x80
[    7.518645][    T1]  ? rcu_is_watching+0x15/0xb0
[    7.518645][    T1]  do_initcall_level+0x157/0x210
[    7.518645][    T1]  do_initcalls+0x3f/0x80
[    7.518645][    T1]  kernel_init_freeable+0x42f/0x5d0
[    7.528806][    T1]  ? __pfx_kernel_init_freeable+0x10/0x10
[    7.528806][    T1]  ? __pfx_lockdep_hardirqs_on_prepare+0x10/0x10
[    7.528806][    T1]  ? __pfx_kernel_init+0x10/0x10
[    7.528806][    T1]  ? __pfx_kernel_init+0x10/0x10
[    7.528806][    T1]  ? __pfx_kernel_init+0x10/0x10
[    7.528806][    T1]  kernel_init+0x1d/0x2b0
[    7.528806][    T1]  ret_from_fork+0x4b/0x80
[    7.528806][    T1]  ? __pfx_kernel_init+0x10/0x10
[    7.528806][    T1]  ret_from_fork_asm+0x1b/0x30
[    7.528806][    T1]  </TASK>
[    7.528806][    T1] Kernel Offset: disabled
[    7.528806][    T1] Rebooting in 86400 seconds..


syzkaller build log:
go env (err=3D<nil>)
GO111MODULE=3D'auto'
GOARCH=3D'amd64'
GOBIN=3D''
GOCACHE=3D'/syzkaller/.cache/go-build'
GOENV=3D'/syzkaller/.config/go/env'
GOEXE=3D''
GOEXPERIMENT=3D''
GOFLAGS=3D''
GOHOSTARCH=3D'amd64'
GOHOSTOS=3D'linux'
GOINSECURE=3D''
GOMODCACHE=3D'/syzkaller/jobs/linux/gopath/pkg/mod'
GONOPROXY=3D''
GONOSUMDB=3D''
GOOS=3D'linux'
GOPATH=3D'/syzkaller/jobs/linux/gopath'
GOPRIVATE=3D''
GOPROXY=3D'https://proxy.golang.org,direct'
GOROOT=3D'/usr/local/go'
GOSUMDB=3D'sum.golang.org'
GOTMPDIR=3D''
GOTOOLCHAIN=3D'auto'
GOTOOLDIR=3D'/usr/local/go/pkg/tool/linux_amd64'
GOVCS=3D''
GOVERSION=3D'go1.21.4'
GCCGO=3D'gccgo'
GOAMD64=3D'v1'
AR=3D'ar'
CC=3D'gcc'
CXX=3D'g++'
CGO_ENABLED=3D'1'
GOMOD=3D'/syzkaller/jobs/linux/gopath/src/github.com/google/syzkaller/go.mo=
d'
GOWORK=3D''
CGO_CFLAGS=3D'-O2 -g'
CGO_CPPFLAGS=3D''
CGO_CXXFLAGS=3D'-O2 -g'
CGO_FFLAGS=3D'-O2 -g'
CGO_LDFLAGS=3D'-O2 -g'
PKG_CONFIG=3D'pkg-config'
GOGCCFLAGS=3D'-fPIC -m64 -pthread -Wl,--no-gc-sections -fmessage-length=3D0=
 -ffile-prefix-map=3D/tmp/go-build2530895313=3D/tmp/go-build -gno-record-gc=
c-switches'

git status (err=3D<nil>)
HEAD detached at 6753db5cd
nothing to commit, working tree clean


tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
Makefile:31: run command via tools/syz-env for best compatibility, see:
Makefile:32: https://github.com/google/syzkaller/blob/master/docs/contribut=
ing.md#using-syz-env
go list -f '{{.Stale}}' ./sys/syz-sysgen | grep -q false || go install ./sy=
s/syz-sysgen
make .descriptions
tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
Makefile:31: run command via tools/syz-env for best compatibility, see:
Makefile:32: https://github.com/google/syzkaller/blob/master/docs/contribut=
ing.md#using-syz-env
bin/syz-sysgen
touch .descriptions
GOOS=3Dlinux GOARCH=3Damd64 go build "-ldflags=3D-s -w -X github.com/google=
/syzkaller/prog.GitRevision=3D6753db5cdc04330ec9d1a5116b890c19481d69b3 -X '=
github.com/google/syzkaller/prog.gitRevisionDate=3D20240320-145051'" "-tags=
=3Dsyz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-fuzzer=
 github.com/google/syzkaller/syz-fuzzer
GOOS=3Dlinux GOARCH=3Damd64 go build "-ldflags=3D-s -w -X github.com/google=
/syzkaller/prog.GitRevision=3D6753db5cdc04330ec9d1a5116b890c19481d69b3 -X '=
github.com/google/syzkaller/prog.gitRevisionDate=3D20240320-145051'" "-tags=
=3Dsyz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-execpr=
og github.com/google/syzkaller/tools/syz-execprog
GOOS=3Dlinux GOARCH=3Damd64 go build "-ldflags=3D-s -w -X github.com/google=
/syzkaller/prog.GitRevision=3D6753db5cdc04330ec9d1a5116b890c19481d69b3 -X '=
github.com/google/syzkaller/prog.gitRevisionDate=3D20240320-145051'" "-tags=
=3Dsyz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-stress=
 github.com/google/syzkaller/tools/syz-stress
mkdir -p ./bin/linux_amd64
gcc -o ./bin/linux_amd64/syz-executor executor/executor.cc \
	-m64 -O2 -pthread -Wall -Werror -Wparentheses -Wunused-const-variable -Wfr=
ame-larger-than=3D16384 -Wno-stringop-overflow -Wno-array-bounds -Wno-forma=
t-overflow -Wno-unused-but-set-variable -Wno-unused-command-line-argument -=
static-pie -fpermissive -w -DGOOS_linux=3D1 -DGOARCH_amd64=3D1 \
	-DHOSTGOOS_linux=3D1 -DGIT_REVISION=3D\"6753db5cdc04330ec9d1a5116b890c1948=
1d69b3\"


Error text is too large and was truncated, full error text is at:
https://syzkaller.appspot.com/x/error.txt?x=3D1254e231180000


Tested on:

commit:         217b2119 mm,page_owner: implement the tracking of the ..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linu=
x.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=3D527195e149aa309=
1
dashboard link: https://syzkaller.appspot.com/bug?extid=3D70f57d8a3ae84934c=
003
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debia=
n) 2.40

Note: no patches were applied.

