Return-Path: <linux-kernel+bounces-151982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 157828AB6AC
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 23:54:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 821E91F22657
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 21:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D53D413D277;
	Fri, 19 Apr 2024 21:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bndlSMvK"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75D7885284
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 21:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713563643; cv=none; b=ZQenxGbvQQ5mMCjBPtKb8JyF8ONyr33nrMDN/GWVQQOZdrP9LfAVB202UhrP7Nrbq+LS9GEefGIfQuxHmMXkTN2j+WX0MsFUmMfM0Fqiiwg4bfEuU4ehqz8Er5e+khOHxcJl2nQPMpAX0dQptPUOvM0+Bf6UBfFyB05n+L+ISck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713563643; c=relaxed/simple;
	bh=HeP80xHA/Kg3pRML1IayolhDbI2pQSmUOOsVpAoSnmI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sBhvs3eUzPZTlnCUuMSVxn3fnFUOtvgjrIoatMIA+Dr1Wud/AXOITOk9FODmFve6cjZ5jHgVZsMEeVyxlCd4RX1cNpcg/nMlRARah/EXv1umi185KlaCceaIdS+2z2DTQyVZYgxzSsqwub5LuoKOLLxu/ByUG6Z8H1dFHUnU4bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=bndlSMvK; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2a5ef566c7aso2003525a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 14:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1713563641; x=1714168441; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GaDNmlON9DsHxNjLMz+q5f55tRz7mgbEsd3+JZFzYlE=;
        b=bndlSMvKb0M63m0/jrTz+4YqOh8eMwyH70IJxQ1KGWsn3PdKd5iubKU7aIfnq681Kd
         ISPNJes0RcUsuFl7DTgeMmfbbrwcrsMQe5d3Ug5vADCDULfvu8fuKZcQK7MpcxhI0B8T
         tZmjbBPmdrWlcDaQU0ddnYpzdisrDlw21VVHQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713563641; x=1714168441;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GaDNmlON9DsHxNjLMz+q5f55tRz7mgbEsd3+JZFzYlE=;
        b=WT5bny9c80pzBpVvXlKvg52cgPkcSzHvK79HBsnwGdvI5cT8jpe1jiWF+IM82x7x9F
         LhQ7oyRtfUg92jitsK6YrlJaWZ3D3JGCAAlWMbGlThmgJCSsJsTELC+jp3un6alHbtQy
         wNc7eNQOHa++ow81S1VMIrTP/w2SAsS+rW3nFv6B2o8WdsSXhMxBzh9N4o/kFMnOeqwo
         4E7vCuc+klh/REPIp9roU5zXYooCcvrod59HYxetS5+nG9+ackKFI5ox6ouWX1Jh2VXy
         c1aMKa0cW//HmeW7v1rKDG+es03jmsX4OhH5MWjZ6n/O5wDY+hzjwWn5YIdPpdphboG8
         Ez2A==
X-Gm-Message-State: AOJu0YzjZWbrFY8WZ9BkMpMo4KUiWsmCVXiNsRKUW6CuVNXe6jGARLPV
	WFhkHR4DU9klsuyxQuV1LWiWbM9+VQIdM5Pf7/c7QuMjAJjhz5xSSwgpH9p8LQ0lsCVqilEBOKw
	=
X-Google-Smtp-Source: AGHT+IHlFT9MjoIwYtJNE1Iq73yGZdw93jMGztDf+9r74BjNf+RfuXMvdefLiyaWH9+ofn6keFJ9tQ==
X-Received: by 2002:a17:90a:8584:b0:2a2:4192:dfc1 with SMTP id m4-20020a17090a858400b002a24192dfc1mr3464519pjn.14.1713563640789;
        Fri, 19 Apr 2024 14:54:00 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id x6-20020a17090a6b4600b002a0544b81d6sm3593335pjl.35.2024.04.19.14.54.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 14:54:00 -0700 (PDT)
Date: Fri, 19 Apr 2024 14:53:59 -0700
From: Kees Cook <keescook@chromium.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: linux-kernel@vger.kernel.org, paulmck@kernel.org
Subject: Re: [PATCH] lkdtm/bugs: add test for hung smp_call_function_single()
Message-ID: <202404191434.5B051B5DC6@keescook>
References: <20240419103452.3530155-1-mark.rutland@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240419103452.3530155-1-mark.rutland@arm.com>

