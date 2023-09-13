Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A06179EC3C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 17:13:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240124AbjIMPNT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 11:13:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230254AbjIMPNR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 11:13:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 72B11BD
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 08:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694617952;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Uje044vKCrnPM/zlrRSYe7sHyJsaq71H01/FgvMXUZI=;
        b=IkYW2CX2lngfd15Q7LWn7hbrGk+JPTFWxfBiS9EJd0QfQ1q+2M8BgbFdlJAYVy0b+Kh9ol
        8H+F1O0H57PBOdKPNEIv3Pi3uV16OoDdgbLkDxIrmvY821wrk9hi5wl8EOA8eo4XSLLztp
        5e/SqcXHKy1xMgqZCwbtROnODmgnW3Q=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-83-5EAEMyI_NRyYoMFWiqDSBA-1; Wed, 13 Sep 2023 11:12:31 -0400
X-MC-Unique: 5EAEMyI_NRyYoMFWiqDSBA-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-52f947d0116so1628159a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 08:12:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694617950; x=1695222750;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Uje044vKCrnPM/zlrRSYe7sHyJsaq71H01/FgvMXUZI=;
        b=Uk/Sq41yMj1+tzIBUr2bLcIyLa9Iw9WwIC/YW7lRfA9C0GlQ0KNFcSVQvgYB2GiWYC
         /0D0iemJkNiDl2j/7567yjkM0HEQj2SFpXpFiyeAxp/KdaxIiHC1M90TU/4gaDskrLmY
         Iu9HqeG/pLUKpUXLcCWjp7K9OGEOdpxIKLe/yWLIGibWdKcSVdW9mIVRJXd0AnakGs6c
         ClRYa8FxA4psuVSlK/Bzk356NEH7KQWAIJrHDQmFefVy0psMiLj4C+HTQ0OpuainmzFE
         I8yRyfIQr/jT08z8n3yD5Z1dr0GqPR/ig9Jk4vcCsS7YRYEvVFphTQPW6ELDD1Djvcxk
         K/Ag==
X-Gm-Message-State: AOJu0Ywjvaw9ATrOzKjeL7CuuCuN+bif08MnZpGLt7XF3yD1cryDec5H
        K6wxJ4sZif4bbxS7Ss4fewEJrt/9RYSWl76KGTquZ0uWFD4PO6gIwBn+V5T8R9P9SBGxvaXHCHb
        798PzSodCXp2LyDS1VB79S8ZI
X-Received: by 2002:aa7:d84f:0:b0:52e:8973:6482 with SMTP id f15-20020aa7d84f000000b0052e89736482mr2590386eds.6.1694617950039;
        Wed, 13 Sep 2023 08:12:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF9W94WOA+QNkki6iu4CpuHL6ub+g/xneEY+b2v79vj2GRXp0yOurmJtg+W9pf3JYjgWYoRRg==
X-Received: by 2002:aa7:d84f:0:b0:52e:8973:6482 with SMTP id f15-20020aa7d84f000000b0052e89736482mr2590367eds.6.1694617949672;
        Wed, 13 Sep 2023 08:12:29 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id b8-20020aa7cd08000000b0052595b17fd4sm7366564edw.26.2023.09.13.08.12.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Sep 2023 08:12:29 -0700 (PDT)
Message-ID: <953f2e40-7b0e-27b5-b017-a1ac2175bb47@redhat.com>
Date:   Wed, 13 Sep 2023 17:12:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3] x86/platform/uv: refactor deprecated strcpy and
 strncpy
Content-Language: en-US, nl
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Justin Stitt <justinstitt@google.com>,
        Steve Wahl <steve.wahl@hpe.com>,
        Mike Travis <mike.travis@hpe.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
References: <20230905-strncpy-arch-x86-platform-uv-uv_nmi-v3-1-3efd6798b569@google.com>
 <ZPhsSzHG6YMViOSk@gmail.com>
 <bce762af-0da7-bb5e-1580-b42803c183f6@redhat.com>
 <ZPiH/ds9oeimXDdb@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <ZPiH/ds9oeimXDdb@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 9/6/23 16:09, Ingo Molnar wrote:
> 
> * Hans de Goede <hdegoede@redhat.com> wrote:
> 
>> Hi Ingo,
>>
>> On 9/6/23 14:10, Ingo Molnar wrote:
>>>
>>> * Justin Stitt <justinstitt@google.com> wrote:
>>>
>>>> Both `strncpy` and `strcpy` are deprecated for use on NUL-terminated
>>>> destination strings [1].
>>>>
>>>> We can see that `arg` and `uv_nmi_action` are expected to be
>>>> NUL-terminated strings due to their use within `strcmp()` and format
>>>> strings respectively.
>>>>
>>>> With this in mind, a suitable replacement is `strscpy` [2] due to the
>>>> fact that it guarantees NUL-termination on its destination buffer
>>>> argument which is _not_ the case for `strncpy` or `strcpy`!
>>>>
>>>> In this case, we can drop both the forced NUL-termination and the `... -1` from:
>>>> |       strncpy(arg, val, ACTION_LEN - 1);
>>>> as `strscpy` implicitly has this behavior.
>>>>
>>>> Link: www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings[1]
>>>> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
>>>> Link: https://github.com/KSPP/linux/issues/90
>>>> Cc: linux-hardening@vger.kernel.org
>>>> Signed-off-by: Justin Stitt <justinstitt@google.com>
>>>
>>>>  arch/x86/platform/uv/uv_nmi.c | 7 +++----
>>>>  1 file changed, 3 insertions(+), 4 deletions(-)
>>>
>>> Note that this commit is already upstream:
>>>
>>>   1e6f01f72855 ("x86/platform/uv: Refactor code using deprecated strcpy()/strncpy() interfaces to use strscpy()")
>>>
>>> Below is the delta your v3 patch has compared to what is upstream - is it 
>>> really necessary to open code it, instead of using strnchrnul() as your 
>>> original patch did? Am I missing anything here?
>>
>> The new version is a result of a review from my because IMHO:
>>
>> 	strscpy(arg, val, strnchrnul(val, sizeof(arg)-1, '\n') - val + 1);
>>
>> Is really unreadable / really hard to reason about if
>> this is actually correct and does not contain any
>> of by 1 bugs.
>>
>> Note that the diff of v3 compared to the code before v2 landed is
>> actually smaller now and actually matches the subject of:
>> "refactor deprecated strcpy and strncpy"
>>
>> Where as v2 actually touches more code / refactor things
>> which fall outside of a "one change per patch" approach.
>> The:
>>
>> 	p = strchr(arg, '\n');
>> 	if (p)
>> 		*p = '\0';
>>
>> was already there before v2 landed.
>>
>> I also suggested to do a follow up patch to change things to:
>>
>> 	strscpy(arg, val, sizeof(arg));
>> 	p = strchrnul(arg, '\n');
>> 	*p = '\0';
>>
>> Which IMHO is much more readable then what has landed
>> now. But since v2 has already landed I guess the best
>> thing is just to stick with what we have upstream now...
> 
> Well, how about we do a delta patch with all the changes
> you suggested? I'm all for readability.

So I started doing this and notices that all the string
manipulation + parsing done here is really just a DYI
implementation of sysfs_match_string().

So I have prepared a patch to switch to sysfs_match_string(),
which completely removes the need to make a copy of the val
string.

I'll submit the patch right after this email.

Regards,

Hans


