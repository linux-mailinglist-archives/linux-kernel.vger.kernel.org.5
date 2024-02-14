Return-Path: <linux-kernel+bounces-65007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 905C185467D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 10:52:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4845A28DA50
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 09:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D14301429C;
	Wed, 14 Feb 2024 09:52:05 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D154113ADB
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 09:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707904325; cv=none; b=pI5MC28dIhyhUpa04n3xxu4qbfGuDywlULic4mRHXQqSYeEeINsUrCPAM9SFPwSObN4Nn13P0rfYuezDBMnW/lchqICeikNTfeCovANsGcNDDwFZnnQvdstQZZt4/96jBCsGppXr2MACw0/4vRbl59MyV3hKSoRpj6gU85Em37c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707904325; c=relaxed/simple;
	bh=/WZ+0en2hYRrVYORtDQ6E5O368IXClGjaFQPYTU4Th4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=KIpIq/NiDNtvZOVwBBZHFdjd6Cn09Zi+iE4kT3M2yzanl/eEz8R1e1ChohQo30NJukeuf2fF5Hf4YugTLgh+8INq/UJgUC2vPbX8kCOV2YoC686IdT8DrpA/BDX/5aHThnQ3rsx2A+tRTGgFtTso3wmpXWUox9E3R5MheoMl6Yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-363da08fc19so47457785ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 01:52:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707904323; x=1708509123;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0cpkPdutDChRiHnxGrJ0+2dxav52OhwGkxn+PEdR9JQ=;
        b=w36cl6BwxKt4ip4rFJ14Zpq/rh7NLsXBDrjSAm0q2SBOo1pBb/LQBNvzcvesXOqIaI
         zxakUg4syxWG+3GMwXrBi/cR3RgJdnxx8WT2dFBetMOrRqOIPniCiJIVrJ4Ot2xdVTCj
         6TyIEsmyehBJsoI8GdSYvTJ/DZSCikka55SuZgSfDXFxkvZ/gjAX4+nozIH7lylr0AiW
         fXQ5jP+XNI02wfnp3KIxPCpz6dDmo/ec3BO0e++8cT1O6AW3box7n8etzDrSQslvaxbf
         wqo0xmBDse6slEVdUVxwVk6gQLtvg3P+Ae7YY4+XTxjpF3uy1bXALcgcLEbvgGcALk8d
         OLtQ==
X-Forwarded-Encrypted: i=1; AJvYcCURErFPjy5xElY5O9hHsLoVQGzQrqOGHMlTMfPSJOB6T+F9YcfCmWrfG2OoGKaeqA9IQZdsp8+1TJ4H6c5w3nXlIdhVZujkbYf0ATwj
X-Gm-Message-State: AOJu0YxnW6a70qRzu5ng0mmUX3ofnpUR+kYuUm9YlEB6JnwOyGxF7stc
	ZZyJMFjWQ69FWcV7vmhXCVlKuTq+ZNPKY47mTXJ95CZsijmhNVttCaHLCgl3FLu9o6hlD7LQnRH
	GRcSI1cnTIb4jNv1Kht2jYZweUtbdb5C05gTZFZcKqWLUpFeRHrmHDRE=
X-Google-Smtp-Source: AGHT+IGbF+h8vgEmVuLVSqw8VUOCxUDbzHv6vN14kAKpmPXDA83IyVqZlKNwYiijytn9SaZ3iKkFXSVtSOedFG0TcUu89k3pQ/bf
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:218a:b0:363:c4a0:5d06 with SMTP id
 j10-20020a056e02218a00b00363c4a05d06mr159076ila.1.1707904323060; Wed, 14 Feb
 2024 01:52:03 -0800 (PST)
Date: Wed, 14 Feb 2024 01:52:03 -0800
In-Reply-To: <9cf86b72-286d-f726-6907-ff2c11af6d75@blackhole.kfki.hu>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007c900506115476fc@google.com>
Subject: Re: [syzbot] [netfilter?] WARNING: ODEBUG bug in ip_set_free
From: syzbot <syzbot+ebbab3e04c88fa141e6b@syzkaller.appspotmail.com>
To: kadlec@blackhole.kfki.hu, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING: ODEBUG bug in ip_set_free

