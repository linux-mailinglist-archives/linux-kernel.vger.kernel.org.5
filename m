Return-Path: <linux-kernel+bounces-77871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 447DB860B57
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 08:29:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A305C1F234B8
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 07:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AAB21429C;
	Fri, 23 Feb 2024 07:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="birTqkb6";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="9ktyOyU9"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA278BA2B;
	Fri, 23 Feb 2024 07:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708673381; cv=none; b=EDEzjRTNI8zICAbXKRzoX4xzbQydqliNdT4hjE9Us1An+Fu1b9AagTh8hJdhT8YtH+BvjmUeNsbiNIHcJIbYEI5ZP2JbjPy1eMNAytb459jMAmY4wA7sISuZgj2hT/PqRbMUOO9ytHWsJZD9EN85HBG7aRzJKNPGBMWMH1kgPzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708673381; c=relaxed/simple;
	bh=dNRL46Jwutz/7GkyTSOrgCg5PYJ/yxKiHilPIwmouxI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eL4a6gj3kJnw63JSoKuIWK30kdo4F+me15E0Lzm5hnvZViVh7sJqjxR6WdS8k6mSOkdf8Y5sc88X2rqbuHv4gg6inJngCRJfmUtrW4gdkg8ONXNZSUUCm2kgeK0EHAEnR7DxDOohAUfPzlKlSej5nqLAQoKM3ni6Wc3Dncuyd2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=birTqkb6; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=9ktyOyU9; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708673377;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HaA9fQcqVYSuNg3wkRSEZWU32RdGNi0Gngw0SdVL3to=;
	b=birTqkb6S3mj0vdYA18Ur/BPk8EwAlE45/GWI5qRKle3zsNaENUwBMIPxhy/wf1e2BmKaL
	Al1pDVkOEK0bGEhW+VQFvi4D/Yp5kIRtjOBiHOC7qed8hpNgbjLEClDkbg4jADpSLFshaP
	w2/IwyY+MRrPD/Vf2HCnqkOjLgrwr54+QJ4Gj8OpsnsTvoCxP/cYJP1NVCscr0xJaPTbMu
	6/QahWITN6d/C1GJ79JcTJAglZQSqpYxaDdXFMcUlZuMmTqutTUYy/47iOxfjWzJ4slKIi
	p6jeNKGJuyB6RzhCeSxqe2xUi4HESXponoDtpONSWF1bwOJEG7Eu7vxP3MombQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708673377;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HaA9fQcqVYSuNg3wkRSEZWU32RdGNi0Gngw0SdVL3to=;
	b=9ktyOyU9vD7z+zHFv9WQ2D0q27MFF7CdOuldZ0azOdzfOrY5tHMJiYiRNDJd+k5uPPn9m6
	pXpzIcrgwGPoA5CA==
To: Bitao Hu <yaoma@linux.alibaba.com>, dianders@chromium.org,
 akpm@linux-foundation.org, liusong@linux.alibaba.com, pmladek@suse.com,
 kernelfans@gmail.com, deller@gmx.de, npiggin@gmail.com,
 tsbogend@alpha.franken.de, James.Bottomley@HansenPartnership.com,
 jan.kiszka@siemens.com
Cc: linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
 linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 yaoma@linux.alibaba.com
Subject: Re: [PATCHv9 2/3] irq: use a struct for the kstat_irqs in the
 interrupt descriptor
In-Reply-To: <3f4b7dbe-93c1-4cb0-8233-18e8432409f8@linux.alibaba.com>
References: <20240222093420.13956-1-yaoma@linux.alibaba.com>
 <20240222093420.13956-3-yaoma@linux.alibaba.com> <87jzmwfxak.ffs@tglx>
 <3f4b7dbe-93c1-4cb0-8233-18e8432409f8@linux.alibaba.com>
Date: Fri, 23 Feb 2024 08:29:36 +0100
Message-ID: <87frxjeizj.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Feb 23 2024 at 15:18, Bitao Hu wrote:
> On 2024/2/22 21:22, Thomas Gleixner wrote:
>>> -	if (desc->kstat_irqs) {
>>> -		for_each_online_cpu(j)
>>> -			any_count |= data_race(*per_cpu_ptr(desc->kstat_irqs, j));
>>> -	}
>>> +	if (desc->kstat_irqs)
>>> +		any_count = data_race(desc->tot_count);
>> 
>> This is an unrelated change and needs to be split out into a separate
>> patch with a proper changelog which explains why this is equivalent.
>> 
>
> Alright, I will remove this change witch is not related to the purpose
> of this patch.
>
> I guess that the purpose of suggesting this change in your V1 response
> was to speedup the 'show_interrupts'. However, after reviewing the
> usage of 'desc->tot_count' in 'unsigned int kstat_irqs(unsigned int 
> irq)', I think the change might be as follows:
>
> diff --git a/kernel/irq/proc.c b/kernel/irq/proc.c
> index 623b8136e9af..53b8d6edd7ac 100644
> --- a/kernel/irq/proc.c
> +++ b/kernel/irq/proc.c
> @@ -489,8 +489,13 @@ int show_interrupts(struct seq_file *p, void *v)
>                  goto outsparse;
>
>          if (desc->kstat_irqs) {
> -               for_each_online_cpu(j)
> -                       any_count |= 
> data_race(per_cpu(desc->kstat_irqs->cnt, j));
> +               if (!irq_settings_is_per_cpu_devid(desc) &&
> +                   !irq_settings_is_per_cpu(desc) &&
> +                   !irq_is_nmi(desc))
> +                       any_count = data_race(desc->tot_count);
> +               else
> +                       for_each_online_cpu(j)
> +                               any_count |= 
> data_race(per_cpu(desc->kstat_irqs->cnt, j));
>          }
>
>          if ((!desc->action || irq_desc_is_chained(desc)) && !any_count)
>
> Is my idea correct?

Yes.

