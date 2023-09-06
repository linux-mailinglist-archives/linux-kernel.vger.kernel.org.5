Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED7F1794099
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 17:42:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241224AbjIFPmz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 11:42:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241013AbjIFPmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 11:42:54 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29CB01738
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 08:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694014970; x=1725550970;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=XyzCncJzF0gXsm602APUgGdhQRN2///3BECDpIb9iyE=;
  b=l+rnSHdOLSPILGWcgle2eTTPiajDeodJupvrkV4R4W6feHjXT7mGXH1Y
   GtNStTQGyyb2puQv+Ll02hdwvgf/sfhtUynUFVlDMSEV7G4OSDtZIyJXc
   o1hYo+i+VrtCPx4HV6p+PU3rFvCNSEPCSCVAQZGO4udiPw7jESH3kVA5E
   MQS9DssUFk2IwzcdfMP8EBLHy61SOahxKIVy0KolDpkTYUq7zXGW9U7/P
   RoK0TZMUZc2lOCcgaGC3ZVd5222LnDNzTJ2dN+UggRYHrnItxvQQD1psi
   P5+RGkiBXo3ANGhQ6CY+Ot/A7ksPEvLEtQ4b0l7usO7IGqSUK4txwyOYV
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10825"; a="379811516"
X-IronPort-AV: E=Sophos;i="6.02,232,1688454000"; 
   d="scan'208";a="379811516"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2023 08:42:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10825"; a="831720784"
X-IronPort-AV: E=Sophos;i="6.02,232,1688454000"; 
   d="scan'208";a="831720784"
Received: from cmabraha-mobl1.amr.corp.intel.com (HELO [10.209.95.171]) ([10.209.95.171])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2023 08:42:45 -0700
Message-ID: <cce18bb7961861eb16f8f9829660cc59779766c3.camel@linux.intel.com>
Subject: Re: [PATCH] sched/fair: Add SMT4 group_smt_balance handling
From:   Tim Chen <tim.c.chen@linux.intel.com>
To:     Shrikanth Hegde <sshegde@linux.vnet.ibm.com>
Cc:     bristot@redhat.com, bsegall@google.com, dietmar.eggemann@arm.com,
        hdanton@sina.com, ionela.voinescu@arm.com, juri.lelli@redhat.com,
        len.brown@intel.com, linux-kernel@vger.kernel.org, mgorman@suse.de,
        naveen.n.rao@linux.vnet.ibm.com, rafael.j.wysocki@intel.com,
        ravi.v.shankar@intel.com, ricardo.neri@intel.com,
        rostedt@goodmis.org, srikar@linux.vnet.ibm.com,
        srinivas.pandruvada@linux.intel.com, v-songbaohua@oppo.com,
        vincent.guittot@linaro.org, vschneid@redhat.com, x86@kernel.org,
        yangyicong@hisilicon.com, yu.c.chen@intel.com, peterz@infradead.org
Date:   Wed, 06 Sep 2023 08:42:44 -0700
In-Reply-To: <e40f93e5-d4a2-5751-1e2f-dcc987c0eb21@linux.vnet.ibm.com>
References: <20230717133718.GJ4253@hirez.programming.kicks-ass.net>
         <20230717145823.1531759-1-sshegde@linux.vnet.ibm.com>
         <804548a12363479d41dee19bb843002d9e105afd.camel@linux.intel.com>
         <6b20e0c0cd82d0d1aafc2a7fb14d9456e19c2c85.camel@linux.intel.com>
         <4118c2e3-fd34-2ebe-3faa-1c6ac9cbbac2@linux.vnet.ibm.com>
         <61cb0511b15612f43f390c750d2e9325bd7af4dd.camel@linux.intel.com>
         <2428a381-1587-2beb-711f-3fab6d773975@linux.vnet.ibm.com>
         <dee7575cc9d3c42c9705348151a1453ff084d4f3.camel@linux.intel.com>
         <e40f93e5-d4a2-5751-1e2f-dcc987c0eb21@linux.vnet.ibm.com>
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

On Wed, 2023-09-06 at 14:59 +0530, Shrikanth Hegde wrote:
> >=20
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 6e7ee2efc1ba..48e9ab7f8a87 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -9764,16 +9764,9 @@ static bool update_sd_pick_busiest(struct lb_env=
 *env,
> > =20
> >         case group_smt_balance:
> >                 /* no idle cpus on both groups handled by group_fully_b=
usy below */
>=20
> Please add a comment here explaining the fall-through and spare logic.
>=20

Sure.


> > -               if (sgs->idle_cpus !=3D 0 || busiest->idle_cpus !=3D 0)=
 {
> > -                       if (sgs->idle_cpus > busiest->idle_cpus)
> > -                               return false;
> > -                       if (sgs->idle_cpus < busiest->idle_cpus)
> > -                               return true;
> > -                       if (sgs->sum_nr_running <=3D busiest->sum_nr_ru=
nning)
> > -                               return false;
> > -                       else
> > -                               return true;
> > -               }
> > +               if (sgs->idle_cpus !=3D 0 || busiest->idle_cpus !=3D 0)
> > +                       goto has_spare;
> > +
> >                 goto fully_busy;
>=20
> This can fall through without the additional goto statement no?
>=20

There is an unconditional goto fully_busy so won't fall through and
compiler won't complain.

> > =20
> >         case group_fully_busy:
> > @@ -9809,6 +9802,7 @@ static bool update_sd_pick_busiest(struct lb_env =
*env,
> >                  * as we do not want to pull task off SMT core with one=
 task
> >                  * and make the core idle.
> >                  */
> > +has_spare:
> >                 if (smt_vs_nonsmt_groups(sds->busiest, sg)) {
> >                         if (sg->flags & SD_SHARE_CPUCAPACITY && sgs->su=
m_h_nr_running <=3D 1)
> >                                 return false;
> >=20
> >=20
> >=20
Tim


