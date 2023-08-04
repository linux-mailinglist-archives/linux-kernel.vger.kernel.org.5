Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F64A7702D2
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 16:19:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231656AbjHDOTc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 10:19:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbjHDOTb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 10:19:31 -0400
Received: from smtpout.efficios.com (unknown [IPv6:2607:5300:203:b2ee::31e5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53F171994
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 07:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1691158763;
        bh=8N0/Ipxy1IIEv+7V9seC0pyf9Fmr6LZitvst5gG2Urw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=kPUDr0QkoJ80C88DLExAAzVxBuxHzvLT4DRPE13cahq3XYz/cqSW/xRBrU7sUmumf
         B2ab4FI41aeFzq9aplvbu6vcDxYNLmKH6L8eOV0OOwR9BUwGM/KklwggIUZ1BPJ7/U
         8CuJ3xu7dcZE/2fS5Hgk6BLMLuW0/LkIVcM4kbdEpinTNBDkKL/9gqPZd6Zi4GhReO
         nHppH4nAiOjjjOukkdU2ZyCDOHN1dU9A1WPiJJKIMB0PvAYqBbXCjS9/Jhz6nO++82
         STOBjhjqoAZGunkr+TgSziBb6Zl9utKS1tBzuDmBj6/PKU/fqnIR/iJHPOGr1KkC5F
         MSo12onLq01gQ==
Received: from [IPV6:2605:59c8:2711:c800::c66] (unknown [IPv6:2605:59c8:2711:c800::c66])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4RHSWt413Wz1Kh6;
        Fri,  4 Aug 2023 10:19:22 -0400 (EDT)
Message-ID: <65350c17-3fcf-a057-a280-f6a5d36dcb21@efficios.com>
Date:   Fri, 4 Aug 2023 10:20:16 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC PATCH] membarrier: riscv: Provide core serializing command
Content-Language: en-US
To:     Andrea Parri <parri.andrea@gmail.com>
Cc:     paulmck@kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, mmaas@google.com, hboehm@google.com,
        striker@us.ibm.com
References: <20230803040111.5101-1-parri.andrea@gmail.com>
 <ZMvLoI6PxLR8RJvR@andrea> <4bf79f06-4593-134a-04dd-b8f89e96a1b8@efficios.com>
 <ZMxDe0gXKYbY5jgt@andrea>
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <ZMxDe0gXKYbY5jgt@andrea>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/3/23 20:16, Andrea Parri wrote:
>> Can you double-check that riscv switch_mm() implies a fence.i or equivalent
>> on the CPU doing the switch_mm ?
> 
> AFAICT, (riscv) switch_mm() does not guarantee that.
> 
> 
>> AFAIR membarrier use of sync_core_before_usermode relies on switch_mm
>> issuing a core serializing instruction.
> 
> I see.  Thanks for the clarification.
> 
> BTW, the comment in __schedule() suggests that membarrier also relies on
> switch_mm() issuing a full memory barrier: I don't think this holds.
> 
> Removing the "deferred icache flush" logic in switch_mm() - in favour of
> a "plain" MB; FENCE.I - would meet both of these requirements.

What is the relationship between FENCE.I and instruction cache flush on 
RISC-V ?

On other architectures, there is need for careful flushing of the 
instruction cache for the address range that was modified, _and_ to 
issue a core serializing instruction on all cores (this last part being 
performed by membarrier SYNC_CORE) between the point where the old 
instructions were executed and before the new instructions are executed.

Thanks,

Mathieu

> 
> Other ideas?
> 
>    Andrea

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

