Return-Path: <linux-kernel+bounces-151013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D18AC8AA7F3
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 07:33:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3640B2851D5
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 05:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70C1EBA2B;
	Fri, 19 Apr 2024 05:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="I/vOOf//";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jeE955Xm"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 612CC748E
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 05:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713504773; cv=none; b=XgCjrYw1YYFnl+n+vpdQKmAoKcGaiFyY4U+ebsYNDBigFVUG9IcO5t6xO7pRmTs8aziDWwuxj+0c8RoLL0idSZd9HPYc0HQ+XLqLoL8JaiyI0cn6DEz9SivPOgcoszQXsPVEWzSuMO5Q+s2q9ZtClcIlmtrP7sT1TPtbpDcFZhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713504773; c=relaxed/simple;
	bh=tuDYbVXL8Fha/njy5SFGrSPhj94DhUTTeOjcn1j8YEI=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:MIME-Version:
	 Content-Type; b=TaDn3lC+Pyv5htlWBszFIy8+2s2UuUMkDBDdQG5o4pivFVojFHG+KztxjdMx3chZfwDyKX5Turs1BHaGbpUjk5W1D0J+jw0I3/VPkj0oJbpGwbqQB0Wk9tUWLFRIIkfBrJ3beDl5jtcbij8X7l/o9/ww/IWgCkCMaVu/9wP1EdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=I/vOOf//; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jeE955Xm; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1713504770;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=Nb8+/9xalraZGLP1jk5h6zvK+UIIvcAHinrH+94E1xA=;
	b=I/vOOf///FF7BJ5TQcjgQ0rC/mQnk+tNg8vUPcF1ga9dg+pMCdLb1KKbKTQ+yqPLP97Gum
	Xo6AZsZNM55cL4+8r13/c1Jt/YyR+l3zECQvE4HFA4a2QFDbQQkJVrBTSRfkzKLHaLELt/
	XFW7PEYR01Slpd/bfyl8zrz2g3K2JZCmgxrhfmhDpQWK69/FWrAJ2/ZdlOBTrMri+pMFNM
	qIYMPEE8yQ4iStw5idzpDHTuG1mvzWBhjvX/ECLBP2h12KrTFBUXyf7Wbe703L2YC1/LP/
	3tgsgHT8URt3Sramh2gf9OqCkboZoIScKx3VOJm5gDDser5mk1ezIvjVttWSIQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1713504770;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=Nb8+/9xalraZGLP1jk5h6zvK+UIIvcAHinrH+94E1xA=;
	b=jeE955XmubM1zgYFBeZuLUAVsiKAwLfD6nD+A/OmERb5W4cPua3eom1tMAIZa8jAcCo1mm
	3JJGGRBobn+NgFCQ==
To: Alexey Dobriyan <adobriyan@gmail.com>, peterz@infradead.org
Cc: adobriyan@gmail.com, yury.norov@gmail.com, linux@rasmusvillemoes.dk,
 akpm@linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpu: memoise number of possible cpus
In-Reply-To: <20240418041927.3903-1-adobriyan@gmail.com>
Date: Fri, 19 Apr 2024 07:32:43 +0200
Message-ID: <8734rhyl1g.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Apr 18 2024 at 07:19, Alexey Dobriyan wrote:

memoise?

> cpu_possible_mask is fixed after boot, so it makes sense
> to calculate number of possible cpus to

The kernel calculates the number of possible CPUs already today, no?

> a) make num_possible_cpus() faster (distros ship with _large_ NR_CPUS),
> b) unscrew codegen elsewhere replacing function call
>    with simple memory load.

Can we please have complete sentences which use precise technical
wording to describe the changes?

> diff --git a/init/main.c b/init/main.c
> index 881f6230ee59..fe0291b44d78 100644
> --- a/init/main.c
> +++ b/init/main.c
> @@ -904,6 +904,9 @@ void start_kernel(void)
>  	setup_boot_config();
>  	setup_command_line(command_line);
>  	setup_nr_cpu_ids();
> +#if NR_CPUS > 1
> +	num_possible_cpus = cpumask_weight(cpu_possible_mask);
> +#endif

setup_nr_cpu_ids() does exactly the same thing despite using a different
algorithm. So why not do the obvious and have:

#define num_possible_cpus()	nr_cpu_ids

and make nr_cpu_ids __ro_after_init?

Which made me look at CONFIG_FORCE_NR_CPUS. That's simply broken
because:

static inline void set_nr_cpu_ids(unsigned int nr)
{
#if (NR_CPUS == 1) || defined(CONFIG_FORCE_NR_CPUS)
       WARN_ON(nr != nr_cpu_ids);
#else
        nr_cpu_ids = nr;
#endif
}

So if num_possible_cpus() != nr_cpu_ids then everything after that
becomes lottery. If that hard-coded NR_CPUS is actually worth it then
this WARN_ON() is just wrong. The only sensible solution to that is to
make it a BUG_ON().

Thanks,

        tglx


