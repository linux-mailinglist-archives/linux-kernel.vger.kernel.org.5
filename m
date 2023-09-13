Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4855979E208
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 10:26:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238865AbjIMI0b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 04:26:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238838AbjIMI02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 04:26:28 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9900C199D;
        Wed, 13 Sep 2023 01:26:24 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id BDC618088;
        Wed, 13 Sep 2023 08:26:23 +0000 (UTC)
Date:   Wed, 13 Sep 2023 11:26:22 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     Dhruva Gole <d-gole@ti.com>, linux-omap@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Keerthy <j-keerthy@ti.com>, Nishanth Menon <nm@ti.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        vibhore@ti.com
Subject: Re: [PATCH] bus: ti-sysc: Fix SYSC_QUIRK_SWSUP_SIDLE_ACT handling
 for uart wake-up
Message-ID: <20230913082622.GG5285@atomide.com>
References: <20230907055441.19476-1-tony@atomide.com>
 <20230907062231.muwzvje726wlqnqw@dhruva.dhcp.ti.com>
 <7hsf7j582o.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7hsf7j582o.fsf@baylibre.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Kevin Hilman <khilman@baylibre.com> [230912 22:40]:
> Dhruva Gole <d-gole@ti.com> writes:
> 
> > On Sep 07, 2023 at 08:54:41 +0300, Tony Lindgren wrote:
> >> The uarts should be tagged with SYSC_QUIRK_SWSUP_SIDLE instead of
> >> SYSC_QUIRK_SWSUP_SIDLE_ACT. The difference is that SYSC_QUIRK_SWSUP_SIDLE
> >> is used to force idle target modules rather than block idle during usage.
> >> 
> >> The SYSC_QUIRK_SWSUP_SIDLE_ACT should disable autoidle and wake-up when
> >> a target module is active, and configure autoidle and wake-up when a
> >> target module is inactive. We are missing configuring the target module
> >> on sysc_disable_module(), and missing toggling of the wake-up bit.
> >> 
> >> Let's fix the issue to allow uart wake-up to work.
> >> 
> >> Fixes: fb685f1c190e ("bus: ti-sysc: Handle swsup idle mode quirks")
> >> Signed-off-by: Tony Lindgren <tony@atomide.com>
> >> ---
> >>  drivers/bus/ti-sysc.c | 22 +++++++++++++++++-----
> >>  1 file changed, 17 insertions(+), 5 deletions(-)
> >> 
> >> diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
> >> --- a/drivers/bus/ti-sysc.c
> >> +++ b/drivers/bus/ti-sysc.c
> >
> > Thanks for the fix Tony,
> > I have tested this on a TI SK-AM62x with deepsleep and am able to wakeup
> > with keypress on the wake_uart.
> >
> > For anyone else who wants to give this a shot, the required patches for
> > deepsleep and DT related changes have been pushed to my branch on github
> > [0].
> >
> > Hence,
> > Tested-by: Dhruva Gole <d-gole@ti.com>
> >
> > [0] https://github.com/DhruvaG2000/v-linux/commits/v6.5-rc7_wkuart
> 
> Also tested on k3-am625-sk using Dhruval's branch.
> 
> Tested-by: Kevin Hilman <khilman@baylibre.com>

Thanks for testing, applied into fixes.

Tony
