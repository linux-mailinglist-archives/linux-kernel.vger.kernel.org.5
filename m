Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92EDF796E71
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 03:11:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232858AbjIGBLM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 21:11:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231970AbjIGBLL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 21:11:11 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4161E5C
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 18:10:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3352C433C8;
        Thu,  7 Sep 2023 01:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694049025;
        bh=NVYr91ZTB33fuG48FDFSm4hUOros8XmqjUrEi2FOsKY=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=fIq6LNc3zpP4anpSAGaaL2DHHTWePT+5PVo3PgzNcIDlWjTAJFTze/pFvUQnshqJt
         R6AWijwpR5f50MMrVQJXR+Hy8qumTl5r6A28AMoRbA02Fr+Zvrja+hgxO0SSSosDQ3
         AFycUeXVRBMneUeOBJXMIAxSqeE5JqQqpIaBnniO5pTD5es5eErukcN0eEf29f+YuC
         fx7hGzjbOHHfpXNYvdHVxEKONUmssORXUMYLZd6EEc2KnK5zWfxIPCoOnFin2LcyvP
         e0uBZCz1iQIiLWE2BxW7K/weE/+NKjUJjx95/vbu9o9yrAUbZlWRL9EOew9og+p3rs
         96jD4veTmvguw==
Message-ID: <2556121f-d086-e79b-b1d7-c33eedaa05ac@kernel.org>
Date:   Thu, 7 Sep 2023 11:10:21 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] fs: binfmt_elf_efpic: fix personality for fdpic ELF
Content-Language: en-US
From:   Greg Ungerer <gerg@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-arm@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk,
        ebiederm@xmission.com, brauner@kernel.org
References: <20230711133955.483393-1-gerg@kernel.org>
 <202307110901.7E9A0D0AE5@keescook>
 <c8c8abb4-51af-9700-722d-049733d13c43@kernel.org>
In-Reply-To: <c8c8abb4-51af-9700-722d-049733d13c43@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/7/23 13:43, Greg Ungerer wrote:
> Hi Kees,
> 
> On 12/7/23 02:11, Kees Cook wrote:
>> On Tue, Jul 11, 2023 at 11:39:55PM +1000, Greg Ungerer wrote:
>>> The elf-fdpic loader hard sets the process personality to either
>>> PER_LINUX_FDPIC for true elf-fdpic binaries or to PER_LINUX for
>>> normal ELF binaries (in this case they would be constant displacement
>>> compiled with -pie for example). The problem with that is that it
>>> will lose any other bits that may be in the ELF header personality
>>> (such as the "bug emulation" bits).
>>>
>>> On the ARM architecture the ADDR_LIMIT_32BIT flag is used to signify
>>> a normal 32bit binary - as opposed to a legacy 26bit address binary.
>>> This matters since start_thread() will set the ARM CPSR register as
>>> required based on this flag. If the elf-fdpic loader loses this bit
>>> the process will be mis-configured and crash out pretty quickly.
>>>
>>> Modify elf-fdpic loaders personality setting for ELF binaries so that
>>> it preserves the upper three bytes by using the SET_PERSONALITY macro
>>> to set it. This macro in the generic case sets PER_LINUX but and
>>> preserves the upper bytes. Architectures can override this for their
>>> specific use case, and ARM does exactly this.
>>
>> Thanks for tracking this down!
>>
>> There are some twisty macros in use across all the architectures here!
>>
>> I notice the bare set_personality() call remains, though. Is that right?
>>
>> For example, ARM (and sh and xtensa) also sets:
>>
>> #define elf_check_fdpic(x) ((x)->e_ident[EI_OSABI] == ELFOSABI_ARM_FDPIC)
>>
>> so it's possible the first half of the "if" below could get executed,
>> and ARM (and possibly other architectures) would again lose the other
>> flags, if I'm reading correctly.
> 
> Yes, it is all a little confusing, and the fdpic handling is a little different
> to the standard ELF handling in binfmt_elf.c (with its use of SET_PERSONALITY2).
> 
> 
>> (And the fact that PER_LINUX is actually 0x0 is oddly handled, leaving
>> it implicit in most architectures.)
>>
>> What seems perhaps more correct is to remove the "if" entirely and make
>> sure that SET_PERSONALITY() checks the header flags on all architectures?
> 
> I had thought along those same lines as well. Changing it to be something more
> like this:
> 
>      SET_PERSONALITY(exec_params.hdr);
>      if (elf_check_fdpic(&exec_params.hdr))
>              current->personality |= FDPIC_FUNCPTRS;
> 
> Which I think better handles any arch specifics via the SET_PERSONALITY() use.
> But I chickened out since I can't test fdpic binaries at this time.

I have done some more extensive testing, with fdpic setups now, and this
definitely suffers the same problem. So it needs a fix more like this.
I am generating a v2 that essentially does the above - so it fixes both
the normal ELF and ELF-FDPOIC binary cases.

Regards
Greg


>> But I'm less familiar with this area, so please let me know what I'm
>> missing. :)
> 
> Me too :-)
> It is definitely broken for loading standard ELF binaries on a noMMU system
> using binfmt_elf_fdpic.c, which is what led me down this path. It loses the
> ADDR_LIMIT_32BIT bit in the personality and that causes application crashing.
> 
> 
>>> Signed-off-by: Greg Ungerer <gerg@kernel.org>
>>> ---
>>>
>>> Is anyone out there using elf-fdpic on ARM?
>>
>> It would seem you're the first? :) (_Should_ it be usable on ARM?)
> 
> I was assuming that it must have worked at some time. The binfmt_elf_fdpic
> loader was enabled for ARM in commit 50b2b2e691cd ("ARM: add ELF_FDPIC support")
> by Nicolas Pitre. But that was way back in 2017.
> 
> Regards
> Greg
> 
> 
>> -Kees
>>
>>> This seems to break it rather badly due to the loss of that ADDR_LIMIT_32BIT
>>> bit from the process personality.
>>>
>>>   fs/binfmt_elf_fdpic.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/fs/binfmt_elf_fdpic.c b/fs/binfmt_elf_fdpic.c
>>> index a05eafcacfb2..f29ae1d96fd7 100644
>>> --- a/fs/binfmt_elf_fdpic.c
>>> +++ b/fs/binfmt_elf_fdpic.c
>>> @@ -348,7 +348,7 @@ static int load_elf_fdpic_binary(struct linux_binprm *bprm)
>>>       if (elf_check_fdpic(&exec_params.hdr))
>>>           set_personality(PER_LINUX_FDPIC);
>>>       else
>>> -        set_personality(PER_LINUX);
>>> +        SET_PERSONALITY(exec_params.hdr);
>>>       if (elf_read_implies_exec(&exec_params.hdr, executable_stack))
>>>           current->personality |= READ_IMPLIES_EXEC;
>>> -- 
>>> 2.25.1
>>>
>>
