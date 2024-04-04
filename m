Return-Path: <linux-kernel+bounces-131468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22FEE89883E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 14:49:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 418181C21377
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 12:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1C178613E;
	Thu,  4 Apr 2024 12:49:34 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F8D42072
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 12:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712234974; cv=none; b=Jm8lYmF366vJW+knb+tlnA6MoS8XsRmRoELhl4H8Ds85+FtEJmhHqvosC3zJbca20mrbOeZBmAPVpWw58KlkqR7gGSjHI600duzZWpODG5BxagmKEhLYIXEmnDFYOOX4Asq6OxwcaDXYgGpviDWxMPT/uOo9yreklRsTRkSUGow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712234974; c=relaxed/simple;
	bh=sb4KZ5DnjkABLmFvWPyLD59JcXtsgt27QvqxFSn2aiQ=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=FQ1/D8jcbIqiHL+Z5TIFd364OucIreH1okhc6QbrVA+wcONcuT3160JiViUxLaGfqGs8VEK22++qGKO+EiJ4NsHniqFr+CZLNM9d1PRv9/GaXVWPx6R02zOFAr4pT+9gCmsiEtgFaXIg/e1CnKEgwIkJQX2dOnE8FE/maOAcmDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-369ec5c3c08so8962455ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 05:49:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712234971; x=1712839771;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VpwTCb/N6+jyMk/fXZkM5PIZRZLMUvuOzVXItB/Y9yk=;
        b=KeLxFeFhyETNOzBrYAophIJ5xELkNVcrtMwgr9tgAXcNJZBvojs17qR6jBJYUBzdq3
         yw4uX0s8RNrrRkn+zzlSd63YdFsNm0vKQCN48dYxSCgdXhdyxSdgYBaEjejptRNo3Qed
         Pnb9rTMPb/W34IWpPD5NrQc9ERDTBucqvdaWEUWuZ5U4tXIGIS80yFUIHcA3UPtrZt9p
         BROm1i2Np1tkN9iMJuBLoXGWwg6Jaj12bGWxQF0AMFS/81F2EcfrdDKp76psgN6f9MHV
         slEl5YCoYx9xmTKjo4YUMfssTyNVPC/+dw2PgmYrQpIbbHqIYGAgj1orad1zYZ8AOw5Y
         i1ew==
X-Forwarded-Encrypted: i=1; AJvYcCWY4zSnCtN7hK/5O6nrbOpnt5t6ncIlPbFHw+0tyZ5326/dbNAH5UnrCCJKvdNkJ5+R/ZgX3T2KwRS5TbP1cC+RIVSG2+A3BKRdy7DC
X-Gm-Message-State: AOJu0YxM30/EGpnK01JFbPZQX9hPG6inE5c/F4KuM/q2UQtGqQ1NgWul
	W2Q7HZkKsyOUJNaxf/BnsUyZJcvCrfY+INUZ5o0f08HRLwSRqXUkA2dDWUbw9sqa7IAmsqJKeUb
	yKUA0dsAP5CX4KrS6BUc47CfQGnpc7V+78i9AJpuTeZJ5/cRxuTY+tRU=
X-Google-Smtp-Source: AGHT+IH5QdcGAKBpOAUvYhYjJZA7iLPcQe6gVhzzRDOvzFZBwg5fhfy0nQdFWfh3kP9KcxfgcHug0BFvTfDaA6pzO9iSeJAvBBE2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c265:0:b0:369:f4bd:2df4 with SMTP id
 h5-20020a92c265000000b00369f4bd2df4mr161162ild.1.1712234971567; Thu, 04 Apr
 2024 05:49:31 -0700 (PDT)
Date: Thu, 04 Apr 2024 05:49:31 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000040a883061544c59f@google.com>
Subject: [syzbot] [netfilter?] KMSAN: uninit-value in nf_flow_offload_ip_hook
From: syzbot <syzbot+b6f07e1c07ef40199081@syzkaller.appspotmail.com>
To: coreteam@netfilter.org, davem@davemloft.net, edumazet@google.com, 
	kadlec@netfilter.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, netfilter-devel@vger.kernel.org, pabeni@redhat.com, 
	pablo@netfilter.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    3e92c1e6cd87 Merge tag 'selinux-pr-20240402' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=135dbd3d180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5112b3f484393436
