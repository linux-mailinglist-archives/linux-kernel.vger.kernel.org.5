Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A1B07EFF5F
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 13:02:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbjKRMCy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 07:02:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjKRMCx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 07:02:53 -0500
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FCA0194;
        Sat, 18 Nov 2023 04:02:49 -0800 (PST)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1r4K1z-0002nv-2p; Sat, 18 Nov 2023 13:02:35 +0100
Date:   Sat, 18 Nov 2023 13:02:35 +0100
From:   Florian Westphal <fw@strlen.de>
To:     Kamil Duljas <kamil.duljas@gmail.com>
Cc:     Jakub Kicinski <kuba@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, Jiri Pirko <jiri@resnulli.us>,
        Johannes Berg <johannes@sipsolutions.net>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] genetlink: Prevent memory leak when krealloc fail
Message-ID: <20231118120235.GA30289@breakpoint.cc>
References: <20231118113357.1999-1-kamil.duljas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231118113357.1999-1-kamil.duljas@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kamil Duljas <kamil.duljas@gmail.com> wrote:
> genl_allocate_reserve_groups() allocs new memory in while loop
> but if krealloc fail, the memory allocated by kzalloc is not freed.
> It seems allocated memory is unnecessary when the function
> returns -ENOMEM

Why should it be free'd?  mc_groups is not a local variable.

>  				new_groups = krealloc(mc_groups, nlen,
>  						      GFP_KERNEL);
> -				if (!new_groups)
> +				if (!new_groups) {
> +					kfree(mc_groups);
>  					return -ENOMEM;
> +				}

How did you test this?  AFAICS this results in use-after-free for every
access to mc_groups after this error path is taken.

Existing code looks correct, we can't grow mc_groups and return an
error.
