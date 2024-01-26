Return-Path: <linux-kernel+bounces-40719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E91983E4AD
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 23:08:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 680E1282BC1
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 22:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 629882556B;
	Fri, 26 Jan 2024 22:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hjvpsiEe"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C38272555E
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 22:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706306775; cv=none; b=HhMPfprMCAk9uH6peOyhqhBT5ucrcC7kNkUdpv+yJuU1rxtkOqi1MCdzefyM6q+xahxcqYFMU0sVrTkIPKrdmq3gaCc3+26gg6hXwR93mBhyympj5p+b0YuENBCAlysV4WGT7t0sLSDGG7Cf6OZZvhIoYHxh6/yxcQB60+bBzbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706306775; c=relaxed/simple;
	bh=dCpJQu3vfIDAJ1Aq2AGyqLIgVqEbRZWCZQ8ESsL/WSA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Disposition; b=bCGG4ghZlSBrmTgwqdXPz0b3TVz8CFrOQIqMFq1IKVKHGiRuYApzCvOcf4qn6JA7uW7QbbJ6rp3XOmHHAmv/O6Ik2qk4xXsc9avAr2rOleadtGlnxOKWdDU/rCNJMZNuoO4245DAlk+1hCJNiU51eAN6CX96vfC+bGYrLh3G4kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hjvpsiEe; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706306772;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6GSjdcoXRL5trov+iE2hoQky/bCBVVYnxpaGKh3qlLE=;
	b=hjvpsiEeJ88pr+vkYhg2awtsP2Uh7SFaIEVzOazpaqUqnFKLUR8r5L0vpTTF2+jkcJrqiQ
	ofJkbsJr4UoC5VTUdoiFm49H29joBjH0F5BD28z+KTmZRmiYdWpPNXi3GD++go5BR9oWGg
	BRSWk1TeD9TDacYI/51wYVOcF9pBFmw=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-294-Y0XBGdtZPje1rwYm68gYaw-1; Fri, 26 Jan 2024 17:06:10 -0500
X-MC-Unique: Y0XBGdtZPje1rwYm68gYaw-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-783c781aa5dso137058585a.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 14:06:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706306770; x=1706911570;
        h=content-transfer-encoding:content-disposition:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6GSjdcoXRL5trov+iE2hoQky/bCBVVYnxpaGKh3qlLE=;
        b=N/H4Kuml3o+HyrZt2i0Yi1RoekA6UcBm8htsTI6SSY8K0GIaM5se/xh4SNmrNic+0D
         85oLIiAxzxH6kzACx0I5V01QPPj5QUNHRYsCYfRKLzWyNl1KQfePta4GO/Uh32sQ0k36
         m3u56PfulxGMCCRjt4NVI8sqt+NI1CSzSu9LLvEgiNYxmAWrbrIiUCfuN+9AFJtOW9lU
         VGuh67hJxBugudETMoIdfOP/lYg98yTTFZAvjwQ0D6JgBT0J6RdQMnhj6XB6YFbpWf6F
         SFI0QyQjjW/6pij+ZpBTg8yCqHgKza3emJtwnL6OTgFNK4bw9ajTOpkcNVlMwYboO+jy
         Irww==
X-Gm-Message-State: AOJu0Yz8X00UIlSYHG3g4JnRvPUWH6qP3X4X7G/iAYaTlirotCHcPImB
	HxojrLMBKPRCWfQEJSnvyDyfsazPGLS0sOqABVnWKRd4IyBHeiMWf1jDsCAJCdZBA3P7F/k6CiC
	saEJ5J+QLHYtk/OTj3xdcF9/sbyEvaKnYa2fs0F1/mhsb1HeUoCw6dwK47m0nBeTw53UEQg==
X-Received: by 2002:a05:620a:21c9:b0:783:bfad:6b7c with SMTP id h9-20020a05620a21c900b00783bfad6b7cmr470415qka.81.1706306770112;
        Fri, 26 Jan 2024 14:06:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG6Ua082hX1o6w3Alg70OFXopnpnd8uZm0FMet0DILAUPDHTbUOrSYeO1M+o4ytf88wID/Zcw==
X-Received: by 2002:a05:620a:21c9:b0:783:bfad:6b7c with SMTP id h9-20020a05620a21c900b00783bfad6b7cmr470407qka.81.1706306769792;
        Fri, 26 Jan 2024 14:06:09 -0800 (PST)
