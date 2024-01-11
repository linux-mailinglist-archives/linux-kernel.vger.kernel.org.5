Return-Path: <linux-kernel+bounces-23851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 417B982B2CC
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 17:21:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5654281D8F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 16:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BF2C50246;
	Thu, 11 Jan 2024 16:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IqQhEeiy";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="M1SBdvHL"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2010756B66;
	Thu, 11 Jan 2024 16:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 11 Jan 2024 17:19:15 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1704989957;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YOLOzAjuYOas3k2x1TDtMxzw0TAxfNtFSi0XJdyBOuw=;
	b=IqQhEeiyfpazk/Y9GG+PbHwfbR47wNC8Gj7JipnWsmQeEGGfThXzwW76YCyO3K3WgtO9DB
	pOTYmZFJfnG+WRDytuVbnrYV0j+Ke6SnMNW2zfajvn+pcWatTDYtDH+BdbCHwLPZOnFFBY
	VCcEizb76GmaF8xOMsKRFnOtItrsU/Nwdj1Xbv4kvu9uiCe7xkIROY1k95cKQe7PzOZ+ux
	kzSVLMuFSl6hImnDirJOFujtBL16aurVJCk5Lhkki+hLpXrExuONuHKAUs6jI9bKknuwHU
	9uorA79s+84aP3oUaEFvxJ9526xHNyCYF0kfNGqy3PwrMmYbsdmDuQ0nnjidJw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1704989957;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YOLOzAjuYOas3k2x1TDtMxzw0TAxfNtFSi0XJdyBOuw=;
	b=M1SBdvHLQqhI3beZkl5BBaVsgKfakdiJKYfOZCVrRkZnnMpfLQ+0hjL1fi1g5bjkdbb36z
	Lz955hH+qNGMKeDg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Paolo Abeni <pabeni@redhat.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Boqun Feng <boqun.feng@gmail.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eric Dumazet <edumazet@google.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH net-next 01/24] locking/local_lock: Introduce guard
 definition for local_lock.
Message-ID: <20240111161915.QlfL1DLS@linutronix.de>
References: <20231215171020.687342-1-bigeasy@linutronix.de>
 <20231215171020.687342-2-bigeasy@linutronix.de>
 <e6509e106251c10a9f65bf5e520911cda26060a6.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e6509e106251c10a9f65bf5e520911cda26060a6.camel@redhat.com>

On 2023-12-18 09:16:49 [+0100], Paolo Abeni wrote:
> > --- a/include/linux/local_lock.h
> > +++ b/include/linux/local_lock.h
> > @@ -51,4 +51,15 @@
> >  #define local_unlock_irqrestore(lock, flags)			\
> >  	__local_unlock_irqrestore(lock, flags)
> >  
> > +DEFINE_LOCK_GUARD_1(local_lock, local_lock_t,
> > +		    local_lock(_T->lock),
> > +		    local_unlock(_T->lock))
> > +DEFINE_LOCK_GUARD_1(local_lock_irq, local_lock_t,
> > +		    local_lock_irq(_T->lock),
> > +		    local_unlock_irq(_T->lock))
> 
> DEFINE_GUARD should fit for the 2 above, right?

Yes, that will work. Let me update it.

> Cheers,
> 
> Paolo

Sebastian

