Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B79E7EB1FD
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 15:20:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233354AbjKNOUN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 09:20:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjKNOUK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 09:20:10 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2624CA
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 06:20:07 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 695BEC433C8;
        Tue, 14 Nov 2023 14:20:06 +0000 (UTC)
Message-ID: <6e3f2a2e-2430-4b4f-9ead-d9a4d5e42713@linux-m68k.org>
Date:   Wed, 15 Nov 2023 00:20:03 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] m68k: Avoid CONFIG_COLDFIRE switch in uapi header
Content-Language: en-US
To:     Arnd Bergmann <arnd@arndb.de>, Thomas Huth <thuth@redhat.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org
Cc:     linux-kernel@vger.kernel.org
References: <20231110103120.387517-1-thuth@redhat.com>
 <571ed28a-9690-4f85-9122-4b0f76975cb3@app.fastmail.com>
From:   Greg Ungerer <gerg@linux-m68k.org>
In-Reply-To: <571ed28a-9690-4f85-9122-4b0f76975cb3@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/11/23 21:19, Arnd Bergmann wrote:
> On Fri, Nov 10, 2023, at 11:31, Thomas Huth wrote:
>> We should not use any CONFIG switches in uapi headers since
>> these only work during kernel compilation. They are not defined
>> for userspace. Let's use the __mcoldfire__ switch from the
>> compiler here instead.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>   Marked as RFC since I didn't test it - I'd appreciate if someone
>>   could give it a try on a real system.
>>
>>   arch/m68k/include/uapi/asm/ptrace.h | 2 +-
>>   scripts/headers_install.sh          | 1 -
>>   2 files changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/arch/m68k/include/uapi/asm/ptrace.h
>> b/arch/m68k/include/uapi/asm/ptrace.h
>> index 5b50ea592e00..ebd9fccb3d11 100644
>> --- a/arch/m68k/include/uapi/asm/ptrace.h
>> +++ b/arch/m68k/include/uapi/asm/ptrace.h
>> @@ -39,7 +39,7 @@ struct pt_regs {
>>     long     d0;
>>     long     orig_d0;
>>     long     stkadj;
>> -#ifdef CONFIG_COLDFIRE
>> +#ifdef __mcoldfire__
>>     unsigned format :  4; /* frame format specifier */
>>     unsigned vector : 12; /* vector offset */
>>     unsigned short sr;
> 
> I think this should be harmless,

I expect it would be, we have done this in at least one other uapi file,
arch/m68k/include/uapi/asm/swab.h.


> but I'm not sure we even
> need the structure in a uapi header: about half the architectures
> define this in a user-visible way, while the others don't.
> 
> On csky, powerpc and microblaze, pt_regs is used inside
> of the 'struct sigcontext' definition, but I don't think
> this was ever the case on m68k.
> 
> The other one that is accessed in userspace is 'struct
> user_regs_struct', but this one is actually not in the
> uapi headers on m68k or x86.

I don't think we need them in the uapi header at all. Trivially moving
those 2 structures into the non-uapi ptrace.h seems to build fine on
most simple setups I tried (systems using uClibc, with applications like
strace). Should we try moving them out?

Regards
Greg

