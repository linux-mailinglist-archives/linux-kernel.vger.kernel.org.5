Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 519A1781BBE
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Aug 2023 02:31:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbjHTAbZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Aug 2023 20:31:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbjHTAbE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Aug 2023 20:31:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F8E75EC28
        for <linux-kernel@vger.kernel.org>; Sat, 19 Aug 2023 16:13:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E1E9C615DE
        for <linux-kernel@vger.kernel.org>; Sat, 19 Aug 2023 23:13:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDD4FC433C8;
        Sat, 19 Aug 2023 23:13:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692486833;
        bh=BVT53e23X9XrDvxuObUy2+IXkk6QBgsv6gatKgYdiEg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=h298QTxsdirjP/Roz1SRBzjZxKI4+ZKPs4qWphaFYV+jXcpxG9Wc3KlrpOiRezk6e
         QuFxTzHNBvGfZ0p0LJEc61AgRoa4KcacImdIQhi0YZJmLrDyUZUcTFt1zyEKpaigxb
         5/5rKWmSnNrkDXVXz7skXSNM41Z+nJPwqwOewE7QL4Z4cVcJ+gSq4Me/6fKmCupH04
         9Jykx4zMPWtAT2DxYcG625aKwzWK74VpgqweboXog6UDLkDq0ztsUvLaZTSKND18eB
         Y12HIH7qNv6XZTYsxk+4yobtxfagd35Qjy8Y5l5zXZZBbzrf+IdyofjUYtgTSA+TTe
         Y336IYxBriauw==
Message-ID: <3f555ce3-1bf7-d55d-bf84-da75659f1042@kernel.org>
Date:   Sat, 19 Aug 2023 16:13:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 16/20] ARC: entry: Add more common chores to
 EXCEPTION_PROLOGUE
Content-Language: en-US
To:     Pavel.Kozlov@synopsys.com, Vineet Gupta <vgupta@kernel.org>,
        linux-snps-arc@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        Shahab Vahedi <Shahab.Vahedi@synopsys.com>,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>
References: <20230815004813.555115-17-vgupta@kernel.org>
 <20230818125652.3981-1-kozlov@synopsys.com>
From:   Vineet Gupta <vgupta@kernel.org>
In-Reply-To: <20230818125652.3981-1-kozlov@synopsys.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/18/23 05:56, Pavel.Kozlov@synopsys.com wrote:
> Hi Vineet,
>
>> Subject: [PATCH 16/20] ARC: entry: Add more common chores to
>>          EXCEPTION_PROLOGUE
>>
>> THe high level structure of most ARC exception handlers is
>>   1. save regfile with EXCEPTION_PROLOGUE
>>   2. setup r0: EFA (not part of pt_regs)
>>   3. setup r1: pointer to pt_regs (SP)
>>   4. drop down to pure kernel mode (from exception)
>>   5. call the Linux "C" handler
>>
>> Remove the boiler plate code by moving #2, #3, #4 into #1.
>>
>> The exceptions to most exceptions are syscall Trap and Machine check
>> which don't do some of above for various reasons, so call a newly
>> introduced variant EXCEPTION_PROLOGUE_KEEP_AE (same as original
>> EXCEPTION_PROLOGUE)
> I'm observing the ARC700 (nSIM) system freeze after this patch.
>
> ...
> f0000000.serial: ttyS0 at MMIO 0xf0000000 (irq = 24, base_baud = 3125000) is a 16550A
> printk: console [ttyS0] enabled
> printk: console [ttyS0] enabled
> printk: bootconsole [uart8250] disabled
> printk: bootconsole [uart8250] disabled
> NET: Registered PF_PACKET protocol family
> NET: Registered PF_KEY protocol family
> clk: Disabling unused clocks
> Freeing unused kernel image (initmem) memory: 2856K
> This architecture does not have kernel memory protection.
> Run /init as init process
>
>> @@ -128,11 +123,6 @@ ENTRY(EV_PrivilegeV)
>>
>>           EXCEPTION_PROLOGUE
>>
>> -       lr  r0, [efa]
>> -       mov r1, sp
>> -
>> -       FAKE_RET_FROM_EXCPN
>> -
>>           bl  do_privilege_fault
>>           b   ret_from_exception
> The same update is also required for the call_do_page_fault wrapper for ARcompact.

Indeed I missed that part.

-Vineet
