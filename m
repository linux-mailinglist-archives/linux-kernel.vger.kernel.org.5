Return-Path: <linux-kernel+bounces-21599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9D728291A6
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 01:58:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C478428269E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 00:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 106A1656;
	Wed, 10 Jan 2024 00:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U96P3i+B"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C44EE38D
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 00:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704848321; x=1736384321;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=T2PZDIdw4KnyDQa2y+FgiY6adAF6RhE16QQIWZhVedk=;
  b=U96P3i+B+N6wY+y7tQ6QlUB8L7w/ddGSKdv13EfTbgBjqA6y88CSNDwj
   cp2LBbWj3YItT8EQDPfyJBvS0FyPo2iN92ensmZpnyjViU9WNvieWUAw1
   RDTwYivCuNwAFgSBqvMOuS/LnR8deuMPNdW+6WxrHTS4+embxCx2hNlGB
   qyboBj9jwyFRaK3i54MQFXFzp7p40z+cZx9deMQuO8h8rAnMuMmK81Rqw
   /io4lg9T1RvfxPAerwV6f3fkcnTAtDYIGhMw1iFvK/K07XHnUwW9r5Qsn
   n72mtJN97ecufRb8fI7UX2+8NQsmm2YeeUbzmoLpxLfjp9Yd0yVasZ0jv
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="5117447"
X-IronPort-AV: E=Sophos;i="6.04,184,1695711600"; 
   d="scan'208";a="5117447"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2024 16:58:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="900951117"
X-IronPort-AV: E=Sophos;i="6.04,184,1695711600"; 
   d="scan'208";a="900951117"
Received: from sahilmah-mobl.amr.corp.intel.com (HELO [10.209.63.195]) ([10.209.63.195])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2024 16:58:39 -0800
Message-ID: <a100b38341e13afbb5f8753b731c9e469e704667.camel@linux.intel.com>
Subject: Re: [PATCH] sched/fair: Enable group_asym_packing in
 find_idlest_group
From: Tim Chen <tim.c.chen@linux.intel.com>
To: Shrikanth Hegde <sshegde@linux.vnet.ibm.com>, Srikar Dronamraju
	 <srikar@linux.vnet.ibm.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Juri
 Lelli <juri.lelli@redhat.com>,  Vincent Guittot
 <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel
 Gorman <mgorman@suse.de>, Daniel Bristot de Oliveira <bristot@redhat.com>,
 Valentin Schneider <vschneid@redhat.com>
Date: Tue, 09 Jan 2024 16:58:27 -0800
In-Reply-To: <ea049b25-ba49-4790-8b79-05078adbfc77@linux.vnet.ibm.com>
References: <20231018155036.2314342-1-srikar@linux.vnet.ibm.com>
	 <ea049b25-ba49-4790-8b79-05078adbfc77@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-01-04 at 21:20 +0530, Shrikanth Hegde wrote:
