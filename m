Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 445237CBE9F
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 11:10:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234858AbjJQJKt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 05:10:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234969AbjJQJKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 05:10:23 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7223BFD;
        Tue, 17 Oct 2023 02:10:09 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C7A1C433C8;
        Tue, 17 Oct 2023 09:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697533809;
        bh=XzWNIY/hrbTa3IpvjUeTL3enp5iOsmUIH+SzZ2/j/S4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HYFrKPuxxNnAO4bIJuWAo3vtIdUGAyUiM0Ji3FbzfmtycscCLf6EbhI0QBq1XyWZp
         v9HCOlY08mIS+7BDSJEyqQ9hbVrLXQ+qUeYPciXTcPP2mswDuUoDVITdjw8G3MYpm3
         0yy0JpWRsLtBixnefQMKg8SBdh6hldh8rt4ltCZsuipjz11rIaPwSpRLR1s8KCcH7k
         1oC4SuX7bcQk5aS6RpG41SLA0wEqXTzSFX2TndKUdUGP97V82uFSw+wpNHJV31PDeq
         vvMssJPuN3bgBsQsFyDvrPPlHo6QmDFEOuLMGFSH1jCL9zh28CM9ChnDRQIK8ffU4Q
         vioQ+2/eFWkcw==
Date:   Tue, 17 Oct 2023 11:10:02 +0200
From:   Simon Horman <horms@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        dev@openvswitch.org, kernel-janitors@vger.kernel.org,
        Tom Rix <trix@redhat.com>, llvm@lists.linux.dev,
        Nick Desaulniers <ndesaulniers@google.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        linux-hardening@vger.kernel.org, netdev@vger.kernel.org,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [ovs-dev] [PATCH v2 2/2] net: openvswitch: Annotate struct
 mask_array with __counted_by
Message-ID: <20231017091002.GR1751252@kernel.org>
References: <e5122b4ff878cbf3ed72653a395ad5c4da04dc1e.1697264974.git.christophe.jaillet@wanadoo.fr>
 <ca5c8049f58bb933f231afd0816e30a5aaa0eddd.1697264974.git.christophe.jaillet@wanadoo.fr>
 <202310141928.23985F1CA@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202310141928.23985F1CA@keescook>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 14, 2023 at 07:29:57PM -0700, Kees Cook wrote:
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

Likewise, I agree this is correct.

Reviewed-by: Simon Horman <horms@kernel.org>
