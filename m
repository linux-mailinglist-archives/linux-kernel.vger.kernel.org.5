Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37614797C2E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 20:44:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344283AbjIGSoo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 14:44:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344279AbjIGSom (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 14:44:42 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B4FA132;
        Thu,  7 Sep 2023 11:44:37 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1qeJzS-0001hz-Iq; Thu, 07 Sep 2023 20:44:30 +0200
Date:   Thu, 7 Sep 2023 20:44:30 +0200
From:   Florian Westphal <fw@strlen.de>
To:     David Wang <00107082@163.com>
Cc:     Daniel Xu <dxu@dxuuu.xyz>, Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Florian Westphal <fw@strlen.de>,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH] uapi/netfilter: Change netfilter hook verdict code
 definition from macro to enum
Message-ID: <20230907184430.GF20947@breakpoint.cc>
References: <20230904130201.14632-1-00107082@163.com>
 <cc6e3tukgqhi5y4uhepntrpf272o652pytuynj4nijsf5bkgjq@rgnbhckr3p4w>
 <19d2362f.5c85.18a6647817b.Coremail.00107082@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19d2362f.5c85.18a6647817b.Coremail.00107082@163.com>
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
> At 2023-09-06 00:38:02, "Daniel Xu" <dxu@dxuuu.xyz> wrote:
> >Hi David,
> >
> >On Mon, Sep 04, 2023 at 09:02:02PM +0800, David Wang wrote:
> 
> >>  #include <linux/in6.h>
> >>  
> >>  /* Responses from hook functions. */
> >> -#define NF_DROP 0
> >> -#define NF_ACCEPT 1
> >> -#define NF_STOLEN 2
> >> -#define NF_QUEUE 3
> >> -#define NF_REPEAT 4
> >> -#define NF_STOP 5	/* Deprecated, for userspace nf_queue compatibility. */
> >> -#define NF_MAX_VERDICT NF_STOP
> >> +enum {
> >> +	NF_DROP        = 0,
> >> +	NF_ACCEPT      = 1,
> >> +	NF_STOLEN      = 2,
> >> +	NF_QUEUE       = 3,
> >> +	NF_REPEAT      = 4,
> >> +	NF_STOP        = 5,	/* Deprecated, for userspace nf_queue compatibility. */
> >> +	NF_MAX_VERDICT = NF_STOP,
> >> +};
> >
> >Switching from macro to enum works for almost all use cases, but not
> >all. If someone if #ifdefing the symbols (which is plausible) this
> >change would break them.
> >
> >I think I've seen some other networking code define both enums and
> >macros. But it was a little ugly. Not sure if that is acceptable here or
> >not.
> >
> >[...]
> >
> >Thanks,
> >Daniel
> 
> 
> Thanks for the review~
> I do not have a strong reasoning to deny the possibility of breaking unexpected usage of this macros,
> 
> but I also agree that it is ugly to use both enum and macro at the same time.
> 
> Kind of don't know how to proceed from here now...

I don't see anyone doing #ifdef tests on these, so I suggest we
give your patch a try and see if anything breaks.

Technically only ACCEPT and DROP can be used by bpf
programs but splitting it in
enum-for-accept-drop-and-define-for-the-rest looks even more silly.
