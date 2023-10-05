Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B7997BA52B
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 18:15:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240520AbjJEQOG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 12:14:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240972AbjJEQMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 12:12:20 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ADDA26A42;
        Thu,  5 Oct 2023 05:31:39 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1qoNVT-0008M5-La; Thu, 05 Oct 2023 14:31:07 +0200
Date:   Thu, 5 Oct 2023 14:31:07 +0200
From:   Florian Westphal <fw@strlen.de>
To:     xiaolinkui <xiaolinkui@126.com>
Cc:     pablo@netfilter.org, kadlec@netfilter.org, fw@strlen.de,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, justinstitt@google.com, kuniyu@amazon.com,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linkui Xiao <xiaolinkui@kylinos.cn>
Subject: Re: [PATCH] netfilter: ipset: wait for xt_recseq on all cpus
Message-ID: <20231005123107.GB9350@breakpoint.cc>
References: <20231005115022.12902-1-xiaolinkui@126.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231005115022.12902-1-xiaolinkui@126.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

xiaolinkui <xiaolinkui@126.com> wrote:
> From: Linkui Xiao <xiaolinkui@kylinos.cn>
> 
> Before destroying the ipset, take a check on sequence to ensure that the
> ip_set_test operation of this ipset has been completed.
> 
> The code of set_match_v4 is protected by addend=xt_write_recseq_begin() and
> xt_write_recseq_end(addend). So we can ensure that the test operation is
> completed by reading seqcount.

Nope, please don't do this, the xt_set can also be used from nft_compat
which doesn't use the xtables packet traversers.

I'd rather use synchonize_rcu() once in ip_set_destroy(), that will
make sure all concurrent traversers are gone.

That said, I still do not understand this fix, the
match / target destroy hooks are called after the table has
been completely replaced, i.e., while packets can still be in flight
no packets should be within the ipset lookup functions when
this happens, and no more packets should be able to enter them.

AFAICS the request to delete the set will fail if its still referenced
via any rule. xt_set holds references to the sets.

So:
1. set have dropped all references
2. userspace *can* delete the set
3. we get crash because xt_set was still within a sets eval
  function.

I don't see how 3) can happen, xt table replace isn't supposed
to call the xt_set destroy functions until after table replace.

We even release the entire x_table blob right afterwards.
