Return-Path: <linux-kernel+bounces-96199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E633187586F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 21:32:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16C441C21CF1
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 20:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75AD25B1FD;
	Thu,  7 Mar 2024 20:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="oZug5h7l"
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BC6A24A03
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 20:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709843542; cv=none; b=PH8M2jRBpzn+qV3TXA67/OCPhSxLGamtE+Qo4aAELBLJxp3lplCz+5rAcG8LvRA3uQTzC7vlnNan7HBdm1yleag+UKvLXIJaz3BbXCF1/JjwslGlHMmWTaQn6Z7ABYa9jYjNtR+scdZC6AG2LYOqLB0329/F+8gE+IOfmv+I0dQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709843542; c=relaxed/simple;
	bh=aoy4lfm5e7XBrRJC12aCy9XeTUDBYT8U/xtjKz6NU9c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DLwSTPHS+je4GZJh3nikDOxrw8/Gyf3/CDCEEyFedWdsQ2i7JAU9HbNLq466RuI2ZbnKHQwnNEMZByBkkIpyUUZFz2iWiHwRJqin19f6eQ7Fb8L6yvr7LYhlwPwdM+S2KX5LlN+HfjLPO63HvuNTotsAvyQsoD2P/eYwepeMVZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=oZug5h7l; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <c84fcdba-af50-4212-a8e3-f492c2b02ce4@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1709843538;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pbXTphN52BjwHWTyDQTbj2JLptBHr0UQKajyjco9BOI=;
	b=oZug5h7l7Zw6xwLepEhZgMlliKia0ash7bk0dziOvoBvrtVfdIaubqWCAUUQkuTehBoRUy
	LG8Q9f3c0nW2W/4GiD0BkrI3ZF0tQdkVuZrw2oZ6E18bTCWYmMTaB0w8TQSLPwm6CYzjvO
	1sH1iNHyTmre0HbRxutY7ZO/acz7fso=
Date: Fri, 8 Mar 2024 04:32:05 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 1/4] drm/bridge: Add fwnode based helpers to get the
 next bridge
Content-Language: en-US
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
 <45f59f31-1f03-4a96-adb6-25c7cdd5e8a1@linux.dev>
 <CAA8EJpqq1-cEke6wEFZFDnpz4tFBcL6HF3=Qtf-8Q3WbogLS8A@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sui Jingfeng <sui.jingfeng@linux.dev>
In-Reply-To: <CAA8EJpqq1-cEke6wEFZFDnpz4tFBcL6HF3=Qtf-8Q3WbogLS8A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Hi,


On 2024/3/8 03:37, Dmitry Baryshkov wrote:
> On Thu, 7 Mar 2024 at 21:20, Sui Jingfeng <sui.jingfeng@linux.dev> wrote:
>> Hi,
>>
>>
>> On 2024/3/8 02:43, Dmitry Baryshkov wrote:
>>>> +
>>>>    MODULE_AUTHOR("Ajay Kumar<ajaykumar.rs@samsung.com>");
>>>>    MODULE_DESCRIPTION("DRM bridge infrastructure");
>>>>    MODULE_LICENSE("GPL and additional rights");
>>>> diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
>>>> index 3606e1a7f965..d4c95afdd662 100644
>>>> --- a/include/drm/drm_bridge.h
>>>> +++ b/include/drm/drm_bridge.h
>>>> @@ -26,6 +26,7 @@
>>>>    #include <linux/ctype.h>
>>>>    #include <linux/list.h>
>>>>    #include <linux/mutex.h>
>>>> +#include <linux/of.h>
>>>>
>>>>    #include <drm/drm_atomic.h>
>>>>    #include <drm/drm_encoder.h>
>>>> @@ -721,6 +722,8 @@ struct drm_bridge {
>>>>           struct list_head chain_node;
>>>>           /** @of_node: device node pointer to the bridge */
>>>>           struct device_node *of_node;
>>> In my opinion, if you are adding fwnode, we can drop of_node
>>> completely. There is no need to keep both of them.
>>
>> But the 'struct device' have both of them contained, we should *follow the core*, right?
>> They are two major firmware subsystems (DT and ACPT), both are great and large, right?
>> Personally, I think the drm_bridge should embeds 'struct device', after all, drm bridge
>> are mainly stand for display bridges device. And also to reflect what you said: "to
>> reflect the hardware perfectly" and remove some boilerplate.
> struct device contains both because it is at the root of the hierarchy
> and it should support both API. drm_bridge is a consumer, so it's fine
> to have just one.
>

What I really means is that
if one day a 'struct device *dev' is embedded into struct drm_bridge,
we only need to improve(modify) the implement ofdrm_bridge_set_node().
This is *key point*. Currently, they(of_node and fwnode) point to the
same thing, it is also fine.

For the various drm bridge drivers implementations, the 'struct drm_bridge'
is also belong to the driver core category. drm bridges are also play the
producer role.

>> I think I'm not good enough to do such a big refactor, sorry. I believe that Maxime
>> and Laurent are the advanced programmers who is good enough to do such things, maybe
>> you can ask them for help?
> Well, you picked up the task ;-)


Well, my subject(title) is "*Allow* to use fwnode based API to get drm bridges".
not "Replace 'OF' with fwnode", My task is to provide an alternative solution
for the possible users. And to help improve code sharing and improve code reuse.
And remove some boilerplate. Others things beyond that is not being taken by
anybody. Thanks.


>
> But really, there is nothing so hard about it:
> - Change of_node to fw_node, apply an automatic patch changing this in
> bridge drivers.
> - Make drm_of_bridge functions convert passed of_node and comp
>
> After this we can start cleaning up bridge drivers to use fw_node API
> natively as you did in your patches 2-4.


Yes, it's not so hard. But I'm a little busy due to other downstream developing
tasks. Sorry, very sorry!

During the talk with you, I observed that you are very good at fwnode domain.
Are you willing to help the community to do something? For example, currently
the modern drm bridge framework is corrupted by legacy implement, is it possible
for us to migrate them to modern? Instead of rotting there? such as the lontium-lt9611uxc.c
which create a drm connector manually, not modernized yet and it's DT dependent.
So, there are a lot things to do.



Best Regards,
Sui.


