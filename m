Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56B4176D2AB
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 17:43:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235153AbjHBPnf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 11:43:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235509AbjHBPn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 11:43:26 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B222F9B
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 08:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=NDZYgKKNmkQ0738L3ra1Xs11boy5q4PyNH1Y5BeFCWQ=; b=jldpaGZwhwgeJhKxJNZKE/bGNP
        bzSJGPy9Uo+I07AXE0ITW86MbRlaPir7nfwsPOxPmohFCfvQWFXyOxCfOG75Gt+yF4gft4A1uRLeH
        woLdk0K/FwbZb/4fr/TylvA5dy2fU0JrbeE5JdcPw9v10SZFLYSPuOf5hEey6GOSQSYwAnvOHY8dp
        CKElFmXvX5+5ucV98CG6on01rDrv9eDvW8Dp6oEXbiR1VaOg3S2PtRUf5rdmkB1yRmoNo/Cg57839
        kx2yY0TGTOpNwjV9SOHvV+QcFbe3X9oAZWC4wctsQxjLuECygA8rqcUIEjr9P0BW92NR4AhHsj18M
        GemqlxRg==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qRE0R-005GUn-26;
        Wed, 02 Aug 2023 15:43:23 +0000
Message-ID: <0156b0e7-d9a9-0bb6-f0af-e6a49ff87e34@infradead.org>
Date:   Wed, 2 Aug 2023 08:43:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH RESEND^2] nios2: support clone3() syscall
Content-Language: en-US
To:     Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <brauner@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Dinh Nguyen <dinguyen@kernel.org>,
        Christian Brauner <christian@brauner.io>
References: <20230802051924.7837-1-rdunlap@infradead.org>
 <20230802-abgaben-behutsam-92946d2ecbf5@brauner>
 <d2c8e5ca-44e0-41ec-84d0-ef743a62a2a1@app.fastmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <d2c8e5ca-44e0-41ec-84d0-ef743a62a2a1@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/2/23 01:16, Arnd Bergmann wrote:
> On Wed, Aug 2, 2023, at 09:40, Christian Brauner wrote:
>> On Tue, Aug 01, 2023 at 10:19:24PM -0700, Randy Dunlap wrote:
>>> Add support for the clone3() syscall to prevent a warning from
>>> checksyscalls.sh:
>>>
>>> <stdin>:1517:2: warning: #warning syscall clone3 not implemented [-Wcpp]
>>>
>>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>>> Cc: Dinh Nguyen <dinguyen@kernel.org>
>>> Cc: Christian Brauner <christian@brauner.io>
>>> ---
>>> Is there some reason that NIOS2 should not (does not) support clone3()?
>>
>> Cc Arnd, in case he knows.
> 
> As far as I remember, you left a few architectures without clone3
> during the introduction when there was neither an obvious way to
> handle the syscall entry nor a maintainer to have a look.
> 
> Right now, it seems to be missing on alpha, hexagon, ia64,
> microblaze, nios2, sh and sparc.
> 
> There are a few architectures that implement a custom entry
> point for both clone and clone3. The other architectures that
> provide the generic sys_clone3 also use the generic sys_clone.
> These are the wrappers I see:
> 
> # ARC
> ENTRY(sys_clone3_wrapper)
>         SAVE_CALLEE_SAVED_USER
>         bl  @sys_clone3
>         DISCARD_CALLEE_SAVED_USER
> 
>         GET_CURR_THR_INFO_FLAGS   r10
>         and.f 0, r10, _TIF_SYSCALL_WORK
>         bnz   tracesys_exit
> 
>         b .Lret_from_system_call
> END(sys_clone3_wrapper)
> 
> # m68k
> ENTRY(__sys_clone3)
>         SAVE_SWITCH_STACK
>         pea     %sp@(SWITCH_STACK_SIZE)
>         jbsr    m68k_clone3
>         lea     %sp@(28),%sp
>         rts
> 
> 
> # mips
> save_static_function(sys_clone3);
> 
> # openrisc
> ENTRY(__sys_clone3)
>         l.movhi r29,hi(sys_clone3)
>         l.j     _fork_save_extra_regs_and_call
>          l.ori  r29,r29,lo(sys_clone3)
> 
> # parisc
>         .macro  fork_like name
> ENTRY_CFI(sys_\name\()_wrapper)
>         mfctl   %cr30,%r1
>         ldo     TASK_REGS(%r1),%r1
>         reg_save %r1
>         mfctl   %cr27, %r28
>         ldil    L%sys_\name, %r31
>         be      R%sys_\name(%sr4,%r31)
>         STREG   %r28, PT_CR27(%r1)
> ENDPROC_CFI(sys_\name\()_wrapper)
>         .endm
> fork_like clone
> fork_like clone3
> 
> Nios3 in turn has a wrapper for sys_clone:
> ENTRY(sys_clone)
>         SAVE_SWITCH_STACK
>         subi    sp, sp, 4 /* make space for tls pointer */
>         stw     r8, 0(sp) /* pass tls pointer (r8) via stack (5th argument) */
>         call    nios2_clone
>         addi    sp, sp, 4
>         RESTORE_SWITCH_STACK
>         ret
> 
> so my guess would be that it needs the same thing
> for clone3 as well. Same thing on alpha, ia64 and
> sparc. On the other hand hexagon, microblaze and sh 
> use the generic sys_clone() and can probably just
> enable sys_clone3() without extra work unless it's
> already broken.

OK, thanks for the help.

-- 
~Randy
