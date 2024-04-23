Return-Path: <linux-kernel+bounces-154545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 866F68ADD71
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 08:22:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B81211C20F1F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 06:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 844F42261D;
	Tue, 23 Apr 2024 06:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vocU1hcI"
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EBEC225AF
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 06:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713853330; cv=none; b=KBbOnhZ5Ufx6tfR9ts8exzOBJt+uBc4HQdso2C3oTCscIA6PzRYFeKihHqs7a0OutxXPDPe8UPGiFwlSvFRc3bNKNh/xWsCmZmazXCV9RIgtQp1XKFZV6CgJla4ZwSdqosfGRr0+d9mD08rImIo5xrfBWY9O9FV8rcl3K5Jd6oA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713853330; c=relaxed/simple;
	bh=p7mT1mrDIoXnSA84WhCbJ7mewQVDNwgaGH3G+4j9vmk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gGyT/9o1NBi4/ilNXXHlTzJlG+K4d+CNWOJ0/w56Ug+HV9hI3b3AixkfNMz/P+hu3YJKOU93I0KfJrmBavY28nH/8XnPqm3cPhkujxjq7s1l06apj36q//eU9lFN9sLKoT1HR6GmYYFbTXYrD0ZRg1OFiuhSinpmzUZfw5vCU4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vocU1hcI; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <ecbf2d04-f1e4-453d-b24c-f984c2fa1d1b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1713853325;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Tvs8T44TPQ+aZe85ozLPkk1OZqgZ5bUavSfbQMGyH+o=;
	b=vocU1hcIndM/wqxveJm4cFavglkhOpuXm9yHhE3wBj7RYgF7UpLthNEnSHCGOq9Yljmjhk
	unX7WJUaUimwvQrH4YieB+zKr+LkLfmw6n6jxAZjb5nMHobVfPXLDQnOE4lroFooBooDow
	j6x1d08DbT7rgwx59efvckX4l927RN0=
Date: Tue, 23 Apr 2024 14:21:53 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v4 1/9] drm/bridge: Allow using fwnode API to get the next
 bridge
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Sui Jingfeng <sui.jingfeng@linux.dev>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss
 <rfoss@kernel.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>, Jonas Karlman <jonas@kwiboo.se>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Phong LE <ple@baylibre.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20240422191903.255642-1-sui.jingfeng@linux.dev>
 <20240422191903.255642-2-sui.jingfeng@linux.dev>
 <xsfrnucued63q2amv7betkvgks6bhssubhjcryghkcloytixj4@ukmak4xwyjtg>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sui Jingfeng <sui.jingfeng@linux.dev>
In-Reply-To: <xsfrnucued63q2amv7betkvgks6bhssubhjcryghkcloytixj4@ukmak4xwyjtg>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Hi,


On 2024/4/23 03:51, Dmitry Baryshkov wrote:
> On Tue, Apr 23, 2024 at 03:18:55AM +0800, Sui Jingfeng wrote:
>> Currently, the various display bridge drivers rely on OF infrastructures
>> to works very well, yet there are platforms and/or devices absence of 'OF'
>> support. Such as virtual display drivers, USB display apapters and ACPI
>> based systems etc.
>>
>> Add fwnode based helpers to fill the niche, this allows part of the display
>> bridge drivers to work across systems. As the fwnode API has wider coverage
>> than DT counterpart and the fwnode graphs are compatible with the OF graph,
>> so the provided helpers can be used on all systems in theory. Assumed that
>> the system has valid fwnode graphs established before drm bridge drivers
>> are probed, and there has fwnode assigned to involved drm bridge instance.
>>
>> Signed-off-by: Sui Jingfeng <sui.jingfeng@linux.dev>
>> ---
>>   drivers/gpu/drm/drm_bridge.c | 74 ++++++++++++++++++++++++++++++++++++
>>   include/drm/drm_bridge.h     | 16 ++++++++
>>   2 files changed, 90 insertions(+)
>>
> [skipped]
>
>> diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
>> index 4baca0d9107b..a3f5d12a308c 100644
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
>>   	struct list_head chain_node;
>>   	/** @of_node: device node pointer to the bridge */
>>   	struct device_node *of_node;
>> +	/** @fwnode: fwnode pointer to the bridge */
>> +	struct fwnode_handle *fwnode;
> My comment is still the same: plese replace of_node with fwnode.

s/plese/please


Unless you can guarantee that *all* maintainers agree(welcome) with
the code changes involved by your proposal. Otherwise I'm going to
respect the domain specific maintainers to keep the code base as it
is.

I need the agreement of all other maintainers involved before I
could take any further action. I'm asking because I need to make sure
that such changes is what *everybody* wanted. As I have to respect
to respective maintainers(such as Daniel, Thomas, Maxime, Laurent
and all other maintainers of the drm miscellaneous).


>   It is more intrusive,

It is not only intrusive, but also annoying.

> however it will lower the possible confusion if the
> driver sets both of_node and fwnode.

The of_node and the fwnode can point to different thing, the potential
reason it the situation of them is not symmetrical.

  - On non-DT environment the of_node can point to NULL.
  - The reverse is also true, that is on DT environment the fwnode can also point to NULL
    if specific subsystem is not going to use it.
  - And USB display adapter can be using at any arch in theory, it can use both of them, or
    one of themm or neither of them.
  

This is a extremely flexible design, it's toward to future and also works with legacy.
So what's the confusion is?


> Also it will remove the necessity for helpers like drm_bridge_set_node().


Thedrm_bridge_set_node() is just a mimic to the device_set_node(), the 
struct device contains both of_node and fwnode as its data members.
I didn't see anyone complains about it, am I fail to understand something?


Or, let's put it straightforward, I'm going to follow your idea
if you could remove the of_node data member from the struct device.
Do you have the ability?


-- 
Best regards,
Sui


