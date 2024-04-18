Return-Path: <linux-kernel+bounces-150583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 637518AA13C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 19:39:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CFE3285B3A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 17:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 211B8174EFB;
	Thu, 18 Apr 2024 17:39:05 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48568172790
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 17:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713461944; cv=none; b=rn6ngDsVWxlrab6ByhdW3SX32IP5th9kNQjaPstaDbmCkkfyfohB5FeVqllXD9LuLKJbrCgiccH0MEJJCF7902m/GkfFOTTeZ7oqdm7PvMQQY34hdVGHkOzU6kWdmpznWoyrF4Hy8xjDXSC7hYzRfZfbKNbyzLvZ3XLlYLcnp5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713461944; c=relaxed/simple;
	bh=RWMZH6J0GD9RfQ02oyeBPmSOb4YXk/FmEyYTCBlrbsY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=mKYXLDJ/xAwb1pTMia9vcCDG3TcqKMyEhdydnBjC5N/5r5Oozvf9rrOG8a8+beEImb/Yx2i43TaYv08P1Ezt+9p1cieIWj9AkSpfKfFh8uyBVLtTagf7iM13xi6CsAe3J2jKpNZyeURNPPBgLLsVTsh5xT0Xujs1WWACDVG2QJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7cc7a930922so148527439f.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 10:39:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713461942; x=1714066742;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VFr4uVSTyAdq+TAQCve9ObM5/g9I+go2KD86NN0Rt0A=;
        b=eEA8OOCRRejpF+mKwt/3kB+xidHHfUHLEaCAwiQCvs4DjdkR8ywPKv9kfv1l27Tzs1
         xAY5WJYjbzqxh1QiPXXxX8Ed6uWl1DW49LCG1A29pKXZBd8F75he63RG2lqVS4uhINgJ
         uwRrFStcjg+jgjQOZyPYXVgiXWpKW/jReT+uiT2QNlTxOPT8usHjMRPEu34JjJI3iFeE
         rHMUHPXLrbnLr8G5DoEu5cgtGc4g9hE1vB5RARQGaeqbwWKpRHeY/u4Ph9+n0/91GEp8
         bjvXzsmf2+9TQQpKSeRJB8wNX5AgIkreqm3ss49qz95JQYkaWzodnwTMYZ+Emq/ks0V8
         eYlA==
X-Forwarded-Encrypted: i=1; AJvYcCUvH20uGaySh6vpU/0hbiMEO7rFqTXn2KIzR2BqJ3PfXszJ6Zlf2PjHw/fTBVvrDVx1kChyYKjGdKQQdyEAcDk6o59Y7pA3xFeW3cKe
X-Gm-Message-State: AOJu0Yxc/ykMKgdBGgmCnphWfVA8Z9gfn6QThcu2hzP+yQcl27k2walB
	6icOcpj9bVxUftplz7MIzCHV/d2DiQspXmxOQj9p1xMH6f7dKYDxmEx+AZrsq/9dd0aiVOHtYgT
	Ihk0ZWgmjM2WlrIZkQEGldnKSbEsCetI9drqB83Sn5DRBbZkJdbhjSyk=
X-Google-Smtp-Source: AGHT+IH89SWITvw1/tRkT49rrluxfRKiWcM5ZDlyF3g+kwjMn+UUqr+WyDGSuExMjHj4y7+T6yuK7ILFz8g5bDmfG9lRGLMHKYCt
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8615:b0:482:ca48:7441 with SMTP id
 iu21-20020a056638861500b00482ca487441mr258024jab.3.1713461942429; Thu, 18 Apr
 2024 10:39:02 -0700 (PDT)
Date: Thu, 18 Apr 2024 10:39:02 -0700
In-Reply-To: <20240418084011.313378-1-aha310510@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006a408f0616627229@google.com>
Subject: Re: [syzbot] [net?] KMSAN: uninit-value in hsr_get_node (3)
From: syzbot <syzbot+a81f2759d022496b40ab@syzkaller.appspotmail.com>
To: aha310510@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KMSAN: uninit-value in hsr_get_node

=====================================================
BUG: KMSAN: uninit-value in hsr_get_node+0xab0/0xad0 net/hsr/hsr_framereg.c:250
 hsr_get_node+0xab0/0xad0 net/hsr/hsr_framereg.c:250
 fill_frame_info net/hsr/hsr_forward.c:577 [inline]
 hsr_forward_skb+0x330/0x30e0 net/hsr/hsr_forward.c:615
 hsr_handle_frame+0xa20/0xb50 net/hsr/hsr_slave.c:69
 __netif_receive_skb_core+0x1cff/0x6190 net/core/dev.c:5432
 __netif_receive_skb_one_core net/core/dev.c:5536 [inline]
 __netif_receive_skb+0xca/0xa00 net/core/dev.c:5652
 netif_receive_skb_internal net/core/dev.c:5738 [inline]
 netif_receive_skb+0x58/0x660 net/core/dev.c:5798
 tun_rx_batched+0x3ee/0x980 drivers/net/tun.c:1549
 tun_get_user+0x5566/0x69e0 drivers/net/tun.c:2002
 tun_chr_write_iter+0x3af/0x5d0 drivers/net/tun.c:2048
 call_write_iter include/linux/fs.h:2110 [inline]
 new_sync_write fs/read_write.c:497 [inline]
 vfs_write+0xb63/0x1520 fs/read_write.c:590
 ksys_write+0x20f/0x4c0 fs/read_write.c:643
 __do_sys_write fs/read_write.c:655 [inline]
 __se_sys_write fs/read_write.c:652 [inline]
 __x64_sys_write+0x93/0xe0 fs/read_write.c:652
 x64_sys_call+0x3062/0x3b50 arch/x86/include/generated/asm/syscalls_64.h:2
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcf/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Uninit was created at:
 __alloc_pages+0x9d6/0xe70 mm/page_alloc.c:4598
 alloc_pages_mpol+0x299/0x990 mm/mempolicy.c:2264
 alloc_pages+0x1bf/0x1e0 mm/mempolicy.c:2335
 skb_page_frag_refill+0x2bf/0x7c0 net/core/sock.c:2921
 tun_build_skb drivers/net/tun.c:1679 [inline]
 tun_get_user+0x1258/0x69e0 drivers/net/tun.c:1819
 tun_chr_write_iter+0x3af/0x5d0 drivers/net/tun.c:2048
 call_write_iter include/linux/fs.h:2110 [inline]
 new_sync_write fs/read_write.c:497 [inline]
 vfs_write+0xb63/0x1520 fs/read_write.c:590
 ksys_write+0x20f/0x4c0 fs/read_write.c:643
 __do_sys_write fs/read_write.c:655 [inline]
 __se_sys_write fs/read_write.c:652 [inline]
 __x64_sys_write+0x93/0xe0 fs/read_write.c:652
 x64_sys_call+0x3062/0x3b50 arch/x86/include/generated/asm/syscalls_64.h:2
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcf/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

CPU: 0 PID: 5497 Comm: syz-executor.0 Not tainted 6.9.0-rc4-syzkaller-00038-g8cd26fd90c1a #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
=====================================================


Tested on:

commit:         8cd26fd9 Merge tag 'for-6.9-rc4-tag' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1398c9ab180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=87a805e655619c64
dashboard link: https://syzkaller.appspot.com/bug?extid=a81f2759d022496b40ab
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.

