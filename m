Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E41037CD3B3
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 07:55:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbjJRFzg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 01:55:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbjJRFzf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 01:55:35 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E26D9C4
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 22:55:28 -0700 (PDT)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[127.0.0.1])
        by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <j.zink@pengutronix.de>)
        id 1qszWg-0007hK-2U; Wed, 18 Oct 2023 07:55:26 +0200
Message-ID: <24f14f0f-2a1b-401d-b5f8-314387d0aaef@pengutronix.de>
Date:   Wed, 18 Oct 2023 07:55:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/5] net: stmmac: fix PPS capture input index
Content-Language: en-US, de-DE
To:     Jakub Kicinski <kuba@kernel.org>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     kernel@pengutronix.de, linux-kernel@vger.kernel.org,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        netdev@vger.kernel.org, Richard Cochran <richardcochran@gmail.com>,
        Kurt Kanzenbach <kurt@linutronix.de>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        Eric Dumazet <edumazet@google.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Simon Horman <horms@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-arm-kernel@lists.infradead.org, patchwork-jzi@pengutronix.de
References: <20231010-stmmac_fix_auxiliary_event_capture-v1-0-3eeca9e844fa@pengutronix.de>
 <20231010-stmmac_fix_auxiliary_event_capture-v1-2-3eeca9e844fa@pengutronix.de>
 <20231014144428.GA1386676@kernel.org>
 <004d6ce9-7d15-4944-b31c-c9e628e7483a@pengutronix.de>
 <20231017082618.4558ad06@kernel.org>
 <20231017-transfer-refurbish-5cfaf12a524c-mkl@pengutronix.de>
 <20231017165042.30fa9061@kernel.org>
From:   Johannes Zink <j.zink@pengutronix.de>
In-Reply-To: <20231017165042.30fa9061@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: j.zink@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jakub, hi Marc,

On 10/18/23 01:50, Jakub Kicinski wrote:
> On Tue, 17 Oct 2023 22:27:41 +0200 Marc Kleine-Budde wrote:
>>> Would be good to clarify what impact on device operation the problem
>>> has. How would end user notice the problem?
>>> Does it mean snapshots were always or never enabled, previously?
>>
>> On all dwmac devices not covered by dwmac-intel.c (INTEL 10/100/1000
>> Ethernet PCI driver), PPS capture can be requested from user-space, but
>> is not enabled in HW. There is no error message or other feedback to the
>> user space. The user space will not get any PPS events.
>>
>> As this change also affects the Intel driver, and we don't have any
>> hardware to test, I think it's better that this goes via net-next to
>> give it a bit more time of testing.

I have also CC'ed Kurt in this series, as I know he has at least some hardware 
at hand, though I cannot tell whether he has any chance to test the PPS 
capture. Maybe he has a possibility to try it out. However, giving it a spin in 
net-next SGTM.

> 
> SGTM, we can chalk it up to "never worked, doesn't hurt anyone"
> and put it in net-next. But then the Fixes tag must go.
> 

sure, that's fine for me. I will reword the commit messages and send a v2.

Best regards,
Johannes

-- 
Pengutronix e.K.                | Johannes Zink                  |
Steuerwalder Str. 21            | https://www.pengutronix.de/    |
31137 Hildesheim, Germany       | Phone: +49-5121-206917-0       |
Amtsgericht Hildesheim, HRA 2686| Fax:   +49-5121-206917-5555    |

