Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AAC0757DBB
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 15:35:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232408AbjGRNfq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 09:35:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjGRNfo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 09:35:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54C4AD1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 06:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689687299;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iDWEmFv8ikbM1efDgxCuQsmQ0aQ6k0wQBe6ItEu3PwY=;
        b=C3amw5SC830gong8/pnsk5icwIAXyCyUTaO+4Tb8j3ul6+GLRezwnJSEDwjFDJKJ7STHCc
        FOEQm9Z6b7VKgJ1+slOavH3u+pp8wFGSfTp/Nl6tKEIFuO8dhkDVecb3d2EGvqcaTUr9N3
        M1r683zO4S8Ff+ha1MQ81Q7LTFZe6Jo=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-214-BKOZfY9pMayr0J6ewAho1A-1; Tue, 18 Jul 2023 09:34:56 -0400
X-MC-Unique: BKOZfY9pMayr0J6ewAho1A-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-521a38098faso851827a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 06:34:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689687295; x=1692279295;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iDWEmFv8ikbM1efDgxCuQsmQ0aQ6k0wQBe6ItEu3PwY=;
        b=O9vgRoJdeco+slTX90JZkDY2ua68ibc4SDPb+c/SIVsnn9hEUA0CzdmJ8jijBoTO9a
         ADZDnjcG9edno4oGKR6cvrQW84w3a1+riDpENB/eXe8Ft/T9tuEz+GIWUn3slxjPn+4s
         MugHmlQD+QsWq4SU5nTzUpDUKFlQgflqHndkElZANHo3F+uYW31gnw35OVpLuGckmpoT
         QoBfL6wauH2mjPWNhbb3W5bBIPWideFR6OhcHsU86yIDmFQAg3aEtgYGXuY/bdiITmmz
         V6XZBJqHnRhalRfsV9o2JEARGJcF0UjfbvN9HuuWeFPgWXZdmNubERjSegs1jkHcYH2x
         +1Qg==
X-Gm-Message-State: ABy/qLY8Q5h6kKG8M6fSJm0bTN8NFyB9kh4SJKoV0f6eybIcTswsf2Do
        C72Tmv2wJ10ZEG4qGaHwv7LtJE4iXffaHm/l8EGtVAQgZwZgnhI43XP6ld8ilQvj71ftSPujjqU
        Tfb1R5o5uLh3Q7suh1rZn9kOX
X-Received: by 2002:a17:906:11:b0:992:6d73:568e with SMTP id 17-20020a170906001100b009926d73568emr12055025eja.68.1689687295144;
        Tue, 18 Jul 2023 06:34:55 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFJcNgTzBE7qga/xfpPPErDtgSkzXY/CgEOJmgQRnw9mQ8etLEKAhFQilbOcRK0Uzb0jGgGeA==
X-Received: by 2002:a17:906:11:b0:992:6d73:568e with SMTP id 17-20020a170906001100b009926d73568emr12055000eja.68.1689687294789;
        Tue, 18 Jul 2023 06:34:54 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:9af8:e5f5:7516:fa89? ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
        by smtp.googlemail.com with ESMTPSA id i19-20020a056402055300b0051e24284fc8sm1273243edx.12.2023.07.18.06.34.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jul 2023 06:34:54 -0700 (PDT)
Message-ID: <df7941b9-11ea-9abd-e070-4e9926aecdc3@redhat.com>
Date:   Tue, 18 Jul 2023 15:34:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: en-US
To:     Ard Biesheuvel <ardb@kernel.org>,
        Emanuele Giuseppe Esposito <eesposit@redhat.com>
Cc:     x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        bluca@debian.org, lennart@poettering.net,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Alexander Potapenko <glider@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
        linux-kernel@vger.kernel.org
References: <20230711154449.1378385-1-eesposit@redhat.com>
 <ZK/9MlTh435FP5Ji@gambale.home>
From:   Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC PATCH v2] x86/boot: add .sbat section to the bzImage
In-Reply-To: <ZK/9MlTh435FP5Ji@gambale.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[note: while there is some overlap between the developers and Red Hat 
employees that are involved in KVM, I was not involved in this work and 
only learnt about it last Friday]

On 7/13/23 15:33, Ard Biesheuvel wrote:
>> A .sbat is simply a section containing a string with the component name
>> and a version number. This version number is compared with the value in
>> OVMF_VARS, and if it's less than the variable, the binary is not trusted,
>> even if it is correctly signed.
>>
> 
> Also, 'version number' is a bit vague, better to stick with existing
> terminology that makes this more self explanatory: the component that
> authenticates the kernel image keeps a revocation counter, and refuses
> to load authentic images whose revocation index is lower than the
> revocation counter. This approach removes the need for revoking
> individual image hashes or having to rotate the signing keys when a
> vulnerability is discovered.
> 
> The argument that we need this in the upstream kernel seems to be
> predicated on the assumption that there is one universal signing
> authority and revocation domain, but this is not necessarily true.

I am not sure about this.  I think that a revocation index could _in 
theory_ make sense as a way to double check that you have backported all 
the relevant bugfixes.  If you backport the patch that changes the index 
from 2 to 3 but your tree has index=1, it will conflict and hopefully 
fix it or lead you to document why that is happening.

But I'm saying "in theory", because I'm not sure it makes sense to apply 
the concept to an OS kernel.  A revocation index makes sense for boot 
loaders, whose purpose is to check something about the next stage and 
then get out of the way.  When using a bootloader for secure boot there 
is a limited amount of parsing and basically no user interaction.  With 
some handwaving, that makes it is possible to say things like "oh no I 
found the 234th bug in my codebase, let's bump the revocation index to 235".

If you try to do this for the OS, however, Linux's "vulnerabilities are 
just bugs" mantra hits hard---more specifically the reverse: all bugs 
are potential vulnerabilities.  Sure you can hope for the best, which is 
what we do with module signing and with the (non-upstream) secure boot 
lockdown patches.  In the end, however, an unpatched code execution or 
memory write vulnerability is always a potential rootkit.  While we 
don't have _too_ many of those, there are enough that the idea of a 
revocation index becomes completely unfeasible, not too mention those 
that are fixed silently not because "that's the way Linus does it" but 
rather because we genuinely didn't think of them as security fixes.

So perhaps there could be some kind of protocol that would let a new 
kernel tell the bootloader "don't boot an older kernel than me in the 
future".  It could even be an extension to the SBAT spec itself.  I 
haven't really thought much about it, tbh.  However, I'm quite positive 
that a revocation index attached to the kernel image cannot really work 
as a concept, not even if it is managed by the distro.

Paolo

