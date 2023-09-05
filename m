Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5A3C792FF3
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 22:28:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243586AbjIEU2a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 16:28:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231160AbjIEU23 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 16:28:29 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8A7ECE
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 13:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693945702; x=1725481702;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=Oogv3CjRLDISN2mcTds0oTAW/8ruMFSkmRGlCbXvbRQ=;
  b=fzqxNAacNkKFWISa3lZS/V6Wm9yfz3oxslqPLyhZFf4Il7TKLd/zUKEZ
   7liFbPfFYAi/q/GyLFYejIK9GsdkC/AYK4lWMt9+mQZ6/+XuiVvJATfhy
   F6DKVoIEsODlZTYQg6RUk7tB9FlqJRFncmo/h5NUUdVsnsB3dC+in/7fO
   OXm1OmxsL+KAQdNN+c7yvoqSEBy7nrw2J/ART6W68sgps6MhufuyE6BNx
   J0sK91KeIKClO2lguMQXe8+Zq1uSjw1Eoa8ClCsAcC3b/QuvfCtmiseK3
   eOTibwHdu+0YG3jEiWnga0SyqmBQZITgS+6Wvxq3aU+ORMm7hwwV/E7sn
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="367116081"
X-IronPort-AV: E=Sophos;i="6.02,230,1688454000"; 
   d="scan'208";a="367116081"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2023 13:28:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="734791421"
X-IronPort-AV: E=Sophos;i="6.02,230,1688454000"; 
   d="scan'208";a="734791421"
Received: from dpdesmon-mobl.amr.corp.intel.com (HELO [10.209.18.208]) ([10.209.18.208])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2023 13:28:21 -0700
Message-ID: <cfc3de8fa3172cedf406ccef8c94ef4da0a00281.camel@linux.intel.com>
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
Date:   Tue, 05 Sep 2023 13:28:21 -0700
In-Reply-To: <20230905171105.1005672-2-mathieu.desnoyers@efficios.com>
References: <20230905171105.1005672-1-mathieu.desnoyers@efficios.com>
         <20230905171105.1005672-2-mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-09-05 at 13:11 -0400, Mathieu Desnoyers wrote:
> Rate limit migrations to 1 migration per 2 milliseconds per task. On a
> kernel with EEVDF scheduler (commit b97d64c722598ffed42ece814a2cb791336c6=
679),
> this speeds up hackbench from 62s to 45s on AMD EPYC 192-core (over 2 soc=
kets).
>=20
>=20
>=20
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 479db611f46e..0d294fce261d 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -4510,6 +4510,7 @@ static void __sched_fork(unsigned long clone_flags,=
 struct task_struct *p)
>  	p->se.vruntime			=3D 0;
>  	p->se.vlag			=3D 0;
>  	p->se.slice			=3D sysctl_sched_base_slice;
> +	p->se.next_migration_time	=3D 0;

It seems like the next_migration_time should be initialized to the current =
time,
in case the system run for a long time and clock wrap around could cause pr=
oblem.

>  	INIT_LIST_HEAD(&p->se.group_node);
> =20
>  #ifdef CONFIG_FAIR_GROUP_SCHED
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index d92da2d78774..24ac69913005 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -960,6 +960,14 @@ int sched_update_scaling(void)
> =20
>  static void clear_buddies(struct cfs_rq *cfs_rq, struct sched_entity *se=
);
> =20
> +static bool should_migrate_task(struct task_struct *p, int prev_cpu)
> +{
> +	/* Rate limit task migration. */
> +	if (sched_clock_cpu(prev_cpu) < p->se.next_migration_time)

Should we use time_before(sched_clock_cpu(prev_cpu), p->se.next_migration_t=
ime) ?

> +	       return false;
> +	return true;
> +}
> +

Thanks.

Tim
