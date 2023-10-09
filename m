Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C6C97BD656
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 11:09:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345729AbjJIJJC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 05:09:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345695AbjJIJI7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 05:08:59 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C2C45A3;
        Mon,  9 Oct 2023 02:08:57 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0A6551FB;
        Mon,  9 Oct 2023 02:09:38 -0700 (PDT)
Received: from e120937-lin (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A700B3F7A6;
        Mon,  9 Oct 2023 02:08:50 -0700 (PDT)
Date:   Mon, 9 Oct 2023 10:08:48 +0100
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Rob Herring <robh@kernel.org>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        sudeep.holla@arm.com, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, Oleksii_Moisieiev@epam.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [RFC v2 5/5] dt-bindings: gpio: Add bindings for pinctrl based
 generic gpio driver
Message-ID: <ZSPDILYZkxvTnQia@e120937-lin>
References: <20231005025843.508689-1-takahiro.akashi@linaro.org>
 <20231005025843.508689-6-takahiro.akashi@linaro.org>
 <20231006132346.GA3426353-robh@kernel.org>
 <CACRpkdaLsfSBEG-h9ZNT2_Lm8tW8AZO7tedDVNeuZoQAqSkyjw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACRpkdaLsfSBEG-h9ZNT2_Lm8tW8AZO7tedDVNeuZoQAqSkyjw@mail.gmail.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 09, 2023 at 09:49:33AM +0200, Linus Walleij wrote:
> On Fri, Oct 6, 2023 at 3:23 PM Rob Herring <robh@kernel.org> wrote:
> > On Thu, Oct 05, 2023 at 11:58:43AM +0900, AKASHI Takahiro wrote:
> 

Hi Linus and all,

> > > A dt binding for pin controller based generic gpio driver is defined in
> > > this commit. One usable device is Arm's SCMI.
> >
> > You don't need a "generic" binding to have a generic driver. Keep the
> > binding specific and then decide in the OS to whether to use a generic
> > or specific driver. That decision could change over time, but the
> > binding can't. For example, see simple-panel.
> 
> What you say is true for simple-panel (a word like "simple" should
> always cause red flags).
> 
> This case is more like mfd/syscon.yaml, where the singular
> compatible = "syscon"; is in widespread use:
> 
> $ git grep 'compatible = \"syscon\";' |wc -l
> 50
> 
> I would accept adding a tuple compatible if you insist, so:
> 
> compatible = "foo-silicon", "pin-contro-gpio";
> 
> One case will be something like:
> 
> compatible = "optee-scmi-pin-control", "pin-control-gpio";
> 
> In this case I happen to know that we have the problem of
> this being standardization work ahead of implementation on
> actual hardware, and that is driven by the will known firmware
> ambition to be completely abstract. It is supposed to sit on
> top of pin control, or as part of pin control. Which leads me to
> this thing (which I didn't think of before...)
> 
> > +    gpio0: gpio@0 {
> > +        compatible = "pin-control-gpio";
> > +        gpio-controller;
> > +        #gpio-cells = <2>;
> > +        gpio-ranges = <&scmi_pinctrl 0 10 5>,
> > +                      <&scmi_pinctrl 5 0 0>;
> > +        gpio-ranges-group-names = "",
> > +                                  "pinmux_gpio";
> > +    };
> 

Assuming the above &scmi_pinctrl refers to the protocol node as we
usually do,  I am a bit puzzled by this example in this RFC series, because
usually in SCMI we DO refer to some resources using the phandle and the
domain IDs as in:

	scmi_sensor: protocol@15 {
		reg = <15>;
		#thermal-sensors-cells = <1>;
	};

	...

	thermal_zones {
		pmic {
			thermal-sensor = <&scmi_sensor 0>;
		};
	};
 
BUT in the SCMI Pinctrl case the current v4 Oleksii series takes advantage
of the existing Pinctrl bindings and naming to describe and refer to
pin/groups/functions, indeed #pinctrl-cells is defined as '0' in the
upcoming SCMI DT protocol node @19 in Oleksii v4, since indeed all the
parsing/matching is done by resource-names following the Picntrl
framework conventions. (AFAIU)

Moreover, due to how the SCMI Pinctrl protocol defines and describes the
pins/groups/functions using a tuple like (<TYPE>, <ID>) , with TYPE
being pin/group/function, a generic binding like the above would have to
be defined by at least 2 cells to be able to identify an SCMI PinCtrl
resource by index. (if that is the aim here...)

Am I right to think that such a generic SCMI PinCtrl binding is still to
be defined somewhere on the SCMI side, if needed as such by this GPIO driver ?

... or I am missing something ?

Thanks,
Cristian
