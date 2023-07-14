Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABA9C7544DE
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 00:16:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbjGNWQZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 18:16:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjGNWQW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 18:16:22 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08CFA271E
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 15:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689372981; x=1720908981;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=GtF3KqbmiuznAQw7i6mlD0JBL433S/IryUTjVz3mHKY=;
  b=WBSCp3e+FalKUxTLZPKEvYk49qaVGsOghzoqWDWWMBi4m8YsljjpRUSP
   Yx8BM3kyscfhVzsENHyqfAlokHTkA/S1EmlKLFti5XfDFfLqGgkV+6hZX
   Q7hQHg97NZXEaa6lxsiylgcIo3ut6MdQuEhgIPSO6tn63V/zq2oZ1En0h
   aqUB0kOGT9H9ef3LiF+7bMrHM+VHlhmgxZqvamYY2H9+KlFWvgVLSJRYX
   7f0oXjTWSENA7scPc8C+NXM13lArKs3IuX0QiiIosB2+3YfYGkFWcCH14
   /1t6E9VYRa6c4K7oDdOSGP9znYB4FrAY8xzG9LL4xP0A8J3yEopW888hW
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10771"; a="355527427"
X-IronPort-AV: E=Sophos;i="6.01,206,1684825200"; 
   d="scan'208";a="355527427"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2023 15:16:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10771"; a="787973268"
X-IronPort-AV: E=Sophos;i="6.01,206,1684825200"; 
   d="scan'208";a="787973268"
Received: from bmuller-mobl.amr.corp.intel.com (HELO [10.209.37.94]) ([10.209.37.94])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2023 15:16:19 -0700
Message-ID: <5dbc278117107bcc4047dc55f783dad397da1704.camel@linux.intel.com>
Subject: Re: [Patch v3 4/6] sched/fair: Consider the idle state of the whole
 core for load balance
From:   Tim Chen <tim.c.chen@linux.intel.com>
To:     Shrikanth Hegde <sshegde@linux.vnet.ibm.com>
Cc:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
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
        Chen Yu <yu.c.chen@intel.com>, Hillf Danton <hdanton@sina.com>,
        Peter Zijlstra <peterz@infradead.org>
Date:   Fri, 14 Jul 2023 15:16:18 -0700
In-Reply-To: <29f8bc23-9b17-0a21-baa5-3eee1322f8f0@linux.vnet.ibm.com>
References: <cover.1688770494.git.tim.c.chen@linux.intel.com>
         <807bdd05331378ea3bf5956bda87ded1036ba769.1688770494.git.tim.c.chen@linux.intel.com>
         <29f8bc23-9b17-0a21-baa5-3eee1322f8f0@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2023-07-14 at 18:32 +0530, Shrikanth Hegde wrote:
>=20
>=20
>=20
> Tried on a symmetric system with all cores having SMT=3D4 as well. There =
was reduction in migrations here as well.
> Didnt observe any major regressions when microbenchmarks run alone. Such =
as hackbench, stress-ng.=20
>=20
> So. Here is tested-by.=20
> Tested-by: Shrikanth Hegde <sshegde@linux.vnet.ibm.com>

Thanks for testing. =20

>=20
>=20
> > +
> >  	/* Are we the first CPU of this group ? */
> >  	return group_balance_cpu(sg) =3D=3D env->dst_cpu;
> >  }
>=20
> One doubt though, Here a fully idle core would be chosen instead of first=
 idle cpu in the=20
> group (if there is one). Since coming out of idle of SMT is faster compar=
ed to a fully idle core,
> would latency increase? Or that concerns mainly wakeup path?

Yeah, I think that concern is for the wakeup path and not for the balance p=
ath.

Tim
