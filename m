Return-Path: <linux-kernel+bounces-153507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 91ED08ACED8
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 15:55:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 317B5B26AEB
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 13:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F88215099F;
	Mon, 22 Apr 2024 13:55:40 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10F0814F9F8;
	Mon, 22 Apr 2024 13:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713794139; cv=none; b=TY+hKN5YpmQ/vltOFJ5uXc5ZHpksLy1KhCwW+/ZxACnpoJZ61JCvM5Q5gUBXY9fOxxhLtc4ISU9tXmpWHaK6WqlNhvHhUlEuIu7IXy3b5Zlmo9U37DBu786GlWmvntXvBu5MCowFzcn4gMHpnKaipBm+rV0ODmAUYJhQ2xLqZ3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713794139; c=relaxed/simple;
	bh=LxjMLSPiqVdSQbJOUuBYUblOWTo6pFvZqG/mb5eNzdA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d4emF6U7WrRIt1/a75VPOcypIA59kfD86L+NgVTNxEtspXNJ8gPryeE+rmx97geaz3oRWhrVdq5QjE+/hLw2jouXAp1Jvo4aLeXRQVN1zcE8mytbZDthq7DI+/TkXxo6a7oHKDiSqjxBqazMyBXqO7HTj1liWyc36IVb768RgQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 98FE0339;
	Mon, 22 Apr 2024 06:56:04 -0700 (PDT)
Received: from [10.57.75.149] (unknown [10.57.75.149])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B0FCC3F73F;
	Mon, 22 Apr 2024 06:55:34 -0700 (PDT)
Message-ID: <2aba29c3-2519-4709-9f83-4a74cbfea263@arm.com>
Date: Mon, 22 Apr 2024 14:55:43 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] cpufreq: scmi: Update Energy Model with allowed
 performance limits
To: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, sudeep.holla@arm.com,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 cristian.marussi@arm.com, linux-samsung-soc@vger.kernel.org,
 rafael@kernel.org, viresh.kumar@linaro.org, quic_sibis@quicinc.com
References: <20240403162315.1458337-1-lukasz.luba@arm.com>
 <20240403162315.1458337-3-lukasz.luba@arm.com>
 <780caf10-964c-4a5b-8333-b448e9cbab4b@arm.com>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <780caf10-964c-4a5b-8333-b448e9cbab4b@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/22/24 14:11, Dietmar Eggemann wrote:
> On 03/04/2024 18:23, Lukasz Luba wrote:
>> The Energy Model (EM) supports performance limits updates. Use the SCMI
>> notifications to get information from FW about allowed frequency scope for
>> the CPUs.
> 
> I'm slightly confused here. IMHO this doesn't seem to be related to the
> "HW dependency between 'little CPUs & L3 $ in DSU' or similar" usecase.
> 
> I assumed that this usecase is rather handled via an additional
> out-of-tree driver, potentially the same which updates the EM because of
> temperature change (em_dev_compute_costs(), em_dev_update_perf_domain())
> or chip binning (em_dev_update_chip_binning()).

This patch allows to handle relatively simple and straight forward use
case for updating the perf limits in the EM. The one that you mention,
which would probably always live out-of-tree, is more complex and
focused on leakage estimation in different conditions.

I see those two drivers separate. We have the DSU+Littles dependency
always, because it's HW dependency, while the leakage issue can happen
in some scenarios like gaming and needs more dedicated driver to handle
it (or rely on FW, but that's another story, orthogonal as well) and
more information to do it properly.

> 
> What about other CPUFreq drivers registering an EM via
> em_dev_register_perf_domain() or 'cpufreq_register_em_with_opp() ->
> dev_pm_opp_of_register_em()'? Or is this 'limit notification' an SCMI FW
> only thing?

Other platforms which use different drivers for CPUfreq will have to
develop their own code. Although, when we merge this upstream, they
could follow this pattern as a reference design.

In our SCMI cpufreq and our SCP firmware we have this situation:
1. Sending CPUfreq request from Big CPU to SCP e.g. via fast-channel &
    it's done from sched-util w/o sugov kthread &
    it has to be super fast, we don't check any other dependency CPU
    for Littles or something like that.
2. The SCP firmware receives the frequency request for Big CPU &
    it checks internal dependencies for other components e.g.
    L3 cache min speed (DSU+Littles domian frequency)
3. The SCP changes the Big CPU frequency & changes the DSU+Littles
    frequency as the depended device
4. The SCP sends updated performance limits for the depended DSU+Littles
    domian to the SCMI cpufreq kernel driver, for proper Littles domain
    cpufreq device
5. SCMI cpufreq kernel driver gets the SCP notification about updated
    perf limits & translates the perf limits min value as the lowest
    currently available frequency for the Littles
6. The SCMI cpufreq driver updates the EM perf limits for Littles
    as the currently minimum available frequency.
    This allows to properly simulate the energy impact when the EAS
    tries to put a task on that domain, even when that PD's util signals
    might show lower frequency potentially being used.

That's why I see this as part of the CPUfreq driver feature.

The leakage driver might be better suited for the thermal framework,
since there is more information available there.

