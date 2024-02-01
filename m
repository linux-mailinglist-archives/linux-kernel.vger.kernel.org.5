Return-Path: <linux-kernel+bounces-48514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6421D845D28
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 17:25:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CEB401F21BF2
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 16:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 852E1608FB;
	Thu,  1 Feb 2024 16:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="o6OaG679"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D54A8608E9;
	Thu,  1 Feb 2024 16:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706804456; cv=none; b=h4Y9J0UD1eim8uO3WXkUYu4uTY7XCOzg+k7Zh+gTkVGAI/Zw8p4PSFTO/ezqA186WjvN1vQ2iLda0v963St+n88s+kz38kbcF3A0QCRzCQL7lnDHKpon5FjJOVWQwIov3ADWsK64C7ASNlz2Nq6DZs5BCtX2d9I07vaO9g0qIkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706804456; c=relaxed/simple;
	bh=DBUwzX8KqGLX+c0Kq/oEzNmXLUwliME3QH7RqkjuAAI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Mh5UUyy1dNEv9RkMZ78FSJgv73kpdnAVtji/w2K8arLOT6PNX2IMcTz4X4G+/w2M7sEMAt9HNLsII3L1bBhn2TGpbjSBltyFwWqtcfUzHRk0Hj44S/Fl9Xdg9X+G3ZSBc0RfaI7rPPpsCb8Gs9PDd63B4fi0MQKxFQe4mByu5fA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=o6OaG679; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 411GKjHI100171;
	Thu, 1 Feb 2024 10:20:45 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706804445;
	bh=XmEdIqW2hn/99WyNahpO6KjdxRh9z6fH4BH+17dUyUA=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=o6OaG6798fvb4ud2thQaY5btm5hHV+GYj6XnTNpjIJ+IUL+V6BSp3+JwauYHfma+j
	 dNpJWiZ0q4hdE3UU+C5AytocmpdqucXMWsUMtk5aXAVEkh8vQkvIMNQDS/+cZCeSqK
	 at33BT3kejWHT0uecZCwHAih/cqL89YSdUoExIK8=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 411GKjMS074566
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 1 Feb 2024 10:20:45 -0600
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 1
 Feb 2024 10:20:44 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 1 Feb 2024 10:20:44 -0600
Received: from [10.249.42.149] ([10.249.42.149])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 411GKi4x106981;
	Thu, 1 Feb 2024 10:20:44 -0600
Message-ID: <d81a060f-3d8f-44b2-8140-eb8e7ce35d93@ti.com>
Date: Thu, 1 Feb 2024 10:20:44 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: pwrseq: Use proper reboot notifier path
Content-Language: en-US
To: Ulf Hansson <ulf.hansson@linaro.org>
CC: Marek Szyprowski <m.szyprowski@samsung.com>,
        Yangtao Li
	<frank.li@vivo.com>, <linux-mmc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20240126190110.148599-1-afd@ti.com>
 <CAPDyKFpc38-CFrzhnhutS7c78tZTLM6Bg6XsTKENP8oVT6SQXg@mail.gmail.com>
From: Andrew Davis <afd@ti.com>
In-Reply-To: <CAPDyKFpc38-CFrzhnhutS7c78tZTLM6Bg6XsTKENP8oVT6SQXg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 1/30/24 6:04 AM, Ulf Hansson wrote:
> On Fri, 26 Jan 2024 at 20:01, Andrew Davis <afd@ti.com> wrote:
>>
>> This driver registers itself as a reboot handler, which means it claims
>> it can reboot the system. It does this so it is called during the system
>> reboot sequence. The correct way to be notified during the reboot
>> sequence is to register a notifier with register_reboot_notifier().
>> Do this here.
>>
>> Note this will be called during normal reboots but not emergency reboots.
>> This is the expected behavior, emergency reboot means emergency, not go
>> do some cleanup with emmc pins.. The reboot notifiers are intentionally
>> not called in the emergency path for a reason and working around that by
>> pretending to be a reboot handler is a hack.
> 
> I understand the reason for the $subject patch, but it will not work,
> unfortunately.
> 
> For eMMC we need to manage emergency reboots too. The fiddling with
> GPIOs isn't a "cleanup", but tries to move the eMMC into a clean reset
> state. 

That is by definition a "cleanup", even if the cleanup is really important.

> This is needed on some platforms with broken bootloaders (ROM
> code), that is expecting the eMMC to always start in a clean reset
> state.
> 

I understand the reason, I don't agree with the method used to get
the result.

> So, we need both parts, as was discussed here [1] too.
> 

In this thread I see a lot of discussion about the priority of the
handler. You want this to run before any real reboot handlers
are run. Luckily for you, all reboot "notifiers" are run before
any "handlers" are run. So if you register as a "notifier" as
this patch does, you will be run first, no super high priority
settings needed.

The real issue is you want to be called even in the
emergency_restart() path, which is fine. But from the
docs for that function this type of restart is done:

> Without shutting down any hardware 

So we have two options:

1. Add a new notifier list that *does* get called in the
    emergency_restart() path. Then register this driver with
    with that.

2. Remove emergency_restart() from the kernel. It only has a
    couple of callers, and most of those callers look like they
    should instead be using hw_protection_reboot() or panic().
    That way all reboot paths activate the reboot notifiers.
    Kinda wondering why you think you need to handle the
    emergency_restart() case at all, will even be a thing on
    your hardware, i.e. is this a real problem at all?

Having this driver claim to be a real reboot handler to sneak
around doing one of the above is preventing some cleanup I am
working on. So if either of the above two options work for you
just let me know, I'll help out in implementing them for you.

Thanks,
Andrew

> Kind regards
> Uffe
> 
> [1]
> https://lore.kernel.org/all/1445440540-21525-1-git-send-email-javier@osg.samsung.com/
> 
>>
>> Signed-off-by: Andrew Davis <afd@ti.com>
>> ---
>>   drivers/mmc/core/pwrseq_emmc.c | 8 +-------
>>   1 file changed, 1 insertion(+), 7 deletions(-)
>>
>> diff --git a/drivers/mmc/core/pwrseq_emmc.c b/drivers/mmc/core/pwrseq_emmc.c
>> index 3b6d69cefb4eb..d5045fd1a02c1 100644
>> --- a/drivers/mmc/core/pwrseq_emmc.c
>> +++ b/drivers/mmc/core/pwrseq_emmc.c
>> @@ -70,14 +70,8 @@ static int mmc_pwrseq_emmc_probe(struct platform_device *pdev)
>>                  return PTR_ERR(pwrseq->reset_gpio);
>>
>>          if (!gpiod_cansleep(pwrseq->reset_gpio)) {
>> -               /*
>> -                * register reset handler to ensure emmc reset also from
>> -                * emergency_reboot(), priority 255 is the highest priority
>> -                * so it will be executed before any system reboot handler.
>> -                */
>>                  pwrseq->reset_nb.notifier_call = mmc_pwrseq_emmc_reset_nb;
>> -               pwrseq->reset_nb.priority = 255;
>> -               register_restart_handler(&pwrseq->reset_nb);
>> +               register_reboot_notifier(&pwrseq->reset_nb);
>>          } else {
>>                  dev_notice(dev, "EMMC reset pin tied to a sleepy GPIO driver; reset on emergency-reboot disabled\n");
>>          }
>> --
>> 2.39.2
>>

