Return-Path: <linux-kernel+bounces-29548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67B67831012
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 00:19:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2026728D850
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 23:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E756B25620;
	Wed, 17 Jan 2024 23:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i66YdexJ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B9FF21A12
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 23:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705533549; cv=none; b=rAAnLw/ZtXUCDHEctET5iLezg+ZdoIPrJpAsAI7g2y2O7wrHOmPyRvx1qc5Ynn5X1u7mmKZArOdBbwZj0EqGDPQySjMYBxM5gXw9deD8C5clUU+1T483np4fOlS2yqCJ+RovHQj3KyvOODK3xJk/Hy+DieKZZRAxO2ZZ9yOmEPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705533549; c=relaxed/simple;
	bh=nuk6PFQ9+p+9wuWPs1iRr1kUgHqCggJoF6Qj/g7bbpA=;
	h=DKIM-Signature:Received:X-MC-Unique:Received:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Received:
	 X-Google-Smtp-Source:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding; b=OFx2/uxmqQWlSW86LyhLlusyW1sGCC4DV0lFmbvOeUrEauSjD6/wOBPJdXU4OnzyLHxNKBQ9UF2C/xU6pz2Qpr50vjNAlAF8RCrFk5xj4OLgTk5jRrbazGmfAOxtQ3iPC3NbyZzO9ADtb0JnCJuof7Dxm5ZvD4GbvQBptg8RVHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i66YdexJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705533546;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MojhU4GRzsLWYYfrEcAZeXUgW5CKtIhKDn39POD9PAg=;
	b=i66YdexJQSYekf9Vcgl8S9Av18P27rA0wljIMJk10DfjG89+E993Yq9Us7zB38D/VBbBxD
	R5VWMqv7YWBNy3ezTybopzImzT//qoGD52GLLbM34H+ZbeAedGgEMQhlF+5eqAbBGhkvn4
	2ZLmzGFMvMFLHIfjRja8yvK+z+FKDpQ=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-U-J3z6itMWSOq-gNIe3lSw-1; Wed, 17 Jan 2024 18:19:03 -0500
X-MC-Unique: U-J3z6itMWSOq-gNIe3lSw-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7816bea8d28so35227285a.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 15:19:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705533542; x=1706138342;
        h=content-transfer-encoding:content-disposition:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MojhU4GRzsLWYYfrEcAZeXUgW5CKtIhKDn39POD9PAg=;
        b=Q25Z+1Gi/lFlQP/97KfG5kZGNA+uuuPgcj3in7Yry+EQR/wcRBUd/ZLIzusMASmLqE
         BhMnKG83RK2T8/48fvmeDZmDOxF1tC8sbaE9r4qoxAwwjhjLMS3FFKar30hfothwTQcV
         Vq4MRLsMcUUn6MSaL5/L80r3ltR7nC5YUsnJZ6o1uliziHYVFPvglAjDze1U2wqalCAq
         Z0Rvi5vUaFgDW12FODdtr6nFZam//I5hs+JTaOSQnQ8KMvuFICwmuyShqir471MtANmd
         N2vghhk72IxWryn/+fuXXNdzqn42mBrGBg9oZKhoOunNGzvMty6R/W8zT8lP9yoxQ98D
         dutA==
X-Gm-Message-State: AOJu0Yz6u71HZKWxyeOpjV2szDI3jkLJhPRDK2OhbHTwzl1FUvymxuj5
	Fl3a1/oOZMSW/k1JxegDZr6uf20AKJIQS0cl7ng4YKt6Z+xsXHmbVaBGL2AmLqpQDhkNYv/y09V
	btJoVvSF4KXhzU8eydQZsdHvnMouw6w3YTpa7MvkVFfcoDkiZds6bNY7V9OB6UQ==
X-Received: by 2002:a05:620a:379b:b0:783:4d55:f213 with SMTP id pi27-20020a05620a379b00b007834d55f213mr71708qkn.46.1705533542151;
        Wed, 17 Jan 2024 15:19:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFakd5eBLFBT+acN/2ozZLykVhRcQfrRhtKu2agDe07jWfzkyFdaQDN1NxSrqpEEAU94kza/Q==
X-Received: by 2002:a05:620a:379b:b0:783:4d55:f213 with SMTP id pi27-20020a05620a379b00b007834d55f213mr71699qkn.46.1705533541923;
        Wed, 17 Jan 2024 15:19:01 -0800 (PST)
Received: from LeoBras.redhat.com ([2804:1b3:a803:6ad1:9baf:f024:858c:2fee])
        by smtp.gmail.com with ESMTPSA id d1-20020a37c401000000b00783189b0aeasm4866671qki.46.2024.01.17.15.18.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jan 2024 15:19:01 -0800 (PST)
From: Leonardo Bras <leobras@redhat.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Leonardo Bras <leobras@redhat.com>,
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
Subject: Re: [RESEND RFC PATCH v1 2/2] serial/8250: Avoid getting lock in RT atomic context
Date: Wed, 17 Jan 2024 20:18:54 -0300
Message-ID: <ZahgXuNmysj8Ue7U@LeoBras>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <87r0ifful4.ffs@tglx>
References: <20240116073701.2356171-1-leobras@redhat.com> <20240116073701.2356171-3-leobras@redhat.com> <87r0ifful4.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Wed, Jan 17, 2024 at 11:44:55PM +0100, Thomas Gleixner wrote:
> On Tue, Jan 16 2024 at 04:37, Leonardo Bras wrote:
> > With PREEMPT_RT enabled, a spin_lock_irqsave() becomes a possibly sleeping
> > spin_lock(), without preempt_disable() or irq_disable().
> >
> > This allows a task T1 to get preempted or interrupted while holding the
> > port->lock. If the preempting task T2 need the lock, spin_lock() code
> > will schedule T1 back until it finishes using the lock, and then go back to
> > T2.
> >
> > There is an issue if a T1 holding port->lock is interrupted by an
> > IRQ, and this IRQ handler needs to get port->lock for writting (printk):
> > spin_lock() code will try to reschedule the interrupt handler, which is in
> > atomic context, causing a BUG() for trying to reschedule/sleep in atomic
> > context.
> >
> > So for the case (PREEMPT_RT && in_atomic()) try to get the lock, and if it
> > fails proceed anyway, just like it's done in oops_in_progress case.
> 
> That's just blantantly wrong. The locks are really only to be ignored
> for the oops case, but not for regular printk.

I agree, but the alternative was to have a BUG() due to scheduling in 
atomic context. This would only ignore the lock if it was already taken 
anyway.

That being said, I agree it is not the best solution for the issue, and 
just sent this in the RFC in order to get feedback on what could be done.

> 
> I assume that this is not against the latest RT kernel as that should
> not have that problem at all.

I am based on torvalds/linux at master branch, so maybe I am missing some 
RT-specific patches. Which tree do you recommend me testing?

> 
> Thanks,
> 
>         tglx
> 

Thank you!
Leo


