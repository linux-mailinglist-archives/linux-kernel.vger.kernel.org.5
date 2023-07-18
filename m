Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1441775784E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 11:43:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231298AbjGRJnU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 05:43:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230260AbjGRJnQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 05:43:16 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E8F5E0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 02:43:15 -0700 (PDT)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[127.0.0.1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <bst@pengutronix.de>)
        id 1qLhEa-0003t9-Bj; Tue, 18 Jul 2023 11:43:08 +0200
Message-ID: <f673a09e-e212-ee7b-15c3-78afe8c70916@pengutronix.de>
Date:   Tue, 18 Jul 2023 11:43:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] crypto: caam - adjust RNG timing to support more devices
Content-Language: en-US
From:   Bastian Krause <bst@pengutronix.de>
To:     meenakshi.aggarwal@nxp.com, horia.geanta@nxp.com, V.sethi@nxp.com,
        pankaj.gupta@nxp.com, gaurav.jain@nxp.com,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Victoria Milhoan <vicki.milhoan@freescale.com>,
        Dan Douglass <dan.douglass@nxp.com>,
        Vipul Kumar <vipul_kumar@mentor.com>, kernel@pengutronix.de
References: <20230612082615.1255357-1-meenakshi.aggarwal@nxp.com>
 <e1f3f073-9d5e-1bae-f4f8-08dc48adad62@pengutronix.de>
In-Reply-To: <e1f3f073-9d5e-1bae-f4f8-08dc48adad62@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: bst@pengutronix.de
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

On 7/17/23 14:43, Bastian Krause wrote:
> On 6/12/23 10:26, meenakshi.aggarwal@nxp.com wrote:
>> From: Victoria Milhoan <vicki.milhoan@freescale.com>
>>
>> Adjust RNG timing parameters to support more i.MX6 devices.
>>
>> Signed-off-by: Victoria Milhoan <vicki.milhoan@freescale.com>
>> Signed-off-by: Dan Douglass <dan.douglass@nxp.com>
>> Signed-off-by: Vipul Kumar <vipul_kumar@mentor.com>
>> Signed-off-by: Horia Geantă <horia.geanta@nxp.com>
>> ---
>>   drivers/crypto/caam/ctrl.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> This patch seems to breaks CAAM RNG instantiation on an i.MX8MM at my end:
> 
> caam 30900000.crypto: Entropy delay = 3200
> caam 30900000.crypto: Entropy delay = 3600
> [...]
> caam 30900000.crypto: Entropy delay = 12400
> caam 30900000.crypto: failed to instantiate RNG
> caam: probe of 30900000.crypto failed with error -11
> 
> If I revert this patch or increase RTSDCTL_ENT_DLY_MAX to a value > 
> 66800, it works again:
> 
> caam 30900000.crypto: Entropy delay = 32800
> caam 30900000.crypto: Entropy delay = 33200
> [...]
> caam 30900000.crypto: Entropy delay = 66800
> caam 30900000.crypto: Instantiated RNG4 SH0
> caam 30900000.crypto: Instantiated RNG4 SH1
> caam 30900000.crypto: device ID = 0x0a16040100000000 (Era 9)
> caam 30900000.crypto: job rings = 2, qi = 0
> caam algorithms registered in /proc/crypto
> caam 30900000.crypto: caam pkc algorithms registered in /proc/crypto
> caam 30900000.crypto: registering rng-caam
> Executing RNG SELF-TEST with wait
> random: crng init done
> caam 30900000.crypto: rng crypto API alg registered prng-caam

This ^ was the kernel log for..


--- a/drivers/crypto/caam/regs.h
+++ b/drivers/crypto/caam/regs.h
@@@ -522,7 -522,7 +522,7 @@@ struct rng4tst
   #define RTSDCTL_ENT_DLY_SHIFT 16
   #define RTSDCTL_ENT_DLY_MASK (0xffff << RTSDCTL_ENT_DLY_SHIFT)
   #define RTSDCTL_ENT_DLY_MIN 3200
--#define RTSDCTL_ENT_DLY_MAX 12800
++#define RTSDCTL_ENT_DLY_MAX 70000
   #define RTSDCTL_SAMP_SIZE_MASK 0xffff
   #define RTSDCTL_SAMP_SIZE_VAL 512
         u32 rtsdctl;            /* seed control register */


For completion's sake: Reverting this patch..


--- a/drivers/crypto/caam/ctrl.c
+++ b/drivers/crypto/caam/ctrl.c
@@ -383,7 +383,7 @@ static void kick_trng(struct device *dev, int ent_delay)
                 /* min. freq. count, equal to 1/4 of the entropy sample length */
                 wr_reg32(&r4tst->rtfrqmin, val >> 2);
                 /* max. freq. count, equal to 16 times the entropy sample length */
-               wr_reg32(&r4tst->rtfrqmax, val << 4);
+               wr_reg32(&r4tst->rtfrqmax, RTFRQMAX_DISABLE);
         }
  
         wr_reg32(&r4tst->rtsdctl, (val << RTSDCTL_ENT_DLY_SHIFT) |


..produces this kernel log (without RNG SELF-TEST):

caam 30900000.crypto: Entropy delay = 3200
caam 30900000.crypto: Entropy delay = 3600
caam 30900000.crypto: Instantiated RNG4 SH0
caam 30900000.crypto: Instantiated RNG4 SH1
caam 30900000.crypto: device ID = 0x0a16040100000000 (Era 9)
caam 30900000.crypto: job rings = 2, qi = 0
caam algorithms registered in /proc/crypto
caam 30900000.crypto: caam pkc algorithms registered in /proc/crypto
caam 30900000.crypto: registering rng-caam
caam 30900000.crypto: rng crypto API alg registered prng-caam
random: crng init done

Regards,
Bastian

>>
>> diff --git a/drivers/crypto/caam/ctrl.c b/drivers/crypto/caam/ctrl.c
>> index 5fed3cf354c0..62dd069942e4 100644
>> --- a/drivers/crypto/caam/ctrl.c
>> +++ b/drivers/crypto/caam/ctrl.c
>> @@ -383,8 +383,8 @@ static void kick_trng(struct device *dev, int 
>> ent_delay)
>>       wr_reg32(&r4tst->rtsdctl, val);
>>       /* min. freq. count, equal to 1/4 of the entropy sample length */
>>       wr_reg32(&r4tst->rtfrqmin, ent_delay >> 2);
>> -    /* disable maximum frequency count */
>> -    wr_reg32(&r4tst->rtfrqmax, RTFRQMAX_DISABLE);
>> +    /* max. freq. count, equal to 16 times the entropy sample length */
>> +    wr_reg32(&r4tst->rtfrqmax, ent_delay << 4);
>>       /* read the control register */
>>       val = rd_reg32(&r4tst->rtmctl);
>>   start_rng:
> 

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

