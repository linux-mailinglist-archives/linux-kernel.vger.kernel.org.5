Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BED6752BDB
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 22:50:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233950AbjGMUu0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 16:50:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232270AbjGMUuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 16:50:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40CC32D54
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 13:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689281376;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IHjAiKDgkWEhMt7jYaYaz3lsgC1nD6n3KKjsUKIQ3NE=;
        b=OVgOPA/KKNHRsYZ290Wv0Ln5mzj/q6r5Ei5QNJGRsH0yeDk12tulbQIi+cZM+nrKh5xPws
        9Y00+IJ06HPJgOPMdrpvLjevZCkycGgoUmDTpRaYeL1jmh4TjNC2l1IZCzdPvarhpgMt06
        RZKuR6xB0N81DA1nWntBars07wafHL8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-60-IopMjFnOPFa2ppYZS0oCvA-1; Thu, 13 Jul 2023 16:49:35 -0400
X-MC-Unique: IopMjFnOPFa2ppYZS0oCvA-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-3f42bcef2acso6414455e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 13:49:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689281374; x=1691873374;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IHjAiKDgkWEhMt7jYaYaz3lsgC1nD6n3KKjsUKIQ3NE=;
        b=jGCxrAlAGgREneMg5wmurz77KCmzlKPsTBElP0ovNvAuebEgiZmBUSWuAnUE1OEomw
         IiSjatcFEL07YELQewQCBEMCpBYftyAHVvPecrsTrmyg8S1WW3ju7UlyTyjq0mU16bje
         dqekzMBOnY76Eh8rtSf8sTOhcpcuTk3m3ce/wuQjqBpOo7T1vxCJHk1cDujS/CfD6/K4
         Jjr70V5iaYebryHzvHoQs4+cipPWHpBScC9gSsFfppTCF4oLKTIExDH7n7Fj78ptRvz/
         eeUZobotMbkz6DVpA24dVfoRmqcYzn16zZp9T4hRuAvSouMDS0z3e59xjZM6HDPOLcjF
         6RMg==
X-Gm-Message-State: ABy/qLY7/FdLRBzjUgihzspsTDBHaUvuXM01FFeXi/QGKcbj2/U8SE93
        OwSV2/uhaxHLVnyeqVlQrRnMb99JHYGhclHEjTo+d/Jjtq3NtqlRVdiajOEZ6yBze0soZ1fE+ey
        JWqHafqs4XRKboMcF4dlElfOK
X-Received: by 2002:a05:600c:247:b0:3fb:b6fa:9871 with SMTP id 7-20020a05600c024700b003fbb6fa9871mr2263350wmj.14.1689281373970;
        Thu, 13 Jul 2023 13:49:33 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFvvODTtbDEgvJEh2F5G/6pc7oW4plrq83Kc2SB3wRSCz6q+L+2QOl9Tzub416n+rdv9wYY1w==
X-Received: by 2002:a05:600c:247:b0:3fb:b6fa:9871 with SMTP id 7-20020a05600c024700b003fbb6fa9871mr2263340wmj.14.1689281373551;
        Thu, 13 Jul 2023 13:49:33 -0700 (PDT)
Received: from [192.168.95.46] ([213.55.224.225])
        by smtp.gmail.com with ESMTPSA id f15-20020a7bc8cf000000b003fbaa2903f4sm8586554wml.19.2023.07.13.13.49.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jul 2023 13:49:32 -0700 (PDT)
Message-ID: <5e7716de-ffce-e89d-0aa3-45eed4804652@redhat.com>
Date:   Thu, 13 Jul 2023 22:49:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [RFC PATCH v2] x86/boot: add .sbat section to the bzImage
Content-Language: de-CH
To:     Greg KH <gregkh@linuxfoundation.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        bluca@debian.org, lennart@poettering.net,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
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
From:   Emanuele Giuseppe Esposito <eesposit@redhat.com>
In-Reply-To: <2023071356-royal-charter-a647@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Am 13/07/2023 um 18:58 schrieb Greg KH:
> On Thu, Jul 13, 2023 at 05:51:57PM +0200, Vitaly Kuznetsov wrote:
>> Greg KH <gregkh@linuxfoundation.org> writes:
>>> On Thu, Jul 13, 2023 at 10:57:45AM +0200, Vitaly Kuznetsov wrote:
>>>> I don't
>>>> particularly see why anyone would need to get additional sign-offs to
>>>> just ask a question (which I don actually think was asked before!) and
>>>> IMO an RFC/patch is usually the best way to do so.
>>>
>>> Again, no questions were asked.
>>>
>>> And when I asked questions, no one knowledgable answered them (hint, we
>>> release more than 3 kernels a year...)
>>>
>>
>> I think that getting these questions was actually the main reason to
>> send out the RFC. (Personally, I don't think that stable@ is an
>> insurmountable problem with an epoch-based revocation mechamism as we
>> can e.g. switch module name from "linux" to e.g. "linux-stable-5.14"
>> when screating a stable branch or do something like that but that's not
>> the main/only problem we see here).
> 
> There was no "questions" asked about this RFC, so what should we respond
> with except with what we did, "No way this is acceptable, as this was
> not thought through at all"?


