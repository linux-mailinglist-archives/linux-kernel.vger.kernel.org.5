Return-Path: <linux-kernel+bounces-153418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C2388ACDE4
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 15:12:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DD3B1C21C91
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 13:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC20414F9EA;
	Mon, 22 Apr 2024 13:11:57 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36A03149C6C;
	Mon, 22 Apr 2024 13:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713791517; cv=none; b=Sfd9pDWapUbKYm55Sr2A1895uwDh703CSgGMiKoblAsFOZEaoKxOJcg1f3m5Prs7HvJZ2T+TME3dYX3yJcYh26/Bq6LXS/NstrpE1h22KLS/Wk1SMRAQ+bHYEsG9Ukc80BbsvVKDkHT1kZjLhAH1nfbF6JgN16O6/meDzBEo3Ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713791517; c=relaxed/simple;
	bh=aXG+BNE2SIlqBsxDx96zRnMTRD2Zw6HLh1GqSC/yW/o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s+0HVkO2SFB76kljhNylgEMQcaUqbLOV8C08HVHFPjU1dI/QRH69wjKr7U+5KQEHxn3f/3UdeUNPCUWbaEK2m8XREq9PMsIXZX+i5KVRqd3SSGCFPee3Mz8wGfO8iFdrAJkWhQUMaRhhS/yZPYdFlqGJub/7GQgWDwYAy/i6tmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D41D8339;
	Mon, 22 Apr 2024 06:12:23 -0700 (PDT)
Received: from [192.168.178.110] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 285833F73F;
	Mon, 22 Apr 2024 06:11:54 -0700 (PDT)
Message-ID: <780caf10-964c-4a5b-8333-b448e9cbab4b@arm.com>
Date: Mon, 22 Apr 2024 15:11:52 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] cpufreq: scmi: Update Energy Model with allowed
 performance limits
Content-Language: en-US
To: Lukasz Luba <lukasz.luba@arm.com>, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, sudeep.holla@arm.com,
 cristian.marussi@arm.com, linux-samsung-soc@vger.kernel.org,
 rafael@kernel.org, viresh.kumar@linaro.org, quic_sibis@quicinc.com
References: <20240403162315.1458337-1-lukasz.luba@arm.com>
 <20240403162315.1458337-3-lukasz.luba@arm.com>
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <20240403162315.1458337-3-lukasz.luba@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 03/04/2024 18:23, Lukasz Luba wrote:
> The Energy Model (EM) supports performance limits updates. Use the SCMI
> notifications to get information from FW about allowed frequency scope for
> the CPUs.

I'm slightly confused here. IMHO this doesn't seem to be related to the
"HW dependency between 'little CPUs & L3 $ in DSU' or similar" usecase.

I assumed that this usecase is rather handled via an additional
out-of-tree driver, potentially the same which updates the EM because of
temperature change (em_dev_compute_costs(), em_dev_update_perf_domain())
or chip binning (em_dev_update_chip_binning()).

What about other CPUFreq drivers registering an EM via
em_dev_register_perf_domain() or 'cpufreq_register_em_with_opp() ->
dev_pm_opp_of_register_em()'? Or is this 'limit notification' an SCMI FW
only thing?

[...]


