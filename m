Return-Path: <linux-kernel+bounces-121987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 645E888F048
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 21:42:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EDDF1C2DA0E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 20:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EC41152E06;
	Wed, 27 Mar 2024 20:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wIXc3lxC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7f8ZT4kU"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5BF028366
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 20:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711572143; cv=none; b=nVCA98/PRuMl3B5WG8NmIihTUt8EGHRrvfa+gLiRd5UFO0NxyWVaapNClRX82ECCaidGOOjcPSJyNGZP1ikKpfNLDRHaBTfH/XxEtqiSY6DPpkz/6bUm54VwbVTDdvdA44sRv+1pJoanVIT8k6j9nVit6quU9vsfIxcDFfC8DxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711572143; c=relaxed/simple;
	bh=0EZfYWHMc+ji8LB9eoKEsU8L5qzPoYXrC7zw7ZYflyk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MVnNYb5Xv+xzKfqSOM5t2/vEXnookQgTdT9n2kKbOzUi4DtpwaCPPDCHHRk16TW1vnc+hfb02CxPqZD7UTSuHPb45v97ZmtXeLdh0MSl2ByGzEINYwq/iFzUzfsLOXxQZyhlZaAGIuKg/yiVVIACKY6S97mz+A8wa+rBGs8ZuGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wIXc3lxC; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=7f8ZT4kU; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1711572133;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1+W9oPmmYqextKEu5dJ3ThwHaBt97fiAq/NkrUovWwQ=;
	b=wIXc3lxCwtJbicWu9BGypzTFSQGHIwRTV5yZapsjRRelCtpfJcmBKlJiwMKhMZBlYNK8BQ
	+Ej8uCIwvWiy5Z/n222PczU/4VzubR37YEBVo9+dgCCnxdS40oDWz8/GK/diTFg+M2j2DV
	7vqqiuQKww1fAQWPvYEyN52b0DhREK54GyeiqF6cMwBMr/yclq4jdlwyjYKsUwAqwl3MKS
	rhXFJyX5PPLzxnSUfqMMC/m+GpnbdsrQhIzEVDQ/4uYLRDrysViivzHvxGtYek7b4VovW+
	iGdmQqY5OEdIYroF9itfPklWMHTFYjPpYb8DtC4y6UR21NShcKxKygRBDuF5gA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1711572133;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1+W9oPmmYqextKEu5dJ3ThwHaBt97fiAq/NkrUovWwQ=;
	b=7f8ZT4kUDXpy+6JjYZ2gJYulAFz8h5hxn38RkcOYby/xRfVXUTii+iIegpxzSgQO6rh27h
	YGYiYMwgaTvL79BQ==
To: Valentin Schneider <vschneid@redhat.com>, Frederic Weisbecker
 <frederic@kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
 Anna-Maria Behnsen <anna-maria@linutronix.de>, Alex Shi
 <alexs@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Vincent Guittot
 <vincent.guittot@linaro.org>, Barry Song <song.bao.hua@hisilicon.com>,
 Tejun Heo <tj@kernel.org>
Subject: Re: for_each_domain()/sched_domain_span() has offline CPUs (was Re:
 [PATCH 2/2] timers: Fix removed self-IPI on global timer's enqueue in
 nohz_full)
In-Reply-To: <xhsmhwmppaqls.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
References: <20240318230729.15497-1-frederic@kernel.org>
 <20240318230729.15497-3-frederic@kernel.org>
 <464f6be2-4a72-440d-be53-6a1035d56a4f@paulmck-laptop>
 <1b5752c8-ef32-4ed4-b539-95d507ec99ce@paulmck-laptop>
 <ZfsLtMijRrNZfqh6@localhost.localdomain>
 <6a95b6ac-6681-4492-b155-e30c19bb3341@paulmck-laptop>
 <ZfwdEROGFFmIbkCM@lothringen>
 <bf8689c2-0749-47cb-9535-53cf66e34f5e@paulmck-laptop>
 <Zf1sSv/6mQHJuJ8G@lothringen> <Zf2GDjekyemQKn7I@lothringen>
 <xhsmhwmppaqls.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Date: Wed, 27 Mar 2024 21:42:12 +0100
Message-ID: <87cyrfe7a3.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Mar 26 2024 at 17:46, Valentin Schneider wrote:
> On 22/03/24 14:22, Frederic Weisbecker wrote:
>> On Fri, Mar 22, 2024 at 12:32:26PM +0100, Frederic Weisbecker wrote:
> Now, on top of the above, there's one more thing worth noting:
>   cpu_up_down_serialize_trainwrecks()
>
> This just flushes the cpuset work, so after that the sched_domain topology
> should be sane. However I see it's invoked at the tail end of _cpu_down(),
> IOW /after/ takedown_cpu() has run, which sounds too late. The comments
> around this vs. lock ordering aren't very reassuring however, so I need to
> look into this more.

commit b22afcdf04c96ca58327784e280e10288cfd3303 has more information in
the change log.

TLDR: The problem is that cpusets have the lock order cpuset_mutex ->
cpu_hotplug_lock in the hotplug path for whatever silly reason. So
trying to flush the work from within the cpu hotplug lock write held
region is guaranteed to dead lock.

That's why all of this got deferred to a work queue. The flush at the
end of the hotplug code after dropping the hotplug lock is there to
prevent that user space sees the CPU hotplug uevent before the work is
done. But of course between bringing the CPU offline and the flush the
kernel internal state is inconsistent.

There was an attempt to make the CPU hotplug path synchronous in commit
a49e4629b5ed ("cpuset: Make cpuset hotplug synchronous") which got
reverted with commit 2b729fe7f3 for the very wrong reason:

https://lore.kernel.org/all/F0388D99-84D7-453B-9B6B-EEFF0E7BE4CC@lca.pw/T/#u

 (cpu_hotplug_lock){++++}-{0:0}:
  lock_acquire+0xe4/0x25c
  cpus_read_lock+0x50/0x154
  static_key_slow_inc+0x18/0x30
  mem_cgroup_css_alloc+0x824/0x8b0
  cgroup_apply_control_enable+0x1d8/0x56c
  cgroup_apply_control+0x40/0x344
  cgroup_subtree_control_write+0x664/0x69c
  cgroup_file_write+0x130/0x2e8
  kernfs_fop_write+0x228/0x32c
  __vfs_write+0x84/0x1d8
  vfs_write+0x13c/0x1b4
  ksys_write+0xb0/0x120

Instead of the revert this should have been fixed by doing:

+  cpus_read_lock();
   mutex_lock();
   mem_cgroup_css_alloc();
-  static_key_slow_inc();
+  static_key_slow_inc_cpuslocked();

Sorry that I did not notice this back then because I was too focussed on
fixing that uevent nonsense in a halfways sane way.

After that revert cpuset locking became completely insane.

cpuset_hotplug_cpus_read_trylock() is the most recent but also the most
advanced part of that insanity. Seriously this commit is just tasteless
and disgusting demonstration of how to paper over a problem which is not
fully understood.

After staring at it some more (including the history which led up to
these insanities) I really think that the CPU hotplug path can be made
truly synchronous and the memory hotplug path should just get the lock
ordering correct.

Can we please fix this for real and get all of this insanity out of the
way including the nonsensical comments in the cpuset code:

 * Call with cpuset_mutex held.  Takes cpus_read_lock().

 ...

       lockdep_assert_cpus_held();
       lockdep_assert_held(&cpuset_mutex);

Oh well...

Thanks,

        tglx

