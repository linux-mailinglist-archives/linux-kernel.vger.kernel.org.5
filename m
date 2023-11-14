Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C14267EB21B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 15:33:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231605AbjKNOdE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 09:33:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjKNOdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 09:33:03 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 448A510D
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 06:33:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699972379;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=vLqA6B8ILvjoZHm5Kjx5UvL4QdH66sld3iEB6MCOoHs=;
        b=UNU/qomw7wWTg8K6i8unzhNW1IdRfnVpggD1oTKf3oPWCoDPYchKCObxhsY+Ok07pmQA9p
        qTQbWbBan9Ci/SOqMewQXiPjr2a8XZFSddJD8ZMbZTwLxh7oohEm7f2I+3pra9bB2/l4th
        FyckplvGU9QXEzvhGBEKo6siFKxQ36I=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-260-Ipd_ZZkzMmy5NB21W5IC8w-1; Tue, 14 Nov 2023 09:32:57 -0500
X-MC-Unique: Ipd_ZZkzMmy5NB21W5IC8w-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-66cffe51b07so64135576d6.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 06:32:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699972377; x=1700577177;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vLqA6B8ILvjoZHm5Kjx5UvL4QdH66sld3iEB6MCOoHs=;
        b=LunXWIUuVIrKfdoi5ao5MzM0uAh1Y2b+uwYRnNFpq29Eq1B5Vj1PcVe9af4fq7p8DC
         ICpN0CXteZHnyFwK3DiXWqsonHoq9Leqsx4XiV66BYOUwjn+dUhXyqTs6/kbwexy51sR
         3ryAkzlKNE2cSrKMlCMwJVBu5k5vTFhn+VChpTARLATK5SZS5Sxt981r2ctP1D6OqUyf
         b/e7cOpvJuV+I2B3cLs+b2GZQQSwmaw+z7kOPgqrlbKaT0FFX1Nw1caS14Bp7lZJhaKO
         b2OSSqcCvgNYWo9QWnK05H3CJLvLyb8RiQT3Ujm/ndfffhcZbckILQ3Bd7zoL1hDxbDR
         4DtA==
X-Gm-Message-State: AOJu0YzgmL2tEhwxCvfek1ofHOfSt1c8NFn02HVShuWukhKe0KM8Tp/W
        kGSXo3SJCWbYJKkSMZ57SMW7FHENUqdr1+03ACNbf2qAYGz4dbbILl4xWGkgcSZQBEdlZ3GYd+r
        wX6gba517nBPpwLRxlbZKIrnRvyZ0K64T
X-Received: by 2002:ad4:5d6c:0:b0:656:4712:af9f with SMTP id fn12-20020ad45d6c000000b006564712af9fmr2951713qvb.13.1699972377304;
        Tue, 14 Nov 2023 06:32:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF+F+DuNTNR6J7TO3eUurmVnigBll6V6yWuPMrEo7og8X7tHnyT+OT6thh8B5Tpri41rDBdyA==
X-Received: by 2002:ad4:5d6c:0:b0:656:4712:af9f with SMTP id fn12-20020ad45d6c000000b006564712af9fmr2951690qvb.13.1699972377024;
        Tue, 14 Nov 2023 06:32:57 -0800 (PST)
Received: from [192.168.0.6] (ip-109-43-176-122.web.vodafone.de. [109.43.176.122])
        by smtp.gmail.com with ESMTPSA id r7-20020a0cf807000000b0065b1f90ff8csm2941320qvn.40.2023.11.14.06.32.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Nov 2023 06:32:56 -0800 (PST)
Message-ID: <8305a632-730a-4113-a638-0a9a520ee0f7@redhat.com>
Date:   Tue, 14 Nov 2023 15:32:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] m68k: Avoid CONFIG_COLDFIRE switch in uapi header
Content-Language: en-US
To:     Greg Ungerer <gerg@linux-m68k.org>, Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org
Cc:     linux-kernel@vger.kernel.org
References: <20231110103120.387517-1-thuth@redhat.com>
 <571ed28a-9690-4f85-9122-4b0f76975cb3@app.fastmail.com>
 <6e3f2a2e-2430-4b4f-9ead-d9a4d5e42713@linux-m68k.org>
From:   Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <6e3f2a2e-2430-4b4f-9ead-d9a4d5e42713@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/11/2023 15.20, Greg Ungerer wrote:
> 
> 
> On 10/11/23 21:19, Arnd Bergmann wrote:
>> On Fri, Nov 10, 2023, at 11:31, Thomas Huth wrote:
>>> We should not use any CONFIG switches in uapi headers since
>>> these only work during kernel compilation. They are not defined
>>> for userspace. Let's use the __mcoldfire__ switch from the
>>> compiler here instead.
>>>
>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>> ---
>>>   Marked as RFC since I didn't test it - I'd appreciate if someone
>>>   could give it a try on a real system.
>>>
>>>   arch/m68k/include/uapi/asm/ptrace.h | 2 +-
>>>   scripts/headers_install.sh          | 1 -
>>>   2 files changed, 1 insertion(+), 2 deletions(-)
>>>
>>> diff --git a/arch/m68k/include/uapi/asm/ptrace.h
>>> b/arch/m68k/include/uapi/asm/ptrace.h
>>> index 5b50ea592e00..ebd9fccb3d11 100644
>>> --- a/arch/m68k/include/uapi/asm/ptrace.h
>>> +++ b/arch/m68k/include/uapi/asm/ptrace.h
>>> @@ -39,7 +39,7 @@ struct pt_regs {
>>>     long     d0;
>>>     long     orig_d0;
>>>     long     stkadj;
>>> -#ifdef CONFIG_COLDFIRE
>>> +#ifdef __mcoldfire__
>>>     unsigned format :  4; /* frame format specifier */
>>>     unsigned vector : 12; /* vector offset */
>>>     unsigned short sr;
>>
>> I think this should be harmless,
> 
> I expect it would be, we have done this in at least one other uapi file,
> arch/m68k/include/uapi/asm/swab.h.
> 
> 
>> but I'm not sure we even
>> need the structure in a uapi header: about half the architectures
>> define this in a user-visible way, while the others don't.
>>
>> On csky, powerpc and microblaze, pt_regs is used inside
>> of the 'struct sigcontext' definition, but I don't think
>> this was ever the case on m68k.
>>
>> The other one that is accessed in userspace is 'struct
>> user_regs_struct', but this one is actually not in the
>> uapi headers on m68k or x86.
> 
> I don't think we need them in the uapi header at all. Trivially moving
> those 2 structures into the non-uapi ptrace.h seems to build fine on
> most simple setups I tried (systems using uClibc, with applications like
> strace). Should we try moving them out?

Yes, please! Can you send your patch?

  Thomas


