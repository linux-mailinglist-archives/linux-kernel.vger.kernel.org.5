Return-Path: <linux-kernel+bounces-148487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBF708A834E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 14:43:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87B67285D6A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 12:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E480113C837;
	Wed, 17 Apr 2024 12:43:01 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71ABE2747F
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 12:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713357781; cv=none; b=NFrLAfjDgA1SCrAejrrCOJJ/4fTd3tixiZN5RWGVgwqoTTcES8ZUQuu0NBfxW51eZdn1DNYuplxTUrkNyY/bqLYu6sK0FAWfZ/tb06S43m1fIJxZYa0JomNCh1FM1uJ1ocjIsjab+duvQfV5L3QfxJBpfRhN38nj+uHTTuPd4lA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713357781; c=relaxed/simple;
	bh=1a4OEWNLsoI1GtLpWCaTfY3p0UrAFNGR6fvFVjWpP08=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bg5NTR3XwEhY1Hl5TXsozETMbKNujbBKnZ/OHGYYmri/HphUG7HIIzYxLMAuiF6CBDkdhpOD43UI2WydsXZFCHgp1uM3Wdj8VcXUwyFEu8DpqTlxP9HUunzyNEgfY2jclZbAOuTdSXkT+8sTeN4ZwgAvHGVF8tyaeaGwho3oI/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A77FF339;
	Wed, 17 Apr 2024 05:43:26 -0700 (PDT)
Received: from pluto (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D89AE3F738;
	Wed, 17 Apr 2024 05:42:54 -0700 (PDT)
Date: Wed, 17 Apr 2024 13:42:50 +0100
From: Cristian Marussi <cristian.marussi@arm.com>
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	james.quinlan@broadcom.com, f.fainelli@gmail.com,
	vincent.guittot@linaro.org, peng.fan@oss.nxp.com,
	michal.simek@amd.com, quic_sibis@quicinc.com,
	konrad.dybcio@linaro.org, souvik.chakravarty@arm.com
Subject: Re: [PATCH v2 1/2] firmware: arm_scmi: Add support for multiple
 vendors custom protocols
Message-ID: <Zh_Dyi_rJGpW4qZr@pluto>
References: <20240408093052.3801576-1-cristian.marussi@arm.com>
 <20240408093052.3801576-2-cristian.marussi@arm.com>
 <20240417123208.criylj2kvdngoswe@bogus>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240417123208.criylj2kvdngoswe@bogus>

On Wed, Apr 17, 2024 at 01:32:08PM +0100, Sudeep Holla wrote:
> On Mon, Apr 08, 2024 at 10:30:51AM +0100, Cristian Marussi wrote:
> > Add a mechanism to be able to tag vendor protocol modules at compile-time
> > with a vendor/sub_vendor string and an implementation version and then to
> > choose to load, at run-time, only those vendor protocol modules matching
> > as close as possible the vendor/subvendor identification advertised by
> > the SCMI platform server.
> > 
> > In this way, any in-tree existent vendor protocol module can be build and
> > shipped by default in a single kernel image, even when using the same
> > clashing protocol identification numbers, since the SCMI core will take
> > care at run-time to load only the ones pertinent to the running system.
> > 
> > Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> > ---
> >  drivers/firmware/arm_scmi/driver.c    | 165 ++++++++++++++++++++++----
> >  drivers/firmware/arm_scmi/protocols.h |  15 +++
> >  2 files changed, 158 insertions(+), 22 deletions(-)
> > 
> > diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
> > index d0091459a276..aa18202054a5 100644
> > --- a/drivers/firmware/arm_scmi/driver.c
> > +++ b/drivers/firmware/arm_scmi/driver.c
> 
> [...]
> 
> > +static const struct scmi_protocol *
> > +scmi_vendor_protocol_lookup(int protocol_id, char *vendor_id,
> > +			    char *sub_vendor_id, u32 impl_ver)
> > +{
> > +	unsigned long key;
> > +	struct scmi_protocol *proto = NULL;
> > +
> > +	/* Searching for closest match ...*/
> > +	key = scmi_protocol_key_calculate(protocol_id, vendor_id,
> > +					  sub_vendor_id, impl_ver);
> > +	if (key)
> > +		proto = xa_load(&scmi_protocols, key);
> > +
> > +	if (proto)
> > +		return proto;
> > +
> > +	/* Any match on vendor/sub_vendor ? */
> > +	if (impl_ver) {
> > +		key = scmi_protocol_key_calculate(protocol_id, vendor_id,
> > +						  sub_vendor_id, 0);
> > +		if (key)
> > +			proto = xa_load(&scmi_protocols, key);
> > +
> > +		if (proto)
> > +			return proto;
> > +	}
> > +
> > +	/* Any match on just the vendor ? */
> > +	if (sub_vendor_id) {
> > +		key = scmi_protocol_key_calculate(protocol_id, vendor_id,
> > +						  NULL, 0);
> > +		if (key)
> > +			proto = xa_load(&scmi_protocols, key);
> > +	}
> >
> 
> I see a pattern here, can be simplify/compress by something like below ?
> 
> static const struct scmi_protocol *
> __scmi_vendor_protocol_lookup(int protocol_id, char *vendor_id,
> 			      char *sub_vendor_id, u32 impl_ver)
> {
> 	unsigned long key;
> 	struct scmi_protocol *proto = NULL;
> 
> 	key = scmi_protocol_key_calculate(protocol_id, vendor_id,
> 					  sub_vendor_id, impl_ver);
> 	if (key)
> 		proto = xa_load(&scmi_protocols, key);
> 
> 	return proto;
> }

Sure...was not completely sure to proceed that way because only 2 lines
were saved for a each block....bit indeed is more clear...I'll d in V3
> 
> [...]
> 
> > diff --git a/drivers/firmware/arm_scmi/protocols.h b/drivers/firmware/arm_scmi/protocols.h
> > index 317d3fb32676..45ee8b35f56d 100644
> > --- a/drivers/firmware/arm_scmi/protocols.h
> > +++ b/drivers/firmware/arm_scmi/protocols.h
> > @@ -29,6 +29,8 @@
> >  #define PROTOCOL_REV_MAJOR(x)	((u16)(FIELD_GET(PROTOCOL_REV_MAJOR_MASK, (x))))
> >  #define PROTOCOL_REV_MINOR(x)	((u16)(FIELD_GET(PROTOCOL_REV_MINOR_MASK, (x))))
> >  
> > +#define SCMI_PROTOCOL_VENDOR	0x80
> > +
> 
> s/SCMI_PROTOCOL_VENDOR/SCMI_PROTOCOL_VENDOR_BASE/
> 
> as I expect 0x80 to be used by most vendors.
> 

I'll do.

Thanks for the review.
Cristian

