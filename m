Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2F107C97EB
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Oct 2023 06:53:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233478AbjJOExh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Oct 2023 00:53:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230091AbjJOExf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Oct 2023 00:53:35 -0400
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9D1DD9;
        Sat, 14 Oct 2023 21:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=fMGwmeCiI2WGZSSIY9zDXk4JfSuYvkdAr36FIasOYjU=;
  b=k5IQxBjXGV3CnXmP7VgfiaoFeBhRXdFbvwWcEJ86HrDH2aegcMqgy9/b
   I9LI0HC1txkCq9sNogIroruo9K0Hh9y5ZrXnsAxRar8tN2v4I3LVDbRSv
   x6yt7j8E7k1e7EcOSnJOckIDAkgHN9kLA1i0nOA4E0PtLe9QlrFZZ21U9
   w=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.03,226,1694728800"; 
   d="scan'208";a="68734435"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2023 06:53:30 +0200
Date:   Sun, 15 Oct 2023 06:53:29 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Kees Cook <keescook@chromium.org>
cc:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Pravin B Shelar <pshelar@ovn.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, netdev@vger.kernel.org,
        dev@openvswitch.org, linux-hardening@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH v2 2/2] net: openvswitch: Annotate struct mask_array with
 __counted_by
In-Reply-To: <202310141928.23985F1CA@keescook>
Message-ID: <alpine.DEB.2.22.394.2310150653070.3260@hadrien>
References: <e5122b4ff878cbf3ed72653a395ad5c4da04dc1e.1697264974.git.christophe.jaillet@wanadoo.fr> <ca5c8049f58bb933f231afd0816e30a5aaa0eddd.1697264974.git.christophe.jaillet@wanadoo.fr> <202310141928.23985F1CA@keescook>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 14 Oct 2023, Kees Cook wrote:

> On Sat, Oct 14, 2023 at 08:34:53AM +0200, Christophe JAILLET wrote:
> > Prepare for the coming implementation by GCC and Clang of the __counted_by
> > attribute. Flexible array members annotated with __counted_by can have
> > their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> > (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> > functions).
> >
> > Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> > ---
> > v2: Fix the subject  [Ilya Maximets]
> >     fix the field name used with __counted_by  [Ilya Maximets]
> >
> > v1: https://lore.kernel.org/all/f66ddcf1ef9328f10292ea75a17b584359b6cde3.1696156198.git.christophe.jaillet@wanadoo.fr/
> >
> >
> > This patch is part of a work done in parallel of what is currently worked
> > on by Kees Cook.
> >
> > My patches are only related to corner cases that do NOT match the
> > semantic of his Coccinelle script[1].

What was the problem with the semantic patch in this case?

thanks,
julia


> >
> > In this case, in tbl_mask_array_alloc(), several things are allocated with
> > a single allocation. Then, some pointer arithmetic computes the address of
> > the memory after the flex-array.
> >
> > [1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci
> > ---
> >  net/openvswitch/flow_table.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/net/openvswitch/flow_table.h b/net/openvswitch/flow_table.h
> > index 9e659db78c05..f524dc3e4862 100644
> > --- a/net/openvswitch/flow_table.h
> > +++ b/net/openvswitch/flow_table.h
> > @@ -48,7 +48,7 @@ struct mask_array {
> >  	int count, max;
> >  	struct mask_array_stats __percpu *masks_usage_stats;
> >  	u64 *masks_usage_zero_cntr;
> > -	struct sw_flow_mask __rcu *masks[];
> > +	struct sw_flow_mask __rcu *masks[] __counted_by(max);
> >  };
>
> Yup, this looks correct to me. Thanks!
>
> Reviewed-by: Kees Cook <keescook@chromium.org>
>
> --
> Kees Cook
>
