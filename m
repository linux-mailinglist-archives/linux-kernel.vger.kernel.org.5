Return-Path: <linux-kernel+bounces-101560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD9AB87A8B1
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 14:47:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D979B1C21A6F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 13:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 002C34437C;
	Wed, 13 Mar 2024 13:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PJ8VuGqZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2374743AD1;
	Wed, 13 Mar 2024 13:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710337657; cv=none; b=AINy+U0xMkGJ+xtSRPqB+PKf5W5pkw1nU33L+ZwwTQrmojjb/3WTz8xRgD+b7K2sRn42lTHRPaY9/SK7TyS2DetHS2AXkzTKL+0YgXW7/2EiMGW8oiOnOiHrlsOUnI0AHVbAg+/rNwcY1XQEUmG6augLwTtbU8zVaQhRVd61FkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710337657; c=relaxed/simple;
	bh=Wm12Cwnnaqqxe6Rw9omoTYJwGYyRMYnkrihCLFB1dLg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Vc11uJlUNQr2FZysI0D5yxBbafAh+SeHEJbIzy4W5FJLwcXTsDWECYW1sdFUP9VdX9QY/NFo5qgBdkW1NAyXMymHLwW6y3dL4qvoqg5SdQ+9oq8ZpNv48LfnQWt6gHbKIIbO6S2RbtTPezTK5wU8x6Zv9C5N19rP3IjzOSr016M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PJ8VuGqZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 117BBC43390;
	Wed, 13 Mar 2024 13:47:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710337656;
	bh=Wm12Cwnnaqqxe6Rw9omoTYJwGYyRMYnkrihCLFB1dLg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=PJ8VuGqZqsRwlTYOY7+8sOgrmQ4V9EP9qdW+8lWd07EaQ40dhKJ45vzLMybMBBdBM
	 W0x301+/QGXMPSnX+1SW3FtBu5vIiN6xCze+MuJLXGvX1WHvKa7skNGjVx63S1g3h5
	 Mwdn5iL7BXY/WFmsnjDhC+IAQsnpxkBvyHThGYiW577rhpEIHHPAgbezLAwbzhNJpl
	 Ny1dei9uxXxQXL/eEwvUsDGnYhvtjNMyYc1TeQ1zdYHix70ghVFu4LOeTZEJYTnCmD
	 Daj7s1ktSQlpfo9aob5je8Z6zz+0b4V/pGf++TgUJzrsTz0cpFsBzzT0hLmIEux21f
	 RqfnyXerwe5Fg==
Date: Wed, 13 Mar 2024 10:47:33 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Ian Rogers <irogers@google.com>, Ingo Molnar <mingo@redhat.com>,
	Jiri Olsa <jolsa@kernel.org>, Marco Elver <elver@google.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2 0/4] perf: Make SIGTRAP and __perf_pending_irq() work
 on RT.
Message-ID: <ZfGudRl9-tB_TszO@x1>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZfGqCWzyVzyGQrAQ@x1>

On Wed, Mar 13, 2024 at 10:28:44AM -0300, Arnaldo Carvalho de Melo wrote:
> On Wed, Mar 13, 2024 at 09:13:03AM +0100, Sebastian Andrzej Siewior wrote:
> > One part I don't get: did you let it run or did you kill it?
 
> If I let them run they will finish and exit, no exec_child remains.
 
> If I instead try to stop the loop that goes on forking the 100 of them,
> then the exec_child remain spinning.
 
