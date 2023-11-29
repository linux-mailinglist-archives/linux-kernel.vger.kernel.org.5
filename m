Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ED967FD7C8
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 14:19:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233920AbjK2NSv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 08:18:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233935AbjK2NSr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 08:18:47 -0500
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AABDA8;
        Wed, 29 Nov 2023 05:18:52 -0800 (PST)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1r8KSk-0006M6-D7; Wed, 29 Nov 2023 14:18:46 +0100
Date:   Wed, 29 Nov 2023 14:18:46 +0100
From:   Florian Westphal <fw@strlen.de>
To:     "D. Wythe" <alibuda@linux.alibaba.com>
Cc:     pablo@netfilter.org, kadlec@netfilter.org, fw@strlen.de,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, coreteam@netfilter.org,
        netfilter-devel@vger.kernel.org, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        ast@kernel.org
Subject: Re: [PATCH net] net/netfilter: bpf: avoid leakage of skb
Message-ID: <20231129131846.GC27744@breakpoint.cc>
References: <1701252962-63418-1-git-send-email-alibuda@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1701252962-63418-1-git-send-email-alibuda@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

D. Wythe <alibuda@linux.alibaba.com> wrote:
> From: "D. Wythe" <alibuda@linux.alibaba.com>
> 
> A malicious eBPF program can interrupt the subsequent processing of
> a skb by returning an exceptional retval, and no one will be responsible
> for releasing the very skb.

How?  The bpf verifier is supposed to reject nf bpf programs that
return a value other than accept or drop.

If this is a real bug, please also figure out why
006c0e44ed92 ("selftests/bpf: add missing netfilter return value and ctx access tests")
failed to catch it.

> Moreover, normal programs can also have the demand to return NF_STOLEN,

No, this should be disallowed already.

>  net/netfilter/nf_bpf_link.c | 19 ++++++++++++++++++-
>  1 file changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/net/netfilter/nf_bpf_link.c b/net/netfilter/nf_bpf_link.c
> index e502ec0..03c47d6 100644
> --- a/net/netfilter/nf_bpf_link.c
> +++ b/net/netfilter/nf_bpf_link.c
> @@ -12,12 +12,29 @@ static unsigned int nf_hook_run_bpf(void *bpf_prog, struct sk_buff *skb,
>  				    const struct nf_hook_state *s)
>  {
>  	const struct bpf_prog *prog = bpf_prog;
> +	unsigned int verdict;
>  	struct bpf_nf_ctx ctx = {
>  		.state = s,
>  		.skb = skb,
>  	};
>  
> -	return bpf_prog_run(prog, &ctx);
> +	verdict = bpf_prog_run(prog, &ctx);
> +	switch (verdict) {
> +	case NF_STOLEN:
> +		consume_skb(skb);
> +		fallthrough;

This can't be right.  STOLEN really means STOLEN (free'd,
redirected, etc, "skb" MUST be "leaked".

Which is also why the bpf program is not allowed to return it.
