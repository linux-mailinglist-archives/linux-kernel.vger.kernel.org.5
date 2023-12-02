Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01B5B801C7F
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 13:03:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232545AbjLBMBo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 07:01:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjLBMBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 07:01:43 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87CFA123
        for <linux-kernel@vger.kernel.org>; Sat,  2 Dec 2023 04:01:49 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFB60C433C9;
        Sat,  2 Dec 2023 12:01:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701518509;
        bh=qGF18cj5rouLI1EH0KmHGn52Fmi+W0AJNsfWPtuN2qw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Ra4lMt8xEm7aZSkJnkPN72ti44Ti5DIfsTJQqmyjLy907PoxtAFpV9zCl1c9jaJOA
         8tUJo3wxPJj15A2X0GDshgVaaOIH2bOS4ZQ938qq5/EqOZ1nd4zX9p70DkG2MRJo/L
         uYJGbssiqgMv8xXFGm+UAMobvSl6HtCmZRKxa5gksqp0uskezGm/ubvcWmnv+mV328
         PPCOrSYgAvfu8unQhiSh3Bb/GmjHgvSh3LY1zAQwQe4vWeRfHKtkXbNl4VhCrsACK3
         fd3/T0hF85mOdPj2TichFRJy98nrxntBDoh1wHzlB1ralt5jN8KhLj+1s/gPKWNsVd
         8NhpTj7c+iKsw==
Message-ID: <5ccc0a13-01e1-464c-980b-bdf34970cc33@kernel.org>
Date:   Sat, 2 Dec 2023 13:01:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/5] w1: ds2490: support block sizes larger than 128
 bytes in ds_read_block
To:     marc.ferland@gmail.com, krzysztof.kozlowski@linaro.org
Cc:     gregkh@linuxfoundation.org, marc.ferland@sonatest.com,
        jeff.dagenais@gmail.com, rdunlap@infradead.org,
        linux-kernel@vger.kernel.org
References: <20231130135232.191320-1-marc.ferland@sonatest.com>
 <20231130135232.191320-2-marc.ferland@sonatest.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzk@kernel.org>
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <20231130135232.191320-2-marc.ferland@sonatest.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/11/2023 14:52, marc.ferland@gmail.com wrote:
> From: Marc Ferland <marc.ferland@sonatest.com>
> 
> The current ds_read_block function only supports block sizes up to
> 128 bytes, which is the depth of the 'data out' fifo on the ds2490.
> 
> Reading larger blocks will fail with a: -110 (ETIMEDOUT) from
> usb_control_msg(). Example:
> 
>     $ dd if=/sys/bus/w1/devices/43-000000478756/eeprom bs=256 count=1
> 
> yields to the following message from the kernel:
> 
>     usb 5-1: Failed to write 1-wire data to ep0x2: err=-110.
> 
> I discovered this issue while implementing support for the ds28ec20
> eeprom in the w1-2433 driver. This driver accepts reading blocks of
> sizes up to the size of the entire memory (2560 bytes in the case of
> the ds28ec20). Note that this issue _does not_ arises when the kernel
> is configured with CONFIG_W1_SLAVE_DS2433_CRC enabled since in this
> mode the driver reads one 32 byte block at a time (a single memory
> page).
> 
> Also, from the ds2490 datasheet (2995.pdf, page 22, BLOCK I/O
> command):
> 
>      For a block write sequence the EP2 FIFO must be pre-filled with
>      data before command execution. Additionally, for block sizes
>      greater then the FIFO size, the FIFO content status must be
>      monitored by host SW so that additional data can be sent to the
>      FIFO when necessary. A similar EP3 FIFO content monitoring
>      requirement exists for block read sequences. During a block read
>      the number of bytes loaded into the EP3 FIFO must be monitored so
>      that the data can be read before the FIFO overflows.
> 
> Breaking the buffer in 128 bytes blocks and simply calling the
> original code sequence has solved the issue for me.
> 
> Tested with a DS1490F usb<->one-wire adapter and both the DS28EC20 and
> DS2433 eeprom memories.
> 
> Note: The v1 of this patch changed both the ds_read_block and
> ds_write_block functions, but since I don't have any way to test the
> 'write' part with writes bigger than a page size (maximum accepted by
> my eeprom), I preferred not to make any assumptions and I just
> removed that part.

Drop that paragraph, not really helping to understand the commit once
accepted.

> 
> Signed-off-by: Marc Ferland <marc.ferland@sonatest.com>
> ---
>  drivers/w1/masters/ds2490.c | 25 +++++++++++++++++++++----
>  1 file changed, 21 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/w1/masters/ds2490.c b/drivers/w1/masters/ds2490.c
> index 5f5b97e24700..b6e244992c15 100644
> --- a/drivers/w1/masters/ds2490.c
> +++ b/drivers/w1/masters/ds2490.c
> @@ -98,6 +98,8 @@
>  #define ST_EPOF				0x80
>  /* Status transfer size, 16 bytes status, 16 byte result flags */
>  #define ST_SIZE				0x20
> +/* 1-wire data i/o fifo size, 128 bytes */
> +#define FIFO_SIZE			0x80
>  
>  /* Result Register flags */
>  #define RR_DETECT			0xA5 /* New device detected */
> @@ -614,14 +616,11 @@ static int ds_read_byte(struct ds_device *dev, u8 *byte)
>  	return 0;
>  }
>  
> -static int ds_read_block(struct ds_device *dev, u8 *buf, int len)
> +static int __read_block(struct ds_device *dev, u8 *buf, int len)

Drop __ and name the function descriptive. It's confusing to have two
times read_block(). Just name them according to what they really do.

Best regards,
Krzysztof

