Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB1637B5B03
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 21:14:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238730AbjJBTOK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 15:14:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjJBTOJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 15:14:09 -0400
X-Greylist: delayed 449 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 02 Oct 2023 12:14:05 PDT
Received: from smtp-out.kfki.hu (smtp-out.kfki.hu [148.6.0.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03B6BAC;
        Mon,  2 Oct 2023 12:14:04 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by smtp2.kfki.hu (Postfix) with ESMTP id 8E8BECC010C;
        Mon,  2 Oct 2023 21:06:28 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at smtp2.kfki.hu
Received: from smtp2.kfki.hu ([127.0.0.1])
        by localhost (smtp2.kfki.hu [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP; Mon,  2 Oct 2023 21:06:26 +0200 (CEST)
Received: from blackhole.kfki.hu (blackhole.szhk.kfki.hu [148.6.240.2])
        by smtp2.kfki.hu (Postfix) with ESMTP id 3F575CC010A;
        Mon,  2 Oct 2023 21:06:23 +0200 (CEST)
Received: by blackhole.kfki.hu (Postfix, from userid 1000)
        id E80B13431A9; Mon,  2 Oct 2023 21:06:23 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by blackhole.kfki.hu (Postfix) with ESMTP id E6836343155;
        Mon,  2 Oct 2023 21:06:23 +0200 (CEST)
Date:   Mon, 2 Oct 2023 21:06:23 +0200 (CEST)
From:   Jozsef Kadlecsik <kadlec@netfilter.org>
To:     Simon Horman <horms@kernel.org>
cc:     xiaolinkui <xiaolinkui@126.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Florian Westphal <fw@strlen.de>,
        David Miller <davem@davemloft.net>, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, justinstitt@google.com,
        kuniyu@amazon.com, netfilter-devel@vger.kernel.org,
        coreteam@netfilter.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Linkui Xiao <xiaolinkui@kylinos.cn>
Subject: Re: [PATCH] netfilter: ipset: add ip_set lock to ip_set_test
In-Reply-To: <20231002160651.GX92317@kernel.org>
Message-ID: <bf23f26-6cf0-b6e-f720-adcd8658a29b@netfilter.org>
References: <20230927130309.30891-1-xiaolinkui@126.com> <20231002160651.GX92317@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 2 Oct 2023, Simon Horman wrote:

> On Wed, Sep 27, 2023 at 09:03:09PM +0800, xiaolinkui wrote:
> > From: Linkui Xiao <xiaolinkui@kylinos.cn>
> > 
> > If the ip_set is not locked during ip_set_test, the following situations
> > may occur:
> > 
> > 	CPU0				CPU1
> > 	ip_rcv->
> > 	ip_rcv_finish->
> > 	ip_local_deliver->
> > 	nf_hook_slow->
> > 	iptable_filter_hook->
> > 	ipt_do_table->
> > 	set_match_v4->
> > 	ip_set_test->			list_set_destroy->
> > 	hash_net4_kadt->		set->data = NULL
> 
> I'm having a bit of trouble analysing this.
> In particular, I'm concerned that in such a scenario set
> itself will be also freed, which seems likely to lead to problems.
> 
> Can you provide a more complete call stack for CPU1 ?

ip_set_test() runs intentionally without holding a spinlock, it uses RCU.

But I don't understand the scenario at all:

	CPU0:				CPU1:
	hash_net4_kadt			list_set_destroy

	so it's a hash:net type		which works on a list
	of set				type of sets only

The list type of set can freely be destroyed (when not referenced), the 
destroy operation has no effect whatsoever on its possible hash:net type 
of member set.

Moreover, kernel side add/del/test can only be performed when the set in 
question is referenced. Referenced sets cannot be deleted.

So what is the scenario really in this case?

Best regards,
Jozsef

> > 	h = set->data
> > 	.cidr = INIT_CIDR(h->nets[0].cidr[0], HOST_MASK)
> > 
> > The set->data is empty, continuing to access set->data will result in a
> > kernel NULL pointer. The call trace is as follows:
> > 
> > [2350616.024418] Call trace:
> > [2350616.024670]  hash_net4_kadt+0x38/0x148 [ip_set_hash_net]
> > [2350616.025147]  ip_set_test+0xbc/0x230 [ip_set]
> > [2350616.025549]  set_match_v4+0xac/0xd0 [xt_set]
> > [2350616.025951]  ipt_do_table+0x32c/0x678 [ip_tables]
> > [2350616.026391]  iptable_filter_hook+0x30/0x40 [iptable_filter]
> > [2350616.026905]  nf_hook_slow+0x50/0x100
> > [2350616.027256]  ip_local_deliver+0xd4/0xe8
> > [2350616.027616]  ip_rcv_finish+0x90/0xb0
> > [2350616.027961]  ip_rcv+0x50/0xb0
> > [2350616.028261]  __netif_receive_skb_one_core+0x58/0x68
> > [2350616.028716]  __netif_receive_skb+0x28/0x80
> > [2350616.029098]  netif_receive_skb_internal+0x3c/0xa8
> > [2350616.029533]  napi_gro_receive+0xf8/0x170
> > [2350616.029898]  receive_buf+0xec/0xa08 [virtio_net]
> > [2350616.030323]  virtnet_poll+0x144/0x310 [virtio_net]
> > [2350616.030761]  net_rx_action+0x158/0x3a0
> > [2350616.031124]  __do_softirq+0x11c/0x33c
> > [2350616.031470]  irq_exit+0x11c/0x128
> > [2350616.031793]  __handle_domain_irq+0x6c/0xc0
> > [2350616.032172]  gic_handle_irq+0x6c/0x170
> > [2350616.032528]  el1_irq+0xb8/0x140
> > [2350616.032835]  arch_cpu_idle+0x38/0x1c0
> > [2350616.033183]  default_idle_call+0x24/0x58
> > [2350616.033549]  do_idle+0x1a4/0x268
> > [2350616.033859]  cpu_startup_entry+0x28/0x78
> > [2350616.034234]  secondary_start_kernel+0x17c/0x1c8
> > 
> > Signed-off-by: Linkui Xiao <xiaolinkui@kylinos.cn>
> > ---
> >  net/netfilter/ipset/ip_set_core.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/net/netfilter/ipset/ip_set_core.c b/net/netfilter/ipset/ip_set_core.c
> > index 35d2f9c9ada0..46f4f47e29e4 100644
> > --- a/net/netfilter/ipset/ip_set_core.c
> > +++ b/net/netfilter/ipset/ip_set_core.c
> > @@ -747,7 +747,9 @@ ip_set_test(ip_set_id_t index, const struct sk_buff *skb,
> >  	    !(opt->family == set->family || set->family == NFPROTO_UNSPEC))
> >  		return 0;
> >  
> > +	ip_set_lock(set);
> >  	ret = set->variant->kadt(set, skb, par, IPSET_TEST, opt);
> > +	ip_set_unlock(set);
> >  
> >  	if (ret == -EAGAIN) {
> >  		/* Type requests element to be completed */
> > -- 
> > 2.17.1
> > 
> > 
> 

-
E-mail  : kadlec@blackhole.kfki.hu, kadlecsik.jozsef@wigner.hu
PGP key : https://wigner.hu/~kadlec/pgp_public_key.txt
Address : Wigner Research Centre for Physics
          H-1525 Budapest 114, POB. 49, Hungary
