Return-Path: <linux-kernel+bounces-92311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EDD9B871E3D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 12:47:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B7391C23AA1
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 11:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B19BE59B5C;
	Tue,  5 Mar 2024 11:46:39 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CD865676D;
	Tue,  5 Mar 2024 11:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709639199; cv=none; b=cY+KVBysX8JL0gmMqUX18yRBVCS4RTJoOaM3RZTxwQKZTyFDe9VPYmadSHeRxj+bZCm4BY/LMqHHKPvCs+TrSCurtYTYoQUpPzHr31YBPYP0l6CBJ95b6IxIhoUSxK0V478yZSznxfUSLu9FuCTuNSptjyJw6XYRBURsu8PLf/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709639199; c=relaxed/simple;
	bh=K+s3gas02e9E4iUjXjT/64GP8DZNwtmwcELjrkLGz0k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JRfcq1hb3Byljld32AhZ7oZY7FRNo5abWCRdsyCjRuNk01jxuoiv5HdOy7DE/r/d0Tyk3Mz0A5jSlyi9mN+VpC3gpt+jjx8eltCc6bprPeH7jI5k7ZgPsvek9UUHLXjqw/N7skaNkAW8SXhBIFB6dpChlW9wqIRUnubi//MSgCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 40D631FB;
	Tue,  5 Mar 2024 03:47:13 -0800 (PST)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EDE4D3F762;
	Tue,  5 Mar 2024 03:46:34 -0800 (PST)
Date: Tue, 5 Mar 2024 11:46:32 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: Pierre Gondois <pierre.gondois@arm.com>
Cc: linux-kernel@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>,
	Cristian Marussi <cristian.marussi@arm.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Ionela Voinescu <ionela.voinescu@arm.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 2/3] firmware: arm_scmi: Populate fast channel rate_limit
Message-ID: <ZecGGJrgJ2857FYW@bogus>
References: <20240222135702.2005635-1-pierre.gondois@arm.com>
 <20240222135702.2005635-3-pierre.gondois@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240222135702.2005635-3-pierre.gondois@arm.com>

On Thu, Feb 22, 2024 at 02:57:00PM +0100, Pierre Gondois wrote:
> Arm SCMI spec. v3.2, s4.5.3.12 PERFORMANCE_DESCRIBE_FASTCHANNEL
> defines a per-domain rate_limit for performance requests:
> """
> Rate Limit in microseconds, indicating the minimum time
> required between successive requests. A value of 0
> indicates that this field is not applicable or supported
> on the platform.
> """"
> The field is first defined in SCMI v2.0.
> 
> Add support to fetch this value and advertise it through
> a fast_switch_rate_limit() callback.
>

I did a quick check and these changes doesn't conflict with -next SCMI
content. So if Viresh is happy to pick them up for v6.9,

Acked-by: Sudeep Holla <sudeep.holla@arm.com>

-- 
Regards,
Sudeep

