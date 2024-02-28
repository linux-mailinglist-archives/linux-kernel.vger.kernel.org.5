Return-Path: <linux-kernel+bounces-84551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7353186A832
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 07:05:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14377B21CB3
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 06:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1963B21A19;
	Wed, 28 Feb 2024 06:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="GtWFzRk9"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C8C21362;
	Wed, 28 Feb 2024 06:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709100300; cv=none; b=F1DbAe2XN6zCVzZXBLXdsCKJcKVL1IvZ6dvYBDFVZXGJHonennnroRJhh91if78LAjU8veSsGf38H736SGbqhQ6+B+FvkW2sogSKldcmBq6wApkYn2v13e5wQM+szqmyn7EFZ8v3FkaPpp0/kPao+tjoRwzXLk9+XDXhFvi1Hp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709100300; c=relaxed/simple;
	bh=Bx/72HQNWWv+7pa7o40RHu5kyjc1ZrMEMUJaH4AtW+0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=rERwsHzDGWTT6LAWoga2KLH2Bos7ihARgRolraHKTZ707z713WsmqLwLhOIQUMh3g/mWOgHogAOzWU6OPo3oJTRZw7E4/tkYkDqb98rS+bLkDmhTpS2LDkZVw3ReRMr0Dal5PdFLCdI9C0NSb6Z9FrxgPoSDSA70nxyIa5LJiNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=GtWFzRk9; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41S64T3S055457;
	Wed, 28 Feb 2024 00:04:29 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1709100269;
	bh=dlFX39e4Le6PT/fbfEe1U4Pxl4yfCvn/ID1DA6HRvSk=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=GtWFzRk9RjdIo1EqAe+uxMjXXCgkL8SCURhE2rKK+g1fRXleQnQYwFIpfgvGQjBC7
	 E4YStneUeimUG2Z806Dq+VReRykRKQ2bCMOQyMvRzo9F9uQJnNVkunBWGjLSjWhSqf
	 XfxroEYiojgz8po2EUSuERBof8qZdyF5Fy3xBOVE=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41S64Taw097518
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 28 Feb 2024 00:04:29 -0600
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 28
 Feb 2024 00:04:28 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 28 Feb 2024 00:04:28 -0600
Received: from [172.24.227.68] (dhruva.dhcp.ti.com [172.24.227.68])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41S64O8F115774;
	Wed, 28 Feb 2024 00:04:25 -0600
Message-ID: <1390e743-2216-4435-b2ef-7d92a55605b1@ti.com>
Date: Wed, 28 Feb 2024 11:34:23 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PM: wakeirq: fix wake irq warning in system suspend stage
To: Qingliang Li <qingliang.li@mediatek.com>,
        "Rafael J . Wysocki"
	<rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Len Brown
	<len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>,
        Johan Hovold
	<johan+linaro@kernel.org>,
        Tony Lindgren <tony@atomide.com>, Dhruva Gole
	<d-gole@ti.com>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
References: <20240228020040.25815-1-qingliang.li@mediatek.com>
Content-Language: en-US
From: Dhruva Gole <d-gole@ti.com>
In-Reply-To: <20240228020040.25815-1-qingliang.li@mediatek.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi,

On 28/02/24 07:30, Qingliang Li wrote:
> When driver registers the wake irq with reverse enable ordering,
> the wake irq will be re-enabled when entering system suspend, triggering
> an 'Unbalanced enable for IRQ xxx' warning. The wake irq will be
> enabled in both dev_pm_enable_wake_irq_complete() and dev_pm_arm_wake_irq()
> 
> To fix this issue, complete the setting of WAKE_IRQ_DEDICATED_ENABLED flag
> in dev_pm_enable_wake_irq_complete() to avoid redundant irq enablement.


Just trying to understand, why not in dev_pm_arm_wake_irq ?
Is it cuz it's called much after dev_pm_enable_wake_irq_complete ?
Not sure what's the exact call order, but I am assuming
dev_pm_enable_wake_irq_complete is more of a runtime thing and
dev_pm_arm_wake_irq happens finally at system suspend?

> 
> Fixes: 8527beb12087 ("PM: sleep: wakeirq: fix wake irq arming")
> Signed-off-by: Qingliang Li <qingliang.li@mediatek.com>
> ---

$subject: Most recent convention used for this file is:
"PM: sleep: wakeirq:  ..."

>   drivers/base/power/wakeirq.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/base/power/wakeirq.c b/drivers/base/power/wakeirq.c
> index 42171f766dcb..5a5a9e978e85 100644
> --- a/drivers/base/power/wakeirq.c
> +++ b/drivers/base/power/wakeirq.c
> @@ -313,8 +313,10 @@ void dev_pm_enable_wake_irq_complete(struct device *dev)
>   		return;
>   
>   	if (wirq->status & WAKE_IRQ_DEDICATED_MANAGED &&
> -	    wirq->status & WAKE_IRQ_DEDICATED_REVERSE)
> +	    wirq->status & WAKE_IRQ_DEDICATED_REVERSE) {
>   		enable_irq(wirq->irq);
> +		wirq->status |= WAKE_IRQ_DEDICATED_ENABLED;
> +	}

But this does make sense to make sure status is updated,
You can pick my R-by.

Reviewed-by: Dhruva Gole <d-gole@ti.com>

-- 
Thanks and Regards,
Dhruva Gole

