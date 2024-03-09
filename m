Return-Path: <linux-kernel+bounces-97830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF95087701A
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 10:33:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E11301C20D59
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 09:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A789381A4;
	Sat,  9 Mar 2024 09:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uSUNaqL3"
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7455337141
	for <linux-kernel@vger.kernel.org>; Sat,  9 Mar 2024 09:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709976811; cv=none; b=ZWlqJd7tKZy7qWir82keHeK/+KgAA7ih459rZ1N41TEwzF31zJFboTb+eIs2604cCiE8IFdLhae3YbFqlrZutU05p1/LKgsJhzdvY4YUXs8EdLqd48YwOUdBA6pqFbKRq0j6kd2rwz3rnchGPSwhIRT6bHp0SMEuFE+VUc4SKsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709976811; c=relaxed/simple;
	bh=ku3/mf8syFhzDXGsMD87IO9efzaJJWCG+R1Xp/7u4qU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bew0DI44QmNLPec3D8x/UwCHyfD93v3Pp8oSsyxj9+qKex62lKtrm5fAbQelBQluW4S1zhiGU6bydClUsRO98s7ZOLM5actil143V6u0p/znQemKwRRRZ7XlrWaGmRMqpqgy16S8NOTwjPvv2nRgfkELK9MWKHh781XoLeLbu3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uSUNaqL3; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <7535b3ba-6bbb-411c-82a4-cd4ac45de1a6@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1709976806;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ku3/mf8syFhzDXGsMD87IO9efzaJJWCG+R1Xp/7u4qU=;
	b=uSUNaqL3Dlk9kk3cXy6TMM/nULPd1TJgzG+cX6gxCONOyfWCOJHRxukYxDymxZFe3aagoX
	PQ7pWtD1aYYqxzefhTs9hr78HhHSfHZWX7VNTp+EgEGqfYgpMpicIpZqSkOUdAhA75xI1B
	V0g5+hntGUtW2BbeGz+r4LdOIrCMLRs=
Date: Sat, 9 Mar 2024 17:33:01 +0800
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
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sui Jingfeng <sui.jingfeng@linux.dev>
In-Reply-To: <CAA8EJppTcPO3j7GpGcGbKPUjQ=3rTMMOrU1SYR3mtkWLztf2qQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Hi,


On 2024/3/8 04:40, Dmitry Baryshkov wrote:
>>> But really, there is nothing so hard about it:
>>> - Change of_node to fw_node, apply an automatic patch changing this in
>>> bridge drivers.
>>> - Make drm_of_bridge functions convert passed of_node and comp
>>>
>>> After this we can start cleaning up bridge drivers to use fw_node API
>>> natively as you did in your patches 2-4.
>> Yes, it's not so hard. But I'm a little busy due to other downstream developing
>> tasks. Sorry, very sorry!
>>
>> During the talk with you, I observed that you are very good at fwnode domain.
>> Are you willing to help the community to do something? For example, currently
>> the modern drm bridge framework is corrupted by legacy implement, is it possible
>> for us to migrate them to modern? Instead of rotting there? such as the lontium-lt9611uxc.c
>> which create a drm connector manually, not modernized yet and it's DT dependent.
>> So, there are a lot things to do.
> Actually, lontium-lt9611uxc.c does both of that 😉 It supports
> creating a connector and it as well supports attaching to a chain
> without creating a connector. Pretty nice, isn't it?


But why the drm_bridge_connector helpers and/or the drm_connector bridge can't suit you need?
Coding this way just add boilerplate into drm bridge subsystem, right?


The code path of "creating a connector" plus the code path of "not creating a connector"
forms a 'side-by-side' implementation imo.

Besides, I have repeated many times: the DT already speak everything.
Device drivers can completely know if there is a display connector OF device created and how many
display bridges in the whole chain. If there are connector device node in the DT, then it should
has a device driver bound to it(instead of create it manually) for a perfect implementation. As
you told me we should not *over play* the device-driver model, right?


