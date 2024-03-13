Return-Path: <linux-kernel+bounces-101461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40C0287A76E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 13:14:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D69911F23DF3
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 12:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CEDA3FE58;
	Wed, 13 Mar 2024 12:14:14 +0000 (UTC)
Received: from mail115-79.sinamail.sina.com.cn (mail115-79.sinamail.sina.com.cn [218.30.115.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA5D63FB0F
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 12:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710332053; cv=none; b=kjITxxKLxDc5so+E/1oJIYE0KOmlsu/vEwoF+2etq4EFZzM4ATdJhTVTJ6XVZn8+EYMKKAP2TufAhyNRCLxaSPWq985UaRsY4Zw5vXokETUkI0jx+TlfpENQ1+YUKEaITT3YAlKVprxg/adJj8lEQuvNsfsDS0yY2Rtf5zE0L2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710332053; c=relaxed/simple;
	bh=sOkhZ/jvuJIvVKMVXakf+8B+RRwVxQbb5lRb+kXv7gY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TWNo93YdHPW4dmE5C00aFcWwzKKQN8l2Bp22nAFQO0c8f9CEpbcwKLZ+mR4z1jJU9zpkaWludDePPXDJF2kvBX0x6mQGz/gyWmm0jfI2e10t2PhBLjrOMxOyn3PhwG8h51O4+QwJ34KRuUvC8/tkf8DP/IPybnZWLi9zK6ShYJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([116.24.9.180])
	by sina.com (10.75.12.45) with ESMTP
	id 65F19882000062E7; Wed, 13 Mar 2024 20:13:58 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 63174631457839
X-SMAIL-UIID: DBAC9056B457471298C7A75B155E6EF3-20240313-201358-1
From: Hillf Danton <hdanton@sina.com>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: syzbot <syzbot+850aaf14624dc0c6d366@syzkaller.appspotmail.com>,
	andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com,
	yonghong.song@linux.dev
Subject: Re: [syzbot] [bpf?] possible deadlock in __bpf_ringbuf_reserve
Date: Wed, 13 Mar 2024 20:13:45 +0800
Message-Id: <20240313121345.2292-1-hdanton@sina.com>
In-Reply-To: <ZfDC45Kc1VEvBMuW@krava>
References: <0000000000004aa700061379547e@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 12 Mar 2024 22:02:27 +0100 Jiri Olsa <olsajiri@gmail.com>
> On Tue, Mar 12, 2024 at 09:41:26AM -0700, syzbot wrote:
> > Hello,
> > 
> > syzbot found the following issue on:
> > 
> > HEAD commit:    df4793505abd Merge tag 'net-6.8-rc8' of git://git.kernel.o..
> > git tree:       bpf
> > console+strace: https://syzkaller.appspot.com/x/log.txt?x=11fd0092180000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=c11c5c676adb61f0
> > dashboard link: https://syzkaller.appspot.com/bug?extid=850aaf14624dc0c6d366
> > compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1509c4ae180000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10babc01180000
> > 
> > Downloadable assets:
> > disk image: https://storage.googleapis.com/syzbot-assets/d2e80ee1112b/disk-df479350.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/b35ea54cd190/vmlinux-df479350.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/59f69d999ad2/bzImage-df479350.xz
> > 
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+850aaf14624dc0c6d366@syzkaller.appspotmail.com
> > 
> > ============================================
> > WARNING: possible recursive locking detected
> > 6.8.0-rc7-syzkaller-gdf4793505abd #0 Not tainted
> > --------------------------------------------
> > strace-static-x/5063 is trying to acquire lock:
> > ffffc900096f10d8 (&rb->spinlock){-.-.}-{2:2}, at: __bpf_ringbuf_reserve+0x211/0x4f0 kernel/bpf/ringbuf.c:424
> > 
> > but task is already holding lock:
> > ffffc900098410d8 (&rb->spinlock){-.-.}-{2:2}, at: __bpf_ringbuf_reserve+0x211/0x4f0 kernel/bpf/ringbuf.c:424
> > 
> > other info that might help us debug this:
> >  Possible unsafe locking scenario:
> > 
> >        CPU0
> >        ----
> >   lock(&rb->spinlock);
> >   lock(&rb->spinlock);
> > 
> >  *** DEADLOCK ***
> > 
> >  May be due to missing lock nesting notation
> > 
> > 4 locks held by strace-static-x/5063:
> >  #0: ffff88807857e068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:103 [inline]
> >  #0: ffff88807857e068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x1cc/0x1a40 fs/pipe.c:465
> >  #1: ffffffff8e130be0 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:298 [inline]
> >  #1: ffffffff8e130be0 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:750 [inline]
> >  #1: ffffffff8e130be0 (rcu_read_lock){....}-{1:2}, at: __bpf_trace_run kernel/trace/bpf_trace.c:2380 [inline]
> >  #1: ffffffff8e130be0 (rcu_read_lock){....}-{1:2}, at: bpf_trace_run2+0x114/0x420 kernel/trace/bpf_trace.c:2420
> >  #2: ffffc900098410d8 (&rb->spinlock){-.-.}-{2:2}, at: __bpf_ringbuf_reserve+0x211/0x4f0 kernel/bpf/ringbuf.c:424
> >  #3: ffffffff8e130be0 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:298 [inline]
> >  #3: ffffffff8e130be0 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:750 [inline]
> >  #3: ffffffff8e130be0 (rcu_read_lock){....}-{1:2}, at: __bpf_trace_run kernel/trace/bpf_trace.c:2380 [inline]
> >  #3: ffffffff8e130be0 (rcu_read_lock){....}-{1:2}, at: bpf_trace_run2+0x114/0x420 kernel/trace/bpf_trace.c:2420
> > 
> > stack backtrace:
> > CPU: 0 PID: 5063 Comm: strace-static-x Not tainted 6.8.0-rc7-syzkaller-gdf4793505abd #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/25/2024
> > Call Trace:
> >  <TASK>
> >  __dump_stack lib/dump_stack.c:88 [inline]
> >  dump_stack_lvl+0x1e7/0x2e0 lib/dump_stack.c:106
> >  check_deadlock kernel/locking/lockdep.c:3062 [inline]
> >  validate_chain+0x15c0/0x58e0 kernel/locking/lockdep.c:3856
> >  __lock_acquire+0x1345/0x1fd0 kernel/locking/lockdep.c:5137
> >  lock_acquire+0x1e3/0x530 kernel/locking/lockdep.c:5754
> >  __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
> >  _raw_spin_lock_irqsave+0xd5/0x120 kernel/locking/spinlock.c:162
> >  __bpf_ringbuf_reserve+0x211/0x4f0 kernel/bpf/ringbuf.c:424
> >  ____bpf_ringbuf_reserve kernel/bpf/ringbuf.c:459 [inline]
> >  bpf_ringbuf_reserve+0x5c/0x70 kernel/bpf/ringbuf.c:451
> >  bpf_prog_9efe54833449f08e+0x2d/0x47
> >  bpf_dispatcher_nop_func include/linux/bpf.h:1231 [inline]
> >  __bpf_prog_run include/linux/filter.h:651 [inline]
> >  bpf_prog_run include/linux/filter.h:658 [inline]
> >  __bpf_trace_run kernel/trace/bpf_trace.c:2381 [inline]
> 
> hum, scratching my head how this could passed through the prog->active check,
> will try to reproduce

Feel free to take a look at another syzbot report [1,2]

[1] Subject: Re: [syzbot] [ntfs3?] possible deadlock in ntfs_set_state (2)
https://lore.kernel.org/lkml/ZdwSXCaTrzq7mm7Z@boqun-archlinux/

[2] Subject: Re: [syzbot] [bpf?] possible deadlock in __bpf_ringbuf_reserve
https://lore.kernel.org/lkml/00000000000082883f061388d49e@google.com/

