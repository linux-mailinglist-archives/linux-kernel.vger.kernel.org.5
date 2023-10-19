Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E7CA7CEE0C
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 04:27:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232153AbjJSC1Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 22:27:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjJSC1Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 22:27:24 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A288895
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 19:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=dxOjzErkh5+zOBFjAXg3fxhcdphmjj8jzIkYzk1WPo4=; b=lGaalIYZQEMesgAQnQaBGuUTdI
        8sMhhoZrEZ9xoiO5fLnqAeov1dFW2FmOmGBE80ZEDqZZVr8xQgOABwZlbIW+pYAZLil7Q/AtN1gD3
        ovYHjlg+y1YVoU2kkSjjOD6SD4cGKsO1C6jKTVfdA+rfPOh1FsgsTKdT+Ji8XAL1Ll97p3MFpcwF+
        iBt8Vj9v/rxbxdKqxRxexGqK77JWiWVIUisuHDAwOOZnHvt/5VWwDdFG3EMhnnD8CeX2pH2GaZMWj
        HUx5p77cbKOK7nCgJ3O7JDaR9/Oot0Ltu0zGQZINulHVk1+nmVPV1d/tghI2CkvxSAveEnvDPwnNP
        w8dbYStw==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qtIkr-00G8AZ-1G;
        Thu, 19 Oct 2023 02:27:21 +0000
Message-ID: <cf6950bc-32c8-459c-a4b1-ca0a291fc2f8@infradead.org>
Date:   Wed, 18 Oct 2023 19:27:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Is strncpy really less secure than strscpy ?
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        James Dutton <james.dutton@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Justin Stitt <justinstitt@google.com>,
        Calvince Otieno <calvncce@gmail.com>,
        Azeem Shaikh <azeemshaikh38@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Andy Shevchenko <andy@kernel.org>
References: <CAAMvbhG40h6pqSf91BurDHQqeoKfP30bwnpvSDRHBN4Hoygqew@mail.gmail.com>
 <ZTCLLinnaqIILXsJ@debian.me>
Content-Language: en-US
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <ZTCLLinnaqIILXsJ@debian.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/18/23 18:49, Bagas Sanjaya wrote:
> [Disclaimer: I have little to no knowledge of C, so things may be wrong.
>  Please correct me if it is the case. Also Cc: recent people who work on
>  strscpy() conversion.]
> 

Also Cc: the STRING maintainers.

> On Thu, Oct 19, 2023 at 12:22:33AM +0100, James Dutton wrote:
>> Is strncpy really less secure than strscpy ?
>>
>> If one uses strncpy and thus put a limit on the buffer size during the
>> copy, it is safe. There are no writes outside of the buffer.
>> If one uses strscpy and thus put a limit on the buffer size during the
>> copy, it is safe. There are no writes outside of the buffer.
> 
> Well, assuming that the string is NUL-terminated, the end result should
> be the same.
> 
>> But, one can fit more characters in strncpy than strscpy because
>> strscpy enforces the final \0 on the end.
>> One could argue that strncpy is better because it might save the space
>> of one char at the end of a string array.
>> There are cases where strncpy might be unsafe. For example copying
>> between arrays of different sizes, and that is a case where strscpy
>> might be safer, but strncpy can be made safe if one ensures that the
>> size used in strncpy is the smallest of the two different array sizes.
> 
> Code example on both cases?
> 
>>
>> If one blindly replaces strncpy with strscpy across all uses, one
>> could unintentionally be truncating the results and introduce new
>> bugs.
>>
>> The real insecurity surely comes when one tries to use the string.
>> For example:
>>
>> #include <stdio.h>
>> #include <string.h>
>>
>> int main() {
>>         char a[10] = "HelloThere";
>>         char b[10];
>>         char c[10] = "Overflow";
>>         strncpy(b, a, 10);
>>         /* This overflows and so in unsafe */
>>         printf("a is  %s\n", a);
>>         /* This overflows and so in unsafe */
>>         printf("b is  %s\n", b);
>>         /* This is safe */
>>         printf("b is  %.*s\n", 10, a);
>>         /* This is safe */
>>         printf("b is  %.*s\n", 4, a);
>>         return 0;
>> }
> 
> What if printf("a is  %.*s\n", a);?
> 

>>
>>
>> So, why isn't the printk format specifier "%.*s" used more instead of
>> "%s" in the kernel?
> 
> Since basically strings are pointers.
> 
> Thanks.
> 

-- 
~Randy
