Return-Path: <linux-kernel+bounces-46343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FEB9843E54
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 12:29:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DA5A1F2A632
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 11:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6813F74E2F;
	Wed, 31 Jan 2024 11:29:03 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C50B21E522;
	Wed, 31 Jan 2024 11:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706700543; cv=none; b=KqTMeXJKRrWeXZ7ED4vZA61Dz6KKKqKRAhvkzGzBwCKUeKHgs7jQT8nEVL4r2N3NcQLx8q23R9tcOA3Vc88B6QF8tyvu0sOJim2oFyuCpKqWAqFJtx09enpFRGVnXlKkgpX8+T7cmonbaTj/3NOYbngBIJCC+tzkmfYS43LfCjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706700543; c=relaxed/simple;
	bh=QKraxa4UloPYnJDUngqsppTilrRHPIZbphWIi9YMt/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RF7r2o7hPuld8mDnVyrEvfJnu/2JMCZ3NaydrMTPnHe5bXy5/Ih13+RqaRZ5tIxUFpWn/1DIdn8LxRrE3GmDvWnz+NYHW4mrSH2itN4dA0h6MIG3U9+7hkJXL+HmacZ9AX/60rpl651o2CUXKno2PsplADSp0wWDCm6oVrfeOz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ABF94DA7;
	Wed, 31 Jan 2024 03:29:43 -0800 (PST)
Received: from bogus (unknown [10.57.78.35])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7FF973F762;
	Wed, 31 Jan 2024 03:28:57 -0800 (PST)
Date: Wed, 31 Jan 2024 11:28:54 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: Cristian Marussi <cristian.marussi@arm.com>
Cc: Sibi Sankar <quic_sibis@quicinc.com>, rafael@kernel.org,
	Sudeep Holla <sudeep.holla@arm.com>, viresh.kumar@linaro.org,
	morten.rasmussen@arm.com, dietmar.eggemann@arm.com,
	lukasz.luba@arm.com, linux-arm-kernel@lists.infradead.org,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	quic_mdtipton@quicinc.com, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH V2 1/4] firmware: arm_scmi: Add perf_notify_support
 interface
Message-ID: <20240131112854.24euh6c6xgljsj6c@bogus>
References: <20240117104116.2055349-1-quic_sibis@quicinc.com>
 <20240117104116.2055349-2-quic_sibis@quicinc.com>
 <ZbfJN1c9viiLhO1L@pluto>
 <ZbfhdqBBpjyf3IRI@pluto>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZbfhdqBBpjyf3IRI@pluto>

On Mon, Jan 29, 2024 at 05:33:42PM +0000, Cristian Marussi wrote:
> On Mon, Jan 29, 2024 at 03:50:20PM +0000, Cristian Marussi wrote:
> > On Wed, Jan 17, 2024 at 04:11:13PM +0530, Sibi Sankar wrote:
> > > Add a new perf_notify_support interface to the existing perf_ops to export
> > > info regarding limit/level change notification support.
> > > 
> > 
> > Hi Sibi,
> > 
> > as I mentioned previously, in order not to add a needless stream of SCMI
> > Perf accessors I posted this:
> > 
> > https://lore.kernel.org/linux-arm-kernel/20240129151002.1215333-1-cristian.marussi@arm.com/T/#u
> > 
> > to expose all the Perf domains infos via the usual info_get(), similarly
> > to how other SCMI protocols do already.
> > 
> > I think that reworking this series on that, you can certainly drop this patch and just
> > check the _notify booleans on the retrieved domain info.
> 
> Sorry, but hold on with this change, I will probably post an updated version
> my patch above.
> 

As discussed in private, I would prefer to avoid exposing all the internals
to the users of SCMI perf. At the same time may we can do better if we can
check the availability of notification as part of notification enablement
from the SCMI driver, I need to think the details yet.

-- 
Regards,
Sudeep

