Return-Path: <linux-kernel+bounces-96127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A0F287576F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 20:47:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A4F11F21082
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 19:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8E411369A6;
	Thu,  7 Mar 2024 19:46:59 +0000 (UTC)
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 3B7F1135A45
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 19:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.131.102.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709840819; cv=none; b=newPl1GrokgYoa8yqQ+lNECoMiB3Kx1CM/oiGUz6S9pAebQbUrqiKGcCId+7auvecHwcR7HOhvA2922hWPanLhYqc4E5X3JgknsYxGAzbYcYdnzDYegyAeTZnxwHcssdpiQoWr3+UvXXSxFIhMusOy29uaY85mRiwYuWvuVfySU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709840819; c=relaxed/simple;
	bh=HODFHfKssOPLT885+7VMMgilrUGj5cbpfwyXP0arUls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HPcLSjsPjrTNaDrtV4Jf2dHHk83xmU5laPNSdwGVeCQpz8nsJSazmPUd2VQ7w5VMgm6FEwn55iHi2aeGiBlY2gJUV7alyQbZzyzo1dEUijgjI6nFGT5Kb42zol4IX32uMVL/z1ulaV9QFDy6rh3WXqUF7blRJLngWUUypxmnFPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=rowland.harvard.edu; spf=pass smtp.mailfrom=netrider.rowland.org; arc=none smtp.client-ip=192.131.102.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netrider.rowland.org
Received: (qmail 230714 invoked by uid 1000); 7 Mar 2024 14:46:56 -0500
Date: Thu, 7 Mar 2024 14:46:56 -0500
From: Alan Stern <stern@rowland.harvard.edu>
To: Andrea Parri <parri.andrea@gmail.com>
Cc: Kenneth-Lee-2012@foxmail.com, linux-kernel@vger.kernel.org,
  paulmck@kernel.org
Subject: Re: Question about PB rule of LKMM
Message-ID: <b3137a9b-0776-421f-8b3b-b5ddd6bce96a@rowland.harvard.edu>
References: <Zedd18wiAkK68Lzr@andrea>
 <tencent_744E0AF832049C200F96FD6582D5114D7F0A@qq.com>
 <ZeipiSVLR01jmM6b@andrea>
 <e05fa6a9-c810-46cb-b033-b91ae7a5c382@rowland.harvard.edu>
 <ZejC+lutRuwXQrMz@andrea>
 <Zenip+8BDM3p+MUh@andrea>
 <eb8f2a21-d388-424d-8504-ccd7bdb53a93@rowland.harvard.edu>
 <ZeoFBkB1BeTdEQsn@andrea>
 <bde188b0-1c5b-4b3b-94de-395a52fc37ce@rowland.harvard.edu>
 <ZeoQvj3l6moF9KdQ@andrea>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZeoQvj3l6moF9KdQ@andrea>

On Thu, Mar 07, 2024 at 08:08:46PM +0100, Andrea Parri wrote:
> > > I'd disagree with these premises: certain instructions can and do execute
> > > at the same time.
> > 
> > Can you give an example?
> 
> I think I'm starting to see where this is going..., but to address the
> question: really any example where the LKMM doesn't know better, say
> 
> C test
> 
> {}
> 
> P0(int *x)
> {
> 	*x = 1;
> }
> 
> P1(int *x)
> {
> 	*x = 2;
> }

Ah, but you see, any time you run this program one of those statements
will execute before the other.  Which will go first is indeterminate,
but the chance of them executing at _exactly_ the same moment is zero.

The LKMM can't say which will execute first because it could be either
one.  In other words, "I don't know which will execute first" is very
different from "They will execute at the same time".

> > >  FWIW, in the formal model, it is not that difficult to
> > > provide examples of "(not F ->xb E) and (not E ->xb F)".
> > 
> > That's because the xb relation in the formal model does not fully 
> > capture our intuitive notion of "executes at the same time" in the 
> > informal operational model.
> > 
> > Also, it's important to distinguish between:
> > 
> > (1)	Two instructions that are forced (say by a dependency) or known 
> > 	(say by an rfe link) to execute in a particular order; versus
> > 
> > (2)	Two instructions that may execute in either order but do execute
> > 	in some particular order during a given run of the program.
> > 
> > The formal xb relation corresponds more to (1), whereas the informal 
> > notion corresponds more to (2).
> 
> This appears to be the key observation.  For if, in the operational model,
> (not F ->xb E) implies (E ->xb F) then I'll apologize for the noise.  :-)

Okay, so it looks like we're in violent agreement.  :-)

> > > > The new text says the same thing as the original, just in a more 
> > > > condensed way.  It skips the detailed explanation of why E must execute 
> > > > before W propagates to E's CPU, merely saying that it is because "W is 
> > > > coherence-later than E".  I'm not sure this is an improvement; the 
> > > > reader might want to know exactly how this reasoning goes.
> > > 
> > > The current text relies on an argument by contradiction.  A contradiction
> > > is reached by "forcing" (F ->xb E), hence all it can be concluded is that
> > > (not F ->xb E).  Again, AFAICS, this doesn't match the claim in the text.
> > 
> > That's why I suggested adding an extra sentence to the paragraph (which 
> > you did not quote in your reply).  That sentence gave a direct argument.
> 
> Well, I read that sentence but stopped at "These contradictions show that"
> for the reason I detailed above.

The way you put it also relies on argument by contradiction.  This
just wasn't visible, because you omitted a lot of intermediate steps in
the reasoning.

If you want to see this in detail, try explaining why it is that "W is
coherence-later than E" implies "E must execute before W propagates to
E's CPU" in the operational model.

Alan

