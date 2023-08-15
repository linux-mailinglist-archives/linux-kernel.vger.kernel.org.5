Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1E1377CCE0
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 14:45:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237255AbjHOMpM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 08:45:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237272AbjHOMop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 08:44:45 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 060B81B2;
        Tue, 15 Aug 2023 05:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1692103466; x=1692708266; i=deller@gmx.de;
 bh=Qy6ZjM+WbSo/PV82lPa4mgAugqyl9sOVrw4vzJKI45w=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=a5zSyVQhsDXL43FRvrtcxn+SSM0xx8gs/koOfI6UTZ/YdLniLpX3IUEc9RUPhaU46eoFsTb
 UYdTaLONbNzDDS35UtcuJVNnf8Y8FUz5vqB3+FlQ2Mesn8hVg+FOYjF7PNCT3Yl16uMx+RBSi
 KWvquPypbGfDCNyhVQeJtlKg9e8LZRHdUekIXpRt+EUcVrCHC1cTg2RvZFM08x3fHYFTNYhws
 owx0cNKqbYUdtRezcnz9t6XM2QYgZRJWADglmdseqfh0DuMZc56wqLRjwZmnMK1u/hqVFqgCL
 /gzm9/twQXNzroThN6MXO/a6xkAmJnf8xwdCq0zOi4ELT8qqH7+g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.60] ([94.134.159.222]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MNsw4-1q7cKQ1RjE-00OHvX; Tue, 15
 Aug 2023 14:44:26 +0200
Message-ID: <4be239c7-86be-f88d-508f-e0245538ce15@gmx.de>
Date:   Tue, 15 Aug 2023 14:44:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] watchdog: Fix lockdep warning
To:     Petr Mladek <pmladek@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>, Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>
References: <ZNZr0mPsIuqKzb5u@p100> <ZNtnX7m_lHE0u-g1@alley>
Content-Language: en-US
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <ZNtnX7m_lHE0u-g1@alley>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:kLLOldtyWFnN8V5Ls7O8BrsZx37nuzZ0lpgabX5aMdeJFQ74j+a
 x1oA6um53mdoO00Q3zOJn8ECKJTIm3SRucS6AmmqSZYPibbfX66lHmh47iOtcjYUANy/sHs
 Y6HUoHwo1p9JMcBsZerrApRxnhd5ACe4ACSehcnVMBI8+PTrl7PJZ8Ey6GXsBUeg1OeWFEN
 gB7tUfKg+F/smyt0OcwAQ==
