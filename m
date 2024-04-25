Return-Path: <linux-kernel+bounces-159153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DB308B2A04
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 22:43:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2CE51F22AB8
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 20:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3979C153801;
	Thu, 25 Apr 2024 20:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DJAW2FW+"
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 481E915250D
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 20:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714077813; cv=none; b=AWZ8jvmVRqZF+LPhpTSLeRFeHtKGrI0rxFIVQkF2T6R95HkuGZCWgigkigIgfJU0bF5X7EcZGtsK/hrQ22kPY9ydb46iHDqpUPaN+Vrs0AHSdQ6K50hy+RqzXtEAQQ6HWt/7Yfv1DTVYkuDwK5kVIPif5WotwromTVmbjWeQDG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714077813; c=relaxed/simple;
	bh=3hvw0+YukQ3HV4tpP34vO998x2VY2TniSSuewZeedqw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UQqq6A9p3uYAFFQ3fxDw4UVkU83d07fs6n+O0UBc39xDE475WQulhTJSLxKtdWgIr580cKsYFLv52Jlw6S0zpwthIsJBPL2tJRKlK+PDX4o2FOVNHbzeQBgzgbHtT1flJ8Iun8AcVhIIDHn5W4mQSaDEQ1uol4UwqSnXSNqqX5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DJAW2FW+; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <2599705c-0a64-4742-b1d7-330e9fde6e7a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1714077808;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u2mtItP+V03mGsYiNN70hhu7OHc79xAcYyNtntuYPhE=;
	b=DJAW2FW+hkuxUhr1TylwYEe1ZWXxjgdQVUkI0WgbomDCeHx40HNnOZ+0CtTRk2Y9d99vDm
	NxsClUQHg7mixWEJF7rc5Z+lOolnKYNLibvs93PK0jKZeNsmCbDg5ZEJuzxT6S7qXEbAZE
	tP8vF3HcdiVvel/D5rkp0lwlmCfR5io=
Date: Fri, 26 Apr 2024 04:43:18 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [v1,1/3] drm/panel: ili9341: Correct use of device property APIs
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Randy Dunlap <rdunlap@infradead.org>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Jessica Zhang <quic_jesszhan@quicinc.com>,
 Sam Ravnborg <sam@ravnborg.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
References: <20240425142706.2440113-2-andriy.shevchenko@linux.intel.com>
 <c2d41916-0b6c-43b5-98eb-514eb0511f84@linux.dev>
 <ZiqqiAztCaiAgI8e@smile.fi.intel.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sui Jingfeng <sui.jingfeng@linux.dev>
In-Reply-To: <ZiqqiAztCaiAgI8e@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Hi,


On 2024/4/26 03:10, Andy Shevchenko wrote:
> On Fri, Apr 26, 2024 at 02:08:16AM +0800, Sui Jingfeng wrote:
>> On 2024/4/25 22:26, Andy Shevchenko wrote:
>>> It seems driver missed the point of proper use of device property APIs.
>>> Correct this by updating headers and calls respectively.
>> You are using the 'seems' here exactly saying that you are not 100% sure.
>>
>> Please allow me to tell you the truth: This patch again has ZERO effect.
>> It fix nothing. And this patch is has the risks to be wrong.
> Huh?! Really, stop commenting the stuff you do not understand.


I'm actually a professional display drivers developer at the downstream
in the past, despite my contribution to upstream is less. But I believe
that all panel driver developers know what I'm talking about. So please
have take a look at my replies.


>> Simple because the "ili9341_probe() ---> ili9341_dbi_prob()" code path
>> is DT dependent.
>>
>> First of all, the devm_of_find_backlight() is called in ili9341_dbi_probe()
>> under *non-DT* environment, devm_of_find_backlight() is just a just a
>> no-op and will return NULL. NULL is not an error code, so ili9341_dbi_probe()
>> won't rage quit. But the several side effect is that the backlight will
>> NOT works at all.
> Is it a problem?

Yes, it is.
  

