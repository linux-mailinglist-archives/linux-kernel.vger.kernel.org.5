Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C303757404
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 08:25:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230313AbjGRGZo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 02:25:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbjGRGZn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 02:25:43 -0400
Received: from mail.3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFB9E126;
        Mon, 17 Jul 2023 23:25:41 -0700 (PDT)
Received: from 3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id C07D23C3;
        Tue, 18 Jul 2023 08:25:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1689661539;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vwy+Rk+DpWgKqRl/5W9li4fim9nVcS+KSVDMqOOga0w=;
        b=ZFlYDESTV91bDpjpp/nK4NchulbycORk27MdDVBlJYrImYDMQzO2LmWhfX9jveUYMvi+EZ
        /hoPhwCsC9r6JH60O1UT2Un4xvhfiR66BznPTLZm/tjfVdtQtWKmEaIE3OceRqPoUlrh+N
        Kyb/UsbP45UCgllP2HCzY1VouJ/0uN+4v/BiWNpdOzBFabBlYyWtNgHmvYIEWf4hSQPykG
        ae9lPqXmd2FFFotC3p3qvyyPuw8deil5/guhRGKFtgEybwzP1SzKidgLiWCJ0xxVj6IefX
        /TrnE9bVQKjbD/0GrSNEJD7n16e8oExEGD2RFaFbfnoWf9ah/bitQnJVjF4eTQ==
MIME-Version: 1.0
Date:   Tue, 18 Jul 2023 08:25:39 +0200
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
In-Reply-To: <d99d87e7-47ba-d6fe-735f-16de2a2ec280@linaro.org>
References: <20230712-spi-nor-winbond-w25q128-v2-1-50c9f1d58d6c@linaro.org>
 <f00fa2ae-6d4a-90cb-3724-2bedb96cb4fb@linaro.org>
 <0525440a652854a2a575256cd07d3559@walle.cc>
 <d99d87e7-47ba-d6fe-735f-16de2a2ec280@linaro.org>
Message-ID: <e642ff27fd0bc0f1f0e293972145f680@walle.cc>
X-Sender: michael@walle.cc
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

>>> while here try, using INFO with INFO(0xef4018, 0, 0, 0), those
>>> parameters shall be discovered at run-time, so we prepare to get rid 
>>> of
>>> explicitly setting them sooner or later.
>> 
>> This is an entry matching various flash families from Winbond, see my
>> reply in v1. I'm not sure we should remove these as we could break the
>> older ones, which might or might not have SFDP tables. We don't know.
> 
> I'd take the risk and break the older ones if there are some that don't
> define SFDP indeed, just to handle the conflict properly. We can't
> encourage code based on assumptions otherwise we'll get back to the
> knotted spi-nor code that we tried to untie in the last years.

Wait a minute, now I'm the more conservative one of the both of
us? (:

Jokes aside, basically you are saying that if there are two flashes
with the same id, one supports JEDEC one doesn't, we can brake the
latter one.

>>>> -        NO_SFDP_FLAGS(SECT_4K) },
>> 
>> Thus, I'd also keep this one.
>> 
> 
> Keeping this one does not have the effect that you want as SECT_4K is
> used in spi_nor_no_sfdp_init_params() which is not called when
> PARSE_SFDP is set, which makes perfectly sense. Let's drop this and if
> bugs will be reported, I commit I'll fix them in the same release 
> cycle.

Mhh, I should have been more curious to why Linus needed the PARSE_SFDP
flag in the first place. Taking a closer look, that is because in the
legacy behavior, the SFDP is only read if the chip supports dual or
quad read (whatever the rationale was for that).

Also, if PARSE_SFDP is set, none of the no_sfdp_flags are ever handled.
If the chip doesn't support the SFDP is will just fail probing.

As I'm reading the code right now, for the new behavior
it is either
  * expect the flash supports SFDP, if not, probe fails
  * expect the flash to don't support SFDP, no SFDP is ever read at all

Shouldn't we handle the third case in the new behavior, too:
  * start with the static data we have and try reading SFDP to 
amend/correct it.

If not, will you accept breakage for future flashes, too? Looking at 
winbond.c
for example, I guess all chips with 0xef40.. 0xef50.. and 0xef60.. 
supports
SFDP nowadays and most of them only have SECT_4K set.

> If both of you agree, I'll amend Linus's v4 patch when applying.

So it would be the first chip without flags at all? Then we could
drop the entry entirely :) And if we do this, then we should also
drop all the other entries for the newer winbond flashes.

If you decide to break older flashes, then I'd prefer to also drop
the n_sectors and sector_size, i.e. INFO(0xef...., 0, 0, 0).

-michael
