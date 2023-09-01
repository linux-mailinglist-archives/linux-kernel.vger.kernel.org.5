Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50BCB78FC02
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 13:00:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347207AbjIALA4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 07:00:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349073AbjIALAz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 07:00:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68A9C10D2
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 04:00:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3195EB821F9
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 11:00:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88ECCC433C9;
        Fri,  1 Sep 2023 11:00:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693566048;
        bh=9wNybEkDrP39FqndXH3ASSh7pRWU+k5rHL6wMWLCDFc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fP0mXdEOAYpOrg8xqTiYbvflR22PvDvzVz+ZOHyEpuq2xJCyoJVpkQ6qAQ6MRe2Iq
         N/VWigF8A7+cj5XRjcRWxY1QJN8N6XsRp06iyszs4G25WH6IR+eAXhJx3tve+pOIwQ
         3xaQq7a/0MTvo2KrY2cems3s4wajqsMOqOvYuMoVMAgNhq1RFmaVhra8J57ghnM4YY
         kHsNiyMqzjk3Zp2IJCmL9k5+aIAyQIf3ee8KJrFn/HrYX92iDJHipQnGne695xU/3E
         7VfLkC/X8ZXdLto0pktDLqN+jk9Kh28R4MGxEoAYn0CsEgDaRnstXpglZGGJqdRiRl
         mcn2l/IFP9P2A==
MIME-Version: 1.0
Date:   Fri, 01 Sep 2023 13:00:45 +0200
From:   Michael Walle <mwalle@kernel.org>
To:     Tudor Ambarus <tudor.ambarus@linaro.org>
Cc:     Pratyush Yadav <pratyush@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
Subject: Re: [PATCH v2 05/41] mtd: spi-nor: convert .n_sectors to .size
In-Reply-To: <3df0728d-60d8-1cff-a0d9-f3de505dfa17@linaro.org>
References: <20230807-mtd-flash-info-db-rework-v2-0-291a0f39f8d8@kernel.org>
 <20230807-mtd-flash-info-db-rework-v2-5-291a0f39f8d8@kernel.org>
 <3df0728d-60d8-1cff-a0d9-f3de505dfa17@linaro.org>
Message-ID: <d7985b397e19f66c0692369e20a4fba6@kernel.org>
X-Sender: mwalle@kernel.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2023-08-24 10:25, schrieb Tudor Ambarus:
> On 8/22/23 08:09, Michael Walle wrote:
>> .n_sectors is rarely used. In fact it is only used in swp.c and to
>> calculate the flash size in the core. The use in swp.c might be
>> converted to use the (largest) flash erase size. For now, we just
>> locally calculate the sector size.
>> 
>> Simplify the flash_info database and set the size of the flash 
>> directly.
>> This also let us use the SZ_x macros.
>> 
>> Signed-off-by: Michael Walle <mwalle@kernel.org>
>> ---
>>  drivers/mtd/spi-nor/core.c   | 2 +-
>>  drivers/mtd/spi-nor/core.h   | 8 ++++----
>>  drivers/mtd/spi-nor/swp.c    | 9 +++++----
>>  drivers/mtd/spi-nor/xilinx.c | 4 ++--
>>  4 files changed, 12 insertions(+), 11 deletions(-)
>> 
>> diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
>> index 286155002cdc..f4cc2eafcc5e 100644
>> --- a/drivers/mtd/spi-nor/core.c
>> +++ b/drivers/mtd/spi-nor/core.c
>> @@ -2999,7 +2999,7 @@ static void spi_nor_init_default_params(struct 
>> spi_nor *nor)
>> 
>>  	/* Set SPI NOR sizes. */
>>  	params->writesize = 1;
>> -	params->size = (u64)info->sector_size * info->n_sectors;
>> +	params->size = info->size;
> 
> would be good to check the sanity of info->size to not be null and to 
> be
> divisible by sector_size.

Have a look at the later patches, info->size can be zero, indicating
that we need to parse SFDP for this flash.

