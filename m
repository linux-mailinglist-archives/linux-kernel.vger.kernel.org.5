Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E7B4753700
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 11:48:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235954AbjGNJsV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 05:48:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235072AbjGNJsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 05:48:04 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF8A32D73;
        Fri, 14 Jul 2023 02:47:59 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1qKFOn-0002GU-MB; Fri, 14 Jul 2023 11:47:41 +0200
Date:   Fri, 14 Jul 2023 11:47:41 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Daniel Xu <dxu@dxuuu.xyz>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Florian Westphal <fw@strlen.de>,
        "David S. Miller" <davem@davemloft.net>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        netfilter-devel <netfilter-devel@vger.kernel.org>,
        coreteam@netfilter.org,
        Network Development <netdev@vger.kernel.org>,
        David Ahern <dsahern@kernel.org>
Subject: Re: [PATCH bpf-next v4 2/6] netfilter: bpf: Support
 BPF_F_NETFILTER_IP_DEFRAG in netfilter link
Message-ID: <20230714094741.GA7912@breakpoint.cc>
References: <cover.1689203090.git.dxu@dxuuu.xyz>
 <d3b0ff95c58356192ea3b50824f8cdbf02c354e3.1689203090.git.dxu@dxuuu.xyz>
 <CAADnVQKKfEtZYZxihxvG3aQ34E1m95qTZ=jTD7yd0qvOASpAjQ@mail.gmail.com>
 <kwiwaeaijj6sxwz5fhtxyoquhz2kpujbsbeajysufgmdjgyx5c@f6lqrd23xr5f>
 <CAADnVQLcAoN5z+HD_44UKgJJc6t5TPW8+Ai9We0qJpau4NtEzA@mail.gmail.com>
 <wltfmammaf5g4gumsbna4kmwo6dtd24g472o7kgkug42dhwcy2@32fmd7q6kvg4>
 <CAADnVQJQZ2jQSWByVvi3N2ZOoL0XDSJzx5biSVvq=inS7OSW7A@mail.gmail.com>
 <t6wypww537golmoosbikfuombrqq555fh5mbycwl4whto6joo4@hcqlospkgqyr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <t6wypww537golmoosbikfuombrqq555fh5mbycwl4whto6joo4@hcqlospkgqyr>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Xu <dxu@dxuuu.xyz> wrote:
> On Thu, Jul 13, 2023 at 04:10:03PM -0700, Alexei Starovoitov wrote:
> > Why is rcu_assign_pointer() used?
> > If it's not RCU protected, what is the point of rcu_*() accessors
> > and rcu_read_lock() ?
> > 
> > In general, the pattern:
> > rcu_read_lock();
> > ptr = rcu_dereference(...);
> > rcu_read_unlock();
> > ptr->..
> > is a bug. 100%.

FWIW, I agree with Alexei, it does look... dodgy.

> The reason I left it like this is b/c otherwise I think there is a race
> with module unload and taking a refcnt. For example:
> 
> ptr = READ_ONCE(global_var)
>                                              <module unload on other cpu>
> // ptr invalid
> try_module_get(ptr->owner) 
>

Yes, I agree.

> I think the the synchronize_rcu() call in
> kernel/module/main.c:free_module() protects against that race based on
> my reading.
> 
> Maybe the ->enable() path can store a copy of the hook ptr in
> struct bpf_nf_link to get rid of the odd rcu_dereference()?
> 
> Open to other ideas too -- would appreciate any hints.

I would suggest the following:

- Switch ordering of patches 2 and 3.
  What is currently patch 3 would add the .owner fields only.

Then, what is currently patch #2 would document the rcu/modref
interaction like this (omitting error checking for brevity):

rcu_read_lock();
v6_hook = rcu_dereference(nf_defrag_v6_hook);
if (!v6_hook) {
        rcu_read_unlock();
        err = request_module("nf_defrag_ipv6");
        if (err)
                 return err < 0 ? err : -EINVAL;
        rcu_read_lock();
	v6_hook = rcu_dereference(nf_defrag_v6_hook);
}

if (v6_hook && try_module_get(v6_hook->owner))
	v6_hook = rcu_pointer_handoff(v6_hook);
else
	v6_hook = NULL;

rcu_read_unlock();

if (!v6_hook)
	err();
v6_hook->enable();


I'd store the v4/6_hook pointer in the nf bpf link struct, its probably more
self-explanatory for the disable side in that we did pick up a module reference
that we still own at delete time, without need for any rcu involvement.

Because above handoff is repetitive for ipv4 and ipv6,
I suggest to add an agnostic helper for this.

I know you added distinct structures for ipv4 and ipv6 but if they would use
 the same one you could add

static const struct nf_defrag_hook *get_proto_frag_hook(const struct nf_defrag_hook __rcu *hook,
							const char *modulename);

And then use it like:

v4_hook = get_proto_frag_hook(nf_defrag_v4_hook, "nf_defrag_ipv4");

Without a need to copy the modprobe and handoff part.

What do you think?
