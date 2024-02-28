Return-Path: <linux-kernel+bounces-84712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE95486AA99
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 09:58:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A1BF2877D7
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 08:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DA942D622;
	Wed, 28 Feb 2024 08:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="pn3BXlWU"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE42F2D056;
	Wed, 28 Feb 2024 08:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709110717; cv=none; b=MexnUWODZJ7hJYSp/wQwNuAoHlAcVTmEsOek/kyMpZnoD00rNWRekr8OmLXMKwXHPePwWI6l7P9Nk3dgAE6Xi9cEcGNUzngTm3EY3EmK/fSG7+RXCS3eD5CPKl/rmDG+ah4VmKgKvDKRWJtHxHMkb5PUGCPxw3cQFHne9nlsY58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709110717; c=relaxed/simple;
	bh=pLxQnlIYQRFIqzP2dygI2ETILFtthWcncOGTSYn9w4A=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=IO+qyqWcpx1teHx/83sa2J2gNM8soIrwzvwPTxxqQzG2jD93ju1W9lgl1w8iPBFdfrF1UorcY80fQUMf5NdfJN4Ojx8pepnuSkRlZfeTXaGtfjMwbR8xvsLD5TnI5ft4JpuGJhLyHiQwFCB9Ybv9vnNf4YYxujGizaGEPpeArEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=pn3BXlWU; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41S8wGXZ102099;
	Wed, 28 Feb 2024 02:58:16 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1709110696;
	bh=zRcCiO8CqojQK0c4Re3HNYJ/sU9ZKURFUS1XX0WG8kQ=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=pn3BXlWUfuCHrH7o+y/Mf/mETlFrdYHKRymO6U+/mmgRHF3yOpKR9ChZuegmXvkcm
	 +/LYITnB0fvFUxcBIxxQ4P0MkCiOFs8e4bhg4pquDrIKfRypAGJIxs7EMtUWayTJS4
	 fcGtLxuDdgiOxSevMwJdcbHfCbWwNaSZt1DYpNuU=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41S8wGfh116555
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 28 Feb 2024 02:58:16 -0600
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 28
 Feb 2024 02:58:16 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 28 Feb 2024 02:58:16 -0600
Received: from [172.24.227.68] (dhruva.dhcp.ti.com [172.24.227.68])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41S8wBb5090151;
	Wed, 28 Feb 2024 02:58:12 -0600
Message-ID: <b3056b8a-d59c-4edb-ba81-848b08313c54@ti.com>
Date: Wed, 28 Feb 2024 14:28:11 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PM: wakeirq: fix wake irq warning in system suspend stage
Content-Language: en-US
To: =?UTF-8?B?UWluZ2xpYW5nIExpICjpu47mmbTkuq4p?= <Qingliang.Li@mediatek.com>,
        "johan+linaro@kernel.org" <johan+linaro@kernel.org>,
        "pavel@ucw.cz"
	<pavel@ucw.cz>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "tony@atomide.com" <tony@atomide.com>,
        "len.brown@intel.com"
	<len.brown@intel.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>,
        =?UTF-8?B?QXhlIFlhbmcgKOadqOejiik=?= <Axe.Yang@mediatek.com>
CC: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>,
        "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>
References: <20240228020040.25815-1-qingliang.li@mediatek.com>
 <1390e743-2216-4435-b2ef-7d92a55605b1@ti.com>
 <0c1e972cf506b22cb1de73c8509bf2b917c0806b.camel@mediatek.com>
From: Dhruva Gole <d-gole@ti.com>
In-Reply-To: <0c1e972cf506b22cb1de73c8509bf2b917c0806b.camel@mediatek.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hello,

On 28/02/24 14:03, Qingliang Li (黎晴亮) wrote:
> On Wed, 2024-02-28 at 11:34 +0530, Dhruva Gole wrote:
>>   	
>> External email : Please do not click links or open attachments until
>> you have verified the sender or the content.
>>   Hi,
>>
>> On 28/02/24 07:30, Qingliang Li wrote:
>>> When driver registers the wake irq with reverse enable ordering,
>>> the wake irq will be re-enabled when entering system suspend,
>> triggering
>>> an 'Unbalanced enable for IRQ xxx' warning. The wake irq will be
>>> enabled in both dev_pm_enable_wake_irq_complete() and
>> dev_pm_arm_wake_irq()
>>>
>>> To fix this issue, complete the setting of
>> WAKE_IRQ_DEDICATED_ENABLED flag
>>> in dev_pm_enable_wake_irq_complete() to avoid redundant irq
>> enablement.
>>
>>
>> Just trying to understand, why not in dev_pm_arm_wake_irq ?
>> Is it cuz it's called much after dev_pm_enable_wake_irq_complete ?
>> Not sure what's the exact call order, but I am assuming
>> dev_pm_enable_wake_irq_complete is more of a runtime thing and
>> dev_pm_arm_wake_irq happens finally at system suspend?
> 
> You are right, the involvement of 'dev_pm_enable_wake_irq_complete' is
> due to the driver selecting 'pm_runtime_force_suspend' as the callback
> function for system suspend. In this scenario, the call sequence during
> system suspend is as follows:
> dpm_suspend_start -> dpm_run_callback -> pm_runtime_force_suspend ->
> dev_pm_enable_wake_irq_check/complete
> suspend_enter -> dpm_suspend_noirq -> dev_pm_arm_wake_irq

OK this is what I expected, thanks for clarifying!

> 
> Based on the above, if the driver (i) chooses pm_runtime_force_suspend
> as the system suspend callback function and (ii) registers wake irq
> with reverse enable ordering, the wake irq will be enabled twice during
> system suspend.

Yep, makes sense

> 
>>
>>>
>>> Fixes: 8527beb12087 ("PM: sleep: wakeirq: fix wake irq arming")
>>> Signed-off-by: Qingliang Li <qingliang.li@mediatek.com>
>>> ---
>>
>> $subject: Most recent convention used for this file is:
>> "PM: sleep: wakeirq:  ..."
> 
> I'm sorry, but what is the problem with the description of the "Fixed"
> field? I didn't get your point and I wrote it according to the previous
> patches.

I am not talking about your "Fixed", I am taking about the subject line
of the patch.
You've used "PM: wakeirq: fix wake ..."

Instead use
"PM: sleep: wakeirq: fix wake ..."

No strong objections here, it's just a nit.

[..snip..]

-- 
Thanks and Regards,
Dhruva Gole

