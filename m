Return-Path: <linux-kernel+bounces-166220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 823A48B97AF
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 11:27:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35D291F2737D
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 09:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D19454BE7;
	Thu,  2 May 2024 09:26:30 +0000 (UTC)
Received: from mg.richtek.com (mg.richtek.com [220.130.44.152])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9728854750
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 09:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.130.44.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714641989; cv=none; b=aK/tVrrOsXPBQalgLV+39J02+sQ03Tqygl1OZ2v3nVbn7XvErrOnlP72OQa5OBOn1X+w76/6z/mh/jGP3cfmIwJnWSBDTh1M0wbOC4nSBVCmhvA5ZbVJ3sd5+N2rNmO0QDHBsPp+O7v7kvFnDsGglyXM5153HZqi823ODVkw/+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714641989; c=relaxed/simple;
	bh=zAcc9H0zBpdAD5nv9mhTCmb+aHc9FHHAqMpk3o3+kzM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KRxv1fwB62qtRVTrgGgjkvaJkhw7rVyHUUnjWbkZ8vMGLZPIh+l2+mWti7svczc+POk1OhCatcAGToGhIztxUw3PBzFd5c5Cdg2xI+j7+apcqmKvbEhxvpuPm2JbVJmdl/PGUYbvFZ1caTisqV8qTi0FDFE3bRrIZeEW59HBGhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=richtek.com; spf=pass smtp.mailfrom=richtek.com; arc=none smtp.client-ip=220.130.44.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=richtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=richtek.com
X-MailGates: (SIP:2,PASS,NONE)(compute_score:DELIVER,40,3)
Received: from 192.168.10.46
	by mg.richtek.com with MailGates ESMTPS Server V6.0(3367350:0:AUTH_RELAY)
	(envelope-from <alina_yu@richtek.com>)
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256/256); Thu, 02 May 2024 17:26:15 +0800 (CST)
Received: from ex3.rt.l (192.168.10.46) by ex3.rt.l (192.168.10.46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 2 May 2024
 17:26:14 +0800
Received: from linuxcarl2.richtek.com (192.168.10.154) by ex3.rt.l
 (192.168.10.45) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 2 May 2024 17:26:14 +0800
Date: Thu, 2 May 2024 17:26:14 +0800
From: Alina Yu <alina_yu@richtek.com>
To: Mark Brown <broonie@kernel.org>
CC: <lgirdwood@gmail.com>, <linux-kernel@vger.kernel.org>,
	<johnny_lai@richtek.com>, <cy_huang@richtek.com>
Subject: Re: [PATCH v2 2/4] regulator: rtq2208: Fix LDO to be compatible with
 both fixed and adjustable vout
Message-ID: <20240502092614.GA31518@linuxcarl2.richtek.com>
References: <cover.1714467553.git.alina_yu@richtek.com>
 <ffeecd61c194df1f7f049bd50cb2bbbad3cf1025.1714467553.git.alina_yu@richtek.com>
 <ZjGmmYWHu-ZQQdIh@finisterre.sirena.org.uk>
 <20240502073029.GA4055@linuxcarl2.richtek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240502073029.GA4055@linuxcarl2.richtek.com>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Thu, May 02, 2024 at 03:30:29PM +0800, Alina Yu wrote:
> On Wed, May 01, 2024 at 11:19:05AM +0900, Mark Brown wrote:
> > On Tue, Apr 30, 2024 at 05:58:25PM +0800, Alina Yu wrote:
> > 
> > > In this patch, LDO's adjustable and fixed Vout settings are compatible.
> > > The LDO Vout ability depends on the init_data->constraints.
> > > If adjustable, the Vout can be set to either 1800mV or 3300mV.
> > 
> > > +		if (init_data->constraints.min_uV == init_data->constraints.max_uV) {
> > > +			desc->n_voltages = 1;
> > > +			desc->fixed_uV = init_data->constraints.min_uV;
> > > +			desc->ops = &rtq2208_regulator_ldo_fix_ops;
> > > +		} else {
> > > +			desc->n_voltages = ARRAY_SIZE(rtq2208_ldo_volt_table);
> > > +			desc->volt_table = rtq2208_ldo_volt_table;
> > > +			desc->ops = &rtq2208_regulator_ldo_adj_ops;
> > > +		}
> > 
> > Why are you making this change?  The operations supported by the
> > regulator don't change depending on if the system is going to chnage the
> > voltage.
> 
> The change is necessary due to the requirement of the SD card for high/default and ultra-high-speed modes. The system needs to adjust the LDO Vout accordingly.
> In ultra-high-speed mode, the LDO Vout needs to be adjusted to 1.8V; otherwise, it will remain at 1.8V.
> 
> 

Apologies for the misunderstanding. Let me provide further clarification regarding the LDO Vout.
For the fixed LDO Vout, it will be set to either 0.9V or 1.2V, which are outside the range of 1.8V to 3.3V.
The determination of whether it is fixed or adjustable lies solely with the user.
This modification aims to ensure compatibility with the user's application.


Thanks,
Alina

> 
> 

