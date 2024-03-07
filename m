Return-Path: <linux-kernel+bounces-95935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D6A687551C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 18:26:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2022D1F22AFA
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 17:26:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59971130AE5;
	Thu,  7 Mar 2024 17:26:03 +0000 (UTC)
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 5D22C12D754
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 17:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.131.102.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709832362; cv=none; b=VtxGwBFD+gwGryEPRVX8o37AG97l+upmCPYCzVzGFLlvUTR8X9pqMkwQfEVQKNq9cpWfjVNHdLAq6P+Lrq6NIPzibxVylKwBjkh4/VPunF2yc+DvLeuqdZJw0OX6pbroH7Txq3j2vRbY/iLuczUYEPDWz90BLnole6HzpvvLph0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709832362; c=relaxed/simple;
	bh=SX1AtC2u+6Iy/vuRfN8U8yNJ+dFFIfCxN9dJq7EtE78=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SuGYB6OYDUE1v+N1QMebitn6IODVfKBLBKgNoIz7wqStEqbmHfhe+gfFvBtM82m2GTl81SUOIfdYiX+crG6tFtCZ0dxP/FezDSjugUQ/Qk8/hgtjwCgKyPFjYc025RIFKEqNjLsdchE0nYfiMTRXdkrvxsDPUvUldo7SxNJL9qU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=rowland.harvard.edu; spf=pass smtp.mailfrom=netrider.rowland.org; arc=none smtp.client-ip=192.131.102.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netrider.rowland.org
Received: (qmail 226039 invoked by uid 1000); 7 Mar 2024 12:25:58 -0500
Date: Thu, 7 Mar 2024 12:25:58 -0500
From: Alan Stern <stern@rowland.harvard.edu>
To: Andrea Parri <parri.andrea@gmail.com>
Cc: Kenneth-Lee-2012@foxmail.com, linux-kernel@vger.kernel.org,
  paulmck@kernel.org
Subject: Re: Question about PB rule of LKMM
Message-ID: <eb8f2a21-d388-424d-8504-ccd7bdb53a93@rowland.harvard.edu>
References: <tencent_C5266B7D6F024A916BCA7833FDEA94A74309@qq.com>
 <Zedd18wiAkK68Lzr@andrea>
 <tencent_744E0AF832049C200F96FD6582D5114D7F0A@qq.com>
 <ZeipiSVLR01jmM6b@andrea>
 <e05fa6a9-c810-46cb-b033-b91ae7a5c382@rowland.harvard.edu>
 <ZejC+lutRuwXQrMz@andrea>
 <Zenip+8BDM3p+MUh@andrea>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zenip+8BDM3p+MUh@andrea>

On Thu, Mar 07, 2024 at 04:52:07PM +0100, Andrea Parri wrote:
> On Wed, Mar 06, 2024 at 08:24:42PM +0100, Andrea Parri wrote:
> > > Later on, the file includes this paragraph, which answers the question 
> > > you were asking:
> > > 
> > > ---------------------------------------------------------------------
> > > The existence of a pb link from E to F implies that E must execute
> > > before F.  To see why, suppose that F executed first.  Then W would
> > > have propagated to E's CPU before E executed.  If E was a store, the
> > > memory subsystem would then be forced to make E come after W in the
> > > coherence order, contradicting the fact that E ->coe W.  If E was a
> > > load, the memory subsystem would then be forced to satisfy E's read
> > > request with the value stored by W or an even later store,
> > > contradicting the fact that E ->fre W.
> > > ---------------------------------------------------------------------
> > 
> > TBF, that just explains (not F ->xb E), or I guess that was the origin
> > of the question.

Are we talking about the formal xb relation (as mentioned in a comment 
in linux-kernel.cat), or the informal notion of "executing before" as 
used in the operational model?  In the first case, it's true by 
definition that pb implies xb, since xb would be defined by:

	let xb = hb | pb | rb

if it were in the memory model.

So I guess you're talking about the second, intuitive meaning.  That's 
very simple to explain.  Since every instruction executes at _some_ 
time, and since we can safely assume that no two instructions execute at 
exactly the _same_ time, if F doesn't execute before E then E must 
execute before F.  Or using your terms, (not F ->xb E) implies (E ->xb 
F).  Would that answer the original question satisfactorily?

> So perhaps as in the diff below.  (Alan, feel free to manipulate to better
> align with the current contents and style of explanation.txt.)
> 
>   Andrea
> 
> From c13fd76cd62638cbe197431a16aeea001f80f6ec Mon Sep 17 00:00:00 2001
> From: Andrea Parri <parri.andrea@gmail.com>
> Date: Thu, 7 Mar 2024 16:31:57 +0100
> Subject: [PATCH] tools/memory-model: Amend the description of the pb relation
> 
> To convey why E ->pb F implies E ->xb F in the operational model of
> explanation.txt.
> 
> Reported-by: Kenneth Lee <Kenneth-Lee-2012@foxmail.com>
> Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
> ---
>  tools/memory-model/Documentation/explanation.txt | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/tools/memory-model/Documentation/explanation.txt b/tools/memory-model/Documentation/explanation.txt
> index 6dc8b3642458e..68af5effadbbb 100644
> --- a/tools/memory-model/Documentation/explanation.txt
> +++ b/tools/memory-model/Documentation/explanation.txt
> @@ -1461,13 +1461,11 @@ The case where E is a load is exactly the same, except that the first
>  link in the sequence is fre instead of coe.
>  
>  The existence of a pb link from E to F implies that E must execute
> -before F.  To see why, suppose that F executed first.  Then W would
> -have propagated to E's CPU before E executed.  If E was a store, the
> -memory subsystem would then be forced to make E come after W in the
> -coherence order, contradicting the fact that E ->coe W.  If E was a
> -load, the memory subsystem would then be forced to satisfy E's read
> -request with the value stored by W or an even later store,
> -contradicting the fact that E ->fre W.
> +before F.  To see why, let W be a store coherence-later than E and
> +propagating to every CPU and to RAM before F executes.  Then E must
> +execute before W propagates to E's CPU (since W is coherence-later
> +than E).  In turn, W propagates to E's CPU (and every CPU) before F
> +executes.

The new text says the same thing as the original, just in a more 
condensed way.  It skips the detailed explanation of why E must execute 
before W propagates to E's CPU, merely saying that it is because "W is 
coherence-later than E".  I'm not sure this is an improvement; the 
reader might want to know exactly how this reasoning goes.

Would it suit you to instead add an extra sentence to the end of the 
paragraph, something like this?

	These contradictions show that E must execute before W 
	propagates to E's CPU, hence before W propagates to every
	CPU, and hence before F executes.

Alan Stern

