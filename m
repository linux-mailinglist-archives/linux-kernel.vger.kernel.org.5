Return-Path: <linux-kernel+bounces-82955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC801868C39
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 10:28:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D709B27D0D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 09:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93627136667;
	Tue, 27 Feb 2024 09:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LBXzZyzp";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="C8mTHtGb"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77F5C130AC5;
	Tue, 27 Feb 2024 09:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709026018; cv=none; b=aH+1yoc6RaT4IPj52kY6yqjclCKlOCs4I+ClcjiFJOpZMjg3edvmQJ1b/NNri7qyNlKMBMaRtUTpPI18y2jE8JGz6lZLXHjX3sFAcem7bll6D8bTM5tyPG0JyAoSWgEwnTsBF349JYZ9iKHjxpi9cFaygUHkguXq1KlzFfoq+sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709026018; c=relaxed/simple;
	bh=gaG8nTZcfk4aZxgk+gD5iHy4ee/P+gUiTF0WM4mC0zo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uUjgH0+AI4Km3b4aJNLOHYtihyQnZqfV7LBuvO1RcDgZndEVncTm2QgcWEKNTU7S23mOIr9tW9IdwwSiZHBMDnRE+2Ki/jRmF0eQ/YWdHYtGJ9fi+tHAif4tHKfak6guqA48EAZShNf2+x4zzEtUKkNfl1YYvVdAWJPZctysftA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LBXzZyzp; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=C8mTHtGb; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1709026015;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=B2DNoua1xXX/U7MFUA3YAYMVHqRpCwfO/mAGYY3xBzc=;
	b=LBXzZyzpTdtFHY2VpBGJuBijVqvUA1/5HqeGa9x0azN7ESTVKdASwMyQMCNvsEfplBSqWD
	lYadRJTx9WvXlMP6RQQ2fiBOwpZxOBQeiQACRizedDCtqrnApMlbjXaXebOu0gQz+e1IBF
	/+kjcWbjdLBsblLwcFZV1fQD0vr4mYtyMpHsUDjWd1/2Po+GhloYKuerl6A0A0suFrUp3f
	G7e2YaJ5PkaxdwQFfGLfGgCatP0tKtBkU+Dw6bbClyOrxJ8gyIrv4+2VTwSm+bp3Dz9yZf
	ij+ctMoFxVbQNnrg8AjT5/sU76h9JQ+VdeCVSWAoME/7f484RDK2pWxhj+Q5fQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1709026015;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=B2DNoua1xXX/U7MFUA3YAYMVHqRpCwfO/mAGYY3xBzc=;
	b=C8mTHtGbmzr9wsRK3X5g+Sxjc/EK71HQgCXHKl29hrvYxg92eeCD5tIpuo8n/BoE+A+z9x
	zYhhKfoOOpl5hPAA==
To: Bitao Hu <yaoma@linux.alibaba.com>, dianders@chromium.org,
 liusong@linux.alibaba.com, akpm@linux-foundation.org, pmladek@suse.com,
 kernelfans@gmail.com, deller@gmx.de, npiggin@gmail.com,
 tsbogend@alpha.franken.de, James.Bottomley@HansenPartnership.com,
 jan.kiszka@siemens.com
Cc: linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
 linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 yaoma@linux.alibaba.com
Subject: Re: [PATCHv10 3/4] genirq: Avoid summation loops for /proc/interrupts
In-Reply-To: <20240226020939.45264-4-yaoma@linux.alibaba.com>
References: <20240226020939.45264-1-yaoma@linux.alibaba.com>
 <20240226020939.45264-4-yaoma@linux.alibaba.com>
Date: Tue, 27 Feb 2024 10:26:55 +0100
Message-ID: <87le769s0w.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Feb 26 2024 at 10:09, Bitao Hu wrote:
> We could use the irq_desc::tot_count member to avoid the summation
> loop for interrupts which are not marked as 'PER_CPU' interrupts in
> 'show_interrupts'. This could reduce the time overhead of reading
> /proc/interrupts.

"Could" is not really a technical term. Either we do or we do not. Also
please provide context for your change and avoid the 'We'.

> --- a/include/linux/irqdesc.h
> +++ b/include/linux/irqdesc.h
> @@ -121,6 +121,8 @@ static inline void irq_unlock_sparse(void) { }
>  extern struct irq_desc irq_desc[NR_IRQS];
>  #endif
>
> +extern bool irq_is_nmi(struct irq_desc *desc);
> +

If at all this wants to be in kernel/irq/internal.h. There is zero
reason to expose this globally.

> -static bool irq_is_nmi(struct irq_desc *desc)
> +bool irq_is_nmi(struct irq_desc *desc)
>  {
>  	return desc->istate & IRQS_NMI;
>  }

If at all this really wants to be a static inline in internals.h, but
instead of blindly copying code this can be done smarter:

unsigned int kstat_irq_desc(struct irq_desc *desc)
{
	unsigned int sum = 0;
	int cpu;

	if (!irq_settings_is_per_cpu_devid(desc) &&
	    !irq_settings_is_per_cpu(desc) &&
	    !irq_is_nmi(desc))
		return data_race(desc->tot_count);

	for_each_possible_cpu(cpu)
		sum += data_race(*per_cpu_ptr(desc->kstat_irqs, cpu));
	return sum;
}

and then let kstat_irqs() and show_interrupts() use it. See?

With that a proper changelog would be:

   show_interrupts() unconditionally accumulates the per CPU interrupt
   statistics to determine whether an interrupt was ever raised.

   This can be avoided for all interrupts which are not strictly per CPU
   and not of type NMI because those interrupts provide already an
   accumulated counter. The required logic is already implemented in
   kstat_irqs().

   Split the inner access logic out of kstat_irqs() and use it for
   kstat_irqs() and show_interrupts() to avoid the accumulation loop
   when possible.

Thanks,

        tglx

