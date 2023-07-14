Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16325754563
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 01:29:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbjGNX3F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 19:29:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjGNX3D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 19:29:03 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D27FD3A87
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 16:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689377342; x=1720913342;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=uiYTcJPJmh4W/QVY1yRB8BdNSrQ492BteeJa949PR+Y=;
  b=QF+3v9ggLs1Km8KV5GGMnOXWHuBS4YoS5DFbR5U4u9B1NB5N58+ig5ay
   d5bu0HMFugFT6FXp5LJe86SoGnRPxAQSMWG2w58xyWySGsdLAB3vvnSUO
   h6t3M/Vu87dQkWtW/TIksL2DA9nPZ/uWVoKWgma2kscltZh+oV+o6Tcrg
   B9KgfaYa878PtKSY7JkxstksiKiPZoxNDyMH3Ww1A15Sn9yjXX/1Dkzc4
   OteWTpemP3Z1oU23uKAIKLc7D8Nu3CqB5LFxNhLBNRn0cfrIDh2zG5RtY
   jYhInN945Av/TDtqPKyhzYtfWS9moNYg82Kqj/lT7naSTlb8s1q+eI69w
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10771"; a="431779224"
X-IronPort-AV: E=Sophos;i="6.01,206,1684825200"; 
   d="scan'208";a="431779224"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2023 16:29:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10771"; a="1053240913"
X-IronPort-AV: E=Sophos;i="6.01,206,1684825200"; 
   d="scan'208";a="1053240913"
Received: from bmuller-mobl.amr.corp.intel.com (HELO [10.209.37.94]) ([10.209.37.94])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2023 16:29:01 -0700
Message-ID: <9de4ecabf658458f3f45f6970707a0b1458c6394.camel@linux.intel.com>
Subject: Re: [Patch v3 1/6] sched/fair: Determine active load balance for
 SMT sched groups
From:   Tim Chen <tim.c.chen@linux.intel.com>
To:     Tobias Huschle <huschle@linux.ibm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
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
        Shrikanth Hegde <sshegde@linux.vnet.ibm.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        naveen.n.rao@linux.vnet.ibm.com,
        Yicong Yang <yangyicong@hisilicon.com>,
        Barry Song <v-songbaohua@oppo.com>,
        Chen Yu <yu.c.chen@intel.com>, Hillf Danton <hdanton@sina.com>
Date:   Fri, 14 Jul 2023 16:29:00 -0700
In-Reply-To: <d3a1621eae04f7671b2b430352b42a27@linux.ibm.com>
References: <cover.1688770494.git.tim.c.chen@linux.intel.com>
         <e24f35d142308790f69be65930b82794ef6658a2.1688770494.git.tim.c.chen@linux.intel.com>
         <d3a1621eae04f7671b2b430352b42a27@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> >=20
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 87317634fab2..f636d6c09dc6 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -8279,6 +8279,11 @@ enum group_type {
> >  	 * more powerful CPU.
> >  	 */
> >  	group_misfit_task,
> > +	/*
> > +	 * Balance SMT group that's fully busy. Can benefit from migration
> > +	 * a task on SMT with busy sibling to another CPU on idle core.
> > +	 */
> > +	group_smt_balance,
>=20
> Would it make sense to move smt_balance?, s.t. we get:
>=20
> group_has_spare < group_smt_balance < group_fully_busy
>=20
> Conceptually I would be more intuitive to me like this as the
> smt_balance groups are more busy than has_spare ones, but less busy
> then fully_busy ones.
>=20
>  From a functional perspective I could also see some impact when
> update_sd_pick_busiest compares the group types. In that case we
> would remove tasks from fully busy groups before moving them
> from smt_balance groups. Not sure which way would be to prefer
> to increase overall throughput.
>=20
> Since smt_balance is only selected if the group has SMT, this
> should still not pull the last task off of a non-SMT CPU.
>=20
>=20

I think you have similar concerns as Shrikanth on this patch.
Can you see if my fix to update_sd_pick_busiest() in my reply
to Shrikanth addresses what you have in mind.

Tim