On Fri, Apr 19, 2024 at 11:34:52AM +0100, Mark Rutland wrote:
> The CONFIG_CSD_LOCK_WAIT_DEBUG option enables debugging of hung
> smp_call_function*() calls (e.g. when the target CPU gets stuck within
> the callback function). Testing this option requires triggering such
> hangs.
> 
> This patch adds an lkdtm test with a hung smp_call_function_single()
> callbac, which can be used to test CONFIG_CSD_LOCK_WAIT_DEBUG and NMI
> backtraces (as CONFIG_CSD_LOCK_WAIT_DEBUG will attempt an NMI backtrace
> of the hung target CPU).
> 
> On arm64 using pseudo-NMI, this looks like:
> 
> | # mount -t debugfs none /sys/kernel/debug/
> | # echo CSDLOCKUP > /sys/kernel/debug/provoke-crash/DIRECT
> | lkdtm: Performing direct entry CSDLOCKUP
> | smp: csd: Detected non-responsive CSD lock (#1) on CPU#0, waiting 5000001136 ns for CPU#01 __lkdtm_CSDLOCKUP+0x0/0x8(0x0).
> | smp:     csd: CSD lock (#1) handling this request.
> | Sending NMI from CPU 0 to CPUs 1:
> | NMI backtrace for cpu 1
> | CPU: 1 PID: 0 Comm: swapper/1 Not tainted 6.9.0-rc4-00001-gda84b9dede43 #7
> | Hardware name: linux,dummy-virt (DT)
> | pstate: 60401005 (nZCv daif +PAN -UAO -TCO -DIT +SSBS BTYPE=--)
> | pc : __lkdtm_CSDLOCKUP+0x0/0x8
> | lr : __flush_smp_call_function_queue+0x1b0/0x290
> | sp : ffff80008000bf30
> | pmr_save: 00000060
> | x29: ffff80008000bf30 x28: fff00000c02dc500 x27: 0000000000000000
> | x26: 0000000000000000 x25: fff00000c02dc500 x24: ffffa41b939aa140
> | x23: ffffa41b939aa140 x22: 0000000000000000 x21: ffff80008066bc40
> | x20: 0000000000000000 x19: 0000000000000000 x18: fff05be56bd37000
> | x17: fff05be56bd07000 x16: ffff800080008000 x15: 00005b132023e6fd
> | x14: 00005aeabb53d8c3 x13: 000000000000032e x12: 0000000000000001
> | x11: 0000000000000040 x10: fff00000c003d0a8 x9 : fff00000c003d0a0
> | x8 : fff00000c0400270 x7 : 0000000000000000 x6 : ffffa41b9251b810
> | x5 : 0000000000000000 x4 : fff05be56bd07000 x3 : ffff80008000bf30
> | x2 : fff05be56bd07000 x1 : ffffa41b939aa140 x0 : 0000000000000000
> | Call trace:
> |  __lkdtm_CSDLOCKUP+0x0/0x8
> |  generic_smp_call_function_single_interrupt+0x14/0x20
> |  ipi_handler+0xb8/0x178
> |  handle_percpu_devid_irq+0x84/0x130
> |  generic_handle_domain_irq+0x2c/0x44
> |  gic_handle_irq+0x118/0x240
> |  call_on_irq_stack+0x24/0x4c
> |  do_interrupt_handler+0x80/0x84
> |  el1_interrupt+0x44/0xc0
> |  el1h_64_irq_handler+0x18/0x24
> |  el1h_64_irq+0x78/0x7c
> |  default_idle_call+0x40/0x60
> |  do_idle+0x23c/0x2d0
> |  cpu_startup_entry+0x38/0x3c
> |  secondary_start_kernel+0x148/0x180
> |  __secondary_switched+0xb8/0xbc
> | CPU: 0 PID: 143 Comm: sh Not tainted 6.9.0-rc4-00001-gda84b9dede43 #7
> | Hardware name: linux,dummy-virt (DT)
> | Call trace:
> |  dump_backtrace+0x90/0xe8
> |  show_stack+0x18/0x24
> |  dump_stack_lvl+0xac/0xe8
> |  dump_stack+0x18/0x24
> |  csd_lock_wait_toolong+0x268/0x338
> |  smp_call_function_single+0x1dc/0x2f0
> |  lkdtm_CSDLOCKUP+0xcc/0xfc
> |  lkdtm_do_action+0x1c/0x38
> |  direct_entry+0xbc/0x14c
> |  full_proxy_write+0x60/0xb4
> |  vfs_write+0xd0/0x35c
> |  ksys_write+0x70/0x104
> |  __arm64_sys_write+0x1c/0x28
> |  invoke_syscall+0x48/0x114
> |  el0_svc_common.constprop.0+0x40/0xe0
> |  do_el0_svc+0x1c/0x28
> |  el0_svc+0x38/0x108
> |  el0t_64_sync_handler+0x120/0x12c
> |  el0t_64_sync+0x1a4/0x1a8
> | smp: csd: Continued non-responsive CSD lock (#1) on CPU#0, waiting 10000001888 ns for CPU#01 __lkdtm_CSDLOCKUP+0x0/0x8(0x0).
> | smp:     csd: CSD lock (#1) handling this request.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Paul E. McKenney <paulmck@kernel.org>
> ---
>  drivers/misc/lkdtm/bugs.c | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
> 
> I wrote this because I needed to guide someone through debugging a hung
> smp_call_function() call, and I needed examples with/without an NMI
> backtrace. It seems like it'd be useful for testing the CSD lockup
> detector and NMI backtrace code in future.

Like the other lockup detector, I suspect we should skip it by default
in the selftests? Something like this:

diff --git a/tools/testing/selftests/lkdtm/tests.txt b/tools/testing/selftests/lkdtm/tests.txt
index 368973f05250..32baddc2c85d 100644
--- a/tools/testing/selftests/lkdtm/tests.txt
+++ b/tools/testing/selftests/lkdtm/tests.txt
@@ -31,6 +31,7 @@ SLAB_FREE_CROSS
 SLAB_FREE_PAGE
 #SOFTLOCKUP Hangs the system
 #HARDLOCKUP Hangs the system
+#CSDLOCKUP Hangs the system
 #SPINLOCKUP Hangs the system
 #HUNG_TASK Hangs the system
 EXEC_DATA

> 
> I'm not sure about the CSDLOCKUP name, but everything else I tried
> didn't seem great either:
> 
> * IPILOCKUP sounds like it's testing IPIs generally
> * SMPCALLLOCKUP and similar look weirdly long
> * SMP_CALL_LOCKUP and similar look different to {HARD,SOFT,SPIN}LOCKUP
> 
> ... and I'm happy to defer to Kees for the naming. ;)

It looks like it's only useful with CSD lockup detector? If that's true,
sure, this name is fine.

> [...]
> diff --git a/drivers/misc/lkdtm/bugs.c b/drivers/misc/lkdtm/bugs.c
> index 5178c02b21eba..47cd1be09ac1f 100644
> --- a/drivers/misc/lkdtm/bugs.c
> +++ b/drivers/misc/lkdtm/bugs.c
> @@ -286,6 +286,35 @@ static void lkdtm_HARDLOCKUP(void)
>  		cpu_relax();
>  }
>  
> +static void __lkdtm_CSDLOCKUP(void *unused)
> +{
> +	for (;;)
> +		cpu_relax();
> +}
> +
> +static void lkdtm_CSDLOCKUP(void)
> +{
> +	unsigned int cpu, target;
> +
> +	cpus_read_lock();
> +
> +	cpu = get_cpu();
> +	target = cpumask_any_but(cpu_online_mask, cpu);
> +
> +	if (target >= nr_cpu_ids) {
> +		pr_err("FAIL: no other online CPUs\n");
> +		goto out_put_cpus;
> +	}
> +
> +	smp_call_function_single(target, __lkdtm_CSDLOCKUP, NULL, 1);
> +
> +	pr_err("FAIL: did not hang\n");
> +
> +out_put_cpus:
> +	put_cpu();
> +	cpus_read_unlock();
> +}
> +
>  static void lkdtm_SPINLOCKUP(void)
>  {
>  	/* Must be called twice to trigger. */
> @@ -680,6 +709,7 @@ static struct crashtype crashtypes[] = {
>  	CRASHTYPE(UNALIGNED_LOAD_STORE_WRITE),
>  	CRASHTYPE(SOFTLOCKUP),
>  	CRASHTYPE(HARDLOCKUP),
> +	CRASHTYPE(CSDLOCKUP),
>  	CRASHTYPE(SPINLOCKUP),
>  	CRASHTYPE(HUNG_TASK),
>  	CRASHTYPE(OVERFLOW_SIGNED),
> -- 
> 2.30.2

Seems good to me.

-- 
Kees Cook

