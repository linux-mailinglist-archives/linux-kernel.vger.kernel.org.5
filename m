Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A29CD78C7DA
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 16:46:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236992AbjH2Opk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 10:45:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231600AbjH2OpP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 10:45:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E32C1E1;
        Tue, 29 Aug 2023 07:45:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6A7A165B78;
        Tue, 29 Aug 2023 14:45:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70EC9C433C7;
        Tue, 29 Aug 2023 14:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693320311;
        bh=ER9Gz9SFdmE/umOJVmlcEIl/MKJJYC+R+B+etHYGKBE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UTk0+OKvpRNKz85bTnMceJIK19J273fWUdGO/uFnpQO91jEe+m3zn58H4ezGGMoXt
         cnl9HqbY0nyTzHTUgHJ7oBTtUT2AfEK3mjQPjHAEt/7v/N1lmYTIsO4QGKrP40tfl8
         24QTcY1f1GmxScb0wHqL9mz4I1DQjrojcRYCim1s5P8/N/Ju2EM+wzX1KtpkaGrl21
         nCb2+hsJGsbQIGQQbMq2pwEKQmRNZEe5R1gTSoMekZUnWeMMfWqCNNag/y+t+tXv2j
         HHNUlWmvAMX9kMOPCvGv4p/OKYtDQ09Jt+fvlQD+5rFdfBPv3Z1GXROg8qSkLvirq2
         vDJcv08nkKwvA==
Date:   Tue, 29 Aug 2023 16:45:08 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
        paulmck@kernel.org, Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Zqiang <qiang.zhang1211@gmail.com>
Subject: Re: [PATCH v2 4/5] tree/nocb: Improve readability of nocb_gp_wait()
Message-ID: <ZO4EdIM/JtelKHFH@lothringen>
References: <20230729142738.222208-1-joel@joelfernandes.org>
 <20230729142738.222208-5-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230729142738.222208-5-joel@joelfernandes.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 29, 2023 at 02:27:34PM +0000, Joel Fernandes (Google) wrote:
>  /*
>   * No-CBs GP kthreads come here to wait for additional callbacks to show up
>   * or for grace periods to end.
>   */
>  static void nocb_gp_wait(struct rcu_data *my_rdp)
>  {
> -	bool bypass = false;
>  	int __maybe_unused cpu = my_rdp->cpu;
>  	unsigned long cur_gp_seq;
>  	unsigned long flags;
>  	bool gotcbs = false;
> -	unsigned long j = jiffies;
> -	bool lazy = false;
>  	bool needwait_gp = false; // This prevents actual uninitialized use.
>  	bool needwake;
>  	bool needwake_gp;
> +	int defer_wake_type = RCU_NOCB_WAKE_NOT;
>  	struct rcu_data *rdp, *rdp_toggling = NULL;
>  	struct rcu_node *rnp;
>  	unsigned long wait_gp_seq = 0; // Suppress "use uninitialized" warning.
> @@ -712,44 +758,24 @@ static void nocb_gp_wait(struct rcu_data *my_rdp)
>  	 * won't be ignored for long.
>  	 */
>  	list_for_each_entry(rdp, &my_rdp->nocb_head_rdp, nocb_entry_rdp) {
> -		long bypass_ncbs;
> -		bool flush_bypass = false;
> -		long lazy_ncbs;
> +		int defer_wake_type_one = RCU_NOCB_WAKE_NOT;

No need to initialize it, nocb_gp_flush_wake() always returns a value, and
it will avoid mistakes in the future if nocb_gp_flush_wake() is moved and
accidentally not called.

> +		bool flushed;
> +		bool empty;
>  
> -		trace_rcu_nocb_wake(rcu_state.name, rdp->cpu, TPS("Check"));
>  		rcu_nocb_lock_irqsave(rdp, flags);
> -		lockdep_assert_held(&rdp->nocb_lock);
> -		bypass_ncbs = rcu_cblist_n_cbs(&rdp->nocb_bypass);
> -		lazy_ncbs = READ_ONCE(rdp->lazy_len);
> +		defer_wake_type_one = nocb_gp_flush_wake(rdp, &empty, &flushed);
>  
> -		if (bypass_ncbs && (lazy_ncbs == bypass_ncbs) &&
> -		    (time_after(j, READ_ONCE(rdp->nocb_bypass_first) + jiffies_till_flush) ||
> -		     bypass_ncbs > 2 * qhimark)) {
> -			flush_bypass = true;
> -		} else if (bypass_ncbs && (lazy_ncbs != bypass_ncbs) &&
> -		    (time_after(j, READ_ONCE(rdp->nocb_bypass_first) + 1) ||
> -		     bypass_ncbs > 2 * qhimark)) {
> -			flush_bypass = true;
> -		} else if (!bypass_ncbs && rcu_segcblist_empty(&rdp->cblist)) {
> -			rcu_nocb_unlock_irqrestore(rdp, flags);
> -			continue; /* No callbacks here, try next. */
> -		}
> +		// We may need to do a deferred wakeup later for bypass/lazy
> +		// So note down what we learnt from the rdp.
> +		defer_wake_type = max(defer_wake_type_one, defer_wake_type);
>  
> -		if (flush_bypass) {
> -			// Bypass full or old, so flush it.
> -			(void)rcu_nocb_try_flush_bypass(rdp, j);
> -			bypass_ncbs = rcu_cblist_n_cbs(&rdp->nocb_bypass);
> -			lazy_ncbs = READ_ONCE(rdp->lazy_len);
> +		// Did we make any updates to main cblist? If not, no
> +		// non-deferred wake up to do for this rdp.
> +		if (!flushed && empty) {

Can you ever have (flushed && empty) ? If not you should be able to remove the
flushed parameter.

Thanks.

> +			rcu_nocb_unlock_irqrestore(rdp, flags);
> +			continue;
>  		}
>  
> -		if (bypass_ncbs) {
> -			trace_rcu_nocb_wake(rcu_state.name, rdp->cpu,
> -					    bypass_ncbs == lazy_ncbs ? TPS("Lazy") : TPS("Bypass"));
> -			if (bypass_ncbs == lazy_ncbs)
> -				lazy = true;
> -			else
> -				bypass = true;
> -		}
>  		rnp = rdp->mynode;
>  
