Return-Path: <linux-kernel+bounces-49961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57EAD84721B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 15:42:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D08D286A28
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 14:42:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD7254779F;
	Fri,  2 Feb 2024 14:42:36 +0000 (UTC)
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B3620DFA;
	Fri,  2 Feb 2024 14:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706884956; cv=none; b=deF2gvgEj1j8ivZh+GnKZZiOK8ne5+M7M+eF8IFugRs8ATykRtQnh+8FAJw7DK0ah4S0HBwrPVfBSrizBypc50cg50qIWgukyOF9aRqTicMNcvdcqurLS2e6kMBiNaWMBn0tnMgakfBICao8UI9a35pXrqkM0fiPTrE+c5WnYSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706884956; c=relaxed/simple;
	bh=2P+ZNughbw18nF0XEj47/8gcO7qDHTuHeliWPvBKGcE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Fv66hovJgcF2JO/Fi4S78QjqZVUx3MlWyq5yIRYJj+6gioxBcQblAvKoRcFy9xTOROf3bIDgVIDWj74mNoJb3e393PKuuh4IPBp0P7C+y59csntCdOSBnbmeHY3VTN/3cxaaGhO4qSQgKiUNl923LZYf9cYQ1NjRQHrx87WvLDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4TRHkl5ZTlz9xqpg;
	Fri,  2 Feb 2024 22:11:27 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id B75331405F9;
	Fri,  2 Feb 2024 22:26:28 +0800 (CST)
Received: from [10.81.209.159] (unknown [10.81.209.159])
	by APP1 (Coremail) with SMTP id LxC2BwBHPxiM+7xl22O9AQ--.55539S2;
	Fri, 02 Feb 2024 15:26:28 +0100 (CET)
Message-ID: <c6ce8816-c4ff-4668-8cbb-88285330057d@huaweicloud.com>
Date: Fri, 2 Feb 2024 15:26:14 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] workqueues and printk not playing nice since next-20240130
To: paulmck@kernel.org, Tejun Heo <tj@kernel.org>,
 Lai Jiangshan <jiangshanlai@gmail.com>, Petr Mladek <pmladek@suse.com>,
 Steven Rostedt <rostedt@goodmis.org>, John Ogness
 <john.ogness@linutronix.de>, Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-kernel@vger.kernel.org,
 rcu@vger.kernel.org
References: <410d6a87-bf34-457e-b714-1e6149d48532@paulmck-laptop>
From: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
In-Reply-To: <410d6a87-bf34-457e-b714-1e6149d48532@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:LxC2BwBHPxiM+7xl22O9AQ--.55539S2
X-Coremail-Antispam: 1UD129KBjvJXoWxCr1UAF1xXry8uF45CFyDWrg_yoWrtryfpr
	W5Gr4UWr4kG347ZF1kAw15Xa4Yy3Z0yay3JasxGr98Xw15KF1ayF1ftFW7ua4qvr4rCF1a
	qF90v3y2qw1UAaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28IcxkI
	7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxV
	Cjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY
	6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6x
	AIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv
	6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07UWE__UUUUU=
X-CM-SenderInfo: 5mrqt2oorev25kdx2v3u6k3tpzhluzxrxghudrp/


