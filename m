Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29B407EDE79
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 11:29:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230348AbjKPK34 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 05:29:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbjKPK3x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 05:29:53 -0500
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DA97B7
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 02:29:49 -0800 (PST)
Message-ID: <50006160-f82b-4ec1-91a4-2ebbd7752e1d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1700130588;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=M9Tiz4ZqcvP9PVbA0QUZ7/XAmQaSaESa8alpLYKuTXs=;
        b=gN0djCjFpM84zH6NfgBbkC3hSOihpNiLmCzdaRDiimhppbOM/E9yIbtA4YpVMSGcYtmbly
        Sf2YUGzE1sQelfoBBm9AcQBrB1WuHRsVdO8fG23ata6R0a82V5wlzuqapNRre7wvd1v0kr
        uD/cxYL9mvGHwIQ5KRfKPVqFEu7s+50=
Date:   Thu, 16 Nov 2023 18:29:39 +0800
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
Content-Transfer-Encoding: 8bit
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
>> @@ -703,14 +704,32 @@ static int it66121_bridge_attach(struct drm_bridge *bridge,
>>                                   enum drm_bridge_attach_flags flags)
>>   {
>>          struct it66121_ctx *ctx = bridge_to_it66121(bridge);
>> +       struct drm_bridge *next_bridge = ctx->next_bridge;
>> +       struct drm_encoder *encoder = bridge->encoder;
>>          int ret;
>>
>> -       if (!(flags & DRM_BRIDGE_ATTACH_NO_CONNECTOR))
>> -               return -EINVAL;
>> +       if (next_bridge) {
>> +               if (!(flags & DRM_BRIDGE_ATTACH_NO_CONNECTOR)) {
>> +                       WARN_ON(1);
> Why? At least use WARN() instead

If (next_bridge) is true, it says that the driver *already* known that
it66121 have a next bridges attached. Then it66121 driver should certainly
attach it, no matter what it is. Either a connector or another display bridge.
It also says that this is a DT-based system on such a case. CallingWARN_ON(1) here helps to see(print) which DC driver is doing the wired 
things. Ok, I will remove the WARN_ON(1)  on the next version.

