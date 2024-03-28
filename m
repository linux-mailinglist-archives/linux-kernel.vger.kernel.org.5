Return-Path: <linux-kernel+bounces-122846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A846E88FE54
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 12:48:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D9D51F2803E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 11:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFB397E59F;
	Thu, 28 Mar 2024 11:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="S8IJmrEZ"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB6065BAD;
	Thu, 28 Mar 2024 11:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711626473; cv=none; b=f5AsJz5XTohHzFvyBAqzoCwfdzVdw36UT/J5Ntfo2cxJmr1eg2gz9pumfTXGbApDl6SOYj1vqcros3G3mG26g0Qd2K0TZIAgis9emkBU9iGRQCqiY2x8zImF3u8W9svRMoyQP2q+sZ9+BTyeWxbFJezuDds0H8uQusSGSBuGN1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711626473; c=relaxed/simple;
	bh=C5ia7p6FUZ/GW0o5oehcThIhFiuQMOg24e6c5W5XV3I=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Eeqk9kADLEXZTDWvwHyNZVn51vXhhoukvNA2msg+p5VireVI9UPFzRvWmWvO7YXJZ83U9dUTd7IVDPIuBcGkVquWQicF3eL3nhHARK4J14kuz3dJVYn4BKajGjwFjyV+Gi5vl3anhqeytYVUS+poEWBaeetrdprUtFBt2snbT6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=S8IJmrEZ; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 42SBlkrB000717;
	Thu, 28 Mar 2024 06:47:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1711626467;
	bh=pwfnoAJSZcrhbms9HpLufGmoUmKKXf9I0a/VgsGU/QU=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=S8IJmrEZMxtK1bgaK1dX62stY8AVxr4fmhQdLdL5LdaqiGD9RauH5/uNdpIic3TuU
	 NoXopmhFfVjNgaUyBwxDUIDviYCJG+9ooRAD8t/qtDMVwcj/0PGSHVpi9m9PKQKkQZ
	 NsLEfxp5uddc7exdJMMT+KfgmYeq2Hvm080+ig1M=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 42SBlkbT003061
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 28 Mar 2024 06:47:46 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 28
 Mar 2024 06:47:46 -0500
Received: from fllvsmtp7.itg.ti.com (10.64.40.31) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 28 Mar 2024 06:47:46 -0500
Received: from localhost (dhruva.dhcp.ti.com [172.24.227.68])
	by fllvsmtp7.itg.ti.com (8.15.2/8.15.2) with ESMTP id 42SBljLd002673;
	Thu, 28 Mar 2024 06:47:46 -0500
Date: Thu, 28 Mar 2024 17:17:45 +0530
From: Dhruva Gole <d-gole@ti.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Tony Lindgren <tony@atomide.com>, <linux-omap@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <nm@ti.com>, <vigneshr@ti.com>
Subject: Re: [PATCH 2/5] bus: ti-sysc: Add a description and copyrights
Message-ID: <20240328114745.7lpnepkpyyeep2hi@dhruva>
References: <20240327081508.36747-1-tony@atomide.com>
 <20240327081508.36747-3-tony@atomide.com>
 <20240328111907.cknfqe3qpiyeipsp@dhruva>
 <2024032824-suburb-decline-2165@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <2024032824-suburb-decline-2165@gregkh>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On Mar 28, 2024 at 12:36:22 +0100, Greg Kroah-Hartman wrote:
> On Thu, Mar 28, 2024 at 04:49:07PM +0530, Dhruva Gole wrote:
> > On Mar 27, 2024 at 10:15:05 +0200, Tony Lindgren wrote:
> > > The ti-sysc driver is missing coprights and description, let's add
> > > those.
> > > 
> > > Signed-off-by: Tony Lindgren <tony@atomide.com>
> > > ---
> > >  drivers/bus/ti-sysc.c | 11 +++++++++++
> > >  1 file changed, 11 insertions(+)
> > > 
> > > diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
> > > --- a/drivers/bus/ti-sysc.c
> > > +++ b/drivers/bus/ti-sysc.c
> > > @@ -1,6 +1,17 @@
> > >  // SPDX-License-Identifier: GPL-2.0
> > >  /*
> > >   * ti-sysc.c - Texas Instruments sysc interconnect target driver
> > > + *
> > > + * TI SoCs have an interconnect target wrapper IP for many devices. The wrapper
> > > + * IP manages clock gating, resets, and PM capabilities for the connected devices.
> > > + *
> > > + * Copyright (C) 2017-2024 Texas Instruments Incorporated - https://www.ti.com/
> > > + *
> > > + * Many features are based on the earlier omap_hwmod arch code with thanks to all
> > > + * the people who developed and debugged the code over the years:
> > > + *
> > > + * Copyright (C) 2009-2011 Nokia Corporation
> > > + * Copyright (C) 2011-2012 Texas Instruments, Inc.
> > 
> > +Nishant
> > 
> > I am no expert on the copyrights part of it, but who gets copyright from
> > 2012 - 2017?
> 
> If there are no changes in those years, what exactly are you attempting
> to copyright for those years?

Oops, should've checked git log. I think 2017 makes sense then.
However the 2011-2012 copyright format comment still stands.

> 
> Please talk to your corporate copyright lawyers about this.  I'm sure
> there is a class you can take from them to explain all of this.  If not,
> there's a free one online from the Linux Foundation that you might want
> to take instead.

Thanks, will take a look!


-- 
Best regards,
Dhruva Gole <d-gole@ti.com>

