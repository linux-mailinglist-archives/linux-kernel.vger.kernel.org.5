Return-Path: <linux-kernel+bounces-96015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF44187561D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 19:30:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B67D41C213D9
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 18:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA30F182BB;
	Thu,  7 Mar 2024 18:30:32 +0000 (UTC)
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 9EAAC1CA8A
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 18:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.131.102.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709836232; cv=none; b=RPQ0FsTkjFWDa47OszQYyZGSvMiEBRsL+jP9nF0u/AFnzVUB48VnaCtVzGiU5BqKaQGUkMpJ7L+QrHs66EdtA6d8nHXdA7xNsKGJYLmqiUmaKrDfkoYL12yF4iJ4SQSklyw3e/YRgRc4I2Cp0HNMhsI5dBX2Dw0SG2REaSFyaGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709836232; c=relaxed/simple;
	bh=EsjxUmMOFGlEYnJvDps6DJCfL6v6Kx+yjlql86ERYsc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DBt57h1dT0YTtpOKRI1pRHczyxEbZsaOgu2wldtAMQkAE/Qz+yzS3dDYt7lB2LbqmE5BM9c9GSWLXyxkoEmBHC7zczYDcOXtE+b7Z64HRrkC1fzzu9Q9J7UwGPhQ07gdUxeutwH0D+LtPsPTQS/vbqDTEprqHphHDSBb7r97ISQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=rowland.harvard.edu; spf=pass smtp.mailfrom=netrider.rowland.org; arc=none smtp.client-ip=192.131.102.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netrider.rowland.org
Received: (qmail 227946 invoked by uid 1000); 7 Mar 2024 13:30:22 -0500
Date: Thu, 7 Mar 2024 13:30:22 -0500
From: Alan Stern <stern@rowland.harvard.edu>
To: Andrea Parri <parri.andrea@gmail.com>
Cc: Kenneth-Lee-2012@foxmail.com, linux-kernel@vger.kernel.org,
  paulmck@kernel.org
Subject: Re: Question about PB rule of LKMM
Message-ID: <bde188b0-1c5b-4b3b-94de-395a52fc37ce@rowland.harvard.edu>
References: <tencent_C5266B7D6F024A916BCA7833FDEA94A74309@qq.com>
 <Zedd18wiAkK68Lzr@andrea>
 <tencent_744E0AF832049C200F96FD6582D5114D7F0A@qq.com>
 <ZeipiSVLR01jmM6b@andrea>
 <e05fa6a9-c810-46cb-b033-b91ae7a5c382@rowland.harvard.edu>
 <ZejC+lutRuwXQrMz@andrea>
 <Zenip+8BDM3p+MUh@andrea>
 <eb8f2a21-d388-424d-8504-ccd7bdb53a93@rowland.harvard.edu>
 <ZeoFBkB1BeTdEQsn@andrea>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZeoFBkB1BeTdEQsn@andrea>

On Thu, Mar 07, 2024 at 07:18:46PM +0100, Andrea Parri wrote:
> > So I guess you're talking about the second, intuitive meaning.  That's 
> > very simple to explain.  Since every instruction executes at _some_ 
> > time, and since we can safely assume that no two instructions execute at 
> > exactly the _same_ time, if F doesn't execute before E then E must 
> > execute before F.  Or using your terms, (not F ->xb E) implies (E ->xb 
> > F).  Would that answer the original question satisfactorily?
> 
> I'd disagree with these premises: certain instructions can and do execute
> at the same time.

Can you give an example?

>  FWIW, in the formal model, it is not that difficult to
> provide examples of "(not F ->xb E) and (not E ->xb F)".

That's because the xb relation in the formal model does not fully 
capture our intuitive notion of "executes at the same time" in the 
informal operational model.

Also, it's important to distinguish between:

(1)	Two instructions that are forced (say by a dependency) or known 
	(say by an rfe link) to execute in a particular order; versus

(2)	Two instructions that may execute in either order but do execute
	in some particular order during a given run of the program.

The formal xb relation corresponds more to (1), whereas the informal 
notion corresponds more to (2).

> > The new text says the same thing as the original, just in a more 
> > condensed way.  It skips the detailed explanation of why E must execute 
> > before W propagates to E's CPU, merely saying that it is because "W is 
> > coherence-later than E".  I'm not sure this is an improvement; the 
> > reader might want to know exactly how this reasoning goes.
> 
> The current text relies on an argument by contradiction.  A contradiction
> is reached by "forcing" (F ->xb E), hence all it can be concluded is that
> (not F ->xb E).  Again, AFAICS, this doesn't match the claim in the text.

That's why I suggested adding an extra sentence to the paragraph (which 
you did not quote in your reply).  That sentence gave a direct argument.

Alan

