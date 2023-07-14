Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A54975325B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 08:58:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234943AbjGNG6G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 02:58:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234986AbjGNG6A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 02:58:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0AD32709
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 23:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689317830;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=b+vLfnTG8Q/865ZPP5fpquTZ1SKPz1rH7UINbuOOycw=;
        b=cRCa5n9FK0MfKyZ4zSzxSKByoC3ysJvJWhdW5mhlduc4VUNkXCrs/tNfjzxuw8rcqT7+UF
        KmKjrYpg/1iAlxDoq/wXHaTnsqYxSiWbeQp5y+ZGP59ev3lNIHdrQh1uVCLvvWgiQofPO6
        IRTqitmYNwAHfH6b1Yf53HoAdyUFZFg=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-261-FsZklcDWMBKlNUikJhNJ7w-1; Fri, 14 Jul 2023 02:57:09 -0400
X-MC-Unique: FsZklcDWMBKlNUikJhNJ7w-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-763a36c3447so161996785a.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 23:57:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689317829; x=1691909829;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b+vLfnTG8Q/865ZPP5fpquTZ1SKPz1rH7UINbuOOycw=;
        b=Ym6d2nbyoFueJVM210OonH73Zo7n8pDx/SV1KG74Qtu63QbQbTGBUXQOh2ZAVvVzJz
         as+0aWoyt0Eqc4JPae1NBQSws5wyj/tHgAXvYDEcTQlYHKE/Eu3BS6HHGo62qcaKF9Iz
         G1t9VKaiDhlHSS5MVaSs/V4gSj3+3Qqfk3QotbcVhTjfDrMFOkpDehN1bE8WctvRPC4j
         ytfEHIbj6XQiUUBPa2xxXHWpr/F2O0bHuxl2e6qcy3lEKsswq6We29/6kCTKq3pt064y
         5C46EXqVxOr931dDG29xBRxit1Gk6ypVUOwsPaElcH//rKu2bsDG4kJkZj4fwROsW5T/
         uRjg==
X-Gm-Message-State: ABy/qLYxpkKA7KK6F1LnBhLBKjwEt0eY1ceM/duWhQvc1jPabSbfOo7O
        OKhK1T+ix0uS9wfDwqkHarCI+co9IVxMBbbHqlh6vQ/sc4E3SqChQ3EdWCPWtBDbUO6RXiueXcQ
        vBPezM4Zd4OLFzLA6QrQD2ZNP
X-Received: by 2002:a05:620a:2809:b0:765:84e3:aa1f with SMTP id f9-20020a05620a280900b0076584e3aa1fmr3944134qkp.14.1689317829025;
        Thu, 13 Jul 2023 23:57:09 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHpi8y/ZsQnKSySx9auFWWPGpKXcJhkjZHL2RolTd/0Gc433nK1xs/FeLXNxtGka2uHD+S7KA==
X-Received: by 2002:a05:620a:2809:b0:765:84e3:aa1f with SMTP id f9-20020a05620a280900b0076584e3aa1fmr3944123qkp.14.1689317828761;
        Thu, 13 Jul 2023 23:57:08 -0700 (PDT)
Received: from [192.168.149.40] (58.254.164.109.static.wline.lns.sme.cust.swisscom.ch. [109.164.254.58])
        by smtp.gmail.com with ESMTPSA id pa36-20020a05620a832400b007676658e369sm3568490qkn.26.2023.07.13.23.57.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jul 2023 23:57:08 -0700 (PDT)
Message-ID: <e495599a-7a5c-15d0-34b1-3470ad0986ca@redhat.com>
Date:   Fri, 14 Jul 2023 08:57:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [RFC PATCH v2] x86/boot: add .sbat section to the bzImage
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, bluca@debian.org,
        lennart@poettering.net, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Alexander Potapenko <glider@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
        linux-kernel@vger.kernel.org
References: <20230711154449.1378385-1-eesposit@redhat.com>
 <2023071237-private-overhang-7f86@gregkh> <875y6o429i.fsf@redhat.com>
 <2023071329-persevere-pursuant-e631@gregkh> <87wmz33j36.fsf@redhat.com>
 <2023071356-royal-charter-a647@gregkh>
 <5e7716de-ffce-e89d-0aa3-45eed4804652@redhat.com>
 <2023071429-decibel-amazingly-0185@gregkh>
