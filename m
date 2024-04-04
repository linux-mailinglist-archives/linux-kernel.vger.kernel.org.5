Return-Path: <linux-kernel+bounces-132124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA37E898FF1
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 23:13:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 458A21F239B4
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 21:13:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D048813B798;
	Thu,  4 Apr 2024 21:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VkOxH4PZ"
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6871213AD2F
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 21:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712265222; cv=none; b=XOt/kgXrPiSb+nH5BuUib4DA6O/OJTQ5dzuBkA8YLORG3jHJONL4CY7ZuCjAxmbc8D7N9aWKRkhENDc3eHAcaMLa34MCIskMyyRq+n0BWWWMWu71tehWyFG+L2onBIm6NfC1AKv5befpOhVQilJW8lBUyL46UdnWbPdMlL4El1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712265222; c=relaxed/simple;
	bh=s9wwL23thTprrqQZ5wXrDwmYHVyBkc8YlW0ql+daai0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nxyhu9Jz5tzijSL/TNScTAv94GmDyj/vhX+lXTiYug8UvY4YfE+YzHESMSn1+PeoINSLwCzyz3KjeId+YyaxKIYvkKQ8WcklAv1ZVZQ3FZGMNOHUKoYpuQIL5/nksleDHPnE6edsGQprW0amzt8rja4mIx4pRFebyjGebl3uGXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VkOxH4PZ; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-6157c30fbc9so15275617b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 14:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712265219; x=1712870019; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=s9wwL23thTprrqQZ5wXrDwmYHVyBkc8YlW0ql+daai0=;
        b=VkOxH4PZ7ve7D7LfwdEUJPzVPbSfTaFeTpr+gNHWXiAfodLp3YWewCKjOMMULmPTLx
         zvYo1QgjKhbkzj54exC17ZXzSZEQZcTLtvxrgjHkTTH1HTSPRS9YZAzNAKiAOzLt2SrS
         9308pt2J9xVqcYmxw65EOr013jDXm+pjg28YcpobcMDZVRSpRe5wgHK3AilmDn4oPZre
         BIVfS75gS+4Ue2/8us1eg7Wf+F4yze0lS5DdD/Q2S+Qs1xxRwTl8g9gRjbzETvf3tRs8
         ZCbmzbzGWEYitfDQlVkRNkihB2bxVN4dY08AQAiUciM4SIjDqBu6n7SzsxqgHz6y6qES
         YttQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712265219; x=1712870019;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s9wwL23thTprrqQZ5wXrDwmYHVyBkc8YlW0ql+daai0=;
        b=P3R3zyMPQSKZskCg8wk2xK3Ox4mEXJ+9A2EDYlajEhFQY/2M57owkftgbw28oAxdpW
         o7oUSdIR01acZniK22LJ73mHNNWiMw1E0v8oNiUQOM8QpkMsSG1Q5e69Klt2kWOtW6f5
         61C6f/Ch1ywehDBCsj3NuszPtVS0nXVgij7Tb+f9FZQalURamE/sXCK8VuKSeTzI5tmC
         +/9ITkjHDzhRBYXz5dyVdP3QE6RHlut/17CZ0s85fkItYwRGLv68LLh4F1ciaVXxBdVp
         v4GmCQR9+zbMjx4DvaOZ45MPzWF9P5ojTZImcLtpG2n7E6ez2I229PZW1w/k0VDHrb6M
         nvPA==
X-Forwarded-Encrypted: i=1; AJvYcCU1arnpQCOUk0ve7RzZUJWsQuQJG7Ip5j8aaHH0PV+9nlJE7MDkDkvTnQpTXjGZ9MjQSLI0SxPxdow2ZVJYb/djsKeQDxDDxLebM5x0
X-Gm-Message-State: AOJu0YzA50xnra1w9n48V2NeK/ltoY/ule2k8BT0mj1F5He0yOSMIhgX
	sOg1x0G+q73rp03iqsdimEf3aGZ0j/qcs+w2RZkd1w1sBWpQiHUPHNlkgGvbPHTUSwq3DVgw4Qa
	il5xMKHcLAYFhMB3O0bb1JM0MCh2I/ofQlVHllg==
