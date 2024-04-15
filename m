Return-Path: <linux-kernel+bounces-145414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ACFD8A55E2
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 17:03:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26432282ADB
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 15:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 736767602A;
	Mon, 15 Apr 2024 15:03:09 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3682271B3B
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 15:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713193389; cv=none; b=M3F0bXsTOyU28FEpmeRjZx2ZQVEQt2RqVthFO0DCGo7VU6XOhQgWWi88KTAqXkr6dflzbq6u0GiF2kO6ang25C/yj9ue90OI7QnGPH7DSFEjUlItkGDlp+DFOhNOYXRLo6gb299s9KRl/4qEw2MyQJJf3xFyxTcm4mQ31DazGz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713193389; c=relaxed/simple;
	bh=QAzFmffWsZYQzeY3yEKEC0gQlvmNo9ljGjRjjp/8IfU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=rqsZOI5ChTIzMhQkrQ8cIyTVPqx6lpg6LOodRoLSmVJ8d+odFyzGAerPmvDQlAPrmXWqAfCgC1jh/F93vuUEOuGWixr/GCoXlTKkld9z4p86GKoRSGdW4a5i7urZEJDXoha49aJPBmvGMEfa5s/aDzIapgo8BsE4Eplz+bFmWrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7d622cae9e4so356950539f.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 08:03:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713193383; x=1713798183;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hSq8qGn/JF5KdpapQccUGb3UzISwAxkFXjt7VDeXU64=;
        b=Lv72CcUD8HcHH9xRviVPcVo6ZNhEnC9FHS35sQmla3FjY5GyPE4qqOI2bvueF5cpfd
         CoJV6D/RUgf3Wx6Gh8I/UrVhf8AZlekcc7WQW4srRSan52MBoG6Rrx2ojeY833QuccIJ
         FxUwWW311aAnvS0fPCCNPiJzssHX5KjcqzZf/kl9d1HST+k7/cBGZfBRZO9i9rYkGaHs
         36uvjFZbwUGwc5eu6ZdYZ66fl65rHlLrPwtgF+QvLLObEbFebyUJYFFGpyzLwp9XV2Bi
         bZpwJw1pXLNGX5bYV9EvxWrc7CFEQ/wCII0gkm0AicY8qCcOWE0a48dxemudYPKjAzyP
         uXKw==
X-Gm-Message-State: AOJu0YzO/gL16vWn+lCm92wt3VZBA0OTovPs2kGBv+9BQAasRQOSpQXJ
	Oq7FJm6cHP7ZEaqV/z5gpQk3QcuHonB64GrezQUpOmqNNny95waQDE0cJy//GIOP0hzbVHX+WKm
	8yxwPOMT41xJu9rmnHub6ikNny72Mbf9S00yGCgrwnCFYLfvtimkyFew=
X-Google-Smtp-Source: AGHT+IH5fP1hNjHV5iZhkXGr2AeaV+3IJv9e9gh7OynLUxpJJ6hstBncRmesAd2VqtfV0x3WTwa3KDYZ7KQjyB1aH63Fry0WQIFq
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:204d:b0:482:fbfb:e72e with SMTP id
 t13-20020a056638204d00b00482fbfbe72emr379402jaj.6.1713193383440; Mon, 15 Apr
 2024 08:03:03 -0700 (PDT)
Date: Mon, 15 Apr 2024 08:03:03 -0700
In-Reply-To: <20240415144101.44907-1-n.zhandarovich@fintech.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000d41d2061623ebed@google.com>
Subject: Re: [syzbot] [usb?] WARNING in usbnet_start_xmit/usb_submit_urb (2)
From: syzbot <syzbot+d693c07c6f647e0388d3@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, n.zhandarovich@fintech.ru, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING in usbnet_start_xmit/usb_submit_urb

