Return-Path: <linux-kernel+bounces-97353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F300876955
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 18:08:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 462A2281B88
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 17:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96A5324A06;
	Fri,  8 Mar 2024 17:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="jrWFndom"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 549482420C;
	Fri,  8 Mar 2024 17:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709917701; cv=none; b=jMRRA3MnI7OEsAjeIAaecPG51cvdsl4BXhM0MlS/lf5NI5Oe4lMOIuCHDYxJ3IEfSamjfQ3JNsZj0NyIuYjXXhfUadG8Mdr0u9+FevtSRsKOYy/lLSfGzAoiRhQPw5OV0KOY2CLuNXRsvcWKQ5AyadQMEUf6W3Knewv06Z3qFyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709917701; c=relaxed/simple;
	bh=yjkgaWbfvxOAOJ8/GrcE5ERV6Xdug+DVVLT7XjhOlTk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uPq9rxy8qun47y8VVcJGkH8qVck79FNRw3U5ZbLmB1FHJkjt2qB4HTJVC/alBuBIuk+3xzR//7QwO3WHxhXja5ciwxdYgO4rZ2k2ptp8gDLCrazicNy0K3SUOCXY618pNIysIg74qN51VTnt4h0CZWh2TNvRnC1wyxhSlG1lTiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=jrWFndom; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8CE101BF208;
	Fri,  8 Mar 2024 17:08:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709917690;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SVSOVMM++kpSS7mrO6vPo+8T0YiZCKLh1YcyRU4PU+0=;
	b=jrWFndomKXlOKifh8SJu/xxEkVdtVmr98MEjZ+7hFRthTHJKujWCykaljnvIvOdtm7Dok6
	M5tjTkWxhcWVLR0ib0dwtzRbmM11eEqG5foA9pKwMy/DXOg4uUggHkmFvEaQY100sS/+Bp
	pYaikC+wimyQPKjSNwhgfeVMhVXpOGlVMaVzeT6+bf/kqrKuhov+Afv8A5Gw+uPjZF+ekD
	aAR07y5nHuo2+++FZbpPxmXO5XbPt08sNYX9ChZpYhxl/4TddBcUBnt7CB4XYeBgpboqZN
	OxtD+TGlSCuakbxbSCTP3XXoc69X0TmpYm1qLJ/scQ+Yp+jUu3MY8tnLiY3dfw==
Date: Fri, 8 Mar 2024 18:08:10 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Nicholas Miehlbradt <nicholas@linux.ibm.com>
Cc: a.zummo@towertech.it, linux-rtc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rtc: fix uninitialized read of rtc_wkalrm.time
Message-ID: <2024030817081059be4ef2@mail.local>
References: <20231129073647.2624497-1-nicholas@linux.ibm.com>
 <20240229215850a1990100@mail.local>
 <66a2c8b3-b1e8-4d2c-8a19-09e62099a2d7@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66a2c8b3-b1e8-4d2c-8a19-09e62099a2d7@linux.ibm.com>
X-GND-Sasl: alexandre.belloni@bootlin.com

On 08/03/2024 11:53:13+1100, Nicholas Miehlbradt wrote:
> 
> 
> On 1/3/2024 8:58 am, Alexandre Belloni wrote:
> > Hello,
> > 
> > On 29/11/2023 07:36:47+0000, Nicholas Miehlbradt wrote:
> > > If either of the first two branches of the if statement in
> > > rtc_read_alarm_internal are taken the fields of alarm->time are not
> > > initialized but are subsequently read by the call to rtc_tm_to_time64.
> > > 
> > > Refactor so that the time field is only read if the final branch of the
> > > if statment which initializes the field is taken.
> > > 
> > 
> > While the problem description is correct, the solution is not because
> > you have no guarantee that the fields have been initialized if
> > ->read_alarm returns a value different from 0
> > 
> > So, instead of avoiding the conversion unless the final branch is taken,
> > it should be avoided as long as err != 0.
> > 
> > But, I'm also wondering whether there is actually an issue. mktime64
> > can be fed whatever value without bugging out and the value of err will
> > be part of the trace so userspace knows that it shouldn't trust the
> > value.
> > 
> > So, what is the actual issue? :)
> 
> Thank you for your feedback.
> I found this issue during my implementation of KMSAN for powerpc. The goal
> with this patch is to eliminate use of undefined memory which leads to
> undefined behaviour, I should have made this more clear in my original
> message. You can find the KMSAN patch series here:
> https://lore.kernel.org/linuxppc-dev/20231214055539.9420-1-nicholas@linux.ibm.com/
> 
> I can make the changes suggested and fold this patch into the next version
> of my KMSAN series if that would help to add context as to why I am
> submitting this patch?

Please do but I must say I don't really like "defensive" programming
just to please a static checker. There is no actual issue here, even if
the memory is not initialized, the result will never be incorrect and
the various checks that are being added everywhere are just bloating the
kernel, making it slower to boot and run. Now, we even have useless CVEs
that are assigned for this kind of issues...

Maybe it would be better to ensure the correctness of the result rather
than having a look at whether the memory was initialized or not.

> > 
> > > Signed-off-by: Nicholas Miehlbradt <nicholas@linux.ibm.com>
> > > ---
> > >   drivers/rtc/interface.c | 4 +++-
> > >   1 file changed, 3 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/rtc/interface.c b/drivers/rtc/interface.c
> > > index 1b63111cdda2..f40e76d2fe2b 100644
> > > --- a/drivers/rtc/interface.c
> > > +++ b/drivers/rtc/interface.c
> > > @@ -179,6 +179,7 @@ static int rtc_read_alarm_internal(struct rtc_device *rtc,
> > >   				   struct rtc_wkalrm *alarm)
> > >   {
> > >   	int err;
> > > +	time64_t trace_time = -1;
> > >   	err = mutex_lock_interruptible(&rtc->ops_lock);
> > >   	if (err)
> > > @@ -201,11 +202,12 @@ static int rtc_read_alarm_internal(struct rtc_device *rtc,
> > >   		alarm->time.tm_yday = -1;
> > >   		alarm->time.tm_isdst = -1;
> > >   		err = rtc->ops->read_alarm(rtc->dev.parent, alarm);
> > > +		trace_time = rtc_tm_to_time64(&alarm->time);
> > >   	}
> > >   	mutex_unlock(&rtc->ops_lock);
> > > -	trace_rtc_read_alarm(rtc_tm_to_time64(&alarm->time), err);
> > > +	trace_rtc_read_alarm(trace_time, err);
> > >   	return err;
> > >   }
> > > -- 
> > > 2.37.2
> > > 
> > 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