Received: from LeoBras.redhat.com ([2804:1b3:a803:96a5:ba81:becc:80f3:6a79])
        by smtp.gmail.com with ESMTPSA id b1-20020a05620a04e100b0078397efd1e3sm917750qkh.31.2024.01.26.14.06.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 14:06:09 -0800 (PST)
From: Leonardo Bras <leobras@redhat.com>
To: Tejun Heo <tj@kernel.org>
Cc: Leonardo Bras <leobras@redhat.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] wq: Avoid using isolated cpus' timers on unbounded queue_delayed_work
Date: Fri, 26 Jan 2024 19:05:35 -0300
Message-ID: <ZbQsr1pNSoiMbDrO@LeoBras>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <ZbQozqY9qOa4Q8KR@slm.duckdns.org>
References: <20240126010321.2550286-1-leobras@redhat.com> <ZbQozqY9qOa4Q8KR@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Fri, Jan 26, 2024 at 11:49:02AM -1000, Tejun Heo wrote:
> Hello,
> 
> On Thu, Jan 25, 2024 at 10:03:20PM -0300, Leonardo Bras wrote:
> ...
> > AS an optimization, if the current cpu is not isolated, use it's timer
>   ^                                                           ^
>   As                                                          its
> 
> > instead of looking for another candidate.
> 
> The sentence reads weird tho. It's always the same timer. We're deciding
> which CPU to queue the timer on.
> 

Hello,

Thanks for pointing that out, I will improve it in the v2.



> > @@ -1958,10 +1958,24 @@ static void __queue_delayed_work(int cpu, struct workqueue_struct *wq,
> >  	dwork->cpu = cpu;
> >  	timer->expires = jiffies + delay;
> >  
> > -	if (unlikely(cpu != WORK_CPU_UNBOUND))
> > -		add_timer_on(timer, cpu);
> > -	else
> > -		add_timer(timer);
> > +	if (likely(cpu == WORK_CPU_UNBOUND)) {
> > +		if (!housekeeping_enabled(HK_TYPE_TIMER)) {
> > +			/* Reuse the same timer */
> 
> This comment is confusing because it's always the same timer.

Thanks, I will point out this being the last cpu used to handle the timer.

> 
> > +			add_timer(timer);
> > +			return;
> > +		}
> > +
> > +		/*
> > +		 * If the work is cpu-unbound, and cpu isolation is in place,
> > +		 * only use timers from housekeeping cpus.
> > +		 * If the current cpu is a housekeeping cpu, use it instead.
> > +		 */
> > +		cpu = smp_processor_id();
> > +		if (!housekeeping_test_cpu(cpu, HK_TYPE_TIMER))
> > +			cpu = housekeeping_any_cpu(HK_TYPE_TIMER);
> > +	}
> > +
> > +	add_timer_on(timer, cpu);
> >  }
> 
> I find the control flow a bit difficult to follow. It's not the end of the
> world to have two add_timer_on() calls. Would something like the following
> be easier to read?
> 
> 	if (housekeeping_enabled(HK_TYPE_TIMER)) {
> 		cpu = smp_processor_id();
> 		if (!housekeeping_test_cpu(cpu, HK_TYPE_TIMER))
> 			cpu = housekeeping_any_cpu(HK_TYPE_TIMER);
> 		add_timer_on(timer, cpu);
> 	} else {
> 		if (likely(cpu == WORK_CPU_UNBOUND))
> 			add_timer(timer, cpu);
> 		else
> 			add_timer_on(timer, cpu);
> 	}
> 
> Thanks.

I am not really against it, but for me it's kind of weird to have that many 
calls to add_timer_on() if we can avoid it. 

I would rather go with:

###
if (unlikely(cpu != WORK_CPU_UNBOUND)) {
	add_timer_on(timer, cpu);
	return;
}

if (!housekeeping_enabled(HK_TYPE_TIMER)) {
	add_timer(timer);
	return;
}

cpu = smp_processor_id();
if (!housekeeping_test_cpu(cpu, HK_TYPE_TIMER))
	cpu = housekeeping_any_cpu(HK_TYPE_TIMER);

add_timer_on(timer, cpu);
###

What do you think?

Thanks,
Leo

> 
> -- 
> tejun
> 


