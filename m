Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDAD0793162
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 23:53:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234813AbjIEVx4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 17:53:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231794AbjIEVxz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 17:53:55 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81616CDC
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 14:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693950802; x=1725486802;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=yfFD5NiYt3S8WapLQkaV3NbZYyR3M0QTiRq/+bnxcus=;
  b=h4O0ddW3AUn/HxZqA+VM5tfUboXNKkInYyUOwqcakO1uJiK1V15oHeBu
   DTO6azyw2B2u3IeDxuZpRmRcyEAPD6MTVC+1D54+GDksOq9BP+sJhh2Os
   DWZMpEtv9SdveWDI7ODqRf1zU9Rk7mVhCAfx6HcZCvse3WEY90eKbxpsB
   IDbrBYuT45ZtoQEJqZkfuhgZ4/JSVwX/6QxPy6aUTny2vHgLKkkzSKsiJ
   h61IZ80hnqOraBbdamp3weQ4nLXnfmni+ooBqB1x0rrfpQV1JQvdEXhxV
   bGd9iOrZV8n7i42CUEiiZ/noxFKj5SzJNXywdo+uAbxDzaTLZgEbKhzIE
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="407909208"
X-IronPort-AV: E=Sophos;i="6.02,230,1688454000"; 
   d="scan'208";a="407909208"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2023 14:53:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="811412210"
X-IronPort-AV: E=Sophos;i="6.02,230,1688454000"; 
   d="scan'208";a="811412210"
Received: from dpdesmon-mobl.amr.corp.intel.com (HELO [10.209.18.208]) ([10.209.18.208])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2023 14:53:21 -0700
Message-ID: <9b23259e62826ee8be14c6fe5dcb4bfad40d4bee.camel@linux.intel.com>
Subject: Re: [PATCH v2] sched/topology: remove sysctl_sched_energy_aware
 depending on the architecture
From:   Tim Chen <tim.c.chen@linux.intel.com>
To:     Pierre Gondois <pierre.gondois@arm.com>,
        Shrikanth Hegde <sshegde@linux.vnet.ibm.com>
Cc:     dietmar.eggemann@arm.com, vincent.guittot@linaro.org,
        peterz@infradead.org, mingo@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, ionela.voinescu@arm.com,
        quentin.perret@arm.com, srikar@linux.vnet.ibm.com,
        mgorman@techsingularity.net, mingo@kernel.org, yu.c.chen@intel.com
Date:   Tue, 05 Sep 2023 14:53:20 -0700
In-Reply-To: <b81e3d8f-88e3-e7b5-0dbc-78268193db7e@arm.com>
References: <20230901065249.137242-1-sshegde@linux.vnet.ibm.com>
         <b81e3d8f-88e3-e7b5-0dbc-78268193db7e@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-09-05 at 16:03 +0200, Pierre Gondois wrote:
> Hello Shrikanth,
> I tried the patch (on a platform using the cppc_cpufreq driver). The plat=
form
> normally has EAS enabled, but the patch removed the sched_energy_aware sy=
sctl.
> It seemed the following happened (in the below order):
>=20
> 1. sched_energy_aware_sysctl_init()
> Doesn't set sysctl_sched_energy_aware as cpufreq_freq_invariance isn't se=
t
> and arch_scale_freq_invariant() returns false
>=20
> 2. cpufreq_register_driver()
> Sets cpufreq_freq_invariance during cpufreq initialization sched_energy_s=
et()
>=20
> 3. sched_energy_set()
> Is called with has_eas=3D0 since build_perf_domains() doesn't see the pla=
tform
> as EAS compatible. Indeed sysctl_sched_energy_aware=3D0.
> So with sysctl_sched_energy_aware=3D0 and has_eas=3D0, sched_energy_aware=
 sysctl
> is not enabled even though EAS should be possible.
>=20
>=20
> On 9/1/23 08:52, Shrikanth Hegde wrote:
> > Currently sysctl_sched_energy_aware doesn't alter the said behaviour on
> > some of the architectures. IIUC its meant to either force rebuild the
> > perf domains or cleanup the perf domains by echoing 1 or 0 respectively=
.
>=20
> There is a definition of the sysctl at:
> Documentation/admin-guide/sysctl/kernel.rst::sched_energy_aware
>=20
> Also a personal comment about the commit message (FWIW), I think it shoul=
d
> be a bit more impersonal and factual. The commit message seems to describ=
e
> the code rather than the desired behaviour.

I also wonder if Shrikanth's description of the operations can be simplifie=
d.

In my mind, There are 3 variables describing the system:

1. sched_energy_capable : whether system is EAS capable
2. sched_energy_aware   : whether the admin wants to enables EAS
3. sched_energy_status  : sched_energy_capable && sched_energy_aware

