Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75F5E7915DB
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 12:49:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351940AbjIDKtQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 06:49:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230431AbjIDKtQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 06:49:16 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 655ED19B;
        Mon,  4 Sep 2023 03:49:12 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1qd78a-0000sx-EP; Mon, 04 Sep 2023 12:48:56 +0200
Date:   Mon, 4 Sep 2023 12:48:56 +0200
From:   Florian Westphal <fw@strlen.de>
To:     David Wang <00107082@163.com>
Cc:     fw@strlen.de, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH] samples/bpf: Add sample usage for BPF_PROG_TYPE_NETFILTER
Message-ID: <20230904104856.GE11802@breakpoint.cc>
References: <20230904102128.11476-1-00107082@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230904102128.11476-1-00107082@163.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

David Wang <00107082@163.com> wrote:
> This sample code implements a simple ipv4
> blacklist via the new bpf type BPF_PROG_TYPE_NETFILTER,
> which was introduced in 6.4.
> 
> The bpf program drops package if destination ip address
> hits a match in the map of type BPF_MAP_TYPE_LPM_TRIE,
> 
> The userspace code would load the bpf program,
> attach it to netfilter's FORWARD/OUTPUT hook,
> and then write ip patterns into the bpf map.

Thanks, I think its good to have this.

> diff --git a/samples/bpf/netfilter_ip4_blacklist.bpf.c b/samples/bpf/netfilter_ip4_blacklist.bpf.c
> new file mode 100644
> index 000000000000..d315d64fda7f
> --- /dev/null
> +++ b/samples/bpf/netfilter_ip4_blacklist.bpf.c
> @@ -0,0 +1,62 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include "vmlinux.h"
> +#include <bpf/bpf_helpers.h>
> +
> +
> +#define NF_DROP 0
> +#define NF_ACCEPT 1

If you are interested, you could send a patch for nf-next that
makes the uapi headers expose this as enum, AFAIU that would make
the verdict nanes available via vmlinux.h.

> +	/* search p->daddr in trie */
> +	key.prefixlen = 32;
> +	key.data = p->daddr;
> +	pvalue = bpf_map_lookup_elem(&ipv4_lpm_map, &key);
> +	if (pvalue) {
> +		/* cat /sys/kernel/debug/tracing/trace_pipe */
> +		bpf_printk("rule matched with %d...\n", *pvalue);

If you are interested you could send a patch that adds a kfunc to
nf_bpf_link that exposes nf_log_packet() to bpf.

nf_log_packet has a terrible api, I suggest to have the kfunc take
'struct nf_hook_state *' instead of 6+ members of that struct as
argument.

Thanks for the example.
