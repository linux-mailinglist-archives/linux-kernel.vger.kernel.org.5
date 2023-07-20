Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5CDD75BB08
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 01:19:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbjGTXT2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 19:19:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbjGTXT0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 19:19:26 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C874B2713;
        Thu, 20 Jul 2023 16:19:19 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1qMcvI-0003Fw-2U; Fri, 21 Jul 2023 01:19:04 +0200
Date:   Fri, 21 Jul 2023 01:19:04 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Daniel Xu <dxu@dxuuu.xyz>
Cc:     daniel@iogearbox.net, kadlec@netfilter.org, ast@kernel.org,
        pablo@netfilter.org, kuba@kernel.org, davem@davemloft.net,
        andrii@kernel.org, edumazet@google.com, pabeni@redhat.com,
        fw@strlen.de, alexei.starovoitov@gmail.com, martin.lau@linux.dev,
        song@kernel.org, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, netfilter-devel@vger.kernel.org,
        coreteam@netfilter.org, netdev@vger.kernel.org, dsahern@kernel.org
Subject: Re: [PATCH bpf-next v5 2/5] netfilter: bpf: Support
 BPF_F_NETFILTER_IP_DEFRAG in netfilter link
Message-ID: <20230720231904.GA31372@breakpoint.cc>
References: <cover.1689884827.git.dxu@dxuuu.xyz>
 <690a1b09db84547b0f0c73654df3f4950f1262b7.1689884827.git.dxu@dxuuu.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <690a1b09db84547b0f0c73654df3f4950f1262b7.1689884827.git.dxu@dxuuu.xyz>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Xu <dxu@dxuuu.xyz> wrote:
> +	const struct nf_defrag_hook __maybe_unused *hook;
> +
> +	switch (link->hook_ops.pf) {
> +#if IS_ENABLED(CONFIG_NF_DEFRAG_IPV4)
> +	case NFPROTO_IPV4:
> +		hook = get_proto_defrag_hook(link, nf_defrag_v4_hook, "nf_defrag_ipv4");
> +		if (IS_ERR(hook))
> +			return PTR_ERR(hook);
> +
> +		link->defrag_hook = hook;
> +		return 0;
> +#endif
> +#if IS_ENABLED(CONFIG_NF_DEFRAG_IPV6)
> +	case NFPROTO_IPV6:
> +		hook = get_proto_defrag_hook(link, nf_defrag_v6_hook, "nf_defrag_ipv6");
> +		if (IS_ERR(hook))
> +			return PTR_ERR(hook);
> +
> +		link->defrag_hook = hook;
> +		return 0;
> +#endif
> +	default:
> +		return -EAFNOSUPPORT;
> +	}
> +}
> +
> +static void bpf_nf_disable_defrag(struct bpf_nf_link *link)
> +{
> +	const struct nf_defrag_hook *hook = link->defrag_hook;
> +
> +	if (!hook)
> +		return;
> +	hook->disable(link->net);
> +	module_put(hook->owner);
> +}
> +
>  static void bpf_nf_link_release(struct bpf_link *link)
>  {
>  	struct bpf_nf_link *nf_link = container_of(link, struct bpf_nf_link, link);
> @@ -37,6 +119,8 @@ static void bpf_nf_link_release(struct bpf_link *link)
>  	 */
>  	if (!cmpxchg(&nf_link->dead, 0, 1))
>  		nf_unregister_net_hook(nf_link->net, &nf_link->hook_ops);
> +
> +	bpf_nf_disable_defrag(nf_link);
>  }

I suspect this needs to be within the cmpxchg() branch to avoid
multiple ->disable() calls.

> +	if (attr->link_create.netfilter.flags & BPF_F_NETFILTER_IP_DEFRAG) {
> +		err = bpf_nf_enable_defrag(link);
> +		if (err) {
> +			bpf_link_cleanup(&link_primer);
> +			return err;
> +		}
> +	}
> +
>  	err = nf_register_net_hook(net, &link->hook_ops);
>  	if (err) {
		bpf_nf_disable_defrag(link);

Other than those nits this lgtm, thanks!
