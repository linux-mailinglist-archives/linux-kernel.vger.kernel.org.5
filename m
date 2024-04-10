Return-Path: <linux-kernel+bounces-137952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89DE789EA3C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 07:59:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45471283692
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 05:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A49501CD22;
	Wed, 10 Apr 2024 05:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nYKgVMAM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD7B9171BA;
	Wed, 10 Apr 2024 05:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712728777; cv=none; b=rQAPUsnOeDIk74/N/n/50qNE+B4xm/jcrhQ1GsvZoyJb/t+TlsJfk0OStBbRpaOYFbL0MID2AyY0uGrUN4jC54OMg/UwzlzE3IObO5l+HcKo6n2cQf3pG8PDtY7UTcRH0d+RI2er2JSEs58Xv2Od08Oep4KSsF1mlvWmgpnF3UM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712728777; c=relaxed/simple;
	bh=ukxMVPAJ/AkosAmnVzWG0as7OY6SvL0J05596JAPvK4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jU9a94cE5NUMzNOgWPbeF2OSBYVxYZpC6WSzS/O3Z9acCmC5xZ2qaap8SzrqW91oLFpV3wMKrYAnIy6A2FDYgZgo5m1z7ceBuqTf9m3aW8cYpeesRzkwEEWdXD8lcn+Vn5f/ttCOybA9c0hZ7OPxMk1Rd/gees4RneGsTsGA/kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nYKgVMAM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D509BC433C7;
	Wed, 10 Apr 2024 05:59:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712728776;
	bh=ukxMVPAJ/AkosAmnVzWG0as7OY6SvL0J05596JAPvK4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nYKgVMAMlBfHB848hHBR7S+eB8r3weqJvCRq33/TTgMMD93HCsm9//plbMy5w02Yd
	 SfNmkOhq+JO6iYOFZfNvAHmz97Tg2feCLTVbibUZrE4zyil3vQCNN61cG+sWMUnhmT
	 UETYje6KKLFzTGGbdhaN9wVt5uwdbK59i0S8jiO0=
Date: Wed, 10 Apr 2024 07:59:32 +0200
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
Subject: Re: =?utf-8?B?562U5aSN?= =?utf-8?Q?=3A?= [PATCH V10] kdb: Fix the
 deadlock issue in KDB debugging.
Message-ID: <2024041001-retaliate-cork-1fe5@gregkh>
References: <20240409020326.2125332-1-liu.yec@h3c.com>
 <20240410020615.2885000-1-liu.yec@h3c.com>
 <2024041014-padlock-aggregate-4705@gregkh>
 <0c004dd44ad5478eba9451186f4ec962@h3c.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0c004dd44ad5478eba9451186f4ec962@h3c.com>

On Wed, Apr 10, 2024 at 05:54:08AM +0000, Liuye wrote:
> >> Signed-off-by: Greg KH <gregkh@linuxfoundation.org>
> >
> >I have NOT signed off on this commit.  You just said that I made a legal statement about this commit without that actually being true???
> >
> >Sorry, but that is flat out not acceptable at all.  Please go work with your company lawyers to figure out what you did and come back with an explaination of exactly what this is and how it will not happen again.
> >
> 
> >> Signed-off-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> >
> >> V9 -> V10 : Add Signed-off-by of Greg KH and Andy Shevchenko, Acked-by 
> >> of Daniel Thompson
> >
> >Huh?!
> 
> @greg k-h ：
> @Andy Shevchenko ：
> 
> Sorry, it was my mistake. I misunderstood the meaning of "signed-off-by", which led to usage issues.
> 
> I want to express my gratitude for the suggestions on the patch from the two of you. 
> 
> What do I need to do now? Release PATCH V11 and delete these two signatures in it ?

As I said, go work with your corporate lawyers on this to understand
what just happened and have them let us know how it will not happen
again.

thanks,

greg k-h

