Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A52F57A610D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 13:18:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231881AbjISLSU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 07:18:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231665AbjISLSR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 07:18:17 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0038F2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 04:18:10 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7467C433C7;
        Tue, 19 Sep 2023 11:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695122290;
        bh=FBr/duLnMLUp4OEqEvn7ySuq3D9P7mkz4j8Di64T388=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=CDQ8604phgwnal+8wn8eyt7s6Q6m8OeIUl2WjSIrDoLL+6JEDIC1xnTHkZvlwovYH
         hMB3VMQfp0OY1e9LAR7fWwVhMfo1GjtUAf24Uoob96jVXdJLFwpCQgjUNHPY7mgye2
         k6ah0F/2cT6Xs2MRlcZRpToJgyD/yC7DJTwu4x8yPCosuEDC+A2qS+WF1XgCiSzzF/
         D2UCPh4+rZYTxuKtenAB5SBNs7GMM3EH01faF6msjeVo7Qe7wNn+ad9alGlRXgudTR
         bmM23Ub5MY3pAQ79s2pzOCpY4DY4LZwhY5ck3ERnyzLnDt6EEAE603CT+3T0TbCscH
         VLUs3IbjuBszw==
MIME-Version: 1.0
Date:   Tue, 19 Sep 2023 13:18:05 +0200
From:   Michael Walle <mwalle@kernel.org>
To:     Tudor Ambarus <tudor.ambarus@linaro.org>
Cc:     Pratyush Yadav <pratyush@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
Subject: Re: [PATCH v3 05/41] mtd: spi-nor: convert .n_sectors to .size
In-Reply-To: <80641a1c-d922-22cc-edd4-76d475e1aac8@linaro.org>
References: <20230807-mtd-flash-info-db-rework-v3-0-e60548861b10@kernel.org>
 <20230807-mtd-flash-info-db-rework-v3-5-e60548861b10@kernel.org>
 <80641a1c-d922-22cc-edd4-76d475e1aac8@linaro.org>
Message-ID: <beccab49f4c7dd1ac403d5e88a348724@kernel.org>
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

Am 2023-09-19 11:24, schrieb Tudor Ambarus:
> On 08.09.2023 13:16, Michael Walle wrote:
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
> 
> this should use nor->params instead, but we can do it later on.

I didn't do that because there is no need to change sector_size. We
have erase maps, which are already part of the params. So that should
be changed. Just in the non-SFDP case we infer the erase map from
sector_size.

> New
> flash additions must specify the sector size, otherwise we get a
> division by zero below. I see you introduce a default value in patch 
> 10,
> which will guard us.

Yes the assumption is that - for now - if locking is supported, we
need a nor->info->sector_size.

> I assume  you checked that there's no flash that
> specifies BP and sector size of zero up to patch 9 inclusively,
> otherwise we'll break bisect-ability. Let me know if yes, and I'll
> update the commit message when applying.

Yes. The assumption above was already a requirement.

-michael
