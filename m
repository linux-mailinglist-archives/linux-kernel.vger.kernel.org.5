Return-Path: <linux-kernel+bounces-64186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EBB12853B56
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 20:41:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B3941F23905
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 19:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C005E6088D;
	Tue, 13 Feb 2024 19:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Le3J8HU3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yiBOEDRf"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 971685FF03
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 19:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707853295; cv=none; b=I7J/VMY0Sv7EiuvINHHIe4YciE7NvbfnHUIm/SgFtcsqcxIURxA3lkm+gizDJSR6pYEDLMsk+KX/5TUUb3GQxiWmY/QnT8/SydNkxZIkUSRykaM7nNzIUchQHGB+nx9pH0vQeSiGoBW3nKZv7fOI37BIg0Oy8IDeA5VuoRp0T6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707853295; c=relaxed/simple;
	bh=XIUKV2HP89ebTBkSQ2l8KhiXukJ6i4bGZqfxFPpfty4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eO1wwMoLK2Db23qa8mGHdiy3eH8/HczuKPLBpa3QNvpLZwgR9smkzXxm/zdgnGBJe4OQzZvmLJyAXlZ1o90qKst8mgLHWMqXNyBFf13LCeDGHzsMQVTFc/nYalaOQr9CLjgcewiNbZc0RMz2UfhO9bPR0Bpjrzi4WrpdhRJXcRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Le3J8HU3; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yiBOEDRf; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1707853291;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=j71MqH+xvg5K1VUefTPtDEr7dN3DjkMWha2MAQfzw/I=;
	b=Le3J8HU3y667A+uu1HYQhAwW6JCF4SIOdKhAjesA1vZoq6kDNa4fGnqijTOgxenX+qIxf+
	omfHJ8yffkLGqBigsqjTmf9WF44Sl76tylX+mcCROpBDpZKQ8s+X4a9lKmxYRCzCMJW21h
	ffJqEk7QFSx3NP63gmuxkme/68AfxDTKIIJzzK+0DZXHsGXXHhe8IBvll0MlEPff7RV22S
	gMIlOJmXpg/FVn33vd3fNrV6ttg9IhWERM/Zd3TgEAdnTcHZLmDQmXhiD969r1j9UMFAUU
	S+P2MNttjyXb10dvCdJuv9vtYU2AFI3ekiIIJClAUCB6pBfLmP12bU/3jdgMtw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1707853291;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=j71MqH+xvg5K1VUefTPtDEr7dN3DjkMWha2MAQfzw/I=;
	b=yiBOEDRfa9+z8CkraC0tS6kgC8SQxgH1HNzlPU7N6x4Yp3pOlEFjn5Zq2jgqwe86Z9DaWA
	LIr8DZ3TCT5I0VCg==
To: Costa Shulyupin <costa.shul@redhat.com>, linux-kernel@vger.kernel.org
Cc: Costa Shulyupin <costa.shul@redhat.com>, Waiman Long
 <longman@redhat.com>, Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH v2] hrtimer: select housekeeping CPU during migration
In-Reply-To: <20240213164650.2935909-3-costa.shul@redhat.com>
References: <20240211135213.2518068-1-costa.shul@redhat.com>
 <20240213164650.2935909-3-costa.shul@redhat.com>
Date: Tue, 13 Feb 2024 20:41:30 +0100
Message-ID: <877cj8gnit.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Feb 13 2024 at 18:46, Costa Shulyupin wrote:

Way better now. Two nitpicks though:

> During CPU-down hotplug, hrtimers may migrate to isolated CPUs,
> compromising CPU isolation. This commit addresses this issue by
> masking valid CPUs for hrtimers using housekeeping_cpumask(HK_TYPE_TIMER).

'This commit' is pointless.

 # git grep 'This patch' Documentation/process/

gives you an hint.

> Suggested-by: Waiman Long <longman@redhat.com>
> Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
> Reviewed-by: Waiman Long <longman@redhat.com>
> Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
> ---
>
> Changes in v2:
> - [v1] https://lore.kernel.org/all/20240211135213.2518068-1-costa.shul@redhat.com/
> - reworded and rebased on linux-next
> ---
>  kernel/time/hrtimer.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
> index edb0f821dcea..947bd6cf7105 100644
> --- a/kernel/time/hrtimer.c
> +++ b/kernel/time/hrtimer.c
> @@ -2224,7 +2224,7 @@ static void migrate_hrtimer_list(struct hrtimer_clock_base *old_base,
>  int hrtimers_cpu_dying(unsigned int dying_cpu)
>  {
>  	struct hrtimer_cpu_base *old_base, *new_base;
> -	int i, ncpu = cpumask_first(cpu_active_mask);
> +	int i, ncpu = cpumask_any_and(cpu_active_mask, housekeeping(HK_TYPE_TIMER));

The tip tree managed code has rules for variable declarations (and more):

  https://www.kernel.org/doc/html/latest/process/maintainer-tip.html#variable-declarations

No need to send a v3, I fix it up this time.

Thanks,

        tglx

