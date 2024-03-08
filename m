Return-Path: <linux-kernel+bounces-97200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF1208766D8
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 15:57:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 243E11F23805
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 14:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 560A0568A;
	Fri,  8 Mar 2024 14:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="N4RJhAQR"
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1697139B
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 14:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709909869; cv=none; b=LVS8/71+PIhMxYWHGKOPYELABGoGQlwNwOVlktJjbPbNlHe+zI+r1Bn5kI3JDLLU6v6FJNPa7PXftvyMwZu5yuI+htti3d5yo61HVCaJH5Iit9MuSwhlwRxlxOq/oGny9/t+NrBLl7Wr6vB/5+D+T71Xj2YBbRAhHttAiBToxy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709909869; c=relaxed/simple;
	bh=nOGmeeP+S2YSHfBnNQyo6hO5u9KbbN1gVrn38SWkjnQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AvK1dQG5EKWQYlcagv4Mvpn430tfxM3MpGexRycaLyGshy6k/m8zzjNGAFOK2n7sPXvXH9DSbB58iESAgQrVyB8Ty/A8nQIeG7yuSUkzy0wdo5FZgtJwWzDR1sM70Pf1c/eFWmY0BL+L0KzJiDYVVSFb/LTN6WzK2RCRC2oQk2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=N4RJhAQR; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-690bba32309so897456d6.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2024 06:57:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1709909865; x=1710514665; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zHs25ksJpqEeOp1pNTzGqltTuGv83hVjOZuwqlpctzQ=;
        b=N4RJhAQRNYjprM5Oc/LTMkhucHpItkaaL3kdHBw/ASALJjUMcpIP8S1YjCfTV3jj2f
         FXfe5D6VRNEgt2MyVANgmZn0WGN/7qdUNme9KAnUixDA8hKDd5An7/dz1ksJCkP5kJDi
         Y/f4akqndp09xzE8xC5GWUc33S5m+BEPeR7Sw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709909865; x=1710514665;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zHs25ksJpqEeOp1pNTzGqltTuGv83hVjOZuwqlpctzQ=;
        b=TZnUXxQSzLXjwUivFZ2hO6aa1hbUK/ITaTjTmsysI7pUsrEidXYRvLD4vNpsI4nZfC
         IP+Nt9BbzwcrvIHObfjUzdqr48uxzDHwNgbHNtjJSc2Nm0Y39298nmmtNBNhkArL/dtC
         7aY5cU0of5v6ipUY07dt3C0v5edJfZ2Y7b8Sl+6BSENfVqHwcEEaIVcDrf0w7pup+WVC
         NzyJVELPmxX1i195/10YykiD48APYJKgJokGhgfANFiU/IY1u4dOokTUaRbR8jC6T0sU
         3FqC2Fjz+NyG+qrQEY9KHs86KkcbVJqdLUaveMULDrRZ/Zz+ECqaBqJuL7xK5uY+CNbR
         83MQ==
X-Forwarded-Encrypted: i=1; AJvYcCUvEoW0AcCsKm5Z3NbjHaQCthprj4phE/74BFbV3WmCDp25YGYt5aL5xVxkVi4F/KrRGaufuShjnv4HaIInGQIceyFIPOtINSJZCOYW
X-Gm-Message-State: AOJu0Ywxtn8vs93CffAEeBcS8FjLFS0TCe5mN49WO2JmX05m0tfqHwwS
	augdBcrrbr4tdmjcZUPFNqU856lZgbYxLuDuTLNoeCklFwB2NAAWnHWrCyvlnQs=
X-Google-Smtp-Source: AGHT+IFgMYXjfmNrjnOEWaK0ByL3HTUskDb8AyXDaoxRYm0ZxLkEmiG2mFQnS6LbDZxo9RDmgpMRMQ==
X-Received: by 2002:a05:6214:a63:b0:690:7dc5:a9bc with SMTP id ef3-20020a0562140a6300b006907dc5a9bcmr12454963qvb.29.1709909865438;
        Fri, 08 Mar 2024 06:57:45 -0800 (PST)
Received: from [10.5.0.2] ([91.196.69.182])
        by smtp.gmail.com with ESMTPSA id ld8-20020a056214418800b0068fef1264f6sm9765794qvb.101.2024.03.08.06.57.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Mar 2024 06:57:44 -0800 (PST)
