Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A24E17640E6
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 23:08:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231439AbjGZVHy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 17:07:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230306AbjGZVHv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 17:07:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D89B2122;
        Wed, 26 Jul 2023 14:07:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7F96661CAA;
        Wed, 26 Jul 2023 21:07:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD1ECC433C8;
        Wed, 26 Jul 2023 21:07:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690405667;
        bh=jxWkxAJfmYCp6DgVJWz6SjhDGtLFuqITHEbKhdu2CYc=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=I+uBZsz/Y+rltdxHSVYiKo/PhWomuGRhxVQuFMkxxHQwqcDJZM4o46G+U5LRt4k2E
         DjrEigYzGpCM0Lj4YrSEfxyzffBsvmpXsj2gjMGFrR8S3p2mKIldz5xUZ4DbjZQSNJ
         sTLqTg/FA1bq6C833xsB2MaQlQESyFR1FRyCi4RHmaXR4HURqTuyWOxTaxOB8RBGDx
         gIV77ydV+V3+ZQogHF4TpcVpjQhf1U6i7RrWaLpVddPkXH9lXNqFrcJ92L8pWPvqYB
         a/2/t5HrmlLZ7JfHWtJN/5ri3LdpQOKse+nSB0fwqV5pmOmWdU2wJfFgeIqFCZ0mdV
         Ukpzfi+TfHidQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 74B28CE0A1C; Wed, 26 Jul 2023 14:07:47 -0700 (PDT)
Date:   Wed, 26 Jul 2023 14:07:47 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "open list:SLEEPABLE READ-COPY UPDATE (SRCU)" <rcu@vger.kernel.org>
Subject: Re: [PATCH 2/5] srcu: Fix error handling in init_srcu_struct_fields()
Message-ID: <1943e34c-3c8e-411c-a677-33f8c5b4b0e5@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230725232913.2981357-1-joel@joelfernandes.org>
 <20230725232913.2981357-3-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230725232913.2981357-3-joel@joelfernandes.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 25, 2023 at 11:29:07PM +0000, Joel Fernandes (Google) wrote:
> The current error handling in init_srcu_struct_fields() is a bit
> inconsistent.  If init_srcu_struct_nodes() fails, the function either
> returns -ENOMEM or 0 depending on whether ssp->sda_is_static is true or
> false. This can make init_srcu_struct_fields() return 0 even if memory
> allocation failed!
> 
> Simplify the error handling by always returning -ENOMEM if either
> init_srcu_struct_nodes() or the per-CPU allocation fails. This makes the
> control flow easier to follow and avoids the inconsistent return values.
> 
> Add goto labels to avoid duplicating the error cleanup code.
> 
> Link: https://lore.kernel.org/r/20230404003508.GA254019@google.com
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>

Looks good, nice simplification!  One nit below.

							Thanx, Paul

> ---
>  kernel/rcu/srcutree.c | 31 +++++++++++++++++--------------
>  1 file changed, 17 insertions(+), 14 deletions(-)
> 
> diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> index 20d7a238d675..cbc37cbc1805 100644
> --- a/kernel/rcu/srcutree.c
> +++ b/kernel/rcu/srcutree.c
> @@ -255,29 +255,32 @@ static int init_srcu_struct_fields(struct srcu_struct *ssp, bool is_static)
>  	ssp->srcu_sup->sda_is_static = is_static;
>  	if (!is_static)
>  		ssp->sda = alloc_percpu(struct srcu_data);
> -	if (!ssp->sda) {
> -		if (!is_static)
> -			kfree(ssp->srcu_sup);
> -		return -ENOMEM;
> -	}
> +	if (!ssp->sda)
> +		goto err_free_sup;
>  	init_srcu_struct_data(ssp);
>  	ssp->srcu_sup->srcu_gp_seq_needed_exp = 0;
>  	ssp->srcu_sup->srcu_last_gp_end = ktime_get_mono_fast_ns();
>  	if (READ_ONCE(ssp->srcu_sup->srcu_size_state) == SRCU_SIZE_SMALL && SRCU_SIZING_IS_INIT()) {
> -		if (!init_srcu_struct_nodes(ssp, GFP_ATOMIC)) {
> -			if (!ssp->srcu_sup->sda_is_static) {

I was going to complain about this ssp->srcu_sup->sda_is_static becoming
just is_static, but now I cannot see why I didn't just use is_static in
the first place.  ;-)

> -				free_percpu(ssp->sda);
> -				ssp->sda = NULL;
> -				kfree(ssp->srcu_sup);
> -				return -ENOMEM;
> -			}
> -		} else {
> +		if (!init_srcu_struct_nodes(ssp, GFP_ATOMIC))
> +			goto err_free_sda;
> +		else
>  			WRITE_ONCE(ssp->srcu_sup->srcu_size_state, SRCU_SIZE_BIG);

Given that the "then" clause is a goto, what is the "else" clause doing
for us?

> -		}
>  	}
>  	ssp->srcu_sup->srcu_ssp = ssp;
>  	smp_store_release(&ssp->srcu_sup->srcu_gp_seq_needed, 0); /* Init done. */
>  	return 0;
> +
> +err_free_sda:
> +	if (!is_static) {
> +		free_percpu(ssp->sda);
> +		ssp->sda = NULL;
> +	}
> +err_free_sup:
> +	if (!is_static) {
> +		kfree(ssp->srcu_sup);
> +		ssp->srcu_sup = NULL;
> +	}
> +	return -ENOMEM;
>  }
>  
>  #ifdef CONFIG_DEBUG_LOCK_ALLOC
> -- 
> 2.41.0.487.g6d72f3e995-goog
> 
