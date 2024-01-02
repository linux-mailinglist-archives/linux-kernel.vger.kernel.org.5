Return-Path: <linux-kernel+bounces-14780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9227D822231
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 20:37:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33388B228C5
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 19:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DECC16424;
	Tue,  2 Jan 2024 19:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YCcgOUG9"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A06A9168C6;
	Tue,  2 Jan 2024 19:36:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2086C433C9;
	Tue,  2 Jan 2024 19:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704224209;
	bh=z8L6/wjAuu1+co/0Y9paPzHusZ2E1Wm88BUIn8iOkng=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YCcgOUG9FFTHAfHaTStXjGyDLn86yKRSwvs4aF2tLvPfQVKG2uafvJulh9b2g1bZT
	 uXSPuuxAdCEYTGHJDKHAIA3ItahYgX/LVm2zocLxOoCHBV/iOJVX45wqLWb8kIGTUw
	 2GcLj3PC4eDYBfhfci+6k1aZBA8J8emVKISe43bhRQEqVdOT7niFKXq5hkEl2vBxrs
	 6XGmURBRRBzzXi2sRF9LUqhXPy3jDBbrhw+dBRRke++Imv+JeH1jKvEFYaeioo2Ny1
	 pIUV+oK1/S0vR5trWVr8HM1de6V+wIsPpzy8RRVyBFgCgql1BMG4NCyUO8XHKblQQ9
	 IjaxC52L9OZzQ==
Date: Tue, 2 Jan 2024 19:36:42 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: ChiYuan Huang <cy_huang@richtek.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Rob Herring
 <robh+dt@kernel.org>, Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?=
 <u.kleine-koenig@pengutronix.de>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] iio: adc: rtq6056: Add support for the whole
 RTQ6056 family
Message-ID: <20240102193642.0d6d2007@jic23-huawei>
In-Reply-To: <20240102083042.GA13611@linuxcarl2.richtek.com>
References: <cover.1703762557.git.cy_huang@richtek.com>
	<74db15583a9a68701dbff5a1a967c0d987d6dfb6.1703762557.git.cy_huang@richtek.com>
	<20231230120347.0816bd09@jic23-huawei>
	<20240102083042.GA13611@linuxcarl2.richtek.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 2 Jan 2024 16:30:42 +0800
ChiYuan Huang <cy_huang@richtek.com> wrote:

> Hi, Johathan:
> 
> Most comments are good and will be fixed in next revision.
> 
> Still one comment I cannot make sure.
> 
> Please see the comment that's below yours.
> 	
Hi ChiYuan,

It's good practice to crop away all the parts where the discussion is finished.
Makes it easier for people to find the bit you want discussion to continue on!

I've done so in this reply.

...
> > > +
> > >  enum {
> > >  	RTQ6056_CH_VSHUNT = 0,
> > >  	RTQ6056_CH_VBUS,
> > > @@ -50,16 +60,29 @@ enum {
> > >  enum {
> > >  	F_OPMODE = 0,
> > >  	F_VSHUNTCT,
> > > +	F_SADC = F_VSHUNTCT,  
> > 
> > If the devices have different register fields, better to have different enums
> > for them as well as that should result in less confusing code.
> >   
> Actually, this is all the same register, just the control naming difference.
> If not to define the new eum, I can remain to use the same field to handle rtq6059 part.

If the bits in the register control the same thing across both parts then
add a comment alongside the enum to make that clear. 

Given the naming that seems very unlikely.  PGA and AVG would eman
very different things to me for starters (oversampling vs a programmble
gain amplifier on the front end)

> >   
> > >  	F_VBUSCT,
> > > +	F_BADC = F_VBUSCT,
> > >  	F_AVG,
> > > +	F_PGA = F_AVG,
> > >  	F_RESET,
> > >  	F_MAX_FIELDS
> > >  };

