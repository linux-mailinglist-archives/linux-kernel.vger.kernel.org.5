Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEA7C77165B
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Aug 2023 19:52:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230364AbjHFRwl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Aug 2023 13:52:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230362AbjHFRwj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Aug 2023 13:52:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF5941719
        for <linux-kernel@vger.kernel.org>; Sun,  6 Aug 2023 10:52:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0D5386124D
        for <linux-kernel@vger.kernel.org>; Sun,  6 Aug 2023 17:52:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E14D6C433C8;
        Sun,  6 Aug 2023 17:52:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691344357;
        bh=GFtElTpnw8Awc2J5lB8COy884PMEifozgPjaaX6ierU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=lAR+DAW6Lc9+x7+XzVo6wIsyTTrTqhVrQijewLIqUAQ2mbJlKpc3U98aZvpGswOVx
         kRw11EUDkWIUJDl+/O9G/Epp96eeWYSWYm4ax79za7VuVcpiwBcxCCVkisM/R5maoO
         8U5iQmMWTiF+2iPowHSMFxSgsNRL2jgZ2cVOB2w6K4Tb58vUOL8DBgVMu2FiFKiIe4
         8fsvIStpMtGob3l+xc9cZJPpi+2UQOJoe76sK2mwS4D6pUv8L4k8qt6QTtyIHaKkfE
         tAINNyMBTzovDvdIxq/Wd5UC1uExcNyCgWZUZTyUvHkOg/mS8UGOqvQskhMdZfFPtL
         dk7K0vOSQK9Ng==
Message-ID: <8698e2f6-beac-b89f-5b7e-d9dbab267151@kernel.org>
Date:   Sun, 6 Aug 2023 12:52:35 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH RESEND^2] nios2: support clone3() syscall
Content-Language: en-US
To:     Randy Dunlap <rdunlap@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <brauner@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Christian Brauner <christian@brauner.io>
References: <20230802051924.7837-1-rdunlap@infradead.org>
 <20230802-abgaben-behutsam-92946d2ecbf5@brauner>
 <d2c8e5ca-44e0-41ec-84d0-ef743a62a2a1@app.fastmail.com>
 <0156b0e7-d9a9-0bb6-f0af-e6a49ff87e34@infradead.org>
From:   Dinh Nguyen <dinguyen@kernel.org>
In-Reply-To: <0156b0e7-d9a9-0bb6-f0af-e6a49ff87e34@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/2/23 10:43, Randy Dunlap wrote:
> 
> 
> On 8/2/23 01:16, Arnd Bergmann wrote:
>> On Wed, Aug 2, 2023, at 09:40, Christian Brauner wrote:
>>> On Tue, Aug 01, 2023 at 10:19:24PM -0700, Randy Dunlap wrote:
>>>> Add support for the clone3() syscall to prevent a warning from
>>>> checksyscalls.sh:
>>>>
>>>> <stdin>:1517:2: warning: #warning syscall clone3 not implemented [-Wcpp]
>>>>
>>>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>>>> Cc: Dinh Nguyen <dinguyen@kernel.org>
>>>> Cc: Christian Brauner <christian@brauner.io>
>>>> ---
>>>> Is there some reason that NIOS2 should not (does not) support clone3()?
>>>
>>> Cc Arnd, in case he knows.
>>
>> As far as I remember, you left a few architectures without clone3
>> during the introduction when there was neither an obvious way to
>> handle the syscall entry nor a maintainer to have a look.
>>
>> Right now, it seems to be missing on alpha, hexagon, ia64,
>> microblaze, nios2, sh and sparc.
>>
>> There are a few architectures that implement a custom entry
>> point for both clone and clone3. The other architectures that
>> provide the generic sys_clone3 also use the generic sys_clone.
>> These are the wrappers I see:
>>
>> # ARC
>> ENTRY(sys_clone3_wrapper)
>>          SAVE_CALLEE_SAVED_USER
>>          bl  @sys_clone3
>>          DISCARD_CALLEE_SAVED_USER
>>
>>          GET_CURR_THR_INFO_FLAGS   r10
>>          and.f 0, r10, _TIF_SYSCALL_WORK
>>          bnz   tracesys_exit
>>
>>          b .Lret_from_system_call
>> END(sys_clone3_wrapper)
>>
>> # m68k
>> ENTRY(__sys_clone3)
>>          SAVE_SWITCH_STACK
>>          pea     %sp@(SWITCH_STACK_SIZE)
>>          jbsr    m68k_clone3
>>          lea     %sp@(28),%sp
>>          rts
>>
>>
>> # mips
>> save_static_function(sys_clone3);
>>
>> # openrisc
>> ENTRY(__sys_clone3)
>>          l.movhi r29,hi(sys_clone3)
>>          l.j     _fork_save_extra_regs_and_call
>>           l.ori  r29,r29,lo(sys_clone3)
>>
>> # parisc
>>          .macro  fork_like name
>> ENTRY_CFI(sys_\name\()_wrapper)
>>          mfctl   %cr30,%r1
>>          ldo     TASK_REGS(%r1),%r1
>>          reg_save %r1
>>          mfctl   %cr27, %r28
>>          ldil    L%sys_\name, %r31
>>          be      R%sys_\name(%sr4,%r31)
>>          STREG   %r28, PT_CR27(%r1)
>> ENDPROC_CFI(sys_\name\()_wrapper)
>>          .endm
>> fork_like clone
>> fork_like clone3
>>
>> Nios3 in turn has a wrapper for sys_clone:
>> ENTRY(sys_clone)
>>          SAVE_SWITCH_STACK
>>          subi    sp, sp, 4 /* make space for tls pointer */
>>          stw     r8, 0(sp) /* pass tls pointer (r8) via stack (5th argument) */
>>          call    nios2_clone
>>          addi    sp, sp, 4
>>          RESTORE_SWITCH_STACK
>>          ret
>>
>> so my guess would be that it needs the same thing
>> for clone3 as well. Same thing on alpha, ia64 and
>> sparc. On the other hand hexagon, microblaze and sh
>> use the generic sys_clone() and can probably just
>> enable sys_clone3() without extra work unless it's
>> already broken.
> 
> OK, thanks for the help.
> 

Applied!

Thank you,
Dinh
