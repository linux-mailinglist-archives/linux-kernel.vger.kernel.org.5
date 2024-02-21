Return-Path: <linux-kernel+bounces-75362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F242685E73F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 20:26:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22FE3B283E8
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 19:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AABF886122;
	Wed, 21 Feb 2024 19:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cDnMxz6n"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3BA785951;
	Wed, 21 Feb 2024 19:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708543592; cv=none; b=bpJQiAbUz3AXHFh+v+ho8AGZmSlJx5bRsbXe3xoPliDAxQ4KRQKup2ArCMucMohWx2jsac1mxdyACZsnAApZTGcyP0ycaYJInXXSJYShwuPk58JcpofgxeU4qPDm03ctMuDr4Od/+Z72EjI5unFTv2btnGL9bCGnme4pTJGIxqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708543592; c=relaxed/simple;
	bh=91FyS08qWiRDlfMFBy4FOxLFqiOt/aEpMc0x5QwlDEY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Mqk8+kPLn4OQLPe2DwyyQ5ZEeMN1lx3CLq//tXasAN8jvXyn+FTt7xTFhGPpn01KmQpGEfeBQRBQy7gf7Fo4SpLkvL1hWfBHnl6Hqaur+MGRGZML93Hb+Ux3JBgcTgl9D75eKUB6/HHdoPxTlmCBC1U2yKNwArhNMDXdJ2sPo+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cDnMxz6n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4C66C433F1;
	Wed, 21 Feb 2024 19:26:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708543592;
	bh=91FyS08qWiRDlfMFBy4FOxLFqiOt/aEpMc0x5QwlDEY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=cDnMxz6n0tEThszwo0X3l9YoIL3uzpPkbjkMTUlHLsHkkICAdlC9hK8kpfEoNu5wB
	 KHDt2WOSYb0FiEj2dfG93p/X5sOEKvP9636M9qEARAGpOYSoL/8zRSvCsKk5fiAJ84
	 nmZujen4MnwPIkA1dhgIqxFOkd187aoxtObWjSK1AMRVCW3tYIXITP3QEVuHEg35Sf
	 BeMWKV9nuo14ef9M8q0gPhNVTRQ/OnAh6xRGAknh97ikmfrv4lsKAL/ftu3DCXagw8
	 KsMYyGWkI4Gpopi8AwOUmw6Sxv345qPXysMyUVPuQH7447/CYaCCxx26B/fmp9Bp//
	 u7VtC3TR75v6Q==
Date: Wed, 21 Feb 2024 16:26:26 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Mike Galbraith <efault@gmx.de>, Peter Zijlstra <peterz@infradead.org>,
	Marco Elver <elver@google.com>, linux-rt-users@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Clark Williams <williams@redhat.com>,
	Alessandro Carminati <acarmina@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Artem Savkov <asavkov@redhat.com>
Subject: Re: 'perf test sigtrap' failing on PREEMPT_RT_FULL
Message-ID: <ZdZOYnIkjqkyfo5P@x1>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZZcyzV8logh6BY0I@kernel.org>
X-Url: http://acmel.wordpress.com

In Thu, 4 Jan 2024 19:35:57 -0300, Arnaldo Carvalho de Melo wrote:
> Em Fri, Jul 28, 2023 at 05:07:18PM +0200, Sebastian Andrzej Siewior escreveu:
> > On 2023-07-26 08:10:45 [+0200], Mike Galbraith wrote:
> > > > [   52.848925] BUG: scheduling while atomic: perf/6549/0x00000002

> > > Had bf9ad37dc8a not been reverted due to insufficient beauty, you could
> > > trivially make the sigtrap test a happy camper (wart tested in tip-rt).
 
> > Thank you for the pointer Mike.
 
> > I guess we need this preempt_disable_notrace() in perf_pending_task()
> > due to context accounting in get_recursion_context(). Would a
> > migrate_disable() be sufficient or could we send the signal outside of
> > the preempt-disabled block?

> I got back to this, need to go again over all the callers of
> perf_swevent_get_recursion_context(), from the first quick glance there
> are other places with preempt_disable()/enable(), but doing just the
> switch to migrate disable/enable on perf_pending_task() makes this
> specific test to work:

