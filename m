Return-Path: <linux-kernel+bounces-35248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13827838E8F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 13:31:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C000928A919
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 12:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84E605D917;
	Tue, 23 Jan 2024 12:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="C8Khf+z7"
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E371210E0
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 12:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706013088; cv=none; b=D7v/9FaqARqUdeNsSbSYagWsYw2yu2xgcRavHCPGM0Zz93xmWze2t/ig8BM7IKomrCYTcK7OEyMEi8jyut4uOLJe5PZJm4CRBwAEYO57TGMjKjbspqWLawMPyBwIIDOGBVqpElvwpOefoshUyxHg/VB5NgQEVWGlPwyIe5xo8W0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706013088; c=relaxed/simple;
	bh=v6QaS+zlcJW8ZzHrHC34+KSqeG2oSrUlpQocEZfmqZg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s5HByIrlRoAYw+p/MmOWL1jvR6rttbVneosBwAU6xvOqeZe4Qeqz9hNTMBcD5g7HP7zJShl/YDuh4KN7KNrf2jZnTdBeM3wZAUiHgC2t1iNXCuQyH1wWYprioQET/okPaZv+1Y3jRDZnV9dltxm362HHYFnzjzg22bSJXP4Da4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=C8Khf+z7; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <23d0f0c0-d171-4b40-8135-da672714591c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1706013084;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wuSyEILrrJ4bPevKaikzWZq3Ix33Pu26FtdW4gUZRTI=;
	b=C8Khf+z7/6p4HSuqGvmLnnPR2qTEKsXEabm9YfZRH/sfc0qioP4UWX4gSxawC4bq24vnAz
	nW91ZXDed9kKTGiaiBwCk7c75ATzQzejQm8e7JqzRrIF+fVXqojNmCw/w0wAjUVCLjrHg/
	F9N10L9Df7ed+BTruESuan175jbWwzk=
Date: Tue, 23 Jan 2024 20:31:19 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 2/5] drm/bridge: simple-bridge: Extend match support for
 non-DT based systems
Content-Language: en-US
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: David Airlie <airlied@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Daniel Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20240122163220.110788-1-sui.jingfeng@linux.dev>
 <20240122163220.110788-3-sui.jingfeng@linux.dev>
 <20240123012139.GD22880@pendragon.ideasonboard.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sui Jingfeng <sui.jingfeng@linux.dev>
In-Reply-To: <20240123012139.GD22880@pendragon.ideasonboard.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Hi,


On 2024/1/23 09:21, Laurent Pinchart wrote:
>>   static int simple_bridge_probe(struct platform_device *pdev)
>>   {
>>   	struct simple_bridge *sbridge;
>> @@ -176,7 +194,10 @@ static int simple_bridge_probe(struct platform_device *pdev)
>>   		return -ENOMEM;
>>   	platform_set_drvdata(pdev, sbridge);
>>   
>> -	sbridge->info = of_device_get_match_data(&pdev->dev);
>> +	if (pdev->dev.of_node)
>> +		sbridge->info = of_device_get_match_data(&pdev->dev);
>> +	else
>> +		sbridge->info = simple_bridge_get_match_data(&pdev->dev);
>>   
>>   	/* Get the next bridge in the pipeline. */
>>   	remote = of_graph_get_remote_node(pdev->dev.of_node, 1, -1);
>> @@ -309,3 +330,4 @@ module_platform_driver(simple_bridge_driver);
>>   MODULE_AUTHOR("Maxime Ripard<maxime.ripard@free-electrons.com>");
>>   MODULE_DESCRIPTION("Simple DRM bridge driver");
>>   MODULE_LICENSE("GPL");
>> +MODULE_ALIAS("platform:simple-bridge");
> This is an unrelated change.


Otherwise, this driver will not be probed when compiled as module on non-DT environment.


