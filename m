Return-Path: <linux-kernel+bounces-17975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FA13825631
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 15:56:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2CF91F22318
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 14:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 818E72E63B;
	Fri,  5 Jan 2024 14:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="sgpU6O11"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-19.smtpout.orange.fr [80.12.242.19])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 066E02E631;
	Fri,  5 Jan 2024 14:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.18] ([92.140.202.140])
	by smtp.orange.fr with ESMTPA
	id LlU8rZXOax8edLlU8rWP3j; Fri, 05 Jan 2024 15:47:46 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1704466066;
	bh=3o+5IuQI3KZqIsQuHVkAVYAXMFpoFfomYAL99cJxMGI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=sgpU6O11WbmPfG4vpUH2O7BN1pofyUbOrstaUMQg0d2e0uzP2AewwyzIk/YctiQZO
	 CWGCK7hoX12xjrEAgBUI4ER5Ayb44ki9D7O8crIiCjzpQgnROgUMcIt1DNqlNyCEor
	 AIMKuqcpZEvg6kJcg/vxxLgNOvxjnRLbCYUALcmplkO0gGieZ6WOfraYiqJ3TcEtgF
	 vTFfCoVYx7KV+kxZpGe9Qdf9ISAqdEIMPoPGLzjitMYIvdoeD9RnTeetFELFUoiDJy
	 6NC8CmhTBq8lxs1LPup6OmvL+8i8GwzaRCpUYUaAWJ8VPwrhsPWlSj33xz8dBLqbGn
	 y8i+4UGB10THw==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Fri, 05 Jan 2024 15:47:46 +0100
X-ME-IP: 92.140.202.140
Message-ID: <a821c56b-2153-4464-8323-66ba62348f59@wanadoo.fr>
Date: Fri, 5 Jan 2024 15:47:43 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] thermal: core: Save a few bytes of memory when
 registering a cooling device
Content-Language: fr
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>,
 Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
 alexis.lothore@bootlin.com, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org, linux-pm@vger.kernel.org
References: <4a3658efad8f6247ed8c477717dc2820b72319d0.1704462287.git.christophe.jaillet@wanadoo.fr>
 <CAJZ5v0hqaJ79BUj_hWDmErCVvJdBJ8o9fcHxcZDyP4+C4iDVxQ@mail.gmail.com>
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <CAJZ5v0hqaJ79BUj_hWDmErCVvJdBJ8o9fcHxcZDyP4+C4iDVxQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 05/01/2024 à 14:50, Rafael J. Wysocki a écrit :
> On Fri, Jan 5, 2024 at 2:45 PM Christophe JAILLET
> <christophe.jaillet@wanadoo.fr> wrote:
>>
>> Some *thermal_cooling_device_register() calls pass a string literal as the
>> 'type' parameter.
>>
>> So kstrdup_const() can be used instead of kfree() to avoid a memory
> 
> I guess you mean kstrdup()?

Sure.
Stupid cut'n'paste typo. Thx for catching it.

Should I resend, or can it be fixed if/when the patch is applied?

CJ

> 
>> allocation in such cases.
>>
>> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>> ---
>>   drivers/thermal/thermal_core.c | 6 +++---
>>   include/linux/thermal.h        | 2 +-
>>   2 files changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
>> index fa88d8707241..d21225ddbf10 100644
>> --- a/drivers/thermal/thermal_core.c
>> +++ b/drivers/thermal/thermal_core.c
>> @@ -846,7 +846,7 @@ static void thermal_release(struct device *dev)
>>                              sizeof("cooling_device") - 1)) {
>>                  cdev = to_cooling_device(dev);
>>                  thermal_cooling_device_destroy_sysfs(cdev);
>> -               kfree(cdev->type);
>> +               kfree_const(cdev->type);
>>                  ida_free(&thermal_cdev_ida, cdev->id);
>>                  kfree(cdev);
>>          }
>> @@ -918,7 +918,7 @@ __thermal_cooling_device_register(struct device_node *np,
>>          cdev->id = ret;
>>          id = ret;
>>
>> -       cdev->type = kstrdup(type ? type : "", GFP_KERNEL);
>> +       cdev->type = kstrdup_const(type ? type : "", GFP_KERNEL);
>>          if (!cdev->type) {
>>                  ret = -ENOMEM;
>>                  goto out_ida_remove;
>> @@ -969,7 +969,7 @@ __thermal_cooling_device_register(struct device_node *np,
>>   out_cooling_dev:
>>          thermal_cooling_device_destroy_sysfs(cdev);
>>   out_cdev_type:
>> -       kfree(cdev->type);
>> +       kfree_const(cdev->type);
>>   out_ida_remove:
>>          ida_free(&thermal_cdev_ida, id);
>>   out_kfree_cdev:
>> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
>> index bf84595a4e86..052c72c0fa17 100644
>> --- a/include/linux/thermal.h
>> +++ b/include/linux/thermal.h
>> @@ -102,7 +102,7 @@ struct thermal_cooling_device_ops {
>>
>>   struct thermal_cooling_device {
>>          int id;
>> -       char *type;
>> +       const char *type;
>>          unsigned long max_state;
>>          struct device device;
>>          struct device_node *np;
>> --
>> 2.34.1
>>
> 
> 