The core problem is that the driver you are modifying has *implicit* *dependency* on DT.
The implicit dependency is due to the calling of devm_of_find_backlight(). This function
is a no-op under non-DT systems. Therefore, before the devm_of_find_backlight() and
the device_get_match_data() function can truly DT independent.

Removing the "OF" dependency just let the tigers run out from the jail.

It is not really meant to targeting at you, but I thinks, all of drm_panel drivers
that has the devm_of_find_backlight() invoked will suffer such concerns.
In short, the reason is that the *implicit* *dependency* populates and
the undefined behavior gets triggered.


I'm sure you know that device_get_match_data() is same with of_device_get_match_data()
for DT based systems. For non DT based systems, device_get_match_data() is just *undefined*
Note that ACPI is not in the scope of the discussion here, as all of the drm bridges and
panels driver under drivers/gpu/drm/ hasn't the ACPI support yet. Therefore, at present,
it safe to say that device_get_match_data() is *undefined* under no-DT environment.

Removing the "OF" dependency hints to us that it allows the driver to be probed as a
pure SPI device under non DT systems. When device_get_match_data() is called, it returns
NULL to us now. As a result, the drm driver being modified will tears down.

See bellow code snippet extracted frompanel-ilitek-ili9341.c:


```
	ili->conf = of_device_get_match_data(dev);
	if (!ili->conf) {
		dev_err(dev, "missing device configuration\n");
		return -ENODEV;
	}
```

>> It is actually considered as fatal bug for *panels* if the backlight of
>> it is not light up, at least the brightness of *won't* be able to adjust.
>> What's worse, if there is no sane platform setup code at the firmware
>> or boot loader stage to set a proper initial state. The screen is complete
>> dark. Even though the itself panel is refreshing framebuffers, it can not
>> be seen by human's eye. Simple because of no backlight.
> Can you imagine that I may have different hardware that considered
> this is non-fatal error?
>
Yes, I can imagine.

I believe you have the hardware which make you patch correct to run
in 99.9% of all cases. But as long as there one bug happened, you patch
are going to be blamed.

Because its your patch that open the door, both from the perceptive of
practice and from the perceptive of the concept (static analysis).

>> Second, the ili9341_dbi_probe() requires additional device properties to
>> be able to works very well on the rotation screen case. See the calling
>> of "device_property_read_u32(dev, "rotation", &rotation)" in
>> ili9341_dbi_probe() function.
> Yes, exactly, and how does it object the purpose of this patch?

Because under *non-DT* environment, your commit message do not give a
valid description, how does the additional device property can be acquired
is not demonstrated.

And it is exactly your patch open the non-DT code path (way or possibility).
It isn't has such risks before your patch is applied. In other words,
previously, the driver has the 'OF' dependency as the guard, all of the
potential risk(or problem) are suppressed. It is a extremely safe policy,
and it is also a extremely perfect defend.

And suddenly, you patch release the dangerous tiger from the cage.
So I think you can imagine...

>> Combine with those two factors, it is actually can conclude that the
>> panel-ilitek-ili9394 driver has the *implicit* dependency on 'OF'.
>> Removing the 'OF' dependency from its Kconfig just trigger the
>> leakage of such risks.
> What?!
>
Posting a patch is actually doing the defensive works, such a saying
may not sound fair for you, but this is just the hash cruel reality.
Sorry for saying that. :(


>> My software node related patches can help to reduce part of the potential
>> risks, but it still need some extra work. And it is not landed yet.
> Your patch has nothing to do with this series.

With my patch applied, this is way to meet the gap under non-DT systems.
Users of this driver could managed to attach(complete) absent properties
to the SPI device with software node properties. Register the swnode
properties group into the system prior the panel driver is probed. There
may need some quirk. But at the least there has a way to go.  When there
has a way to go, things become self-consistent. Viewed from both the
practice of viewpoint and the concept of viewpoint.

And the dangerous tiger will steer its way to the direction of "ACPI
support is missing". But both of will be safe then.

-- 
Best regards,
Sui


