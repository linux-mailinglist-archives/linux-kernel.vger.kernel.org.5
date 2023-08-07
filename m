Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 703FA771B20
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 09:07:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231361AbjHGHHe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 03:07:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231321AbjHGHHc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 03:07:32 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E0C6510F0;
        Mon,  7 Aug 2023 00:07:26 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id E946A809D;
        Mon,  7 Aug 2023 07:07:25 +0000 (UTC)
Date:   Mon, 7 Aug 2023 10:07:24 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Nishanth Menon <nm@ti.com>
Cc:     Dhruva Gole <d-gole@ti.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-omap@vger.kernel.org, linux-gpio@vger.kernel.org,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH] pinctrl: single: Add compatible for ti,am625-padconf
Message-ID: <20230807070724.GN14799@atomide.com>
References: <20230805045554.786092-1-d-gole@ti.com>
 <20230805171508.schg4xquoa24klk5@october>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230805171508.schg4xquoa24klk5@october>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Nishanth Menon <nm@ti.com> [230805 17:15]:
> On 10:25-20230805, Dhruva Gole wrote:
> > From: Tony Lindgren <tony@atomide.com>
> > +static const struct pcs_soc_data pinctrl_single_am625 = {
> > +	.flags = PCS_QUIRK_SHARED_IRQ | PCS_CONTEXT_LOSS_OFF,
> > +	.irq_enable_mask = (1 << 29),   /* WKUP_EN */
> > +	.irq_status_mask = (1 << 30),   /* WKUP_EVT */
> > +};
> > +
> 
> Why cant we set this in the k3-pinctrl.h and set it once?

Good idea to define the bit offsets k3-pinctrl.h instead of magic numbers
here :)

> The event will not be generated until wakeup daisy chain is triggered
> anyways.

Yup, and having that happen is enough to show the wake-up reason with
grep wakeup /proc/interrupts :)

> Have you looked at all the padconf registers across devices to ensure
> the WKUP_EN/EVT bits are present? daisy chain feature is used elsewhere
> as well.

The lack of bits at least earlier just meant that attempting to use a
wake-up interrupt would just never trigger. Worth checking though.
Dhruva, care to check if some padconf register have reserved bits for
29 and 30 that might be set high by default?

Regards,

Tony
