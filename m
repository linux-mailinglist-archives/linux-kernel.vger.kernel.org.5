Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 662DA764707
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 08:40:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232784AbjG0GkM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 02:40:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232768AbjG0Gjy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 02:39:54 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 543732D73
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 23:39:48 -0700 (PDT)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[127.0.0.1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <j.zink@pengutronix.de>)
        id 1qOuf3-0001oC-9Q; Thu, 27 Jul 2023 08:39:45 +0200
Message-ID: <8742d597-e8b1-705f-6616-dca4ead529f4@pengutronix.de>
Date:   Thu, 27 Jul 2023 08:39:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2] net: stmmac: correct MAC propagation delay
Content-Language: en-US, de-DE
To:     Richard Cochran <richardcochran@gmail.com>
Cc:     linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Russell King <linux@armlinux.org.uk>,
        kernel test robot <lkp@intel.com>,
        Eric Dumazet <edumazet@google.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-arm-kernel@lists.infradead.org, patchwork-jzi@pengutronix.de
References: <20230719-stmmac_correct_mac_delay-v2-1-3366f38ee9a6@pengutronix.de>
 <20230725200606.5264b59c@kernel.org> <ZMCRjcRF9XqEPg/Z@hoboy.vegasvil.org>
 <09a2d767-d781-eba2-028f-a949f1128fbd@pengutronix.de>
 <ZME/GjBWdodiUO+8@hoboy.vegasvil.org>
From:   Johannes Zink <j.zink@pengutronix.de>
In-Reply-To: <ZME/GjBWdodiUO+8@hoboy.vegasvil.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: j.zink@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Richard,

On 7/26/23 17:43, Richard Cochran wrote:
> On Wed, Jul 26, 2023 at 08:10:35AM +0200, Johannes Zink wrote:
> 
>> Also on a side-note, "driver nonsense" sounds a bit harsh from someone
>> always insisting that one should not compensate for bad drivers in the
>> userspace stack and instead fixing driver and hardware issues in the kernel,
>> don't you think?
> 
> Everything has its place.
> 
> The proper place to account for delay asymmetries is in the user space
> configuration, for example in linuxptp you have
This is not about Delay Asymmetry, but about Additional Errors in Path Delay, 
namely MAC Ingress and Egress Delay.

> 
>         delayAsymmetry
>                The  time  difference in nanoseconds of the transmit and receive
>                paths. This value should be positive when  the  server-to-client
>                propagation  time  is  longer  and  negative when the client-to-
>                server time is longer. The default is 0 nanoseconds.
> 
>         egressLatency
>                Specifies the  difference  in  nanoseconds  between  the  actual
>                transmission time at the reference plane and the reported trans‐
>                mit time stamp. This value will be added to egress  time  stamps
>                obtained from the hardware.  The default is 0.
> >         ingressLatency
>                Specifies the difference in nanoseconds between the reported re‐
>                ceive  time  stamp  and  the  actual reception time at reference
>                plane. This value will be subtracted from  ingress  time  stamps
>                obtained from the hardware.  The default is 0.
For the PTP stack you could probably configure these in the stack, but fixing 
the delay in the driver also has the advantage of reducing phase offset error 
when doing clock revovery from the PHC.

> 
> Trying to hard code those into the driver?  Good luck getting that
> right for everyone.
That's why we don't hardcode the values but read them from the registers 
provided by the IP core.

> 
> BTW this driver is actually for an IP core used in many, many SoCs.
> 
> How many _other_ SoCs did you test your patch on?
> 
I don't have many available, thus as stated in the description: on the i.MX8MP 
only. That's why I am implementing my stuff in the imx glue code, you're 
welcome to help testing on other hardware if you have any at hand.

Best regards
Johannes

> Thanks,
> Richard
> 
> 
> 


-- 
Pengutronix e.K.                | Johannes Zink                  |
Steuerwalder Str. 21            | https://www.pengutronix.de/    |
31137 Hildesheim, Germany       | Phone: +49-5121-206917-0       |
Amtsgericht Hildesheim, HRA 2686| Fax:   +49-5121-206917-5555    |

