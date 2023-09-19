Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 344937A6138
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 13:31:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230443AbjISLbW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 07:31:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjISLbT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 07:31:19 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 917F8E3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 04:31:14 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EFB5C433C8;
        Tue, 19 Sep 2023 11:31:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695123074;
        bh=5ru64uTo5hwHfPq+Yd9EZrxiNaBgze2zLhEfszCpNks=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=LAGgnB3BNs4lvtH8Yw6xVsRZpHrBq36ruK9GIGsoX4J4lgqZGh6iZP7HDGjIsBDKm
         unyQeXKZyBAmYthMTXvUOmeR9S4qPRUcnEduQBNVsCVHHqIum5P22K2qivM2j+Dc2d
         o9Uv/ebSLQtp1qRnsksRcU2FxEM2UWi1CT6G6srYgY+JvpOij8JfVkHlqWZZvnqEsl
         kZslLoqs6jiciZ4j+JncoXNuci3gDt8uTPYVemFA24KzX6CiRK4KEmrDdM+/DzCeM4
         DrGUy8bWZ5pXNs3r145iG/ThXrrJnCU9800t1k58Oh6hvTofuB0mKmUYRezuL90OJu
         kfyGOd6GFjyUw==
MIME-Version: 1.0
Date:   Tue, 19 Sep 2023 13:31:10 +0200
From:   Michael Walle <mwalle@kernel.org>
To:     Tudor Ambarus <tudor.ambarus@linaro.org>
Cc:     Pratyush Yadav <pratyush@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
Subject: Re: [PATCH v3 10/41] mtd: spi-nor: make sector_size optional
In-Reply-To: <417fb0fa-e774-c744-8641-7618347a8d1a@linaro.org>
References: <20230807-mtd-flash-info-db-rework-v3-0-e60548861b10@kernel.org>
 <20230807-mtd-flash-info-db-rework-v3-10-e60548861b10@kernel.org>
 <417fb0fa-e774-c744-8641-7618347a8d1a@linaro.org>
Message-ID: <4ec7192b6bfaf956e1b8e747e5fd07e7@kernel.org>
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

Am 2023-09-19 11:25, schrieb Tudor Ambarus:
> On 08.09.2023 13:16, Michael Walle wrote:
>> Most of the (old, non-SFDP) flashes use a sector size of 64k. Make 
>> that
>> a default value so it can be optional in the flash_info database.
>> 
>> As a preparation for conversion to the new database format, set the
>> sector size to zero if the default value is used. This way, the actual
>> change is happening with this patch ant not with a later conversion
>> patch.
>> 
>> Signed-off-by: Michael Walle <mwalle@kernel.org>
>> ---
>>  drivers/mtd/spi-nor/core.c | 6 ++++--
>>  drivers/mtd/spi-nor/core.h | 8 +++++---
>>  drivers/mtd/spi-nor/swp.c  | 6 +++++-
>>  3 files changed, 14 insertions(+), 6 deletions(-)
>> 
>> diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
>> index c84be791341e..368851ff9f40 100644
>> --- a/drivers/mtd/spi-nor/core.c
>> +++ b/drivers/mtd/spi-nor/core.c
>> @@ -2756,7 +2756,8 @@ static void spi_nor_no_sfdp_init_params(struct 
>> spi_nor *nor)
>>  {
>>  	struct spi_nor_flash_parameter *params = nor->params;
>>  	struct spi_nor_erase_map *map = &params->erase_map;
>> -	const u8 no_sfdp_flags = nor->info->no_sfdp_flags;
>> +	const struct flash_info *info = nor->info;
>> +	const u8 no_sfdp_flags = info->no_sfdp_flags;
>>  	u8 i, erase_mask;
>> 
>>  	if (no_sfdp_flags & SPI_NOR_DUAL_READ) {
>> @@ -2810,7 +2811,8 @@ static void spi_nor_no_sfdp_init_params(struct 
>> spi_nor *nor)
>>  		i++;
>>  	}
>>  	erase_mask |= BIT(i);
>> -	spi_nor_set_erase_type(&map->erase_type[i], nor->info->sector_size,
>> +	spi_nor_set_erase_type(&map->erase_type[i],
>> +			       info->sector_size ?: SPI_NOR_DEFAULT_SECTOR_SIZE,
>>  			       SPINOR_OP_SE);
> 
> all these info->sector_size checks can be removed if we use
> params->sector_size. I'll do it after applying the series.

See previous reply, there will be just this check. The one in swp.c
will go away. I don't have a strong opinion. I just didn't want to
have redundant information.

Speaking of.. there is a check missing in

--snip--
diff --git a/drivers/mtd/spi-nor/spansion.c 
b/drivers/mtd/spi-nor/spansion.c
index fd2652aa6c1e..e4c725000964 100644
--- a/drivers/mtd/spi-nor/spansion.c
+++ b/drivers/mtd/spi-nor/spansion.c
@@ -1053,7 +1053,8 @@ static int spansion_nor_late_init(struct spi_nor 
*nor)
  		nor->flags |= SNOR_F_4B_OPCODES;
  		/* No small sector erase for 4-byte command set */
  		nor->erase_opcode = SPINOR_OP_SE;
-		nor->mtd.erasesize = nor->info->sector_size;
+		nor->mtd.erasesize = nor->info->sector_size ?:
+				     SPI_NOR_DEFAULT_SECTOR_SIZE;
  	}

  	if (mfr_flags & (USE_CLSR | USE_CLPEF)) {
--snip--

Is it possible to amend this patch while you apply it? A later patch
should probably fixup the erase_map instead of setting the erase_opcode
and erasesize itself.

-michael
