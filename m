Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8384D79296E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 18:52:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352019AbjIEQ0b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:26:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354881AbjIEP2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 11:28:09 -0400
Received: from smtp.smtpout.orange.fr (smtp-22.smtpout.orange.fr [80.12.242.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E40E2198
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 08:28:04 -0700 (PDT)
Received: from [10.29.1.31] ([109.190.253.13])
        by smtp.orange.fr with ESMTPA
        id dXyDqPWxLyoREdXyDqwvbI; Tue, 05 Sep 2023 17:28:02 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1693927682;
        bh=d/5mhBQg/8h+vLPk2GvgxBrqZ4+T0NEJqgvtXCgV7nI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=RMCCviBYRg/3CvCQfZngp6lLg7T61oe7y5gjxgNfYJw+KlMCqW6G08Up8TXAD/9rA
         VsOHJYGXyv9JMF+c5zT+hr/otlX3vtpzWk8k7NQt+EzxGvaB6zFGxs4YXIo+p8pkZi
         mQMCDqzSKm2nMoy6NSQVGSww6e9Uc5eSGf6Uzan3prdC83eYR0aZnUtZDjIWESCDHo
         xpXi24dag+Sv3f4SuqJFPTFML0Dm8JPWm30O7Qf6Yctz9jkFYGb6xr4coGRQmxtsHp
         I7Zgq2PZICSsj0RTNUfPVG2+e5iOEzs95tndH8zXZAqbJ/ofLiXlmpi5U0+n5SIXkm
         ++W8qnmmWoffw==
X-ME-Helo: [10.29.1.31]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Tue, 05 Sep 2023 17:28:02 +0200
X-ME-IP: 109.190.253.13
Message-ID: <9150d691-49b8-c102-a5de-d1fa207d61ed@wanadoo.fr>
Date:   Tue, 5 Sep 2023 17:28:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] ata: sata_mv: Fix incorrect string length computation in
 mv_dump_mem()
Content-Language: en-US
To:     Damien Le Moal <dlemoal@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-ide@vger.kernel.org
References: <1a35e114a3dcc33053ca7cca41cb06b8426d8c40.1693857262.git.christophe.jaillet@wanadoo.fr>
 <b5dcc85d-f709-a3a3-e7ad-9c71f278842a@kernel.org>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <b5dcc85d-f709-a3a3-e7ad-9c71f278842a@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 05/09/2023 à 07:04, Damien Le Moal a écrit :
> On 9/5/23 04:54, Christophe JAILLET wrote:
>> snprintf() returns the "number of characters which *would* be generated for
>> the given input", not the size *really* generated.
>>
>> In order to avoid too large values for 'o' (and potential negative values
>> for "sizeof(linebuf) o") use scnprintf() instead of snprintf().
>>
>> Note that given the "w < 4" in the for loop, the buffer can NOT
>> overflow, but using the *right* function is always better.
>>
>> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> 
> Doesn't this need Fixes and CC stable tags ?

I don't think so.
As said in the commit message :
    Note that given the "w < 4" in the for loop, the buffer can NOT
    overflow, but using the *right* function is always better.

linebuf is 38 chars.
In each iteration, we write 9 bytes + NULL.
We write only 4 elements per line (because of w < 4), so 9 * 4 + 1 = 37 
bytes are needed.
9 is for %08x<space>

It can't overflow.
Moreover, it is really unlikely that the size of linebuf or the number 
of elements on each line change in a stable kernel.

So, from my POV, this patch is more a clean-up than anything else.

I would even agree that it is maybe not even needed. But should someone 
cut'n'paste it one day, then using the correct function could maybe help 
him.

CJ

> 
>> ---
>>   drivers/ata/sata_mv.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
>> index d105db5c7d81..45e48d653c60 100644
>> --- a/drivers/ata/sata_mv.c
>> +++ b/drivers/ata/sata_mv.c
>> @@ -1255,8 +1255,8 @@ static void mv_dump_mem(struct device *dev, void __iomem *start, unsigned bytes)
>>   
>>   	for (b = 0; b < bytes; ) {
>>   		for (w = 0, o = 0; b < bytes && w < 4; w++) {
>> -			o += snprintf(linebuf + o, sizeof(linebuf) - o,
>> -				      "%08x ", readl(start + b));
>> +			o += scnprintf(linebuf + o, sizeof(linebuf) - o,
>> +				       "%08x ", readl(start + b));
>>   			b += sizeof(u32);
>>   		}
>>   		dev_dbg(dev, "%s: %p: %s\n",
> 