X-Google-Smtp-Source: AGHT+IGsrooHF667jpjcxcb99/DcW0fwSfThU7HKVDtxh2RCICQMVyfcyBMKfj/nqQt9pNEkvEvrius1N2V1oudQtq8=
X-Received: by 2002:a25:c744:0:b0:dc2:398b:fa08 with SMTP id
 w65-20020a25c744000000b00dc2398bfa08mr3804202ybe.31.1712265219410; Thu, 04
 Apr 2024 14:13:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240321-sdhci-mmc-suspend-v1-1-fbc555a64400@8devices.com>
 <2e712cf6-7521-4c0b-b6fd-76bacc309496@intel.com> <CAPDyKFoBgwWDXhcXsbCfBD_nJ=3w1e5eReqHgDQ1BiPf0zJRxw@mail.gmail.com>
 <5bce008a-8354-4ccd-af1f-b7f2b2caf3bc@intel.com> <77d76e3b-549e-4d26-834c-a59b91fbb2a0@intel.com>
In-Reply-To: <77d76e3b-549e-4d26-834c-a59b91fbb2a0@intel.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 4 Apr 2024 23:13:02 +0200
Message-ID: <CAPDyKFrx3OdQqzfUvfi_tsoA0Am2rf6HKSrzL1qg77p50BZ3Lw@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-msm: pervent access to suspended controller
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Mantas Pucka <mantas@8devices.com>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Georgi Djakov <djakov@kernel.org>, 
	Pramod Gurav <pramod.gurav@linaro.org>, Ritesh Harjani <ritesh.list@gmail.com>, 
	linux-mmc@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Thierry Reding <thierry.reding@gmail.com>, Liming Sun <limings@nvidia.com>, 
	Victor Shih <victor.shih@genesyslogic.com.tw>
Content-Type: text/plain; charset="UTF-8"

On Thu, 4 Apr 2024 at 20:42, Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> On 28/03/24 16:20, Adrian Hunter wrote:
> > On 27/03/24 17:17, Ulf Hansson wrote:
> >> On Tue, 26 Mar 2024 at 11:25, Adrian Hunter <adrian.hunter@intel.com> wrote:
> >>>
> >>> On 21/03/24 16:30, Mantas Pucka wrote:
> >>>> Generic sdhci code registers LED device and uses host->runtime_suspended
> >>>> flag to protect access to it. The sdhci-msm driver doesn't set this flag,
> >>>> which causes a crash when LED is accessed while controller is runtime
> >>>> suspended. Fix this by setting the flag correctly.
> >>>>
> >>>> Cc: stable@vger.kernel.org
> >>>> Fixes: 67e6db113c90 ("mmc: sdhci-msm: Add pm_runtime and system PM support")
> >>>> Signed-off-by: Mantas Pucka <mantas@8devices.com>
> >>>
> >>> Acked-by: Adrian Hunter <adrian.hunter@intel.com>
> >>
> >> Looks like this problem may exist for other sdhci drivers too. In
> >> particular for those that enables runtime PM, don't set
> >> SDHCI_QUIRK_NO_LED and don't use sdhci_runtime|suspend_resume_host().
> >>
> >> Don't know if there is a better way to address this, if not on a case
> >> by case basis. Do you have any thoughts about this?
> >
> > Yes probably case by case, but I will look at it.
>
> There seem to be 3 that use runtime pm but not
> sdhci_runtime_suspend_host():
>
> 1. dwcmshc_runtime_suspend() : only turns off the card clock
> via SDHCI_CLOCK_CONTROL register, so registers are presumably
> still accessible
>
> 2. gl9763e_runtime_suspend() : ditto
>
> 3. sdhci_tegra_runtime_suspend() : disables the functional
> clock via clk_disable_unprepare(), so registers are presumably
> still accessible
>
> sdhci_msm_runtime_suspend() is different because it also turns
> off the interface clock.
>
> But it looks like there are no similar cases.

Not sure we should care, but it still looks a bit fragile to me. We
may also have a power-domain hooked up to the device, that could get
power gated too, in which case it's likely affecting the access to
registers.

Kind regards
Uffe