> [acme@nine linux]$ git log --oneline -5
> 086dab66d504 (HEAD -> linux-rt-devel/linux-6.7.y-rt/send_sig_perf.fix, tag: v6.7-rc5-rt5, linux-rt-devel/linux-6.7.y-rt) v6.7-rc5-rt5
> 29e0d951f39b printk: Update the printk series.
> 2308ecc8ce88 (tag: v6.7-rc5-rt4) v6.7-rc5-rt4
> 10d5f3551216 Merge tag 'v6.7-rc5' into linux-6.7.y-rt
> a39b6ac3781d (tag: v6.7-rc5, linux-rt-devel/master, linux-rt-devel/linux-6.7.y) Linux 6.7-rc5
> [acme@nine linux]$ git diff
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index c9d123e13b57..a9b9ef60f6b3 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -6801,7 +6801,7 @@ static void perf_pending_task(struct callback_head *head)
>         * If we 'fail' here, that's OK, it means recursion is already disabled
>         * and we won't recurse 'further'.
>         */
>-       preempt_disable_notrace();
>+       migrate_disable();
>        rctx = perf_swevent_get_recursion_context();

Pardon my ignorance, is it safe to call preempt_count() with preemption
enabled on PREEMPT_RT, or at least in the context being discussed here?

Because:

	 perf_swevent_get_recursion_context()
	     get_recursion_context()
                 interrupt_context_level()
                     preempt_count()	

And:

int perf_swevent_get_recursion_context(void)
{
        struct swevent_htable *swhash = this_cpu_ptr(&swevent_htable);

        return get_recursion_context(swhash->recursion);
}

>         if (event->pending_work) {
> @@ -6812,7 +6812,7 @@ static void perf_pending_task(struct callback_head *head)
 
>        if (rctx >= 0)
>                 perf_swevent_put_recursion_context(rctx);
> -       preempt_enable_notrace();
> +       migrate_enable();
 
>         put_event(event);
>  }
> [acme@nine linux]$ uname -a
> Linux nine 6.7.0-rc5-rt5.sigtrap-fix-dirty #2 SMP PREEMPT_RT Thu Jan  4 18:11:44 -03 2024 x86_64 x86_64 x86_64 GNU/Linux
> [acme@nine linux]$ sudo su -
> [sudo] password for acme: 
> [root@nine ~]# 
> [root@nine ~]# perf test sigtrap
>  68: Sigtrap                                                         : Ok
> [root@nine ~]# 
> [root@nine ~]# perf probe -L perf_pending_task
> <perf_pending_task@/home/acme/git/linux/kernel/events/core.c:0>
>       0  static void perf_pending_task(struct callback_head *head)
>          {
>       2         struct perf_event *event = container_of(head, struct perf_event, pending_task);
>       3         int rctx;
       
>                 /*
>                  * If we 'fail' here, that's OK, it means recursion is already disabled
>                  * and we won't recurse 'further'.
>                  */
>                 migrate_disable();
>      10         rctx = perf_swevent_get_recursion_context();
>         
>      12         if (event->pending_work) {
>      13                 event->pending_work = 0;
>      14                 perf_sigtrap(event);
>      15                 local_dec(&event->ctx->nr_pending);
>                 }
>         
>      18         if (rctx >= 0)
>      19                 perf_swevent_put_recursion_context(rctx);
>      20         migrate_enable();
     
>      22         put_event(event);
>          }
         
>          #ifdef CONFIG_GUEST_PERF_EVENTS

> [root@nine ~]# perf probe perf_pending_task
> Added new event:
>   probe:perf_pending_task (on perf_pending_task)

> You can now use it in all perf tools, such as:

> 	perf record -e probe:perf_pending_task -aR sleep 1

> [root@nine ~]# perf trace --max-events=1 -e probe:perf_pending_task/max-stack=6/ perf test sigtrap 
>  68: Sigtrap                                                         : Ok
>      0.000 :9608/9608 probe:perf_pending_task(__probe_ip: -2064408784)
>                                        perf_pending_task ([kernel.kallsyms])
>                                        task_work_run ([kernel.kallsyms])
>                                        exit_to_user_mode_loop ([kernel.kallsyms])
>                                        exit_to_user_mode_prepare ([kernel.kallsyms])
>                                        irqentry_exit_to_user_mode ([kernel.kallsyms])
>                                        asm_sysvec_irq_work ([kernel.kallsyms])
> [root@nine ~]#

> [root@nine ~]# head -5 /etc/os-release
> NAME="Red Hat Enterprise Linux"
> VERSION="9.2 (Plow)"
> ID="rhel"
> ID_LIKE="fedora"
> VERSION_ID="9.2"
> [root@nine ~]#

> I did the test without the above patch and the original problem is
> reproduced.
 
> > This is also used in perf_pending_irq() and on PREEMPT_RT this is
> > invoked from softirq context which is preemptible.

Humm, and then when going thru perf_pending_irq() we don't hit that
scheduling on atomic.

- Arnaldo

