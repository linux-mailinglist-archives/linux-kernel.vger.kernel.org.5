Return-Path: <linux-kernel+bounces-85127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DDED86B0BA
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 14:48:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F21171F2268E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 13:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59DCC14EFEB;
	Wed, 28 Feb 2024 13:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bdu+d5PT"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C31B14AD07
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 13:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709128085; cv=none; b=u+aHxxi9qucnm0h0hhaiaqhVqGqb+xNWp/Aup7cEUWcI+DyP+ovoJE4d/v2Ni7xuIJwjh3gUP/jxkfXW81CQIuYJE6R774ss9+FHTj5IfH2grKP36NPzIoiNCEp8EkVIg5O8UhB/Epq8tKVjN28VAlspLg+t/dpJvxe10TYcug8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709128085; c=relaxed/simple;
	bh=D7zDGT/oL9Z+7zb2o0ogH171hkdvTA3w4me6yNYvg+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f6sOtZGt4rlRYWOrC/7AsSZ+HR+lovRAYDibiaq5XKMoSCA/tdQkr6ExPxOfaSaadafTdf+Igk6tItlu/0vYGOUGRJhY9FDlpjavbRuzHzqu2KlUPg0ja8/ITPgvn1ybGGz2r82ZZBUmdE2otEx4VGsQEYPzDkufyl/T4BJFhgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bdu+d5PT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709128083;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dF3BgAxPY8FDKy3zKrUrPlZUKXmTDH8+1bxpWFRIR3A=;
	b=bdu+d5PTy7t+ldUpkNjLBVlvElOxp5/I+ceQoBB6iJAYxZZXDtV+Xsl1W2Bnd0SgE0H5XF
	Px+ua5lhpbGClj5t4qosqGHurJdX+URTcZRFH+fRLTWtRCP3IM2a1SsS2rG8MPdtUd1rvi
	p5Vdqvkeo+oaINz8KcY4pODDnIqQgsg=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-688-gy7bK2C4O0um93KF85N4jw-1; Wed, 28 Feb 2024 08:48:01 -0500
X-MC-Unique: gy7bK2C4O0um93KF85N4jw-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-787bd91c5feso414071785a.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 05:48:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709128080; x=1709732880;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dF3BgAxPY8FDKy3zKrUrPlZUKXmTDH8+1bxpWFRIR3A=;
        b=SXmpzeQd8jeN44Gnsdant4iYEUxG9sgoA7LvFPXQczM/a2o4vcGhYBTR3l7u0O1slc
         y70LEjTU8EqkhLeIB3FaGdAl0MroxBWpeHYtjRl5M4/6yCNzx+fnpzTJ++vTrh2my4mE
         dOeEXCC6T6SOTkEAWTFGmX4ibmIzkuwpCWmx474d5BrDp0/PAF5ENv4YM8DTLZiC2ZKI
         V3bKN+TD/VmamDbNuvYIxXABxk64JjUjulSOY104kqajVSb1BryMcuZTE11qyG6X+SyE
         H8zphcFcLBBSRcrWkL/k19d/pH80fhDSmGHpjiB52BfmNa3AuviC7oxlELYsT7xVQCff
         HTOQ==
X-Gm-Message-State: AOJu0Ywqsc5iSeEV2cd1jmvXR2Acgn6Ub6686zHBZpkRoIfYXzLSoRo4
	rylD49RZ1is1gyvLo9zaotMG+9Mk+V2htsF/OFgv8OnahOaXToof3rtuj66AqO+ebBfuFsLY+pQ
	LbMaPyAjOiIQG4niMcFgaV8pAHw2hL/nUBIlkDkoHObAJkZcyNCNMPlISl8xM2A==
X-Received: by 2002:a37:e104:0:b0:787:b0fc:8f12 with SMTP id c4-20020a37e104000000b00787b0fc8f12mr4918784qkm.3.1709128080592;
        Wed, 28 Feb 2024 05:48:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFhtY/FJ0IeSpFd+3Ejx6yAVAHu26iqAsyIKTKdYQwkopXAopVMMN/ioJCgaZXlvC06rjDrJA==
