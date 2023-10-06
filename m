Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B24967BC045
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 22:26:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233466AbjJFU0H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 16:26:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231912AbjJFU0F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 16:26:05 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46471BD
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 13:26:01 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3E05C433C7;
        Fri,  6 Oct 2023 20:26:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696623960;
        bh=QPzTmb5/1DB0NMquULcALN2ygsW27WAkF/x0WUgo1LA=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=uAEV6jJlml6Gzejf+VQJTL/pc7ei0O4nXg6LcVHsRkT2ncLGEztegJugOg78k78Cw
         ztsf9tjToi/TP0APFDu1aKhlOTdIzKeVu07nwJXv4PDSikYPmJZzdp6dXwcGqZadKB
         eg1VUOdDeRthW5qVbLQyyEwrY82PHT0y2EvI1+D1LX/FO2jU+VCy2XoukYmC8iST3B
         iakI/dLCTeAPX+RGN1t6KiPikrm30JG4il5TngYJUhmdqgX31BE76DfObL9grts63q
         M8NViw7SmLBdW90+Q5G9mFOg4as7M1LgGsV8Ks4SIr8pQP+nsaqoaBfEfvnOMKe8Jh
         lzaL5wzRpEipQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 607E2CE0BAE; Fri,  6 Oct 2023 13:26:00 -0700 (PDT)
Date:   Fri, 6 Oct 2023 13:26:00 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Valentin Schneider <vschneid@redhat.com>,
        Juergen Gross <jgross@suse.com>,
        Leonardo Bras <leobras@redhat.com>,
        Imran Khan <imran.f.khan@oracle.com>
Subject: Re: [PATCH smp,csd] Throw an error if a CSD lock is stuck for too
 long
Message-ID: <a459fe36-3077-48f1-bcd4-63a07f4866f3@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <bc7cc8b0-f587-4451-8bcd-0daae627bcc7@paulmck-laptop>
 <53b8065f-1f65-6956-279c-05bd461a7284@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <53b8065f-1f65-6956-279c-05bd461a7284@huaweicloud.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 06, 2023 at 08:48:23PM +0200, Jonas Oberhauser wrote:
> Is this related to the qspinlock issue you described earlier?

Kind of in that sometimes qspinlock issues trigger CSD-lock warnings,
but not really directly related.

							Thanx, Paul

> jonas
> 
> 
> Am 10/5/2023 um 6:48 PM schrieb Paul E. McKenney:
> > The CSD lock seems to get stuck in 2 "modes". When it gets stuck
> > temporarily, it usually gets released in a few seconds, and sometimes
> > up to one or two minutes.
> > 
> > If the CSD lock stays stuck for more than several minutes, it never
> > seems to get unstuck, and gradually more and more things in the system
> > end up also getting stuck.
> > 
> > In the latter case, we should just give up, so the system can dump out
> > a little more information about what went wrong, and, with panic_on_oops
> > and a kdump kernel loaded, dump a whole bunch more information about
> > what might have gone wrong.
> > 
> > Question: should this have its own panic_on_ipistall switch in
> > /proc/sys/kernel, or maybe piggyback on panic_on_oops in a different
> > way than via BUG_ON?
> > 
> > Signed-off-by: Rik van Riel <riel@surriel.com>
> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > 
> > diff --git a/kernel/smp.c b/kernel/smp.c
> > index 8455a53465af..059f1f53fc6b 100644
> > --- a/kernel/smp.c
> > +++ b/kernel/smp.c
> > @@ -230,6 +230,7 @@ static bool csd_lock_wait_toolong(struct __call_single_data *csd, u64 ts0, u64 *
> >   	}
> >   	ts2 = sched_clock();
> > +	/* How long since we last checked for a stuck CSD lock.*/
> >   	ts_delta = ts2 - *ts1;
> >   	if (likely(ts_delta <= csd_lock_timeout_ns || csd_lock_timeout_ns == 0))
> >   		return false;
> > @@ -243,9 +244,17 @@ static bool csd_lock_wait_toolong(struct __call_single_data *csd, u64 ts0, u64 *
> >   	else
> >   		cpux = cpu;
> >   	cpu_cur_csd = smp_load_acquire(&per_cpu(cur_csd, cpux)); /* Before func and info. */
> > +	/* How long since this CSD lock was stuck. */
> > +	ts_delta = ts2 - ts0;
> >   	pr_alert("csd: %s non-responsive CSD lock (#%d) on CPU#%d, waiting %llu ns for CPU#%02d %pS(%ps).\n",
> > -		 firsttime ? "Detected" : "Continued", *bug_id, raw_smp_processor_id(), ts2 - ts0,
> > +		 firsttime ? "Detected" : "Continued", *bug_id, raw_smp_processor_id(), ts_delta,
> >   		 cpu, csd->func, csd->info);
> > +	/*
> > +	 * If the CSD lock is still stuck after 5 minutes, it is unlikely
> > +	 * to become unstuck. Use a signed comparison to avoid triggering
> > +	 * on underflows when the TSC is out of sync between sockets.
> > +	 */
> > +	BUG_ON((s64)ts_delta > 300000000000LL);
> >   	if (cpu_cur_csd && csd != cpu_cur_csd) {
> >   		pr_alert("\tcsd: CSD lock (#%d) handling prior %pS(%ps) request.\n",
> >   			 *bug_id, READ_ONCE(per_cpu(cur_csd_func, cpux)),
> 
