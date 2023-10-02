Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7764A7B559E
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 17:01:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237911AbjJBO6g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 10:58:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237919AbjJBO6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 10:58:35 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 03A4CB3;
        Mon,  2 Oct 2023 07:58:31 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 20E62C15;
        Mon,  2 Oct 2023 07:59:10 -0700 (PDT)
Received: from pluto (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D53C03F762;
        Mon,  2 Oct 2023 07:58:29 -0700 (PDT)
Date:   Mon, 2 Oct 2023 15:58:27 +0100
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     Rob Herring <robh@kernel.org>
Cc:     AKASHI Takahiro <takahiro.akashi@linaro.org>, sudeep.holla@arm.com,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linus.walleij@linaro.org, Oleksii_Moisieiev@epam.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [RFC 4/4] dt-bindings: gpio: Add bindings for SCMI pinctrl based
 gpio
Message-ID: <ZRrak57Vg0X0Aqf3@pluto>
References: <20231002021602.260100-1-takahiro.akashi@linaro.org>
 <20231002021602.260100-5-takahiro.akashi@linaro.org>
 <20231002144155.GA1675188-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231002144155.GA1675188-robh@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 02, 2023 at 09:41:55AM -0500, Rob Herring wrote:
> On Mon, Oct 02, 2023 at 11:16:02AM +0900, AKASHI Takahiro wrote:
> > A dt binding for SCMI pinctrl based gpio driver is defined in this
> > commit. It basically conforms to generic pinctrl-gpio mapping framework.

[ snip]

> > +    additionalProperties: false
> > +
> > +required:
> > +  - compatible
> > +  - gpio-controller
> > +  - "#gpio-cells"
> > +  - gpio-ranges
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/gpio/gpio.h>
> > +
> > +    scmi_gpio_0: scmi_gpio@0 {
> 
> gpio {
> 
> But doesn't SCMI have protocol numbers?
> 

My understanding is that this RFC GPIO driver from Akashi is built
completely on Pinctrl facilities (as he says in the cover), it is not
indeed a typical pure SCMI driver, it just happen to trigger the use
of SCMI if the underlying backend pinctrl driver is pinctrl-scmi;
but this driver does not really call directly into any SCMI API by
itself, i.e. it does not get and call any SCMI protocol ops.
(but it could indeed trigger the backend Pinctrl SCMI driver to issue
 such call on its behalf AFAIU...)

I wonder why it has even a dependency on PINCTRL_SCMI at this point;
is not that it could work (generically) even if the backend Pinctrl
driver is NOT SCMI ?
What makes it usable only against an SCMI Pinctrl backend ?
Cannot be a generic GPIO driver based on top of Pinctrl, no matter which
Pinctrl backend driver has been configured ?

...I maybe missing something here about Pinctrl AND GPIO frameworks :P

Thanks,
Cristian