------------[ cut here ]------------
usb 2-1: BOGUS urb xfer, pipe 3 != type 1
WARNING: CPU: 0 PID: 726 at drivers/usb/core/urb.c:503 usb_submit_urb+0xe4b/0x1730 drivers/usb/core/urb.c:503
Modules linked in:
CPU: 0 PID: 726 Comm: kworker/0:2 Not tainted 6.8.0-syzkaller-08951-gfe46a7dd189e #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
Workqueue: mld mld_ifc_work
RIP: 0010:usb_submit_urb+0xe4b/0x1730 drivers/usb/core/urb.c:503
Code: 84 3c 02 00 00 e8 35 48 30 fd 4c 89 ef e8 1d 24 01 ff 45 89 e0 89 e9 4c 89 f2 48 89 c6 48 c7 c7 c0 49 30 87 e8 46 b1 f6 fc 90 <0f> 0b 90 90 e9 e9 f8 ff ff e8 07 48 30 fd 49 81 c4 b8 05 00 00 e9
RSP: 0000:ffffc90001bef2e0 EFLAGS: 00010082
RAX: 0000000000000000 RBX: ffff8881026a1e00 RCX: ffffffff8118b029
RDX: ffff88810b350000 RSI: ffffffff8118b036 RDI: 0000000000000001
RBP: 0000000000000003 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 000000000000000c R12: 0000000000000001
R13: ffff888101f760a8 R14: ffff888105ee9040 R15: ffff8881026a1e7c
FS:  0000000000000000(0000) GS:ffff8881f6400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f13260e9870 CR3: 000000010dbd0000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 usbnet_start_xmit+0x696/0x2440 drivers/net/usb/usbnet.c:1453
 __netdev_start_xmit include/linux/netdevice.h:4903 [inline]
 netdev_start_xmit include/linux/netdevice.h:4917 [inline]
 xmit_one net/core/dev.c:3531 [inline]
 dev_hard_start_xmit+0x143/0x720 net/core/dev.c:3547
 sch_direct_xmit+0x18e/0x840 net/sched/sch_generic.c:343
 __dev_xmit_skb net/core/dev.c:3760 [inline]
 __dev_queue_xmit+0x12c5/0x3ef0 net/core/dev.c:4301
 dev_queue_xmit include/linux/netdevice.h:3091 [inline]
 neigh_resolve_output net/core/neighbour.c:1563 [inline]
 neigh_resolve_output+0x5ba/0x950 net/core/neighbour.c:1543
 neigh_output include/net/neighbour.h:542 [inline]
 ip6_finish_output2+0xad9/0x2300 net/ipv6/ip6_output.c:137
 __ip6_finish_output+0x3d8/0xf10 net/ipv6/ip6_output.c:211
 ip6_finish_output net/ipv6/ip6_output.c:222 [inline]
 NF_HOOK_COND include/linux/netfilter.h:303 [inline]
 ip6_output+0x23a/0x8c0 net/ipv6/ip6_output.c:243
 dst_output include/net/dst.h:450 [inline]
 NF_HOOK.constprop.0+0x118/0x8b0 include/linux/netfilter.h:314
 mld_sendpack+0x6e6/0xd20 net/ipv6/mcast.c:1818
 mld_send_cr net/ipv6/mcast.c:2119 [inline]
 mld_ifc_work+0x756/0xce0 net/ipv6/mcast.c:2650
 process_one_work+0x9a9/0x1a60 kernel/workqueue.c:3254
 process_scheduled_works kernel/workqueue.c:3335 [inline]
 worker_thread+0x6c8/0xf70 kernel/workqueue.c:3416
 kthread+0x2c1/0x3a0 kernel/kthread.c:388
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243
 </TASK>


Tested on:

commit:         fe46a7dd Merge tag 'sound-6.9-rc1' of git://git.kernel..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=15b90f43180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=811ce8e010ac6afc
dashboard link: https://syzkaller.appspot.com/bug?extid=d693c07c6f647e0388d3
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.

