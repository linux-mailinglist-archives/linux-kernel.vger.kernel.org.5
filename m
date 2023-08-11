Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5764E7790CC
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 15:31:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234867AbjHKNbH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 09:31:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjHKNbF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 09:31:05 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE8EC26A0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 06:31:04 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-99bdf08860dso656871566b.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 06:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google; t=1691760663; x=1692365463;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jyuu8MZR8xDTvM5cCyqf+eqxfCOwPyGgKAn2hxG/Pvc=;
        b=W083Mp1pkYP/1RaRAKV91kwwy9R90tBP4XY/bdRnll7APUx6WrF3nwP9nps/9mSo70
         r8dFJoNg5BLqXEIolNCyTPHVi5dc7ia38d0VXJQyoVzA7YKaknqQrIlTpOh/eg2o3Vxc
         VfGswdgfa55KzOC5ykQGGKWMNUi2uP5PiuiGU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691760663; x=1692365463;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jyuu8MZR8xDTvM5cCyqf+eqxfCOwPyGgKAn2hxG/Pvc=;
        b=fPmAsc+HV5tq0qRftheGrDxWwd2k9Pe4oNFsyR+4qs1uoQIJBnen/tExeV5nCtNAl7
         zHOCfWv2mWnzFAnOq6n0l0kOoUqjxlSUEl+0JjUBgdgRwVPrN4QQhBOC/DSXXwdyCg96
         CNS9LJWIhIc+wQXFnGQlViI5nQ9z8RZLGgK8/4LNKJbTJFBcFzRNG4eeScyiJBpqQ+Bg
         c/dbp1hNFvF+Si8J3mRAZS0n6rwPKAFG9YWiXhPvse2HkJTDGtVIRUqKRObWqNNS0zTP
         oPC4IBQ5Ai45nW+0PQFeu4ozsyBjep4wW9h4mGXU885KD4/MH6KXRyxk+4jcnr/xBdGT
         TNew==
X-Gm-Message-State: AOJu0YwlAjiEz79FpL9dz7hScyttCskKCzoPfNBKbHP4caUacSSkS63J
        +KkVjfW9lo1AkOJNnkjUcdbcc0ofGg1a24OSSs0d2g==
X-Google-Smtp-Source: AGHT+IE9YI7kKkE9XNP7jv2CWlbeVk2KacfUuatwhdKcqHX/el1DhemqmGuWpqRy1MyVVi3d7u+FYQ==
X-Received: by 2002:a17:907:7f8b:b0:99c:c794:8ce0 with SMTP id qk11-20020a1709077f8b00b0099cc7948ce0mr7533819ejc.4.1691760662978;
        Fri, 11 Aug 2023 06:31:02 -0700 (PDT)
Received: from [172.16.11.116] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id f4-20020a170906824400b0098ec690e6d7sm2270587ejx.73.2023.08.11.06.31.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Aug 2023 06:31:02 -0700 (PDT)
Message-ID: <d81ee557-74b1-6ed9-e806-d8e0865e40f0@rasmusvillemoes.dk>
Date:   Fri, 11 Aug 2023 15:31:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 2/6] bitmap: replace _reg_op(REG_OP_ALLOC) with
 bitmap_set()
Content-Language: en-US, da
To:     Yury Norov <yury.norov@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <20230811005732.107718-1-yury.norov@gmail.com>
 <20230811005732.107718-3-yury.norov@gmail.com>
 <25deb65e-a8f3-957b-9e4f-759604111d50@rasmusvillemoes.dk>
 <ZNYv4pt4HBUBZA60@yury-ThinkPad>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
In-Reply-To: <ZNYv4pt4HBUBZA60@yury-ThinkPad>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/08/2023 14.56, Yury Norov wrote:
> On Fri, Aug 11, 2023 at 08:21:33AM +0200, Rasmus Villemoes wrote:
>> On 11/08/2023 02.57, Yury Norov wrote:
>>> _reg_op(REG_OP_ALLOC) duplicates bitmap_set(). Fix it.
>>>
>>> Signed-off-by: Yury Norov <yury.norov@gmail.com>
>>> ---
>>>  lib/bitmap.c | 5 ++++-
>>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/lib/bitmap.c b/lib/bitmap.c
>>> index 3a589016f5e0..c9afe704fe4b 100644
>>> --- a/lib/bitmap.c
>>> +++ b/lib/bitmap.c
>>> @@ -1352,9 +1352,12 @@ EXPORT_SYMBOL(bitmap_release_region);
>>>   */
>>>  int bitmap_allocate_region(unsigned long *bitmap, unsigned int pos, int order)
>>>  {
>>> +	unsigned int nbits = pos + BIT(order);
>>> +
>>
>> That really doesn't sound right. Have you added self-tests for these
>> functions first and then used those to catch regressions?
> 
> When bitmap_allocate_region() is broken, almost every arch build fails
> to boot. Can you explain what exactly looks wrong to you?

The number of bits we are about to set should not be [position in bitmap
to start from] + [2^order]. The second half of that patch was

-	return __reg_op(bitmap, pos, order, REG_OP_ALLOC);
+	bitmap_set(bitmap, pos, nbits);
+	return 0;

so instead of setting 1<<nbits starting at pos, you're now setting
pos+(1<<nbits) starting at pos. How is that correct?

Rasmus

