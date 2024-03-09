Return-Path: <linux-kernel+bounces-97871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DAD898770F0
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 13:03:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96EE7281D5D
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 12:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8052638F83;
	Sat,  9 Mar 2024 12:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="i0E6pVN2"
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 214C5EDD
	for <linux-kernel@vger.kernel.org>; Sat,  9 Mar 2024 12:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709985809; cv=none; b=M43cZH4EWvnWWKQ9LcDTos1033KKJUGXqPnhU6U3vkO+aO7eq/JFa68G5gzW1TsRz/3qzeGZgkRKfzsbXfUByUmBOCKxpyGpocKDC5pnOb8+7JYQ8K7tIb1NMoboAMvOd5UrsW94Yxc40eDF/qbXOLtKUvpUK4mhpx8u/3gRZsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709985809; c=relaxed/simple;
	bh=+G2vKevHrzC1uEml5HdORxxQr4XVz2gnv97uXrbdLjc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DePO+z3FwCbUeswQGjdUVSnoQsfiYoHK89W9amGeUKEsUNj/gFcnnP9xD9rhlRF0XatwWsnHwi3cGwedE+vU26y4Q2FZ9rDLbAMUhfGyL6OWl8eKEB618SH9cGTXzmnhm4m/Q0K7oNYlZ7zk1SFKVs/GrplzRnV09NDLOIbNYk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=i0E6pVN2; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <28492cfb-5327-46d5-8c08-233f1786ff44@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1709985804;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=axQl+5LrcSwPQ7Y79L1XQ/DDezVoFDIXlwRR++4w7oE=;
	b=i0E6pVN2RsKFRkkKlIL4UD3RFZkn0fPIwWzAu9aj89oddtgk9EwIl36OgqpuVwhcHs996e
	kcfXE839mR/cszn9zYEcFBz6g9CT0p5c4iKVsaD2nTiOhcmv/pRza/V7QrlFr7gduwZhuu
	JC2wELPl4O9bjqYGSEAYemZpwc0xPF8=
Date: Sat, 9 Mar 2024 20:03:14 +0800
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
 <c84fcdba-af50-4212-a8e3-f492c2b02ce4@linux.dev>
 <CAA8EJppTcPO3j7GpGcGbKPUjQ=3rTMMOrU1SYR3mtkWLztf2qQ@mail.gmail.com>
 <7535b3ba-6bbb-411c-82a4-cd4ac45de1a6@linux.dev>
 <CAA8EJpp3yd33pYweL_exrXMJ3g-m7-yjJrjiVMVMevOadBtt8g@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sui Jingfeng <sui.jingfeng@linux.dev>
In-Reply-To: <CAA8EJpp3yd33pYweL_exrXMJ3g-m7-yjJrjiVMVMevOadBtt8g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Hi,


On 2024/3/9 18:39, Dmitry Baryshkov wrote:
>> The code path of "creating a connector" plus the code path of "not creating a connector"
>> forms a 'side-by-side' implementation imo.
>>
>> Besides, I have repeated many times: the DT already speak everything.
>> Device drivers can completely know if there is a display connector OF device created and how many
>> display bridges in the whole chain. If there are connector device node in the DT, then it should
>> has a device driver bound to it(instead of create it manually) for a perfect implementation. As
>> you told me we should not*over play*  the device-driver model, right?
> Please, don't mix the connector node in DT and the drm_connector. If
> you check the code, you will see that the driver for hdmi-connector,
> dp-connector and other such devices creates a drm_bridge.


OK, I'm not mixed them, I'm very clear from the very beginning. I have checked
the code years ago. Let's make it clear by iterating one more time:

If DT contains one or more HDMI connector node, then there will be one or
more display connector platform devices created by OF core, Then, according to
your "don't overplay device-driver model" criterion or modern drm bridge standard,
we shouldn't create a display connector instance in the drm birdge driver, right?

As otherwise we will have two display connector driver (or code) for a single entity,
right?

Another side effect is that
when you create a hdmi display connector instance manually without reference to the
DT, then *you made an assumption!*. But there are users who have don't a different
need(or  different typology), for example, they need to read edid directly from the
KMS driver side. This may because the i2c bus is directly connected to the connector
part, but the display bridge's I2C slave interface. sii9022, it66121 and tfp410 support
this kind of usage.

So the real problem is that it is a policy level code  when you creating a hdmi
display connector instance manually without reference to the DT in a common drm bridge
driver, not a mechanism.


