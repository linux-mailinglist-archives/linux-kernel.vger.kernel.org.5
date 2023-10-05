Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 501267BA2C9
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 17:46:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233079AbjJEPqm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 11:46:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233929AbjJEPpR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 11:45:17 -0400
X-Greylist: delayed 585 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 05 Oct 2023 08:02:08 PDT
Received: from smtp-out.kfki.hu (smtp-out.kfki.hu [148.6.0.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87EEA21D00;
        Thu,  5 Oct 2023 08:02:07 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by smtp2.kfki.hu (Postfix) with ESMTP id 16261CC02C3;
        Thu,  5 Oct 2023 16:50:46 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at smtp2.kfki.hu
Received: from smtp2.kfki.hu ([127.0.0.1])
        by localhost (smtp2.kfki.hu [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP; Thu,  5 Oct 2023 16:50:43 +0200 (CEST)
Received: from blackhole.kfki.hu (blackhole.szhk.kfki.hu [148.6.240.2])
        by smtp2.kfki.hu (Postfix) with ESMTP id 52ACACC02C0;
        Thu,  5 Oct 2023 16:50:42 +0200 (CEST)
Received: by blackhole.kfki.hu (Postfix, from userid 1000)
        id 096853431A9; Thu,  5 Oct 2023 16:50:42 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by blackhole.kfki.hu (Postfix) with ESMTP id 076443431A8;
        Thu,  5 Oct 2023 16:50:42 +0200 (CEST)
Date:   Thu, 5 Oct 2023 16:50:42 +0200 (CEST)
From:   Jozsef Kadlecsik <kadlec@netfilter.org>
To:     Florian Westphal <fw@strlen.de>
cc:     xiaolinkui <xiaolinkui@126.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        David Miller <davem@davemloft.net>, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, justinstitt@google.com,
        kuniyu@amazon.com, netfilter-devel@vger.kernel.org,
        coreteam@netfilter.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Linkui Xiao <xiaolinkui@kylinos.cn>
Subject: Re: [PATCH] netfilter: ipset: wait for xt_recseq on all cpus
In-Reply-To: <20231005123107.GB9350@breakpoint.cc>
Message-ID: <2c9efd36-f1f6-b77b-d4eb-f65932cfaba@netfilter.org>
References: <20231005115022.12902-1-xiaolinkui@126.com> <20231005123107.GB9350@breakpoint.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Oct 2023, Florian Westphal wrote:

> xiaolinkui <xiaolinkui@126.com> wrote:
> > From: Linkui Xiao <xiaolinkui@kylinos.cn>
> > 
> > Before destroying the ipset, take a check on sequence to ensure that the
> > ip_set_test operation of this ipset has been completed.
> > 
> > The code of set_match_v4 is protected by addend=xt_write_recseq_begin() and
> > xt_write_recseq_end(addend). So we can ensure that the test operation is
> > completed by reading seqcount.
> 
> Nope, please don't do this, the xt_set can also be used from nft_compat
> which doesn't use the xtables packet traversers.
> 
> I'd rather use synchonize_rcu() once in ip_set_destroy(), that will
> make sure all concurrent traversers are gone.

But ip_set_destroy() can be called only when there's no reference to the 
set in the kernel and thus there's no ipset function whatsoever in the 
packet path which would access it.

> That said, I still do not understand this fix, the
> match / target destroy hooks are called after the table has
> been completely replaced, i.e., while packets can still be in flight
> no packets should be within the ipset lookup functions when
> this happens, and no more packets should be able to enter them.
> 
> AFAICS the request to delete the set will fail if its still referenced
> via any rule. xt_set holds references to the sets.
> 
> So:
> 1. set have dropped all references
> 2. userspace *can* delete the set
> 3. we get crash because xt_set was still within a sets eval
>   function.
> 
> I don't see how 3) can happen, xt table replace isn't supposed
> to call the xt_set destroy functions until after table replace.
> 
> We even release the entire x_table blob right afterwards.

I'd expect the author to send patches to netfilter-devel@vger.kernel.org 
first in order to review netfilter and ipset related patches there.

Best regards,
Jozsef
-
E-mail  : kadlec@blackhole.kfki.hu, kadlecsik.jozsef@wigner.hu
PGP key : https://wigner.hu/~kadlec/pgp_public_key.txt
Address : Wigner Research Centre for Physics
          H-1525 Budapest 114, POB. 49, Hungary
