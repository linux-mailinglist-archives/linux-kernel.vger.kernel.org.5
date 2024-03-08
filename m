Return-Path: <linux-kernel+bounces-97421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AFFF6876A48
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 18:54:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 501EF1F24E22
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 17:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7744840861;
	Fri,  8 Mar 2024 17:54:46 +0000 (UTC)
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 9275C36D
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 17:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.131.102.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709920486; cv=none; b=smpsid6inEvT6mbrHJ/lCYhwZxvuopwqNW4A6VdjuyDNHqj4bmR6+2KcUTNBcVpjPJOs/xzgOqcISaQwfY0y4x2iXNKWHWmtK/QOcRea5Pur6HoXdgQtTPTSrBd5PaVU3AR/GAX9e673ffmIIUYSnJA0QK9QBKHrOCrIb2luHWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709920486; c=relaxed/simple;
	bh=/H8WjFvFPxyLsZIPjl4/bakKUkVA3AKPXdEEQ/B6xns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zdw+YDCnqyC6uCvbLmGtUZU+KgLNhFyRovMcfbzBodleUmLhSjOUbn3EpF5M0CSTTOXYhYpEy2cOcWKE0ZPQ2s8Vk8qYdR7ijcizcKcRfykfaeYFWDRSSFhYuangBpSyjiJSjh6dh9wpFAwCDTGlaTJHLUnVA0ltoK8tAiBrEzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=rowland.harvard.edu; spf=pass smtp.mailfrom=netrider.rowland.org; arc=none smtp.client-ip=192.131.102.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netrider.rowland.org
Received: (qmail 266266 invoked by uid 1000); 8 Mar 2024 12:54:42 -0500
Date: Fri, 8 Mar 2024 12:54:42 -0500
From: Alan Stern <stern@rowland.harvard.edu>
To: Andrea Parri <parri.andrea@gmail.com>
Cc: Kenneth-Lee-2012@foxmail.com, linux-kernel@vger.kernel.org,
  paulmck@kernel.org
Subject: Re: Question about PB rule of LKMM
Message-ID: <198f16f6-1d61-4868-b522-1bc5d34bf7af@rowland.harvard.edu>
References: <ZeipiSVLR01jmM6b@andrea>
 <e05fa6a9-c810-46cb-b033-b91ae7a5c382@rowland.harvard.edu>
 <ZejC+lutRuwXQrMz@andrea>
 <Zenip+8BDM3p+MUh@andrea>
 <eb8f2a21-d388-424d-8504-ccd7bdb53a93@rowland.harvard.edu>
 <ZeoFBkB1BeTdEQsn@andrea>
 <bde188b0-1c5b-4b3b-94de-395a52fc37ce@rowland.harvard.edu>
 <ZeoQvj3l6moF9KdQ@andrea>
 <b3137a9b-0776-421f-8b3b-b5ddd6bce96a@rowland.harvard.edu>
 <ZeosQDNK8hN/KgJR@andrea>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZeosQDNK8hN/KgJR@andrea>

On Thu, Mar 07, 2024 at 10:06:08PM +0100, Andrea Parri wrote:
> > > C test
> > > 
> > > {}
> > > 
> > > P0(int *x)
> > > {
> > > 	*x = 1;
> > > }
> > > 
> > > P1(int *x)
> > > {
> > > 	*x = 2;
> > > }
> > 
> > Ah, but you see, any time you run this program one of those statements
> > will execute before the other.  Which will go first is indeterminate,
> > but the chance of them executing at _exactly_ the same moment is zero.
> 
> TBH, I don't.  But I trust you know your memory controller.  ;-)

I can't tell which aspect of this bothers you more: the fact that the 
text uses an argument by contradiction, or the fact that it ignores the 
possibility of two instructions executing at the same time.

If it's the latter, consider this: Although the text doesn't say so, 
the reasoning it gives also covers the case where F executes at the same 
time as E.  You can still deduce that W must have propagated to E's 
CPU before E executed, because W must propagate to every CPU before F 
executes.

> > The way you put it also relies on argument by contradiction.  This
> > just wasn't visible, because you omitted a lot of intermediate steps in
> > the reasoning.
> > 
> > If you want to see this in detail, try explaining why it is that "W is
> > coherence-later than E" implies "E must execute before W propagates to
> > E's CPU" in the operational model.
> 
> But that's all over in explanation.txt??  FWIW, a quick search returned
> (wrt fre):
> 
>   R ->fre W means that W overwrites the value which R reads, but it
>   doesn't mean that W has to execute after R.  All that's necessary
>   is for the memory subsystem not to propagate W to R's CPU until
>   after R has executed

(In fact, that sentence isn't entirely accurate.  It should say "... not 
to propagate W (or a co-later store)...".)

Let's consider coe instead of fre.  The description of how the 
operational model manages the coherence order of stores is found in 
section 13 (AN OPERATIONAL MODEL):

	When CPU C executes a store instruction, it tells the memory 
	subsystem to store a certain value at a certain location.  The 
	memory subsystem propagates the store to all the other CPUs as 
	well as to RAM.  (As a special case, we say that the store 
	propagates to its own CPU at the time it is executed.)  The 
	memory subsystem also determines where the store falls in the 
	location's coherence order.  In particular, it must arrange for 
	the store to be co-later than (i.e., to overwrite) any other 
	store to the same location which has already propagated to CPU 
	C.

So now if E is a store and is co-before W, how do we know that W didn't 
propagate to E's CPU before E executed?  It's clear from the last 
sentence of the text above: If W had propagated to E's CPU before E 
executed then the memory subsystem would have arranged for E to be 
co-later than W.  That's an argument by contradiction, and there's no 
way to avoid it here.

Alan