------------[ cut here ]------------
ODEBUG: free active (active state 0) object: 0000000062ae9ef3 object type: timer_list hint: bitmap_port_gc+0x0/0x4dc net/netfilter/ipset/ip_set_bitmap_port.c:282
WARNING: CPU: 0 PID: 6628 at lib/debugobjects.c:517 debug_print_object lib/debugobjects.c:514 [inline]
WARNING: CPU: 0 PID: 6628 at lib/debugobjects.c:517 __debug_check_no_obj_freed lib/debugobjects.c:989 [inline]
WARNING: CPU: 0 PID: 6628 at lib/debugobjects.c:517 debug_check_no_obj_freed+0x398/0x47c lib/debugobjects.c:1019
Modules linked in:
CPU: 0 PID: 6628 Comm: syz-executor.0 Not tainted 6.8.0-rc3-syzkaller-00010-gf735966ee23c-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : debug_print_object lib/debugobjects.c:514 [inline]
pc : __debug_check_no_obj_freed lib/debugobjects.c:989 [inline]
pc : debug_check_no_obj_freed+0x398/0x47c lib/debugobjects.c:1019
lr : debug_print_object lib/debugobjects.c:514 [inline]
lr : __debug_check_no_obj_freed lib/debugobjects.c:989 [inline]
lr : debug_check_no_obj_freed+0x398/0x47c lib/debugobjects.c:1019
sp : ffff8000978c6950
x29: ffff8000978c6990 x28: 0000000000000000 x27: ffff80008aeec3c0
x26: ffff0000e345d318 x25: dfff800000000000 x24: 0000000000000000
x23: ffff80009368be40 x22: ffff0000e345d000 x21: 0000000000000000
x20: ffff8000894dfe30 x19: ffff0000e345d300 x18: 1fffe000367ff596
x17: ffff80008ec6d000 x16: ffff80008031fff4 x15: 0000000000000001
x14: 1fffe00036801de8 x13: 0000000000000000 x12: 0000000000000003
x11: 0000000000000001 x10: 0000000000000003 x9 : dee47f29bae7c100
x8 : dee47f29bae7c100 x7 : ffff800080296b68 x6 : 0000000000000000
x5 : 0000000000000001 x4 : 0000000000000001 x3 : 0000000000000000
x2 : 0000000000000006 x1 : ffff80008aecd8e0 x0 : ffff800125439000
Call trace:
 debug_print_object lib/debugobjects.c:514 [inline]
 __debug_check_no_obj_freed lib/debugobjects.c:989 [inline]
 debug_check_no_obj_freed+0x398/0x47c lib/debugobjects.c:1019
 slab_free_hook mm/slub.c:2093 [inline]
 slab_free mm/slub.c:4299 [inline]
 kfree+0x114/0x3cc mm/slub.c:4409
 kvfree+0x40/0x50 mm/util.c:663
 ip_set_free+0x28/0x7c net/netfilter/ipset/ip_set_core.c:264
 bitmap_port_destroy+0xe4/0x324 net/netfilter/ipset/ip_set_bitmap_gen.h:66
 ip_set_create+0x904/0xf48 net/netfilter/ipset/ip_set_core.c:1157
 nfnetlink_rcv_msg+0xa78/0xf80 net/netfilter/nfnetlink.c:302
 netlink_rcv_skb+0x214/0x3c4 net/netlink/af_netlink.c:2543
 nfnetlink_rcv+0x21c/0x1ed0 net/netfilter/nfnetlink.c:659
 netlink_unicast_kernel net/netlink/af_netlink.c:1341 [inline]
 netlink_unicast+0x65c/0x898 net/netlink/af_netlink.c:1367
 netlink_sendmsg+0x83c/0xb20 net/netlink/af_netlink.c:1908
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg net/socket.c:745 [inline]
 ____sys_sendmsg+0x56c/0x840 net/socket.c:2584
 ___sys_sendmsg net/socket.c:2638 [inline]
 __sys_sendmsg+0x26c/0x33c net/socket.c:2667
 __do_sys_sendmsg net/socket.c:2676 [inline]
 __se_sys_sendmsg net/socket.c:2674 [inline]
 __arm64_sys_sendmsg+0x80/0x94 net/socket.c:2674
 __invoke_syscall arch/arm64/kernel/syscall.c:37 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:51
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:136
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:155
 el0_svc+0x54/0x158 arch/arm64/kernel/entry-common.c:678
 el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:696
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:598
irq event stamp: 294
hardirqs last  enabled at (293): [<ffff800080296c08>] raw_spin_rq_unlock_irq kernel/sched/sched.h:1397 [inline]
hardirqs last  enabled at (293): [<ffff800080296c08>] finish_lock_switch+0xbc/0x1e4 kernel/sched/core.c:5154
hardirqs last disabled at (294): [<ffff80008ad60eac>] el1_dbg+0x24/0x80 arch/arm64/kernel/entry-common.c:436
softirqs last  enabled at (276): [<ffff80008002189c>] softirq_handle_end kernel/softirq.c:399 [inline]
softirqs last  enabled at (276): [<ffff80008002189c>] __do_softirq+0xac8/0xce4 kernel/softirq.c:582
softirqs last disabled at (147): [<ffff80008002ab48>] ____do_softirq+0x14/0x20 arch/arm64/kernel/irq.c:81
---[ end trace 0000000000000000 ]---


Tested on:

commit:         f735966e Merge branches 'for-next/reorg-va-space' and ..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=10afd01c180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d47605a39da2cf06
dashboard link: https://syzkaller.appspot.com/bug?extid=ebbab3e04c88fa141e6b
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10de0934180000


