Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37C35774325
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 19:57:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234953AbjHHR5a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 13:57:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235203AbjHHR5C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 13:57:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8102CAD1A;
        Tue,  8 Aug 2023 09:25:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1E4F1623EB;
        Tue,  8 Aug 2023 04:36:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03487C433C7;
        Tue,  8 Aug 2023 04:36:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691469369;
        bh=IMgWwZ4rdhaoLfJ9wmfKo2+cng5qpJxVkmNuR2ToNbo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kUgys+Xtx3ItPxfY68wwjolIAgO72NEQe5mB342f1M7WPec873Dz3SkSCdrTMW5Hb
         MPBPYP7vT0yTHLn0VvtFPOts++DefKyFeZboOtwQG/pP4VK3t95O7NvRHYowDE7TmT
         8mBE4GJFdU36umK//qMGo3+liGHlEEk86BIneeEo=
Date:   Tue, 8 Aug 2023 06:36:06 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Nishanth Menon <nm@ti.com>
Cc:     Andrew Davis <afd@ti.com>, Peter Rosin <peda@axentia.se>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mux: mmio: use reg property when parent device is not
 a syscon
Message-ID: <2023080854-crummy-armored-420c@gregkh>
References: <20230605154153.24025-1-afd@ti.com>
 <b16568ec-0428-981b-01ca-571cc5d52704@ti.com>
 <20230807182645.ct2uvkb3s2tuplon@improve>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230807182645.ct2uvkb3s2tuplon@improve>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 07, 2023 at 01:26:45PM -0500, Nishanth Menon wrote:
> On 15:12-20230713, Andrew Davis wrote:
> > On 6/5/23 10:41 AM, Andrew Davis wrote:
> > > The DT binding for the reg-mux compatible states it can be used when the
> > > "parent device of mux controller is not syscon device". It also allows
> > > for a reg property. When the reg property is provided, use that to
> > > identify the address space for this mux. If not provided fallback to
> > > using the parent device as a regmap provider.
> > > 
> > > Signed-off-by: Andrew Davis <afd@ti.com>
> > > ---
> > 
> > Ping, still needed and applies cleanly on v6.5-rc1.
> > 
> > Andrew
> > 
> > > 
> > > Changes from v1:
> > >   - Flip logic as suggested in v1[0]
> > > 
> > > [0] https://lore.kernel.org/lkml/1c27d9d4-b1cc-c158-90f7-f7e47e02c424@ti.com/T/
> > > 
> > >   drivers/mux/mmio.c | 9 ++++++---
> > >   1 file changed, 6 insertions(+), 3 deletions(-)
> 
> 
> Reviewed-by: Nishanth Menon <nm@ti.com>
> 
> Greg: looks like you were missed in CC
> 
> Peter/Greg: Any chance of Looking at this? This is a basic corner stone
> for us to clean up much of the mess we have created up in the device
> tree syscon nodes and trying to transition those into simple-bus.
> 
> > > 
> > > diff --git a/drivers/mux/mmio.c b/drivers/mux/mmio.c
> > > index 44a7a0e885b8d..2c9e4df9d6f2c 100644
> > > --- a/drivers/mux/mmio.c
> > > +++ b/drivers/mux/mmio.c
> > > @@ -44,10 +44,13 @@ static int mux_mmio_probe(struct platform_device *pdev)
> > >   	int ret;
> > >   	int i;
> > > -	if (of_device_is_compatible(np, "mmio-mux"))
> > > +	if (of_device_is_compatible(np, "mmio-mux")) {
> > >   		regmap = syscon_node_to_regmap(np->parent);
> > > -	else
> > > -		regmap = dev_get_regmap(dev->parent, NULL) ?: ERR_PTR(-ENODEV);
> > > +	} else {
> > > +		regmap = device_node_to_regmap(np);
> > > +		if (IS_ERR(regmap))
> > > +			regmap = dev_get_regmap(dev->parent, NULL) ?: ERR_PTR(-ENODEV);
> > > +	}
> > >   	if (IS_ERR(regmap)) {
> > >   		ret = PTR_ERR(regmap);
> > >   		dev_err(dev, "failed to get regmap: %d\n", ret);

I'm not the maintainer here, it's up to Peter.

