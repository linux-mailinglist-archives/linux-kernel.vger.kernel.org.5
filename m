Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75D187EE093
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 13:18:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345192AbjKPMS2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 07:18:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345138AbjKPMS1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 07:18:27 -0500
Received: from out-184.mta1.migadu.com (out-184.mta1.migadu.com [IPv6:2001:41d0:203:375::b8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE72B9B
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 04:18:23 -0800 (PST)
Message-ID: <7602cd83-0e05-4e11-9bd1-10eb1d48a507@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1700137102;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mojXKgKsD6OOdOdTVyAHt9qNfNzmLYV5MNq0diPZ0zo=;
        b=ui0PNUIWnN3h0wZZlTNPpzsTYt72RGpccxzSG5u2mJgqPIRlWezUkSceAZfLDNwbl7aiyd
        f3Z0dAwKeBEj8HzSlDEuC5fobUcRY/59txepIFCGunD1O2JARyC5JKOYlhwgCNb57bFBjR
        LLkrWlUnt+Qx0bphCRc3GD+DZfsPIik=
Date:   Thu, 16 Nov 2023 20:18:12 +0800
MIME-Version: 1.0
Subject: Re: [PATCH 5/8] drm/bridge: it66121: Add a helper function to read
 chip id
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
 <20231114150130.497915-6-sui.jingfeng@linux.dev>
 <CAA8EJprkDpjuHEi5R01p4XNvFBr94BvXhr7AZCLr6dC8Mk=yPw@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Sui Jingfeng <sui.jingfeng@linux.dev>
In-Reply-To: <CAA8EJprkDpjuHEi5R01p4XNvFBr94BvXhr7AZCLr6dC8Mk=yPw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


On 2023/11/15 00:06, Dmitry Baryshkov wrote:
> On Tue, 14 Nov 2023 at 17:09, Sui Jingfeng <sui.jingfeng@linux.dev> wrote:
>> From: Sui Jingfeng <suijingfeng@loongson.cn>
>>
>> Read the required chip id data back by calling regmap_bulk_read() once,
>> reduce the number of local variables needed in it66121_probe() function.
>> And store its values into struct it66121_ctx, as it will be used latter.
>>
>> Signed-off-by: Sui Jingfeng <suijingfeng@loongson.cn>
>> ---
>>   drivers/gpu/drm/bridge/ite-it66121.c | 47 ++++++++++++++++++++--------
>>   1 file changed, 34 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/bridge/ite-it66121.c b/drivers/gpu/drm/bridge/ite-it66121.c
>> index 7e473beefc79..f36d05331f25 100644
>> --- a/drivers/gpu/drm/bridge/ite-it66121.c
>> +++ b/drivers/gpu/drm/bridge/ite-it66121.c
>> @@ -313,6 +313,9 @@ struct it66121_ctx {
>>                  bool auto_cts;
>>          } audio;
>>          const struct it66121_chip_info *info;
>> +       u16 vender_id;
>> +       u16 device_id;
>> +       u8 revision;
> There is no need to store them, they are not used by the driver anywhere.
>
>>   };
>>
>>   static inline struct it66121_ctx *bridge_to_it66121(struct drm_bridge *bridge)
>> @@ -399,6 +402,30 @@ static void it66121_hw_reset(struct it66121_ctx *ctx)
>>          gpiod_set_value(ctx->gpio_reset, 0);
>>   }
>>
>> +static int it66121_read_chip_id(struct it66121_ctx *ctx, bool verbose)
>> +{
>> +       u8 id[4];
>> +       int ret;
>> +
>> +       ret = regmap_bulk_read(ctx->regmap, IT66121_VENDOR_ID0_REG, id, 4);
>> +       if (ret < 0) {
>> +               dev_err(ctx->dev, "Failed to read chip ID: %d\n", ret);
>> +               return ret;
>> +       }
>> +
>> +       ctx->vender_id = (u16)id[1] << 8 | id[0];
>> +       ctx->device_id = ((u16)(id[3] & IT66121_DEVICE_ID1_MASK) << 8 | id[2]);
>> +       /* Revision is shared with DEVICE_ID1 */
>> +       ctx->revision = FIELD_GET(IT66121_REVISION_MASK, id[3]);
>> +
>> +       if (verbose) {
>> +               dev_info(ctx->dev, "Found ITE66121: 0x%x%x, revision: %u\n",
>> +                        ctx->vender_id, ctx->device_id, ctx->revision);
>> +       }
>> +
>> +       return 0;
>> +}
>> +
>>   static inline int it66121_preamble_ddc(struct it66121_ctx *ctx)
>>   {
>>          return regmap_write(ctx->regmap, IT66121_MASTER_SEL_REG, IT66121_MASTER_SEL_HOST);
>> @@ -1561,7 +1588,6 @@ static const char * const it66121_supplies[] = {
>>
>>   static int it66121_probe(struct i2c_client *client)
>>   {
>> -       u32 revision_id, vendor_ids[2] = { 0 }, device_ids[2] = { 0 };
>>          int ret;
>>          struct it66121_ctx *ctx;
>>          struct device *dev = &client->dev;
>> @@ -1603,19 +1629,13 @@ static int it66121_probe(struct i2c_client *client)
>>          if (IS_ERR(ctx->regmap))
>>                  return PTR_ERR(ctx->regmap);
>>
>> -       regmap_read(ctx->regmap, IT66121_VENDOR_ID0_REG, &vendor_ids[0]);
>> -       regmap_read(ctx->regmap, IT66121_VENDOR_ID1_REG, &vendor_ids[1]);
>> -       regmap_read(ctx->regmap, IT66121_DEVICE_ID0_REG, &device_ids[0]);
>> -       regmap_read(ctx->regmap, IT66121_DEVICE_ID1_REG, &device_ids[1]);
>> -
>> -       /* Revision is shared with DEVICE_ID1 */
>> -       revision_id = FIELD_GET(IT66121_REVISION_MASK, device_ids[1]);
>> -       device_ids[1] &= IT66121_DEVICE_ID1_MASK;
>> +       ret = it66121_read_chip_id(ctx, false);
>> +       if (ret)
>> +               return ret;
>>
>> -       if ((vendor_ids[1] << 8 | vendor_ids[0]) != ctx->info->vid ||
>> -           (device_ids[1] << 8 | device_ids[0]) != ctx->info->pid) {
>> +       if (ctx->vender_id != ctx->info->vid ||
>> +           ctx->device_id != ctx->info->pid)

Q: There is no need to store them, they are not used by the driver anywhere.

A: Here it is used, it is also used by the 0007-patch to get the entity(instance)-specific data.


Since it6610 was introduced, this is used for chip identifying.
It can also be used with in debugfs context, to show who I am.


>>                  return -ENODEV;
>> -       }
>>
>>          ctx->bridge.funcs = &it66121_bridge_funcs;
>>          ctx->bridge.of_node = dev->of_node;
>> @@ -1633,7 +1653,8 @@ static int it66121_probe(struct i2c_client *client)
>>
>>          drm_bridge_add(&ctx->bridge);
>>
>> -       dev_info(dev, "IT66121 revision %d probed\n", revision_id);
>> +       dev_info(dev, "IT66121 probed, chip id: 0x%x:0x%x, revision: %u\n",
>> +                ctx->vender_id, ctx->device_id, ctx->revision);
>>
>>          return 0;
>>   }
>> --
>> 2.34.1
>>
>
