Return-Path: <linux-kernel+bounces-85423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 43E2886B5B6
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 18:18:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A32DB26C8C
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 17:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B7983FBB9;
	Wed, 28 Feb 2024 17:18:30 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2379F6EEEA
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 17:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709140709; cv=none; b=dEGzkBWEhEYQTUI555h1hko/hXPib1FZfjRWrQphwtyoB6rd1cxfQHfd5G5v6qcGyeNcw4uSABXoIDb7YxxVZLkx2hso0rW+I7409x0bEt95euSx+pRGFjlSVYBbhvgz53qinS0K+zkfiRaFNRKLqNNOmV01a4l2Nq+sGrde05c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709140709; c=relaxed/simple;
	bh=ljhwA1ICnCinSxb5yXpCuDklCJzPCxRlTCXJeQUydjE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tr2yALOvfEbm9YpKMvOg+PNQKhqpqT5IUIqeDj++Y0K6pyptcz9x5AgvcqfarbsIQBN9WDdMlVRdHVO3BLVr6KG0cHwVLIQD7ONIyPmyb1HqzYJE454sz4MGGA0F9B0u+gAPeE6yUTFKpVXRi4W30/OAu8qn20KLbHl0rZxMVHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0208EC15;
	Wed, 28 Feb 2024 09:18:58 -0800 (PST)
