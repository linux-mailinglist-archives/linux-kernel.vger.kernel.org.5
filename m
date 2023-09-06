Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55007793330
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 03:11:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237343AbjIFBLm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 21:11:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233453AbjIFBLj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 21:11:39 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE1351B3;
        Tue,  5 Sep 2023 18:11:30 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 190E1C433C8;
        Wed,  6 Sep 2023 01:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693962690;
        bh=38UssaFaZayoI6U5IKOuuqMDBMRrzSnz5dYgB67NSgU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=j20KuZXTsaK8/J0L8XFI2WZzTIQA9xmOaYcwLjFEKXt11i0hL6oGmBSY9bEqrWA85
         qFwheqExwYq6Ha8JneprLQtawh9IkicZFRv7Pu+MLY1vEoMG6S67xn7Iyj7/yRFKLt
         zZVml6kI2+cpZ/BU5QbOK2rajMedYOLi78N+8cabhQR4nhl6+HHA6q8D+kLsloQein
         FK8XbeNtjnNkekYFBplGxZ5d2s+HzZh0kPBGdiHGLf2ReCxoblN5vScLEyvy6I9MJJ
         nx1/klWninffswbDEs2st0jXUe6danoROz2YWMUN0z2J3TlyBTb/swy8CRYLpHsoOA
         u1rl4cIq6nD9Q==
Message-ID: <3b7f0d1d-57ec-7870-fc6e-0449e3112461@kernel.org>
Date:   Wed, 6 Sep 2023 10:11:29 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] ata: sata_mv: Fix incorrect string length computation in
 mv_dump_mem()
Content-Language: en-US
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-ide@vger.kernel.org
References: <1a35e114a3dcc33053ca7cca41cb06b8426d8c40.1693857262.git.christophe.jaillet@wanadoo.fr>
 <b5dcc85d-f709-a3a3-e7ad-9c71f278842a@kernel.org>
 <9150d691-49b8-c102-a5de-d1fa207d61ed@wanadoo.fr>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <9150d691-49b8-c102-a5de-d1fa207d61ed@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/6/23 00:28, Christophe JAILLET wrote:
> 
> 
> Le 05/09/2023 à 07:04, Damien Le Moal a écrit :
>> On 9/5/23 04:54, Christophe JAILLET wrote:
>>> snprintf() returns the "number of characters which *would* be generated for
>>> the given input", not the size *really* generated.
>>>
>>> In order to avoid too large values for 'o' (and potential negative values
>>> for "sizeof(linebuf) o") use scnprintf() instead of snprintf().
>>>
>>> Note that given the "w < 4" in the for loop, the buffer can NOT
>>> overflow, but using the *right* function is always better.
>>>
>>> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>>
>> Doesn't this need Fixes and CC stable tags ?
> 
> I don't think so.
> As said in the commit message :
>     Note that given the "w < 4" in the for loop, the buffer can NOT
>     overflow, but using the *right* function is always better.
> 
> linebuf is 38 chars.
> In each iteration, we write 9 bytes + NULL.
> We write only 4 elements per line (because of w < 4), so 9 * 4 + 1 = 37 
> bytes are needed.
> 9 is for %08x<space>
> 
> It can't overflow.
> Moreover, it is really unlikely that the size of linebuf or the number 
> of elements on each line change in a stable kernel.
> 
> So, from my POV, this patch is more a clean-up than anything else.
> 
> I would even agree that it is maybe not even needed. But should someone 
> cut'n'paste it one day, then using the correct function could maybe help 
> him.

OK. Fine. But then maybe the patch title should be something like "Improve
string length computation in mv_dump_mem()" as the "Fix" word you used seems to
be somewhat misleading. With the patch title as is, the stable bot will likely
pick up that patch for stable. Fine with me, unless you see an issue with that.

> 
> CJ
> 
>>
>>> ---
>>>   drivers/ata/sata_mv.c | 4 ++--
>>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
>>> index d105db5c7d81..45e48d653c60 100644
>>> --- a/drivers/ata/sata_mv.c
>>> +++ b/drivers/ata/sata_mv.c
>>> @@ -1255,8 +1255,8 @@ static void mv_dump_mem(struct device *dev, void __iomem *start, unsigned bytes)
>>>   
>>>   	for (b = 0; b < bytes; ) {
>>>   		for (w = 0, o = 0; b < bytes && w < 4; w++) {
>>> -			o += snprintf(linebuf + o, sizeof(linebuf) - o,
>>> -				      "%08x ", readl(start + b));
>>> +			o += scnprintf(linebuf + o, sizeof(linebuf) - o,
>>> +				       "%08x ", readl(start + b));
>>>   			b += sizeof(u32);
>>>   		}
>>>   		dev_dbg(dev, "%s: %p: %s\n",
>>

-- 
Damien Le Moal
Western Digital Research

