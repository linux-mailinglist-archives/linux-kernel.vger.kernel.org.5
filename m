Return-Path: <linux-kernel+bounces-161048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC81A8B4667
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 15:12:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2112B239A9
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 13:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90F794EB39;
	Sat, 27 Apr 2024 13:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="k1fS7Yw2"
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D867822075
	for <linux-kernel@vger.kernel.org>; Sat, 27 Apr 2024 13:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714223530; cv=none; b=EK1N+jg4j360tW57dSPBtPINuzD8BdUYjp3KuoUjaA0W1SMnmfQgJ+j74hrkKZdEtOaSD3Mpp5OQ4IvHXZv/MA6QNldegwKscBqhZ5Nd193iLXDTfCkJGXDG4JnWxGpVBCxh2KPP/mQEVPW+vES2NPNHTSYLfelDKrcO4IPEXC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714223530; c=relaxed/simple;
	bh=70+1nvBV+ScB9JEIrjFDOdESFyqIhT71FwYcH0OHVDU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t6NkbJonjYw6krkdgWoOw2NlEPuYsu4djEvYvAyaZaye4Iaz1dsIRhl6dUkodClfCRaDBDNGb89spmnv+H8oOoO0dg4N1XTEBSiM/rYCPJ1upkwapefNZL9tRGSw87EIqYNCIW/6fDfDRcEq8ZoKn+MEPr6zd8xK9Y5OYAqnVQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=k1fS7Yw2; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <fc9132ec-68ae-4d28-afe8-0fc6ab2eec8c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1714223524;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ku4jJuCrxWroVraIv9fiL80ign+FS7tm7M7KNTXdEEI=;
	b=k1fS7Yw2uTskNtYQ+uCW5Y2o8VISSJ3vaslSshvCxdtNhInx6Q5NUjtF4GkQ1Trj1IsDLz
	NDpVosEB//XZ8LWEjizaMDyMO5Z0qrEk1Ru7ZDgVhgWHz4hrn2KZZRSLr9BNfWN9lRqomb
	MzDPNDmJcwfoRp3ULOiIFNJn0dpgngI=
Date: Sat, 27 Apr 2024 21:11:47 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v4 7/9] drm-bridge: it66121: Use fwnode API to acquire
 device properties
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss
 <rfoss@kernel.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>, Jonas Karlman <jonas@kwiboo.se>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Phong LE <ple@baylibre.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20240422191903.255642-1-sui.jingfeng@linux.dev>
 <20240422191903.255642-8-sui.jingfeng@linux.dev>
 <ugo62mcrvo5csp7umzvn3jhffh625agnjr3rtujnbgm7gxvgtr@re4q2xg46iqn>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sui Jingfeng <sui.jingfeng@linux.dev>
In-Reply-To: <ugo62mcrvo5csp7umzvn3jhffh625agnjr3rtujnbgm7gxvgtr@re4q2xg46iqn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Hi,


On 2024/4/23 04:06, Dmitry Baryshkov wrote:
>> +
>>   static int it66121_probe(struct i2c_client *client)
>>   {
>>   	u32 revision_id, vendor_ids[2] = { 0 }, device_ids[2] = { 0 };
>> -	struct device_node *ep;
>>   	int ret;
>>   	struct it66121_ctx *ctx;
>>   	struct device *dev = &client->dev;
>> +	struct fwnode_handle *fwnode = dev_fwnode(dev);
>>   
>>   	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C)) {
>>   		dev_err(dev, "I2C check functionality failed.\n");
>> @@ -1520,29 +1542,20 @@ static int it66121_probe(struct i2c_client *client)
>>   	if (!ctx)
>>   		return -ENOMEM;
>>   
>> -	ep = of_graph_get_endpoint_by_regs(dev->of_node, 0, 0);
>> -	if (!ep)
>> -		return -EINVAL;
>> -
>>   	ctx->dev = dev;
>>   	ctx->client = client;
>>   	ctx->info = i2c_get_match_data(client);
>>   
>> -	of_property_read_u32(ep, "bus-width", &ctx->bus_width);
>> -	of_node_put(ep);
>> -
>> -	if (ctx->bus_width != 12 && ctx->bus_width != 24)
>> -		return -EINVAL;
>> -
>> -	ep = of_graph_get_remote_node(dev->of_node, 1, -1);
>> -	if (!ep) {
>> -		dev_err(ctx->dev, "The endpoint is unconnected\n");
>> -		return -EINVAL;
>> -	}
>> +	ret = it66121_read_bus_width(fwnode, &ctx->bus_width);
>> +	if (ret)
>> +		return ret;
>>   
>> -	ctx->next_bridge = of_drm_find_bridge(ep);
>> -	of_node_put(ep);
>> -	if (!ctx->next_bridge) {
>> +	ctx->next_bridge = drm_bridge_find_next_bridge_by_fwnode(fwnode, 1);
>> +	if (IS_ERR(ctx->next_bridge)) {
>> +		ret = PTR_ERR(ctx->next_bridge);
>> +		dev_err(dev, "Error in founding the next bridge: %d\n", ret);
>> +		return ret;
> return dev_err_probe(dev, ret, "msg"), if your function doesn't do this.
> If it does, just return ret.


My drm_bridge_find_next_bridge_by_fwnode() function won't return -EPROBE_DEFER
this is known for sure. As a//prior(priori) knowledge. Calling the dev_err_probe()
just introduce extra overhead. It is useless to use dev_err_probe() here.
  

-- 
Best regards,
Sui


