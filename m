Return-Path: <linux-kernel+bounces-129670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E81E0896E4A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 13:36:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 258E51C26021
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 11:36:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60263143885;
	Wed,  3 Apr 2024 11:35:35 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 479481386A8
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 11:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712144134; cv=none; b=nVUecSdlr59fjpC24qWj9Rcw1vaSC487Lf0aqEo3n4mvlwP2W/D0JUPxm/wXmNhN8li+l6e5mkGHOM2OeXmusawWkv/M8+XlmTAq64UVdkHoMykuUy4HSdmc+IR0Zt61cslCWo40Fm2nDwBdbY7LHwPBAGNdzpvbkRkNTl06iEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712144134; c=relaxed/simple;
	bh=He2U7fb8aU+EkEyUm/8NshncYf1dEyzTByD9lzAR4Hk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=j+7FJ1HpZ5532lX5aC6Uay0EFI6eO2+YrsfdskP/Oawv6AB2fzIiZyUdRzETcyU98VabQ9OL4ZXxv0zobyjkQhBm4ICvRIUUXoHZ9yh068Btxv0MXDtAjyroSJFek84gjr76yJeA7MDD+g4IzRMDCPKqYIrsyofgqLQ66fALrGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7cbfd4781fcso666682439f.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2024 04:35:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712144132; x=1712748932;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W63RUJcvU8oDwlqRPyrIqv2ix8e3Wfp/1qAcWEZ3Qt4=;
        b=V2N0IMut5XjXQTGtclj4RJPHFmCMt3c07Z/MoJI7TrIiYeQKi9BmYJs2iQJ+k9vc+F
         aJZT3PoYTOvqKJu95i/JG7gShHIkLvHOvtJWYjRkaA7hTmt8HiEZfWaQkwKMkQZFEsbC
         NRMK6alV+s33T6362UJNLAHdbJbmZfYnch7RrlRMXwxH6wHw27tcyqKbFLrs4FLGRl5u
         eElzONOmvpPymK5RMZCwGsJ58g8uEURl+2gWKtZUggkrN1I/Bg1mtw1zdm/A7KpiBX5H
         RajUoB481G/INwJyWPbpngZxb3JdJ/lNiE0iNySaE7vZzchFfAkCk/u6SyDrEKKDPQPv
         zg8Q==
X-Forwarded-Encrypted: i=1; AJvYcCWnT31nisTurbnU4BVhAI9PS+hkQgcYOrF2oNsRInLFq6PQ76Mqtm5zPEKnW6mgTEgxON2awbJKRZacA65YMgb4aClnDu4cAv4rhluz
X-Gm-Message-State: AOJu0YxTgF55GBm6TrYgyUx3OKvDbii+D0yo3G5K1dNfMkugCyAQl2fd
	EspuSM5deAijmkhz1beRd6B3gi08xj5ikKh7SEc8nvnEvz7QsXUyRdv5FaNLrxyY3JJzxoi7HEq
	8Bl7haN11IGF/2bVs1Z0w8Q7vQCcRa5yd4Ro9WHTy72YAw3pSqsBnymM=
X-Google-Smtp-Source: AGHT+IFHlnuZ227swltfMtmSK2kgOgDDYBW6LWbUccIHDI3QnefoBKXjAowCe6MZ/Vbj2QmQ+AM39ecZtIonUsiCGXcpqa5Db1E2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:3fc4:b0:7c8:c7ec:2b71 with SMTP id
 fc4-20020a0566023fc400b007c8c7ec2b71mr229344iob.3.1712144132441; Wed, 03 Apr
 2024 04:35:32 -0700 (PDT)
Date: Wed, 03 Apr 2024 04:35:32 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d19c3a06152f9ee4@google.com>
Subject: [syzbot] [net?] KMSAN: uninit-value in geneve_xmit (3)
From: syzbot <syzbot+9ee20ec1de7b3168db09@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    928a87efa423 Merge tag 'gfs2-v6.8-fix' of git://git.kernel..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=10c17b4e180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e2599baf258ef795
dashboard link: https://syzkaller.appspot.com/bug?extid=9ee20ec1de7b3168db09
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16cd6479180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16cec009180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/7d66fa7ed5c7/disk-928a87ef.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/8b511d64cde0/vmlinux-928a87ef.xz
kernel image: https://storage.googleapis.com/syzbot-assets/8810588440a2/bzImage-928a87ef.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9ee20ec1de7b3168db09@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in geneve_xmit_skb drivers/net/geneve.c:910 [inline]
BUG: KMSAN: uninit-value in geneve_xmit+0x302d/0x5420 drivers/net/geneve.c:1030
 geneve_xmit_skb drivers/net/geneve.c:910 [inline]
 geneve_xmit+0x302d/0x5420 drivers/net/geneve.c:1030
 __netdev_start_xmit include/linux/netdevice.h:4903 [inline]
 netdev_start_xmit include/linux/netdevice.h:4917 [inline]
 xmit_one net/core/dev.c:3531 [inline]
 dev_hard_start_xmit+0x247/0xa20 net/core/dev.c:3547
 __dev_queue_xmit+0x348d/0x52c0 net/core/dev.c:4335
 dev_queue_xmit include/linux/netdevice.h:3091 [inline]
 packet_xmit+0x9c/0x6c0 net/packet/af_packet.c:276
 packet_snd net/packet/af_packet.c:3081 [inline]
 packet_sendmsg+0x8bb0/0x9ef0 net/packet/af_packet.c:3113
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg+0x30f/0x380 net/socket.c:745
 __sys_sendto+0x685/0x830 net/socket.c:2191
 __do_sys_sendto net/socket.c:2203 [inline]
 __se_sys_sendto net/socket.c:2199 [inline]
 __x64_sys_sendto+0x125/0x1d0 net/socket.c:2199
 do_syscall_64+0xd5/0x1f0
 entry_SYSCALL_64_after_hwframe+0x6d/0x75

Uninit was created at:
 slab_post_alloc_hook mm/slub.c:3804 [inline]
 slab_alloc_node mm/slub.c:3845 [inline]
 kmem_cache_alloc_node+0x613/0xc50 mm/slub.c:3888
 kmalloc_reserve+0x13d/0x4a0 net/core/skbuff.c:577
 __alloc_skb+0x35b/0x7a0 net/core/skbuff.c:668
 alloc_skb include/linux/skbuff.h:1318 [inline]
 alloc_skb_with_frags+0xc8/0xbf0 net/core/skbuff.c:6504
 sock_alloc_send_pskb+0xa81/0xbf0 net/core/sock.c:2795
 packet_alloc_skb net/packet/af_packet.c:2930 [inline]
 packet_snd net/packet/af_packet.c:3024 [inline]
 packet_sendmsg+0x722d/0x9ef0 net/packet/af_packet.c:3113
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg+0x30f/0x380 net/socket.c:745
 __sys_sendto+0x685/0x830 net/socket.c:2191
 __do_sys_sendto net/socket.c:2203 [inline]
 __se_sys_sendto net/socket.c:2199 [inline]
 __x64_sys_sendto+0x125/0x1d0 net/socket.c:2199
 do_syscall_64+0xd5/0x1f0
 entry_SYSCALL_64_after_hwframe+0x6d/0x75

CPU: 0 PID: 5033 Comm: syz-executor346 Not tainted 6.9.0-rc1-syzkaller-00005-g928a87efa423 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/29/2024
=====================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

