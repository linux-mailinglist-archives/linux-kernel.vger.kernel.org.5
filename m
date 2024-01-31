Return-Path: <linux-kernel+bounces-46362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD57C843EAA
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 12:43:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0047B2EEC1
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 11:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 478EF762E1;
	Wed, 31 Jan 2024 11:35:35 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B02F91E522;
	Wed, 31 Jan 2024 11:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706700934; cv=none; b=FHQvtnJZtGNgzIge0FRZhQA7lkIK/h/F1FJZE6BncN11Fi2ei5QF5qpH8N7oBUf4sqKEPNjxeDtYmhPA8JuYfjAyY00aqYSSgPQregX6aqqA6Bqjyr6NAFdj2Mc7S9iuSQBTOn65PWgc20NkXQtXI5mJEs1G/Iw3KAWwQTQiiHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706700934; c=relaxed/simple;
	bh=izE1H+fGsLUgCjynXXUT4yExr6tCiZIXXQ1O+xf9IZ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lI2lLrbadew5X5ma6ey8IHxDIvEbiWjZC0M8LVL8TCcumV8uuDYKfOfbEcGSSCQSnO0xnifEj1CwW6SAJ13lCDyqP3eLrj3DLRDDX4XefGpb8Krk7wQS5qKXrjbS71BhWrAtjaucgD87N28jIZa+1UJB8F9pXg8CoxGiePfTeGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A134CDA7;
	Wed, 31 Jan 2024 03:36:15 -0800 (PST)
Received: from pluto (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2A8F73F762;
	Wed, 31 Jan 2024 03:35:30 -0800 (PST)
Date: Wed, 31 Jan 2024 11:35:27 +0000
From: Cristian Marussi <cristian.marussi@arm.com>
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: Sibi Sankar <quic_sibis@quicinc.com>, rafael@kernel.org,
	viresh.kumar@linaro.org, morten.rasmussen@arm.com,
	dietmar.eggemann@arm.com, lukasz.luba@arm.com,
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, quic_mdtipton@quicinc.com,
	linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH V2 1/4] firmware: arm_scmi: Add perf_notify_support
 interface
Message-ID: <ZbowcUEa3-gxqzXp@pluto>
References: <20240117104116.2055349-1-quic_sibis@quicinc.com>
 <20240117104116.2055349-2-quic_sibis@quicinc.com>
 <ZbfJN1c9viiLhO1L@pluto>
 <ZbfhdqBBpjyf3IRI@pluto>
 <20240131112854.24euh6c6xgljsj6c@bogus>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240131112854.24euh6c6xgljsj6c@bogus>

On Wed, Jan 31, 2024 at 11:28:54AM +0000, Sudeep Holla wrote:
> On Mon, Jan 29, 2024 at 05:33:42PM +0000, Cristian Marussi wrote:
> > On Mon, Jan 29, 2024 at 03:50:20PM +0000, Cristian Marussi wrote:
> > > On Wed, Jan 17, 2024 at 04:11:13PM +0530, Sibi Sankar wrote:
> > > > Add a new perf_notify_support interface to the existing perf_ops to export
> > > > info regarding limit/level change notification support.
> > > > 
> > > 
> > > Hi Sibi,
> > > 
> > > as I mentioned previously, in order not to add a needless stream of SCMI
> > > Perf accessors I posted this:
> > > 
> > > https://lore.kernel.org/linux-arm-kernel/20240129151002.1215333-1-cristian.marussi@arm.com/T/#u
> > > 
> > > to expose all the Perf domains infos via the usual info_get(), similarly
> > > to how other SCMI protocols do already.
> > > 
> > > I think that reworking this series on that, you can certainly drop this patch and just
> > > check the _notify booleans on the retrieved domain info.
> > 
> > Sorry, but hold on with this change, I will probably post an updated version
> > my patch above.
> > 
> 
> As discussed in private, I would prefer to avoid exposing all the internals
> to the users of SCMI perf. At the same time may we can do better if we can
> check the availability of notification as part of notification enablement
> from the SCMI driver, I need to think the details yet.

Yes a patch is under-work to avoid exposing too much Perf info AND to
avoid adding ad-hoc accessors like xlate, in this case.

Thanks,
Cristian

