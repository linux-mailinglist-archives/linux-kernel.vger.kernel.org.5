Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0BA57562FC
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 14:44:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbjGQMoA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 08:44:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230322AbjGQMnu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 08:43:50 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66AEE116
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 05:43:49 -0700 (PDT)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[127.0.0.1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <bst@pengutronix.de>)
        id 1qLNZm-0003ul-21; Mon, 17 Jul 2023 14:43:42 +0200
Message-ID: <e1f3f073-9d5e-1bae-f4f8-08dc48adad62@pengutronix.de>
Date:   Mon, 17 Jul 2023 14:43:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] crypto: caam - adjust RNG timing to support more devices
Content-Language: en-US
To:     meenakshi.aggarwal@nxp.com, horia.geanta@nxp.com, V.sethi@nxp.com,
        pankaj.gupta@nxp.com, gaurav.jain@nxp.com,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Victoria Milhoan <vicki.milhoan@freescale.com>,
        Dan Douglass <dan.douglass@nxp.com>,
        Vipul Kumar <vipul_kumar@mentor.com>, kernel@pengutronix.de
References: <20230612082615.1255357-1-meenakshi.aggarwal@nxp.com>
From:   Bastian Krause <bst@pengutronix.de>
In-Reply-To: <20230612082615.1255357-1-meenakshi.aggarwal@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: bst@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/12/23 10:26, meenakshi.aggarwal@nxp.com wrote:
> From: Victoria Milhoan <vicki.milhoan@freescale.com>
> 
> Adjust RNG timing parameters to support more i.MX6 devices.
> 
> Signed-off-by: Victoria Milhoan <vicki.milhoan@freescale.com>
> Signed-off-by: Dan Douglass <dan.douglass@nxp.com>
> Signed-off-by: Vipul Kumar <vipul_kumar@mentor.com>
> Signed-off-by: Horia Geantă <horia.geanta@nxp.com>
> ---
>   drivers/crypto/caam/ctrl.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

This patch seems to breaks CAAM RNG instantiation on an i.MX8MM at my end:

caam 30900000.crypto: Entropy delay = 3200
caam 30900000.crypto: Entropy delay = 3600
[...]
caam 30900000.crypto: Entropy delay = 12400
caam 30900000.crypto: failed to instantiate RNG
caam: probe of 30900000.crypto failed with error -11

If I revert this patch or increase RTSDCTL_ENT_DLY_MAX to a value > 
66800, it works again:

caam 30900000.crypto: Entropy delay = 32800
caam 30900000.crypto: Entropy delay = 33200
[...]
caam 30900000.crypto: Entropy delay = 66800
caam 30900000.crypto: Instantiated RNG4 SH0
caam 30900000.crypto: Instantiated RNG4 SH1
caam 30900000.crypto: device ID = 0x0a16040100000000 (Era 9)
caam 30900000.crypto: job rings = 2, qi = 0
caam algorithms registered in /proc/crypto
caam 30900000.crypto: caam pkc algorithms registered in /proc/crypto
caam 30900000.crypto: registering rng-caam
Executing RNG SELF-TEST with wait
random: crng init done
caam 30900000.crypto: rng crypto API alg registered prng-caam

Regards,
Bastian

> 
> diff --git a/drivers/crypto/caam/ctrl.c b/drivers/crypto/caam/ctrl.c
> index 5fed3cf354c0..62dd069942e4 100644
> --- a/drivers/crypto/caam/ctrl.c
> +++ b/drivers/crypto/caam/ctrl.c
> @@ -383,8 +383,8 @@ static void kick_trng(struct device *dev, int ent_delay)
>   	wr_reg32(&r4tst->rtsdctl, val);
>   	/* min. freq. count, equal to 1/4 of the entropy sample length */
>   	wr_reg32(&r4tst->rtfrqmin, ent_delay >> 2);
> -	/* disable maximum frequency count */
> -	wr_reg32(&r4tst->rtfrqmax, RTFRQMAX_DISABLE);
> +	/* max. freq. count, equal to 16 times the entropy sample length */
> +	wr_reg32(&r4tst->rtfrqmax, ent_delay << 4);
>   	/* read the control register */
>   	val = rd_reg32(&r4tst->rtmctl);
>   start_rng:

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

