Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63B8B7EDE3C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 11:13:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235408AbjKPKNS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 05:13:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234970AbjKPKNQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 05:13:16 -0500
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EC031AE
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 02:13:05 -0800 (PST)
Message-ID: <121163c9-0d56-47ad-a12e-e67390fef2b4@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1700129583;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=x2/NJA7ywSEAZY6s2t2yF+R5iHHDWkweZBt6DBgrSpM=;
        b=WpqHKP837fwO98gcuTy19uklf6Dai09g2jF6PBn/gEg65pLQO0GmUgvHiTR9jxz7WJmfxP
        abtp1YLBbdCNrt1nrC+Zcuqy7tNDjwGDTmWkNmms1YSFSlNVM5UjcI4VVFJozrpJkw2k6F
        trvriyuUB6yvfmuj6BQViRMWNu3pGv0=
Date:   Thu, 16 Nov 2023 18:12:55 +0800
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
 <79301d04-c0cb-4740-8a6d-27a889b65daf@linux.dev>
 <CAA8EJpom5kAbDkacOdqp6BR7YPfmCSXaQfDYRVcLf9eGmi64CQ@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Sui Jingfeng <sui.jingfeng@linux.dev>
In-Reply-To: <CAA8EJpom5kAbDkacOdqp6BR7YPfmCSXaQfDYRVcLf9eGmi64CQ@mail.gmail.com>
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


