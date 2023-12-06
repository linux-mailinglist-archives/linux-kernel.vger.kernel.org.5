Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8CC4806B4C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 11:08:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377392AbjLFKIG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 05:08:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377385AbjLFKID (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 05:08:03 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C7D8109;
        Wed,  6 Dec 2023 02:08:08 -0800 (PST)
Received: from [192.168.88.20] (91-158-149-209.elisa-laajakaista.fi [91.158.149.209])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 9B964E45;
        Wed,  6 Dec 2023 11:07:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1701857244;
        bh=XYVNV7G4X7YzqJ49hmgXShVAk3zY/kjKTxOWrKENMz4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ejFFmGl7bYIEd00VbGSNJVOBmRnVux/HBu5EK8nX1AhVeMCHObhj6efqrWfNm2p1M
         nES/yTI6Uj951BAPIlUjL95YkOfh4u5iyao+NE+ZU7JqYNvMO75ZX//hXUz27qiMI5
         wIRUMKsR7k+FrBvgbhtKuQW7nBPMzjpEU3mIFaeA=
Message-ID: <c7117713-bc98-459c-a475-2ec838215cd9@ideasonboard.com>
Date:   Wed, 6 Dec 2023 12:08:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] media: rkisp1: Fix IRQ disable race issue
Content-Language: en-US
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Dafna Hirschfeld <dafna@fastmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Paul Elder <paul.elder@ideasonboard.com>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        kieran.bingham@ideasonboard.com, umang.jain@ideasonboard.com,
        aford173@gmail.com, linux-media@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20231205-rkisp-irq-fix-v1-0-f4045c74ba45@ideasonboard.com>
 <20231205-rkisp-irq-fix-v1-4-f4045c74ba45@ideasonboard.com>
 <20231205121355.GE17394@pendragon.ideasonboard.com>
From:   Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Autocrypt: addr=tomi.valkeinen@ideasonboard.com; keydata=
 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
In-Reply-To: <20231205121355.GE17394@pendragon.ideasonboard.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/12/2023 14:13, Laurent Pinchart wrote:
> Hi Tomi,
> 
> Thank you for the patch.
> 
> On Tue, Dec 05, 2023 at 10:09:35AM +0200, Tomi Valkeinen wrote:
>> In rkisp1_isp_stop() and rkisp1_csi_disable() the driver masks the
>> interrupts and then apparently assumes that the interrupt handler won't
>> be running, and proceeds in the stop procedure. This is not the case, as
>> the interrupt handler can already be running, which would lead to the
>> ISP being disabled while the interrupt handler handling a captured
>> frame.
>>
>> It is not clear to me if this problem causes a real issue, but shutting
>> down the ISP while an interrupt handler is running sounds rather bad.
> 
> Agreed.
> 
>> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
>> ---
>>   drivers/media/platform/rockchip/rkisp1/rkisp1-csi.c | 14 +++++++++++++-
>>   drivers/media/platform/rockchip/rkisp1/rkisp1-isp.c | 20 +++++++++++++++++---
>>   2 files changed, 30 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/media/platform/rockchip/rkisp1/rkisp1-csi.c b/drivers/media/platform/rockchip/rkisp1/rkisp1-csi.c
>> index f6b54654b435..f0cef766fc0c 100644
>> --- a/drivers/media/platform/rockchip/rkisp1/rkisp1-csi.c
>> +++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-csi.c
>> @@ -125,8 +125,20 @@ static void rkisp1_csi_disable(struct rkisp1_csi *csi)
>>   	struct rkisp1_device *rkisp1 = csi->rkisp1;
>>   	u32 val;
>>   
>> -	/* Mask and clear interrupts. */
>> +	/* Mask MIPI interrupts. */
>>   	rkisp1_write(rkisp1, RKISP1_CIF_MIPI_IMSC, 0);
>> +
>> +	/* Flush posted writes */
>> +	rkisp1_read(rkisp1, RKISP1_CIF_MIPI_IMSC);
>> +
>> +	/*
>> +	 * Wait until the IRQ handler has ended. The IRQ handler may get called
>> +	 * even after this, but it will return immediately as the MIPI
>> +	 * interrupts have been masked.
>> +	 */
> 
> This comment will need to be updated if patch 3/4 gets replaced by a
> patch that drops IRQF_SHARED.

I don't think it needs an update, as the irq handling is divided into 
multiple parts. The handler here may get called due to a MI or ISP 
interrupt, and vice versa.

  Tomi

> 
>> +	synchronize_irq(rkisp1->irqs[RKISP1_IRQ_MIPI]);
>> +
>> +	/* Clear MIPI interrupt status */
>>   	rkisp1_write(rkisp1, RKISP1_CIF_MIPI_ICR, ~0);
>>   
>>   	val = rkisp1_read(rkisp1, RKISP1_CIF_MIPI_CTRL);
>> diff --git a/drivers/media/platform/rockchip/rkisp1/rkisp1-isp.c b/drivers/media/platform/rockchip/rkisp1/rkisp1-isp.c
>> index d6b8786661ad..a6dd497c884c 100644
>> --- a/drivers/media/platform/rockchip/rkisp1/rkisp1-isp.c
>> +++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-isp.c
>> @@ -364,11 +364,25 @@ static void rkisp1_isp_stop(struct rkisp1_isp *isp)
>>   	 * ISP(mi) stop in mi frame end -> Stop ISP(mipi) ->
>>   	 * Stop ISP(isp) ->wait for ISP isp off
>>   	 */
>> -	/* stop and clear MI and ISP interrupts */
>> -	rkisp1_write(rkisp1, RKISP1_CIF_ISP_IMSC, 0);
>> -	rkisp1_write(rkisp1, RKISP1_CIF_ISP_ICR, ~0);
>>   
>> +	/* Mask MI and ISP interrupts */
>> +	rkisp1_write(rkisp1, RKISP1_CIF_ISP_IMSC, 0);
>>   	rkisp1_write(rkisp1, RKISP1_CIF_MI_IMSC, 0);
>> +
>> +	/* Flush posted writes */
>> +	rkisp1_read(rkisp1, RKISP1_CIF_MI_IMSC);
>> +
>> +	/*
>> +	 * Wait until the IRQ handler has ended. The IRQ handler may get called
>> +	 * even after this, but it will return immediately as the MI and ISP
>> +	 * interrupts have been masked.
>> +	 */
> 
> Same here.
> 
>> +	synchronize_irq(rkisp1->irqs[RKISP1_IRQ_ISP]);
>> +	if (rkisp1->irqs[RKISP1_IRQ_ISP] != rkisp1->irqs[RKISP1_IRQ_MI])
>> +		synchronize_irq(rkisp1->irqs[RKISP1_IRQ_MI]);
> 
> It would be nice if we could avoid the double synchronize_irq() for
> platforms where RKISP1_IRQ_MIPI and RKISP1_IRQ_ISP are identical, but I
> understand that would be difficult.
> 
>> +
>> +	/* Clear MI and ISP interrupt status */
>> +	rkisp1_write(rkisp1, RKISP1_CIF_ISP_ICR, ~0);
>>   	rkisp1_write(rkisp1, RKISP1_CIF_MI_ICR, ~0);
>>   
>>   	/* stop ISP */
> 

