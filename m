Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 523E5757698
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 10:33:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231713AbjGRIdF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 04:33:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231695AbjGRIc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 04:32:59 -0400
Received: from mail.3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8BA91725;
        Tue, 18 Jul 2023 01:32:41 -0700 (PDT)
Received: from 3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id C0E71126;
        Tue, 18 Jul 2023 10:32:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1689669159;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v4SBXoVwuzLZBjyBRWdVUzfBu7mTaGP8lodd6f21ilk=;
        b=GLlwLbLUrdFeCqJ7kKhU1jMXQq9lYv+sVjOXbUz/X4v2NXz+pVjy/KynohNRGSD/U9n1qH
        y4ksz0MuaD+NS5StRfCcVrbIjXxLwzne2AbaxeHUwL2l5ilnL9GqVDZBpVU2p9mhgM2WmR
        EPbqsc2B9V4Vl832ejXLMQrUaKP42ipBkGJst6awN7TcDO44cFIZN6zLRsyuf6evKV3O53
        MjdXn46moZmMKtyoGgefaiT+6pCEEcKONJlIkSKdTQteFz9q42+3X/28G356/+qcpSEeBa
        TE0qmwHX4Xhm74wWR1HE7zLxuVd0R+asM0xzZCdY4Ne/DaGMZuLGd5egQ77GBg==
MIME-Version: 1.0
Date:   Tue, 18 Jul 2023 10:32:39 +0200
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
In-Reply-To: <2d71326c-023e-69af-9337-62672f50fed9@linaro.org>
References: <20230712-spi-nor-winbond-w25q128-v2-1-50c9f1d58d6c@linaro.org>
 <f00fa2ae-6d4a-90cb-3724-2bedb96cb4fb@linaro.org>
 <0525440a652854a2a575256cd07d3559@walle.cc>
 <d99d87e7-47ba-d6fe-735f-16de2a2ec280@linaro.org>
 <e642ff27fd0bc0f1f0e293972145f680@walle.cc>
 <2d71326c-023e-69af-9337-62672f50fed9@linaro.org>
Message-ID: <62083227d40d7b631c2eeac1e40c6b56@walle.cc>
X-Sender: michael@walle.cc
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> Jokes aside, basically you are saying that if there are two flashes
>> with the same id, one supports JEDEC one doesn't, we can brake the
>> latter one.
> 
> I say I don't want to suffocate the code based on assumptions and I'm 
> ready
> to take the risk and break some presumably old flashes that don't 
> support
> SFDP. If we know for sure that we break old variants of this flash ID,
> then we have to rework the core now. Otherwise I'll rework it when a 
> bug
> is reported.

Ok, fair enough.

>>>>>> -        NO_SFDP_FLAGS(SECT_4K) },
>>>> 
>>>> Thus, I'd also keep this one.
>>>> 
>>> 
>>> Keeping this one does not have the effect that you want as SECT_4K is
>>> used in spi_nor_no_sfdp_init_params() which is not called when
>>> PARSE_SFDP is set, which makes perfectly sense. Let's drop this and 
>>> if
>>> bugs will be reported, I commit I'll fix them in the same release 
>>> cycle.
>> 
>> Mhh, I should have been more curious to why Linus needed the 
>> PARSE_SFDP
>> flag in the first place. Taking a closer look, that is because in the
>> legacy behavior, the SFDP is only read if the chip supports dual or
>> quad read (whatever the rationale was for that).
> 
> dual or quad reads are params that could be discovered in the first 
> version of
> SFDP, that why they associated them with reading SFDP. Not great, but 
> it
> worked.
> 
>> 
>> Also, if PARSE_SFDP is set, none of the no_sfdp_flags are ever 
>> handled.
>> If the chip doesn't support the SFDP is will just fail probing.
>> 
>> As I'm reading the code right now, for the new behavior
>> it is either
>>  * expect the flash supports SFDP, if not, probe fails
>>  * expect the flash to don't support SFDP, no SFDP is ever read at all
>> 
> 
> sort of. It's more elaborate than that. Check spi_nor_init_params().

I had checked that. And there is either parse_sfdp = true, which will
fail if SFDP is not available - or SPI_NOR_SKIP_SFDP, which won't handle
SFDP at all. And then there is the third case which will handle legacy
behavior. So what am I missing? )

>> Shouldn't we handle the third case in the new behavior, too:
>>  * start with the static data we have and try reading SFDP to 
>> amend/correct it.
> 
> This case is already supported and it's the old way of initializing 
> flash
> parameters. Check spi_nor_init_params_deprecated().

But it's not encouraged for new flashes and it doesn't work. Otherwise
we wouldn't have a problem here. It (suprisingly!) only parses SFDP
if the dual or quad flags are set.

> I don't want to do that for the SFDP capable flashes for now, otherwise
> we'll have again parameters initialized all over the place, which 
> results
> in ugly hard to read code. You have the fixup hooks if you need to 
> amend SFDP
> data. And since the first table of SFDP is mandatory (BFPT), if you set 
> PARSE_SFDP
> and get an error, then you shouldn't have set PARSE_SFDP in the first 
> place.

Unless of course there are flashes with the same id where one supports
SFDP and another don't. But as you said, we can handle that one if there
is actual breakage. I'm fine with that.

> Optional SFDP tables return void and we have a rollback mechanism for 
> the parameters
> set in those optional tables in case of errors.
> 
>> 
>> If not, will you accept breakage for future flashes, too? Looking at 
>> winbond.c
>> for example, I guess all chips with 0xef40.. 0xef50.. and 0xef60.. 
>> supports
>> SFDP nowadays and most of them only have SECT_4K set.
> 
> I will. Note that you have to actually have a physical flash to do 
> changes,
> I don't queue untested patches.
> 
>> 
>>> If both of you agree, I'll amend Linus's v4 patch when applying.
>> 
>> So it would be the first chip without flags at all? Then we could
>> drop the entry entirely :) And if we do this, then we should also
> 
> No, you have the locking flags that can't be discovered by parsing 
> SFDP,
> thus you need to define a flash entry for it.

Ah, right, they were added :)

>> drop all the other entries for the newer winbond flashes.
> 
> If you can test it, and there's no dedicated compatible for that flash,
> I'm ok to drop them.

I've had a look at the dedicated compatibles, too. They are only needed
for the spi core to probe. But if I read the code correctly, it should
work just fine with the generic driver (even if it is probed by
name). Right?

>> 
>> If you decide to break older flashes, then I'd prefer to also drop
>> the n_sectors and sector_size, i.e. INFO(0xef...., 0, 0, 0).
>> 
> 
> Isn't v4 already doing this? I'll amend it if not. Waiting for ack from
> both you and Linus.

FWIW, I'm fine with the removed no_sfdp_flags if INFO(, 0, 0, 0).

-michael
