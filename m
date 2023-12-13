Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFFE9812160
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 23:24:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442790AbjLMWYO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 17:24:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbjLMWYN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 17:24:13 -0500
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 416CBBD;
        Wed, 13 Dec 2023 14:24:19 -0800 (PST)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1rDXeJ-0003ip-4L; Wed, 13 Dec 2023 23:24:15 +0100
Date:   Wed, 13 Dec 2023 23:24:15 +0100
From:   Florian Westphal <fw@strlen.de>
To:     "D. Wythe" <alibuda@linux.alibaba.com>
Cc:     pablo@netfilter.org, kadlec@netfilter.org, fw@strlen.de,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, coreteam@netfilter.org,
        netfilter-devel@vger.kernel.org, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        ast@kernel.org
Subject: Re: [RFC nf-next 1/2] netfilter: bpf: support prog update
Message-ID: <20231213222415.GA13818@breakpoint.cc>
References: <1702467945-38866-1-git-send-email-alibuda@linux.alibaba.com>
 <1702467945-38866-2-git-send-email-alibuda@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1702467945-38866-2-git-send-email-alibuda@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

D. Wythe <alibuda@linux.alibaba.com> wrote:
> From: "D. Wythe" <alibuda@linux.alibaba.com>
> 
> To support the prog update, we need to ensure that the prog seen
> within the hook is always valid. Considering that hooks are always
> protected by rcu_read_lock(), which provide us the ability to use a
> new RCU-protected context to access the prog.
> 
> Signed-off-by: D. Wythe <alibuda@linux.alibaba.com>
> ---
>  net/netfilter/nf_bpf_link.c | 124 +++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 111 insertions(+), 13 deletions(-)
> 
> diff --git a/net/netfilter/nf_bpf_link.c b/net/netfilter/nf_bpf_link.c
> index e502ec0..918c470 100644
> --- a/net/netfilter/nf_bpf_link.c
> +++ b/net/netfilter/nf_bpf_link.c
> @@ -8,17 +8,11 @@
>  #include <net/netfilter/nf_bpf_link.h>
>  #include <uapi/linux/netfilter_ipv4.h>
>  
> -static unsigned int nf_hook_run_bpf(void *bpf_prog, struct sk_buff *skb,
> -				    const struct nf_hook_state *s)
> +struct bpf_nf_hook_ctx
>  {
> -	const struct bpf_prog *prog = bpf_prog;
> -	struct bpf_nf_ctx ctx = {
> -		.state = s,
> -		.skb = skb,
> -	};
> -
> -	return bpf_prog_run(prog, &ctx);
> -}
> +	struct bpf_prog *prog;
> +	struct rcu_head rcu;
> +};

I don't understand the need for this structure.  AFAICS bpf_prog_put()
will always release the program via call_rcu()?

If it doesn't, we are probably already in trouble as-is without this
patch, I don't think anything that prevents us from ending up calling already
released bpf prog, or releasing it while another cpu is still running it
if bpf_prog_put releases the actual underlying prog instantly.

A BPF expert could confirm bpf-prog-put-is-call-rcu.

>  struct bpf_nf_link {
>  	struct bpf_link link;
> @@ -26,8 +20,59 @@ struct bpf_nf_link {
>  	struct net *net;
>  	u32 dead;
>  	const struct nf_defrag_hook *defrag_hook;
> +	/* protect link update in parallel */
> +	struct mutex update_lock;
> +	struct bpf_nf_hook_ctx __rcu *hook_ctx;

What kind of replacements-per-second rate are you aiming for?
I think

static DEFINE_MUTEX(bpf_nf_mutex);

is enough.

Then bpf_nf_link gains

	struct bpf_prog __rcu *prog

and possibly a trailing struct rcu_head, see below.

> +static void bpf_nf_hook_ctx_free_rcu(struct bpf_nf_hook_ctx *hook_ctx)
> +{
> +	call_rcu(&hook_ctx->rcu, __bpf_nf_hook_ctx_free_rcu);
> +}

Don't understand the need for call_rcu either, see below.

> +static unsigned int nf_hook_run_bpf(void *bpf_link, struct sk_buff *skb,
> +				    const struct nf_hook_state *s)
> +{
> +	const struct bpf_nf_link *link = bpf_link;
> +	struct bpf_nf_hook_ctx *hook_ctx;
> +	struct bpf_nf_ctx ctx = {
> +		.state = s,
> +		.skb = skb,
> +	};
> +
> +	hook_ctx = rcu_dereference(link->hook_ctx);

This could then just rcu_deref link->prog.

> +	return bpf_prog_run(hook_ctx->prog, &ctx);
> +}
> +
>  #if IS_ENABLED(CONFIG_NF_DEFRAG_IPV4) || IS_ENABLED(CONFIG_NF_DEFRAG_IPV6)
>  static const struct nf_defrag_hook *
>  get_proto_defrag_hook(struct bpf_nf_link *link,
> @@ -120,6 +165,10 @@ static void bpf_nf_link_release(struct bpf_link *link)
>  	if (!cmpxchg(&nf_link->dead, 0, 1)) {
>  		nf_unregister_net_hook(nf_link->net, &nf_link->hook_ops);
>  		bpf_nf_disable_defrag(nf_link);
> +		/* Wait for outstanding hook to complete before the
> +		 * link gets released.
> +		 */
> +		synchronize_rcu();
>  	}

Could you convert bpf_nf_link_dealloc to release via kfree_rcu instead?

> @@ -162,7 +212,42 @@ static int bpf_nf_link_fill_link_info(const struct bpf_link *link,
>  static int bpf_nf_link_update(struct bpf_link *link, struct bpf_prog *new_prog,
>  			      struct bpf_prog *old_prog)
>  {
> -	return -EOPNOTSUPP;
> +	struct bpf_nf_link *nf_link = container_of(link, struct bpf_nf_link, link);
> +	struct bpf_nf_hook_ctx *hook_ctx;
> +	int err = 0;
> +
> +	mutex_lock(&nf_link->update_lock);
> +

I think you need to check link->dead here too.

> +	/* bpf_nf_link_release() ensures that after its execution, there will be
> +	 * no ongoing or upcoming execution of nf_hook_run_bpf() within any context.
> +	 * Therefore, within nf_hook_run_bpf(), the link remains valid at all times."
> +	 */
> +	link->hook_ops.priv = link;

ATM we only need to make sure the bpf prog itself stays alive until after
all concurrent rcu critical sections have completed.

After this change, struct bpf_link gets passed instead, so we need to
keep that alive too.

Which works with synchronize_rcu, sure, but that seems a bit overkill here.
