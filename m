Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE8AD793215
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 00:45:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243039AbjIEWpF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 18:45:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbjIEWpD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 18:45:03 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F834FA
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 15:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693953900; x=1725489900;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=BcZkq7IcQZ96F0Z/kgGOKOdOKCDjMpYiw9DdVLs8LDQ=;
  b=juyPWRzRgNatcE5HGvsFrmXRoUADBmPh7E1FLhJZPR8njeqJIAHDL3oN
   JU1900aLSVAhqExcA5OFHe/49Mv1QxCJZ9wCMoIUD8rZ7pWJ//yLZ+ZrP
   PFB7HOCA8j2JVx73WdPdIf4caOW9dolQ+0iFRncyM55Z+KLxCcZmJPDRV
   DtH8TIqV+Czek9Ywwl5lpiBARDJak+A5aU19UrHl1N4Vba1ed/LljLJ7Z
   +UZbw+U0QofDVMu3YgPqReTJ3RRshiC+VDef3IuQeoM7PsRzb2GY+6DNM
   /2Hxsl+LDcKaY1Kn61OiO18N2vvbyEtyCgaacn7tgpTeTii8GZThuhF16
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="463297265"
X-IronPort-AV: E=Sophos;i="6.02,230,1688454000"; 
   d="scan'208";a="463297265"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2023 15:44:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="856173675"
X-IronPort-AV: E=Sophos;i="6.02,230,1688454000"; 
   d="scan'208";a="856173675"
Received: from dpdesmon-mobl.amr.corp.intel.com (HELO [10.209.18.208]) ([10.209.18.208])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2023 15:44:58 -0700
Message-ID: <ae4b342c424b76dc3f8adafcc2da7c02b9755b10.camel@linux.intel.com>
Subject: Re: [RFC PATCH 1/2] sched: Rate limit migrations to 1 per 2ms per
 task
From:   Tim Chen <tim.c.chen@linux.intel.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Swapnil Sapkal <Swapnil.Sapkal@amd.com>,
        Aaron Lu <aaron.lu@intel.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>, x86@kernel.org
Date:   Tue, 05 Sep 2023 15:44:57 -0700
In-Reply-To: <866f23cc-6725-fc74-099f-450939fc0dc4@efficios.com>
References: <20230905171105.1005672-1-mathieu.desnoyers@efficios.com>
         <20230905171105.1005672-2-mathieu.desnoyers@efficios.com>
         <cfc3de8fa3172cedf406ccef8c94ef4da0a00281.camel@linux.intel.com>
         <866f23cc-6725-fc74-099f-450939fc0dc4@efficios.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-09-05 at 17:16 -0400, Mathieu Desnoyers wrote:
> On 9/5/23 16:28, Tim Chen wrote:
> > On Tue, 2023-09-05 at 13:11 -0400, Mathieu Desnoyers wrote:
> > > Rate limit migrations to 1 migration per 2 milliseconds per task. On =
a
> > > kernel with EEVDF scheduler (commit b97d64c722598ffed42ece814a2cb7913=
36c6679),
> > > this speeds up hackbench from 62s to 45s on AMD EPYC 192-core (over 2=
 sockets).
> > >=20
> > >=20
> > >=20
> > > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > > index 479db611f46e..0d294fce261d 100644
> > > --- a/kernel/sched/core.c
> > > +++ b/kernel/sched/core.c
> > > @@ -4510,6 +4510,7 @@ static void __sched_fork(unsigned long clone_fl=
ags, struct task_struct *p)
> > >   	p->se.vruntime			=3D 0;
> > >   	p->se.vlag			=3D 0;
> > >   	p->se.slice			=3D sysctl_sched_base_slice;
> > > +	p->se.next_migration_time	=3D 0;
> >=20
> > It seems like the next_migration_time should be initialized to the curr=
ent time,
> > in case the system run for a long time and clock wrap around could caus=
e problem.
>=20
> next_migration_time is a u64, which should "never" overflow. Other=20

Reading up on sched_clock() documentation and seems like it should=C2=A0
indeed be monotonic.
For TSC based clock, which starts from 0 at boot
and TSC doesn't wrap around on the order of ~190 years. =C2=A0

I wonder about the corner case when a system suspeds and resume.  The
documentation on sched clock says "The clock driving sched_clock() may=C2=
=A0
stop or reset to zero during system suspend/sleep".
If the sched_clock is reset to 0, the next_migration_time for all=C2=A0
suspended tasks should also be reset to 0
before they resume so the next migration time is not in the long future.

Thanks.

Tim

> scheduler code comparing with sched_clock() don't appear to care about=
=20
> u64 overflow. Sampling the next_migration_time on fork could delay=20
> migrations for a 2ms window after process creation, which I don't think=
=20
> is something we want. Or if we do want this behavior, it should be=20
> validated with benchmarks beforehand.
>=20
> >=20
> > >   	INIT_LIST_HEAD(&p->se.group_node);
> > >  =20
> > >   #ifdef CONFIG_FAIR_GROUP_SCHED
> > > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > > index d92da2d78774..24ac69913005 100644
> > > --- a/kernel/sched/fair.c
> > > +++ b/kernel/sched/fair.c
> > > @@ -960,6 +960,14 @@ int sched_update_scaling(void)
> > >  =20
> > >   static void clear_buddies(struct cfs_rq *cfs_rq, struct sched_entit=
y *se);
> > >  =20
> > > +static bool should_migrate_task(struct task_struct *p, int prev_cpu)
> > > +{
> > > +	/* Rate limit task migration. */
> > > +	if (sched_clock_cpu(prev_cpu) < p->se.next_migration_time)
> >=20
> > Should we use time_before(sched_clock_cpu(prev_cpu), p->se.next_migrati=
on_time) ?
>=20
> No, because time_before expects unsigned long parameters, and=20
> sched_clock_cpu() and next_migration_time are u64.
>=20
> Thanks,
>=20
> Mathieu

