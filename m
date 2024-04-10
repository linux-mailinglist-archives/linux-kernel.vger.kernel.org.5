Return-Path: <linux-kernel+bounces-137971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B4C289EA94
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 08:15:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCFC71C22B4A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 06:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B95E2BB06;
	Wed, 10 Apr 2024 06:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2qyXSC6M"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5184320309;
	Wed, 10 Apr 2024 06:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712729710; cv=none; b=SYcSaCva/mLZMyilIDpSNXXxjD66d8HUpmM7flB+s5YsLediLsuf4FWWanU+ufug5nN3ysyndX9JWZGvdaJ3zuX2KQ+HbzjrDY8QhJeD1hG8DjHwF5HBC7O6klwX1JqXG5gMmleZuRkUOhXwyota9isLAb3VtFhzHJWmb7M/xzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712729710; c=relaxed/simple;
	bh=i1SI/KN3r0p/TBOv27r40IHabpQWrtHclXTYWM4E3BM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V7yNiOmMrLNecIOpF+BPtVKZxjDbPDseB2aZVTtu9/lXMDrcgSk00c7sF2nsA7kpB9LrepvCOBo3VvGKfCdjYha5qeGFwUQSDUSNaS60eEKHp+9HqzpsQRXbuGc3LHaTxld9w0D+ii4ajvCtnseWE7SXJEu/MTWl+et8ovZvcBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2qyXSC6M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86D73C433F1;
	Wed, 10 Apr 2024 06:15:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712729709;
	bh=i1SI/KN3r0p/TBOv27r40IHabpQWrtHclXTYWM4E3BM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=2qyXSC6McdQ9greAT8ipTCHr/xjY5kNOSrkhCcTAB0tO8Iu+MCPnF8Xme6UFJzkFb
	 qE+lhgiFkbOj2fMQzIFAcwuUj1piXYWnm624l37L0x5PUN6sh2Dgm0REQRWkvedtot
	 yOvaw/gT7LNBgG0nS0SE30A5vm8DM1ORmJXFxMlg=
Date: Wed, 10 Apr 2024 08:15:06 +0200
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
Subject: Re: =?utf-8?B?562U5aSNOiDnrZTlpI0=?= =?utf-8?Q?=3A?= [PATCH V10]
 kdb: Fix the deadlock issue in KDB debugging.
Message-ID: <2024041022-electable-unblock-5077@gregkh>
References: <20240409020326.2125332-1-liu.yec@h3c.com>
 <20240410020615.2885000-1-liu.yec@h3c.com>
 <2024041014-padlock-aggregate-4705@gregkh>
 <0c004dd44ad5478eba9451186f4ec962@h3c.com>
 <2024041001-retaliate-cork-1fe5@gregkh>
 <5c659d5f41ff4cf69ea9467b62d74e9b@h3c.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5c659d5f41ff4cf69ea9467b62d74e9b@h3c.com>

On Wed, Apr 10, 2024 at 06:10:10AM +0000, Liuye wrote:
> >On Wed, Apr 10, 2024 at 05:54:08AM +0000, Liuye wrote:
> >> >> Signed-off-by: Greg KH <gregkh@linuxfoundation.org>
> >> >
> >> >I have NOT signed off on this commit.  You just said that I made a legal statement about this commit without that actually being true???
> >> >
> >> >Sorry, but that is flat out not acceptable at all.  Please go work with your company lawyers to figure out what you did and come back with an explaination of exactly what this is and how it will not happen again.
> >> >
> >> 
> >> >> Signed-off-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> >> >
> >> >> V9 -> V10 : Add Signed-off-by of Greg KH and Andy Shevchenko, 
> >> >> Acked-by of Daniel Thompson
> >> >
> >> >Huh?!
> >> 
> >> @greg k-h ：
> >> @Andy Shevchenko ：
> >> 
> >> Sorry, it was my mistake. I misunderstood the meaning of "signed-off-by", which led to usage issues.
> >> 
> >> I want to express my gratitude for the suggestions on the patch from the two of you. 
> >> 
> >> What do I need to do now? Release PATCH V11 and delete these two signatures in it ?
> >
> >As I said, go work with your corporate lawyers on this to understand what just happened and have them let us know how it will not happen again.
> 
> I'm very sorry, this is my first time submitting a patch and I made a significant mistake in using "Signed-off-by". I now understand the meaning of this field and will not make the same mistake again in the future.

Understood, but you still need to go work with your corporate legal
group so that you all ensure this does not happen again for any other
developer in your company, as I am sure they will want to know about
this.

thanks,

greg k-h

