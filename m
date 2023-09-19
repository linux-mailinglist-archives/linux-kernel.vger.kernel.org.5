Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 326EA7A599B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 07:52:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231481AbjISFw4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 01:52:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230513AbjISFwv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 01:52:51 -0400
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A611114;
        Mon, 18 Sep 2023 22:52:46 -0700 (PDT)
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-53136a13cd4so1628826a12.1;
        Mon, 18 Sep 2023 22:52:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695102764; x=1695707564;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JOcQqm5T2l7FnqzIqZfGQiR6q/pI6ROhu9GBQdAWfvo=;
        b=GtW8wyqTpFJLAoB8rt12TiETqgKCFy/cNTCngTVqcC/uGJw8ITNQLskPxf6c0ggfK+
         c+ZmS+y7DKtIkbQ9UlS19IbX//DgbyZrq3FDVfZ9/C0PzhIin/wZNLQ22vNV0PL+1jNA
         PKkfEEaOvNj3jNL3T8s5D4bgwGguxt0YsxaDSQj+cgOSCZIHWCoWAbG42eVdT4hHItNw
         1IplCgWfTCvN5wdtZv3BnlE7QEIfxVLYd/ohOtV57jYYBThlC2LQdyVOKcU8KZ/3ku74
         XWWVXBWhyk64x12Cv0afjoTHe2MzRnB7FBBYmLVfz6KbS++wGWcfaH27Tq6Gh5R3kFOK
         q7IQ==
X-Gm-Message-State: AOJu0Yw7xyAmTQaO/OF+pawGT52mvQ/ok3rbmXIroJq2Hp8SOANGg1Ne
        4fXqQyEBYdbVYjaCvMDRe6s=
X-Google-Smtp-Source: AGHT+IFDojkH8mbhi3nGxmR/46Ua2sUlAaT2McBPmJHqfb5qbcQ+woAXm5/fdtF2TKJmc+PAxQzDPg==
X-Received: by 2002:a17:906:2921:b0:992:7295:61c9 with SMTP id v1-20020a170906292100b00992729561c9mr9021336ejd.69.1695102763492;
        Mon, 18 Sep 2023 22:52:43 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:59? ([2a0b:e7c0:0:107::aaaa:59])
        by smtp.gmail.com with ESMTPSA id i23-20020a170906851700b00977eec7b7e8sm7326588ejx.68.2023.09.18.22.52.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Sep 2023 22:52:43 -0700 (PDT)
Message-ID: <d0406751-829d-4892-9939-0e8873be3318@kernel.org>
Date:   Tue, 19 Sep 2023 07:52:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] tty/sysrq: replace smp_processor_id() with get_cpu()
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc:     Ingo Molnar <mingo@elte.hu>, kernel@collabora.com,
        stable@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org
References: <20230822102606.2821311-1-usama.anjum@collabora.com>
 <2023091835-quill-congress-b691@gregkh>
From:   Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <2023091835-quill-congress-b691@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18. 09. 23, 10:10, Greg Kroah-Hartman wrote:
> On Tue, Aug 22, 2023 at 03:26:06PM +0500, Muhammad Usama Anjum wrote:
>> The smp_processor_id() shouldn't be called from preemptible code.
>> Instead use get_cpu() and put_cpu() which disables preemption in
>> addition to getting the processor id. This fixes the following bug:
>>
>> [  119.143590] sysrq: Show backtrace of all active CPUs
>> [  119.143902] BUG: using smp_processor_id() in preemptible [00000000] code: bash/873
>> [  119.144586] caller is debug_smp_processor_id+0x20/0x30
>> [  119.144827] CPU: 6 PID: 873 Comm: bash Not tainted 5.10.124-dirty #3
>> [  119.144861] Hardware name: QEMU QEMU Virtual Machine, BIOS 2023.05-1 07/22/2023
>> [  119.145053] Call trace:
>> [  119.145093]  dump_backtrace+0x0/0x1a0
>> [  119.145122]  show_stack+0x18/0x70
>> [  119.145141]  dump_stack+0xc4/0x11c
>> [  119.145159]  check_preemption_disabled+0x100/0x110
>> [  119.145175]  debug_smp_processor_id+0x20/0x30
>> [  119.145195]  sysrq_handle_showallcpus+0x20/0xc0
>> [  119.145211]  __handle_sysrq+0x8c/0x1a0
>> [  119.145227]  write_sysrq_trigger+0x94/0x12c
>> [  119.145247]  proc_reg_write+0xa8/0xe4
>> [  119.145266]  vfs_write+0xec/0x280
>> [  119.145282]  ksys_write+0x6c/0x100
>> [  119.145298]  __arm64_sys_write+0x20/0x30
>> [  119.145315]  el0_svc_common.constprop.0+0x78/0x1e4
>> [  119.145332]  do_el0_svc+0x24/0x8c
>> [  119.145348]  el0_svc+0x10/0x20
>> [  119.145364]  el0_sync_handler+0x134/0x140
>> [  119.145381]  el0_sync+0x180/0x1c0
>>
>> Cc: stable@vger.kernel.org
>> Fixes: 47cab6a722d4 ("debug lockups: Improve lockup detection, fix generic arch fallback")
>> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
>> ---
>> Changes since v2:
>> - Add changelog and resend
>>
>> Changes since v1:
>> - Add "Cc: stable@vger.kernel.org" tag
>> ---
>>   drivers/tty/sysrq.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
>> index 23198e3f1461a..6b4a28bcf2f5f 100644
>> --- a/drivers/tty/sysrq.c
>> +++ b/drivers/tty/sysrq.c
>> @@ -262,13 +262,14 @@ static void sysrq_handle_showallcpus(u8 key)
>>   		if (in_hardirq())
>>   			regs = get_irq_regs();
>>   
>> -		pr_info("CPU%d:\n", smp_processor_id());
>> +		pr_info("CPU%d:\n", get_cpu());
> 
> Why not call put_cpu() right here?
> 
>>   		if (regs)
>>   			show_regs(regs);
>>   		else
>>   			show_stack(NULL, NULL, KERN_INFO);
>>   
>>   		schedule_work(&sysrq_showallcpus);
>> +		put_cpu();
> 
> Why wait so long here after you have scheduled work?  Please drop the
> cpu reference right away, you don't need to hold it for this length of
> time, right?

As I understand it, this way, schedule_work() will queue the work on the 
"gotten" (current) CPU. So sysrq_showregs_othercpus() will really dump 
other than the "gotten" cpu.

If that is the case, it indeed should have been described in the commit log.

regards,
-- 
js
suse labs

