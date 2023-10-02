Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FE917B5798
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 18:13:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238227AbjJBPsp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 11:48:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238224AbjJBPsn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 11:48:43 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3D4BAB;
        Mon,  2 Oct 2023 08:48:40 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44169C433C7;
        Mon,  2 Oct 2023 15:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696261720;
        bh=ELvrTTc3tgkEtVZaFMDyJF1B3XJ0+YcocBLVouLOqvY=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=DcyhWZjtp0vISG7Vld77phnuaJgizDc+s1fNzDCVZ+YYxie8riQ0udlN3ij2KHOTP
         2hmsCQM+ItEeZD5zk9GuB8MyiabXCLEYjDRXoBInTb4+garra9mqaq40lhdodzO2VM
         Eou/to32emItUdzK0pwVvfNbmlUwCo2nOlmLMwSh5LEJBS4CBkIurT+Fw7CHp+sKTL
         zCp6AotjcckUL9+tkBqFjHW1v99TQjOzJ/OfC4eEds7P74FXsx79ILvQn7oDK4oEfG
         yV+wHBNJKn1CY4Lxyf36kzzTAlRsKhBcSEhee1xNA+gLnE/tqnUTke2gB0MNtUL7Ig
         6Qednt2xWd0TQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id DFC70CE0CCF; Mon,  2 Oct 2023 08:48:39 -0700 (PDT)
Date:   Mon, 2 Oct 2023 08:48:39 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, rcu <rcu@vger.kernel.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH 10/10] rcu: Comment why callbacks migration can't wait
 for CPUHP_RCUTREE_PREP
Message-ID: <20c376e6-ba85-4c4a-bca6-727d3ef5e164@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230908203603.5865-1-frederic@kernel.org>
 <20230908203603.5865-11-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230908203603.5865-11-frederic@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 08, 2023 at 10:36:03PM +0200, Frederic Weisbecker wrote:
> The callbacks migration is performed through an explicit call from
> the hotplug control CPU right after the death of the target CPU and
> before proceeding with the CPUHP_ teardown functions.
> 
> This is unusual but necessary and yet uncommented. Summarize the reason
> as explained in the changelog of:
> 
> 	a58163d8ca2c (rcu: Migrate callbacks earlier in the CPU-offline timeline)
> 
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>

> ---
>  kernel/cpu.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/kernel/cpu.c b/kernel/cpu.c
> index a41a6fff3c91..b135bb481be1 100644
> --- a/kernel/cpu.c
> +++ b/kernel/cpu.c
> @@ -1352,7 +1352,14 @@ static int takedown_cpu(unsigned int cpu)
>  	cpuhp_bp_sync_dead(cpu);
>  
>  	tick_cleanup_dead_cpu(cpu);
> +
> +	/*
> +	 * Callbacks must be re-integrated right away to the RCU state machine.
> +	 * Otherwise an RCU callback could block a further teardown function
> +	 * waiting for its completion.
> +	 */
>  	rcutree_migrate_callbacks(cpu);
> +
>  	return 0;
>  }
>  
> -- 
> 2.41.0
> 
