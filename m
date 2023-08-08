Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7EF177354D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 02:00:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230149AbjHHAAY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 20:00:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjHHAAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 20:00:22 -0400
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AD04EDE;
        Mon,  7 Aug 2023 17:00:20 -0700 (PDT)
Received: from unknown (HELO iyokan2-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 08 Aug 2023 09:00:20 +0900
Received: from mail.mfilter.local (mail-arc01.css.socionext.com [10.213.46.36])
        by iyokan2-ex.css.socionext.com (Postfix) with ESMTP id EA17F2058453;
        Tue,  8 Aug 2023 09:00:19 +0900 (JST)
Received: from kinkan2.css.socionext.com ([172.31.9.51]) by m-FILTER with ESMTP; Tue, 8 Aug 2023 09:00:19 +0900
Received: from [10.212.159.175] (unknown [10.212.159.175])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id 436EA1CF7;
        Tue,  8 Aug 2023 09:00:19 +0900 (JST)
Message-ID: <213763b3-5a8b-3a88-54f1-024325f7fe80@socionext.com>
Date:   Tue, 8 Aug 2023 09:00:18 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] spi: dw: Set default value if reg-io-width isn't
 specified
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230807001621.196776-1-hayashi.kunihiko@socionext.com>
 <az7wvv5f42mnuuwkqzpfmwg4ngvl4jvpcfmns7d6lhzogc4qdi@ox64l6i7b44r>
Content-Language: en-US
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
In-Reply-To: <az7wvv5f42mnuuwkqzpfmwg4ngvl4jvpcfmns7d6lhzogc4qdi@ox64l6i7b44r>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Serge,

On 2023/08/08 7:57, Serge Semin wrote:
> On Mon, Aug 07, 2023 at 09:16:21AM +0900, Kunihiko Hayashi wrote:
>> According to the dt-bindings, the default value of reg-io-width is 4.
>> However, the value becomes zero when reg-io-width isn't specified.
> 
> This semantic is implied by the dw_read_io_reg() and dw_write_io_reg()
> methods. It doesn't seem like that much necessary duplicating it in the
> property parse procedure, if not to say - redundant.

I see. Currently since the variable reg_io_width has no other references
other than dw_{read, write}_io_reg(), it means the default value is taken
if this is zero.

So, I think we should be careful when actually using the value of
this variable.

Thank you,

> 
> -Serge(y)
> 
>>
>> Should set the actual value to dws->reg_io_width, considering it
>> referenced.
>>
>> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
>> ---
>>   drivers/spi/spi-dw-mmio.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/spi/spi-dw-mmio.c b/drivers/spi/spi-dw-mmio.c
>> index a963bc96c223..7eafc07ef7aa 100644
>> --- a/drivers/spi/spi-dw-mmio.c
>> +++ b/drivers/spi/spi-dw-mmio.c
>> @@ -369,7 +369,9 @@ static int dw_spi_mmio_probe(struct platform_device
> *pdev)
>>   
>>   	dws->max_freq = clk_get_rate(dwsmmio->clk);
>>   
>> -	device_property_read_u32(&pdev->dev, "reg-io-width",
> &dws->reg_io_width);
>> +	if (device_property_read_u32(&pdev->dev, "reg-io-width",
>> +				     &dws->reg_io_width))
>> +		dws->reg_io_width = 4;
>>   
>>   	num_cs = 4;
>>   
>> -- 
>> 2.25.1
>>

---
Best Regards
Kunihiko Hayashi
