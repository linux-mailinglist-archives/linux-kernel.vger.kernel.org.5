Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EC0F78FC0D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 13:04:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349072AbjIALEB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 07:04:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238117AbjIALEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 07:04:00 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89562D7
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 04:03:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 56A81B823FC
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 11:03:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78B10C433C8;
        Fri,  1 Sep 2023 11:03:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693566235;
        bh=I2iaub0EMUJL2Csl2POps/A2Cg6Qycr9Mjw6FoE53Yo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=J/iEKDs+QjF7IKgBXNVCVQgqUW8QNAKRuOH3NTCb7+7/cUcdo2nl8cg60JNHCFVvU
         QImMLMDULNPtYXQJJpwF08Ws+sR0Dea7MvLmxrhFyvzmvYiF72j7khZ6ky5pJyzOE9
         pqARkGIvugKX1kraKwTSaUVMbeNKvub7bonOFrlqSwn5FO+bXFXoua53kC+gXKTkXr
         /sXu63zw14YDvVpRnkNEhSWZouAjuEj87qcp3r6ajesk06VJ8eljRxj9KfchOEQYwo
         3UCNWKxWC/81xDI5rspn2ubSQFefu0uGpq1rTEOVN1TaQyJ6sBVAQowSE9kKPt5Lb7
         A3Cj3ljJZYKpQ==
MIME-Version: 1.0
Date:   Fri, 01 Sep 2023 13:03:51 +0200
From:   Michael Walle <mwalle@kernel.org>
To:     Tudor Ambarus <tudor.ambarus@linaro.org>
Cc:     Pratyush Yadav <pratyush@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
Subject: Re: [PATCH v2 06/41] mtd: spi-nor: default page_size to 256 bytes
In-Reply-To: <f8fe1378-686f-5889-8f0f-e1cda237ee3f@linaro.org>
References: <20230807-mtd-flash-info-db-rework-v2-0-291a0f39f8d8@kernel.org>
 <20230807-mtd-flash-info-db-rework-v2-6-291a0f39f8d8@kernel.org>
 <f8fe1378-686f-5889-8f0f-e1cda237ee3f@linaro.org>
Message-ID: <68f8c1224b5f5298ed423503f3580186@kernel.org>
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

Am 2023-08-24 10:36, schrieb Tudor Ambarus:
> On 8/22/23 08:09, Michael Walle wrote:
>> The INFO() macro always set the page_size to 256 bytes. Make that an
>> optional parameter. This default is a sane one for all older flashes,
>> newer ones will set the page size by its SFDP tables anyway.
>> 
>> Signed-off-by: Michael Walle <mwalle@kernel.org>
>> Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
>> ---
>>  drivers/mtd/spi-nor/core.c | 7 +------
>>  drivers/mtd/spi-nor/core.h | 8 ++++++--
>>  2 files changed, 7 insertions(+), 8 deletions(-)
>> 
>> diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
>> index f4cc2eafcc5e..d27ad1295ee0 100644
>> --- a/drivers/mtd/spi-nor/core.c
>> +++ b/drivers/mtd/spi-nor/core.c
>> @@ -2018,11 +2018,6 @@ static const struct spi_nor_manufacturer 
>> *manufacturers[] = {
>>  static const struct flash_info spi_nor_generic_flash = {
>>  	.name = "spi-nor-generic",
>>  	.n_banks = 1,
>> -	/*
>> -	 * JESD216 rev A doesn't specify the page size, therefore we need a
>> -	 * sane default.
>> -	 */
>> -	.page_size = 256,
>>  	.parse_sfdp = true,
>>  };
>> 
>> @@ -3001,7 +2996,7 @@ static void spi_nor_init_default_params(struct 
>> spi_nor *nor)
>>  	params->writesize = 1;
>>  	params->size = info->size;
>>  	params->bank_size = params->size;
>> -	params->page_size = info->page_size;
>> +	params->page_size = info->page_size ?: SPI_NOR_DEFAULT_PAGE_SIZE;
> 
> how about to get rid of info->page_size entirely and directly use the
> default?

We'd first have to get rid of the Xilinx S3AN and the everspin stuff.
They are still using a different page size. That being said, that's
on my todo list.

-michael
