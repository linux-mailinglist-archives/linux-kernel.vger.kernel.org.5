Return-Path: <linux-kernel+bounces-90521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FBC4870091
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 12:43:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57079B21CFB
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 11:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3C613A287;
	Mon,  4 Mar 2024 11:42:50 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D62639FEE;
	Mon,  4 Mar 2024 11:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709552570; cv=none; b=KoskiX1+vla202dQeST8ajhlJ5spex8w1BuL1pLimOLqMf9TRjIfw7Fj1s5O1KDYkmZ5azG3IAubaFY4ll4XFjLOC5HYYUeZN2pa2eE0s/IabNO5u3+BGBUQy6v8HMTbCfUkRU9jJG/FXS+T+ZEYjm4ACUaPnuTHVwlvVrwJRqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709552570; c=relaxed/simple;
	bh=dnzxzWXhjTBIQHDxWLCiIj/FNQoDuoU0e9AQhpZ82os=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cAoBl0eHhwgWNre7kqlhaOGkki/I8mPn0cQh7/ylxlT0jmZxKKHaSJUcqfzae2UbkfmERYxvpgaWKNLilE5jS6Gv+HptO2tHEhOCLJBvTCPAp8kCe3bkfxVr1494hv/gNuH/9akh/QiLxpJ5EIbMWQgHy3RE4nN0kl/NbfPABmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A77D51FB;
	Mon,  4 Mar 2024 03:43:24 -0800 (PST)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 47FF73F738;
	Mon,  4 Mar 2024 03:42:46 -0800 (PST)
Date: Mon, 4 Mar 2024 11:42:43 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Pierre Gondois <pierre.gondois@arm.com>, linux-kernel@vger.kernel.org,
	Cristian Marussi <cristian.marussi@arm.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Ionela Voinescu <ionela.voinescu@arm.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 0/3]  scmi-cpufreq: Set transition_delay_us
Message-ID: <ZeWzs_g6FvQlHQN7@bogus>
References: <20240222135702.2005635-1-pierre.gondois@arm.com>
 <20240304070058.kfqg3ypssn5x6k7s@vireshk-i7>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240304070058.kfqg3ypssn5x6k7s@vireshk-i7>

On Mon, Mar 04, 2024 at 12:30:58PM +0530, Viresh Kumar wrote:
> On 22-02-24, 14:56, Pierre Gondois wrote:
> > policy's fields definitions:
> > `transition_delay_us`:
> > The minimum amount of time between two consecutive freq. requests
> > for one policy.
> > `transition_latency`:
> > Delta between freq. change request and effective freq. change on
> > the hardware.
> >
> > cpufreq_policy_transition_delay_us() uses the `transition_delay_us`
> > value if available. Otherwise a value is induced from the policy's
> > `transition_latency`.
> >
> > The scmi-cpufreq driver doesn't populate the `transition_delay_us`.
> > Values matching the definition are available through the SCMI
> > specification.
> > Add support to fetch these values and use them in the scmi-cpufreq
> > driver.
>
> How do we merge this series ? I can only pick the last commit.

I have sent my PR for v6.9 already and was deferring this to v6.10
The changes look good to me. If it doesn't conflict much with -next
SCMI content, then I am happy to ack and you can take all of them
together. Otherwise we can revisit strategy at -rc1. Thoughts ?

--
Regards,
Sudeep

