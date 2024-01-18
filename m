Return-Path: <linux-kernel+bounces-29948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47BFC8315AB
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 10:24:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CACFD1F26DEF
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 09:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C9F21D55A;
	Thu, 18 Jan 2024 09:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GwxJlBqX"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A711BDFC
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 09:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705569880; cv=none; b=fb+qTD0nwyOA5nZ83BJnlANDxpGn72ilfbo5/H528Wbq50TlCemFlRICAR6JzkCCINfo8N3OXZCeLxcqOO4g11Nt8YDcLo6UoImnVSBRFHhFTkcMPDIqV++DWRqEmVAxAYOBfMcPdMSmyLRtc+ZObeG3wCQjo3QP0fkH+PASlps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705569880; c=relaxed/simple;
	bh=hAxBSB8jZGNGXkaDT5Gc0IOAwfXgI9zR287purl7LbA=;
	h=DKIM-Signature:Received:X-MC-Unique:Received:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Received:
	 X-Google-Smtp-Source:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding; b=ee5rlenI+WVYNuVmkCpPousFIIaJq8flzL66jEVK7k9l5Sr2YuBHxMX1O7mUaraW7aHIBnFe0UQ31jJfGVXXLCVS0hE99iqJ2AUCADZo/5Vu989sK61o5e1ijErr8SbJK+IutnAsb8JxdSenvxb1ObiDumKZK2ViwWlwdUG3qCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GwxJlBqX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705569877;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RnEHhjCm6k/CZTLAzXdrHvCgybCqk5qE4sMq7XE6mNc=;
	b=GwxJlBqXtvARCVOwr5+sIPXHljN3JHwmihkfBE2iWefa0Za9OajZjC/T1IYWBBHOPf6tuf
	BYx88k1ZeCjCqfrNKW53e287Eh4GDUakvFgMnoZWqRLn8Bw6gAXzrjipCA/ZN8h91Vthiw
	qANDV+vZgNWHJzbZ1asAW6aeZJhbrw4=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-75-kmes5XHKOXKNsm18N4Iftw-1; Thu, 18 Jan 2024 04:24:30 -0500
X-MC-Unique: kmes5XHKOXKNsm18N4Iftw-1
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-42a1e487360so1198031cf.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 01:24:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705569870; x=1706174670;
        h=content-transfer-encoding:content-disposition:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RnEHhjCm6k/CZTLAzXdrHvCgybCqk5qE4sMq7XE6mNc=;
        b=mB2r7NwPiIlVytszROVSW0TjKukS3VTxxvfIeQoJkZTmXI/xX/Rp7Ghe3IELVqvheK
         hiR5czIR4V94NSlG5U1pGiTFBBXX2EB3oq0Zc/7ik3O/X7xgYlq+o79ySmbO+2kjer0P
         hS0PD13g+B4+1XpTXA6jGUwqBX79AXmhRieFSGRHl8CdgfGwxxGzF0qF+d/JUyk5c8sr
         1nICzayTVa/9zDt14bUih4JWqJU9FPo0eNifJFli8OHBoBonjO3bJrjQUhzc7xKuI/Q4
         gAtKaL3ns4L5qjxurQ48Db5e25/vJVBp45Gd4DjfxDYXRhorju/kHxR3axGEigXgNDXU
         ZNqg==
X-Gm-Message-State: AOJu0YzqY7UpwRZchPCBJN32ollc2hyxfwuzRJSUnZwN7GLKXOW0oeQL
	HYHtveA0UZbuo0RrAg48FsEOJp6+FMMpuvbsSPF6HMZnh9U24m1JujtsuZoG0Hai+qf07DzpZrw
	0IKplfa50FxxqAJf2QSeXhwLk0kCsDHEKSZ7GG42O/sMPxJHRmSFREL0M8UKyAw==
X-Received: by 2002:a05:622a:41:b0:429:e741:6086 with SMTP id y1-20020a05622a004100b00429e7416086mr545583qtw.50.1705569870283;
        Thu, 18 Jan 2024 01:24:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE/aIlnaKaJDxIo0ryzXxRyNDirj7kD4P44SfvMq8LixI0qLxHxLgWyeoalljRIspXWt/d+Mg==
X-Received: by 2002:a05:622a:41:b0:429:e741:6086 with SMTP id y1-20020a05622a004100b00429e7416086mr545580qtw.50.1705569869975;
        Thu, 18 Jan 2024 01:24:29 -0800 (PST)
