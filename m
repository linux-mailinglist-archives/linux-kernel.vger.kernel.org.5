Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC6BA7BCD70
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 11:14:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344516AbjJHJMt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Oct 2023 05:12:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230441AbjJHJMr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Oct 2023 05:12:47 -0400
Received: from out-195.mta0.migadu.com (out-195.mta0.migadu.com [91.218.175.195])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9EABBA
        for <linux-kernel@vger.kernel.org>; Sun,  8 Oct 2023 02:12:45 -0700 (PDT)
Message-ID: <4a747fda-2bb9-4231-66d6-31306184eec2@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1696756363;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+bG1Q3u3bRF3BO7YzEUH3MczQImA0t9o01BdRVZ0j+Q=;
        b=wleWIFJNNAI6Ii4FmYo+ZyLkU+Vlz38vwONmPwnZ5ayUMG6j7FHn1nu9jJrKA5QFbZJFPm
        iIMR5bkAbCk2sVaI89M4aft19LKV7WyFTOBlkxVfhj/NozpRJ4A/R4wIUIL864jvAzxlym
        LEw1onuJsuv0W7pbMyyggFLfOeTUhgs=
Date:   Sun, 8 Oct 2023 17:12:34 +0800
MIME-Version: 1.0
Subject: Re: [PATCH net-next v7] net/core: Introduce netdev_core_stats_inc()
Content-Language: en-US
To:     Eric Dumazet <edumazet@google.com>, rostedt@goodmis.org
Cc:     davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexander Lobakin <aleksander.lobakin@intel.com>
References: <20231007050621.1706331-1-yajun.deng@linux.dev>
 <CANn89iL-zUw1FqjYRSC7BGB0hfQ5uKpJzUba3YFd--c=GdOoGg@mail.gmail.com>
 <917708b5-cb86-f233-e878-9233c4e6c707@linux.dev>
 <CANn89i+navyRe8-AV=ehM3qFce2hmnOEKBqvK5Xnev7KTaS5Lg@mail.gmail.com>
 <a53a3ff6-8c66-07c4-0163-e582d88843dd@linux.dev>
 <CANn89i+u5dXdYm_0_LwhXg5Nw+gHXx+nPUmbYhvT=k9P4+9JRQ@mail.gmail.com>
 <9f4fb613-d63f-9b86-fe92-11bf4dfb7275@linux.dev>
 <CANn89iK7bvQtGD=p+fHaWiiaNn=u8vWrt0YQ26pGQY=kZTdfJw@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Yajun Deng <yajun.deng@linux.dev>