As I wrote you privately before, yeah I think there is a
misunderstanding here. I always thought that RFC stands for "hey I don't
know what I am doing, can you help me?". I apologize for the
misunderstanding.
Also other hints were "*Important*: this is just an RFC, as I am not
expert in this area and
I don't know what's the best way to achieve this."
and "Issues with this patch:" section.

> 
>>> Turn it around, what would you do if you got this patch in your inbox to
>>> review and you were responsible for doing kernel releases and security
>>> fixes?
>>>
>>
>> I replied to the thread not to defend the idea as after the discussion
>> it is clear there's a lot to take into consideration if anyone decides
>> to pursue the SBAT idea ever again (and the discussion is now well
>> preserved in the archive!). I replied to disagree with "get sign-offs
>> from senior people before sending RFCs" idea, I believe that asking
>> questions by sending a not-fully-ready patch as "RFC" should not be
>> discouraged. 
> 
> On the contrary, this is EXACTLY what needs to happen here.
> 
> This developer (I'm not picking on them at all, it's not their fault),
> should be taking advantage of the resources of their company when
> dealing with core, critical, functionality of the kernel.
> 
> To just "throw them at the wolves" like Red Hat did, is a total
> disservice to them, AND it wastes the time and resources of the
> community, as it is not our job to train and teach them, it is the job
> of the senior people at your company to do so.
> 
> We have a non-zero number of companies that right now who are in the
> "penalty box" because their developers have had a history of throwing
> crud over the wall, or having inexperienced developers submit changes
> that are obviously wrong, which waste the time and energy of the kernel
> community.  For companies that do this, we have instituted the
> requirement that they get review and acceptance of kernel changes from
> the experienced developers within the company BEFORE submitting their
> changes to the community, for the basic fact that this actually saves
> EVERYONE time and energy.
> 
> It allows the developer to grow and learn more quickly, it saves the
> energy and time of the reviewers (which is our most valuable resource
> right now) and it provides a solid path forward on the corporate ladder
> of using mentors well, and lifting up your own employees.
> 
> I don't think you want us to put Red Hat into this type of policy at
> this point in time, but if you all keep insisting that you can just "let
> loose" inexperienced developers who wish to change the core
> functionality of how we operate, that can easily change.

Wow, I was not aware of these policies O.O.
What you say makes sense, but what about developers not working in a
company? Then they are completely ignored?
Otherwise a simple way to trick you is to actually use my gmail address
and you won't ever know that I work for RH.
Is this the policy of the community? If so, is it explained clearly
somewhere? Because I think a lot of people need to be aware of this, not
wait that this mess happens for every company employer submitting a
patch in the kernel.

> 
> Remember, this proposed patch directly affects how the kernel is
> released, how the security team works, and how the security of Linux is
> viewed by the world.  Why would you NOT want your experienced developers
> to review such a thing first?  To not want that, means that Red Hat just
> doesn't care about their developers, nor the community, which I sure
> hope is not the case.
> 
> So again, yes, I am INSISTING that the next version of this change be
> properly reviewed, vetted, and signed-off-by, by the senior kernel
> developers at your company BEFORE you submit it again for review by
> anyone in the community.  Only that way can I hope that it will be
> something that actually takes into account all of the questions we have
> already had for this proposed 2 line change.
> 
> Funnily, I think this proposed patch takes the dubious record for "most
> innocuous looking patch that will directly affect the development
> procedures for the most people", an outstanding record that I hope never
> gets broken :)

Glad to be the one that opened the pandora box for everyone :)

Thank you,
Emanuele
> 
> thanks,
> 
> greg k-h
> 

