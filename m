Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04B41804C47
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 09:27:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344719AbjLEI1g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 03:27:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbjLEI1e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 03:27:34 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C52A4FA;
        Tue,  5 Dec 2023 00:27:40 -0800 (PST)
Received: from [192.168.88.20] (91-158-149-209.elisa-laajakaista.fi [91.158.149.209])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 4ABA64DB;
        Tue,  5 Dec 2023 09:26:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1701764819;
        bh=2bWSQJ91KzxSVZZxT/S36qXml+6Tqw1sYUSNGxv6iGw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=GLdhIJbFPt4zgN4FTYoadYmU7ouvQUXJvq3ThTc4rY3HAmTmAfAUp9LRkTUWgm2if
         0vQpGOTGw34wB/8TU7u2xlV8G8MOgSdKgJB5uN9pZuSKnlrHjjuwB3yUbFWn1/5IkF
         D3dsnS/fpJgAQADa8dAJ1+D1wo2LfqLzv8hBw0Nw=
Message-ID: <9b28dcf7-c9a0-4d68-9197-cdcdd9f0393b@ideasonboard.com>
Date:   Tue, 5 Dec 2023 10:27:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] media: rkisp1: Fix IRQ handling due to shared
 interrupts
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
 <20231205-rkisp-irq-fix-v1-3-f4045c74ba45@ideasonboard.com>
 <20231205082016.GA17394@pendragon.ideasonboard.com>
From:   Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Autocrypt: addr=tomi.valkeinen@ideasonboard.com; keydata=
 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
In-Reply-To: <20231205082016.GA17394@pendragon.ideasonboard.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/12/2023 10:20, Laurent Pinchart wrote:
> Hi Tomi,
> 
> Thank you for the patch.
> 
> On Tue, Dec 05, 2023 at 10:09:34AM +0200, Tomi Valkeinen wrote:
>> The driver requests the interrupts as IRQF_SHARED, so the interrupt
>> handlers can be called at any time. If such a call happens while the ISP
>> is powered down, the SoC will hang as the driver tries to access the
>> ISP registers.
> 
> Is IRQF_SHARED actually needed ?

I don't have any answer to that, but it seems to have always been there. 
Dropping it would simplify the code, but we can only do that if we are 
sure all the platforms the ISP is used on or will be used on won't share 
the interrupt.

  Tomi

