Return-Path: <linux-kernel+bounces-159033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93E508B2879
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 20:53:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 497751F22534
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 18:53:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B00A914EC58;
	Thu, 25 Apr 2024 18:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="L+80yaQb"
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D747112C7FF
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 18:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714071215; cv=none; b=gzeY8wk7JaUQkp1L4Gyz58221CpOoUujbb6iBuDZ9Jq++wduvqth54WrF6214qe5+mU+tstcm5yRozR7V3Z+cfXeDyWz4Pmekz9IDNYDa5N2jdVG5/9NOV3Q9TUC7OLPtLLnEfcI3fpapNM7+zFtHxJOpPjkv3OLZY2VsSxYCIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714071215; c=relaxed/simple;
	bh=re971cS/rGk+4wp+vkc/sEN1VDcEfvgLrnON22YFVwc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=q+IncooqZ3w+1fq8Zf5j2bKeMoBBZrmDgW+E2aN8aLAO0z990Dzep4hvomC+X81LWxETaU7ssQuB8WVi44gheaEUuVOA3DJz4na0+Grf5Tx2YjjxVnAWmsuYuTu+7rxkQq89blHHHRLU+cd5OdwOC4HEBM6pMRYSwxx61NRAq0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=L+80yaQb; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <ce6a480d-80b3-46b0-a32d-26bc6480d02f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1714071211;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aznp4QsPEUD4ueRh6l09AkRprYe0zqCUY4MqSs3knq0=;
	b=L+80yaQbJXmGtikX5eolbc2kg73dE+2Wliyg6C1xKn5Vn8P6BJWALMCAPybMmp5IB44/pg
	IpsFzNoVd2hUhgKgopzlWktU/54ejgClHqTEm+x/6WpQ3V6EsHe2I7KlvZr1pmBBoApEpU
	0DCiJ0Rlkkn4j6TVo09BrMBXA7NRLv0=
Date: Fri, 26 Apr 2024 02:53:22 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [v1,1/3] drm/panel: ili9341: Correct use of device property APIs
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sui Jingfeng <sui.jingfeng@linux.dev>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Randy Dunlap <rdunlap@infradead.org>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Cc: Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg
 <sam@ravnborg.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
References: <20240425142706.2440113-2-andriy.shevchenko@linux.intel.com>
 <c2d41916-0b6c-43b5-98eb-514eb0511f84@linux.dev>
Content-Language: en-US
In-Reply-To: <c2d41916-0b6c-43b5-98eb-514eb0511f84@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Hi,


On 2024/4/26 02:08, Sui Jingfeng wrote:
> Hi,
>
>
> On 2024/4/25 22:26, Andy Shevchenko wrote:
>> It seems driver missed the point of proper use of device property APIs.
>> Correct this by updating headers and calls respectively.
>
> You are using the 'seems' here exactly saying that you are not 100% sure.
>
Using the word 'seems' here exactly saying that you are not 100% sure.


> And this patch is has the risks to be wrong.
>
This patch has the risks of to be wrong.


> Simple because the "ili9341_probe() ---> ili9341_dbi_prob()" code path
> is DT dependent.
>
Simply because part of the driver is DT dependent, plus its code(implementation)
is deep(tight) coupling, as a result, it is became total DT dependent.


> First of all, the devm_of_find_backlight() is called in 
> ili9341_dbi_probe()
,
> under *non-DT* environment, 

Under *non-DT* environment, the use case probably should take into consideration.
Since you remove it, then we can't stop imagining. But if we really care about
the usage case on DT based systems, There is *NO* difference between the
device_get_match_data() and the of_device_get_match_data(). This is the reason
why I'm saying that you patch has the *ZERO* effects.

And again, on non-DT systems, if there is no acpi_device_id stuff, calling
the device_get_match_data() function will just get NULL. Which is nearly a
undefined behavior. So the 'OF 'removal is don't really make much sense.

But there is a way to save the awkward situation, that is, helps to get
this patch[1] merged. Then we still tenable both at the practice side
and at the concept side.
  

[1] https://patchwork.freedesktop.org/patch/590653/?series=131296&rev=2

> devm_of_find_backlight() is just a just a  no-op and will return NULL. 
> NULL is not an error code, so ili9341_dbi_probe()
> won't rage quit. 

[...]

> But the several side effect is that the backlight will NOT works at all.
>
s/several/severe


> It is actually considered as fatal bug for *panels* if the backlight of
> it is not light up, 


It's fatal error if backlight is not adjustable or not light-up at all.


>

[...]


> Even though the itself panel is refreshing framebuffers, 

Even though the panel itself is consuming frame-buffers and displaying.
But if the backlight not work, the screen is extremely dark, we can not
see as well.

Besides the ili9341_dbi_probe() requires additional device properties to
able to work very well. Especially on the rotate screen use case.



