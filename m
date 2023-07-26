Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B768762B25
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 08:11:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231186AbjGZGLH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 02:11:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjGZGLF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 02:11:05 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F165AC0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 23:11:03 -0700 (PDT)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[127.0.0.1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <j.zink@pengutronix.de>)
        id 1qOXjP-00073w-Ss; Wed, 26 Jul 2023 08:10:43 +0200
Message-ID: <09a2d767-d781-eba2-028f-a949f1128fbd@pengutronix.de>
Date:   Wed, 26 Jul 2023 08:10:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2] net: stmmac: correct MAC propagation delay
To:     Richard Cochran <richardcochran@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        patchwork-jzi@pengutronix.de, netdev@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, kernel test robot <lkp@intel.com>
References: <20230719-stmmac_correct_mac_delay-v2-1-3366f38ee9a6@pengutronix.de>
 <20230725200606.5264b59c@kernel.org> <ZMCRjcRF9XqEPg/Z@hoboy.vegasvil.org>
Content-Language: en-US, de-DE
From:   Johannes Zink <j.zink@pengutronix.de>
In-Reply-To: <ZMCRjcRF9XqEPg/Z@hoboy.vegasvil.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: j.zink@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Richard,

On 7/26/23 05:22, Richard Cochran wrote:
> On Tue, Jul 25, 2023 at 08:06:06PM -0700, Jakub Kicinski wrote:
> 
>> any opinion on this one?
> 
> Yeah, I saw it, but I can't get excited about drivers trying to
> correct delays.  I don't think this can be done automatically in a
> reliable way, and so I expect that the few end users who are really
> getting into the microseconds and nanoseconds will calibrate their
> systems end to end, maybe even patching out this driver nonsense in
> their kernels.
> 

Thanks for your reading and commenting on my patch. As the commit message 
elaborates, the Patch corrects for the MAC-internal delays (this is neither PHY 
delays nor cable delays), that arise from the timestamps not being taken at the 
packet egress, but at an internal point in the MAC. The compensation values are 
read from internal registers of the hardware since these values depend on the 
actual operational mode of the MAC and on the MII link. I have done extensive 
testing, and as far as my results are concerned, this is reliable at least on 
the i.MX8MP Hardware I can access for testing. I would actually like correct 
this on other MACs too, but they are often poorly documented. I have to admit 
that the DWMAC is one of the first hardwares I encountered with proper 
documentation. The driver admittedly still has room for improvements - so here 
we go...

Nevertheless, there is still PHY delays to be corrected for, but I need to 
extend the PHY framework for querying the clause 45 registers to account for 
the PHY delays (which are even a larger factor of). I plan to send another 
series fixing this, but this still needs some cleanup being done.

Also on a side-note, "driver nonsense" sounds a bit harsh from someone always 
insisting that one should not compensate for bad drivers in the userspace stack 
and instead fixing driver and hardware issues in the kernel, don't you think?

> Having said that, I won't stand in the way of such driver stuff.
> After all, who cares about a few microseconds time error one way or
> the other?

I do, and so does my customer. If you want to reach sub-microsecond accuracy 
with a linuxptp setup (which is absolutely feasible on COTS hardware), you have 
to take these things into account. I did quite extensive tests, and measuring 
the peer delay as precisely as possible is one of the key steps in getting 
offsets down between physical nodes. As I use the PHCs to recover clocks with 
as low phase offset as possible, the peer delays matter, as they add phase 
error. At the moment, this patch reduces the offset of approx 150ns to <50ns in 
a real world application, which is not so bad for a few lines of code, i guess...

I don't want to kick off a lengthy discussion here (especially since Jakub 
already picked the patch to next), but maybe this mail can help for 
clarification in the future, when the next poor soul does work on the hwtstamps 
in the dwmac.

Thanks, also for keeping linuxptp going,
Johannes

> 
> Thanks,
> Richard
> 
> 

-- 
Pengutronix e.K.                | Johannes Zink                  |
Steuerwalder Str. 21            | https://www.pengutronix.de/    |
31137 Hildesheim, Germany       | Phone: +49-5121-206917-0       |
Amtsgericht Hildesheim, HRA 2686| Fax:   +49-5121-206917-5555    |

