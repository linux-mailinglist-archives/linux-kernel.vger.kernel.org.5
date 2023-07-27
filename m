Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A70247648A1
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 09:32:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233294AbjG0HcL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 03:32:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231883AbjG0Hbq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 03:31:46 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C993F2D60
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 00:20:31 -0700 (PDT)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[127.0.0.1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <j.zink@pengutronix.de>)
        id 1qOvIF-0000DH-VE; Thu, 27 Jul 2023 09:20:16 +0200
Message-ID: <729dd79e-83aa-0237-1edd-1662a6ae28cd@pengutronix.de>
Date:   Thu, 27 Jul 2023 09:20:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2] net: stmmac: correct MAC propagation delay
Content-Language: en-US, de-DE
To:     Richard Cochran <richardcochran@gmail.com>
Cc:     Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        patchwork-jzi@pengutronix.de, netdev@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, kernel test robot <lkp@intel.com>
References: <20230719-stmmac_correct_mac_delay-v2-1-3366f38ee9a6@pengutronix.de>
 <ZMGIuKVP7BEotbrn@hoboy.vegasvil.org>
From:   Johannes Zink <j.zink@pengutronix.de>
In-Reply-To: <ZMGIuKVP7BEotbrn@hoboy.vegasvil.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: j.zink@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Richard,

On 7/26/23 22:57, Richard Cochran wrote:
> On Mon, Jul 24, 2023 at 12:01:31PM +0200, Johannes Zink wrote:
> 
> Earlier versions of the IP core return zero from these...
> 
>> +#define	PTP_TS_INGR_LAT	0x68	/* MAC internal Ingress Latency */
>> +#define	PTP_TS_EGR_LAT	0x6c	/* MAC internal Egress Latency */
> 

good catch. Gonna send a v3 with a check to and set the values for dwmac v5 only.

Best regards
Johannes


> and so...
> 
>> +static void correct_latency(struct stmmac_priv *priv)
>> +{
>> +	void __iomem *ioaddr = priv->ptpaddr;
>> +	u32 reg_tsic, reg_tsicsns;
>> +	u32 reg_tsec, reg_tsecsns;
>> +	u64 scaled_ns;
>> +	u32 val;
>> +
>> +	/* MAC-internal ingress latency */
>> +	scaled_ns = readl(ioaddr + PTP_TS_INGR_LAT);
>> +
>> +	/* See section 11.7.2.5.3.1 "Ingress Correction" on page 4001 of
>> +	 * i.MX8MP Applications Processor Reference Manual Rev. 1, 06/2021
>> +	 */
>> +	val = readl(ioaddr + PTP_TCR);
>> +	if (val & PTP_TCR_TSCTRLSSR)
>> +		/* nanoseconds field is in decimal format with granularity of 1ns/bit */
>> +		scaled_ns = ((u64)NSEC_PER_SEC << 16) - scaled_ns;
>> +	else
>> +		/* nanoseconds field is in binary format with granularity of ~0.466ns/bit */
>> +		scaled_ns = ((1ULL << 31) << 16) -
>> +			DIV_U64_ROUND_CLOSEST(scaled_ns * PSEC_PER_NSEC, 466U);
>> +
>> +	reg_tsic = scaled_ns >> 16;
>> +	reg_tsicsns = scaled_ns & 0xff00;
>> +
>> +	/* set bit 31 for 2's compliment */
>> +	reg_tsic |= BIT(31);
>> +
>> +	writel(reg_tsic, ioaddr + PTP_TS_INGR_CORR_NS);
> 
> here reg_tsic = 0x80000000 for a correction of -2.15 seconds! >
> @Jakub  Can you please revert this patch?
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

