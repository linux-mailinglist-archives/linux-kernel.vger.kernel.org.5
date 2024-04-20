Return-Path: <linux-kernel+bounces-152100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B20A58AB91D
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 04:58:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65B411F21D1E
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 02:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB10D8BEE;
	Sat, 20 Apr 2024 02:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d6rI+Szc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1826B625;
	Sat, 20 Apr 2024 02:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713581887; cv=none; b=pOIUNHdhEb58QnRaU9cQYg1Jxu0pY6M+FzqWXtwV57S2ebFLn1bRr8+OwW+yXUqnn0RSANFUu4qtAMIY7/KLNQzSZEAktrs2+BAuJOrF8ixHJIqLIzF5FzU6gQd4NwMcledZCdZ8ocebVCr1rkpt7FrwZ/DZXq4sK1k3zp/h3Og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713581887; c=relaxed/simple;
	bh=dqJCgSGZDVHIYWgOCypPgASUgV3IusHHzpLEV6weCTM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Rsq8IellLXHQqlLKIb2vepSOGKJbsj6qEXkmP+13Bs6DGgcrUaCcGZq4kUYGBXPEyMTYrkDTPl7EujMgdLiebzP4A7RyJk10THXmQ27kko7EaNKnirwtA2jl7T7SQOhkzrYPusWRWXgCBHn4cRJ+6SsG71MPv9x4b0AkGpqcSvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d6rI+Szc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05335C072AA;
	Sat, 20 Apr 2024 02:58:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713581884;
	bh=dqJCgSGZDVHIYWgOCypPgASUgV3IusHHzpLEV6weCTM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=d6rI+Szc4HoW/JpVK43LsiotzkyvpNSswsJGpoSJdOCu4Cd0fhCXFwGdLwc48XbKC
	 619ugF7i2/HeXihWBpA2Krn1l4Pkl77Nt00XEpGF/JyV7ok2pWCSwae6pqTMxDYMw8
	 zoxxUhuEx8KHt1gPtfNc5bIaLAtbwWpyfNgveSHBIdzbNa552tKyR5zNU71NVTHu+O
	 KQuUZtxGsddS3L0mTxgSWGTb5a2ctfRJaZSLQs4ArvEZpVUSGjDP2ZpPz5F4UKj/4I
	 rJkHn3NoQzmQf2e+vHeQQhV8n0pcuG9jtnt1LaNFgW8TYct4UY8AZ6thq8m4kmRsNR
	 wn1Qnbu39rwwQ==
Date: Fri, 19 Apr 2024 19:58:02 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Richard Cochran <richardcochran@gmail.com>
Cc: Mahesh Bandewar <maheshb@google.com>, Netdev <netdev@vger.kernel.org>,
 Linux <linux-kernel@vger.kernel.org>, David Miller <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Thomas
 Gleixner <tglx@linutronix.de>, Arnd Bergmann <arnd@arndb.de>, Sagi Maimon
 <maimon.sagi@gmail.com>, Jonathan Corbet <corbet@lwn.net>, John Stultz
 <jstultz@google.com>, Mahesh Bandewar <mahesh@bandewar.net>
Subject: Re: [PATCHv1 next] ptp: update gettimex64 to provide ts optionally
 in mono-raw base.
Message-ID: <20240419195802.0699dc5b@kernel.org>
In-Reply-To: <ZiIPIKM1rH7J-Pok@hoboy.vegasvil.org>
References: <20240416215942.150202-1-maheshb@google.com>
	<20240417182445.019fb351@kernel.org>
	<ZiIPIKM1rH7J-Pok@hoboy.vegasvil.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 18 Apr 2024 23:28:48 -0700 Richard Cochran wrote:
> On Wed, Apr 17, 2024 at 06:24:45PM -0700, Jakub Kicinski wrote:
> > On Tue, 16 Apr 2024 14:59:42 -0700 Mahesh Bandewar wrote:  
> > >  		if (extoff->n_samples > PTP_MAX_SAMPLES
> > > -		    || extoff->rsv[0] || extoff->rsv[1] || extoff->rsv[2]) {
> > > +		    || extoff->rsv[0] || extoff->rsv[1]
> > > +		    || (extoff->clockid != CLOCK_REALTIME
> > > +			&& extoff->clockid != CLOCK_MONOTONIC_RAW)) {  
> > 
> > Since you're touching this condition it's probably a good opportunity
> > to fox the coding style.  
> 
> What is the CodingStyle violation?
> 
> Is it starting a line with  ||  ?

Yup. Now that it's a mix of || and && the loss of readability 
to a kernel-trained eye starts to be impactful.

