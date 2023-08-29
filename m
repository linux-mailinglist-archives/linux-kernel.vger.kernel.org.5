Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DE3F78BECB
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 08:49:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbjH2GtD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 02:49:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233711AbjH2Gsv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 02:48:51 -0400
Received: from mail.3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A6B0E1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 23:48:48 -0700 (PDT)
Received: from 3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id DCBB5A55;
        Tue, 29 Aug 2023 08:48:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1693291725;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=q5F5WhjfdT+77U4L9JnSs2za5mERiqnZyuCnUDfQa/c=;
        b=Ey+yebf4iiJBEV7UdMIg7djW3boOUJ6/soVYL/XjSfrxD7HiG0c8yFQ/kVzx8FfoDD4tZZ
        gIm1FlGQiacwCkVBlR0UggTep0j3HIo7yjS54QeJ2KsDDyf1PYmWBKDKy4Da6jgXCEfj2I
        YdoyORELMS1YUMpIdQIeNnCd85/N3++h13VEFr4H4XxlwUJej4wvL/N/ho0iSFAGGKMDFa
        z4KLWFubxsyaGS3zuWScdbxGGRiSd2O2F8uDTOQie6Vpi4HVTwOVbmVrcPoG8YvS+A3fPf
        8kLfXXH8tkAj2i5jWWkjVJI56b2+1x1dFFvTczpZ7BtlP/n/K2OVxSe09+PE2Q==
MIME-Version: 1.0
Date:   Tue, 29 Aug 2023 08:48:45 +0200
From:   Michael Walle <michael@walle.cc>
To:     SSunk <ssunkkan@gmail.com>
Cc:     ssunkkan@gmail.com, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, miquel.raynal@bootlin.com,
        pratyush@kernel.org, richard@nod.at, tudor.ambarus@linaro.org,
        vigneshr@ti.com
Subject: Re: [PATCH] Add support for more XMC series
In-Reply-To: <20230829045600.5254-1-ssunkkan@gmail.com>
References: <2F4A4D23-1C71-42B9-8B2C-06496F773BDA@gmail.com>
 <20230829045600.5254-1-ssunkkan@gmail.com>
Message-ID: <1c04bbe2a65f13b9815ce465cc8dcdd5@walle.cc>
X-Sender: michael@walle.cc
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2023-08-29 06:56, schrieb SSunk:
>> Hi Michael,
>> Since this is the first time I've submitted code to the Linux 
>> community, please forgive me for some of the missteps that I've made.
>> I uploaded the incorrect patch file.
>> In a previous e-mail you said：
>> XMC parts seem to have SFDP tables and they should work out of the box
>> without any patches with the generic spi nor driver [1]. Therefore,
>> you don't need any entry at all.
>> 
>> I think it is related to the PARSE_SFDP flag.
>> The XMC flash part supports SFDP, so i don’t need to add 
>> NO_SFDP_FLAGS() macro.
>> drivers/mtd/spi-nor/xmc.c | 17 +++++++++++++----
>> 1 file changed, 13 insertions(+), 4 deletions(-)
>> 
>> diff --git a/drivers/mtd/spi-nor/xmc.c b/drivers/mtd/spi-nor/xmc.c
>> index 051411e86339..e78bf11792d9 100644
>> --- a/drivers/mtd/spi-nor/xmc.c
>> +++ b/drivers/mtd/spi-nor/xmc.c
>> @@ -11,11 +11,20 @@
>> static const struct flash_info xmc_nor_parts[] = {
>> 	/* XMC (Wuhan Xinxin Semiconductor Manufacturing Corp.) */
>> 	{ "XM25QH64A", INFO(0x207017, 0, 64 * 1024, 128)
>> -		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ |
>> -			      SPI_NOR_QUAD_READ) },
>> +		PARSE_SFDP },
>> 	{ "XM25QH128A", INFO(0x207018, 0, 64 * 1024, 256)
>> -		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ |
>> -			      SPI_NOR_QUAD_READ) },
>> +		PARSE_SFDP },
>> +	{ "XM25QH128C", INFO(0x204018, 0, 64 * 1024, 256)
>> +		PARSE_SFDP },
>> +	{ "XM25QH256C", INFO(0x204019, 0, 64 * 1024, 512)
>> +		PARSE_SFDP },
>> +	{ "XM25QU256C", INFO(0x204119, 0, 64 * 1024, 512)
>> +		PARSE_SFDP },
>> +	{ "XM25QH512C", INFO(0x204020, 0, 64 * 1024, 1024)
>> +		PARSE_SFDP },
>> +	{ "XM25QU512C", INFO(0x204120, 0, 64 * 1024, 1024)
>> +		PARSE_SFDP },
>> +
>> };
>> 
>> const struct spi_nor_manufacturer spi_nor_xmc = {
>>> Correct. If the flash is working with PARSE_SFDP, it has SFDP and
>>> all the information of the flash_info table is pulled from the SFDP
>>> tables, except for the part name. Therefore, you don't need any entry
>>> at all. The flash should just work out of the box. Are you using the
>>> latest kernel?
>>> 
>>> -michael
> --
> Hi Michael,
> 
> According to you, does this piece of my code still need to be modified?

You don't need it at all. The flash will work as is - that is without 
that
piece of code.

-michael
