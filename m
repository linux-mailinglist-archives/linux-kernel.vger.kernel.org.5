Return-Path: <linux-kernel+bounces-96092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 505938756FB
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 20:21:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5F3D1F22AC1
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 19:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D15F1369A4;
	Thu,  7 Mar 2024 19:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fLR491Ky"
Received: from out-175.mta0.migadu.com (out-175.mta0.migadu.com [91.218.175.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E546D135A7E
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 19:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709839227; cv=none; b=O55z6baVMssaFeqQyf+7ZQGe/lffXSxH4sbrss8hqsvkIhoEmW9yD0mDGVI7gvvk5Y2c8b0Dpf0Csng4gcU1K8TWlIQAtfSftI1uYooTPWcCYRMCob37wTCh7xRwrPxAEwhpc2CFs4QMGw25LKh/QCjEYZqG4wJjQ0MotATmnLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709839227; c=relaxed/simple;
	bh=66/OiU9kekT0wVFBm33Xdi8g7UDAgmAY/pPMP3kjYO4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DMOOeUuR3UY8ZckkAQm3LzY9U692Lg2m4+R+sT2A2YST8+JVnM/aw/eTu01ETJmktGYZ41FDTdOz99e8s2IfBbOvyhsDEQpp9VHQkVTZ+yRszf9LyMX5jmFiLr5hEB4aU/oC44xw7T6H+jhUHtgV5mB0qVeObDiedrgBqRiMiaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fLR491Ky; arc=none smtp.client-ip=91.218.175.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <45f59f31-1f03-4a96-adb6-25c7cdd5e8a1@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1709839221;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VnFnbqDeKPmVvi03N+VBYRVISwQV8TV/BYHIxfxeVJo=;
	b=fLR491KyRBd+vuj8QblEQG+I3EUMqpmzX4/kZPi2b4kFpWdfqOZPkLeLkSFaHXbbxDR2av
	hMmBeUV/mrETplF47OVMIQLbBa+PcklOjWcl0Vm8FU0TmRLCuTaogLLkIOyM8qgIrw2PB3
	SUkHxI+kqGAdhh7nm8CaTKrYZ9mrVA8=
Date: Fri, 8 Mar 2024 03:20:07 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 1/4] drm/bridge: Add fwnode based helpers to get the
 next bridge
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Phong LE <ple@baylibre.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20240307172334.1753343-1-sui.jingfeng@linux.dev>
 <20240307172334.1753343-2-sui.jingfeng@linux.dev>
 <CAA8EJpp8tsHi0RhsJXG+r6nOsV3AUC_n6jNHL0Cr6Ku2h3NMog@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sui Jingfeng <sui.jingfeng@linux.dev>
In-Reply-To: <CAA8EJpp8tsHi0RhsJXG+r6nOsV3AUC_n6jNHL0Cr6Ku2h3NMog@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Hi,


On 2024/3/8 02:43, Dmitry Baryshkov wrote:
>> +
>>   MODULE_AUTHOR("Ajay Kumar<ajaykumar.rs@samsung.com>");
>>   MODULE_DESCRIPTION("DRM bridge infrastructure");
>>   MODULE_LICENSE("GPL and additional rights");
>> diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
>> index 3606e1a7f965..d4c95afdd662 100644
>> --- a/include/drm/drm_bridge.h
>> +++ b/include/drm/drm_bridge.h
>> @@ -26,6 +26,7 @@
>>   #include <linux/ctype.h>
>>   #include <linux/list.h>
>>   #include <linux/mutex.h>
>> +#include <linux/of.h>
>>
>>   #include <drm/drm_atomic.h>
>>   #include <drm/drm_encoder.h>
>> @@ -721,6 +722,8 @@ struct drm_bridge {
>>          struct list_head chain_node;
>>          /** @of_node: device node pointer to the bridge */
>>          struct device_node *of_node;
> In my opinion, if you are adding fwnode, we can drop of_node
> completely. There is no need to keep both of them.


But the 'struct device' have both of them contained, we should *follow the core*, right?
They are two major firmware subsystems (DT and ACPT), both are great and large, right?
Personally, I think the drm_bridge should embeds 'struct device', after all, drm bridge
are mainly stand for display bridges device. And also to reflect what you said: "to
reflect the hardware perfectly" and remove some boilerplate.

I think I'm not good enough to do such a big refactor, sorry. I believe that Maxime
and Laurent are the advanced programmers who is good enough to do such things, maybe
you can ask them for help?

Beside this, other reviews are acceptable and will be fixed at the next version,
thanks a lot for review.


Best Regards,
Sui