Am 2/2/2024 um 2:04 PM schrieb Paul E. McKenney:
> Hello!
>
> Starting with next-20240130 (and perhaps a bit earlier), rcutorture gets
> what initially looked like early-boot hangs, but only when running on
> dual-socket x86 systems [1], as it it works just fine on my x86 laptop [2].
> But when running on dual-socket systems, this happens all the time,
> perhaps because rcutorture works hard to split each guest OS across a
> socket boundary.
>
> This is the reproducer:
>
> tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration 1m --configs "10*TREE01" --trust-make
>
> By "looked like early-boot hangs" I mean that qemu was quite happy,
> but there was absolutely no console output.
>
> Bisection identified this commit:
>
> 5797b1c18919 ("workqueue: Implement system-wide nr_active enforcement for unbound workqueues")
>
> Reverting this commit made the problem go away.  Except that it is really
> hard to imagine this commit having any effect whatsoever on early boot
> execution.  Of course, this might be a failure of imagination on my part,
> so I enlisted the aid of gdb:
>
> tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration 1m --configs "TREE01" --trust-make --gdb
>
> After following the resulting gdb startup instructions and waiting for
> about ten seconds, I hit control-C on the gdb window and then:
>
> 	(gdb) bt
> 	#0  default_idle () at arch/x86/kernel/process.c:743
> 	#1  0xffffffff81e94d34 in default_idle_call () at kernel/sched/idle.c:97
> 	#2  0xffffffff810d746d in cpuidle_idle_call () at kernel/sched/idle.c:170
> 	#3  do_idle () at kernel/sched/idle.c:312
> 	#4  0xffffffff810d76a4 in cpu_startup_entry (state=state@entry=CPUHP_ONLINE)
> 	    at kernel/sched/idle.c:410
> 	#5  0xffffffff81e95417 in rest_init () at init/main.c:730
> 	#6  0xffffffff8329adf2 in start_kernel () at init/main.c:1067
> 	#7  0xffffffff832a5038 in x86_64_start_reservations (
> 	    real_mode_data=real_mode_data@entry=0x13d50 <exception_stacks+32080> <error: Cannot access memory at address 0x13d50>) at arch/x86/kernel/head64.c:555
> 	#8  0xffffffff832a513c in x86_64_start_kernel (
> 	    real_mode_data=0x13d50 <exception_stacks+32080> <error: Cannot access memory at address 0x13d50>) at arch/x86/kernel/head64.c:536
> 	#9  0xffffffff810001d2 in secondary_startup_64 ()
> 	    at arch/x86/kernel/head_64.S:461
> 	#10 0x0000000000000000 in ?? ()
> 	(gdb) print jiffies
> 	$1 = 4294676330
> 	(gdb) print system_state
> 	$2 = SYSTEM_RUNNING
>
> In other words, the system really has booted, and at least one CPU is
> happily idling in the idle loop.  And another CPU is (maybe not quite
> so happily) running rcutorture:
>
> 	(gdb) thread 6
> 	[Switching to thread 6 (Thread 1.6)]
> 	#0  0xffffffff8111160b in rcu_torture_one_read (
> 	    trsp=trsp@entry=0xffffc900004abe90, myid=myid@entry=4)
> 	    at kernel/rcu/rcutorture.c:2003
> 	2003            completed = cur_ops->get_gp_seq();
> 	(gdb) bt
> 	#0  0xffffffff8111160b in rcu_torture_one_read (
> 	    trsp=trsp@entry=0xffffc900004abe90, myid=myid@entry=4)
> 	    at kernel/rcu/rcutorture.c:2003
> 	#1  0xffffffff81111bef in rcu_torture_reader (arg=0x4 <fixed_percpu_data+4>)
> 	    at kernel/rcu/rcutorture.c:2097
> 	#2  0xffffffff810af3e0 in kthread (_create=0xffff8880047aa480)
> 	    at kernel/kthread.c:388
> 	#3  0xffffffff8103af1f in ret_from_fork (prev=<optimized out>,
> 	    regs=0xffffc900004abf58, fn=0xffffffff810af300 <kthread>,
> 	    fn_arg=0xffff8880047aa480) at arch/x86/kernel/process.c:147
> 	#4  0xffffffff8100247a in ret_from_fork_asm () at arch/x86/entry/entry_64.S:242
> 	#5  0x0000000000000000 in ?? ()
>
> So the system really did boot and is running just fine.  It is just that
> there is no console output.  Details, details!
>
> Is there anything I can do to some combination of workqueues and printk
> to help debug this?  Or that I can do to anything else, as I am not
> feeling all that picky.  ;-)


Just to exclude one source of troubles, have you tried turning all 
atomics into full barriers and seen if the issue still reproduces?

jonas


>
> 							Thanx, Paul
>
> [1] The dual-socket system is an 80-hardware-thread (20 cores per socket)
>      system with model name Intel(R) Xeon(R) Gold 6138 CPU @ 2.00GHz.
>      I get the same results when using either of these compilers:
>      gcc version 8.5.0 20210514 (Red Hat 8.5.0-21) (GCC)
>      gcc version 11.4.1 20230605 (Red Hat 11.4.1-2) (GCC)
>
> [2] My laptop is a 16-hardware-thread (8 cores) single-socket system with
>      model name "Intel(R) Core(TM) i9-10885H CPU @ 2.40GHz" and
>      gcc version 11.4.0 (Ubuntu 11.4.0-1ubuntu1~22.04).