Message-ID: <bce79497-52c5-4241-aaf6-2a95dc459041@joelfernandes.org>
Date: Fri, 8 Mar 2024 09:57:42 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm: smp: Avoid false positive CPU hotplug Lockdep-RCU
 splat
To: Stefan Wiehler <stefan.wiehler@nokia.com>,
 Russell King <linux@armlinux.org.uk>, "Paul E. McKenney"
 <paulmck@kernel.org>, Josh Triplett <josh@joshtriplett.org>,
 Boqun Feng <boqun.feng@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>,
 linux-arm-kernel@lists.infradead.org, rcu@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240307160951.3607374-1-stefan.wiehler@nokia.com>
Content-Language: en-US
From: Joel Fernandes <joel@joelfernandes.org>
In-Reply-To: <20240307160951.3607374-1-stefan.wiehler@nokia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/7/2024 11:09 AM, Stefan Wiehler wrote:
> With CONFIG_PROVE_RCU_LIST=y and by executing
> 
>   $ echo 0 > /sys/devices/system/cpu/cpu1/online
> 
> one can trigger the following Lockdep-RCU splat on ARM:
> 
>   =============================
>   WARNING: suspicious RCU usage
>   6.8.0-rc7-00001-g0db1d0ed8958 #10 Not tainted
>   -----------------------------
>   kernel/locking/lockdep.c:3762 RCU-list traversed in non-reader section!!
> 
>   other info that might help us debug this:
> 
>   RCU used illegally from offline CPU!
>   rcu_scheduler_active = 2, debug_locks = 1
>   no locks held by swapper/1/0.
> 
>   stack backtrace:
>   CPU: 1 PID: 0 Comm: swapper/1 Not tainted 6.8.0-rc7-00001-g0db1d0ed8958 #10
>   Hardware name: Allwinner sun8i Family
>    unwind_backtrace from show_stack+0x10/0x14
>    show_stack from dump_stack_lvl+0x60/0x90
>    dump_stack_lvl from lockdep_rcu_suspicious+0x150/0x1a0
>    lockdep_rcu_suspicious from __lock_acquire+0x11fc/0x29f8
>    __lock_acquire from lock_acquire+0x10c/0x348
>    lock_acquire from _raw_spin_lock_irqsave+0x50/0x6c
>    _raw_spin_lock_irqsave from check_and_switch_context+0x7c/0x4a8
>    check_and_switch_context from arch_cpu_idle_dead+0x10/0x7c
>    arch_cpu_idle_dead from do_idle+0xbc/0x138
>    do_idle from cpu_startup_entry+0x28/0x2c
>    cpu_startup_entry from secondary_start_kernel+0x11c/0x124
>    secondary_start_kernel from 0x401018a0
> 
> The CPU is already reported as offline from RCU perspective in
> cpuhp_report_idle_dead() before arch_cpu_idle_dead() is invoked. Above
> RCU-Lockdep splat is then triggered by check_and_switch_context() acquiring the
> ASID spinlock.
> 
> Avoid the false-positive Lockdep-RCU splat by briefly reporting the CPU as
> online again while the spinlock is held.
> 
> Signed-off-by: Stefan Wiehler <stefan.wiehler@nokia.com>
> ---
>  arch/arm/kernel/smp.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
> index 3431c0553f45..6875e2c5dd50 100644
> --- a/arch/arm/kernel/smp.c
> +++ b/arch/arm/kernel/smp.c
> @@ -319,7 +319,14 @@ void __noreturn arch_cpu_idle_dead(void)
>  {
>  	unsigned int cpu = smp_processor_id();
>  
> +	/*
> +	 * Briefly report CPU as online again to avoid false positive
> +	 * Lockdep-RCU splat when check_and_switch_context() acquires ASID
> +	 * spinlock.
> +	 */
> +	rcutree_report_cpu_starting(cpu);
>  	idle_task_exit();
> +	rcutree_report_cpu_dead();

I agree with the problem but disagree with the patch because it feels like a
terrible workaround.

Can we just use arch_spin_lock() for the cpu_asid_lock? This might require
acquiring the raw_lock within the raw_spinlock_t, but there is precedent:

arch/powerpc/kvm/book3s_hv_rm_mmu.c:245:
arch_spin_lock(&kvm->mmu_lock.rlock.raw_lock);

IMO, lockdep tracking of this lock is not necessary or possible considering the
hotplug situation.

Or is there a reason you need lockdep working for the cpu_asid_lock?

thanks,

 - Joel

