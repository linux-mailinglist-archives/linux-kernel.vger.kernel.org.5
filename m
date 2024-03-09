Return-Path: <linux-kernel+bounces-97866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13F7E8770A8
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 12:25:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EB241C20BCB
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 11:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72ECD383B0;
	Sat,  9 Mar 2024 11:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FZd5WXe+"
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A281338397
	for <linux-kernel@vger.kernel.org>; Sat,  9 Mar 2024 11:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709983551; cv=none; b=phjcwvZO/8YuamK3TXqW+9ort7KKiNF9zDnhxc7XZm72SEakXkXqL20w7NWVk62FXz25QJntTHc8rUJPFxxn5lJy8jGOAidlJmZVBJjw0pO63Sb2VKfhtKckf/kX6bAIevYpy1KnQjvf0AsWhf/ACJ+/gslowxBzyV5szN9a6hA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709983551; c=relaxed/simple;
	bh=84EES1hz80DnJmpO2XJ6xr9aeFaGyCWwF3S/dCaUCZs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FhqtaUArimk1WBfzMKgo9UGlhfxb9YsYDJOkZ13jC2Q5yyG9dBJLY2NfusZrsB7Dk/vlPl2iEF/rIYDHXHY/zcxDtq6c86vC7/V7IN7q9bltnkfdnIjpJTmhoYoGybcYpjslPSkN9Zt9/tB65ZzD1suh4cBcWwhL4tvdjP4wBnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FZd5WXe+; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <b573ec32-fe07-498c-abe7-f9a16bdc1c21@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1709983547;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JWRrdfVsYkQ+30BxDLA3NCMXnwM3kUkO1xE8cyE4gSs=;
	b=FZd5WXe+Nbya9sRvuKEsSuvLJiaoVaqBCyOHKmuiZoy3pFTz9CLxm1/1GoA7hcqrvGu3vG
	WN9M0MgNu8+Rw5sgQ6ubSzaZrJJCxplzQ0JhvKUtbi9/VGnAOx+WA9W7qjvHAk8BIkAt5U
	AKVyaH83deaQ1JyEsRy6DDzOHWYzaN4=
Date: Sat, 9 Mar 2024 19:25:36 +0800
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
 <45f59f31-1f03-4a96-adb6-25c7cdd5e8a1@linux.dev>
 <CAA8EJpqq1-cEke6wEFZFDnpz4tFBcL6HF3=Qtf-8Q3WbogLS8A@mail.gmail.com>
 <c84fcdba-af50-4212-a8e3-f492c2b02ce4@linux.dev>
 <CAA8EJppTcPO3j7GpGcGbKPUjQ=3rTMMOrU1SYR3mtkWLztf2qQ@mail.gmail.com>
 <7535b3ba-6bbb-411c-82a4-cd4ac45de1a6@linux.dev>
 <CAA8EJpp3yd33pYweL_exrXMJ3g-m7-yjJrjiVMVMevOadBtt8g@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sui Jingfeng <sui.jingfeng@linux.dev>
In-Reply-To: <CAA8EJpp3yd33pYweL_exrXMJ3g-m7-yjJrjiVMVMevOadBtt8g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Hi,


On 2024/3/9 18:39, Dmitry Baryshkov wrote:
> On Sat, 9 Mar 2024 at 11:33, Sui Jingfeng <sui.jingfeng@linux.dev> wrote:
>> Hi,
>>
>>
>> On 2024/3/8 04:40, Dmitry Baryshkov wrote:
>>>>> But really, there is nothing so hard about it:
>>>>> - Change of_node to fw_node, apply an automatic patch changing this in
>>>>> bridge drivers.
>>>>> - Make drm_of_bridge functions convert passed of_node and comp
>>>>>
>>>>> After this we can start cleaning up bridge drivers to use fw_node API
>>>>> natively as you did in your patches 2-4.
>>>> Yes, it's not so hard. But I'm a little busy due to other downstream developing
>>>> tasks. Sorry, very sorry!
>>>>
>>>> During the talk with you, I observed that you are very good at fwnode domain.
>>>> Are you willing to help the community to do something? For example, currently
>>>> the modern drm bridge framework is corrupted by legacy implement, is it possible
>>>> for us to migrate them to modern? Instead of rotting there? such as the lontium-lt9611uxc.c
>>>> which create a drm connector manually, not modernized yet and it's DT dependent.
>>>> So, there are a lot things to do.
>>> Actually, lontium-lt9611uxc.c does both of that 😉 It supports
>>> creating a connector and it as well supports attaching to a chain
>>> without creating a connector. Pretty nice, isn't it?
>>
>> But why the drm_bridge_connector helpers and/or the drm_connector bridge can't suit you need?
>> Coding this way just add boilerplate into drm bridge subsystem, right?
> Because there are platforms, like iMX LCDIF which can use the
> lt9611uxc bridge, but do not make use of the drm_bridge_connector yet.
>

Well, I have just grepped across the drm-tip kernel branch, but I don't find
iMX LCDIF you mentioned. See the search results pasted at bellow.


$ find . -name "*.dts" -type f | xargs grep "lontium,lt9611uxc"
/arm64/boot/dts/qcom/sm8450-hdk.dts:		compatible = "lontium,lt9611uxc";
/arm64/boot/dts/qcom/qrb5165-rb5.dts:		compatible = "lontium,lt9611uxc";
/arm64/boot/dts/qcom/qrb2210-rb1.dts:		compatible = "lontium,lt9611uxc";
/arm64/boot/dts/qcom/qrb4210-rb2.dts:		compatible = "lontium,lt9611uxc";
/arm64/boot/dts/qcom/sm8350-hdk.dts:		compatible = "lontium,lt9611uxc";


So I can't see the drm driver that you refer to, can you pointed it out for study
purpose? Even it's exist, however, back to that time, why don't you posting a patch
to switch it to the canonical design as you mentioned and give the community a clean
design?
  
And those are just *reasons*, from the viewpoint of the *result*.
The merged patch results in a 'side-by-side' implement and boilerplate added
into drm bridges subsystem, the results doesn't change no matter what the
reason is, right?


