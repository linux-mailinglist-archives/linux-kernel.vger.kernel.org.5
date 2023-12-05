Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68FF6805622
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 14:36:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345503AbjLENgc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 08:36:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345471AbjLENga (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 08:36:30 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C989BA;
        Tue,  5 Dec 2023 05:36:37 -0800 (PST)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1rAVbG-0006du-4s; Tue, 05 Dec 2023 14:36:34 +0100
Message-ID: <6c97a39b-4ba6-4d79-985e-a69f8e0c76a4@leemhuis.info>
Date:   Tue, 5 Dec 2023 14:36:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: spi: imx: Increase imx51 ecspi burst length fails on imx6dl and
 imx8mm
Content-Language: en-US, de-DE
To:     linux@bigler.io, Benjamin Bigler <benjamin@bigler.one>
Cc:     broonie@kernel.org, francesco@dolcini.it,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        regressions@lists.linux.dev, stefan.moring@technolution.nl
References: <c7a38307ac74a973e26ac820a0b98773262720bd.camel@bigler.one>
 <89209fbb46c4ce650141ecb6fdf06476@mail.infomaniak.com>
From:   "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <89209fbb46c4ce650141ecb6fdf06476@mail.infomaniak.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1701783397;20bb4ff0;
X-HE-SMSGID: 1rAVbG-0006du-4s
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27.11.23 10:09, linux@bigler.io wrote:
> 
> Thank you Benjamin for the patch.
> I have tested the patch and is works fine.

That's great.

Benjamin, what's the status of the fix for this regression? I tried to
find a proper submission for review, but didn't find one. Am I missing
something or did that fall through the cracks?

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

#regzbot poke

> Am 2023-11-26T14:19:56.000+01:00 hat Benjamin Bigler <benjamin@bigler.one> geschrieben:
>>  Hi
>>
>> I did some debugging and I think the problem is that in this case bits_per_word is 8. So in
>> spi_imx_dma_configure the buswidth is set to DMA_SLAVE_BUSWIDTH_1_BYTE. But in
>> mx51_ecspi_prepare_transfer the BURST_LENGTH is now set to (spi_imx->count * spi_imx->bits_per_word
>> - 1)
>> before 15a6af94a2779d5dfb42ee4bfac858ea8e964a3f it was (spi_imx->bits_per_word - 1). Now the spi
>> transmits 4 byte per byte except for the first word. I added the following patch and it worked again
>>
>> diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
>> index 498e35c8db2c..f514966e2ada 100644
>> --- a/drivers/spi/spi-imx.c
>> +++ b/drivers/spi/spi-imx.c
>> @@ -659,11 +659,22 @@ static int mx51_ecspi_prepare_transfer(struct spi_imx_data *spi_imx,
>>  		ctrl |= (spi_imx->target_burst * 8 - 1)
>>  			<< MX51_ECSPI_CTRL_BL_OFFSET;
>>  	else {
>> -		if (spi_imx->count &gt;= 512)
>> -			ctrl |= 0xFFF << MX51_ECSPI_CTRL_BL_OFFSET;
>> -		else
>> -			ctrl |= (spi_imx->count * spi_imx->bits_per_word - 1)
>> +		if (spi_imx->usedma)
>> +			ctrl |= (spi_imx->bits_per_word *
>> +					 spi_imx_bytes_per_word(
>> +						 spi_imx->bits_per_word) -
>> +				 1)
>>  				<< MX51_ECSPI_CTRL_BL_OFFSET;
>> +		else {
>> +			if (spi_imx->count &gt;= MX51_ECSPI_CTRL_MAX_BURST)
>> +				ctrl |= (MX51_ECSPI_CTRL_MAX_BURST - 1)
>> +					<< MX51_ECSPI_CTRL_BL_OFFSET;
>> +			else
>> +				ctrl |= (spi_imx->count *
>> +						 spi_imx->bits_per_word -
>> +					 1)
>> +					<< MX51_ECSPI_CTRL_BL_OFFSET;
>> +		}
>>  	}
>>  
>>  	/* set clock speed */
>>
>> Best regards,
> Benjamin Bigler
> 
> 