> On 10/18/23 9:20 PM, Srikar Dronamraju wrote:
>=20
> Hi Srikar,=20
>=20
> > Current scheduler code doesn't handle SD_ASYM_PACKING in the
> > find_idlest_cpu path. On few architectures, like Powerpc, cache is at a
> > core. Moving threads across cores may end up in cache misses.
> >=20
> > While asym_packing can be enabled above SMT level, enabling Asym packin=
g
> > across cores could result in poorer performance due to cache misses.
> > However if the initial task placement via find_idlest_cpu does take
> > Asym_packing into consideration, then scheduler can avoid asym_packing
> > migrations. This will result in lesser migrations and better packing an=
d
> > better overall performance.
> >=20
>=20
> This would handle asym packing case when finding the idle CPU for newly w=
oken
> up task and thereby reducing the number of migrations if it is placed cor=
rectly in=20
> the first place. I think thats helpful.=20
>=20
> Currently intel cluster and powerVM shared LPAR's are the two where ASYM =
PACKING=20
> is enabled at higher domain than SMT. Is that correct or is there any oth=
er topology?
>=20
> +tim=20
>=20
> > Signed-off-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
> > ---
> >  kernel/sched/fair.c | 33 ++++++++++++++++++++++++++++++---
> >  1 file changed, 30 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index cb225921bbca..7164f79a3d13 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -9931,11 +9931,13 @@ static int idle_cpu_without(int cpu, struct tas=
k_struct *p)
> >   * @group: sched_group whose statistics are to be updated.
> >   * @sgs: variable to hold the statistics for this group.
> >   * @p: The task for which we look for the idlest group/CPU.
> > + * @this_cpu: current cpu
> >   */
> >  static inline void update_sg_wakeup_stats(struct sched_domain *sd,
> >  					  struct sched_group *group,
> >  					  struct sg_lb_stats *sgs,
> > -					  struct task_struct *p)
> > +					  struct task_struct *p,
> > +					  int this_cpu)
> >  {
> >  	int i, nr_running;
> > =20
> > @@ -9972,6 +9974,11 @@ static inline void update_sg_wakeup_stats(struct=
 sched_domain *sd,
> > =20
> >  	}
> > =20
> > +	if (sd->flags & SD_ASYM_PACKING && sgs->sum_h_nr_running &&
> > +			sched_asym_prefer(group->asym_prefer_cpu, this_cpu)) {
> > +		sgs->group_asym_packing =3D 1;

I disagree with the above criteria for doing asym_packing.

I think asym packing only makes sense if you have an idle CPU availabe
in the group that is preferred over this_cpu, and you have fewer
tasks than CPU.  Using group->asym_prefer_cpu
is inappropriate as that most preferred CPU may be busy.
You should be migrating task from this_cpu to that highest
priority idle_cpu identified

If the group is fully busy or overloaded, we should stick with the original
logic of picking the most lightly loaded group and not use asym_packing.=C2=
=A0

You may want to note down the idle CPU in the group with highest priority,=
=C2=A0
or most preferred if there are more than 1 cpu in the group to compare=C2=
=A0
between two idle groups that have idle CPUs.

Tim

> > +	}
> > +
>=20
>=20
> I think there is a corner case here which could be taken care. please cor=
rect me if i=20
> am wrong.=20
>=20
> Assume there are four sched groups, sg1, sg2, sg3 and sg4. asym packing i=
s enabled at sd.=20
> sg1, and sg3 have one task each and a new task is being created. So find_=
idlest_cpu is=20
> called for this new task.=20
>=20
> Because of sgs->sum_h_nr_running check, sg1 and sg3 will have group_asym_=
packing, while=20
> sg2 and sg4 will have group_has_spare. update_pick_idlest will choose the=
 lowest type.=20
> so group_has_spare. TIE would be between sg2 and sg4. Because of asym pac=
king (atleast true=20
> for powerpc shared LPAR case) sg4 will have lower utilization compared to=
 sg2, and hence sg4=20
> will be given as the idlest_cpu. On the next load balance sg2 will pull t=
ask from sg4 due to=20
> asym packing.=20
>=20
> Additional migration may be avoided if we omit the sum_h_nr_running check=
?=20
>=20
>=20
> >  	sgs->group_capacity =3D group->sgc->capacity;
> > =20
> >  	sgs->group_weight =3D group->group_weight;
> > @@ -10012,8 +10019,17 @@ static bool update_pick_idlest(struct sched_gr=
oup *idlest,
> >  			return false;
> >  		break;
> > =20
> > -	case group_imbalanced:
> >  	case group_asym_packing:
> > +		if (sched_asym_prefer(group->asym_prefer_cpu, idlest->asym_prefer_cp=
u)) {
> > +			int busy_cpus =3D idlest_sgs->group_weight - idlest_sgs->idle_cpus;
> > +
> > +			busy_cpus -=3D (sgs->group_weight - sgs->idle_cpus);
> > +			if (busy_cpus >=3D 0)
> > +				return true;
>=20
>=20
> wouldn't using idle_cpus would be simpler? something like,=20
>=20
> if (sgs->idle_cpus - idlest->idle_cpus > 0)
> 	return true
>=20
> > +		}
> > +		return false;
> > +
> > +	case group_imbalanced:
> >  	case group_smt_balance:
> >  		/* Those types are not used in the slow wakeup path */
> >  		return false;
> > @@ -10080,7 +10096,7 @@ find_idlest_group(struct sched_domain *sd, stru=
ct task_struct *p, int this_cpu)
> >  			sgs =3D &tmp_sgs;
> >  		}
> > =20
> > -		update_sg_wakeup_stats(sd, group, sgs, p);
> > +		update_sg_wakeup_stats(sd, group, sgs, p, this_cpu);
> > =20
> >  		if (!local_group && update_pick_idlest(idlest, &idlest_sgs, group, s=
gs)) {
> >  			idlest =3D group;
> > @@ -10112,6 +10128,17 @@ find_idlest_group(struct sched_domain *sd, str=
uct task_struct *p, int this_cpu)
> >  	if (local_sgs.group_type > idlest_sgs.group_type)
> >  		return idlest;
> > =20
> > +	if (idlest_sgs.group_type =3D=3D group_asym_packing) {
> > +		if (sched_asym_prefer(idlest->asym_prefer_cpu, local->asym_prefer_cp=
u)) {
> > +			int busy_cpus =3D local_sgs.group_weight - local_sgs.idle_cpus;
> > +
> > +			busy_cpus -=3D (idlest_sgs.group_weight - idlest_sgs.idle_cpus);
> > +			if (busy_cpus >=3D 0)
> > +				return idlest;
> > +		}
> > +		return NULL;
> > +	}
>=20
> same comment of using idle_cpus=20
>=20
> > +
> >  	switch (local_sgs.group_type) {
> >  	case group_overloaded:
> >  	case group_fully_busy:
>=20


