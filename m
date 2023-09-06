Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C0AA793663
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 09:38:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231995AbjIFHiQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 03:38:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjIFHiP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 03:38:15 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A565CFF
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 00:38:12 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B747C433C8;
        Wed,  6 Sep 2023 07:38:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693985892;
        bh=TlFFHkQqnU9xxEpivIc2OzdDpMruk7bYtr2KqdZe+JU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Lhh8tVR+xMS5I3tRz33K0Edqpq5824vTwtxpEETY8yARl5JZ39kownBAtnopmYwpq
         XFEzK3I29FBSQk5YfzwPayL+R3YOEhexMU4b4hlKaQIgHcASFJXp4FIy7g0kYMw0xu
         j/r+es9iAizkJxLooGwcYM6AZghHoONZrqBcjviVo/b8wHr/7KfsGY6pIkiIaLZXw0
         J6m364nCTDxY6pGHLHN2AxORh9kyecL4mFsa5o4jV9zW4vdi+/9MUYTGmhyJ2UdAit
         N+rLU82xEJP2pEzzpGb3mRhhTQhvi3b/O7YqSLmZltcDRHT53txfnRG0zlBc22al5g
         nelUjNRPkWdSA==
MIME-Version: 1.0
Date:   Wed, 06 Sep 2023 09:38:08 +0200
From:   Michael Walle <mwalle@kernel.org>
To:     Tudor Ambarus <tudor.ambarus@linaro.org>
Cc:     Pratyush Yadav <pratyush@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
Subject: Re: [PATCH v2 17/41] mtd: spi-nor: atmel: convert flash_info to new
 format
In-Reply-To: <aba618e2-ad74-d716-c8d7-e77588b22509@linaro.org>
References: <20230807-mtd-flash-info-db-rework-v2-0-291a0f39f8d8@kernel.org>
 <20230807-mtd-flash-info-db-rework-v2-17-291a0f39f8d8@kernel.org>
 <aba618e2-ad74-d716-c8d7-e77588b22509@linaro.org>
Message-ID: <50043f689a491d330eea22714f72f95a@kernel.org>
X-Sender: mwalle@kernel.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2023-09-06 09:35, schrieb Tudor Ambarus:
> On 22.08.2023 10:09, Michael Walle wrote:
>> The INFOx() macros are going away. Convert the flash_info database to
>> the new format.
>> 
>> Signed-off-by: Michael Walle <mwalle@kernel.org>
>> ---
>>  drivers/mtd/spi-nor/atmel.c | 122 
>> +++++++++++++++++++++++++++++---------------
>>  1 file changed, 80 insertions(+), 42 deletions(-)
>> 
>> diff --git a/drivers/mtd/spi-nor/atmel.c b/drivers/mtd/spi-nor/atmel.c
>> index d2de2cb0c066..ccc985c48ae3 100644
>> --- a/drivers/mtd/spi-nor/atmel.c
>> +++ b/drivers/mtd/spi-nor/atmel.c
>> @@ -163,48 +163,86 @@ static const struct spi_nor_fixups 
>> atmel_nor_global_protection_fixups = {
>>  };
>> 
>>  static const struct flash_info atmel_nor_parts[] = {
>> -	{ "at25fs010",  INFO(0x1f6601, 0, 32 * 1024,   4)
>> -		FLAGS(SPI_NOR_HAS_LOCK)
>> -		NO_SFDP_FLAGS(SECT_4K)
>> -		.fixups = &at25fs_nor_fixups },
>> -	{ "at25fs040",  INFO(0x1f6604, 0, 64 * 1024,   8)
>> -		FLAGS(SPI_NOR_HAS_LOCK)
>> -		NO_SFDP_FLAGS(SECT_4K)
>> -		.fixups = &at25fs_nor_fixups },
>> -	{ "at25df041a", INFO(0x1f4401, 0, 64 * 1024,   8)
>> -		FLAGS(SPI_NOR_HAS_LOCK | SPI_NOR_SWP_IS_VOLATILE)
>> -		NO_SFDP_FLAGS(SECT_4K)
>> -		.fixups = &atmel_nor_global_protection_fixups },
>> -	{ "at25df321",  INFO(0x1f4700, 0, 64 * 1024,  64)
>> -		FLAGS(SPI_NOR_HAS_LOCK | SPI_NOR_SWP_IS_VOLATILE)
>> -		NO_SFDP_FLAGS(SECT_4K)
>> -		.fixups = &atmel_nor_global_protection_fixups },
>> -	{ "at25df321a", INFO(0x1f4701, 0, 64 * 1024,  64)
>> -		FLAGS(SPI_NOR_HAS_LOCK | SPI_NOR_SWP_IS_VOLATILE)
>> -		NO_SFDP_FLAGS(SECT_4K)
>> -		.fixups = &atmel_nor_global_protection_fixups },
>> -	{ "at25df641",  INFO(0x1f4800, 0, 64 * 1024, 128)
>> -		FLAGS(SPI_NOR_HAS_LOCK | SPI_NOR_SWP_IS_VOLATILE)
>> -		NO_SFDP_FLAGS(SECT_4K)
>> -		.fixups = &atmel_nor_global_protection_fixups },
>> -	{ "at25sl321",	INFO(0x1f4216, 0, 64 * 1024, 64)
>> -		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
>> -	{ "at26f004",   INFO(0x1f0400, 0, 64 * 1024,  8)
>> -		NO_SFDP_FLAGS(SECT_4K) },
>> -	{ "at26df081a", INFO(0x1f4501, 0, 64 * 1024, 16)
>> -		FLAGS(SPI_NOR_HAS_LOCK | SPI_NOR_SWP_IS_VOLATILE)
>> -		NO_SFDP_FLAGS(SECT_4K)
>> -		.fixups = &atmel_nor_global_protection_fixups },
>> -	{ "at26df161a", INFO(0x1f4601, 0, 64 * 1024, 32)
>> -		FLAGS(SPI_NOR_HAS_LOCK | SPI_NOR_SWP_IS_VOLATILE)
>> -		NO_SFDP_FLAGS(SECT_4K)
>> -		.fixups = &atmel_nor_global_protection_fixups },
>> -	{ "at26df321",  INFO(0x1f4700, 0, 64 * 1024, 64)
>> -		FLAGS(SPI_NOR_HAS_LOCK | SPI_NOR_SWP_IS_VOLATILE)
>> -		NO_SFDP_FLAGS(SECT_4K)
>> -		.fixups = &atmel_nor_global_protection_fixups },
>> -	{ "at45db081d", INFO(0x1f2500, 0, 64 * 1024, 16)
>> -		NO_SFDP_FLAGS(SECT_4K) },
>> +	{
>> +		.id = SNOR_ID(0x1f, 0x66, 0x01),
>> +		.name = "at25fs010",
> 
> nitpick, we shall respect the order of the members declared in
> flash_info struct.

The id is the first one on purpose, because that's our main
key to the entry. I couldn't swap the properties in flash_info
yet because the old entry style used also positional parameters,
i.e. the first entry was always the name.

> And I'll let you double check if the conversion is accurate :D.

See the cover letter for the objdump trick :)

-michael
