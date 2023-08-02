Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE31D76CA9C
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 12:17:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232818AbjHBKRK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 06:17:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231358AbjHBKRI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 06:17:08 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1D94132
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 03:17:06 -0700 (PDT)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[127.0.0.1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <j.zink@pengutronix.de>)
        id 1qR8uA-0002t7-I3; Wed, 02 Aug 2023 12:16:34 +0200
Message-ID: <9954c171-cb2d-83a4-6965-f5cb3a4a6166@pengutronix.de>
Date:   Wed, 2 Aug 2023 12:16:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Subject: Re: [PATCH v3 0/2] net: stmmac: correct MAC propagation delay
Content-Language: en-US, de-DE
To:     Kurt Kanzenbach <kurt@linutronix.de>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Russell King <linux@armlinux.org.uk>
Cc:     patchwork-jzi@pengutronix.de, netdev@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, kernel test robot <lkp@intel.com>
References: <20230719-stmmac_correct_mac_delay-v3-0-61e63427735e@pengutronix.de>
 <87fs51kb4k.fsf@kurt>
From:   Johannes Zink <j.zink@pengutronix.de>
In-Reply-To: <87fs51kb4k.fsf@kurt>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: j.zink@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kurt,

On 8/2/23 12:10, Kurt Kanzenbach wrote:
> On Tue Aug 01 2023, Johannes Zink wrote:
>> ---
>> Changes in v3:
>> - work in Richard's review feedback. Thank you for reviewing my patch:
>>    - as some of the hardware may have no or invalid correction value
>>      registers: introduce feature switch which can be enabled in the glue
>>      code drivers depending on the actual hardware support
>>    - only enable the feature on the i.MX8MP for the time being, as the patch
>>      improves timing accuracy and is tested for this hardware
>> - Link to v2: https://lore.kernel.org/r/20230719-stmmac_correct_mac_delay-v2-1-3366f38ee9a6@pengutronix.de
>>
>> Changes in v2:
>> - fix builds for 32bit, this was found by the kernel build bot
>> 	Reported-by: kernel test robot <lkp@intel.com>
>> 	Closes: https://lore.kernel.org/oe-kbuild-all/202307200225.B8rmKQPN-lkp@intel.com/
>> - while at it also fix an overflow by shifting a u32 constant from macro by 10bits
>>    by casting the constant to u64
>> - Link to v1: https://lore.kernel.org/r/20230719-stmmac_correct_mac_delay-v1-1-768aa4d09334@pengutronix.de
>>
>> ---
>> Johannes Zink (2):
>>        net: stmmac: correct MAC propagation delay
>>        net: stmmac: dwmac-imx: enable MAC propagation delay correction for i.MX8MP
> 
> Tested on imx8mp <-> TSN Switch <-> x86 with i225:
> 
> Before your patch:
> 
> |ptp4l -i eth0 -f configs/gPTP.cfg --summary_interval=5 -m
> |ptp4l[139.274]: rms    9 max   27 freq +29264 +/-  13 delay   347 +/-   2
> |ptp4l[171.279]: rms   10 max   24 freq +29257 +/-  13 delay   344 +/-   2
> |ptp4l[203.283]: rms   10 max   24 freq +29254 +/-  13 delay   347 +/-   2
> |ptp4l[235.288]: rms    9 max   24 freq +29255 +/-  13 delay   346 +/-   1
> |ptp4l[267.292]: rms    9 max   28 freq +29257 +/-  13 delay   347 +/-   2
> 
> After:
> 
> |ptp4l -i eth0 -f configs/gPTP.cfg --summary_interval=5 -m
> |ptp4l[214.186]: rms    9 max   29 freq +28868 +/-  16 delay   326 +/-   2
> |ptp4l[246.190]: rms    8 max   22 freq +28902 +/-  15 delay   329 +/-   2
> |ptp4l[278.194]: rms    9 max   24 freq +28930 +/-  15 delay   325 +/-   1
> |ptp4l[310.199]: rms    9 max   25 freq +28956 +/-  15 delay   327 +/-   3
> |ptp4l[342.203]: rms    9 max   27 freq +28977 +/-  14 delay   327 +/-   1
> 
> And the derived register values:
> 
> |[   15.864016] KURT: PTP_TS_INGR_CORR_NS: 3147483248 PTP_TS_INGR_CORR_SNS: 0
> |[   15.870862] KURT: PTP_TS_EGR_CORR_NS: 400 PTP_TS_EGR_CORR_SNS: 0
> |[   20.000962] KURT: PTP_TS_INGR_CORR_NS: 3147483636 PTP_TS_INGR_CORR_SNS: 0
> |[   20.007809] KURT: PTP_TS_EGR_CORR_NS: 12 PTP_TS_EGR_CORR_SNS: 0
> 
> So, seems to work:
> 
> Tested-by: Kurt Kanzenbach <kurt@linutronix.de> # imx8mp

Thank you for testing!
Johannes

> 
> Thanks,
> Kurt

-- 
Pengutronix e.K.                | Johannes Zink                  |
Steuerwalder Str. 21            | https://www.pengutronix.de/    |
31137 Hildesheim, Germany       | Phone: +49-5121-206917-0       |
Amtsgericht Hildesheim, HRA 2686| Fax:   +49-5121-206917-5555    |

