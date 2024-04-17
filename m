Return-Path: <linux-kernel+bounces-148548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71AF88A8442
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 15:21:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EE0E1F23D99
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 13:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4951E13E3EE;
	Wed, 17 Apr 2024 13:21:06 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A362B13E02A
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 13:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713360065; cv=none; b=Rtr52wo+lUB7uw93yN+5IciUSLn1SwF+2hBlTjh1od3wrfLkajhWi37RQ/0sc+kYNQdCyJaF77V2h1QB8/qZQmgVh+0RyZDImNezUo8eVJfk4eTMkLwATjAvi5hz+RP9FK/386o1aPYZGfc+lCY0S00wEz2olIZw7PF6k1fddUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713360065; c=relaxed/simple;
	bh=nETCHB7JIutC8EKJAX2M9aPwQSEYpjvigfPP7Y07kDg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kEQecvYd8NY0v2WH0VMhvs5wta/aophoh/n0HCO+n6yjxjvI5gkZLX8rFbgUo4Gs4xOPVKVV52qVzndW+/wERW7BCrhJw1PTdhsGaUgYQmp1Ir2NWX1gJmJGIXlBj02wcG5o8tNC4G5NgODHwAVkOyCJe2RLDZ9nR4+oXW29u2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B960F339;
	Wed, 17 Apr 2024 06:21:29 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1F7483F738;
	Wed, 17 Apr 2024 06:20:59 -0700 (PDT)
Date: Wed, 17 Apr 2024 14:20:57 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: Cristian Marussi <cristian.marussi@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Sudeep Holla <sudeep.holla@arm.com>, james.quinlan@broadcom.com,
	f.fainelli@gmail.com, vincent.guittot@linaro.org,
	peng.fan@oss.nxp.com, michal.simek@amd.com, quic_sibis@quicinc.com,
	konrad.dybcio@linaro.org, souvik.chakravarty@arm.com
Subject: Re: [PATCH v2 1/2] firmware: arm_scmi: Add support for multiple
 vendors custom protocols
Message-ID: <20240417132057.2s5s2mzgub2nnyd3@bogus>
References: <20240408093052.3801576-1-cristian.marussi@arm.com>
 <20240408093052.3801576-2-cristian.marussi@arm.com>
 <20240417123208.criylj2kvdngoswe@bogus>
 <Zh_Dyi_rJGpW4qZr@pluto>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zh_Dyi_rJGpW4qZr@pluto>

On Wed, Apr 17, 2024 at 01:42:50PM +0100, Cristian Marussi wrote:
> On Wed, Apr 17, 2024 at 01:32:08PM +0100, Sudeep Holla wrote:
> > On Mon, Apr 08, 2024 at 10:30:51AM +0100, Cristian Marussi wrote:
> > > Add a mechanism to be able to tag vendor protocol modules at compile-time
> > > with a vendor/sub_vendor string and an implementation version and then to
> > > choose to load, at run-time, only those vendor protocol modules matching
> > > as close as possible the vendor/subvendor identification advertised by
> > > the SCMI platform server.
> > >
> > > In this way, any in-tree existent vendor protocol module can be build and
> > > shipped by default in a single kernel image, even when using the same
> > > clashing protocol identification numbers, since the SCMI core will take
> > > care at run-time to load only the ones pertinent to the running system.
> > >
> > > Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> > > ---
> > >  drivers/firmware/arm_scmi/driver.c    | 165 ++++++++++++++++++++++----
> > >  drivers/firmware/arm_scmi/protocols.h |  15 +++
> > >  2 files changed, 158 insertions(+), 22 deletions(-)
> > >
> > > diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
> > > index d0091459a276..aa18202054a5 100644
> > > --- a/drivers/firmware/arm_scmi/driver.c
> > > +++ b/drivers/firmware/arm_scmi/driver.c
> >
> > [...]
> >
> > > +static const struct scmi_protocol *
> > > +scmi_vendor_protocol_lookup(int protocol_id, char *vendor_id,
> > > +			    char *sub_vendor_id, u32 impl_ver)
> > > +{
> > > +	unsigned long key;
> > > +	struct scmi_protocol *proto = NULL;
> > > +
> > > +	/* Searching for closest match ...*/
> > > +	key = scmi_protocol_key_calculate(protocol_id, vendor_id,
> > > +					  sub_vendor_id, impl_ver);
> > > +	if (key)
> > > +		proto = xa_load(&scmi_protocols, key);
> > > +
> > > +	if (proto)
> > > +		return proto;
> > > +
> > > +	/* Any match on vendor/sub_vendor ? */
> > > +	if (impl_ver) {
> > > +		key = scmi_protocol_key_calculate(protocol_id, vendor_id,
> > > +						  sub_vendor_id, 0);
> > > +		if (key)
> > > +			proto = xa_load(&scmi_protocols, key);
> > > +
> > > +		if (proto)
> > > +			return proto;
> > > +	}
> > > +
> > > +	/* Any match on just the vendor ? */
> > > +	if (sub_vendor_id) {
> > > +		key = scmi_protocol_key_calculate(protocol_id, vendor_id,
> > > +						  NULL, 0);
> > > +		if (key)
> > > +			proto = xa_load(&scmi_protocols, key);
> > > +	}
> > >
> >
> > I see a pattern here, can be simplify/compress by something like below ?
> >
> > static const struct scmi_protocol *
> > __scmi_vendor_protocol_lookup(int protocol_id, char *vendor_id,
> > 			      char *sub_vendor_id, u32 impl_ver)
> > {
> > 	unsigned long key;
> > 	struct scmi_protocol *proto = NULL;
> >
> > 	key = scmi_protocol_key_calculate(protocol_id, vendor_id,
> > 					  sub_vendor_id, impl_ver);
> > 	if (key)
> > 		proto = xa_load(&scmi_protocols, key);
> >
> > 	return proto;
> > }
>
> Sure...was not completely sure to proceed that way because only 2 lines
> were saved for a each block....bit indeed is more clear...I'll d in V3

Agreed, that's why I was asking rather than requesting you to change 😉.
Even I was not sure by the time I completed writing the above one 😁.
It may make it bit easier to read.

--
Regards,
Sudeep

