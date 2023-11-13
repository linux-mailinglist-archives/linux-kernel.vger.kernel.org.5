Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 876137E9FF1
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 16:28:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbjKMP2r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 10:28:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjKMP2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 10:28:44 -0500
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 949E8D63;
        Mon, 13 Nov 2023 07:28:39 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id AE965E000C;
        Mon, 13 Nov 2023 15:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1699889316;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aIIRnOM8lZdjayyVbJdSL02qsiaukPJ406eFMm5UKFA=;
        b=ItggKojN8r1Km5DPV7lScttvphF0TWoJVrHORGuEhlDw0Qg2DhcCPPboAYQdqYRuFQ/Xw2
        0PhAjNVYoNzxQ9i1lKs9karTKqIcjjA3/h3x/MzgNeL8Vb4YIVbgT94jeqI5yq8a69M9Dk
        sYK97Fy2bRwN5bgEoiSNDH2DkRccGIH3zX2pDveFTKsdCxpV3qOf2jiTBe/0RZk8clc2WD
        1dvU6j/PRsxadugl5WJY/da4I0NSq53+tNNL4kkdp6rkmMJ8Z9n0CGGGUAQlbqyKtP9LaK
        iiiMTYfUiZ2lMgj7y7naY4kIF1B56H6u1tJwKx8HBsq9saQ+l8qPht6SVUAg6Q==
Date:   Mon, 13 Nov 2023 16:28:34 +0100
From:   Mehdi Djait <mehdi.djait@bootlin.com>
To:     Michael Riesch <michael.riesch@wolfvision.net>
Cc:     mchehab@kernel.org, heiko@sntech.de, hverkuil-cisco@xs4all.nl,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        conor+dt@kernel.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, alexandre.belloni@bootlin.com,
        maxime.chevallier@bootlin.com, paul.kocialkowski@bootlin.com
Subject: Re: [PATCH v10 2/3] media: rockchip: Add a driver for Rockchip's
 camera interface
Message-ID: <ZVJAogJsTidx+Cg1@pc-70.home>
References: <cover.1699460637.git.mehdi.djait@bootlin.com>
 <bcc0b84f4a6a8cf4c007cfe25025060b22627408.1699460637.git.mehdi.djait@bootlin.com>
 <4f9bc04b-81af-49ee-9818-d4cd281504e7@wolfvision.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4f9bc04b-81af-49ee-9818-d4cd281504e7@wolfvision.net>
X-GND-Sasl: mehdi.djait@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

On Fri, Nov 10, 2023 at 03:33:34PM +0100, Michael Riesch wrote:
> Hi Mehdi,
> 
> Sorry, forgot one thing:
> 
> On 11/8/23 17:38, Mehdi Djait wrote:
> > +static int cif_subdev_notifier(struct cif_device *cif_dev)
> > +{
> > +	struct v4l2_async_notifier *ntf = &cif_dev->notifier;
> > +	struct device *dev = cif_dev->dev;
> > +	struct v4l2_async_connection *asd;
> > +	struct v4l2_fwnode_endpoint vep = {
> > +		.bus_type = V4L2_MBUS_PARALLEL,
> 
> This is surprising. I had to set this to V4L2_MBUS_UNKNOWN, otherwise
> v4l2_fwnode_endpoint_parse would yield -ENXIO, which indicates a bus
> type mismatch. Does this really work for your (BT.656, right?) setup?
> 

Yes it works.

> I think we should get the bus type from the device tree, right?
> 

I am looking into this.

> Thanks and best regards,
> Michael
> 

I assume you have a "bus-type = <MEDIA_BUS_TYPE_BT656>;" in the device
tree definition of your endpoint ? This caused the mismatch as the
v4l2_fwnode_endpoint is set to PARALLEL

--
Kind Regards
Mehdi Djait