Received: from LeoBras.redhat.com ([2804:1b3:a803:6ad1:9baf:f024:858c:2fee])
        by smtp.gmail.com with ESMTPSA id cn3-20020a05622a248300b00429c8ae9b94sm6362366qtb.85.2024.01.18.01.24.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jan 2024 01:24:29 -0800 (PST)
From: Leonardo Bras <leobras@redhat.com>
To: Leonardo Bras <leobras@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	John Ogness <john.ogness@linutronix.de>,
	Tony Lindgren <tony@atomide.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [RESEND RFC PATCH v1 1/2] irq/spurious: Reset irqs_unhandled if an irq_thread handles one IRQ request
Date: Thu, 18 Jan 2024 06:24:25 -0300
Message-ID: <ZajuST2EHSPCwA1m@LeoBras>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <ZahYxOL2r7YbPvO7@LeoBras>
References: <20240116073701.2356171-1-leobras@redhat.com> <20240116073701.2356171-2-leobras@redhat.com> <87ttnbfw9f.ffs@tglx> <ZahYxOL2r7YbPvO7@LeoBras>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Wed, Jan 17, 2024 at 07:46:28PM -0300, Leonardo Bras wrote:
> On Wed, Jan 17, 2024 at 11:08:44PM +0100, Thomas Gleixner wrote:
> > On Tue, Jan 16 2024 at 04:36, Leonardo Bras wrote:
> > > This IRQ line disable bug can be easily reproduced with a serial8250
> > > console on a PREEMPT_RT kernel: it only takes the user to print a lot
> > > of text to the console (or to ttyS0): around 300k chars should be
> > > enough.
> > 
> > That has nothing to do with RT, it's a problem of force threaded
> > interrupts in combination with an edge type interrupt line and a
> > hardware which keeps firing interrupts forever.
> 
> Hello Thomas, thanks for your feedback!
> 
> I agreed it has nothing to do with RT.
> I just mentioned PREEMPT_RT as my test case scenario, since it enables 
> force-threaded IRQs.
> 
> > 
> > > To fix this bug, reset irqs_unhandled whenever irq_thread handles at least
> > > one IRQ request.
> > 
> > This papers over the symptom and makes runaway detection way weaker for
> > all interrupts or breaks it completely.
> 
> This change is supposed to only touch threaded interruptions, since it will
> reach the included line only if (action_ret == IRQ_WAKE_THREAD) and if 
> desc->threads_handled changes since the last IRQ request.
> 
> This incrementing also happens only on irq_forced_thread_fn() and 
> irq_thread_fn(), which are called only from irq_thread_fn().
> 
> But I get the overall worry about having this making runaway detection way 
> weaker for all threaded interrupts.
> 
> I have previously worked on a solution that can be more precise and be an 
> opt-in for drivers instead of a general solution:
> 
> It required a change in IRQ interface that let the handlers inform how 
> many IRQs were actually handled (batching). This number would then be 
> added to desc->threads_handle (in irq_*thread_fn(), just changing the 
> atomic_inc() to atomic_add()), and then subtracted from irqs_unhandled
> at note_interrupt().
> 
> In the serial8250 case, the driver would be changed to use that interface, 
> since it's already able to process multiple IRQs, and the bug just 
> vanishes.
> 
> This also solved the serial driver issue, but required a deeper change in 
> the code, which caused me to consider a simpler solution first.
> 
> This solution sure does give better runnaway detection. Do you think it 
> would be better that the one I sent in this patch?

For reference, this is the alternative:
https://gitlab.com/LeoBras/linux/-/commits/serial8250

Please let me know it you think this one is better.

Thanks!
Leo

> 
> > 
> > The problem with edge type interrupts is that we cannot mask them like
> > we do with level type interrupts in the hard interrupt handler and
> > unmask them once the threaded handler finishes.
> > 
> > So yes, we need special rules here when:
> > 
> >    1) The interrupt handler is force threaded
> > 
> >    2) The interrupt line is edge type
> > 
> >    3) The accumulated unhandled interrupts are within a sane margin
> > 
> > Thanks,
> > 
> >         tglx
> > 
> 
> Completelly agree, that's why I am suggesting dealing with threaded 
> interruptions in a different way: reseting the unhandled count when it 
> handles a request. 
> 
> I am not sure how force threaded and just threaded are different in this 
> scenario. Could you help me understand?
> 
> Thanks!
> Leo