Content-Language: de-CH
From:   Emanuele Giuseppe Esposito <eesposit@redhat.com>
In-Reply-To: <2023071429-decibel-amazingly-0185@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_FILL_THIS_FORM_SHORT,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Am 14/07/2023 um 00:04 schrieb Greg KH:
> On Thu, Jul 13, 2023 at 10:49:31PM +0200, Emanuele Giuseppe Esposito wrote:
>>>> I replied to the thread not to defend the idea as after the discussion
>>>> it is clear there's a lot to take into consideration if anyone decides
>>>> to pursue the SBAT idea ever again (and the discussion is now well
>>>> preserved in the archive!). I replied to disagree with "get sign-offs
>>>> from senior people before sending RFCs" idea, I believe that asking
>>>> questions by sending a not-fully-ready patch as "RFC" should not be
>>>> discouraged. 
>>>
>>> On the contrary, this is EXACTLY what needs to happen here.
>>>
>>> This developer (I'm not picking on them at all, it's not their fault),
>>> should be taking advantage of the resources of their company when
>>> dealing with core, critical, functionality of the kernel.
>>>
>>> To just "throw them at the wolves" like Red Hat did, is a total
>>> disservice to them, AND it wastes the time and resources of the
>>> community, as it is not our job to train and teach them, it is the job
>>> of the senior people at your company to do so.
>>>
>>> We have a non-zero number of companies that right now who are in the
>>> "penalty box" because their developers have had a history of throwing
>>> crud over the wall, or having inexperienced developers submit changes
>>> that are obviously wrong, which waste the time and energy of the kernel
>>> community.  For companies that do this, we have instituted the
>>> requirement that they get review and acceptance of kernel changes from
>>> the experienced developers within the company BEFORE submitting their
>>> changes to the community, for the basic fact that this actually saves
>>> EVERYONE time and energy.
>>>
>>> It allows the developer to grow and learn more quickly, it saves the
>>> energy and time of the reviewers (which is our most valuable resource
>>> right now) and it provides a solid path forward on the corporate ladder
>>> of using mentors well, and lifting up your own employees.
>>>
>>> I don't think you want us to put Red Hat into this type of policy at
>>> this point in time, but if you all keep insisting that you can just "let
>>> loose" inexperienced developers who wish to change the core
>>> functionality of how we operate, that can easily change.
>>
>> Wow, I was not aware of these policies O.O.
>> What you say makes sense, but what about developers not working in a
>> company? Then they are completely ignored?
> 
> Not at all, they are not ignored and are treated as someone who probably
> needs help.
> 
>> Otherwise a simple way to trick you is to actually use my gmail address
>> and you won't ever know that I work for RH.
> 
> If RH finds out you are misrepresenting yourself like this, I don't
> think it will go over very well :)

By "my gmail address" I mean any potential employee of any company
reading this thread of course. I think after this you'll remember my
name for a while ;) So no way to hide for me. Also my private email
address has my name and surname in it, so it won't be hard to identify me.

Anyways, I think you need to clarify better what you mean with
"inexperienced developers submit changes that are obviously wrong", more
specifically the "obviously wrong" part.
If you refer to the commit message wrongly made, ok you have a point. I
take responsibility on this, it already happened that I wrote non clear
commits and I am working on this. Working on different communities that
have less commit rules and rarely sending stuff to kernel doesn't help
though (my only excuse). If it's that, the issue can be closed here and
I will definitely be more careful in the future, as well as all I work with.

If you refer to the fact that the patch is wrong technically, 1) as I
wrote it is indeed not working properly, I have clearly documented in
the commit message that if you run make twice with this patch it won't
work, and 2) the aim of this patch that we thought was clear with RFC
and "Important:..." was to ask opinions because we don't have experts on
this matter, the technology is new and would like to hear opinions from
outside. You gave the opinion we were looking for, it's just that the
whole thing escalated dramatically because IMHO intentions were
misunderstood and again IMHO the wrong tones and wordings were used.

Thank you,
Emanuele
> 
> Also, we know who almost everyone works for, this isn't a secret.  And
> it would turn out to be worse overall for that developer if they were to
> attempt that.
> 
> Remember, kernel development works on trusting other people.  If someone
> looses their trust in you, it's very hard to get it back.
> 
> thanks,
> 
> greg k-h
> 

