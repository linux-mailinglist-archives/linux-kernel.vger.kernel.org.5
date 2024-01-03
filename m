Return-Path: <linux-kernel+bounces-15019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B2E2822640
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 02:05:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27443B228FF
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 01:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EA06A57;
	Wed,  3 Jan 2024 01:05:29 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mg.richtek.com (mg.richtek.com [220.130.44.152])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54AD91848;
	Wed,  3 Jan 2024 01:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=richtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=richtek.com
X-MailGates: (SIP:2,PASS,NONE)(compute_score:DELIVER,40,3)
Received: from 192.168.10.47
	by mg.richtek.com with MailGates ESMTPS Server V6.0(636810:0:AUTH_RELAY)
	(envelope-from <cy_huang@richtek.com>)
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256/256); Wed, 03 Jan 2024 09:04:52 +0800 (CST)
Received: from ex3.rt.l (192.168.10.46) by ex4.rt.l (192.168.10.47) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.27; Wed, 3 Jan
 2024 09:04:52 +0800
Received: from linuxcarl2.richtek.com (192.168.10.154) by ex3.rt.l
 (192.168.10.45) with Microsoft SMTP Server id 15.2.1258.27 via Frontend
 Transport; Wed, 3 Jan 2024 09:04:52 +0800
Date: Wed, 3 Jan 2024 09:04:52 +0800
From: ChiYuan Huang <cy_huang@richtek.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
	<conor+dt@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Rob Herring
	<robh+dt@kernel.org>, Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>, <linux-iio@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] iio: adc: rtq6056: Add support for the whole
 RTQ6056 family
Message-ID: <20240103010452.GA6655@linuxcarl2.richtek.com>
References: <cover.1703762557.git.cy_huang@richtek.com>
 <74db15583a9a68701dbff5a1a967c0d987d6dfb6.1703762557.git.cy_huang@richtek.com>
 <20231230120347.0816bd09@jic23-huawei>
 <20240102083042.GA13611@linuxcarl2.richtek.com>
 <20240102193642.0d6d2007@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240102193642.0d6d2007@jic23-huawei>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Tue, Jan 02, 2024 at 07:36:42PM +0000, Jonathan Cameron wrote:
> On Tue, 2 Jan 2024 16:30:42 +0800
> ChiYuan Huang <cy_huang@richtek.com> wrote:
> 
> > Hi, Johathan:
> > 
> > Most comments are good and will be fixed in next revision.
> > 
> > Still one comment I cannot make sure.
> > 
> > Please see the comment that's below yours.
> > 	
> Hi ChiYuan,
> 
> It's good practice to crop away all the parts where the discussion is finished.
> Makes it easier for people to find the bit you want discussion to continue on!
> 
> I've done so in this reply.
> 
> ...
> > > > +
> > > >  enum {
> > > >  	RTQ6056_CH_VSHUNT = 0,
> > > >  	RTQ6056_CH_VBUS,
> > > > @@ -50,16 +60,29 @@ enum {
> > > >  enum {
> > > >  	F_OPMODE = 0,
> > > >  	F_VSHUNTCT,
> > > > +	F_SADC = F_VSHUNTCT,  
> > > 
> > > If the devices have different register fields, better to have different enums
> > > for them as well as that should result in less confusing code.
> > >   
> > Actually, this is all the same register, just the control naming difference.
> > If not to define the new eum, I can remain to use the same field to handle rtq6059 part.
> 
> If the bits in the register control the same thing across both parts then
> add a comment alongside the enum to make that clear. 
> 
> Given the naming that seems very unlikely.  PGA and AVG would eman
> very different things to me for starters (oversampling vs a programmble
> gain amplifier on the front end)
> 
I'm also thinking how to write this difference like as comments or a seperate enum.
But if to define a new enum, many function about the regfield controls must be seperated
for 6056 and 6059.
> > >   
> > > >  	F_VBUSCT,
> > > > +	F_BADC = F_VBUSCT,
> > > >  	F_AVG,
> > > > +	F_PGA = F_AVG,
> > > >  	F_RESET,
> > > >  	F_MAX_FIELDS
> > > >  };

What if to keep the original coding, just to rename the different part like as below
F_SADC -> F_RTQ6059_SDAC
F_BADC -> F_RTQ6059_BADC
F_PGA -> F_RTQ6059_PGA

At least, the nameing already shows the difference between 6056 and 6059.
Only these three parts are different, others are the same like as F_OPMODE, F_RESET.


