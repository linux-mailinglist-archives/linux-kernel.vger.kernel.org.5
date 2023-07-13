Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7313475193E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 09:01:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233787AbjGMHBl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 03:01:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231431AbjGMHBg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 03:01:36 -0400
X-Greylist: delayed 86195 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 13 Jul 2023 00:01:35 PDT
Received: from mail.3ffe.de (0001.3ffe.de [159.69.201.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67D63119;
        Thu, 13 Jul 2023 00:01:35 -0700 (PDT)
Received: from 3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id 6F6D2274;
        Thu, 13 Jul 2023 09:01:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1689231693;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4KyJcPj86wpm+joAeHLW9qgmm3L3ws49NQpsZj9t5vI=;
        b=wG4HOiPI5/V1Jo2HNE4ElQjSmLJMfuVJyMb1Gt/nwycMmhv6wN+Ze/Xc6OslEkLcqMP6oi
        x5ovQuQONhXPht7KgSdBZb+unayfafqg5YV7zgSy12N2RdANEAgEAVeMHsBClNqIvbXhs3
        zwT+4wOWG4J2vCBJMdPZX/SKq6ehkxJRbZfNdOEdAyketbr5VyP5H8yASFSOHW+1C+0jUp
        GnNH6c2IrtS0EcSB+ON4JtDdy54pAtUzl+6VSzitP7zV3pVBGcEtQMhziF5u+U/aeIhFIr
        2a6I3xO/4/aTxlYxYjwnxe5zv9+o19/o/kuLqWJFKEz17TwOcceD1m9gJN5mOg==
MIME-Version: 1.0
Date:   Thu, 13 Jul 2023 09:01:33 +0200
From:   Michael Walle <michael@walle.cc>
To:     Tudor Ambarus <tudor.ambarus@linaro.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Pratyush Yadav <pratyush@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH v2] mtd: spi-nor: Correct flags for Winbond w25q128
In-Reply-To: <f00fa2ae-6d4a-90cb-3724-2bedb96cb4fb@linaro.org>
References: <20230712-spi-nor-winbond-w25q128-v2-1-50c9f1d58d6c@linaro.org>
 <f00fa2ae-6d4a-90cb-3724-2bedb96cb4fb@linaro.org>
Message-ID: <0525440a652854a2a575256cd07d3559@walle.cc>
X-Sender: michael@walle.cc
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Am 2023-07-13 05:32, schrieb Tudor Ambarus:
> Hi, Linus,
> 
> On 13.07.2023 00:59, Linus Walleij wrote:
>> The Winbond "w25q128" (actual vendor name W25Q128JV)
>> has exactly the same flags as the sibling device
>> "w25q128jv". The devices both require unlocking to
>> enable write access.
>> 
>> The actual product naming between devices vs the
>> Linux strings in winbond.c:
>> 
>> 0xef4018: "w25q128"   W25Q128JV-IM/JM
>> 0xef7018: "w25q128jv" W25Q128JV-IN/IQ/JQ
>> 
>> The latter device, "w25q128jv" supports features
>> named DTQ and QPI, otherwise it is the same.
>> 
>> Not having the right flags has the annoying side
>> effect that write access does not work.
> 
> I guess you refer to the locking flags. Probably your flash has the non
> volatile block protection (BP) bits from the Status Register set, which
> means the entire flash is write protected. The factory default for 
> these
> bits is 0/disabled on this flash so someone must have played with them.
> The reason why one may want write protection set is to avoid 
> inadvertent
> writes during power-up.
> One can control whether to disable the software write protection at 
> boot
> time with the MTD_SPI_NOR_SWP_ configs.
>> 
>> After this patch I can write to the flash on the
>> Inteno XG6846 router.
>> 
>> The flash memory also supports dual and quad SPI
>> modes. This does not currently manifest, but by
> 
> The fasted mode is chosen after SFDP parsing, so you should use quad
> reads if your controller also supports 4 I/O lines.
>> turning on SFDP parsing, the right SPI modes are
>> emitted in
>> /sys/kernel/debug/spi-nor/spi1.0/capabilities
>> for this chip, so we also turn on this.
>> 
>> Cc: stable@vger.kernel.org
>> Suggested-by: Michael Walle <michael@walle.cc>
>> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
>> ---
>> Changes in v2:
>> - Only add the write access flags.
>> - Use SFDP parsing to properly detect the various
>>   available SPI modes.
>> - Link to v1: 
>> https://lore.kernel.org/r/20230712-spi-nor-winbond-w25q128-v1-1-f78f3bb42a1c@linaro.org
>> ---
>>  drivers/mtd/spi-nor/winbond.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>> 
>> diff --git a/drivers/mtd/spi-nor/winbond.c 
>> b/drivers/mtd/spi-nor/winbond.c
>> index 834d6ba5ce70..6c82e525c801 100644
>> --- a/drivers/mtd/spi-nor/winbond.c
>> +++ b/drivers/mtd/spi-nor/winbond.c
>> @@ -121,7 +121,8 @@ static const struct flash_info winbond_nor_parts[] 
>> = {
>>  	{ "w25q80bl", INFO(0xef4014, 0, 64 * 1024,  16)
>>  		NO_SFDP_FLAGS(SECT_4K) },
>>  	{ "w25q128", INFO(0xef4018, 0, 64 * 1024, 256)
> 
> while here try, using INFO with INFO(0xef4018, 0, 0, 0), those
> parameters shall be discovered at run-time, so we prepare to get rid of
> explicitly setting them sooner or later.

This is an entry matching various flash families from Winbond, see my
reply in v1. I'm not sure we should remove these as we could break the
older ones, which might or might not have SFDP tables. We don't know.

> 
>> -		NO_SFDP_FLAGS(SECT_4K) },

Thus, I'd also keep this one.

-michael

>> +		PARSE_SFDP
>> +		FLAGS(SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB) },
> 
> Looks good. Also I would like you to run a small sanity test, just to
> make sure the flash works after your changes. You can do that with
> mtd_debug utility, see an example on Miquel's commit message from:
> https://lore.kernel.org/linux-mtd/d479489736ee193609816dc2003bd0fb@walle.cc/T/#m3550973e0884ec4a288d344fabd4a9c3b64af46e
> 
> Cheers,
> ta
