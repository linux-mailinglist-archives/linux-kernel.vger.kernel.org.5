Return-Path: <linux-kernel+bounces-161131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BAC2C8B4775
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 20:43:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE6211F21866
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 18:43:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B556F3A8EF;
	Sat, 27 Apr 2024 18:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="R8WxDvkx"
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF1933C8
	for <linux-kernel@vger.kernel.org>; Sat, 27 Apr 2024 18:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714243417; cv=none; b=fO1ChwhTANq6CzLFnzOCQ0DwlGHcFiG78o282OfQ2KqU0dt0TFfallN05akIczpdMYcr4NY1DIAPN1zt8IvCi5eUWHkpCTmG5ZAMqR6oEdtl2DzCjJgfjpFTvG4A4bglqB1YpUBoRypCFfxUsTEN4/ZK/liAbAz1Oz8oSvXDbxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714243417; c=relaxed/simple;
	bh=oy47Cu0P1Sjhd1RueSFUdcxgxnOThp+ciKW02oAgErc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sZfjIQtwlvQPSyWwwLbloIGatI50wI9ky23AUquZS2E5sVZyJHp0XRxRpEvQ7WZ6cRXZNp+og4wYpQ7ybpkJOtRFI82OjdkARB/F1PK8ZZBZmvrv6jqIK5XwzoY7UuS0o7JQOm8STTJAL03TmHdMb5VfM001oiJgaU1CMvPnaRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=R8WxDvkx; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <da04552a-9466-4df9-8754-399b47dcbd5c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1714243412;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UOhXo5EjGdx33Wt6C3d2r2+E77VdrxWCqdRaAFDAJcs=;
	b=R8WxDvkxBRS/13UkJJzRrvuwuy5IHBtUb59zzW6HWKPUJYjqmQztVAdEPqUKaQV6PKVJYz
	rkRxIO6NEL+7MgavRdkJavIgQzqjQpJlGm8eTi8ziv5YGLJ7Fqy1k3VuvWtdu9q+OBk954
	fkIvWe0aTp5Up0H+0Z6mrTUhYDvRDII=
Date: Sun, 28 Apr 2024 02:43:20 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v4 8/9] drm/bridge: tfp410: Use fwnode API to acquire
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
 <20240422191903.255642-9-sui.jingfeng@linux.dev>
 <gwpgunhe3frumjtxjapdw3nxlavrhseleddqqn6qpqeqg2ku56@ec6log4zl6ds>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sui Jingfeng <sui.jingfeng@linux.dev>
In-Reply-To: <gwpgunhe3frumjtxjapdw3nxlavrhseleddqqn6qpqeqg2ku56@ec6log4zl6ds>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Hi,


