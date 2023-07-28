Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 183B6766D28
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 14:24:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236414AbjG1MYS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 08:24:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237011AbjG1MXo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 08:23:44 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 064DC4491
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 05:21:45 -0700 (PDT)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[127.0.0.1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <j.zink@pengutronix.de>)
        id 1qPMTE-00071I-In; Fri, 28 Jul 2023 14:21:24 +0200
Message-ID: <f511c66b-10b3-0af1-3bb5-801060c3a55e@pengutronix.de>
Date:   Fri, 28 Jul 2023 14:21:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 3/3] drm/panel-simple: allow LVDS format override
Content-Language: en-US, de-DE
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     Neil Armstrong <neil.armstrong@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Dan Carpenter <error27@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, devicetree@vger.kernel.org,
        Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        patchwork-jzi@pengutronix.de, David Airlie <airlied@gmail.com>,
        kernel@pengutronix.de, kernel test robot <lkp@intel.com>
References: <20230523-simplepanel_support_nondefault_datamapping-v3-0-78ede374d3d9@pengutronix.de>
 <20230523-simplepanel_support_nondefault_datamapping-v3-3-78ede374d3d9@pengutronix.de>
 <1cd00596-604d-4fbf-b9d1-9ee0f05cb373@kadam.mountain>
From:   Johannes Zink <j.zink@pengutronix.de>
In-Reply-To: <1cd00596-604d-4fbf-b9d1-9ee0f05cb373@kadam.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: j.zink@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan,

thanks for your feedback.

On 7/28/23 14:03, Dan Carpenter wrote:
> On Fri, Jul 28, 2023 at 01:54:40PM +0200, Johannes Zink wrote:
>> @@ -556,7 +602,7 @@ static int panel_simple_probe(struct device *dev, const struct panel_desc *desc)
>>   	struct device_node *ddc;
>>   	int connector_type;
>>   	u32 bus_flags;
>> -	int err;
>> +	int err, ret;
> 
> I don't like this at all...
> 
>>   
>>   	panel = devm_kzalloc(dev, sizeof(*panel), GFP_KERNEL);
>>   	if (!panel)
>> @@ -601,6 +647,13 @@ static int panel_simple_probe(struct device *dev, const struct panel_desc *desc)
>>   			panel_simple_parse_panel_timing_node(dev, panel, &dt);
>>   	}
>>   
>> +	if (desc->connector_type == DRM_MODE_CONNECTOR_LVDS) {
>> +		/* Optional data-mapping property for overriding bus format */
>> +		ret = panel_simple_override_nondefault_lvds_datamapping(dev, panel);
>> +		if (ret)
>> +			goto free_ddc;
> 
> This *looks* like we are returning an error but we aren't.  I think we
> should be.  If not then we need to have a discussion about that and
> add some comments.
> 

Good catch. This should actually be err instead of ret. This way we'd make sure
to return -ENOMEM from panel_simple_probe() in case an error occured due
to devm_kmemdup failing in panel_simple_override_nondefault_lvds_datamapping().

I'll send a v4 with that fixed.

Thanks for having my back!
Johannes

> regards,
> dan carpenter
> 
>> +	}
>> +
>>   	connector_type = desc->connector_type;
>>   	/* Catch common mistakes for panels. */
>>   	switch (connector_type) {
>>
>> -- 
>> 2.39.2
> 
> 

-- 
Pengutronix e.K.                | Johannes Zink                  |
Steuerwalder Str. 21            | https://www.pengutronix.de/    |
31137 Hildesheim, Germany       | Phone: +49-5121-206917-0       |
Amtsgericht Hildesheim, HRA 2686| Fax:   +49-5121-206917-5555    |

