Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93E3F754599
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 02:11:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbjGOALt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 20:11:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjGOALq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 20:11:46 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 619153A84
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 17:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689379905; x=1720915905;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=77qiGRubk75GY4oTDZJb3XK2FFdx14QYxTnO6rGu+SQ=;
  b=NQevYCMnOBZx4rnUbgQ5/3Gfg+sUGq35UzB+sb/DTTTRLaOZ83vd/qjy
   H8BdKWIxw11za1Iw1Zjdk2IOAkyMTVTjy/CmDH60gS8j9EZAE94zdAsE8
   krr3AetTVvsGx8+p6iPcLm3sgHA5E3tV8MKxlzJva9L41l0kZO6mIZxiO
   57I95j4S3j/YRJP/JgYgRKIjeuEiDRFdsyuedrfDckSvModFbTOnMblFB
   oUDcznUNzAk69PBrwKfSFD0pmZfjE7KRPwBSSOrurSCzQuoyP6CF4pCzj
   5e3eCRzoacLV8s9mD1Xntm7s74nedsGc9rEd1dLMhQKBBVjmv+obBCd21
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10771"; a="365647631"
X-IronPort-AV: E=Sophos;i="6.01,206,1684825200"; 
   d="scan'208";a="365647631"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2023 17:11:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10771"; a="672868380"
X-IronPort-AV: E=Sophos;i="6.01,206,1684825200"; 
   d="scan'208";a="672868380"
Received: from bmuller-mobl.amr.corp.intel.com (HELO [10.209.37.94]) ([10.209.37.94])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2023 17:11:43 -0700
Message-ID: <04c369a9087353270a17ab474dd6ba88cf3a3df9.camel@linux.intel.com>
Subject: Re: [Patch v3 3/6] sched/fair: Implement prefer sibling imbalance
 calculation between asymmetric groups
From:   Tim Chen <tim.c.chen@linux.intel.com>
To:     Shrikanth Hegde <sshegde@linux.vnet.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Juri Lelli <juri.lelli@redhat.com>,
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
        Chen Yu <yu.c.chen@intel.com>, Hillf Danton <hdanton@sina.com>,
        Tobias Huschle <huschle@linux.ibm.com>
Date:   Fri, 14 Jul 2023 17:11:42 -0700
In-Reply-To: <c5a49136-3549-badd-ec8f-3de4e7bb7b7d@linux.vnet.ibm.com>
References: <cover.1688770494.git.tim.c.chen@linux.intel.com>
         <4eacbaa236e680687dae2958378a6173654113df.1688770494.git.tim.c.chen@linux.intel.com>
         <c5a49136-3549-badd-ec8f-3de4e7bb7b7d@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2023-07-14 at 18:44 +0530, Shrikanth Hegde wrote:
>=20
> > +	/* Take advantage of resource in an empty sched group */
> > +	if (imbalance =3D=3D 0 && local->sum_nr_running =3D=3D 0 &&
> > +	    busiest->sum_nr_running > 1)
> > +		imbalance =3D 2;
> > +
>=20
> I don't see how this case would be true. When there are unequal number of=
 cores and local->sum_nr_ruuning=20
> is 0, and busiest->sum_nr_running is atleast 2, imbalance will be atleast=
 1.=20

I think you are correct.  With at least 2 task in the busiest group,
imbalance will be at least 1.  This is the effect of doing rounding
when adding the (ncores_local + ncores_busy) rounding factor. =20

Returning an imbalance value of 1 will not be correct as we
will be dividing imbalance by 2 and we will still not move task
to the empty group as intended.=20

So this code should be updated as below:


diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 3fc8d3a3bd22..16bf75e6a775 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9400,7 +9400,7 @@ static inline long sibling_imbalance(struct lb_env *e=
nv,
        imbalance /=3D ncores_local + ncores_busiest;
=20
        /* Take advantage of resource in an empty sched group */
-       if (imbalance =3D=3D 0 && local->sum_nr_running =3D=3D 0 &&
+       if (imbalance <=3D 1 && local->sum_nr_running =3D=3D 0 &&
            busiest->sum_nr_running > 1)
                imbalance =3D 2;
=20

Tim