I could validate that the size is a multiple of sector_size, but
that one might also be zero. Of course you could solve this by
additional logic. But I treated that one as a misconfiguration
of the flash_info entry. It's nothing which can happen during
runtime. Anyway, I have no strong opinion on the "is multiple
of sector_size" check (for now, maybe there's something I didn't
thought of now).

> 
>>  	params->bank_size = params->size;
>>  	params->page_size = info->page_size;
>> 
>> diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
>> index dfc20a3296fb..12c35409493b 100644
>> --- a/drivers/mtd/spi-nor/core.h
>> +++ b/drivers/mtd/spi-nor/core.h
>> @@ -443,9 +443,9 @@ struct spi_nor_fixups {
>>   * @id:             the flash's ID bytes. The first three bytes are 
>> the
>>   *                  JEDIC ID. JEDEC ID zero means "no ID" (mostly 
>> older chips).
>>   * @id_len:         the number of bytes of ID.
>> + * @size:           the size of the flash in bytes.
>>   * @sector_size:    the size listed here is what works with 
>> SPINOR_OP_SE, which
>>   *                  isn't necessarily called a "sector" by the 
>> vendor.
>> - * @n_sectors:      the number of sectors.
>>   * @n_banks:        the number of banks.
>>   * @page_size:      the flash's page size.
>>   * @addr_nbytes:    number of address bytes to send.
>> @@ -505,8 +505,8 @@ struct flash_info {
>>  	char *name;
>>  	u8 id[SPI_NOR_MAX_ID_LEN];
>>  	u8 id_len;
>> +	size_t size;
>>  	unsigned sector_size;
>> -	u16 n_sectors;
>>  	u16 page_size;
>>  	u8 n_banks;
>>  	u8 addr_nbytes;
>> @@ -556,8 +556,8 @@ struct flash_info {
>>  	.id_len = 6
>> 
>>  #define SPI_NOR_GEOMETRY(_sector_size, _n_sectors, _n_banks)		\
>> +	.size = (_sector_size) * (_n_sectors),				\
>>  	.sector_size = (_sector_size),					\
>> -	.n_sectors = (_n_sectors),					\
>>  	.page_size = 256,						\
>>  	.n_banks = (_n_banks)
>> 
>> @@ -575,8 +575,8 @@ struct flash_info {
>>  	SPI_NOR_GEOMETRY((_sector_size), (_n_sectors), 1),
>> 
>>  #define CAT25_INFO(_sector_size, _n_sectors, _page_size, 
>> _addr_nbytes)	\
>> +		.size = (_sector_size) * (_n_sectors),			\
>>  		.sector_size = (_sector_size),				\
>> -		.n_sectors = (_n_sectors),				\
>>  		.page_size = (_page_size),				\
>>  		.n_banks = 1,						\
>>  		.addr_nbytes = (_addr_nbytes),				\
>> diff --git a/drivers/mtd/spi-nor/swp.c b/drivers/mtd/spi-nor/swp.c
>> index 5ab9d5324860..40bf52867095 100644
>> --- a/drivers/mtd/spi-nor/swp.c
>> +++ b/drivers/mtd/spi-nor/swp.c
>> @@ -34,17 +34,18 @@ static u8 spi_nor_get_sr_tb_mask(struct spi_nor 
>> *nor)
>>  static u64 spi_nor_get_min_prot_length_sr(struct spi_nor *nor)
>>  {
>>  	unsigned int bp_slots, bp_slots_needed;
>> +	unsigned int sector_size = nor->info->sector_size;
>> +	u64 n_sectors = div_u64(nor->params->size, sector_size);
> 
> if params(info)->size is zero here, we get into trouble.

Please note that this is not the info->size, params->size cannot
be zero. If info->size was zero, we have to parse SFDP which hopefully
will give us a sane size.

And regarding the sector_size, which could be zero here. I want to
replace that logic, so we don't rely on the flash_info sector size.
 From a later patch:

         /*
          * sector_size will eventually be replaced with the max erase 
size of
          * the flash. For now, we need to have that ugly default.
          */

-michael
