Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F007F75614A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 13:11:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbjGQLLg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 07:11:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbjGQLLd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 07:11:33 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E65EE1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 04:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=CTMOEue5i+/+41KVpYou8hDhTmtQ6MkXTaitTVQIf0M=; b=N5UGq2Nvp2MIe+qtMwFQQ36oHk
        B3/PLiEnp9C87SwS4KYBnLhhdCoJD8VNg3C6ByPsYxbPxGvT8CgWCyZ+BkYG+Gt096NfzgXRv03Nq
        WbsrrQtJD4Qt2JELbuU+TNkIgblScH6Y/+xJs8iQ1PpFlBuA7f6lK7FTz4zQu20J88cpfMDu0HHOB
        WOprEYLrK5RoEsyLta2VNHWSy1INXbXnR6B+SLzPn018qKJgxDTZHkFvwhf/DHHmuBlIhRrqBvM1S
        UmNg+bQ/0dwVyeBIBg+ST2PjBTWqLAK20YXW40S//phD6xbUbsIGakPDAdTzXy9Olt2qjSi9Ln9Uu
        wala5pQw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qLM80-00962A-2g;
        Mon, 17 Jul 2023 11:10:56 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5460130049D;
        Mon, 17 Jul 2023 13:10:53 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3CB0E2463D7F2; Mon, 17 Jul 2023 13:10:53 +0200 (CEST)
Date:   Mon, 17 Jul 2023 13:10:53 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Shrikanth Hegde <sshegde@linux.vnet.ibm.com>
Cc:     Tim Chen <tim.c.chen@linux.intel.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ricardo Neri <ricardo.neri@intel.com>,
        "Ravi V . Shankar" <ravi.v.shankar@intel.com>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Len Brown <len.brown@intel.com>, Mel Gorman <mgorman@suse.de>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Valentin Schneider <vschneid@redhat.com>,
        Ionela Voinescu <ionela.voinescu@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        naveen.n.rao@linux.vnet.ibm.com,
        Yicong Yang <yangyicong@hisilicon.com>,
        Barry Song <v-songbaohua@oppo.com>,
        Chen Yu <yu.c.chen@intel.com>, Hillf Danton <hdanton@sina.com>
Subject: Re: [Patch v3 1/6] sched/fair: Determine active load balance for SMT
 sched groups
Message-ID: <20230717111053.GI4253@hirez.programming.kicks-ass.net>
References: <cover.1688770494.git.tim.c.chen@linux.intel.com>
 <e24f35d142308790f69be65930b82794ef6658a2.1688770494.git.tim.c.chen@linux.intel.com>
 <165778ce-7b8f-1966-af02-90ef481455b9@linux.vnet.ibm.com>
 <a399af19aa8e1291558724509a1de2f52b3bad0a.camel@linux.intel.com>
 <05ed4537-e79b-0ff3-5be5-92cbffaab3ee@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <05ed4537-e79b-0ff3-5be5-92cbffaab3ee@linux.vnet.ibm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 17, 2023 at 01:06:59AM +0530, Shrikanth Hegde wrote:
> 
> 
> On 7/15/23 4:35 AM, Tim Chen wrote:
> > On Fri, 2023-07-14 at 18:36 +0530, Shrikanth Hegde wrote:
> > 
> >>
> >>
> >> If we consider symmetric platforms which have SMT4 such as power10. 
> >> we have a topology like below. multiple such MC will form DIE(PKG)
> >>
> >>
> >> [0 2 4 6][1 3 5 7][8 10 12 14][9 11 13 15]
> >> [--SMT--][--SMT--][----SMT---][---SMT----]
> >> [--sg1--][--sg1--][---sg1----][---sg1----]
> >> [--------------MC------------------------]
> >>
> >> In case of SMT4, if there is any group which has 2 or more tasks, that 
> >> group will be marked as group_smt_balance. previously, if that group had 2
> >> or 3 tasks, it would have been marked as group_has_spare. Since all the groups have 
> >> SMT that means behavior would be same fully busy right? That can cause some 
> >> corner cases. No?
> > 
> > You raised a good point. I was looking from SMT2
> > perspective so group_smt_balance implies group_fully_busy.
> > That is no longer true for SMT4.
> > 
> > I am thinking of the following fix on the current patch
> > to take care of SMT4. Do you think this addresses
> 
> Thanks Tim for taking a look at it again. 
> 
> Yes. I think this would address some of the corner cases. 
> Any SMT4 group having 2,3,4 will have smt_balance as the group type, and busiest one 
> is the one which has least number of idle cpu's. (same conditions as group_has_spare)
> 
> 
> 
> 
> > concerns from you and Tobias?
> > 
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 294a662c9410..3fc8d3a3bd22 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -9588,6 +9588,17 @@ static bool update_sd_pick_busiest(struct lb_env *env,
> >                 break;
> >  
> >         case group_smt_balance:
> > +               /* no idle cpus on both groups handled by group_fully_busy below */
> > +               if (sgs->idle_cpus != 0 || busiest->idle_cpus != 0) {
> > +                       if (sgs->idle_cpus > busiest->idle_cpus)
> > +                               return false;
> > +                       if (sgs->idle_cpus < busiest->idle_cpus)
> > +                               return true;
> > +                       if (sgs->sum_nr_running <= busiest_sum_nr_running)
> > +                               return false;
> > +                       else
> > +                               return true;
> > +               }
> > 
> > 
> > I will be on vacation next three weeks so my response will be slow.
> > 
> > Tim
> > 
> >>
> 
> Small suggestion to above code to avoid compiler warning of switch case falling
> through and else case can be removed, since update_sd_pick_busiest by default returns true.
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index e5a75c76bcaa..ae364ac6f22e 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -9728,9 +9728,9 @@ static bool update_sd_pick_busiest(struct lb_env *env,
>                                 return true;
>                         if (sgs->sum_nr_running <= busiest->sum_nr_running)
>                                 return false;
> -                       else
> -                               return true;
>                 }
> +               break;
> +
>         case group_fully_busy:
>                 /*
>                  * Select the fully busy group with highest avg_load. In
> 
> 

Can someone please send a full patch for this? I've already queued Tim's
patches in tip/sched/core (tip-bot seems to have died somewhere last
week, it's being worked on).
