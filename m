Return-Path: <linux-kernel+bounces-96120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8630A87575D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 20:40:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7ACAA1C20F24
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 19:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACBCB1369A6;
	Thu,  7 Mar 2024 19:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VjIalN1Y"
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B427C1EB56
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 19:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709840397; cv=none; b=qm9yMFiCEoZVv91P5LqB3IDNtvY6YF8pHMt8WGpUrEU8qtrfReexCmj5Li422wYGyjzxkCiCo8JEywsmgGt2iKeaQcFqk9qBwAGP75HzdQF69oqD5oxN57JyPAFCRSIAn0t5IAXI7AYsq81J8cJOUC0yGJAFe0jJZ2BL87EiW5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709840397; c=relaxed/simple;
	bh=LqpYgIXeoGYANxQOarNKmK0a8fU42JbAoQUJ3zFEkiI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=felLI8kn2mhr3obyXaemRJjEgJZEr6zDxP3m/pJkzi38Idth2OZDKwUJ0d9w5PHNZyFqAXgWc0DJJ96gjilOiq11i3nLBymNQtNUkvF5jNisEZIp1w+oxRNq6BqG4396Hx2i7BP/ahwWZfY9dMsYTmzV3vFeHobQlsVnZZqkr4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VjIalN1Y; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <9edaecbc-e6be-4518-b110-a6a574df967a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1709840393;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ys8e9p5+eqfoxouq7g7nRJjBibIoxszrfaw3qqFo2uU=;
	b=VjIalN1Yqh2hQdoHNxx3oiDZCfUrAraw+5VNiW1R1cP0ExjzcHMD4/Oz8nZXkPdxiI90ZX
	PV0LZGZwSJXGQZQQh3CNFW+UQiJz+rrzvj0fG+Yiqnp6pAMFWbVL2mqCJvA/O4Vd/Zi/Tt
	91w6RSmjm/82DokulFLAi0+fgTtq8lk=
Date: Fri, 8 Mar 2024 03:39:43 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 4/4] drm-bridge: it66121: Use fwnode API to acquire
 device properties
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
 <20240307172334.1753343-5-sui.jingfeng@linux.dev>
 <CAA8EJpqtPRfe1VL_ACYEOSq=iNMkZ03-fwVv3XdVrpTObZFu1w@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sui Jingfeng <sui.jingfeng@linux.dev>
In-Reply-To: <CAA8EJpqtPRfe1VL_ACYEOSq=iNMkZ03-fwVv3XdVrpTObZFu1w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Hi,


