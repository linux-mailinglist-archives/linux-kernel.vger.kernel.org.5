Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B825772DD9
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 20:27:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229827AbjHGS06 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 14:26:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjHGS05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 14:26:57 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77FDC8F;
        Mon,  7 Aug 2023 11:26:55 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 377IQkUP090374;
        Mon, 7 Aug 2023 13:26:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691432806;
        bh=2EnyPrs/cBI+rlI07B1v5rUd2uvloil8hm66/Q0Hrno=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=KxiPLkvWqdp1YG2KSWOT7IYVGlm5X5WTZi5O1lwkWLG68UERiqh/sTYOt2rAIpSKX
         5nAm7YjJ98/Ur05hA9rQIZz5TIHS2BNG8HCa6np+Rj2bwU6cHV07eLj8OT1cHkX2Ed
         a8krfurCBFUMClwbyFuxULUW5wBi+iQdOPYSQQ4c=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 377IQj6Q095573
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 7 Aug 2023 13:26:46 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 7
 Aug 2023 13:26:45 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 7 Aug 2023 13:26:45 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 377IQjNi058017;
        Mon, 7 Aug 2023 13:26:45 -0500
Date:   Mon, 7 Aug 2023 13:26:45 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Andrew Davis <afd@ti.com>, Peter Rosin <peda@axentia.se>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Peter Rosin <peda@axentia.se>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] mux: mmio: use reg property when parent device is not
 a syscon
Message-ID: <20230807182645.ct2uvkb3s2tuplon@improve>
References: <20230605154153.24025-1-afd@ti.com>
 <b16568ec-0428-981b-01ca-571cc5d52704@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <b16568ec-0428-981b-01ca-571cc5d52704@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15:12-20230713, Andrew Davis wrote:
> On 6/5/23 10:41 AM, Andrew Davis wrote:
> > The DT binding for the reg-mux compatible states it can be used when the
> > "parent device of mux controller is not syscon device". It also allows
> > for a reg property. When the reg property is provided, use that to
> > identify the address space for this mux. If not provided fallback to
> > using the parent device as a regmap provider.
> > 
> > Signed-off-by: Andrew Davis <afd@ti.com>
> > ---
> 
> Ping, still needed and applies cleanly on v6.5-rc1.
> 
> Andrew
> 
> > 
> > Changes from v1:
> >   - Flip logic as suggested in v1[0]
> > 
> > [0] https://lore.kernel.org/lkml/1c27d9d4-b1cc-c158-90f7-f7e47e02c424@ti.com/T/
> > 
> >   drivers/mux/mmio.c | 9 ++++++---
> >   1 file changed, 6 insertions(+), 3 deletions(-)


Reviewed-by: Nishanth Menon <nm@ti.com>

Greg: looks like you were missed in CC

Peter/Greg: Any chance of Looking at this? This is a basic corner stone
for us to clean up much of the mess we have created up in the device
tree syscon nodes and trying to transition those into simple-bus.

> > 
> > diff --git a/drivers/mux/mmio.c b/drivers/mux/mmio.c
> > index 44a7a0e885b8d..2c9e4df9d6f2c 100644
> > --- a/drivers/mux/mmio.c
> > +++ b/drivers/mux/mmio.c
> > @@ -44,10 +44,13 @@ static int mux_mmio_probe(struct platform_device *pdev)
> >   	int ret;
> >   	int i;
> > -	if (of_device_is_compatible(np, "mmio-mux"))
> > +	if (of_device_is_compatible(np, "mmio-mux")) {
> >   		regmap = syscon_node_to_regmap(np->parent);
> > -	else
> > -		regmap = dev_get_regmap(dev->parent, NULL) ?: ERR_PTR(-ENODEV);
> > +	} else {
> > +		regmap = device_node_to_regmap(np);
> > +		if (IS_ERR(regmap))
> > +			regmap = dev_get_regmap(dev->parent, NULL) ?: ERR_PTR(-ENODEV);
> > +	}
> >   	if (IS_ERR(regmap)) {
> >   		ret = PTR_ERR(regmap);
> >   		dev_err(dev, "failed to get regmap: %d\n", ret);

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
