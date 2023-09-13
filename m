Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 954A279DF6C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 07:30:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238315AbjIMFan (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 01:30:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232858AbjIMFai (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 01:30:38 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E6D71734;
        Tue, 12 Sep 2023 22:30:34 -0700 (PDT)
Received: from [192.168.100.7] (unknown [59.103.218.185])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id D6A996607319;
        Wed, 13 Sep 2023 06:30:29 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1694583031;
        bh=QyQihaw5qvrloeqI+myxpbxwvzMeDS3foepHXVwjQpg=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=ZDI7OQhyXJvrX3SKacW3VISdi1FqmRGm/wF2bwhpujO8jzBeQtjSOFn2NW/plAISU
         FUBtY29z7WshWYMh2hGLlXg+wFDTUQKg+b+U73BGbvyh04N7iNIHco0/ybVBWt3qpF
         R5Rn1XElYJKXuN6/vkSI7shgA5a6hButrq7lZ/1Boyumcp7uL3bAKQieKyT4vUHzQY
         429fXkpw1EQGOonGbFMFvNmqsoqdpC9LUkV73vWYt0LiDQuVSopISBEGDzt2TXR/No
         9VIBOegGV1BO87lVfqzXKQYNhFtQiGwv0AZtN5/Ab+Qr8+mJDWPH1OQM4SD7wzAJeZ
         v5Q6GBuy0cy2Q==
Message-ID: <120e7e65-debc-4677-a080-49b9bc917e36@collabora.com>
Date:   Wed, 13 Sep 2023 10:30:25 +0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Jiri Slaby <jirislaby@kernel.org>, Ingo Molnar <mingo@elte.hu>,
        kernel@collabora.com, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH v3] tty/sysrq: replace smp_processor_id() with get_cpu()
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20230822102606.2821311-1-usama.anjum@collabora.com>
 <2023082258-lethargic-hazily-5c7e@gregkh>
 <deab26bd-7db4-422a-8e58-6ea56ed0b200@collabora.com>
Content-Language: en-US
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <deab26bd-7db4-422a-8e58-6ea56ed0b200@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/23/23 4:06 PM, Muhammad Usama Anjum wrote:
> On 8/22/23 6:24 PM, Greg Kroah-Hartman wrote:
>> On Tue, Aug 22, 2023 at 03:26:06PM +0500, Muhammad Usama Anjum wrote:
>>> The smp_processor_id() shouldn't be called from preemptible code.
>>> Instead use get_cpu() and put_cpu() which disables preemption in
>>> addition to getting the processor id. This fixes the following bug:
>>>
>>> [  119.143590] sysrq: Show backtrace of all active CPUs
>>> [  119.143902] BUG: using smp_processor_id() in preemptible [00000000] code: bash/873
>>> [  119.144586] caller is debug_smp_processor_id+0x20/0x30
>>> [  119.144827] CPU: 6 PID: 873 Comm: bash Not tainted 5.10.124-dirty #3
>>> [  119.144861] Hardware name: QEMU QEMU Virtual Machine, BIOS 2023.05-1 07/22/2023
>>> [  119.145053] Call trace:
>>> [  119.145093]  dump_backtrace+0x0/0x1a0
>>> [  119.145122]  show_stack+0x18/0x70
>>> [  119.145141]  dump_stack+0xc4/0x11c
>>> [  119.145159]  check_preemption_disabled+0x100/0x110
>>> [  119.145175]  debug_smp_processor_id+0x20/0x30
>>> [  119.145195]  sysrq_handle_showallcpus+0x20/0xc0
>>> [  119.145211]  __handle_sysrq+0x8c/0x1a0
>>> [  119.145227]  write_sysrq_trigger+0x94/0x12c
>>> [  119.145247]  proc_reg_write+0xa8/0xe4
>>> [  119.145266]  vfs_write+0xec/0x280
>>> [  119.145282]  ksys_write+0x6c/0x100
>>> [  119.145298]  __arm64_sys_write+0x20/0x30
>>> [  119.145315]  el0_svc_common.constprop.0+0x78/0x1e4
>>> [  119.145332]  do_el0_svc+0x24/0x8c
>>> [  119.145348]  el0_svc+0x10/0x20
>>> [  119.145364]  el0_sync_handler+0x134/0x140
>>> [  119.145381]  el0_sync+0x180/0x1c0
>>>
>>> Cc: stable@vger.kernel.org
>>> Fixes: 47cab6a722d4 ("debug lockups: Improve lockup detection, fix generic arch fallback")This commit had introduced the smp_processor_id() function in
> sysrq_handle_showallcpus().
> 
>>
>> How has this never shown up before now?  What changed to cause this to
>> now be triggered?  This feels odd that no one has seen this in the past
>> 20+ years :(
> Not sure. Probably the combination of reproduction has happened now. The
> following three conditions are needed for the warning to appear:
> * Enable CONFIG_DEBUG_PREEMPT
> * Arch which doesn't define arch_trigger_all_cpu_backtrace such as arm64
> * Trigger showallcpu's stack sysrq

Any thoughts about the patch?

> 
>>
>>
>>> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
>>> ---
>>> Changes since v2:
>>> - Add changelog and resend
>>>
>>> Changes since v1:
>>> - Add "Cc: stable@vger.kernel.org" tag
>>> ---
>>>  drivers/tty/sysrq.c | 3 ++-
>>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
>>> index 23198e3f1461a..6b4a28bcf2f5f 100644
>>> --- a/drivers/tty/sysrq.c
>>> +++ b/drivers/tty/sysrq.c
>>> @@ -262,13 +262,14 @@ static void sysrq_handle_showallcpus(u8 key)
>>>  		if (in_hardirq())
>>>  			regs = get_irq_regs();
>>>  
>>> -		pr_info("CPU%d:\n", smp_processor_id());
>>> +		pr_info("CPU%d:\n", get_cpu());
>>>  		if (regs)
>>>  			show_regs(regs);
>>>  		else
>>>  			show_stack(NULL, NULL, KERN_INFO);
>>>  
>>>  		schedule_work(&sysrq_showallcpus);
>>> +		put_cpu();
>>
>> Why are you putting the cpu _after_ you schedule the work?
> The sysrq_showallcpus work prints stack traces on all CPUs other than the
> current CPU. So we are re-enabling preemption after scheduling work from
> current CPU. So that it doesn't get changed.
>>
>> thanks,
>>
>> greg k-h
> 

-- 
BR,
Muhammad Usama Anjum
