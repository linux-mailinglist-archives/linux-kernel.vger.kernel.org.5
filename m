Return-Path: <linux-kernel+bounces-131722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1B23898B12
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 17:26:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D21A28E06B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 15:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC81512A16A;
	Thu,  4 Apr 2024 15:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LpXanQ8O"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E50481C2BD
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 15:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712244355; cv=none; b=gH/83KCs14ynAAMIE3udCAH2dvQDwsdYAnJ1pvxZg+AqbNM6oUxeF/v0dbK3EqdnsmEOqP70YRq0V7akI9aR3qO6uDsabapHesn3EfqziQi1Lr5zH3tnKJwg8M8xAo3SLv1cQSHuMLSzy0jW7jYDjrRRKEruNpJPHrb7xCHE0G0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712244355; c=relaxed/simple;
	bh=EyANxchTUq4vCZ8B0GlMj1ALpGGfgcRd78F9nkanEmk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rsTp5SEC1798q55Hc3WoO181vc57j6rZuXmZUbMGkx8XVEhCKlZgL8drY+YFoMuiFochBftmnhrYD8JHrCr/4Dig6/DpBieA8RE8WNwPEut5fEym7E4HyinSt25oaIxymclwUiAq7Uri5A3IlOCzSHk7WZpQ8qz2CKEkCeu9IIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LpXanQ8O; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712244351;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EyANxchTUq4vCZ8B0GlMj1ALpGGfgcRd78F9nkanEmk=;
	b=LpXanQ8O1I2dnfBRiblgyj80UxaqRHvRjga/pEjQOR9KHgdMbw9Sol/tBHI1GIoB1OaVkb
	QokJrxDRHhzB6ITlX2UQVxPLnv4lUGByNbMX/CLfi5pD4QjGc8QSabMTYvyFCDovxocJV1
	OgLgp7GmI1d2sMvaiXPC3Ywk/59CnBg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-694-tUm63H4bOu2bbGcK_ijisg-1; Thu, 04 Apr 2024 11:25:46 -0400
X-MC-Unique: tUm63H4bOu2bbGcK_ijisg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CE27680C76B;
	Thu,  4 Apr 2024 15:25:45 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.21])
	by smtp.corp.redhat.com (Postfix) with SMTP id BAF1D40735E2;
	Thu,  4 Apr 2024 15:25:42 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu,  4 Apr 2024 17:24:20 +0200 (CEST)
Date: Thu, 4 Apr 2024 17:23:57 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Dmitry Vyukov <dvyukov@google.com>, John Stultz <jstultz@google.com>,
	Marco Elver <elver@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	kasan-dev@googlegroups.com, Edward Liaw <edliaw@google.com>,
	Carlos Llamas <cmllamas@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v6 1/2] posix-timers: Prefer delivery of signals to the
 current thread
Message-ID: <20240404152356.GE7153@redhat.com>
References: <20230316123028.2890338-1-elver@google.com>
 <CANDhNCqBGnAr_MSBhQxWo+-8YnPPggxoVL32zVrDB+NcoKXVPQ@mail.gmail.com>
 <87frw3dd7d.ffs@tglx>
 <CANDhNCqbJHTNcnBj=twHQqtLjXiGNeGJ8tsbPrhGFq4Qz53c5w@mail.gmail.com>
 <874jcid3f6.ffs@tglx>
 <20240403150343.GC31764@redhat.com>
 <87sf02bgez.ffs@tglx>
 <CACT4Y+a-kdkAjmACJuDzrhmUPmv9uMpYOg6LLVviMQn=+9JRgA@mail.gmail.com>
 <20240404134357.GA7153@redhat.com>
 <87v84x9nad.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87v84x9nad.ffs@tglx>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

On 04/04, Thomas Gleixner wrote:
>
> On Thu, Apr 04 2024 at 15:43, Oleg Nesterov wrote:
>
> > And this will happen with
> > or without the commit bcb7ee79029dca ("posix-timers: Prefer delivery of
> > signals to the current thread"). Any thread can dequeue a shared signal,
> > say, on return from interrupt.
> >
> > Just without that commit this "eventually" means A_LOT_OF_TIME
> > statistically.
>
> bcb7ee79029dca only directs the wakeup to current, but the signal is
> still queued in the process wide shared pending list. So the thread
> which sees sigpending() first will grab and deliver it to itself.

This is what I tried to say above.

> What we can actually test is the avoidance of waking up the main thread
> by doing the following in the main thread:

Hmm... I think it can be even simpler,

> I'm testing a modification which implements something like the above and
> the success condition is that the main thread does not return early from
> nanosleep() and has no signal accounted. It survived 2000 iterations by
> now.

Yes, but please see a trivial test-case I sent you few minutes ago.

Oleg.


