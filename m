Return-Path: <linux-kernel+bounces-151079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5854B8AA8CF
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 09:01:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A6381C208C4
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 07:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77E924087F;
	Fri, 19 Apr 2024 07:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="oCh4lCzC"
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3BDA3A1CF;
	Fri, 19 Apr 2024 07:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.134.164.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713510092; cv=none; b=eokUwuJEm3QPTlZ5FGzBtz10f6nJRks9K/9qKiWTfW8CcVMt9kVa4D/2bNc9EyyprCPUZJXFgnHVMeGdSo3s2gRfi2byv6L64i+O2m+szltdpUlBZ4z9uuhlzW1IjZbHYcIVkD3A3UatowrjAdALwP8tlBOPDnjD2qds9dSTZGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713510092; c=relaxed/simple;
	bh=hu5M/GWI+6j5XlPD+m5U1EPsKsY/dPwRT5nX2i3eaNI=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Y1bs3v04ENKt+nbtV3C8d7FLhiKjZJUtwtaS7ciIkVRfsrNzlpVT2v9YA99I5UlKmfQWSyFfsG3BsOFhC2sJEOyzKCRvuOdW5Uqhh58DnrKfkvxufA7h1DZ/ukIjGIG9cOK+/jPQ9OeGzlRonOySy4R3kJuWIhiqWN1bnJZlRfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr; spf=pass smtp.mailfrom=inria.fr; dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b=oCh4lCzC; arc=none smtp.client-ip=192.134.164.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=lZKIvqMY0yDjmj+RCqXjIQ/hqzgZ/plMeZWor4/tnHs=;
  b=oCh4lCzCaB7R0QO/V04lwiVU73U/Zo2jCNbiyE/o/OC+QqodUUY3CPTy
   BH2N4kJIVz14Et7EVqH0NVWjaRr6JlwQ0VzCydDxlB4AltgQCGkB4uabX
   Vc7b+zr2HDtXO/bV4H7uZggCl5IKCUhOWxQ9e61p9P2VTxiZJn3o/J98E
   4=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.07,213,1708383600"; 
   d="scan'208";a="85211701"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2024 09:01:22 +0200
Date: Fri, 19 Apr 2024 09:01:21 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Markus Elfring <Markus.Elfring@web.de>
cc: Julia Lawall <julia.lawall@inria.fr>, 
    Ricardo Ribalda <ribalda@chromium.org>, Denis Efremov <efremov@linux.com>, 
    Nicolas Palix <nicolas.palix@imag.fr>, cocci@inria.fr, 
    kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [cocci] [PATCH] coccinelle: misc: minmax: Suppress reports for
 err returns
In-Reply-To: <f1f47166-00d7-49f3-9b80-34aa7b7b5510@web.de>
Message-ID: <1530259-fe0-eb35-6f8a-58f272adef5@inria.fr>
References: <20240415-minimax-v1-1-5feb20d66a79@chromium.org> <alpine.DEB.2.22.394.2404182255010.3213@hadrien> <f1f47166-00d7-49f3-9b80-34aa7b7b5510@web.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-533158061-1713510082=:3432"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-533158061-1713510082=:3432
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Fri, 19 Apr 2024, Markus Elfring wrote:

> >> Most of the people prefer:
> >>
> >> return ret < 0 ? ret: 0;
> >>
> >> than:
> >>
> >> return min(ret, 0);
> >>
> >> Let's tweak the cocci file to ignore those lines completely.
> …
> > Applied, thanks. (Coccinelle for-6.10 branch).
>
> Was a planned code adjustment published?

There is no "planned code adjustment" if there is no patch.

I can check the dependencies again.

julia

>
>
> …
> >> +++ b/scripts/coccinelle/misc/minmax.cocci
> >> @@ -50,11 +50,26 @@ func(...)
> >>  	...>
> >>  }
> >>
> >> +// Ignore errcode returns.
> >> +@errcode@
> …
> >> -// Don't generate patches for errcode returns.
> >> -@errcode depends on patch@
> …
>
> How does such a change fit to the usability of the coccicheck operation modes
> “context” and “org”?
>
> Should dependencies be reconsidered any more for the desired consistency
> of involved rules for scripts of the semantic patch language?
>
> Regards,
> Markus
>
--8323329-533158061-1713510082=:3432--

