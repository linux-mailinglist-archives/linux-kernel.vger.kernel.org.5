Return-Path: <linux-kernel+bounces-161158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E8C48B47C8
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 22:11:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 482271C20C49
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 20:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 469B813C83D;
	Sat, 27 Apr 2024 20:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mo7k/2pQ"
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC99A938
	for <linux-kernel@vger.kernel.org>; Sat, 27 Apr 2024 20:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714248673; cv=none; b=PofqlJSqTGJrWoKfE8BLdug9Tz4BvjlMnZbNra9B+hYnEzRFNl13hn90AZyFvaZqXrFRpBPnZa7xg2iFTFVjCIkSak82t9uIaCuZdLWwfymJeFPjwbjC+g2roNmFBgxZSGwET6hUzsLI4cynSp0ugk3URAIrJpDzcm1FfIqeLfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714248673; c=relaxed/simple;
	bh=NQB1cnItFU0HT2k+pExCcB9Jhxuh32pS+FpbInh3tZs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O7oKOQIEbrvKKTI4XepEbsYzZfqafgwNgEL/s91qSrR2hPk6qNwoenVWaL2++0JT5fRPzX3Z30LC/t0sg5fzRpFWvfO5zJFKVejStrx2ORzLyP69Z/XfQ5gxhmPcdIgGQPEE+Av5E5EGwnKc67ksVOy1NlgAICFTTZE32lOtXa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mo7k/2pQ; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <4212ba2d-0fe0-4b6c-9acb-1359e7b9ffa0@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1714248668;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wSLO05hJh2y9y8zfKfzdd6ahvDrXKNQDfVfqlHeHhw0=;
	b=mo7k/2pQA1G1T9UX3e68iLdYoRuCnix7XU/rHmhvSO7glOAQMih65MJXNiDH/XSAsm02H8
	czbNKEZ0sMpeR+KcFJX99hL8Nk9bcc9Nk1mTzhDbbkQceJ788cIWQmGDkq5Z6PXdCSHbcI
	Ow4Po4A2TfYZKAmGQO87GqZ0fqOCCAc=
Date: Sun, 28 Apr 2024 04:10:55 +0800
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
 <da04552a-9466-4df9-8754-399b47dcbd5c@linux.dev>
 <a2c4a2bwkesbp72bqoc6p2kdzhxaeb4hdohxae5othyvb6didw@asguw3ywktt6>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sui Jingfeng <sui.jingfeng@linux.dev>
In-Reply-To: <a2c4a2bwkesbp72bqoc6p2kdzhxaeb4hdohxae5othyvb6didw@asguw3ywktt6>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Hi,