On 2023/11/16 17:30, Dmitry Baryshkov wrote:
> On Thu, 16 Nov 2023 at 11:14, Sui Jingfeng <sui.jingfeng@linux.dev> wrote:
>> Hi,
>>
>> Thanks a lot for reviewing!
>>
>>
>> On 2023/11/15 00:30, Dmitry Baryshkov wrote:
>>> On Tue, 14 Nov 2023 at 17:09, Sui Jingfeng <sui.jingfeng@linux.dev> wrote:
>>>> From: Sui Jingfeng <suijingfeng@loongson.cn>
>>>>
>>>> The it66121_create_bridge() and it66121_destroy_bridge() are added to
>>>> export the core functionalities. Create a connector manually by using
>>>> bridge connector helpers when link as a lib.
>>>>
>>>> Signed-off-by: Sui Jingfeng <suijingfeng@loongson.cn>
>>>> ---
>>>>    drivers/gpu/drm/bridge/ite-it66121.c | 134 +++++++++++++++++++--------
>>>>    include/drm/bridge/ite-it66121.h     |  17 ++++
>>>>    2 files changed, 113 insertions(+), 38 deletions(-)
>>>>    create mode 100644 include/drm/bridge/ite-it66121.h
>>>>
>>>> diff --git a/drivers/gpu/drm/bridge/ite-it66121.c b/drivers/gpu/drm/bridge/ite-it66121.c
>>>> index 8971414a2a60..f5968b679c5d 100644
>>>> --- a/drivers/gpu/drm/bridge/ite-it66121.c
>>>> +++ b/drivers/gpu/drm/bridge/ite-it66121.c
>>>> @@ -22,6 +22,7 @@
>>>>
>>>>    #include <drm/drm_atomic_helper.h>
>>>>    #include <drm/drm_bridge.h>
>>>> +#include <drm/drm_bridge_connector.h>
>>>>    #include <drm/drm_edid.h>
>>>>    #include <drm/drm_modes.h>
>>>>    #include <drm/drm_print.h>
>>>> @@ -703,14 +704,32 @@ static int it66121_bridge_attach(struct drm_bridge *bridge,
>>>>                                    enum drm_bridge_attach_flags flags)
>>>>    {
>>>>           struct it66121_ctx *ctx = bridge_to_it66121(bridge);
>>>> +       struct drm_bridge *next_bridge = ctx->next_bridge;
>>>> +       struct drm_encoder *encoder = bridge->encoder;
>>>>           int ret;
>>>>
>>>> -       if (!(flags & DRM_BRIDGE_ATTACH_NO_CONNECTOR))
>>>> -               return -EINVAL;
>>>> +       if (next_bridge) {
>>>> +               if (!(flags & DRM_BRIDGE_ATTACH_NO_CONNECTOR)) {
>>>> +                       WARN_ON(1);
>>> Why? At least use WARN() instead
>> Originally I want to
>>
>>
>>
>>
>>>> +                       flags |= DRM_BRIDGE_ATTACH_NO_CONNECTOR;
>>>> +               }
>>>> +               ret = drm_bridge_attach(encoder, next_bridge, bridge, flags);
>>>> +               if (ret)
>>>> +                       return ret;
>>>> +       } else {
>>>> +               struct drm_connector *connector;
>>>>
>>>> -       ret = drm_bridge_attach(bridge->encoder, ctx->next_bridge, bridge, flags);
>>>> -       if (ret)
>>>> -               return ret;
>>>> +               if (flags & DRM_BRIDGE_ATTACH_NO_CONNECTOR)
>>>> +                       WARN_ON(1);
>>> No. It is perfectly fine to create attach a bridge with no next_bridge
>>> and with the DRM_BRIDGE_ATTACH_NO_CONNECTOR flag.
>>>
>> The document say when DRM_BRIDGE_ATTACH_NO_CONNECTOR flag is set
>> the bridge shall not create a drm_connector. So I think if a display
>> bridge driver don't have a next bridge attached (Currently, this is
>> told by the DT), it says that this is a non-DT environment. On such
>> a case, this display bridge driver(it66121.ko) should behavior like
>> a *agent*. Because the upstream port of it66121 is the DVO port of
>> the display controller, the downstream port of it66121 is the HDMI
>> connector. it66121 is on the middle. So I think the it66121.ko should
>> handle all of troubles on behalf of the display controller drivers.
> No. Don't make decisions for the other drivers. They might have different needs.

[...]


>
>> Therefore (when in non-DT use case), the display controller drivers
>> side should not set DRM_BRIDGE_ATTACH_NO_CONNECTOR flag anymore.
>> Which is to hint that the it66121 should totally in charge of those
>> tasks (either by using bridge connector helper or create a connector
>> manually). I don't understand on such a case, why bother display
>> controller drivers anymore.
> This is the reason why we had introduced this flag. It allows the
> driver to customise the connector. It even allows the driver to
> implement a connector on its own, completely ignoring the
> drm_bridge_connector.


I know what you said is right in the sense of the universe cases,
but I think the most frequent(majority) use case is that there is
only one display bridge on the middle. Therefore, I don't want to
movethe connector things into device driver if there is only one display 
bridge(say it66121) in the middle. After all, there is no *direct 
physical connection* from the perspective of the hardware. I means that 
there is no hardware wires connectthe HDMI connector and the DVO port. So display controller drivers 
should not interact with anything related with the connector on a 
perfect abstract on the software side. Especially for such a simple use 
case. It probably make senses to make a  decision for themost frequently use case, please also note
that this patch didn't introduce any-restriction for the more advance
uses cases(multiple bridges in the middle).


>>
>>>> +
>>>> +               connector = drm_bridge_connector_init(bridge->dev, encoder);
>>>> +               if (IS_ERR(connector))
>>>> +                       return PTR_ERR(connector);
>>>> +
>>>> +               drm_connector_attach_encoder(connector, encoder);
>>> This goes into your device driver.
>>>
>>>> +
>>>> +               ctx->connector = connector;
>>>> +       }
>>>>
>>>>           if (ctx->info->id == ID_IT66121) {
>>>>                   ret = regmap_write_bits(ctx->regmap, IT66121_CLK_BANK_REG,
>>>> @@ -1632,16 +1651,13 @@ static const char * const it66121_supplies[] = {
>>>>           "vcn33", "vcn18", "vrf12"
>>>>    };
>
>