>> Fix this by adding a new field, 'irqs_enabled', which is used to bail
>> out from the interrupt handler when the ISP is not operational.
>>
>> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
>> ---
>>   .../media/platform/rockchip/rkisp1/rkisp1-capture.c |  3 +++
>>   .../media/platform/rockchip/rkisp1/rkisp1-common.h  |  2 ++
>>   drivers/media/platform/rockchip/rkisp1/rkisp1-csi.c |  3 +++
>>   drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c | 21 +++++++++++++++++++++
>>   drivers/media/platform/rockchip/rkisp1/rkisp1-isp.c |  3 +++
>>   5 files changed, 32 insertions(+)
>>
>> diff --git a/drivers/media/platform/rockchip/rkisp1/rkisp1-capture.c b/drivers/media/platform/rockchip/rkisp1/rkisp1-capture.c
>> index b50b044d22af..e92067897f28 100644
>> --- a/drivers/media/platform/rockchip/rkisp1/rkisp1-capture.c
>> +++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-capture.c
>> @@ -779,6 +779,9 @@ irqreturn_t rkisp1_capture_isr(int irq, void *ctx)
>>   	unsigned int i;
>>   	u32 status;
>>   
>> +	if (!rkisp1->irqs_enabled)
>> +		return IRQ_NONE;
>> +
>>   	status = rkisp1_read(rkisp1, RKISP1_CIF_MI_MIS);
>>   	if (!status)
>>   		return IRQ_NONE;
>> diff --git a/drivers/media/platform/rockchip/rkisp1/rkisp1-common.h b/drivers/media/platform/rockchip/rkisp1/rkisp1-common.h
>> index ec28907d978e..7f97fdf6e24c 100644
>> --- a/drivers/media/platform/rockchip/rkisp1/rkisp1-common.h
>> +++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-common.h
>> @@ -465,6 +465,7 @@ struct rkisp1_debug {
>>    * @debug:	   debug params to be exposed on debugfs
>>    * @info:	   version-specific ISP information
>>    * @irqs:          IRQ line numbers
>> + * @irqs_enabled:  the hardware is enabled and can cause interrupts
>>    */
>>   struct rkisp1_device {
>>   	void __iomem *base_addr;
>> @@ -488,6 +489,7 @@ struct rkisp1_device {
>>   	struct rkisp1_debug debug;
>>   	const struct rkisp1_info *info;
>>   	int irqs[RKISP1_NUM_IRQS];
>> +	bool irqs_enabled;
>>   };
>>   
>>   /*
>> diff --git a/drivers/media/platform/rockchip/rkisp1/rkisp1-csi.c b/drivers/media/platform/rockchip/rkisp1/rkisp1-csi.c
>> index 47f4353a1784..f6b54654b435 100644
>> --- a/drivers/media/platform/rockchip/rkisp1/rkisp1-csi.c
>> +++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-csi.c
>> @@ -184,6 +184,9 @@ irqreturn_t rkisp1_csi_isr(int irq, void *ctx)
>>   	struct rkisp1_device *rkisp1 = dev_get_drvdata(dev);
>>   	u32 val, status;
>>   
>> +	if (!rkisp1->irqs_enabled)
>> +		return IRQ_NONE;
>> +
>>   	status = rkisp1_read(rkisp1, RKISP1_CIF_MIPI_MIS);
>>   	if (!status)
>>   		return IRQ_NONE;
>> diff --git a/drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c b/drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c
>> index 1d60f4b8bd09..fbe03f7864e3 100644
>> --- a/drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c
>> +++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c
>> @@ -306,6 +306,23 @@ static int __maybe_unused rkisp1_runtime_suspend(struct device *dev)
>>   {
>>   	struct rkisp1_device *rkisp1 = dev_get_drvdata(dev);
>>   
>> +	rkisp1->irqs_enabled = false;
>> +	/* Make sure the IRQ handler will see the above */
>> +	mb();
>> +
>> +	/*
>> +	 * Wait until any running IRQ handler has returned. The IRQ handler
>> +	 * may get called even after this (as it's a shared interrupt line)
>> +	 * but the 'irqs_enabled' flag will make the handler return immediately.
>> +	 */
>> +	for (unsigned int i = 0; i < RKISP1_NUM_IRQS; ++i) {
>> +		if (rkisp1->irqs[i] == -1)
>> +			continue;
>> +
>> +		if (i == 0 || rkisp1->irqs[i - 1] != rkisp1->irqs[i])
>> +			synchronize_irq(rkisp1->irqs[i]);
>> +	}
>> +
>>   	clk_bulk_disable_unprepare(rkisp1->clk_size, rkisp1->clks);
>>   	return pinctrl_pm_select_sleep_state(dev);
>>   }
>> @@ -322,6 +339,10 @@ static int __maybe_unused rkisp1_runtime_resume(struct device *dev)
>>   	if (ret)
>>   		return ret;
>>   
>> +	rkisp1->irqs_enabled = true;
>> +	/* Make sure the IRQ handler will see the above */
>> +	mb();
>> +
>>   	return 0;
>>   }
>>   
>> diff --git a/drivers/media/platform/rockchip/rkisp1/rkisp1-isp.c b/drivers/media/platform/rockchip/rkisp1/rkisp1-isp.c
>> index dafbfd230542..d6b8786661ad 100644
>> --- a/drivers/media/platform/rockchip/rkisp1/rkisp1-isp.c
>> +++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-isp.c
>> @@ -1082,6 +1082,9 @@ irqreturn_t rkisp1_isp_isr(int irq, void *ctx)
>>   	struct rkisp1_device *rkisp1 = dev_get_drvdata(dev);
>>   	u32 status, isp_err;
>>   
>> +	if (!rkisp1->irqs_enabled)
>> +		return IRQ_NONE;
>> +
>>   	status = rkisp1_read(rkisp1, RKISP1_CIF_ISP_MIS);
>>   	if (!status)
>>   		return IRQ_NONE;
> 