> > `exec_child' spins until a signal is received or the parent kills it. So
 
> > it shouldn't remain there for ever. And my guess, that it is in spinning
> > in userland and not in kernel.
 
> Checking that now:

tldr; the tight loop, full details at the end.

100.00  b6:   mov    signal_count,%eax
              test   %eax,%eax
            ↑ je     b6     

remove_on_exec.c

/* For exec'd child. */
static void exec_child(void)
{
        struct sigaction action = {};
        const int val = 42;

        /* Set up sigtrap handler in case we erroneously receive a trap. */
        action.sa_flags = SA_SIGINFO | SA_NODEFER;
        action.sa_sigaction = sigtrap_handler;
        sigemptyset(&action.sa_mask);
        if (sigaction(SIGTRAP, &action, NULL))
                _exit((perror("sigaction failed"), 1));

        /* Signal parent that we're starting to spin. */
        if (write(STDOUT_FILENO, &val, sizeof(int)) == -1)
                _exit((perror("write failed"), 1));

        /* Should hang here until killed. */
        while (!signal_count);
}

So probably just a test needing to be a bit more polished?

Seems like it, on a newer machine, faster, I managed to reproduce it on
a non-RT kernel, with one exec_child remaining:

  1.44  b6:   mov   signal_count,%eax
              test  %eax,%eax
 98.56      ↑ je    b6

same tight loop:

acme@x1:~/git/perf-tools-next/tools/testing/selftests/perf_events$ pidof exec_child
722300
acme@x1:~/git/perf-tools-next/tools/testing/selftests/perf_events$ ps ax|grep exec_child
 722300 pts/2    R      4:08 exec_child
 722502 pts/2    S+     0:00 grep --color=auto exec_child
acme@x1:~/git/perf-tools-next/tools/testing/selftests/perf_events$

- Arnaldo

[root@nine ~]# perf record --call-graph dwarf -p 35785
^C[ perf record: Woken up 48 times to write data ]
[ perf record: Captured and wrote 12.120 MB perf.data (1503 samples) ]

[root@nine ~]# ls -la perf.data
-rw-------. 1 root root 12720152 Mar 13 10:32 perf.data
[root@nine ~]#
[root@nine ~]# perf report --no-child --stdio
# To display the perf.data header info, please use --header/--header-only options.
#
#
# Total Lost Samples: 0
#
# Samples: 1K of event 'cycles:P'
# Event count (approx.): 926018718
#
# Overhead  Command  Shared Object      Symbol                                
# ........  .......  .................  ......................................
#
    98.48%  exe      remove_on_exec     [.] exec_child
            |
            ---exec_child
               main
               __libc_start_call_main
               __libc_start_main@@GLIBC_2.34
               _start

     0.33%  exe      [kernel.kallsyms]  [k] arch_scale_freq_tick
     0.13%  exe      [kernel.kallsyms]  [k] debug_smp_processor_id
     0.13%  exe      [kernel.kallsyms]  [k] check_cpu_stall
     0.13%  exe      [kernel.kallsyms]  [k] acct_account_cputime
     0.13%  exe      [kernel.kallsyms]  [k] cpuacct_account_field
     0.07%  exe      [kernel.kallsyms]  [k] preempt_count_add
     0.07%  exe      [kernel.kallsyms]  [k] update_irq_load_avg
     0.07%  exe      [kernel.kallsyms]  [k] cgroup_rstat_updated
     0.07%  exe      [kernel.kallsyms]  [k] rcu_sched_clock_irq
     0.07%  exe      [kernel.kallsyms]  [k] account_user_time
     0.07%  exe      [kernel.kallsyms]  [k] __hrtimer_run_queues
     0.07%  exe      [kernel.kallsyms]  [k] tick_nohz_highres_handler
     0.07%  exe      [kernel.kallsyms]  [k] ktime_get_update_offsets_now
     0.06%  exe      [kernel.kallsyms]  [k] __enqueue_entity
     0.06%  exe      [kernel.kallsyms]  [k] tick_sched_handle
     0.00%  exe      [kernel.kallsyms]  [k] __intel_pmu_enable_all.constprop.0


#
# (Tip: To show assembler sample contexts use perf record -b / perf script -F +brstackinsn --xed)
#
[root@nine ~]#

[root@nine ~]# perf annotate --stdio2 exec_child 
Samples: 1K of event 'cycles:P', 4000 Hz, Event count (approx.): 911943256, [percent: local period]
exec_child() /home/acme/git/linux/tools/testing/selftests/perf_events/remove_on_exec
Percent        
               
               
            Disassembly of section .text:
               
            00000000004045cf <exec_child>:
              push   %rbp   
              mov    %rsp,%rbp
              sub    $0xb0,%rsp
              lea    -0xa0(%rbp),%rdx
              mov    $0x0,%eax
              mov    $0x13,%ecx
              mov    %rdx,%rdi
              rep    stos %rax,%es:(%rdi)
              movl   $0x2a,-0xa4(%rbp)
              movl   $0x40000004,-0x18(%rbp)
              movq   $0x402a2e,-0xa0(%rbp)
              lea    -0xa0(%rbp),%rax
              add    $0x8,%rax
              mov    %rax,%rdi
            → callq  sigemptyset@plt
              lea    -0xa0(%rbp),%rax
              mov    $0x0,%edx
              mov    %rax,%rsi
              mov    $0x5,%edi
            → callq  sigaction@plt
              test   %eax,%eax
            ↓ je     82     
              mov    $0x4058af,%edi
            → callq  perror@plt
              mov    $0x1,%edi
            → callq  _exit@plt
        82:   lea    -0xa4(%rbp),%rax
              mov    $0x4,%edx
              mov    %rax,%rsi
              mov    $0x1,%edi
            → callq  write@plt
              cmp    $0xffffffffffffffff,%rax
            ↓ jne    b5     
              mov    $0x4058c0,%edi
            → callq  perror@plt
              mov    $0x1,%edi
            → callq  _exit@plt
        b5:   nop           
100.00  b6:   mov    signal_count,%eax
              test   %eax,%eax
            ↑ je     b6     
              nop           
              nop           
              leaveq        
            ← retq          
[root@nine ~]#

