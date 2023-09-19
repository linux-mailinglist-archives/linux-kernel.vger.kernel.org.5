Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D4CC7A6159
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 13:34:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231639AbjISLdr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 07:33:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231285AbjISLdk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 07:33:40 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFD10F0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 04:33:34 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADC17C433C7;
        Tue, 19 Sep 2023 11:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695123214;
        bh=oSAfuJuJoAkvG41btmzxmDdHDNRt675GLYS925NJ/K0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=cGS7C36SFKY3HbPNdzJfObib4KXB8l0OK9PVF8LMO57N/Z9NS6651rPLThLE7D3vZ
         TY1Q96jd+LihiJD9aptxhNWtbzSg9z/k3proslMz2bJcDwAcKx8PY8xbuNhpAljZVL
         07mOyxu+WWIiuGLt0qPp6xIfKB0YP94rGHEauFZBWKdXLwl4CbyxN6d4IHZZ6rPeWy
         A5MCMRbRmy0EB5k98+sz4ES5Fm8GsH6DT8F8i6EXoZMfyIsBVlw8SY+UzoMjBHMVTv
         UepPwRDSLFK3VzSHd7yMh05BGkcpVqDHaCPwKNy4fg1UZg0GvwwtB2RcORx8yuuV5z
         cdHeUS731nESw==
MIME-Version: 1.0
Date:   Tue, 19 Sep 2023 13:33:30 +0200
From:   Michael Walle <mwalle@kernel.org>
To:     Tudor Ambarus <tudor.ambarus@linaro.org>
Cc:     Pratyush Yadav <pratyush@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
Subject: Re: [PATCH v3 20/41] mtd: spi-nor: everspin: convert flash_info to
 new format
In-Reply-To: <647d3775-a71d-a880-6d4d-3eb5a89ec9d6@linaro.org>
References: <20230807-mtd-flash-info-db-rework-v3-0-e60548861b10@kernel.org>
 <20230807-mtd-flash-info-db-rework-v3-20-e60548861b10@kernel.org>
 <647d3775-a71d-a880-6d4d-3eb5a89ec9d6@linaro.org>
Message-ID: <e7a48b040541f783773d9d0039816633@kernel.org>
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
>> The INFOx() macros are going away. Convert the flash_info database to
>> the new format.
>> 
>> Signed-off-by: Michael Walle <mwalle@kernel.org>
>> ---
>>  drivers/mtd/spi-nor/everspin.c | 33 +++++++++++++++++++++++++++++----
>>  1 file changed, 29 insertions(+), 4 deletions(-)
>> 
>> diff --git a/drivers/mtd/spi-nor/everspin.c 
>> b/drivers/mtd/spi-nor/everspin.c
>> index d02c32f2f7ad..46776bc10b27 100644
>> --- a/drivers/mtd/spi-nor/everspin.c
>> +++ b/drivers/mtd/spi-nor/everspin.c
>> @@ -9,10 +9,35 @@
>>  #include "core.h"
>> 
>>  static const struct flash_info everspin_nor_parts[] = {
>> -	{ "mr25h128", CAT25_INFO(16 * 1024, 1, 256, 2) },
>> -	{ "mr25h256", CAT25_INFO(32 * 1024, 1, 256, 2) },
>> -	{ "mr25h10",  CAT25_INFO(128 * 1024, 1, 256, 3) },
>> -	{ "mr25h40",  CAT25_INFO(512 * 1024, 1, 256, 3) },
>> +	{
>> +		.name = "mr25h128",
>> +		.size = SZ_16K,
>> +		.sector_size = SZ_16K,
>> +		.page_size = 256,
> 
> page size defaults to 256, isn't it? Can we get rid of the page_size
> assignments?

Yes!

> 
>> +		.addr_nbytes = 2,
>> +		.flags = SPI_NOR_NO_ERASE | SPI_NOR_NO_FR,
>> +	}, {
>> +		.name = "mr25h256",
>> +		.size = SZ_32K,
>> +		.sector_size = SZ_32K,
>> +		.page_size = 256,
>> +		.addr_nbytes = 2,
>> +		.flags = SPI_NOR_NO_ERASE | SPI_NOR_NO_FR,
>> +	}, {
>> +		.name = "mr25h10",
>> +		.size = SZ_128K,
>> +		.sector_size = SZ_128K,
>> +		.page_size = 256,
>> +		.addr_nbytes = 3,

also "addr_nbytes = 3" is the default.

-michael

>> +		.flags = SPI_NOR_NO_ERASE | SPI_NOR_NO_FR,
>> +	}, {
>> +		.name = "mr25h40",
>> +		.size = SZ_512K,
>> +		.sector_size = SZ_512K,
>> +		.page_size = 256,
>> +		.addr_nbytes = 3,
>> +		.flags = SPI_NOR_NO_ERASE | SPI_NOR_NO_FR,
>> +	}
>>  };
>> 
>>  const struct spi_nor_manufacturer spi_nor_everspin = {
>> 
