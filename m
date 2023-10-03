Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C55C87B5F39
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 05:05:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbjJCDFf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 23:05:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjJCDFd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 23:05:33 -0400
Received: from m126.mail.126.com (m126.mail.126.com [220.181.12.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 56A2FBF;
        Mon,  2 Oct 2023 20:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
        Content-Type; bh=j5U+KH7L61eD/YR+rpoWGe4zYfEE19aFtlBhfDC1WRw=;
        b=JTDlxMKJ14hBqiUvEmwUW8CZZpzGCu4pcGJCXUY2fbyFOaJeugvegPMtJYTlcl
        wR7pvlTx/kUYFwRUxhca+B9EZF170gnzwAvbhzc3d60NhwqaJ2Jmgo1vErZDdDF2
        l88QSwhWRS06Z/OcXMtJtO6RMWaAX+tYmL1UZ7Fn0LKFY=
Received: from [172.20.125.11] (unknown [111.48.58.12])
        by zwqz-smtp-mta-g5-1 (Coremail) with SMTP id _____wC3n0ZDhBtlPMxWBA--.40871S2;
        Tue, 03 Oct 2023 11:02:28 +0800 (CST)
Message-ID: <7ce7ae25-7f1d-7eaa-3084-f3c5f417167a@126.com>
Date:   Tue, 3 Oct 2023 11:02:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] netfilter: ipset: add ip_set lock to ip_set_test
Content-Language: en-US
To:     Jozsef Kadlecsik <kadlec@netfilter.org>,
        Simon Horman <horms@kernel.org>
Cc:     Pablo Neira Ayuso <pablo@netfilter.org>,
        Florian Westphal <fw@strlen.de>,
        David Miller <davem@davemloft.net>, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, justinstitt@google.com,
        kuniyu@amazon.com, netfilter-devel@vger.kernel.org,
        coreteam@netfilter.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Linkui Xiao <xiaolinkui@kylinos.cn>
References: <20230927130309.30891-1-xiaolinkui@126.com>
 <20231002160651.GX92317@kernel.org>
 <bf23f26-6cf0-b6e-f720-adcd8658a29b@netfilter.org>
From:   xiaolinkui <xiaolinkui@126.com>
In-Reply-To: <bf23f26-6cf0-b6e-f720-adcd8658a29b@netfilter.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wC3n0ZDhBtlPMxWBA--.40871S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxuFWUXFWfJr1xAry7Gw4fGrg_yoW3urWkpa
        4YgF1qg3ykZrnrAw4jyF48KF1jqanIyF1UGr95Gr1fuwnrGwnrJF48KFW3Wr47XrWruFy2
        yw1jv3y0qr1UGw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jP_-PUUUUU=
X-Originating-IP: [111.48.58.12]
X-CM-SenderInfo: p0ld0z5lqn3xa6rslhhfrp/1tbibQX91lpEFAQ3OwABsA
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 10/3/23 03:06, Jozsef Kadlecsik wrote:
> Hi,
>
> On Mon, 2 Oct 2023, Simon Horman wrote:
>
>> On Wed, Sep 27, 2023 at 09:03:09PM +0800, xiaolinkui wrote:
>>> From: Linkui Xiao <xiaolinkui@kylinos.cn>
>>>
>>> If the ip_set is not locked during ip_set_test, the following situations
>>> may occur:
>>>
>>> 	CPU0				CPU1
>>> 	ip_rcv->
>>> 	ip_rcv_finish->
>>> 	ip_local_deliver->
>>> 	nf_hook_slow->
>>> 	iptable_filter_hook->
>>> 	ipt_do_table->
>>> 	set_match_v4->
>>> 	ip_set_test->			list_set_destroy->
>>> 	hash_net4_kadt->		set->data = NULL
>> I'm having a bit of trouble analysing this.
>> In particular, I'm concerned that in such a scenario set
>> itself will be also freed, which seems likely to lead to problems.
>>
>> Can you provide a more complete call stack for CPU1 ?
> ip_set_test() runs intentionally without holding a spinlock, it uses RCU.
>
> But I don't understand the scenario at all:
>
> 	CPU0:				CPU1:
> 	hash_net4_kadt			list_set_destroy
>
> 	so it's a hash:net type		which works on a list
> 	of set				type of sets only
>
> The list type of set can freely be destroyed (when not referenced), the
> destroy operation has no effect whatsoever on its possible hash:net type
> of member set.
>
> Moreover, kernel side add/del/test can only be performed when the set in
> question is referenced. Referenced sets cannot be deleted.
>
> So what is the scenario really in this case?
The case I want to express should be like this:

                         CPU0         CPU1

                 ip_set_test

                             |   (1)  iptables -D -> set->ref --

                             |   (2) ipset destroy -> set->data=NULL

                             |

                 hash_net4_kadt

                             |

                 hash_net4_test

For the convenience of description, the definition is as follows:

cmd(1): iptables -D

cmd(2):  ipset destroy

When the ip_set test has already started in CPU0, but before it ends.

For example, when CPU0 runs between  ip_set_test  and hash_net4_kadt,
CPU1 executes cmd (1) and cmd (2).

In addition, if CPU 0 runs between hash_net4_kadt and hash_net4_test,

CPU1 executes cmd (1) and cmd (2). The following call trace will be 
triggered:

crash> bt
PID: 0      TASK: ffff8003a1cd2680  CPU: 7   COMMAND: "swapper/7"
  #0 [ffff8003fff3f460] crash_kexec at ffff0000081af828
  #1 [ffff8003fff3f490] die at ffff00000808f754
  #2 [ffff8003fff3f4d0] die_kernel_fault at ffff0000080aa9ac
  #3 [ffff8003fff3f500] __do_kernel_fault at ffff0000080aa67c
  #4 [ffff8003fff3f530] do_page_fault at ffff000008bfa66c
  #5 [ffff8003fff3f620] do_translation_fault at ffff000008bfab64
  #6 [ffff8003fff3f650] do_mem_abort at ffff000008081284
  #7 [ffff8003fff3f830] el1_ia at ffff00000808310c
      PC: ffff00000342225c  [hash_net4_test+68]
      LR: ffff000003420200  [hash_net4_kadt+208]
      SP: ffff8003fff3f840  PSTATE: 60400005
     X29: ffff8003fff3f840  X28: ffff8003a78ca600  X27: ffff8003fff3f908
     X26: 0000000000000000  X25: ffff000000c70600  X24: ffff8003b8232400
     X23: ffff000002f90fcc  X22: 0000000000000000  X21: ffff8003fff3f9d0
     X20: ffff8003fff3f910  X19: ffff8003fff3f9c8  X18: 0000000000000000
     X17: 0000000000000000  X16: 0000000000000000  X15: 0000000000000000
     X14: 970000002d494600  X13: 0000000000000000  X12: a40d15d8df825036
     X11: ffff000000c70600  X10: ffff8003b2deb000   X9: 0000000000000001
      X8: 0000000000000000   X7: 00000000637c7464   X6: ffff000003422218
      X5: 00000000637c7464   X4: 0000000000000000   X3: ffff8003fff3f9d0
      X2: ffff8003fff3f910   X1: ffff8003fff3f908   X0: 0000000000000020
  #8 [ffff8003fff3f840] hash_net4_test at ffff000003422258 
[ip_set_hash_net]
  #9 [ffff8003fff3f8d0] hash_net4_kadt at ffff0000034201fc 
[ip_set_hash_net]
#10 [ffff8003fff3f940] ip_set_test at ffff000002c011b8 [ip_set]
#11 [ffff8003fff3f990] set_match_v4 at ffff000002f90fc8 [xt_set]
#12 [ffff8003fff3fa20] ipt_do_table at ffff000000c504e0 [ip_tables]
#13 [ffff8003fff3fb60] iptable_filter_hook at ffff0000026e006c 
[iptable_filter]
#14 [ffff8003fff3fb80] nf_hook_slow at ffff000008ac7a84
#15 [ffff8003fff3fbc0] ip_local_deliver at ffff000008ad5d88
#16 [ffff8003fff3fc10] ip_rcv_finish at ffff000008ad59b4
#17 [ffff8003fff3fc40] ip_rcv at ffff000008ad5dec
#18 [ffff8003fff3fca0] __netif_receive_skb_one_core at ffff000008a6c344
#19 [ffff8003fff3fce0] __netif_receive_skb at ffff000008a6c3ac
#20 [ffff8003fff3fd00] netif_receive_skb_internal at ffff000008a6c440
#21 [ffff8003fff3fd30] napi_gro_receive at ffff000008a6d3ec
#22 [ffff8003fff3fd60] receive_buf at ffff000001c734d8 [virtio_net]
#23 [ffff8003fff3fe20] virtnet_poll at ffff000001c753e8 [virtio_net]
#24 [ffff8003fff3fec0] net_rx_action at ffff000008a6c9ec
#25 [ffff8003fff3ff60] __softirqentry_text_start at ffff0000080819f0
#26 [ffff8003fff3fff0] irq_exit at ffff0000080f1228
#27 [ffff8003fff40010] __handle_domain_irq at ffff000008162a10

Of course, the ip_set_test execution cycle is very short. During this 
period,
another CPU needs to complete the cmd1 and cmd2 operations on the 
ip_set, the
probability of triggering this problem will be very low.

This problem has also occurred in Red Hat:

https://access.redhat.com/solutions/6839381

But I think the solution mentioned in the link is not applicable.

Commit c120959387ef(netfilter: fix a use-after-free in mtype_destroy()) 
applies
to ip_set_bitmap instead of ip_set_hash.

Best regards,

Linkui
>
> Best regards,
> Jozsef
>
>>> 	h = set->data
>>> 	.cidr = INIT_CIDR(h->nets[0].cidr[0], HOST_MASK)
>>>
>>> The set->data is empty, continuing to access set->data will result in a
>>> kernel NULL pointer. The call trace is as follows:
>>>
>>> [2350616.024418] Call trace:
>>> [2350616.024670]  hash_net4_kadt+0x38/0x148 [ip_set_hash_net]
>>> [2350616.025147]  ip_set_test+0xbc/0x230 [ip_set]
>>> [2350616.025549]  set_match_v4+0xac/0xd0 [xt_set]
>>> [2350616.025951]  ipt_do_table+0x32c/0x678 [ip_tables]
>>> [2350616.026391]  iptable_filter_hook+0x30/0x40 [iptable_filter]
>>> [2350616.026905]  nf_hook_slow+0x50/0x100
>>> [2350616.027256]  ip_local_deliver+0xd4/0xe8
>>> [2350616.027616]  ip_rcv_finish+0x90/0xb0
>>> [2350616.027961]  ip_rcv+0x50/0xb0
>>> [2350616.028261]  __netif_receive_skb_one_core+0x58/0x68
>>> [2350616.028716]  __netif_receive_skb+0x28/0x80
>>> [2350616.029098]  netif_receive_skb_internal+0x3c/0xa8
>>> [2350616.029533]  napi_gro_receive+0xf8/0x170
>>> [2350616.029898]  receive_buf+0xec/0xa08 [virtio_net]
>>> [2350616.030323]  virtnet_poll+0x144/0x310 [virtio_net]
>>> [2350616.030761]  net_rx_action+0x158/0x3a0
>>> [2350616.031124]  __do_softirq+0x11c/0x33c
>>> [2350616.031470]  irq_exit+0x11c/0x128
>>> [2350616.031793]  __handle_domain_irq+0x6c/0xc0
>>> [2350616.032172]  gic_handle_irq+0x6c/0x170
>>> [2350616.032528]  el1_irq+0xb8/0x140
>>> [2350616.032835]  arch_cpu_idle+0x38/0x1c0
>>> [2350616.033183]  default_idle_call+0x24/0x58
>>> [2350616.033549]  do_idle+0x1a4/0x268
>>> [2350616.033859]  cpu_startup_entry+0x28/0x78
>>> [2350616.034234]  secondary_start_kernel+0x17c/0x1c8
>>>
>>> Signed-off-by: Linkui Xiao <xiaolinkui@kylinos.cn>
>>> ---
>>>   net/netfilter/ipset/ip_set_core.c | 2 ++
>>>   1 file changed, 2 insertions(+)
>>>
>>> diff --git a/net/netfilter/ipset/ip_set_core.c b/net/netfilter/ipset/ip_set_core.c
>>> index 35d2f9c9ada0..46f4f47e29e4 100644
>>> --- a/net/netfilter/ipset/ip_set_core.c
>>> +++ b/net/netfilter/ipset/ip_set_core.c
>>> @@ -747,7 +747,9 @@ ip_set_test(ip_set_id_t index, const struct sk_buff *skb,
>>>   	    !(opt->family == set->family || set->family == NFPROTO_UNSPEC))
>>>   		return 0;
>>>   
>>> +	ip_set_lock(set);
>>>   	ret = set->variant->kadt(set, skb, par, IPSET_TEST, opt);
>>> +	ip_set_unlock(set);
>>>   
>>>   	if (ret == -EAGAIN) {
>>>   		/* Type requests element to be completed */
>>> -- 
>>> 2.17.1
>>>
>>>
> -
> E-mail  : kadlec@blackhole.kfki.hu, kadlecsik.jozsef@wigner.hu
> PGP key : https://wigner.hu/~kadlec/pgp_public_key.txt
> Address : Wigner Research Centre for Physics
>            H-1525 Budapest 114, POB. 49, Hungary

