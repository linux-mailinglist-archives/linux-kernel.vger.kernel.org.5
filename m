Return-Path: <linux-kernel+bounces-40196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3717E83DC16
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 15:36:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69C4B1C20A8F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 14:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E855E1CA91;
	Fri, 26 Jan 2024 14:36:31 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB0F81CA8D;
	Fri, 26 Jan 2024 14:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706279791; cv=none; b=k0HXItufyKCIytnlYDMQWoe0syQsMZ5vJZFIkHrOnhMMhQz4NWKHicAkxgDJabihZEtZgj9JDMPycJZZ4nZoYf8qAG0vd3/3wLwb5MFu8airB7yKT9C8ow1nygpsi2iKi99CYkjEa/4y4bPtyz0S4J8FHyj9BwyOr59P6wW2E4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706279791; c=relaxed/simple;
	bh=fCnJQJroZAwwsS6L657G3W7qNfWzolJI1ZIvcLI9x44=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HRDid4+Z1CcComGw9QW++fifrD217EhqQ/BVmcB8/XLa9pKFuGgsLl840utJXasOU20AWIEbi4SBH+ZHKreyFUN4gl52d1sh292ZlxP63mZsyeUb6t+nO44T9uoJM87i8x+PhZUk9Dm+KQu3JVPvDvE5pZ0Jachi8FzYo722PFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4205D1FB;
	Fri, 26 Jan 2024 06:37:12 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.47.163])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 644823F73F;
	Fri, 26 Jan 2024 06:36:25 -0800 (PST)
Date: Fri, 26 Jan 2024 14:36:16 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Marc Zyngier <maz@kernel.org>
Cc: linux-kernel@vger.kernel.org, Hector Martin <marcan@marcan.st>,
	Ian Rogers <irogers@google.com>, acme@redhat.com,
	james.clark@arm.com, john.g.garry@oracle.com, leo.yan@linaro.org,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, mike.leach@linaro.org,
	namhyung@kernel.org, suzuki.poulose@arm.com, tmricht@linux.ibm.com,
	will@kernel.org
Subject: Re: [PATCH] perf print-events: make is_event_supported() more robust
Message-ID: <ZbPDYG2Bd2H7C_Es@FVFF77S0Q05N>
References: <20240116170348.463479-1-mark.rutland@arm.com>
 <8734uwxrca.wl-maz@kernel.org>
 <ZafEFU7kwf6W0_Qx@FVFF77S0Q05N.cambridge.arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZafEFU7kwf6W0_Qx@FVFF77S0Q05N.cambridge.arm.com>

On Wed, Jan 17, 2024 at 12:12:05PM +0000, Mark Rutland wrote:
> On Wed, Jan 17, 2024 at 09:05:25AM +0000, Marc Zyngier wrote:
> > However, I'm seeing some slightly odd behaviours:

I believe that this is a separate issue; info dump below.
> > $ sudo ./perf stat -e cycles:k ~/hackbench 100 process 1000
> > Running with 100*40 (== 4000) tasks.
> > Time: 3.313
> > 
> >  Performance counter stats for '/home/maz/hackbench 100 process 1000':
> > 
> >    <not supported>      apple_firestorm_pmu/cycles:k/                                         
> >    <not supported>      apple_icestorm_pmu/cycles:k/                                          
> > 
> >        3.467568841 seconds time elapsed
> > 
> >       13.080111000 seconds user
> >       53.162099000 seconds sys
> > 
> > I would have expected it to count, but it didn't. For that to work, I
> > have to add the 'H' modifier:

I gave that a spin with the aforementioned hacked-up PMUv3 driver, and I see
the same:

| # ./perf-after stat -e cycles true
| 
|  Performance counter stats for 'true':
| 
|      <not counted>      armv8_pmuv3_0/cycles/                                                   (0.00%)
|            1375271      armv8_pmuv3_1/cycles/                                                 
| 
|        0.001153070 seconds time elapsed
| 
|        0.001204000 seconds user
|        0.000000000 seconds sys
| 
| 
| # ./perf-after stat -e cycles:k true
| 
|  Performance counter stats for 'true':
| 
|    <not supported>      armv8_pmuv3_0/cycles:k/                                               
|    <not supported>      armv8_pmuv3_1/cycles:k/                                               
| 
|        0.000983130 seconds time elapsed
| 
|        0.001037000 seconds user
|        0.000000000 seconds sys
| 
| 
| # ./perf-after stat -e cycles:kH true
| 
|  Performance counter stats for 'true':
| 
|      <not counted>      armv8_pmuv3_0/cycles:kH/                                                (0.00%)
|             932067      armv8_pmuv3_1/cycles:kH/                                              
| 
|        0.001090100 seconds time elapsed
| 
|        0.001125000 seconds user
|        0.000000000 seconds sys

.. though interestingly 'cycles:u' works:

| # ./perf-after stat -e cycles:u true
| 
|  Performance counter stats for 'true':
| 
|             369753      armv8_pmuv3_0/cycles:u/                                               
|      <not counted>      armv8_pmuv3_1/cycles:u/                                                 (0.00%)
| 
|        0.001171980 seconds time elapsed
| 
|        0.001245000 seconds user
|        0.000000000 seconds sys

Looking at the output with '-vvv' the perf tool implicitly sets exclude_guest
for 'cycles', 'cycles:u', and 'cycles:kH', but does not set exclude_guest for
'cycles:k'.

It looks like that's consistent with the behaviour of opening separate events
prior to this patch:

| # ./perf-before stat -e armv8_pmuv3_0/cycles/ -e armv8_pmuv3_1/cycles/ true
| 
|  Performance counter stats for 'true':
| 
|            1407624      armv8_pmuv3_0/cycles/                                                 
|      <not counted>      armv8_pmuv3_1/cycles/                                                   (0.00%)
| 
|        0.001179205 seconds time elapsed
| 
|        0.001217000 seconds user
|        0.000000000 seconds sys
| 
| 
| # ./perf-before stat -e armv8_pmuv3_0/cycles/u -e armv8_pmuv3_1/cycles/u true
| 
|  Performance counter stats for 'true':
| 
|             329212      armv8_pmuv3_0/cycles/u                                                
|      <not counted>      armv8_pmuv3_1/cycles/u                                                  (0.00%)
| 
|        0.001050550 seconds time elapsed
| 
|        0.001081000 seconds user
|        0.000000000 seconds sys
| 
| 
| # ./perf-before stat -e armv8_pmuv3_0/cycles/k -e armv8_pmuv3_1/cycles/k true
| 
|  Performance counter stats for 'true':
| 
|    <not supported>      armv8_pmuv3_0/cycles/k                                                
|    <not supported>      armv8_pmuv3_1/cycles/k                                                
| 
|        0.000944285 seconds time elapsed
| 
|        0.000985000 seconds user
|        0.000000000 seconds sys
| 
| 
| # ./perf-before stat -e armv8_pmuv3_0/cycles/kH -e armv8_pmuv3_1/cycles/kH true
| 
|  Performance counter stats for 'true':
| 
|            1016160      armv8_pmuv3_0/cycles/kH                                               
|      <not counted>      armv8_pmuv3_1/cycles/kH                                                 (0.00%)
| 
|        0.001179220 seconds time elapsed
| 
|        0.001239000 seconds user
|        0.000000000 seconds sys

.. and per '-vvv', exclude_guest is set in the same cases.

I agree it's a bit weird that the tool sets exclude_guest for unfilted and ':u'
events, but not ':k' events, but it looks like that's separate from the way
events get expanded.

Thanks,
Mark.

