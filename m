Return-Path: <linux-kernel+bounces-96236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D0931875911
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 22:09:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D89628645A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 21:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D12F13AA31;
	Thu,  7 Mar 2024 21:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="X1urbiyQ"
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 523C4139593
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 21:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709845769; cv=none; b=nde/02wr23otTbPfKIF6jb3ofvZDavjtWHna+wKAeIasT03G34Zdgiu++DxdCcVtORv838KYwi5lPn1tWFY+J3RlfOdPVMKsk4QAgeBms5+lY3QA3/PLmGRmt86uyZe1L8cVwCRYZ/31tu39jKPXTEewth83EvRGjeFLqX5zRzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709845769; c=relaxed/simple;
	bh=eMzZuZHHTXZANMsIDx1PTIX01hfAQhyyDCaKkfiYPSc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NFK7gixX1XkM6rP66Vm92V3JWkTq5pDOXyPW4ZYMC04YqTa+9+2Shbqm4WWIjvdoSF3cBviUksn4EOYrREnxcYZtnsrSTmXzKYAZnkg/Tz8hIbIcmWatgselpVJq30sU7IvIuRESk+QvvDR7zmhAGkRVsDlZldLxxlE3hA00+YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=X1urbiyQ; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <ce073b95-b8e9-4822-91a2-f2bd15997bc4@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1709845765;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eMzZuZHHTXZANMsIDx1PTIX01hfAQhyyDCaKkfiYPSc=;
	b=X1urbiyQvTDe4d3wLTYHE+64ojQc+fiEoPMH6lnGK2NakcshMZIMaDRHhBQ55waScQXkq9
	v4pjIAKBdiuttIF4w+L1hTDS2gYkOAwYB9UnVCrvwCuqJSrAvZrp9OoxbBce5xQR0xgJ/B
	T+6yjSIZ0HODgqBg3Wo08w2OTwJDTck=
Date: Fri, 8 Mar 2024 05:09:13 +0800
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


I'm not very sure. But I remember a most experienced told me that
"Not having anything connector-related in the drm_bridge driver is a canonical design".
And I think he is right and I believed.


