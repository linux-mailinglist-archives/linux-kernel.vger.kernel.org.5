Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6718578E6AF
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 08:41:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243597AbjHaGlP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 02:41:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231905AbjHaGlK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 02:41:10 -0400
Received: from mail.3ffe.de (0001.3ffe.de [159.69.201.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60E8FA8
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 23:41:05 -0700 (PDT)
Received: from 3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id 0C24B30A;
        Thu, 31 Aug 2023 08:41:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1693464063;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0qlSvXs72kihayFUUjvnu+kLjorvIfsIcAxoti/RKzE=;
        b=aFV6oVgTw5GVt4vQrfNy1/y3LH+ddTydLGMJ4Q7XwyoYCdZXSVW/iFOFGp9NJoT098VstI
        MdlApVahHGk0shS3derZotrCHvA/U6X5b7/cTupVZWwB+4OsIplUFADNnJwzjZW9bp+aWH
        Sv2NepLDfqrJma7uZDUj+A1NL6Exjo3gdo/aA3sxC8zBprU38OJGHxhNQWR7KsxavYzK3t
        X+TRzLBXMx7FfSkN2Jd1MZ7aiZIyOoJbieKSVolVm7b2ojaKznNlUI/dbtTwTheXZCX0/9
        oqgUYCqW9YJGL6EyXuxH2q/Yy8QxbCFaknXH3BltgrHf6BSmNtzPi79zORry9Q==
MIME-Version: 1.0
Date:   Thu, 31 Aug 2023 08:41:02 +0200
From:   Michael Walle <michael@walle.cc>
To:     SSunk <ssunkkan@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        miquel.raynal@bootlin.com, pratyush@kernel.org, richard@nod.at,
        ssunkkan@gmail.com, tudor.ambarus@linaro.org, vigneshr@ti.com
Subject: Re: [PATCH] Add support for more XMC series
In-Reply-To: <20230831041344.4653-1-ssunkkan@gmail.com>
References: <1c04bbe2a65f13b9815ce465cc8dcdd5@walle.cc>
 <20230831041344.4653-1-ssunkkan@gmail.com>
Message-ID: <c7b200d180278b43ddf8e1f870c846df@walle.cc>
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

Hi,

>>>> Since this is the first time I've submitted code to the Linux
>>>> community, please forgive me for some of the missteps that I've 
>>>> made.
>>>> I uploaded the incorrect patch file.
>>>> In a previous e-mail you said：
>>>> XMC parts seem to have SFDP tables and they should work out of the 
>>>> box
>>>> without any patches with the generic spi nor driver [1]. Therefore,
>>>> you don't need any entry at all.
>>>> 
>>>> I think it is related to the PARSE_SFDP flag.
>>>> The XMC flash part supports SFDP, so i don’t need to add
>>>> NO_SFDP_FLAGS() macro.
>>>> drivers/mtd/spi-nor/xmc.c | 17 +++++++++++++----
>>>> 1 file changed, 13 insertions(+), 4 deletions(-)
>>>> 
>>>> diff --git a/drivers/mtd/spi-nor/xmc.c b/drivers/mtd/spi-nor/xmc.c
>>>> index 051411e86339..e78bf11792d9 100644
>>>> --- a/drivers/mtd/spi-nor/xmc.c
>>>> +++ b/drivers/mtd/spi-nor/xmc.c
>>>> @@ -11,11 +11,20 @@
>>>> static const struct flash_info xmc_nor_parts[] = {
>>>> 	/* XMC (Wuhan Xinxin Semiconductor Manufacturing Corp.) */
>>>> 	{ "XM25QH64A", INFO(0x207017, 0, 64 * 1024, 128)
>>>> -		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ |
>>>> -			      SPI_NOR_QUAD_READ) },
>>>> +		PARSE_SFDP },
>>>> 	{ "XM25QH128A", INFO(0x207018, 0, 64 * 1024, 256)
>>>> -		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ |
>>>> -			      SPI_NOR_QUAD_READ) },
>>>> +		PARSE_SFDP },
>>>> +	{ "XM25QH128C", INFO(0x204018, 0, 64 * 1024, 256)
>>>> +		PARSE_SFDP },
>>>> +	{ "XM25QH256C", INFO(0x204019, 0, 64 * 1024, 512)
>>>> +		PARSE_SFDP },
>>>> +	{ "XM25QU256C", INFO(0x204119, 0, 64 * 1024, 512)
>>>> +		PARSE_SFDP },
>>>> +	{ "XM25QH512C", INFO(0x204020, 0, 64 * 1024, 1024)
>>>> +		PARSE_SFDP },
>>>> +	{ "XM25QU512C", INFO(0x204120, 0, 64 * 1024, 1024)
>>>> +		PARSE_SFDP },
>>>> +
>>>> };
>>>> 
>>>> const struct spi_nor_manufacturer spi_nor_xmc = {
>>>>> Correct. If the flash is working with PARSE_SFDP, it has SFDP and
>>>>> all the information of the flash_info table is pulled from the SFDP
>>>>> tables, except for the part name. Therefore, you don't need any 
>>>>> entry
>>>>> at all. The flash should just work out of the box. Are you using 
>>>>> the
>>>>> latest kernel?
>>>>> 
>>>>> -michael
>>> --
>>> Hi Michael,
>>> 
>>> According to you, does this piece of my code still need to be 
>>> modified?
>> 
>> You don't need it at all. The flash will work as is - that is without
>> that
>> piece of code.
>> 
>> -michael
> --
> Hi michael,
> 
> If these entries are not added, the flash part name is unknown and our 
> customers
> cannot see our flash part name on the kernel log.
> So,I think it's necessary to add these entries.

They can still see the jedec id in the sysfs. We don't add entries just 
for the
names. Sorry.

-michael
