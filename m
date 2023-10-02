Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF4D57B576B
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 18:13:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238081AbjJBQHC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 12:07:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232151AbjJBQHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 12:07:01 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0E1DB3;
        Mon,  2 Oct 2023 09:06:56 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97AF1C433C8;
        Mon,  2 Oct 2023 16:06:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696262816;
        bh=hjJsXyNAF1V7Na1B/S3lP6ETWWJSxW2eEAWFxd1xSuk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rDFT9Jte07g2Ec1nFQBlQricWs9bCv0EicI7uAjZMT9tEbZ8nIQ7Yl2Sk1V4xrjdL
         Q9yh1LOzF8wtvQEj4rhgV9aEks47N7m/MBvFKn3UHdk6mjupdMhwwiHkHMrEMCSGj2
         4OiS0urZS4d+GO6AkGTVOnhvbIgYa8FPDG4jmsntNfTGqa+7a+mq1kkSrcAUnpEDmp
         QhhnZRdudOlKTmclWJg5kqnmlny6wH1a4JwKoE92zVbOT+mrQTbiToHv68k/o5nnE2
         FGHcr83eXgUDNFsMjBxgb2adQqwqpAa9PXkpdDCvuNMo+Pi2nr7KIZKh38HdCugje1
         /kPlnY4nkNNEA==
Date:   Mon, 2 Oct 2023 18:06:51 +0200
From:   Simon Horman <horms@kernel.org>
To:     xiaolinkui <xiaolinkui@126.com>
Cc:     pablo@netfilter.org, kadlec@netfilter.org, fw@strlen.de,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, justinstitt@google.com, kuniyu@amazon.com,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linkui Xiao <xiaolinkui@kylinos.cn>
Subject: Re: [PATCH] netfilter: ipset: add ip_set lock to ip_set_test
Message-ID: <20231002160651.GX92317@kernel.org>
References: <20230927130309.30891-1-xiaolinkui@126.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230927130309.30891-1-xiaolinkui@126.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 27, 2023 at 09:03:09PM +0800, xiaolinkui wrote:
> From: Linkui Xiao <xiaolinkui@kylinos.cn>
> 
> If the ip_set is not locked during ip_set_test, the following situations
> may occur:
> 
> 	CPU0				CPU1
> 	ip_rcv->
> 	ip_rcv_finish->
> 	ip_local_deliver->
> 	nf_hook_slow->
> 	iptable_filter_hook->
> 	ipt_do_table->
> 	set_match_v4->
> 	ip_set_test->			list_set_destroy->
> 	hash_net4_kadt->		set->data = NULL

Hi,

I'm having a bit of trouble analysing this.
In particular, I'm concerned that in such a scenario set
itself will be also freed, which seems likely to lead to problems.

Can you provide a more complete call stack for CPU1 ?

> 	h = set->data
> 	.cidr = INIT_CIDR(h->nets[0].cidr[0], HOST_MASK)
> 
> The set->data is empty, continuing to access set->data will result in a
> kernel NULL pointer. The call trace is as follows:
> 
> [2350616.024418] Call trace:
> [2350616.024670]  hash_net4_kadt+0x38/0x148 [ip_set_hash_net]
> [2350616.025147]  ip_set_test+0xbc/0x230 [ip_set]
> [2350616.025549]  set_match_v4+0xac/0xd0 [xt_set]
> [2350616.025951]  ipt_do_table+0x32c/0x678 [ip_tables]
> [2350616.026391]  iptable_filter_hook+0x30/0x40 [iptable_filter]
> [2350616.026905]  nf_hook_slow+0x50/0x100
> [2350616.027256]  ip_local_deliver+0xd4/0xe8
> [2350616.027616]  ip_rcv_finish+0x90/0xb0
> [2350616.027961]  ip_rcv+0x50/0xb0
> [2350616.028261]  __netif_receive_skb_one_core+0x58/0x68
> [2350616.028716]  __netif_receive_skb+0x28/0x80
> [2350616.029098]  netif_receive_skb_internal+0x3c/0xa8
> [2350616.029533]  napi_gro_receive+0xf8/0x170
> [2350616.029898]  receive_buf+0xec/0xa08 [virtio_net]
> [2350616.030323]  virtnet_poll+0x144/0x310 [virtio_net]
> [2350616.030761]  net_rx_action+0x158/0x3a0
> [2350616.031124]  __do_softirq+0x11c/0x33c
> [2350616.031470]  irq_exit+0x11c/0x128
> [2350616.031793]  __handle_domain_irq+0x6c/0xc0
> [2350616.032172]  gic_handle_irq+0x6c/0x170
> [2350616.032528]  el1_irq+0xb8/0x140
> [2350616.032835]  arch_cpu_idle+0x38/0x1c0
> [2350616.033183]  default_idle_call+0x24/0x58
> [2350616.033549]  do_idle+0x1a4/0x268
> [2350616.033859]  cpu_startup_entry+0x28/0x78
> [2350616.034234]  secondary_start_kernel+0x17c/0x1c8
> 
> Signed-off-by: Linkui Xiao <xiaolinkui@kylinos.cn>
> ---
>  net/netfilter/ipset/ip_set_core.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/net/netfilter/ipset/ip_set_core.c b/net/netfilter/ipset/ip_set_core.c
> index 35d2f9c9ada0..46f4f47e29e4 100644
> --- a/net/netfilter/ipset/ip_set_core.c
> +++ b/net/netfilter/ipset/ip_set_core.c
> @@ -747,7 +747,9 @@ ip_set_test(ip_set_id_t index, const struct sk_buff *skb,
>  	    !(opt->family == set->family || set->family == NFPROTO_UNSPEC))
>  		return 0;
>  
> +	ip_set_lock(set);
>  	ret = set->variant->kadt(set, skb, par, IPSET_TEST, opt);
> +	ip_set_unlock(set);
>  
>  	if (ret == -EAGAIN) {
>  		/* Type requests element to be completed */
> -- 
> 2.17.1
> 
> 
