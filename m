Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C666D7BE5C2
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 18:01:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377110AbjJIQBs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 12:01:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230326AbjJIQBo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 12:01:44 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3383591;
        Mon,  9 Oct 2023 09:01:42 -0700 (PDT)
Received: from [192.168.100.7] (unknown [39.34.187.171])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id A44B2660716E;
        Mon,  9 Oct 2023 17:01:36 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1696867300;
        bh=JyCJjEdKDLAlTbnUu+YzmviHWlf4l4V/ZaDd4AoNfZ8=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=arLoE8vSMK/pwr6KnXQ+vQrYtq9qdcjIYiv7IEBKOikws56wuAIQVlTpi6EtrzhWu
         vRT33AmD8Cu+60weu9K6XF8Yro/M1RfKLQYWcPEH8sVUo4h5jUbZK98Ra5j1Kk/gAj
         +gWiNC6i7E+a6tfbo6+cCNAfNXq9OhPm6M3/1gwKayAfPBYAjoBtXuRYJftPOcq4TW
         o0flrKM6W11fUTtaKtOEhN8L8D2fMJIB3jUeuzWyRUFFd+T/7Q5NKdpSZzV6Q2WiJN
         WFhUYgyCq2y7c5CKsVlOpi14BRUJdgNuOy68ho6nJj8LT8vyGfw96J+jn0gSfymVEn
         89Id3+cpBkw1w==
Message-ID: <c3835e0a-97ef-4c95-9e2b-abb3092d3ef3@collabora.com>
Date:   Mon, 9 Oct 2023 21:01:33 +0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Ingo Molnar <mingo@elte.hu>, kernel@collabora.com,
        stable@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org
Subject: Re: [PATCH v3] tty/sysrq: replace smp_processor_id() with get_cpu()
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
References: <20230822102606.2821311-1-usama.anjum@collabora.com>
 <2023091835-quill-congress-b691@gregkh>
 <d0406751-829d-4892-9939-0e8873be3318@kernel.org>
 <2023091957-roundish-epilepsy-9686@gregkh>
Content-Language: en-US
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <2023091957-roundish-epilepsy-9686@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/19/23 12:13 PM, Greg Kroah-Hartman wrote:
> On Tue, Sep 19, 2023 at 07:52:42AM +0200, Jiri Slaby wrote:
>> On 18. 09. 23, 10:10, Greg Kroah-Hartman wrote:
>>> On Tue, Aug 22, 2023 at 03:26:06PM +0500, Muhammad Usama Anjum wrote:
>>>> The smp_processor_id() shouldn't be called from preemptible code.
>>>> Instead use get_cpu() and put_cpu() which disables preemption in
>>>> addition to getting the processor id. This fixes the following bug:
>>>>
>>>> [  119.143590] sysrq: Show backtrace of all active CPUs
>>>> [  119.143902] BUG: using smp_processor_id() in preemptible [00000000] code: bash/873
>>>> [  119.144586] caller is debug_smp_processor_id+0x20/0x30
>>>> [  119.144827] CPU: 6 PID: 873 Comm: bash Not tainted 5.10.124-dirty #3
>>>> [  119.144861] Hardware name: QEMU QEMU Virtual Machine, BIOS 2023.05-1 07/22/2023
>>>> [  119.145053] Call trace:
>>>> [  119.145093]  dump_backtrace+0x0/0x1a0
>>>> [  119.145122]  show_stack+0x18/0x70
>>>> [  119.145141]  dump_stack+0xc4/0x11c
>>>> [  119.145159]  check_preemption_disabled+0x100/0x110
>>>> [  119.145175]  debug_smp_processor_id+0x20/0x30
>>>> [  119.145195]  sysrq_handle_showallcpus+0x20/0xc0
>>>> [  119.145211]  __handle_sysrq+0x8c/0x1a0
>>>> [  119.145227]  write_sysrq_trigger+0x94/0x12c
>>>> [  119.145247]  proc_reg_write+0xa8/0xe4
>>>> [  119.145266]  vfs_write+0xec/0x280
>>>> [  119.145282]  ksys_write+0x6c/0x100
>>>> [  119.145298]  __arm64_sys_write+0x20/0x30
>>>> [  119.145315]  el0_svc_common.constprop.0+0x78/0x1e4
>>>> [  119.145332]  do_el0_svc+0x24/0x8c
>>>> [  119.145348]  el0_svc+0x10/0x20
>>>> [  119.145364]  el0_sync_handler+0x134/0x140
>>>> [  119.145381]  el0_sync+0x180/0x1c0
>>>>
>>>> Cc: stable@vger.kernel.org
>>>> Fixes: 47cab6a722d4 ("debug lockups: Improve lockup detection, fix generic arch fallback")
>>>> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
>>>> ---
>>>> Changes since v2:
>>>> - Add changelog and resend
>>>>
>>>> Changes since v1:
>>>> - Add "Cc: stable@vger.kernel.org" tag
>>>> ---
>>>>   drivers/tty/sysrq.c | 3 ++-
>>>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
>>>> index 23198e3f1461a..6b4a28bcf2f5f 100644
>>>> --- a/drivers/tty/sysrq.c
>>>> +++ b/drivers/tty/sysrq.c
>>>> @@ -262,13 +262,14 @@ static void sysrq_handle_showallcpus(u8 key)
>>>>   		if (in_hardirq())
>>>>   			regs = get_irq_regs();
>>>> -		pr_info("CPU%d:\n", smp_processor_id());
>>>> +		pr_info("CPU%d:\n", get_cpu());
>>>
>>> Why not call put_cpu() right here?
>>>
>>>>   		if (regs)
>>>>   			show_regs(regs);
>>>>   		else
>>>>   			show_stack(NULL, NULL, KERN_INFO);
>>>>   		schedule_work(&sysrq_showallcpus);
>>>> +		put_cpu();
>>>
>>> Why wait so long here after you have scheduled work?  Please drop the
>>> cpu reference right away, you don't need to hold it for this length of
>>> time, right?
>>
>> As I understand it, this way, schedule_work() will queue the work on the
>> "gotten" (current) CPU. So sysrq_showregs_othercpus() will really dump other
>> than the "gotten" cpu.
> 
> Ok, that makes a bit more sense, but that's not what the code does
> today, have people seen the regs dumped from the wrong cpu in the past?
> 
>> If that is the case, it indeed should have been described in the commit log.
Thanks for review. I'll add the explanation in the commit log and send again.

> 
> Agreed.
> 
> thanks for the review,
> 
> greg k-h

-- 
BR,
Muhammad Usama Anjum
