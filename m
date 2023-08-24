Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E1B8786FD1
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 15:01:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236764AbjHXNBX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 09:01:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236661AbjHXNA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 09:00:59 -0400
Received: from luna.linkmauve.fr (82-65-109-163.subs.proxad.net [82.65.109.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD8E2E79;
        Thu, 24 Aug 2023 06:00:57 -0700 (PDT)
Received: by luna.linkmauve.fr (Postfix, from userid 1000)
        id 817038CC61B; Thu, 24 Aug 2023 15:00:56 +0200 (CEST)
Date:   Thu, 24 Aug 2023 15:00:56 +0200
From:   Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>,
        Alexandre Courbot <acourbot@nvidia.com>,
        azkali <a.ffcc7@gmail.com>, CTCaer <ctcaer@gmail.com>,
        Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] power: supply: bq24190: Support bq24193
Message-ID: <ZOdUiFsAjQCvwp1A@desktop>
References: <20230824112741.201353-1-linkmauve@linkmauve.fr>
 <20230824112741.201353-2-linkmauve@linkmauve.fr>
 <46a562b5-6984-3b41-3c41-c346107b4c96@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <46a562b5-6984-3b41-3c41-c346107b4c96@linaro.org>
Jabber-ID: linkmauve@linkmauve.fr
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,PDS_RDNS_DYNAMIC_FP,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_SORBS_DUL,RDNS_DYNAMIC,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 24, 2023 at 02:40:10PM +0200, Krzysztof Kozlowski wrote:
[…]
> > diff --git a/Documentation/devicetree/bindings/power/supply/bq24190.yaml b/Documentation/devicetree/bindings/power/supply/bq24190.yaml
> > index d3ebc9de8c0b..92a28d3c3070 100644
> > --- a/Documentation/devicetree/bindings/power/supply/bq24190.yaml
> > +++ b/Documentation/devicetree/bindings/power/supply/bq24190.yaml
> > @@ -18,6 +18,7 @@ properties:
> >      enum:
> >        - ti,bq24190
> >        - ti,bq24192
> > +      - ti,bq24193
> >        - ti,bq24192i
> >        - ti,bq24196
> >  
> > diff --git a/drivers/power/supply/bq24190_charger.c b/drivers/power/supply/bq24190_charger.c
> > index ef8235848f56..a56122b39687 100644
> > --- a/drivers/power/supply/bq24190_charger.c
> > +++ b/drivers/power/supply/bq24190_charger.c
> > @@ -2018,6 +2018,7 @@ static const struct dev_pm_ops bq24190_pm_ops = {
> >  static const struct i2c_device_id bq24190_i2c_ids[] = {
> >  	{ "bq24190" },
> >  	{ "bq24192" },
> > +	{ "bq24193" },
> >  	{ "bq24192i" },
> >  	{ "bq24196" },
> >  	{ },
> > @@ -2027,6 +2028,7 @@ MODULE_DEVICE_TABLE(i2c, bq24190_i2c_ids);
> >  static const struct of_device_id bq24190_of_match[] = {
> >  	{ .compatible = "ti,bq24190", },
> >  	{ .compatible = "ti,bq24192", },
> > +	{ .compatible = "ti,bq24193", },
> >  	{ .compatible = "ti,bq24192i", },
> >  	{ .compatible = "ti,bq24196", },
> 
> We should really stop doing this. All of them are compatible, aren't they?

From what I gather from the different datasheets, the main difference
between them is the maximum current they are able to provide, 1.5 A for
the bq24190 and bq24192i, 3 A for bq24192 and 4.5 A for bq24193. The
default current limit is also detected differently it seems.  But yeah,
those are otherwise similar enough to not require anything different in
the driver.

What would be a good way forward for that?  Adding a new ti,bq2419x
compatible and switching all devices to this one, as long as they don’t
require anything specific?

> 
> Best regards,
> Krzysztof
> 

Thanks,

-- 
Link Mauve
