Return-Path: <linux-kernel+bounces-38485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6C8283C08B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 12:15:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 554FE1F23339
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 11:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D736A321AA;
	Thu, 25 Jan 2024 11:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UMq//pwD"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8335850A93
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 11:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706180891; cv=none; b=Ym/4z/3kSjkkRnUfdnE/EPQdrMwTgXVbPOu6IWzz/3Xc8dHryyd5gK9kG/1ZX5+zk7fh02bpagOu5DbAEF/yIeXSVdK83CR4CgcSQ07vWU+9NL2ZPCz/OpEsehiuM/eS9vsmkZeGSy1MtyqrL1psNbPYrm61jwHPmFVOF3toxrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706180891; c=relaxed/simple;
	bh=OXF4CCNwN7MFURfmPr5WAKq/3GKPFepxulJn7BECNSs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oj8nLVtt2fzwIgj7fVA40vBMZ69o1H9lduz6exMK7xN845GNndHI68LbDbTP+0/kiKk0DGb+hEy7AHHZOZIECFN0O3NI8tZx2h2MfUFEnkvRedQbaSuW54oVlfX4KRed5mVq+iJfTXKkUNEpkMxoLCCEVpSBaqO+a9cTnv6es3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UMq//pwD; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5100cb64e7dso2962805e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 03:08:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706180887; x=1706785687; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1lENeQVE9Bv2rk1ViR2R2CP4axbEYZgu2pD0QISWuHM=;
        b=UMq//pwDJZIhfl1PxWcY33JTolADQWXVt1dkloHimjwpkwl2U0W9WV1Oh46lVhuYJX
         7cUlwvObovwNjvprEg3gFWiubJp8aSnqBo07kmtzRSTE5yvIQaS99luzJkKhq/qNdJZ3
         8qx9+Y+k8LXsblw2VmvUyLdRzg3HG4Y7HCm/0eK3xlTJL49wFYKyZghZr/UXOUPs7y9o
         s7XPSGiVRvuJYgDol6BSKGNeO5beicBhXWchG3kQVzxHFcXEoMy0cH/UQe5VkAtVgH2V
         tCvGKoBLBfnmK5OAuQw0n/Uu3wmnOAJ4eGnU6PpKj0bJpHqFG9Am24OfP8Vl0Ix4TbdZ
         rWaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706180887; x=1706785687;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1lENeQVE9Bv2rk1ViR2R2CP4axbEYZgu2pD0QISWuHM=;
        b=kwMBdgL46b7OIEYa8LYgXGgFIJxwnMrakWzJDLHfi4HtwQznz167xBmdjzkGc47GKr
         YLhkVLJeJzacTv6BfLI+YNTbXxfVRvifIBqdzRvNHMc28gWnh+nM31xTiP26Qb/YWOm0
         CwfsHuPho6iWg0qi9YO0ZUkjep/qHyF0Msgz1GAWIkAkGXmDq3nVJT4I/nhIRdENQgY5
         ec3kjHMzaq2f1ls6WZ66QF5nfyynGHkiXS4nDpDGx5/gU+p93V2BOZFYd1AVAoscWxh7
         IIgyxBOiap8a9L822Cz8mOsq1zaQXrK/9X5hUmgW6e0Oaw7QhJA65y+SNoovb/YafOzb
         NKPQ==
X-Gm-Message-State: AOJu0YwPUfItSEBbgqQKdDn4t7v5JS6Er2asmUhc27C/hN3SPM5oWbP3
	R+4sfT4Nqz/mBOLHCyiP5drJCMBghW3TaXPdUMnCrv7bBBI284wipDT1QQ7kRow=
X-Google-Smtp-Source: AGHT+IF1SKkZsDhmiAU0ddYoWXOT3/212iNyF8V8TpY5qe4Q2Hb2/WQC1bm94pc/Je2t2pfpioC7aA==
X-Received: by 2002:ac2:59dd:0:b0:510:ffd:31be with SMTP id x29-20020ac259dd000000b005100ffd31bemr192437lfn.42.1706180887536;
        Thu, 25 Jan 2024 03:08:07 -0800 (PST)
Received: from [172.30.205.155] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id m16-20020a0565120a9000b0050eb207ab58sm2836949lfu.74.2024.01.25.03.08.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jan 2024 03:08:07 -0800 (PST)
Message-ID: <b5ea1c8c-c35d-45e3-9b90-d3dc480f4463@linaro.org>
Date: Thu, 25 Jan 2024 12:08:05 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] thermal/drivers/tsens: Add suspend to RAM support for
 tsens
Content-Language: en-US
To: Priyansh Jain <quic_priyjain@quicinc.com>,
 Amit Kucheria <amitk@kernel.org>, Thara Gopinath <thara.gopinath@gmail.com>,
 Bjorn Andersson <andersson@kernel.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, linux-pm@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: quic_manafm@quicinc.com
References: <20240122100726.16993-1-quic_priyjain@quicinc.com>
 <548e2f24-a51e-4593-9463-09506488c70e@linaro.org>
 <f415a8cd-4cae-d7c3-60fc-674b3e660f6b@quicinc.com>
 <aeae2e69-8407-4d90-9d16-27798e2f3248@linaro.org>
 <be69e0a6-fdc8-c24b-9beb-adaac4a97776@quicinc.com>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <be69e0a6-fdc8-c24b-9beb-adaac4a97776@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 1/24/24 16:25, Priyansh Jain wrote:
> 
> 
> On 1/24/2024 6:04 PM, Konrad Dybcio wrote:
>>
>>
>> On 1/24/24 11:42, Priyansh Jain wrote:
>>>
>>>
>>> On 1/22/2024 8:02 PM, Konrad Dybcio wrote:
>>>> On 22.01.2024 11:07, Priyansh Jain wrote:
>>>>> Add suspend callback support for tsens which disables tsens interrupts
>>>>> in suspend to RAM callback.
>>>>
>>>> Would it not be preferrable to have the "critical overheat", wakeup-
>>>> capable interrupts be enabled, even if the system is suspended?
>>>>
>>>
>>>
>>> As part of suspend to RAM, tsens hardware will be turned off and it cannot generate any interrupt.Also system doesn't want to abort suspend to RAM due to tsens interrupts since system is already going into lowest
>>> power state. Hence disabling tsens interrupt during suspend to RAM callback.
>>
>> Is that a hardware limitation, or a software design choice? I'm not
>> sure I want my phone to have thermal notifications disabled when
>> it's suspended.
> 
>> Konrad
> 
> As part of suspend to RAM , entire SOC will be off,

What do you mean by "entire SOC[sic] will be off"? Surely the memory
controller must be on to keep refreshing the memory? Are you thinking
of suspend-to-disk (hibernation), by chance?

> this mode (suspend to RAM) is not intended for Mobile product. Tsens interrupts are not
> disabled as part of suspend to idle(suspend mode for mobile).

That's clearly untrue, e.g. the PSCI firmware on SM8550 implements
PSCI_SYSTEM_SUSPEND, which does S2R.

Konrad