X-Received: by 2002:a37:e104:0:b0:787:b0fc:8f12 with SMTP id c4-20020a37e104000000b00787b0fc8f12mr4918766qkm.3.1709128080223;
        Wed, 28 Feb 2024 05:48:00 -0800 (PST)
Received: from localhost.localdomain ([176.206.22.187])
        by smtp.gmail.com with ESMTPSA id j26-20020a05620a001a00b00787b93d8df1sm4615908qki.99.2024.02.28.05.47.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 05:47:59 -0800 (PST)
Date: Wed, 28 Feb 2024 14:47:53 +0100
From: Juri Lelli <juri.lelli@redhat.com>
To: Ankur Arora <ankur.a.arora@oracle.com>
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de, peterz@infradead.org,
	torvalds@linux-foundation.org, paulmck@kernel.org,
	akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de,
	dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
	vincent.guittot@linaro.org, willy@infradead.org, mgorman@suse.de,
	jpoimboe@kernel.org, mark.rutland@arm.com, jgross@suse.com,
	andrew.cooper3@citrix.com, bristot@kernel.org,
	mathieu.desnoyers@efficios.com, geert@linux-m68k.org,
	glaubitz@physik.fu-berlin.de, anton.ivanov@cambridgegreys.com,
	mattst88@gmail.com, krypton@ulrich-teichert.org,
	rostedt@goodmis.org, David.Laight@aculab.com, richard@nod.at,
	mjguzik@gmail.com, jon.grimm@amd.com, bharata@amd.com,
	raghavendra.kt@amd.com, boris.ostrovsky@oracle.com,
	konrad.wilk@oracle.com
Subject: Re: [PATCH 23/30] sched/fair: handle tick expiry under lazy
 preemption
Message-ID: <Zd85iRyY6-zlo2wl@localhost.localdomain>
References: <20240213055554.1802415-1-ankur.a.arora@oracle.com>
 <20240213055554.1802415-24-ankur.a.arora@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240213055554.1802415-24-ankur.a.arora@oracle.com>

Hi Ankur,

On 12/02/24 21:55, Ankur Arora wrote:
> The default policy for lazy scheduling is to schedule in exit-to-user,
> assuming that would happen within the remaining time quanta of the
> task.
> 
> However, that runs into the 'hog' problem -- the target task might
> be running in the kernel and might not relinquish CPU on its own.
> 
> Handle that by upgrading the ignored tif_resched(NR_lazy) bit to
> tif_resched(NR_now) at the next tick.
> 
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Juri Lelli <juri.lelli@redhat.com>
> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> Originally-by: Thomas Gleixner <tglx@linutronix.de>
> Link: https://lore.kernel.org/lkml/87jzshhexi.ffs@tglx/
> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
> 
> ---
> Note:
>   Instead of special casing the tick, it might be simpler to always
>   do the upgrade on the second resched_curr().
> 
>   The theoretical problem with doing that is that the current
>   approach deterministically provides a well-defined extra unit of
>   time. Going with a second resched_curr() might mean that the
>   amount of extra time the task gets depends on the vagaries of
>   the incoming resched_curr() (which is fine if it's mostly from
>   the tick; not fine if we could get it due to other reasons.)
> 
>   Practically, both performed equally well in my tests.
> 
>   Thoughts?

I'm still digesting the series, so I could simply be confused, but I
have the impression that the extra unit of time might be a problem for
deadline (and maybe rt as well?).

For deadline we call resched_curr_tick() from the throttle part of
update_curr_dl_se() if the dl_se happens to not be the leftmost anymore,
so in this case I believe we really want to reschedule straight away and
not wait for the second time around (otherwise we might be breaking the
new leftmost tasks guarantees)?

Thanks,
Juri