On 2024/3/8 03:31, Dmitry Baryshkov wrote:
> On Thu, 7 Mar 2024 at 19:24, Sui Jingfeng <sui.jingfeng@linux.dev> wrote:
>> Make this driver less DT-dependent by calling the freshly created helpers,
>> should be no functional changes for DT based systems. But open the door for
>> otherwise use cases. Even though there is no user emerged yet, this still
>> do no harms. In fact, we reduce some boilerplate across drm bridge drivers.
>>
>> Signed-off-by: Sui Jingfeng <sui.jingfeng@linux.dev>
>> ---
>>   drivers/gpu/drm/bridge/ite-it66121.c | 63 ++++++++++++++++------------
>>   1 file changed, 36 insertions(+), 27 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/bridge/ite-it66121.c b/drivers/gpu/drm/bridge/ite-it66121.c
>> index 1c3433b5e366..a2cf2be86065 100644
>> --- a/drivers/gpu/drm/bridge/ite-it66121.c
>> +++ b/drivers/gpu/drm/bridge/ite-it66121.c
>> @@ -15,7 +15,6 @@
>>   #include <linux/bitfield.h>
>>   #include <linux/property.h>
>>   #include <linux/regmap.h>
>> -#include <linux/of_graph.h>
>>   #include <linux/gpio/consumer.h>
>>   #include <linux/pinctrl/consumer.h>
>>   #include <linux/regulator/consumer.h>
>> @@ -1480,7 +1479,7 @@ static int it66121_audio_codec_init(struct it66121_ctx *ctx, struct device *dev)
>>
>>          dev_dbg(dev, "%s\n", __func__);
>>
>> -       if (!of_property_read_bool(dev->of_node, "#sound-dai-cells")) {
>> +       if (!fwnode_property_present(dev_fwnode(dev), "#sound-dai-cells")) {
>>                  dev_info(dev, "No \"#sound-dai-cells\", no audio\n");
>>                  return 0;
>>          }
>> @@ -1503,13 +1502,37 @@ static const char * const it66121_supplies[] = {
>>          "vcn33", "vcn18", "vrf12"
>>   };
>>
>> +static int it66121_read_bus_width(struct fwnode_handle *fwnode, u32 port,
>> +                                 u32 *bus_width)
>> +{
>> +       struct fwnode_handle *endpoint;
>> +       u32 val;
>> +       int ret;
>> +
>> +       endpoint = fwnode_graph_get_endpoint_by_id(fwnode, port, 0, 0);
>> +       if (!endpoint)
>> +               return -EINVAL;
>> +
>> +       ret = fwnode_property_read_u32(endpoint, "bus-width", &val);
>> +       fwnode_handle_put(endpoint);
>> +       if (ret)
>> +               return ret;
>> +
>> +       if (val != 12 && val != 24)
>> +               return -EINVAL;
>> +
>> +       *bus_width = val;
>> +
>> +       return 0;
>> +}
>> +
>>   static int it66121_probe(struct i2c_client *client)
>>   {
>>          u32 revision_id, vendor_ids[2] = { 0 }, device_ids[2] = { 0 };
>> -       struct device_node *ep;
>>          int ret;
>>          struct it66121_ctx *ctx;
>>          struct device *dev = &client->dev;
>> +       struct fwnode_handle *fwnode = dev_fwnode(dev);
>>
>>          if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C)) {
>>                  dev_err(dev, "I2C check functionality failed.\n");
>> @@ -1520,37 +1543,23 @@ static int it66121_probe(struct i2c_client *client)
>>          if (!ctx)
>>                  return -ENOMEM;
>>
>> -       ep = of_graph_get_endpoint_by_regs(dev->of_node, 0, 0);
>> -       if (!ep)
>> -               return -EINVAL;
>> -
>>          ctx->dev = dev;
>>          ctx->client = client;
>>          ctx->info = i2c_get_match_data(client);
>>
>> -       of_property_read_u32(ep, "bus-width", &ctx->bus_width);
>> -       of_node_put(ep);
>> -
>> -       if (ctx->bus_width != 12 && ctx->bus_width != 24)
>> -               return -EINVAL;
>> -
>> -       ep = of_graph_get_remote_node(dev->of_node, 1, -1);
>> -       if (!ep) {
>> -               dev_err(ctx->dev, "The endpoint is unconnected\n");
>> -               return -EINVAL;
>> -       }
>> -
>> -       if (!of_device_is_available(ep)) {
>> -               of_node_put(ep);
>> -               dev_err(ctx->dev, "The remote device is disabled\n");
>> -               return -ENODEV;
>> -       }
>> +       /* Endpoint of port@0 contains the bus-width property */
>> +       ret = it66121_read_bus_width(fwnode, 0, &ctx->bus_width);
> There is no need to pass port as an argument to that function.
>
>
Yeah, extremely correct. Because the bus width property should always
located at the endpoint of the input port(port@0 for it66121).


>> +       if (ret)
>> +               return ret;
>>
>> -       ctx->next_bridge = of_drm_find_bridge(ep);
>> -       of_node_put(ep);
>> +       ctx->next_bridge = drm_bridge_find_next_bridge_by_fwnode(fwnode, 1);
>>          if (!ctx->next_bridge) {
>>                  dev_dbg(ctx->dev, "Next bridge not found, deferring probe\n");
>>                  return -EPROBE_DEFER;
>> +       } else if (IS_ERR(ctx->next_bridge)) {
>> +               ret = PTR_ERR(ctx->next_bridge);
>> +               dev_err(dev, "Error in founding the next bridge: %d\n", ret);
>> +               return ret;
> Nit: I'd usually expect this part to be in a different order: first
> check for error, then check for absence. But that's a minor thing.


OK,  fine, will be fixed at the next version if no other objects.


