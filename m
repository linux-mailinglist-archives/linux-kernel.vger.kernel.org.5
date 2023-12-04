Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D61A803B27
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 18:09:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230391AbjLDRJY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 12:09:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjLDRJX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 12:09:23 -0500
Received: from kozue.soulik.info (kozue.soulik.info [IPv6:2001:19f0:7000:8404:5400:ff:fe00:d7d6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 544D7F0
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 09:09:29 -0800 (PST)
Received: from [192.168.10.7] (unknown [10.0.12.132])
        by kozue.soulik.info (Postfix) with ESMTPSA id BB0652FEC41;
        Tue,  5 Dec 2023 02:09:22 +0900 (JST)
DKIM-Filter: OpenDKIM Filter v2.11.0 kozue.soulik.info BB0652FEC41
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=soulik.info; s=mail;
        t=1701709763; bh=leU52NKS+4j0SOtSDOYOhhz0uxpcfS2T59lZis83zKw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=O7ErB/CxKhYKG4nlGKr3vsziESDbTDQTjRWFfYVZyrBf+FCitbkZmVsu61itW5BZC
         BkuhKzQiNSAx5PnL17tMdzbzYPgQ/GBUDRqn9TqyJCCrM6lOdEtd96b7Sl/Toh1ckQ
         LbywmuN0R9VIAgtnYioVywWwsOj7UpZDT/mMv5eM=
Message-ID: <1f282d44-7593-47f2-9572-131323f846a1@soulik.info>
Date:   Tue, 5 Dec 2023 01:09:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Could secure monitor let op-tee handle secure interrupter?
Content-Language: en-US
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org
References: <de1c35aa-1cbf-450a-9953-eee557c8e8ce@soulik.info>
 <CAFA6WYOUbix72jQ=UW8r_UspngBwVetnn89OdkN3skuzBqMhgg@mail.gmail.com>
From:   Randy Li <ayaka@soulik.info>
In-Reply-To: <CAFA6WYOUbix72jQ=UW8r_UspngBwVetnn89OdkN3skuzBqMhgg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2023/12/4 21:54, Sumit Garg wrote:
> Hi Randy,
>
> On Mon, 27 Nov 2023 at 13:03, Randy Li via OP-TEE
> <op-tee@lists.trustedfirmware.org> wrote:
>> Hello
>>
>> I was wondering whether the current op-tee os support this that secure
>> monitor would trigger the op-tee to handle the native interrupter
>> without forwarding it to the REE?
> I would suggest you to go through this doc [1] to see if it answers
> all your questions. If not then let us know, we will help to clarify
> further.
>
> [1] https://optee.readthedocs.io/en/latest/architecture/core.html#interrupt-handling
>
> -Sumit

"When a secure interrupt is signaled by the Arm GIC, it shall reach the 
OP-TEE OS interrupt exception vector. If the secure world is executing, 
OP-TEE OS will handle interrupt straight from its exception vector."

And Section "Deliver secure interrupt to secure world when SCR_NS is set"

I think those are the answer to my initial question.

But I didn't see such practice. In the recent changes to Linux kernel, 
likes OP-TEE notifications, I think the most of platforms would like not 
let the Secure OS handle the devices' interrupters? I didn't know such a 
driver in Linux kernel either.

When a CPU core, which is holding a spinlock, have been restored to 
Secure context by monitor, would it halt the other cores which are 
waiting for the release of that spinlock?

Besides, when we use a spinlock in the kernel, in the most of time, we 
except all IRQs are masked(spin_lock_irqsave), could this masked the 
secure interrupter?

Also, I didn't see there is a guideline about how OP-TEE os should 
handle native interrupt in this case. If it took too much time, it may 
lead an innocent process be regarded as hardlockup (or softlockup if it 
turns to REE after all) in the linux kernel.

>> If the answer is yes, could it lead to a dead lock when the linux kernel
>> is holding a spinlock(usually irq is disabled in that CPU core) ?
>>
>> I didn't find much about how should we handle the secure interrupter
>> from document, the general way seems to either forward it to REE or just
>> don't use the secure interrupter at all.
>>
>> Let the REE handle the interrupter may not be a good idea, since the
>> device could we should ack the interrupter in it, is protected by the
>> trustzone, we need to switch CPU to secure mode to handle this tiny task.
>>
>> I wish I could know more solution about the interrupter here.
>>
>> Sincerely
>>
>> Randy
>>