Received: from pluto (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E3A8E3F762;
	Wed, 28 Feb 2024 09:18:15 -0800 (PST)
Date: Wed, 28 Feb 2024 17:18:13 +0000
From: Cristian Marussi <cristian.marussi@arm.com>
To: Sibi Sankar <quic_sibis@quicinc.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	sudeep.holla@arm.com, james.quinlan@broadcom.com,
	f.fainelli@gmail.com, vincent.guittot@linaro.org,
	peng.fan@oss.nxp.com, michal.simek@amd.com, quic_nkela@quicinc.com,
	souvik.chakravarty@arm.com
Subject: Re: [PATCH] firmware: arm_scmi: Add support for multiple vendors
 custom protocols
Message-ID: <Zd9q1c7kAtQesf8F@pluto>
References: <20240221220426.1205146-1-cristian.marussi@arm.com>
 <4fa47411-225d-e8cd-c5c7-79ac2de2f52d@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4fa47411-225d-e8cd-c5c7-79ac2de2f52d@quicinc.com>

On Wed, Feb 28, 2024 at 10:36:43PM +0530, Sibi Sankar wrote:
> 
> 
> On 2/22/24 03:34, Cristian Marussi wrote:
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
> 
> Cristian,
> 
> Thanks for the patch.
> 
> 
> > ---
> > Hi all,
> > 
> > this is meant to address the possibility of having multiple vendors
> > implementing distinct SCMI vendor protocols with possibly the same
> > overlapping protocol number without the need of crafting the Kconfig
> > at compile time to include only wanted protos
> > (and without the need for a lottery :P)
> > 
> > Basic idea is simple:
> > 
> > - vendor protos HAS to be 'tagged' at build time with a vendor_id
> > - vendor protos COULD also optionally be tagged at build time with
> > sub_vendor_id and implemetation version
> > 
> > - at init all the build vendor protos are registerd with the SCMI core
> >    using a key derived from the above tags
> > 
> > - at SCMI probe time the platform is identified via Base protocol as
> >    usual and all the required vendor protos (i.e. IDs defined in the DT
> >    as usual) are loaded after a lookup process based on the following rules:
> > 
> >    + protocol DB is searched using the platform/Base runtime provided tags
> > 
> >    	<vendor> / <sub_vendor> / <impl_ver>
> > 
> >      using the the following search logic (keys), first match:
> > 
> >       1. proto_id / <vendor_id> / <sub_vendor_id> / <impl_ver>
> > 
> >       2. proto_id / <vendor_id> / <sub_vendor_id> / 0
> > 
> >       3. proto_id / <vendor_id> / NULL / 0
> > 
> >    IOW, closest match, depending on how much fine grained is your
> >    protocol tuned (tagged) for the platform.
> > 
> >    I am doubtful about the usage of <impl_ver>, and tempted to drop it
> >    since we have anyway protocol version and NEGOTIATE_PROTOCOL_VERSION
> >    to deal with slight difference in fw revision...
> > 
> > Based on sudeep/for-linux-next on top of
> > 
> > 	1c2c88cfcb2b ("clk: scmi: Support get/set duty_cycle operations")
> > 
> > Minimally tested ....
> > 
> >    Any feedback welcome
> > 
> >    Thanks,
> >    Cristian
> > ---
> >   drivers/firmware/arm_scmi/driver.c    | 166 ++++++++++++++++++++++----
> >   drivers/firmware/arm_scmi/protocols.h |   5 +
> >   2 files changed, 149 insertions(+), 22 deletions(-)
> > 
> > diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
> > index 34d77802c990..8fb2903698c9 100644
> > --- a/drivers/firmware/arm_scmi/driver.c
> > +++ b/drivers/firmware/arm_scmi/driver.c
> > @@ -33,6 +33,7 @@
> >   #include <linux/processor.h>
> >   #include <linux/refcount.h>
> >   #include <linux/slab.h>
> > +#include <linux/xarray.h>
> >   #include "common.h"
> >   #include "notify.h"
> > @@ -44,8 +45,7 @@
> >   static DEFINE_IDA(scmi_id);
> > -static DEFINE_IDR(scmi_protocols);
> > -static DEFINE_SPINLOCK(protocol_lock);
> > +static DEFINE_XARRAY(scmi_protocols);
> >   /* List of all SCMI devices active in system */
> >   static LIST_HEAD(scmi_list);
> > @@ -194,11 +194,90 @@ struct scmi_info {
> >   #define bus_nb_to_scmi_info(nb)	container_of(nb, struct scmi_info, bus_nb)
> >   #define req_nb_to_scmi_info(nb)	container_of(nb, struct scmi_info, dev_req_nb)
> > -static const struct scmi_protocol *scmi_protocol_get(int protocol_id)
> > +static unsigned long
> > +scmi_vendor_protocol_signature(unsigned protocol_id, char *vendor_id,
> > +			       char *sub_vendor_id, u32 impl_ver)
> >   {
> > -	const struct scmi_protocol *proto;
> > +	char *signature, *p;
> > +	unsigned long hash = 0;
> > -	proto = idr_find(&scmi_protocols, protocol_id);
> > +	/* vendor_id/sub_vendor_id guaranteed <= SCMI_SHORT_NAME_MAX_SIZE */
> > +	signature = kasprintf(GFP_KERNEL, "%02X|%s|%s|0x%08X", protocol_id,
> > +			      vendor_id ?: "", sub_vendor_id ?: "", impl_ver);
> > +	if (!signature)
> > +		return 0;
> > +
> > +	p = signature;
> > +	while (*p)
> > +		hash = partial_name_hash(tolower(*p++), hash);
> > +	hash = end_name_hash(hash);
> > +
> > +	kfree(signature);
> > +
> > +	return hash;
> > +}
> > +
> > +static unsigned long
> > +scmi_protocol_key_calculate(int protocol_id, char *vendor_id,
> > +			    char *sub_vendor_id, u32 impl_ver)
> > +{
> > +	if (protocol_id < SCMI_PROTOCOL_VENDOR)
> > +		return protocol_id;
> > +	else
> > +		return scmi_vendor_protocol_signature(protocol_id, vendor_id,
> > +						      sub_vendor_id, impl_ver);
> > +}
> > +
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
> > +
> > +	return proto;
> > +}
> > +
> > +static const struct scmi_protocol *
> > +scmi_protocol_get(int protocol_id, struct scmi_revision_info *version)
> > +{
> > +	const struct scmi_protocol *proto = NULL;
> > +
> > +	if (protocol_id < SCMI_PROTOCOL_VENDOR)
> > +		proto = xa_load(&scmi_protocols, protocol_id);
> > +	else
> > +		proto = scmi_vendor_protocol_lookup(protocol_id,
> > +						    version->vendor_id,
> > +						    version->sub_vendor_id,
> > +						    version->impl_ver);
> >   	if (!proto || !try_module_get(proto->owner)) {
> >   		pr_warn("SCMI Protocol 0x%x not found!\n", protocol_id);
> >   		return NULL;
> > @@ -206,21 +285,47 @@ static const struct scmi_protocol *scmi_protocol_get(int protocol_id)
> >   	pr_debug("Found SCMI Protocol 0x%x\n", protocol_id);
> > +	if (protocol_id >= SCMI_PROTOCOL_VENDOR)
> > +		pr_info("Loaded SCMI Vendor Protocol 0x%x - %s %s %X\n",
> > +			protocol_id, proto->vendor_id ?: "",
> > +			proto->sub_vendor_id ?: "", proto->impl_ver);
> > +
> >   	return proto;
> >   }
> > -static void scmi_protocol_put(int protocol_id)
> > +static void scmi_protocol_put(const struct scmi_protocol *proto)
> >   {
> > -	const struct scmi_protocol *proto;
> > -
> > -	proto = idr_find(&scmi_protocols, protocol_id);
> >   	if (proto)
> >   		module_put(proto->owner);
> >   }
> > +static int scmi_vendor_protocol_check(const struct scmi_protocol *proto)
> > +{
> > +	if (!proto->vendor_id) {
> > +		pr_err("missing vendor_id for protocol 0x%x\n", proto->id);
> > +		return -EINVAL;
> > +	}
> > +
> > +	if (proto->vendor_id &&
> 
> You can drop ^^, since you've already checked for it.
> 

Ah, right it's just up there :P

> Reviewed-and-Tested-by: Sibi Sankar <quic_sibis@quicinc.com>
>

Thanks for the review, I will wait for more possible feedback and
reviews before reposting a V2 with this fix.

Thanks,
Cristian