UI-OutboundReport: notjunk:1;M01:P0:FOPgzvkpKXU=;ZR37RzhgPRIuS1O0JxGfaZjh1Lt
 2VNPIiLTgrOMEAMeMdqgZDUWlUA5WskOYFfW+2mZY4RHlFSPns5GOoGY9Zp9DJU7uZtqjnJCM
 2IIZpHupd00Vhn/Eqz6skUn8WOYo0wSYn1Z/bFNhxsRmiwB+h4h7d+L4R2t+KvA72E41dzHR6
 6MJRDz0kxLeyqBaKYriPe0uUYQ9NKXGntlXw5jGSThu27TXBjBEO6/8NDzzT+ffH+2itfhGTS
 9pYbyGZSws5/xVDWrub5I7BM7LSJMD5b+MgINPFyvJhiHX1hy1jwo0JThSAosfDBDgocmQmxM
 6nBEdk5O69wZwDLp6J0q0fiW5rnhGMU2qWKr/jczuyTn7HRdzYAK20ud0xhzMV9/GoakMj38s
 96nGL3yJs/Wt8MOwVrdwrETIkvK95Z05N2kTSLA7b370seFT8+DQexW5JHGui0O2CGaTh7rJm
 3R3ekf/CvQyR35x2nf1kVxP2dc1DMQi1esFLt4VHnZqp4ItMrQSMPGYeX37VdL1AKd9UgTos9
 1T5SdCfSUA4/rAGuKUvV/OGFmI0MYF513nkhPC0VdFObkVj9zanIgT0vJMofl6snEr7O10UWO
 5jt48Nbruob2IwdDK9GVGZvjw7QepKhUaIAQelp5BguekTqnc3NqVdKZF12zGGdp9s5j7SIdr
 JX9p12PCHksjkJJuHouh/u+UlWFuAA5tnjPupnDPgmoce3hhAky9Qk4sMP2zSVAuLAiZzNFa2
 98PvZ0hMsCWH9jO/+Y/Kx1+l3pNTjH37cjGRcYooYGBxq2lp/X4rMlU2hNaOgKsbX6Bd2nCHK
 Q8cB4z4jTuQ4RoMrSmBsm3leeKByWLg6nQ46ewGcb0aabDL6vMSEiY8n80fpI40kluJOgUXHt
 pWwaEKSa2O6PjDmE4l0s51LpsWXS1uq3OOXucmcHVQZDqc1xTtY06muOvrhf5433MtrdL+Mez
 R8Q2qwvM2kkL4Gu8Z+l9xrtC+I4=
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/15/23 13:54, Petr Mladek wrote:
> Adding workqueue and lockdep people into Cc.
>
> On Fri 2023-08-11 19:11:46, Helge Deller wrote:
>> Fully initialize detector_work work struct to avoid this kernel warning
>> when lockdep is enabled:
>>
>>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>   WARNING: bad unlock balance detected!
>>   6.5.0-rc5+ #687 Not tainted
>>   -------------------------------------
>>   swapper/0/1 is trying to release lock (detector_work) at:
>>   [<000000004037e554>] __flush_work+0x60/0x658
>>   but there are no more locks to release!
>>
>>   other info that might help us debug this:
>>   no locks held by swapper/0/1.
>>
>>   stack backtrace:
>>   CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.5.0-rc5+ #687
>>   Hardware name: 9000/785/C3700
>>   Backtrace:
>>    [<0000000041455d5c>] print_unlock_imbalance_bug.part.0+0x20c/0x230
>>    [<000000004040d5e8>] lock_release+0x2e8/0x3f8
>>    [<000000004037e5cc>] __flush_work+0xd8/0x658
>>    [<000000004037eb7c>] flush_work+0x30/0x60
>>    [<000000004011f140>] lockup_detector_check+0x54/0x128
>>    [<0000000040306430>] do_one_initcall+0x9c/0x408
>>    [<0000000040102d44>] kernel_init_freeable+0x688/0x7f0
>>    [<000000004146df68>] kernel_init+0x64/0x3a8
>>    [<0000000040302020>] ret_from_kernel_thread+0x20/0x28
>>
>> Signed-off-by: Helge Deller <deller@gmx.de>
>>
>> ---
>>
>> diff --git a/kernel/watchdog.c b/kernel/watchdog.c
>> index be38276a365f..eab0dfcfa3f9 100644
>> --- a/kernel/watchdog.c
>> +++ b/kernel/watchdog.c
>> @@ -1022,5 +1022,6 @@ void __init lockup_detector_init(void)
>>   	else
>>   		allow_lockup_detector_init_retry =3D true;
>>
>> +	INIT_WORK(&detector_work, lockup_detector_delay_init);
>>   	lockup_detector_setup();
>>   }
>
> Strange. The work is initialized when declared:
>
> static struct work_struct detector_work __initdata =3D
> 		__WORK_INITIALIZER(detector_work, lockup_detector_delay_init);
>
> , which should initialize the lockdep map as well. I would expect
> this is enough.

Right. It's enough...

> And I do not see this on x86_64 with CONFIG_PROVE_LOCKING=3Dy
> on today's Linus' tree. And the flush_work() is always called
> from the lockup_detector_check() late init call.
>
> IMHO, it must be a bug somewhere else. Otherwise, many other
> users of DECLARE_WORK() or __WORK_INITIALIZER() would have
> the same problem.

Right. I should have replied earlier to this patch.
Andrew already dropped this patch here from his patch collection.

It turns out the problem is in function static_obj() from
lockdep, which doesn't recognize the __initdata section
for all platforms.

Please look at this patch on the LKML instead, which
fixes the real problem:
[PATCH v2] lockdep: Fix static memory detection even more

Thanks!
Helge
