Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F8D97C60F9
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 01:15:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235196AbjJKXP4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 19:15:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233835AbjJKXPx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 19:15:53 -0400
Received: from mail.zytor.com (unknown [IPv6:2607:7c80:54:3::138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 964CEA9
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 16:15:52 -0700 (PDT)
Received: from [IPV6:2601:646:9a00:1821:7c45:267e:5aad:82e7] ([IPv6:2601:646:9a00:1821:7c45:267e:5aad:82e7])
        (authenticated bits=0)
        by mail.zytor.com (8.17.1/8.17.1) with ESMTPSA id 39BNFKAT1460737
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Wed, 11 Oct 2023 16:15:20 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 39BNFKAT1460737
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2023091101; t=1697066121;
        bh=A0jQQXBOckvWMvwyYSs8xAHjvJIHmdT/ZUvtoLWPlIw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=HQelFdNGOmQvUkC7FqkZg4tibROwOGCiEcbxjkVmNZ0UoybOfmMDeq30cB4KUnygu
         9CzoNDBAANZ3ZZHMSRQ2Cx0CjPwcVkbiE8j6CdJZeVPxBkTB0eaz9SDpZoz8ik/VnJ
         BozxHWzadRqgtYKdUJklR0yN6s5LvQwZx3Po0Fxy5lH9FCw0LFcIhQAlrCWq0Cpovw
         4zPAm8dBOq1zJwzI7Q3HGOZkEINFgkKZRtKktJWv64Po0ZVP/iUtw5sXxjS9fltrHA
         GF0Hp1oaAGqg6xqx4n6fWveXTddci6Un0W/tCBI7m1pyT3q5iOCY0UvsfZ3KgQBn91
         SlIU50HHoJCrg==
Message-ID: <9b71932a-d410-4b92-b605-d6acc5d35069@zytor.com>
Date:   Wed, 11 Oct 2023 16:15:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 -tip] x86/percpu: Use C for arch_raw_cpu_ptr()
Content-Language: en-US
To:     Ingo Molnar <mingo@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Uros Bizjak <ubizjak@gmail.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Nadav Amit <namit@vmware.com>,
        Andy Lutomirski <luto@kernel.org>,
        Brian Gerst <brgerst@gmail.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>
References: <20231010164234.140750-1-ubizjak@gmail.com>
 <CAHk-=whYWhZN52SJN-Th9x2L2V-vHtAXUgiy_nSJ3+vQU6ak4Q@mail.gmail.com>
 <CAFULd4ZqH3FeG8_mjDvUAU9QiGB36wDu3MzUtadgAgoVuQ9QRg@mail.gmail.com>
 <CAHk-=wiALZxieQQmvv5sW15HYB_YwC3d_ma9sdp7Zb4Fb4uK2w@mail.gmail.com>
 <CAFULd4Y8NSArDqH=VMy8F97eNosUUGxrBMEyHH=MytjUBSCmjg@mail.gmail.com>
 <CAHk-=whMr8V_q3dq4iS0dpx4Nssu+aYWz+mA36p2ykA+OXTjXA@mail.gmail.com>
 <CAFULd4afyYK0-wAOo3oJDapX0iyu86m5+vVn9c35gk8fd6iwRQ@mail.gmail.com>
 <CAHk-=wiLyA0g3BvQ_nsF2PWi-FDtcNS5+4-ai1FX-xFzTBeTzg@mail.gmail.com>
 <ZScjptMn3fDmMFdg@gmail.com>
From:   "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <ZScjptMn3fDmMFdg@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/11/23 15:37, Ingo Molnar wrote:
> 
> * Linus Torvalds <torvalds@linux-foundation.org> wrote:
> 
>>> The only drawback is a larger binary size:
>>>
>>>    text    data     bss     dec     hex filename
>>> 25546594        4387686  808452 30742732        1d518cc vmlinux-new.o
>>> 25515256        4387814  808452 30711522        1d49ee2 vmlinux-old.o
>>>
>>> that increases by 31k (0.123%), probably due to 1578 rdgsbase alternatives.
>>
>> I'm actually surprised that it increases the text size. The 'rdgsbase'
>> instruction should be smaller than a 'mov %gs', so I would have
>> expected the *data* size to increase due to the alternatives tables,
>> but not the text size.
>>
>> [ Looks around ]
>>
>> Oh. It's because we put the altinstructions into the text section.
>> That's kind of silly, but whatever.
> 
> Yeah, we should probably move .altinstructions from init-text to .init.data
> or so? Contains a bunch of other sections too that don't get executed
> directly ... and in fact has some non-code data structures too, such as ...
> ".apicdrivers". :-/
> 
> I suspect people put all that into .text because it was the easiest place
> to modify in the x86 linker script, and linker scripts are arguably scary.
> 

Well, it's more than that; "size" considers all non-writable sections to 
be "text".

	-hpa

