Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47D4A771F09
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 12:59:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231714AbjHGK73 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 06:59:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbjHGK70 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 06:59:26 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7A5EA10FA;
        Mon,  7 Aug 2023 03:59:25 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 8EDEC809D;
        Mon,  7 Aug 2023 10:59:24 +0000 (UTC)
Date:   Mon, 7 Aug 2023 13:59:23 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Dhruva Gole <d-gole@ti.com>
Cc:     Nishanth Menon <nm@ti.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-omap@vger.kernel.org, linux-gpio@vger.kernel.org,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH] pinctrl: single: Add compatible for ti,am625-padconf
Message-ID: <20230807105923.GO14799@atomide.com>
References: <20230805045554.786092-1-d-gole@ti.com>
 <20230805171508.schg4xquoa24klk5@october>
 <20230807070724.GN14799@atomide.com>
 <20230807080922.t35yvyvrknjcriyr@dhruva>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230807080922.t35yvyvrknjcriyr@dhruva>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Dhruva Gole <d-gole@ti.com> [230807 08:09]:
> On Aug 07, 2023 at 10:07:24 +0300, Tony Lindgren wrote:
> > * Nishanth Menon <nm@ti.com> [230805 17:15]:
> > > On 10:25-20230805, Dhruva Gole wrote:
> > > > From: Tony Lindgren <tony@atomide.com>
> > > > +static const struct pcs_soc_data pinctrl_single_am625 = {
> > > > +	.flags = PCS_QUIRK_SHARED_IRQ | PCS_CONTEXT_LOSS_OFF,
> > > > +	.irq_enable_mask = (1 << 29),   /* WKUP_EN */
> > > > +	.irq_status_mask = (1 << 30),   /* WKUP_EVT */
> > > > +};
> > > > +
> > > 
> > > Why cant we set this in the k3-pinctrl.h and set it once?
> 
> Do you mean that I set 1 << 29 and 30 as sort of macros in the
> k3-pinctrl.h file and then include it in pinctrl-single.c?
> 
> Are we okay to #include a header from arch/arm64/boot/dts/ti?

Yes, but SoC specific defines needs to start with a SoC specific
prefix as multiple files may be included for various SoCs.

> If I understand what Nishanth is saying correctly, are we expected to
> set the wake_en bit on every single K3 SoC's every single padconf reg?
> 
> I am a little sceptical with this approach, because what is people
> _don't_ want to wakeup from certain pads? What would be the right way to
> disable wakeup on those pads then?

The wake_en only gets set when some driver does request_irq() on
the wakeirq. No need to set them all.

> Sure, I could take a look, but setting wake_en on all pads still
> doesn't feel right to me.

No need to set all wake_en pads, just checking that if request_irq()
is done for some pin that does not have wake_en capability does not
cause eternal interrupts if a reserved bit is high all the time :)

Regards,

Tony
