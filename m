Return-Path: <linux-kernel+bounces-35071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41B42838B7C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 11:15:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99D67B22B13
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 10:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E8955A780;
	Tue, 23 Jan 2024 10:15:30 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD8465A0EB;
	Tue, 23 Jan 2024 10:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706004930; cv=none; b=OaII2NXuE9AgSP0iFaMsojEHhE+F5mX1bhYUUjzZC/AmvRQXiaoH1Dub3jWW+IUcMDIhxuOkFY9K+c2BRk6ix14UmbsPemqfR5IOthjKDE/GOd50B9K5U0LNsWjJLV44RLFq7auLYJK2byMm+Bu+TmJeCC9T1rAUw9y7ba4JTYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706004930; c=relaxed/simple;
	bh=qgJAvwjqadOAFVHNp00pGGzUi/Sz+qHJ/cHPAJhKjYg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YY5scCwMnIdiKwjp198DU7j5Zwu611RY0Bjhv6ctFR9kYHHIaH6f8XoaC2fvJ0BySsLNIILYKkUVReE1yTUf400w3Jj4kwh5jhnHS52WfisEnb/Xx1dkCA0Mwz+bYrE3B2CaVrncihcZN9usxuwVbtBm6tZnWy1CtJkQwwKUtkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 778521FB;
	Tue, 23 Jan 2024 02:16:06 -0800 (PST)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3F35F3F5A1;
	Tue, 23 Jan 2024 02:15:19 -0800 (PST)
Date: Tue, 23 Jan 2024 10:15:16 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Sibi Sankar <quic_sibis@quicinc.com>, cristian.marussi@arm.com,
	rafael@kernel.org, morten.rasmussen@arm.com,
	Sudeep Holla <sudeep.holla@arm.com>, dietmar.eggemann@arm.com,
	lukasz.luba@arm.com, sboyd@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, quic_mdtipton@quicinc.com,
	linux-arm-msm@vger.kernel.org, nm@ti.com
Subject: Re: [PATCH 0/3] cpufreq: scmi: Add boost frequency support
Message-ID: <Za-RtBrSxI-j4Jdx@bogus>
References: <20240117110443.2060704-1-quic_sibis@quicinc.com>
 <20240123060827.a3vszziftj6pszt3@vireshk-i7>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240123060827.a3vszziftj6pszt3@vireshk-i7>

On Tue, Jan 23, 2024 at 11:38:27AM +0530, Viresh Kumar wrote:
> On 17-01-24, 16:34, Sibi Sankar wrote:
> > This series adds provision to mark dynamic opps as boost capable and adds
> > boost frequency support to the scmi cpufreq driver.
> > 
> > Depends on:
> > HW pressure v4: https://patchwork.kernel.org/project/linux-arm-msm/cover/20240109164655.626085-1-vincent.guittot@linaro.org/
> > scmi notification v2: https://patchwork.kernel.org/project/linux-arm-msm/cover/20240117104116.2055349-1-quic_sibis@quicinc.com/
> > 
> > Sibi Sankar (3):
> >   OPP: Extend dev_pm_opp_data with turbo support
> >   firmware: arm_scmi: Add support for marking certain frequencies as
> >     boost
> >   cpufreq: scmi: Enable boost support
> 
> Sudeep, please lemme know if you are okay with the changes. Will apply
> them.

I was planning to look at it once Lukasz/Dietmar confirm that this concept
doesn't change anything fundamental in the way EAS related changes work
today. I know I suggested the change as that seem to be right way to do
but I haven't analysed if this has any negative impact on the existing
features as this change will impact all the existing platform with OPPs
above sustained performance/frequency advertised from the SCMI platform
firmware.

-- 
Regards,
Sudeep

