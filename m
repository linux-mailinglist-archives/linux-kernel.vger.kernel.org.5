Return-Path: <linux-kernel+bounces-138163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B80989ED82
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 10:24:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC02B1C20B21
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 08:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB17B13D605;
	Wed, 10 Apr 2024 08:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uylqAdnI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0537E13CFA1;
	Wed, 10 Apr 2024 08:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712737481; cv=none; b=eRju3rEnOmO7Ai2tEWlAJzK9QzNdWQ+W3os60/lANWsHkZmwd41LKVQhjymma1e0RJnGZFPCLoMR81jqLplsLGE4daim0U8WUy8gY8DEB4huWM/Kwg6Sjp3YLMBXqaqIyfEga2XPA1TgmM7W0FP66fHDLG1k/Za0+oRSI1vb1h4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712737481; c=relaxed/simple;
	bh=kHw62uWAIH9xVgzosFJdAHEiAM9foucIVnPx0iW+bEk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hsViYueoKZxLPHv1xrN6P+LnEhOn2Kh5FWsdi/Sz1x2kugpVKMJ6m2Yauwfz0VncdHZ/mT9XKcxe+mmYWFbypi2SJ4VDAiDOyaeZD8sMf6G7rdg3rMQfjPsiQfDY3ZMbyyWTvgU9VOncCQ79yJBo+SbqC6EmFHEbMaMoSJqEkAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uylqAdnI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC710C433C7;
	Wed, 10 Apr 2024 08:24:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712737480;
	bh=kHw62uWAIH9xVgzosFJdAHEiAM9foucIVnPx0iW+bEk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uylqAdnIIwZqjIaaS86WJ3YQSmqVYxMIAWLIMPG5xNLG8NrPCeZw1zm1jIzR5vKsL
	 /Y4oYPGk2/TiofuPBM7m2TdHICVpdGkS0mV9v73j4DDk6/JCJEzObRVMCZ1gEQQnbU
	 7EmGb8RRTa0mMAw2WGdDW1m7LRFPg/hyDb/8SnOY=
Date: Wed, 10 Apr 2024 10:24:36 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Liuye <liu.yeC@h3c.com>
Cc: "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
	"daniel.thompson@linaro.org" <daniel.thompson@linaro.org>,
	"dianders@chromium.org" <dianders@chromium.org>,
	"jason.wessel@windriver.com" <jason.wessel@windriver.com>,
	"jirislaby@kernel.org" <jirislaby@kernel.org>,
	"kgdb-bugreport@lists.sourceforge.net" <kgdb-bugreport@lists.sourceforge.net>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
Subject: Re: =?utf-8?B?562U5aSNOiDnrZTlpI06IOetlA==?= =?utf-8?B?5aSN?=
 =?utf-8?Q?=3A?= [PATCH V10] kdb: Fix the deadlock issue in KDB debugging.
Message-ID: <2024041007-busload-equipment-b673@gregkh>
References: <20240409020326.2125332-1-liu.yec@h3c.com>
 <20240410020615.2885000-1-liu.yec@h3c.com>
 <2024041014-padlock-aggregate-4705@gregkh>
 <0c004dd44ad5478eba9451186f4ec962@h3c.com>
 <2024041001-retaliate-cork-1fe5@gregkh>
 <5c659d5f41ff4cf69ea9467b62d74e9b@h3c.com>
 <2024041022-electable-unblock-5077@gregkh>
 <567857bab013409ca53fa7c36292f4b0@h3c.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <567857bab013409ca53fa7c36292f4b0@h3c.com>

On Wed, Apr 10, 2024 at 06:30:59AM +0000, Liuye wrote:
> >On Wed, Apr 10, 2024 at 06:10:10AM +0000, Liuye wrote:
> >> >On Wed, Apr 10, 2024 at 05:54:08AM +0000, Liuye wrote:
> >> >> >> Signed-off-by: Greg KH <gregkh@linuxfoundation.org>
> >> >> >
> >> >> >I have NOT signed off on this commit.  You just said that I made a legal statement about this commit without that actually being true???
> >> >> >
> >> >> >Sorry, but that is flat out not acceptable at all.  Please go work with your company lawyers to figure out what you did and come back with an explaination of exactly what this is and how it will not happen again.
> >> >> >
> >> >> 
> >> >> >> Signed-off-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> >> >> >
> >> >> >> V9 -> V10 : Add Signed-off-by of Greg KH and Andy Shevchenko, 
> >> >> >> Acked-by of Daniel Thompson
> >> >> >
> >> >> >Huh?!
> >> >> 
> >> >> @greg k-h ：
> >> >> @Andy Shevchenko ：
> >> >> 
> >> >> Sorry, it was my mistake. I misunderstood the meaning of "signed-off-by", which led to usage issues.
> >> >> 
> >> >> I want to express my gratitude for the suggestions on the patch from the two of you. 
> >> >> 
> >> >> What do I need to do now? Release PATCH V11 and delete these two signatures in it ?
> >> >
> >> >As I said, go work with your corporate lawyers on this to understand what just happened and have them let us know how it will not happen again.
> >> 
> >> I'm very sorry, this is my first time submitting a patch and I made a significant mistake in using "Signed-off-by". I now understand the meaning of this field and will not make the same mistake again in the future.
> >
> >Understood, but you still need to go work with your corporate legal group so that you all ensure this does not happen again for any other developer in your company, as I am sure they will want to know about this.
> 
> Ok, I will report this to the company. At the same time, I will add an audit mechanism to the patch submission process. Thanks again for your reminder.
> 
> I will remove this part in PATCH V11.

No, you will need to do this before we can accept your change.  And some
sort of verification that this is now in place properly for obvious
reasons.

thanks,

greg k-h