Whenever there is a change in sched_energy_status, then we should trigger a=
 rebuild
of the sched domain.  We should expose sched_energy_capable
to user rather than removing sched_energy_aware when sched_energy_capable =
=3D=3D 0.

If the user know the value of sched_energy_capable, the user will know
if setting sched_energy_aware will change the system's sched_energy_status.

For system that can never support EAS,
we should simply make sched_energy_aware to be 0 and disallow it from getti=
ng written.

On systems that allow sched_energy_capable to be enabled (e.g. by brining s=
mt on/offline),
we should allow setting sched_energy_aware even when sched_energy_capable i=
s 0.
Once sched_energy_capable becomes 1, EAS is enabled.


Tim=20
 =20
>=20
> >=20
> > perf domains are not built when there is SMT, or when there is no
> > Asymmetric CPU topologies or when there is no frequency invariance.
> > Since such cases EAS is not set and perf domains are not built. By
> > changing the values of sysctl_sched_energy_aware, its not possible to
> > force build the perf domains. Hence remove this sysctl on such platform=
s
> > that dont support it. Some of the settings can be changed later
> > such as smt_active by offlining the CPU's, In those cases if
> > build_perf_domains returns true, re-enable the sysctl.
> >=20
> > Anytime, when sysctl_sched_energy_aware is changed sched_energy_update
> > is set when building the perf domains. Making use of that to find out i=
f
> > the change is happening by sysctl or dynamic system change.
> >=20
> > Taking different cases:
> > Case1. system while booting has EAS capability, sysctl will be set 1. H=
ence
> > perf domains will be built if needed. On changing the sysctl to 0, sinc=
e
> > sched_energy_update is true, perf domains would be freed and sysctl wil=
l
> > not be removed. later sysctl is changed to 1, enabling the perf domains
> > rebuild again. Since sysctl is already there, it will skip register.
> >=20
> > Case2. System while booting doesn't have EAS Capability. Later after sy=
stem
> > change it becomes capable of EAS. sched_energy_update is false. Though
> > sysctl is 0, will go ahead and try to enable eas. This is the current
> > behaviour. if has_eas  is true, then sysctl will be registered. After
> > that any sysctl change is same as Case1.
> >=20
> > Case3. System becomes not capable of EAS due to system change. Here sin=
ce
> > sched_energy_update is false, build_perf_domains return has_eas as fals=
e
> > due to one of the checks and Since this is dynamic change remove the sy=
sctl.
> > Any further change which enables EAS is Case2
> >=20
> > Note: This hasn't been tested on platform which supports EAS. If the
> > change can be verified on that it would really help. This has been
> > tested on power10 which doesn't support EAS. sysctl_sched_energy_aware
> > is removed with patch.
> >=20
> > changes since v1:
> > Chen Yu had pointed out that this will not destroy the perf domains on
> > architectures where EAS is supported by changing the sysctl. This patch
> > addresses that.
> > [v1] Link: https://lore.kernel.org/lkml/20230829065040.920629-1-sshegde=
@linux.vnet.ibm.com/#t
> >=20
> > Signed-off-by: Shrikanth Hegde <sshegde@linux.vnet.ibm.com>
> > ---
> >   kernel/sched/topology.c | 45 +++++++++++++++++++++++++++++++++-------=
-
> >   1 file changed, 37 insertions(+), 8 deletions(-)
> >=20
> > diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> > index 05a5bc678c08..4d16269ac21a 100644
> > --- a/kernel/sched/topology.c
> > +++ b/kernel/sched/topology.c
> > @@ -208,7 +208,8 @@ sd_parent_degenerate(struct sched_domain *sd, struc=
t sched_domain *parent)
> >=20
> >   #if defined(CONFIG_ENERGY_MODEL) && defined(CONFIG_CPU_FREQ_GOV_SCHED=
UTIL)
> >   DEFINE_STATIC_KEY_FALSE(sched_energy_present);
> > -static unsigned int sysctl_sched_energy_aware =3D 1;
> > +static unsigned int sysctl_sched_energy_aware;
> > +static struct ctl_table_header *sysctl_eas_header;
>=20
> The variables around the presence/absence of EAS are:
> - sched_energy_present:
> EAS is up and running
>=20
> - sysctl_sched_energy_aware:
> The user wants to use EAS (or not). Doesn't mean EAS can run on the
> platform.
>=20
> - sched_energy_set/partition_sched_domains_locked's "has_eas":
> Local variable. Represent whether EAS can run on the platform.
>=20
> IMO it would be simpler to (un)register sched_energy_aware sysctl
> in partition_sched_domains_locked(), based on the value of "has_eas".
> This would allow to let all the logic as it is right now, inside
> build_perf_domains(), and then advertise sched_energy_aware sysctl
> if EAS can run on the platform.
> sched_energy_aware_sysctl_init() would be deleted then.
>=20
>=20
> >   static DEFINE_MUTEX(sched_energy_mutex);
> >   static bool sched_energy_update;
> >=20
> > @@ -226,6 +227,7 @@ static int sched_energy_aware_handler(struct ctl_ta=
ble *table, int write,
> >   		void *buffer, size_t *lenp, loff_t *ppos)
> >   {
> >   	int ret, state;
> > +	int prev_val =3D sysctl_sched_energy_aware;
> >=20
> >   	if (write && !capable(CAP_SYS_ADMIN))
> >   		return -EPERM;
> > @@ -233,8 +235,11 @@ static int sched_energy_aware_handler(struct ctl_t=
able *table, int write,
> >   	ret =3D proc_dointvec_minmax(table, write, buffer, lenp, ppos);
> >   	if (!ret && write) {
> >   		state =3D static_branch_unlikely(&sched_energy_present);
> > -		if (state !=3D sysctl_sched_energy_aware)
> > +		if (state !=3D sysctl_sched_energy_aware && prev_val !=3D sysctl_sch=
ed_energy_aware) {
> > +			if (sysctl_sched_energy_aware && !state)
> > +				pr_warn("Attempt to build energy domains when EAS is disabled\n");
> >   			rebuild_sched_domains_energy();
> > +		}
> >   	}
> >=20
> >   	return ret;
> > @@ -255,7 +260,14 @@ static struct ctl_table sched_energy_aware_sysctls=
[] =3D {
> >=20
> >   static int __init sched_energy_aware_sysctl_init(void)
> >   {
> > -	register_sysctl_init("kernel", sched_energy_aware_sysctls);
> > +	int cpu =3D cpumask_first(cpu_active_mask);
> > +
> > +	if (sched_smt_active() || !per_cpu(sd_asym_cpucapacity, cpu) ||
> > +	    !arch_scale_freq_invariant())
> > +		return 0;
> > +
> > +	sysctl_eas_header =3D register_sysctl("kernel", sched_energy_aware_sy=
sctls);
> > +	sysctl_sched_energy_aware =3D 1;
> >   	return 0;
> >   }
> >=20
> > @@ -336,10 +348,28 @@ static void sched_energy_set(bool has_eas)
> >   		if (sched_debug())
> >   			pr_info("%s: stopping EAS\n", __func__);
> >   		static_branch_disable_cpuslocked(&sched_energy_present);
> > +#ifdef CONFIG_PROC_SYSCTL
> > +		/*
> > +		 * if the architecture supports EAS and forcefully
> > +		 * perf domains are destroyed, there should be a sysctl
> > +		 * to enable it later. If this was due to dynamic system
> > +		 * change such as SMT<->NON_SMT then remove sysctl.
> > +		 */
> > +		if (sysctl_eas_header && !sched_energy_update) {
> > +			unregister_sysctl_table(sysctl_eas_header);
> > +			sysctl_eas_header =3D NULL;
> > +		}
> > +#endif
> > +		sysctl_sched_energy_aware =3D 0;
> >   	} else if (has_eas && !static_branch_unlikely(&sched_energy_present)=
) {
> >   		if (sched_debug())
> >   			pr_info("%s: starting EAS\n", __func__);
> >   		static_branch_enable_cpuslocked(&sched_energy_present);
> > +#ifdef CONFIG_PROC_SYSCTL
> > +		if (!sysctl_eas_header)
> > +			sysctl_eas_header =3D register_sysctl("kernel", sched_energy_aware_=
sysctls);
> > +#endif
> > +		sysctl_sched_energy_aware =3D 1;
> >   	}
> >   }
> >=20
> > @@ -380,15 +410,14 @@ static bool build_perf_domains(const struct cpuma=
sk *cpu_map)
> >   	struct cpufreq_policy *policy;
> >   	struct cpufreq_governor *gov;
> >=20
> > -	if (!sysctl_sched_energy_aware)
> > +	if (!sysctl_sched_energy_aware && sched_energy_update)
> >   		goto free;
> >=20
> >   	/* EAS is enabled for asymmetric CPU capacity topologies. */
> >   	if (!per_cpu(sd_asym_cpucapacity, cpu)) {
> > -		if (sched_debug()) {
> > -			pr_info("rd %*pbl: CPUs do not have asymmetric capacities\n",
> > -					cpumask_pr_args(cpu_map));
> > -		}
> > +		if (sched_debug())
> > +			pr_info("rd %*pbl: Disabling EAS,  CPUs do not have asymmetric capa=
cities\n",
> > +				cpumask_pr_args(cpu_map));
> >   		goto free;
> >   	}
> >=20
> > --
> > 2.31.1
> >=20
> >=20
>=20
> Regards,
> Pierre

