Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8182F7EDF79
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 12:18:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345108AbjKPLSe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 06:18:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230401AbjKPLSd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 06:18:33 -0500
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [IPv6:2001:41d0:1004:224b::ae])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E649AA
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 03:18:29 -0800 (PST)
Message-ID: <1b59d647-c345-4260-b07b-22abb70ae17a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1700133505;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v3ky3IGmo059i8LI1Q9gFHB3PczZNsekFc8ype32aes=;
        b=ezvDvGaKms6UgbUFpQmlbuvdMdUzp45i41zsw5O9HfSyJGV4UMBDg6zyNYu3EsRLSwbG2o
        k4e+Affx2Sfqf3pA06ntjqVEDRIwfKEot2KYZC15r0Du2dZAb8lgoQ/etG0aEye1YplH/u
        TC41cbtffix+gvgv2yWgFUBgqOHmZ4s=
Date:   Thu, 16 Nov 2023 19:18:18 +0800
MIME-Version: 1.0
Subject: Re: [PATCH 8/8] drm/bridge: it66121: Allow link this driver as a lib
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Phong LE <ple@baylibre.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Maxime Ripard <mripard@kernel.org>,
        Sui Jingfeng <suijingfeng@loongson.cn>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Thomas Zimmermann <tzimmermann@suse.de>
References: <20231114150130.497915-1-sui.jingfeng@linux.dev>
 <20231114150130.497915-9-sui.jingfeng@linux.dev>
 <CAA8EJprQq3aDhzE+yKGZ2-nsuHWcptzMvApsyOi9D63PgeiZ3w@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Sui Jingfeng <sui.jingfeng@linux.dev>
In-Reply-To: <CAA8EJprQq3aDhzE+yKGZ2-nsuHWcptzMvApsyOi9D63PgeiZ3w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


On 2023/11/15 00:30, Dmitry Baryshkov wrote:
>> +
>> +               ctx->connector = connector;
>> +       }
>>
>>          if (ctx->info->id == ID_IT66121) {
>>                  ret = regmap_write_bits(ctx->regmap, IT66121_CLK_BANK_REG,
>> @@ -1632,16 +1651,13 @@ static const char * const it66121_supplies[] = {
>>          "vcn33", "vcn18", "vrf12"
>>   };
>>
>> -static int it66121_probe(struct i2c_client *client)
>> +int it66121_create_bridge(struct i2c_client *client, bool of_support,
>> +                         bool hpd_support, bool audio_support,
>> +                         struct drm_bridge **bridge)
>>   {
>> +       struct device *dev = &client->dev;
>>          int ret;
>>          struct it66121_ctx *ctx;
>> -       struct device *dev = &client->dev;
>> -
>> -       if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C)) {
>> -               dev_err(dev, "I2C check functionality failed.\n");
>> -               return -ENXIO;
>> -       }
>>
>>          ctx = devm_kzalloc(dev, sizeof(*ctx), GFP_KERNEL);
>>          if (!ctx)
>> @@ -1649,24 +1665,19 @@ static int it66121_probe(struct i2c_client *client)
>>
>>          ctx->dev = dev;
>>          ctx->client = client;
>> -       ctx->info = i2c_get_match_data(client);
>> -
>> -       ret = it66121_of_read_bus_width(dev, &ctx->bus_width);
>> -       if (ret)
>> -               return ret;
>> -
>> -       ret = it66121_of_get_next_bridge(dev, &ctx->next_bridge);
>> -       if (ret)
>> -               return ret;
>> -
>> -       i2c_set_clientdata(client, ctx);
>>          mutex_init(&ctx->lock);
>>
>> -       ret = devm_regulator_bulk_get_enable(dev, ARRAY_SIZE(it66121_supplies),
>> -                                            it66121_supplies);
>> -       if (ret) {
>> -               dev_err(dev, "Failed to enable power supplies\n");
>> -               return ret;
>> +       if (of_support) {
>> +               ret = it66121_of_read_bus_width(dev, &ctx->bus_width);
>> +               if (ret)
>> +                       return ret;
>> +
>> +               ret = it66121_of_get_next_bridge(dev, &ctx->next_bridge);
>> +               if (ret)
>> +                       return ret;
>> +       } else {
>> +               ctx->bus_width = 24;
>> +               ctx->next_bridge = NULL;
>>          }
> A better alternative would be to turn OF calls into fwnode calls and
> to populate the fwnode properties. See
> drivers/platform/x86/intel/chtwc_int33fe.c for example.


Honestly, I don't want to leave any scratch(breadcrumbs).
I'm worries about that turn OF calls into fwnode calls will leave something unwanted.

Because I am not sure if fwnode calls will make sense in the DT world, while my patch
*still* be useful in the DT world. Because the newly introduced it66121_create_bridge()
function is a core. I think It's better leave this task to a more advance programmer.
if there have use case. It can be introduced at a latter time, probably parallel with
the DT.

I think DT and/or ACPI is best for integrated devices, but it66121 display bridges is
a i2c slave device. Personally, I think slave device shouldn't be standalone. I'm more
prefer to turn this driver to support hot-plug, even remove the device on the run time
freely when detach and allow reattach. Like the I2C EEPROM device in the monitor (which
contains the EDID, with I2C slave address 0x50). The I2C EEPROM device *also* don't has
a corresponding struct device representation in linux kernel.

so I still think It is best to make this drivers functional as a static lib, but I want
to hear you to say more. Why it would be a *better* alternative to turn OF calls into
fwnode calls? what are the potential benefits?