In-Reply-To: <CANn89iK7bvQtGD=p+fHaWiiaNn=u8vWrt0YQ26pGQY=kZTdfJw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2023/10/8 16:53, Eric Dumazet wrote:
> On Sun, Oct 8, 2023 at 10:44 AM Yajun Deng <yajun.deng@linux.dev> wrote:
>>
>> On 2023/10/8 15:18, Eric Dumazet wrote:
>>> On Sun, Oct 8, 2023 at 9:00 AM Yajun Deng <yajun.deng@linux.dev> wrote:
>>>> On 2023/10/8 14:45, Eric Dumazet wrote:
>>>>> On Sat, Oct 7, 2023 at 8:34 AM Yajun Deng <yajun.deng@linux.dev> wrote:
>>>>>> On 2023/10/7 13:29, Eric Dumazet wrote:
>>>>>>> On Sat, Oct 7, 2023 at 7:06 AM Yajun Deng <yajun.deng@linux.dev> wrote:
>>>>>>>> Although there is a kfree_skb_reason() helper function that can be used to
>>>>>>>> find the reason why this skb is dropped, but most callers didn't increase
>>>>>>>> one of rx_dropped, tx_dropped, rx_nohandler and rx_otherhost_dropped.
>>>>>>>>
>>>>>>> ...
>>>>>>>
>>>>>>>> +
>>>>>>>> +void netdev_core_stats_inc(struct net_device *dev, u32 offset)
>>>>>>>> +{
>>>>>>>> +       /* This READ_ONCE() pairs with the write in netdev_core_stats_alloc() */
>>>>>>>> +       struct net_device_core_stats __percpu *p = READ_ONCE(dev->core_stats);
>>>>>>>> +       unsigned long *field;
>>>>>>>> +
>>>>>>>> +       if (unlikely(!p))
>>>>>>>> +               p = netdev_core_stats_alloc(dev);
>>>>>>>> +
>>>>>>>> +       if (p) {
>>>>>>>> +               field = (unsigned long *)((void *)this_cpu_ptr(p) + offset);
>>>>>>>> +               WRITE_ONCE(*field, READ_ONCE(*field) + 1);
>>>>>>> This is broken...
>>>>>>>
>>>>>>> As I explained earlier, dev_core_stats_xxxx(dev) can be called from
>>>>>>> many different contexts:
>>>>>>>
>>>>>>> 1) process contexts, where preemption and migration are allowed.
>>>>>>> 2) interrupt contexts.
>>>>>>>
>>>>>>> Adding WRITE_ONCE()/READ_ONCE() is not solving potential races.
>>>>>>>
>>>>>>> I _think_ I already gave you how to deal with this ?
>>>>>> Yes, I replied in v6.
>>>>>>
>>>>>> https://lore.kernel.org/all/e25b5f3c-bd97-56f0-de86-b93a3172870d@linux.dev/
>>>>>>
>>>>>>> Please try instead:
>>>>>>>
>>>>>>> +void netdev_core_stats_inc(struct net_device *dev, u32 offset)
>>>>>>> +{
>>>>>>> +       /* This READ_ONCE() pairs with the write in netdev_core_stats_alloc() */
>>>>>>> +       struct net_device_core_stats __percpu *p = READ_ONCE(dev->core_stats);
>>>>>>> +       unsigned long __percpu *field;
>>>>>>> +
>>>>>>> +       if (unlikely(!p)) {
>>>>>>> +               p = netdev_core_stats_alloc(dev);
>>>>>>> +               if (!p)
>>>>>>> +                       return;
>>>>>>> +       }
>>>>>>> +       field = (__force unsigned long __percpu *)((__force void *)p + offset);
>>>>>>> +       this_cpu_inc(*field);
>>>>>>> +}
>>>>>> This wouldn't trace anything even the rx_dropped is in increasing. It
>>>>>> needs to add an extra operation, such as:
>>>>> I honestly do not know what you are talking about.
>>>>>
>>>>> Have you even tried to change your patch to use
>>>>>
>>>>> field = (__force unsigned long __percpu *)((__force void *)p + offset);
>>>>> this_cpu_inc(*field);
>>>> Yes, I tested this code. But the following couldn't show anything even
>>>> if the rx_dropped is increasing.
>>>>
>>>> 'sudo python3 /usr/share/bcc/tools/trace netdev_core_stats_inc'
>>> Well, I am not sure about this, "bpftrace" worked for me.
>>>
>>> Make sure your toolchain generates something that looks like what I got:
>>>
>>> 000000000000ef20 <netdev_core_stats_inc>:
>>>       ef20: f3 0f 1e fa          endbr64
>>>       ef24: e8 00 00 00 00        call   ef29 <netdev_core_stats_inc+0x9>
>>> ef25: R_X86_64_PLT32 __fentry__-0x4
>>>       ef29: 55                    push   %rbp
>>>       ef2a: 48 89 e5              mov    %rsp,%rbp
>>>       ef2d: 53                    push   %rbx
>>>       ef2e: 89 f3                mov    %esi,%ebx
>>>       ef30: 48 8b 87 f0 01 00 00 mov    0x1f0(%rdi),%rax
>>>       ef37: 48 85 c0              test   %rax,%rax
>>>       ef3a: 74 0b                je     ef47 <netdev_core_stats_inc+0x27>
>>>       ef3c: 89 d9                mov    %ebx,%ecx
>>>       ef3e: 65 48 ff 04 08        incq   %gs:(%rax,%rcx,1)
>>>       ef43: 5b                    pop    %rbx
>>>       ef44: 5d                    pop    %rbp
>>>       ef45: c3                    ret
>>>       ef46: cc                    int3
>>>       ef47: e8 00 00 00 00        call   ef4c <netdev_core_stats_inc+0x2c>
>>> ef48: R_X86_64_PLT32 .text.unlikely.+0x13c
>>>       ef4c: 48 85 c0              test   %rax,%rax
>>>       ef4f: 75 eb                jne    ef3c <netdev_core_stats_inc+0x1c>
>>>       ef51: eb f0                jmp    ef43 <netdev_core_stats_inc+0x23>
>>>       ef53: 66 66 66 66 2e 0f 1f data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
>>>       ef5a: 84 00 00 00 00 00
>>
>> I'll share some I can see it.
>>
>> 1.
>>
>> objdump -D vmlinux
>>
>> ffffffff81b2f170 <netdev_core_stats_inc>:
>> ffffffff81b2f170:    e8 8b ea 55 ff           callq ffffffff8108dc00
>> <__fentry__>
>> ffffffff81b2f175:    55                       push   %rbp
>> ffffffff81b2f176:    48 89 e5                 mov    %rsp,%rbp
>> ffffffff81b2f179:    48 83 ec 08              sub    $0x8,%rsp
>> ffffffff81b2f17d:    48 8b 87 e8 01 00 00     mov 0x1e8(%rdi),%rax
>> ffffffff81b2f184:    48 85 c0                 test   %rax,%rax
>> ffffffff81b2f187:    74 0d                    je ffffffff81b2f196
>> <netdev_core_stats_inc+0x26>
>> ffffffff81b2f189:    89 f6                    mov    %esi,%esi
>> ffffffff81b2f18b:    65 48 ff 04 30           incq %gs:(%rax,%rsi,1)
>> ffffffff81b2f190:    c9                       leaveq
>> ffffffff81b2f191:    e9 aa 31 6d 00           jmpq ffffffff82202340
>> <__x86_return_thunk>
>> ffffffff81b2f196:    89 75 fc                 mov %esi,-0x4(%rbp)
>> ffffffff81b2f199:    e8 82 ff ff ff           callq ffffffff81b2f120
>> <netdev_core_stats_alloc>
>> ffffffff81b2f19e:    8b 75 fc                 mov -0x4(%rbp),%esi
>> ffffffff81b2f1a1:    48 85 c0                 test   %rax,%rax
>> ffffffff81b2f1a4:    75 e3                    jne ffffffff81b2f189
>> <netdev_core_stats_inc+0x19>
>> ffffffff81b2f1a6:    c9                       leaveq
>> ffffffff81b2f1a7:    e9 94 31 6d 00           jmpq ffffffff82202340
>> <__x86_return_thunk>
>> ffffffff81b2f1ac:    0f 1f 40 00              nopl   0x0(%rax)
>>
>>
>> 2.
>>
>> sudo cat /proc/kallsyms | grep netdev_core_stats_inc
>>
>> ffffffff9c72f120 T netdev_core_stats_inc
>> ffffffff9ca2676c t netdev_core_stats_inc.cold
>> ffffffff9d5235e0 r __ksymtab_netdev_core_stats_inc
>>
>>
>> 3.
>>
>> ➜  ~ ifconfig enp34s0f0
>> enp34s0f0: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
>>           inet 10.10.30.88  netmask 255.255.255.0  broadcast 10.10.30.255
>>           inet6 fe80::6037:806c:14b6:f1ca  prefixlen 64  scopeid 0x20<link>
>>           ether 04:d4:c4:5c:81:42  txqueuelen 1000  (Ethernet)
>>           RX packets 29024  bytes 3118278 (3.1 MB)
>>           RX errors 0  dropped 794  overruns 0  frame 0
>>           TX packets 16961  bytes 2662290 (2.6 MB)
>>           TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0
>>           device interrupt 29  memory 0x39fff4000000-39fff47fffff
>>
>> ➜  ~ ifconfig enp34s0f0
>> enp34s0f0: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
>>           inet 10.10.30.88  netmask 255.255.255.0  broadcast 10.10.30.255
>>           inet6 fe80::6037:806c:14b6:f1ca  prefixlen 64  scopeid 0x20<link>
>>           ether 04:d4:c4:5c:81:42  txqueuelen 1000  (Ethernet)
>>           RX packets 29272  bytes 3148997 (3.1 MB)
>>           RX errors 0  dropped 798  overruns 0  frame 0
>>           TX packets 17098  bytes 2683547 (2.6 MB)
>>           TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0
>>           device interrupt 29  memory 0x39fff4000000-39fff47fffff
>>
>>
>> The rx_dropped is increasing.
>>
>>
>> 4.
>>
>> sudo python3 /usr/share/bcc/tools/trace netdev_core_stats_inc
>>
>> TIME     PID     TID     COMM            FUNC
>>
>> (Empty, I didn't see anything.)
>>
>>
>> 5.
>>
>> sudo trace-cmd record -p function -l netdev_core_stats_inc
>>
>> sudo trace-cmd report
>>
>> (Empty, I didn't see anything.)
>>
>>
>> If I add a 'pr_info("\n");'   like:
>>
>> +      pr_info("\n");
>>           field = (__force unsigned long __percpu *)((__force void *)p +
>> offset);
>>           this_cpu_inc(*field);
>>
>>
>> Everything is OK. The 'pr_info("\n");' can be changed to anything else,
>> but not
>>
>> without it.
> This seems to be a bug that has nothing to do with the patch.
>
> Try getting help from Steven maybe.


Hi Steven,

Need your help.

1. The following code wouldn't trace anything by the command 'sudo 
python3 /usr/share/bcc/tools/trace netdev_core_stats_inc'

+void netdev_core_stats_inc(struct net_device *dev, u32 offset)
+{
+       /* This READ_ONCE() pairs with the write in netdev_core_stats_alloc() */
+       struct net_device_core_stats __percpu *p = READ_ONCE(dev->core_stats);
+       unsigned long __percpu *field;
+
+       if (unlikely(!p)) {
+               p = netdev_core_stats_alloc(dev);
+               if (!p)
+                       return;
+       }
+       field = (__force unsigned long __percpu *)((__force void *)p + offset);
+       this_cpu_inc(*field);
+}
+EXPORT_SYMBOL_GPL(netdev_core_stats_inc);

2. If I add a 'pr_info("\n");', it would be fine. The 'pr_info("\n");' can be changed to others.

+void netdev_core_stats_inc(struct net_device *dev, u32 offset)
+{
+       /* This READ_ONCE() pairs with the write in netdev_core_stats_alloc() */
+       struct net_device_core_stats __percpu *p = READ_ONCE(dev->core_stats);
+       unsigned long __percpu *field;
+
+       if (unlikely(!p)) {
+               p = netdev_core_stats_alloc(dev);
+               if (!p)
+                       return;
+       }
+	pr_info("\n");
+       field = (__force unsigned long __percpu *)((__force void *)p + offset);
+       this_cpu_inc(*field);
+}
+EXPORT_SYMBOL_GPL(netdev_core_stats_inc);

I don't know why we need to add something in netdev_core_stats_inc, the trace will be fine.

