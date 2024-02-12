Return-Path: <linux-kernel+bounces-61882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 367848517CD
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 16:19:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 684F01C2171F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 15:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE1303C486;
	Mon, 12 Feb 2024 15:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="V6p6bOXR";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1Ep3TZrj"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E02936B08
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 15:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707751163; cv=none; b=qerOXb8uzqeTASa8+s/PpUj/BBFndULEwsrOQA7AqnwD44tPx55Bg+ehUbxlzeKGhU+o6qsde5dHtS2KQgl5P4qm4jakVIoV4iYOAwer52L3kCvMt9UItV0Z3mynd9HHX7sQ95GqUrvgq+hBFIzUQu9ms7Jg3VGfQ7UhPnhavkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707751163; c=relaxed/simple;
	bh=+6mEziMxrgwQlUT5m/369TQaV/jXSqr2KuRfkgVOLr4=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:MIME-Version:
	 Content-Type; b=b7SuSFAkPprNosf9gfHwEM9wpg1bvnG2KNtOppNbt/NoxBOg2hA4AxMt1crmSkOaYXatGsF0R7ukCoc+niWbLqdJigtQ2JOguOLdhcnR8ZP4kor/oC8ik1El0DOAlRFSSPlGpcdfP3VsSJknpYqOJJDfAPNdC+MGYHEdDHe2cqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=V6p6bOXR; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1Ep3TZrj; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1707751159;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=UyXyo1etyHMz/yg/tu7sBloltjY/h+rwAvfUJRR+na8=;
	b=V6p6bOXRiHiANMPQzZhVdmc/USqLcsQ9MGJk7DFfTQFodbmU8z+sgWFwHfsuBEvWitwNeX
	3hzQN9GT9qKUznVXT73BFbbtIPTWLbSoYyatPheti/cOeJgLBLUQskdgMgOjOzogDSUxux
	0yqomKqwH9VP++cdBQd609Uo9nsNPSSs6EkJTOucdeC7xHhzbxEHjEgRTH6HiGLlXj32C5
	4hMXDO8vxggNMJ2PQJgV+85QlZYJU7DotLALYp6hiF3+H8nu+oYnS3OcET4ARKd2yE15+s
	NJxo01b/9dW+OFs+O5sjpSzSZzjnrXTk9msGpsQae0AsBJDEVky3Ibd6He/mhg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1707751159;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=UyXyo1etyHMz/yg/tu7sBloltjY/h+rwAvfUJRR+na8=;
	b=1Ep3TZrj7qzddX3YeYp1AVBoK6lOW0kT0Sn8NNOWpaVg4S8pVTJWKMSrljl4Fg9eG3eg6+
	CG2BKl+sBDLWhxBg==
To: Marcelo Tosatti <mtosatti@redhat.com>, linux-kernel@vger.kernel.org
Cc: Daniel Bristot de Oliveira <bristot@kernel.org>, Juri Lelli
 <juri.lelli@redhat.com>, Valentin Schneider <vschneid@redhat.com>,
 Frederic Weisbecker <frederic@kernel.org>, Leonardo Bras
 <leobras@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Marcelo
 Tosatti <mtosatti@redhat.com>
Subject: Re: [patch 11/12] x86/resctrl: use smp_call_function_single_fail
In-Reply-To: <20240206185710.116221062@redhat.com>
Date: Mon, 12 Feb 2024 16:19:19 +0100
Message-ID: <87zfw5k8w8.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Feb 06 2024 at 15:49, Marcelo Tosatti wrote:
> Convert update_task_closid_rmid from smp_call_function_single
> to smp_call_func_single_fail, which will fail in case
> the target CPU is tagged as block interference CPU.

You fail again to provide a rationale for this change.

What's worse is that you fail to explain why you think that creating
inconistent state is a valid approach.

> Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>
>
> Index: linux-isolation/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> ===================================================================
> --- linux-isolation.orig/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ linux-isolation/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -26,6 +26,7 @@
>  #include <linux/slab.h>
>  #include <linux/task_work.h>
>  #include <linux/user_namespace.h>
> +#include <linux/sched/isolation.h>
>  
>  #include <uapi/linux/magic.h>
>  
> @@ -551,12 +552,20 @@ static void _update_task_closid_rmid(voi
>  		resctrl_sched_in(task);
>  }
>  
> -static void update_task_closid_rmid(struct task_struct *t)
> +static int update_task_closid_rmid(struct task_struct *t)
>  {
> -	if (IS_ENABLED(CONFIG_SMP) && task_curr(t))
> -		smp_call_function_single(task_cpu(t), _update_task_closid_rmid, t, 1);
> -	else
> +	int idx, ret = 0;
> +
> +	if (IS_ENABLED(CONFIG_SMP) && task_curr(t)) {
> +		idx = block_interf_srcu_read_lock();
> +		ret = smp_call_function_single_fail(task_cpu(t),
> +						    _update_task_closid_rmid,
> +						    t, 1);
> +		block_interf_srcu_read_unlock(idx);
> +	} else
>  		_update_task_closid_rmid(t);
> +
> +	return ret;

This is invoked _after_ the change has been committed to the in-memory
state so how is failing here correct?

Thanks,

        tglx

