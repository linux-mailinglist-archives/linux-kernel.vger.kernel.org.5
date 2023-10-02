Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6C0F7B52D9
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 14:21:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237007AbjJBMV0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 08:21:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236933AbjJBMVX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 08:21:23 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08A6994
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 05:21:20 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D79BCC433C7;
        Mon,  2 Oct 2023 12:21:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696249279;
        bh=j6GCwRHciLgjRT87l8yg8vMEZ+mk/SUuffwOzm0R1xs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DKYQ8mdZOgKw8zZeEEHwVzD2dedtzq2hQK80iOXudNyaRmZDYwknuXEObVp2rLKa5
         29voMfvZ84T8EQaRhGSryhRZaeQ6lRUtS/I36rAxAwXjOfeJlp25ZwvRa5zzSehzC+
         R7235RFh0t5yBQ66nKLx2cyDoNJOGs2NS3UG170A=
Date:   Mon, 2 Oct 2023 14:21:15 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     richard.yu@hpe.com
Cc:     verdun@hpe.com, nick.hawkins@hpe.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] usb: gadget: udc: gxp-udc: add HPE GXP USB HUB
 support
Message-ID: <2023100212-hyperlink-prolonged-3e18@gregkh>
References: <20230907210601.25284-1-richard.yu@hpe.com>
 <20230907210601.25284-3-richard.yu@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230907210601.25284-3-richard.yu@hpe.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 07, 2023 at 04:06:00PM -0500, richard.yu@hpe.com wrote:
> +struct gxp_udc_drvdata {
> +	void __iomem *base;
> +	struct platform_device *pdev;
> +	struct regmap *udcg_map;
> +	struct gxp_udc_ep ep[GXP_UDC_MAX_NUM_EP];
> +
> +	int irq;
> +
> +	/* sysfs enclosure for the gadget gunk */
> +	struct device *port_dev;

A "raw" struct device?  That's not ok.  It's also going to break things,
how was this tested?  What does it look like in sysfs with this device?

> +	/*
> +	 * The UDC core really needs us to have separate and uniquely
> +	 * named "parent" devices for each port so we create a sub device
> +	 * here for that purpose
> +	 */
> +	drvdata->port_dev = kzalloc(sizeof(*drvdata->port_dev), GFP_KERNEL);
> +	if (!drvdata->port_dev) {
> +		rc = -ENOMEM;
> +		goto fail_alloc;
> +	}
> +	device_initialize(drvdata->port_dev);
> +	drvdata->port_dev->release = gxp_udc_dev_release;
> +	drvdata->port_dev->parent = parent;
> +	dev_set_name(drvdata->port_dev, "%s:p%d", dev_name(parent), idx + 1);
> +
> +	/* DMA setting */
> +	drvdata->port_dev->dma_mask = parent->dma_mask;
> +	drvdata->port_dev->coherent_dma_mask = parent->coherent_dma_mask;
> +	drvdata->port_dev->bus_dma_limit = parent->bus_dma_limit;
> +	drvdata->port_dev->dma_range_map = parent->dma_range_map;
> +	drvdata->port_dev->dma_parms = parent->dma_parms;
> +	drvdata->port_dev->dma_pools = parent->dma_pools;
> +
> +	rc = device_add(drvdata->port_dev);

So you createad a "raw" device that does not belong to any bus or type
and add it to sysfs?  Why?  Shouldn't it be a "virtual" device if you
really want/need one?

> +	if (rc)
> +		goto fail_add;
> +
> +	/* Populate gadget */
> +	gxp_udc_init(drvdata);
> +
> +	rc = usb_add_gadget_udc(drvdata->port_dev, &drvdata->gadget);
> +	if (rc != 0) {
> +		dev_err(drvdata->port_dev, "add gadget failed\n");
> +		goto fail_udc;
> +	}
> +	rc = devm_request_irq(drvdata->port_dev,
> +			      drvdata->irq,
> +			      gxp_udc_irq,
> +			      IRQF_SHARED,
> +			      gxp_udc_name[drvdata->vdevnum],
> +			      drvdata);

devm_request_irq() is _very_ tricky, are you _SURE_ you got it right
here?  Why do you need to use it?

> +	if (rc < 0) {
> +		dev_err(drvdata->port_dev, "irq request failed\n");
> +		goto fail_udc;
> +	}
> +
> +	return 0;
> +
> +	/* ran code to simulate these three error exit, no double free */

What does this comment mean?

> +fail_udc:
> +	device_del(drvdata->port_dev);
> +fail_add:
> +	put_device(drvdata->port_dev);
> +fail_alloc:
> +	devm_kfree(parent, drvdata);
> +
> +	return rc;
> +}

Where is the device removed from the system when done?

thanks,

greg k-h