On 2024/4/28 03:17, Dmitry Baryshkov wrote:
> On Sun, Apr 28, 2024 at 02:43:20AM +0800, Sui Jingfeng wrote:
>> Hi,
>>
>>
>> On 2024/4/23 04:08, Dmitry Baryshkov wrote:
>>> On Tue, Apr 23, 2024 at 03:19:02AM +0800, Sui Jingfeng wrote:
>>>> Make this driver DT-independent by calling the freshly created helpers,
>>>> which reduce boilerplate and open the door for otherwise use cases. No
>>>> functional changes for DT based systems.
>>>>
>>>> Signed-off-by: Sui Jingfeng <sui.jingfeng@linux.dev>
>>>> ---
>>>>    drivers/gpu/drm/bridge/ti-tfp410.c | 41 +++++++++++++++---------------
>>>>    1 file changed, 21 insertions(+), 20 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/bridge/ti-tfp410.c b/drivers/gpu/drm/bridge/ti-tfp410.c
>>>> index c7bef5c23927..58dc7492844f 100644
>>>> --- a/drivers/gpu/drm/bridge/ti-tfp410.c
>>>> +++ b/drivers/gpu/drm/bridge/ti-tfp410.c
>>>> @@ -266,8 +266,9 @@ static const struct drm_bridge_timings tfp410_default_timings = {
>>>>    static int tfp410_parse_timings(struct tfp410 *dvi, bool i2c)
>>>>    {
>>>> +	struct fwnode_handle *fwnode = dev_fwnode(dvi->dev);
>>>>    	struct drm_bridge_timings *timings = &dvi->timings;
>>>> -	struct device_node *ep;
>>>> +	struct fwnode_handle *ep;
>>>>    	u32 pclk_sample = 0;
>>>>    	u32 bus_width = 24;
>>>>    	u32 deskew = 0;
>>>> @@ -288,14 +289,14 @@ static int tfp410_parse_timings(struct tfp410 *dvi, bool i2c)
>>>>    	 * and EDGE pins. They are specified in DT through endpoint properties
>>>>    	 * and vendor-specific properties.
>>>>    	 */
>>>> -	ep = of_graph_get_endpoint_by_regs(dvi->dev->of_node, 0, 0);
>>>> +	ep = fwnode_graph_get_endpoint_by_id(fwnode, 0, 0, 0);
>>>>    	if (!ep)
>>>>    		return -EINVAL;
>>>>    	/* Get the sampling edge from the endpoint. */
>>>> -	of_property_read_u32(ep, "pclk-sample", &pclk_sample);
>>>> -	of_property_read_u32(ep, "bus-width", &bus_width);
>>>> -	of_node_put(ep);
>>>> +	fwnode_property_read_u32(ep, "pclk-sample", &pclk_sample);
>>>> +	fwnode_property_read_u32(ep, "bus-width", &bus_width);
>>>> +	fwnode_handle_put(ep);
>>>>    	timings->input_bus_flags = DRM_BUS_FLAG_DE_HIGH;
>>>> @@ -324,7 +325,7 @@ static int tfp410_parse_timings(struct tfp410 *dvi, bool i2c)
>>>>    	}
>>>>    	/* Get the setup and hold time from vendor-specific properties. */
>>>> -	of_property_read_u32(dvi->dev->of_node, "ti,deskew", &deskew);
>>>> +	fwnode_property_read_u32(fwnode, "ti,deskew", &deskew);
>>>>    	if (deskew > 7)
>>>>    		return -EINVAL;
>>>> @@ -336,12 +337,12 @@ static int tfp410_parse_timings(struct tfp410 *dvi, bool i2c)
>>>>    static int tfp410_init(struct device *dev, bool i2c)
>>>>    {
>>>> -	struct device_node *node;
>>>> +	struct fwnode_handle *fwnode = dev_fwnode(dev);
>>>>    	struct tfp410 *dvi;
>>>>    	int ret;
>>>> -	if (!dev->of_node) {
>>>> -		dev_err(dev, "device-tree data is missing\n");
>>>> +	if (!fwnode) {
>>>> +		dev_err(dev, "firmware data is missing\n");
>>>>    		return -ENXIO;
>>>>    	}
>>>> @@ -352,8 +353,8 @@ static int tfp410_init(struct device *dev, bool i2c)
>>>>    	dvi->dev = dev;
>>>>    	dev_set_drvdata(dev, dvi);
>>>> +	drm_bridge_set_node(&dvi->bridge, fwnode);
>>>>    	dvi->bridge.funcs = &tfp410_bridge_funcs;
>>>> -	dvi->bridge.of_node = dev->of_node;
>>>>    	dvi->bridge.timings = &dvi->timings;
>>>>    	dvi->bridge.type = DRM_MODE_CONNECTOR_DVID;
>>>> @@ -362,15 +363,15 @@ static int tfp410_init(struct device *dev, bool i2c)
>>>>    		return ret;
>>>>    	/* Get the next bridge, connected to port@1. */
>>>> -	node = of_graph_get_remote_node(dev->of_node, 1, -1);
>>>> -	if (!node)
>>>> -		return -ENODEV;
>>>> -
>>>> -	dvi->next_bridge = of_drm_find_bridge(node);
>>>> -	of_node_put(node);
>>>> -
>>>> -	if (!dvi->next_bridge)
>>>> +	dvi->next_bridge = drm_bridge_find_next_bridge_by_fwnode(fwnode, 1);
>>>> +	if (IS_ERR(dvi->next_bridge)) {
>>>> +		ret = PTR_ERR(dvi->next_bridge);
>>>> +		dev_err(dev, "Error in founding the next bridge: %d\n", ret);
>>>> +		return ret;
>>> Same comment regarding dev_err_probe().
>>>
>>> LGTM otherwise.
>>
>> My drm_bridge_find_next_bridge_by_fwnode() function won't return -EPROBE_DEFER,
>> this is known for sure. this can be used as a prior(priori) knowledge. This is
>> intentionally by design.
>>
>>
>> Calling the dev_err_probe() just introduce extra overhead on non EPROBE_DEFER
>> cases. Hence, It is useless to use dev_err_probe() at here.
>>
>>
>>>> +	} else if (!dvi->next_bridge) {
>>>> +		dev_dbg(dev, "Next bridge not found, deferring probe\n");
>>>>    		return -EPROBE_DEFER;
>>> Looking at the bolerplate code, I think it would be better to make
>>> drm_bridge_find_next_bridge_by_fwnode() reutrn -EPROBE_DEFER on its own.
>>>
>> The drm_bridge_find_next_bridge_by_fwnode() function itself can not
>> reliable detect if the driver(the remote bridge) already probed or not.
>>
>> Hence, as a core helper function, we can not guarantee that return
>> -EPROBE_DEFER is always correct.
>>
>> While, return NULL is always correct. The NULL can stand for two meanings.
>> One is that the next bridge is really don't exist, may happen when the
>> caller provided a wrong fwnode argument.
> Please take a look at drm_of_find_panel_or_bridge().


The function name seems to hint that a panel is not a bridge, while panel can be drm bridge.
display connector can also be a bridge, display connector can also be within a bridge.
There also has HPD fake bridge.

so maybe drm_of_find_panel_or_connector_or_hpd_bridge()?


My function intend to use one word "bridge" stand for all at this moment.


> Returning specific
> error code is always better than returning just NULL. As you have
> pointed yourself, there are (at least) two cases when your function
> returns NULL. Caller can not identify them unless the function returns
> proper error code.

No, you miss the point.

The point is that the caller *don't need* to identify them.
Just tears down (quit with -EPROBE_DEFER returned) is enough.
This is also what's other drivers do.

>
>> Another case is that the next bridge exists but not probed yet, and
>> drm_bridge_find_next_bridge_by_fwnode() can return NULL when it gets called
>> too early.
>>
>> Therefore, it is better to left to the users of this function to process
>> the NULL return value. As driver instances has some extra prior knowledge.
>> And can be controlled by drm bridge driver author.
> he driver has no prior knowledge if there is a remote fwnode/ofnode or
> if there is none.

No,

  
As I have told you several time, the DT/fwnode graph speak everything.
Display bridge driver can query firmware(DT/ACPI) to know if the next bridge
is present, is it really meant to be used and how many bridges in the chains.

If there has complete OF/fwnode graph and the graph say that there has next
bridge in the chain. Then the driver has to return -EPROBE_DEFER if he can't
find the next.

And the most important thing is that it is the bridge drivers responsibility
or authority to take whatever actions when drm_bridge_find_next_bridge_by_fwnode()
can return NULL. Core helpers is meant to be lightweight only, there no need
to introduce this overhead.
  
Ok. I think I have been patient long enough.
You questions and/or reviews have been given polite replies, that's it.

>>>> +	}
>>>>    	/* Get the powerdown GPIO. */
>>>>    	dvi->powerdown = devm_gpiod_get_optional(dev, "powerdown",
>>>> @@ -422,10 +423,10 @@ static struct platform_driver tfp410_platform_driver = {
>>>>    /* There is currently no i2c functionality. */
>>>>    static int tfp410_i2c_probe(struct i2c_client *client)
>>>>    {
>>>> +	struct fwnode_handle *fwnode = dev_fwnode(&client->dev);
>>>>    	int reg;
>>>> -	if (!client->dev.of_node ||
>>>> -	    of_property_read_u32(client->dev.of_node, "reg", &reg)) {
>>>> +	if (!fwnode || fwnode_property_read_u32(fwnode, "reg", &reg)) {
>>>>    		dev_err(&client->dev,
>>>>    			"Can't get i2c reg property from device-tree\n");
>>>>    		return -ENXIO;
>>>> -- 
>>>> 2.34.1
>>>>
>> -- 
>> Best regards,
>> Sui
>>
-- 
Best regards,
Sui


