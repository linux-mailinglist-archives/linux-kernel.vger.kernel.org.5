Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B716793869
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 11:35:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235586AbjIFJfx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 05:35:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbjIFJfw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 05:35:52 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B9081984;
        Wed,  6 Sep 2023 02:35:26 -0700 (PDT)
Received: from pendragon.ideasonboard.com (ftip006315900.acc1.colindale.21cn-nte.bt.net [81.134.214.249])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 8A714E45;
        Wed,  6 Sep 2023 11:33:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1693992831;
        bh=H4jLGHq4HFIPCWPR70vaeuMwMZnYsK+8uQ82mVTVoE0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d1rk4qVrXBYjLglqF8U1UCEaMcZuzqxuVlEkZ313xpRI+sYsCITcSIi/SC2AYwI8C
         JLpEGnZbJVurkcgs1iBG+PBn1b/IRCahK8vEmzAR5hCz2u5PykIGk0c8rPhLFVl/R5
         9rn8dwPvosh0MOmoojOVUcpYj7xSdSiOQEo3WJks=
Date:   Wed, 6 Sep 2023 12:35:31 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Paul Elder <paul.elder@ideasonboard.com>,
        linux-media@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 3/3] arm64: dts: mediatek: mt8365-pumpkin: Add overlays
 for thp7312 cameras
Message-ID: <20230906093531.GO7971@pendragon.ideasonboard.com>
References: <20230905233118.183140-1-paul.elder@ideasonboard.com>
 <20230905233118.183140-4-paul.elder@ideasonboard.com>
 <502fc7b1-a32d-6901-3a45-d2aa0e0c3849@linaro.org>
 <20230906083237.GL7971@pendragon.ideasonboard.com>
 <a3ed9856-a87b-5cf6-26b5-ff2b19234a8a@linaro.org>
 <20230906090058.GB17308@pendragon.ideasonboard.com>
 <59e07c6a-6f1b-0cc7-dddc-96d2a4050843@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <59e07c6a-6f1b-0cc7-dddc-96d2a4050843@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 06, 2023 at 11:21:31AM +0200, Krzysztof Kozlowski wrote:
> On 06/09/2023 11:00, Laurent Pinchart wrote:
> >>> has a regulator@0. There are similar instances for clocks.
> >>>
> >>> I understand why it may not be a good idea, and how the root node is
> >>> indeed not a bus. In some cases, those regulators and clocks are grouped
> >>> in a regulators or clocks node that has a "simple-bus" compatible. I'm
> >>> not sure if that's a good idea, but at least it should validate.
> >>>
> >>> What's the best practice for discrete board-level clocks and regulators
> >>> in overlays ? How do we ensure that their node name will not conflict
> >>> with the board to which the overlay is attached ?
> >>
> >> Top-level nodes (so under /) do not have unit addresses. If they have -
> >> it's an error, because it is not a bus. Also, unit address requires reg.
> >> No reg? No unit address. DTC reports this as warnings as well.
> > 
> > I agree with all that, but what's the recommended practice to add
> > top-level clocks and regulators in overlays, in a way that avoids
> > namespace clashes with the base board ?
> 
> Whether you use regulator@0 or regulator-0, you have the same chances of
> clash.

No disagreement there. My question is whether there's a recommended
practice to avoid clashes, or if it's an unsolved problem that gets
ignored for now because there's only 36h in a day and there are more
urgent things to do.

> >>>>> +		orientation = <0>;
> >>>>> +		rotation = <0>;
> >>>>> +
> >>>>> +		thine,rx,data-lanes = <4 1 3 2>;
> >>>>
> >>>> NAK for this property.
> >>>
> >>> Please explain why. You commented very briefly in the bindings review,
> >>> and it wasn't clear to me if you were happy or not with the property,
> >>> and if not, why.
> >>
> >> Because it is duplicating endpoint. At least from the description.
> > 
> > The THP7312 is an external ISP. At the hardware level, it has an input
> > side, with a CSI-2 receiver and an I2C master controller, and an output
> > side, with a CSI-2 transmitter and an I2C slave controller. A raw camera
> > sensor is connected on the input side, transmitting image data to the
> > THP7312, and being controlled over I2C by the firmware running on the
> > THP7312. From a Linux point of view, only the output side of the THP7312
> > is visible, and the combination of the raw camera sensor and the THP7312
> > acts as a smart camera sensor, producing YUV images.
> 
> None of this was explained in the device description or property field.

I agree this can be improved. Paul, can you expand the description to
make it clearer in the next version ?

> I probably judged to fast but it just looked like duplicated property.
> Then shouldn't it have two ports, even if camera side is not visible for
> the Linux?

I'm in two minds about this. On one hand, using ports means we can reuse
standard properties, as well as helper code in the kernel, which is
nice. On the other hand, it means we would also need to add a DT node
to model the sensor, but the sensor isn't exposed to Linux, so we don't
want that node to cause a device being instantiated.

I think we'll need to add more properties related to the camera sensor
in the future. Coupled with the fact that the THP7312 actually has two
inputs to support two sensors at the same time (which neither the
bindings nor the driver curently support, but that's fine, they can be
added later), it would be nice to group all properties related to a
particular THP7312 input in a node. I've given this a try for the AP1302
(another external ISP) a while ago. The bindings have been posted in
https://lore.kernel.org/linux-media/20211006113254.3470-2-anil.mamidala@xilinx.com/.
It still doesn't connect the sensors to the ISP in DT, but it nicely
groups all sensor-related properties together. Is this something that
you would be happier with ?

> > As there are two CSI-2 buses, the data lanes configuration needs to be
> > specified for both sides. On the output side, connected to the SoC and
> > visible to Linux, the bindings use a port node with an endpoint and the
> > standard data-lanes property. On the input side, which is invisible to
> > Linux, the bindings use the vendor-specific thine,rx,data-lanes
> > property. Its semantics is identical to the standard data-lanes
> > property, but it's not located in an endpoint as there's no port for the
> > input side.
> 
> And how does the property support multiple sensors? What if they data
> lanes are also different between each other?

Ignoring for a moment that the THP7312 has two inputs, there would be no
problem I think, as only one sensor is connected to the input. Different
sensor models can be used on different boards, but only one at a time.

To support the second input, we could add a thine,rx2,data-lanes
property. It's not great, but not that bad either if it stopped there.
However, if we later have to add additional sensor-related properties
(such as regulators for instance), it could become ugly. Grouping
sensor-related properties in child sensor nodes would be nicer I
believe.

-- 
Regards,

Laurent Pinchart