dashboard link: https://syzkaller.appspot.com/bug?extid=b6f07e1c07ef40199081
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/ac287f716705/disk-3e92c1e6.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f04f8cb0bdc6/vmlinux-3e92c1e6.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a8eb9003da40/bzImage-3e92c1e6.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b6f07e1c07ef40199081@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in nf_flow_skb_encap_protocol net/netfilter/nf_flow_table_ip.c:290 [inline]
BUG: KMSAN: uninit-value in nf_flow_offload_lookup net/netfilter/nf_flow_table_ip.c:352 [inline]
BUG: KMSAN: uninit-value in nf_flow_offload_ip_hook+0x79a/0x3e40 net/netfilter/nf_flow_table_ip.c:424
 nf_flow_skb_encap_protocol net/netfilter/nf_flow_table_ip.c:290 [inline]
 nf_flow_offload_lookup net/netfilter/nf_flow_table_ip.c:352 [inline]
 nf_flow_offload_ip_hook+0x79a/0x3e40 net/netfilter/nf_flow_table_ip.c:424
 nf_hook_entry_hookfn include/linux/netfilter.h:154 [inline]
 nf_hook_slow+0xf2/0x3f0 net/netfilter/core.c:626
 nf_hook_ingress include/linux/netfilter_netdev.h:34 [inline]
 nf_ingress net/core/dev.c:5318 [inline]
 __netif_receive_skb_core+0x430b/0x6190 net/core/dev.c:5406
 __netif_receive_skb_one_core net/core/dev.c:5536 [inline]
 __netif_receive_skb+0xca/0xa00 net/core/dev.c:5652
 netif_receive_skb_internal net/core/dev.c:5738 [inline]
 netif_receive_skb+0x58/0x660 net/core/dev.c:5798
 tun_rx_batched+0x3ee/0x980 drivers/net/tun.c:1549
 tun_get_user+0x5566/0x69e0 drivers/net/tun.c:2002
 tun_chr_write_iter+0x3af/0x5d0 drivers/net/tun.c:2048
 call_write_iter include/linux/fs.h:2108 [inline]
 new_sync_write fs/read_write.c:497 [inline]
 vfs_write+0xb63/0x1520 fs/read_write.c:590
 ksys_write+0x20f/0x4c0 fs/read_write.c:643
 __do_sys_write fs/read_write.c:655 [inline]
 __se_sys_write fs/read_write.c:652 [inline]
 __x64_sys_write+0x93/0xe0 fs/read_write.c:652
 do_syscall_64+0xd5/0x1f0
 entry_SYSCALL_64_after_hwframe+0x72/0x7a

Uninit was created at:
 __alloc_pages+0x9d6/0xe70 mm/page_alloc.c:4598
 alloc_pages_mpol+0x299/0x990 mm/mempolicy.c:2264
 alloc_pages+0x1bf/0x1e0 mm/mempolicy.c:2335
 skb_page_frag_refill+0x2bf/0x7c0 net/core/sock.c:2921
 tun_build_skb drivers/net/tun.c:1679 [inline]
 tun_get_user+0x1258/0x69e0 drivers/net/tun.c:1819
 tun_chr_write_iter+0x3af/0x5d0 drivers/net/tun.c:2048
 call_write_iter include/linux/fs.h:2108 [inline]
 new_sync_write fs/read_write.c:497 [inline]
 vfs_write+0xb63/0x1520 fs/read_write.c:590
 ksys_write+0x20f/0x4c0 fs/read_write.c:643
 __do_sys_write fs/read_write.c:655 [inline]
 __se_sys_write fs/read_write.c:652 [inline]
 __x64_sys_write+0x93/0xe0 fs/read_write.c:652
 do_syscall_64+0xd5/0x1f0
 entry_SYSCALL_64_after_hwframe+0x72/0x7a

CPU: 0 PID: 5636 Comm: syz-executor.0 Not tainted 6.9.0-rc2-syzkaller-00042-g3e92c1e6cd87 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
=====================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