On 2024/4/23 04:08, Dmitry Baryshkov wrote:
> On Tue, Apr 23, 2024 at 03:19:02AM +0800, Sui Jingfeng wrote:
>> Make this driver DT-independent by calling the freshly created helpers,
>> which reduce boilerplate and open the door for otherwise use cases. No
>> functional changes for DT based systems.
>>
>> Signed-off-by: Sui Jingfeng <sui.jingfeng@linux.dev>
>> ---
>>   drivers/gpu/drm/bridge/ti-tfp410.c | 41 +++++++++++++++---------------
>>   1 file changed, 21 insertions(+), 20 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/bridge/ti-tfp410.c b/drivers/gpu/drm/bridge/ti-tfp410.c
>> index c7bef5c23927..58dc7492844f 100644
>> --- a/drivers/gpu/drm/bridge/ti-tfp410.c
>> +++ b/drivers/gpu/drm/bridge/ti-tfp410.c
>> @@ -266,8 +266,9 @@ static const struct drm_bridge_timings tfp410_default_timings = {
>>   
>>   static int tfp410_parse_timings(struct tfp410 *dvi, bool i2c)
>>   {
>> +	struct fwnode_handle *fwnode = dev_fwnode(dvi->dev);
>>   	struct drm_bridge_timings *timings = &dvi->timings;
>> -	struct device_node *ep;
>> +	struct fwnode_handle *ep;
>>   	u32 pclk_sample = 0;
>>   	u32 bus_width = 24;
>>   	u32 deskew = 0;
>> @@ -288,14 +289,14 @@ static int tfp410_parse_timings(struct tfp410 *dvi, bool i2c)
>>   	 * and EDGE pins. They are specified in DT through endpoint properties
>>   	 * and vendor-specific properties.
>>   	 */
>> -	ep = of_graph_get_endpoint_by_regs(dvi->dev->of_node, 0, 0);
>> +	ep = fwnode_graph_get_endpoint_by_id(fwnode, 0, 0, 0);
>>   	if (!ep)
>>   		return -EINVAL;
>>   
>>   	/* Get the sampling edge from the endpoint. */
>> -	of_property_read_u32(ep, "pclk-sample", &pclk_sample);
>> -	of_property_read_u32(ep, "bus-width", &bus_width);
>> -	of_node_put(ep);
>> +	fwnode_property_read_u32(ep, "pclk-sample", &pclk_sample);
>> +	fwnode_property_read_u32(ep, "bus-width", &bus_width);
>> +	fwnode_handle_put(ep);
>>   
>>   	timings->input_bus_flags = DRM_BUS_FLAG_DE_HIGH;
>>   
>> @@ -324,7 +325,7 @@ static int tfp410_parse_timings(struct tfp410 *dvi, bool i2c)
>>   	}
>>   
>>   	/* Get the setup and hold time from vendor-specific properties. */
>> -	of_property_read_u32(dvi->dev->of_node, "ti,deskew", &deskew);
>> +	fwnode_property_read_u32(fwnode, "ti,deskew", &deskew);
>>   	if (deskew > 7)
>>   		return -EINVAL;
>>   
>> @@ -336,12 +337,12 @@ static int tfp410_parse_timings(struct tfp410 *dvi, bool i2c)
>>   
>>   static int tfp410_init(struct device *dev, bool i2c)
>>   {
>> -	struct device_node *node;
>> +	struct fwnode_handle *fwnode = dev_fwnode(dev);
>>   	struct tfp410 *dvi;
>>   	int ret;
>>   
>> -	if (!dev->of_node) {
>> -		dev_err(dev, "device-tree data is missing\n");
>> +	if (!fwnode) {
>> +		dev_err(dev, "firmware data is missing\n");
>>   		return -ENXIO;
>>   	}
>>   
>> @@ -352,8 +353,8 @@ static int tfp410_init(struct device *dev, bool i2c)
>>   	dvi->dev = dev;
>>   	dev_set_drvdata(dev, dvi);
>>   
>> +	drm_bridge_set_node(&dvi->bridge, fwnode);
>>   	dvi->bridge.funcs = &tfp410_bridge_funcs;
>> -	dvi->bridge.of_node = dev->of_node;
>>   	dvi->bridge.timings = &dvi->timings;
>>   	dvi->bridge.type = DRM_MODE_CONNECTOR_DVID;
>>   
>> @@ -362,15 +363,15 @@ static int tfp410_init(struct device *dev, bool i2c)
>>   		return ret;
>>   
>>   	/* Get the next bridge, connected to port@1. */
>> -	node = of_graph_get_remote_node(dev->of_node, 1, -1);
>> -	if (!node)
>> -		return -ENODEV;
>> -
>> -	dvi->next_bridge = of_drm_find_bridge(node);
>> -	of_node_put(node);
>> -
>> -	if (!dvi->next_bridge)
>> +	dvi->next_bridge = drm_bridge_find_next_bridge_by_fwnode(fwnode, 1);
>> +	if (IS_ERR(dvi->next_bridge)) {
>> +		ret = PTR_ERR(dvi->next_bridge);
>> +		dev_err(dev, "Error in founding the next bridge: %d\n", ret);
>> +		return ret;
> Same comment regarding dev_err_probe().
>
> LGTM otherwise.


My drm_bridge_find_next_bridge_by_fwnode() function won't return -EPROBE_DEFER,
this is known for sure. this can be used as a prior(priori) knowledge. This is
intentionally by design.


Calling the dev_err_probe() just introduce extra overhead on non EPROBE_DEFER
cases. Hence, It is useless to use dev_err_probe() at here.


>> +	} else if (!dvi->next_bridge) {
>> +		dev_dbg(dev, "Next bridge not found, deferring probe\n");
>>   		return -EPROBE_DEFER;
> Looking at the bolerplate code, I think it would be better to make
> drm_bridge_find_next_bridge_by_fwnode() reutrn -EPROBE_DEFER on its own.
>
The drm_bridge_find_next_bridge_by_fwnode() function itself can not
reliable detect if the driver(the remote bridge) already probed or not.

Hence, as a core helper function, we can not guarantee that return
-EPROBE_DEFER is always correct.

While, return NULL is always correct. The NULL can stand for two meanings.
One is that the next bridge is really don't exist, may happen when the
caller provided a wrong fwnode argument.

Another case is that the next bridge exists but not probed yet, and
drm_bridge_find_next_bridge_by_fwnode() can return NULL when it gets called
too early.

Therefore, it is better to left to the users of this function to process
the NULL return value. As driver instances has some extra prior knowledge.
And can be controlled by drm bridge driver author.

>> +	}
>>   
>>   	/* Get the powerdown GPIO. */
>>   	dvi->powerdown = devm_gpiod_get_optional(dev, "powerdown",
>> @@ -422,10 +423,10 @@ static struct platform_driver tfp410_platform_driver = {
>>   /* There is currently no i2c functionality. */
>>   static int tfp410_i2c_probe(struct i2c_client *client)
>>   {
>> +	struct fwnode_handle *fwnode = dev_fwnode(&client->dev);
>>   	int reg;
>>   
>> -	if (!client->dev.of_node ||
>> -	    of_property_read_u32(client->dev.of_node, "reg", &reg)) {
>> +	if (!fwnode || fwnode_property_read_u32(fwnode, "reg", &reg)) {
>>   		dev_err(&client->dev,
>>   			"Can't get i2c reg property from device-tree\n");
>>   		return -ENXIO;
>> -- 
>> 2.34.1
>>
-- 
Best regards,
Sui


