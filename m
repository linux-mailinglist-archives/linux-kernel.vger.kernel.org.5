Return-Path: <linux-kernel+bounces-123061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DFA7890198
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 15:21:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 484ED2972E0
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 14:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B92912DD94;
	Thu, 28 Mar 2024 14:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bPnho7Ph"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 780A780027;
	Thu, 28 Mar 2024 14:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711635647; cv=none; b=Ptw6tDTASqvbU30qGNFFlbOs0Z6Bx0Ofzoz+I7btGqBIv7xOxOaXWZUgmQXbm0QF+390nCpO+x8Lj69/sKnajrjm1Vmjk5Zt0REklKu5hrT/s908uw4tYGRb5xMRcKcyUZcrdTpwfNbiiwapCn0OFsFZrP4TVAciIIMBJSZ1Tow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711635647; c=relaxed/simple;
	bh=RHBQDa4sqkolqdfPMgVVfKoXTaMJUPy5Hr+BBM0MJbQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pnOivNgoKqAxE6aiRY/ZEjwMXqG9mbfgbylTODyJOKZs+XuGIb12SYgbZMULQRtzmR/24uXrc/Mz7uevatdOOi8O6nTVbb52s7Svuy/2oFgw91SAhYmGnklQnfoN37wJBzMQMmQAgxchJK/vbw8nVEspS6NJQNpmEnTaPknMI8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bPnho7Ph; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711635646; x=1743171646;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=RHBQDa4sqkolqdfPMgVVfKoXTaMJUPy5Hr+BBM0MJbQ=;
  b=bPnho7PhEEpHaD+dhFpQJ1WsxGe2DYMnn4tCktXs6WctQTQfPB1N1cix
   wG90aWWoEg2yNdiuzen7f3h1wmeMSvkKNcd4W5XwrvBbzBGWCB0FAAm8Z
   aOy0sqNyaJmLZ40xHP+NicKI2ex7bGz6ai55jHRckRmPidNSqg12oybmp
   G9hT4ivNQ7DBjsX2fO/XWEnN5W9FXEk93QUSuKKa3jX50P1Uw6vD+TmaB
   KY8LhgEMOxklSup1XbQTdkGO7M4LtfGrQup3AVaEh5YlR3Kg/h+863FRQ
   riDBE/VDJXfc+EYbEFbh7BHFo9ueqsutGxuBpTIJs6lERb0HTJS6cF514
   g==;
X-CSE-ConnectionGUID: yrPlAn79SDum241O2KdMVA==
X-CSE-MsgGUID: vZzb4beyTCW6qUs2vh7CYg==
X-IronPort-AV: E=McAfee;i="6600,9927,11026"; a="9747664"
X-IronPort-AV: E=Sophos;i="6.07,162,1708416000"; 
   d="scan'208";a="9747664"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2024 07:20:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,162,1708416000"; 
   d="scan'208";a="21128607"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.39.195])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2024 07:20:38 -0700
Message-ID: <5bce008a-8354-4ccd-af1f-b7f2b2caf3bc@intel.com>
Date: Thu, 28 Mar 2024 16:20:33 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: sdhci-msm: pervent access to suspended controller
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Mantas Pucka <mantas@8devices.com>, Bjorn Andersson
 <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>,
 Georgi Djakov <djakov@kernel.org>, Pramod Gurav <pramod.gurav@linaro.org>,
 Ritesh Harjani <ritesh.list@gmail.com>, linux-mmc@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20240321-sdhci-mmc-suspend-v1-1-fbc555a64400@8devices.com>
 <2e712cf6-7521-4c0b-b6fd-76bacc309496@intel.com>
 <CAPDyKFoBgwWDXhcXsbCfBD_nJ=3w1e5eReqHgDQ1BiPf0zJRxw@mail.gmail.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <CAPDyKFoBgwWDXhcXsbCfBD_nJ=3w1e5eReqHgDQ1BiPf0zJRxw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 27/03/24 17:17, Ulf Hansson wrote:
> On Tue, 26 Mar 2024 at 11:25, Adrian Hunter <adrian.hunter@intel.com> wrote:
>>
>> On 21/03/24 16:30, Mantas Pucka wrote:
>>> Generic sdhci code registers LED device and uses host->runtime_suspended
>>> flag to protect access to it. The sdhci-msm driver doesn't set this flag,
>>> which causes a crash when LED is accessed while controller is runtime
>>> suspended. Fix this by setting the flag correctly.
>>>
>>> Cc: stable@vger.kernel.org
>>> Fixes: 67e6db113c90 ("mmc: sdhci-msm: Add pm_runtime and system PM support")
>>> Signed-off-by: Mantas Pucka <mantas@8devices.com>
>>
>> Acked-by: Adrian Hunter <adrian.hunter@intel.com>
> 
> Looks like this problem may exist for other sdhci drivers too. In
> particular for those that enables runtime PM, don't set
> SDHCI_QUIRK_NO_LED and don't use sdhci_runtime|suspend_resume_host().
> 
> Don't know if there is a better way to address this, if not on a case
> by case basis. Do you have any thoughts about this?

Yes probably case by case, but I will look at it.

> 
> Kind regards
> Uffe
> 
>>
>>> ---
>>>  drivers/mmc/host/sdhci-msm.c | 16 +++++++++++++++-
>>>  1 file changed, 15 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
>>> index 668e0aceeeba..e113b99a3eab 100644
>>> --- a/drivers/mmc/host/sdhci-msm.c
>>> +++ b/drivers/mmc/host/sdhci-msm.c
>>> @@ -2694,6 +2694,11 @@ static __maybe_unused int sdhci_msm_runtime_suspend(struct device *dev)
>>>       struct sdhci_host *host = dev_get_drvdata(dev);
>>>       struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>>>       struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
>>> +     unsigned long flags;
>>> +
>>> +     spin_lock_irqsave(&host->lock, flags);
>>> +     host->runtime_suspended = true;
>>> +     spin_unlock_irqrestore(&host->lock, flags);
>>>
>>>       /* Drop the performance vote */
>>>       dev_pm_opp_set_rate(dev, 0);
>>> @@ -2708,6 +2713,7 @@ static __maybe_unused int sdhci_msm_runtime_resume(struct device *dev)
>>>       struct sdhci_host *host = dev_get_drvdata(dev);
>>>       struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>>>       struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
>>> +     unsigned long flags;
>>>       int ret;
>>>
>>>       ret = clk_bulk_prepare_enable(ARRAY_SIZE(msm_host->bulk_clks),
>>> @@ -2726,7 +2732,15 @@ static __maybe_unused int sdhci_msm_runtime_resume(struct device *dev)
>>>
>>>       dev_pm_opp_set_rate(dev, msm_host->clk_rate);
>>>
>>> -     return sdhci_msm_ice_resume(msm_host);
>>> +     ret = sdhci_msm_ice_resume(msm_host);
>>> +     if (ret)
>>> +             return ret;
>>> +
>>> +     spin_lock_irqsave(&host->lock, flags);
>>> +     host->runtime_suspended = false;
>>> +     spin_unlock_irqrestore(&host->lock, flags);
>>> +
>>> +     return ret;
>>>  }
>>>
>>>  static const struct dev_pm_ops sdhci_msm_pm_ops = {
>>>
>>> ---
>>> base-commit: e8f897f4afef0031fe618a8e94127a0934896aba
>>> change-id: 20240321-sdhci-mmc-suspend-34f4af1d0286
>>>
>>> Best regards,
>>


