Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46EBB797EA1
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 00:11:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240801AbjIGWL5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 18:11:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234915AbjIGWL4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 18:11:56 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AF8B1BC9
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 15:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694124705; x=1725660705;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=tcfk84zHIXVE8x3W6MkrErooMXf3zfx0rjHmm5IqJVg=;
  b=XIKBqVVgfuhU7wc9X2t/yq0MAlS0KBhYkU9YpbOUhs1i+5xuaWJr5xmo
   TJ8/vgi3coVEt3Ea6+AyW3QpzFKP6JpZiK3cWFeXCbuIS5GDFWxx3oGmy
   Dc8+OiN060yM/FOrszWy0bqT9lqfYatSxxRtcbQNQ34jz2quROinw9m9Z
   HTgjfL8lpWBZPQe9+ubxifGBiXVoJJaG3Y5BYvo2gdcZ95g8JN3KkW248
   32KVjqUQ5xbNCortlVs1scxN1JpbkVlQaIrVLNGQOopeecYagdLNHIrhA
   lJm6vMPeCl9mDUCPdcA6qQVUPgfunKXMEZpe6Rr8ytYjjIvt9cUM5f7FZ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10826"; a="357803390"
X-IronPort-AV: E=Sophos;i="6.02,236,1688454000"; 
   d="scan'208";a="357803390"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2023 15:11:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10826"; a="857066068"
X-IronPort-AV: E=Sophos;i="6.02,236,1688454000"; 
   d="scan'208";a="857066068"
Received: from ayushgup-mobl.amr.corp.intel.com (HELO [10.209.118.125]) ([10.209.118.125])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2023 15:11:43 -0700
Message-ID: <1db04264f6ec2d0b1624f9b1f528538174fa95ee.camel@linux.intel.com>
Subject: Re: [PATCH] sched/smt: fix unbalance sched_smt_present dec/inc
From:   Tim Chen <tim.c.chen@linux.intel.com>
To:     Chen Yu <yu.c.chen@intel.com>,
        Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, tglx@linutronix.de
Date:   Thu, 07 Sep 2023 15:11:42 -0700
In-Reply-To: <ZPVATM5xfmiFKWtk@chenyu5-mobl2>
References: <20230902074609.1757507-1-yangyingliang@huawei.com>
         <ZPVATM5xfmiFKWtk@chenyu5-mobl2>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2023-09-04 at 10:26 +0800, Chen Yu wrote:
> Hi Yingliang,
>=20
> On 2023-09-02 at 15:46:09 +0800, Yang Yingliang wrote:
> > I got the following warn report while doing stress test:
> >=20
>=20
> May I know if the test is to run many deadline tasks while offline the CP=
Us,
> so as to trigger the failing case that removing one CPU gets us below the=
 total
> allocated bandwidth?
>=20
> > jump label: negative count!
> > WARNING: CPU: 3 PID: 38 at kernel/jump_label.c:263 static_key_slow_try_=
dec+0x9d/0xb0
> > Call Trace:
> >  <TASK>
> >  __static_key_slow_dec_cpuslocked+0x16/0x70
> >  sched_cpu_deactivate+0x26e/0x2a0
> >  cpuhp_invoke_callback+0x3ad/0x10d0
> >  cpuhp_thread_fun+0x3f5/0x680
> >  smpboot_thread_fn+0x56d/0x8d0
> >  kthread+0x309/0x400
> >  ret_from_fork+0x41/0x70
> >  ret_from_fork_asm+0x1b/0x30
> >  </TASK>
> >=20
> > Becaus when cpuset_cpu_inactive() fails in sched_cpu_deactivate(),
>=20
> s/Becaus/Because/
>=20
> > the cpu offline failed, but sched_smt_present is decreased before

s/decreased/decremented
to be precise

> > calling sched_cpu_deactivate, it leads unbalance dec/inc, so fix

s/leads unbalance dec/inc / leads to unbalanced dec/inc
>=20
> s/calling sched_cpu_deactivate/calling cpuset_cpu_inactive() ?
> > it by increasing sched_smt_present in the error path.

s/increasing/incrementing

> >=20
> > Fixes: c5511d03ec09 ("sched/smt: Make sched_smt_present track topology"=
)
> > Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> > ---
> >  kernel/sched/core.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >=20
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index 2299a5cfbfb9..b7ef2df36b75 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -9745,6 +9745,10 @@ int sched_cpu_deactivate(unsigned int cpu)
> >  	sched_update_numa(cpu, false);
> >  	ret =3D cpuset_cpu_inactive(cpu);
> >  	if (ret) {
> > +#ifdef CONFIG_SCHED_SMT
> > +		if (cpumask_weight(cpu_smt_mask(cpu)) =3D=3D 2)
> > +			static_branch_inc_cpuslocked(&sched_smt_present);
> > +#endif
>=20
> While checking the code, it seems that the core scheduling also missed
> the error path, maybe we should also invoke sched_core_cpu_starting() to
> restore the context. I'll have a check.
>=20
> Other than above typo, it looks good to me,
>=20
> Reviewed-by: Chen Yu <yu.c.chen@intel.com>
>=20

Other than some minor nits to commit log wording,

Reviewed-by: Tim Chen <tim.c.chen@linux.intel.com>
