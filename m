Return-Path: <linux-kernel+bounces-40321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3091A83DE76
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 17:19:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E113D285EF1
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 16:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A05F31DA21;
	Fri, 26 Jan 2024 16:19:16 +0000 (UTC)
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 087F31CFB6;
	Fri, 26 Jan 2024 16:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706285956; cv=none; b=SSBlLKXpa9Bthj9GuIL88nu5R/4VgrLlmXrHIPri0JyITS/2WGB4yoFNigpzAnLW/ZWZiNHT2PUV2fUrl3cGKsr/vXZe+mj+nYQePndDFJdwIpMNReyjTOSbBEDSP2l/T9nLOOyGIy6OSm89/nDWOC+ehppLpBRzO/FaJM3hle8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706285956; c=relaxed/simple;
	bh=cMrZ22JKhN5As6X/c/pxqBYrRoRyHlZ4SenKY2BEadk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZmusW7AQu616cv6KrQrrWlW2fMAEYqEo7AbPIp2IbwCB5pJIWnhqr6Mnqvwx/KGy1EYd5upICtSaT5b6OYaP128i3Hlz5gTVtWRcji12iMYOgFiiVCK1K2mCMN0PtwWR5AsLMMI5FkeFrMBooK25D9hGARgbXjGIKR5fmC9uOmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1rTOv9-0007sh-2w; Fri, 26 Jan 2024 17:19:11 +0100
Message-ID: <0fd03c79-5e86-4cf8-99ae-944d73d5515a@leemhuis.info>
Date: Fri, 26 Jan 2024 17:19:10 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Re: [PATCH] pinctrl: amd: Add IRQF_ONESHOT to the interrupt request
Content-Language: en-US, de-DE
To: Mario Limonciello <mario.limonciello@amd.com>,
 Linus Walleij <linus.walleij@linaro.org>
Cc: Basavaraj Natikar <Basavaraj.Natikar@amd.com>,
 Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
 "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
 "open list:PIN CONTROL SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>,
 Christian Heusel <christian@heusel.eu>,
 Linux kernel regressions list <regressions@lists.linux.dev>
References: <20240123180818.3994-1-mario.limonciello@amd.com>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
In-Reply-To: <20240123180818.3994-1-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1706285954;49fa5952;
X-HE-SMSGID: 1rTOv9-0007sh-2w

On 23.01.24 19:08, Mario Limonciello wrote:
> On some systems the interrupt is shared between GPIO controller
> and ACPI SCI. When the interrupt is shared with the ACPI SCI the
> flags need to be identical.
> 
> This should fix the GPIO controller failing to work after commit
> 7a36b901a6eb ("ACPI: OSL: Use a threaded interrupt handler for SCI").
> ```
> [    0.417335] genirq: Flags mismatch irq 9. 00000088 (pinctrl_amd) vs. 00002080 (acpi)
> [    0.420073] amd_gpio: probe of AMDI0030:00 failed with error -16
> ```
> 
> Cc: Rafael J. Wysocki <rafael@kernel.org>
> Reported-by: Christian Heusel <christian@heusel.eu>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218407
> Fixes: 7a36b901a6eb ("ACPI: OSL: Use a threaded interrupt handler for SCI")

I'm affected by this regression myself on my Thinkpad T14s Gen1 AMD
(power button does not work, but I guess there might be more). Haven't
tested this patch yet, seemed like this was pretty clear case and
Christian already tested it. But if it makes anyone happy I can do that.

> Link: https://lore.kernel.org/linux-acpi/CAJZ5v0iRqUXeuKmC_+dAJtDBLWQ3x15n4gRH48y7MEaLoXF+UA@mail.gmail.com/T/#mc5506014141b61e472b24e095889535a04458083

Side note: might be wise to change that to something slightly shorter:

Link:
https://lore.kernel.org/linux-acpi/kvoclxvyhmdmrfpfgwfjr33bdltej3upw5qcnazc4xakwdgg2b@krewjw2uk42k/

Ciao, Thorsten

> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/pinctrl/pinctrl-amd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pinctrl/pinctrl-amd.c b/drivers/pinctrl/pinctrl-amd.c
> index ca4a247c2cd1..6a33b584976c 100644
> --- a/drivers/pinctrl/pinctrl-amd.c
> +++ b/drivers/pinctrl/pinctrl-amd.c
> @@ -1162,7 +1162,7 @@ static int amd_gpio_probe(struct platform_device *pdev)
>  	}
>  
>  	ret = devm_request_irq(&pdev->dev, gpio_dev->irq, amd_gpio_irq_handler,
> -			       IRQF_SHARED, KBUILD_MODNAME, gpio_dev);
> +			       IRQF_SHARED | IRQF_ONESHOT, KBUILD_MODNAME, gpio_dev);
>  	if (ret)
>  		goto out2;
>  

P.S.: Let me add this to the tracking while at it:

#regzbot introduced 7a36b901a6eb ^
https://bugzilla.kernel.org/show_bug.cgi?id=218407
#regzbot title ACPI: OSL:/pinctrl: GPIO controller failing to work
#regzbot fix pinctrl: amd: Add IRQF_ONESHOT to the interrupt request
#regzbot ignore-activity

