Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFFED754AAA
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 20:26:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230183AbjGOS0H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jul 2023 14:26:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjGOS0F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jul 2023 14:26:05 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8B4630E2
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jul 2023 11:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689445560; x=1720981560;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=TiANDhvFKHNYarBo0f5b7OHT2MfFmM6d6+cbcqZYhXU=;
  b=CYrmDcb/Wi6HHq3kYBYVieYOZobSCBUF+YV8OplWNxsCI408Wy56qXWW
   ib3yameH8kQjMmeAewFtXyeQcSrpBXGAM78uVcvCxGnpfQ6I0TCAHaE77
   3EzOmRnCLAXDWKU3U+p8h6fPF7I+TU3aYI2FuOdAPT20q/3qOgvdnqJQs
   sH5xvaG+lQR1FHihZFjRQ1eBNPgDL/0sdCCAAgmp4cpLhPjVZAGKha9KZ
   qOL67kkw1aaWFbWdVekidElr77hN2QqyOKm/Mu3yFE3kdLzHFD9jySST0
   24uqo6aV6Ptl9iLTSrY7bJKIVUV/IIyDZcyE8QbmUw3EZ2u2gd1+sIi39
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10772"; a="363148382"
X-IronPort-AV: E=Sophos;i="6.01,208,1684825200"; 
   d="scan'208";a="363148382"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2023 11:26:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10772"; a="812791063"
X-IronPort-AV: E=Sophos;i="6.01,208,1684825200"; 
   d="scan'208";a="812791063"
Received: from nsbhole-mobl1.amr.corp.intel.com (HELO [10.251.11.90]) ([10.251.11.90])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2023 11:25:59 -0700
Message-ID: <ec2fdae5f574e407308ba7746fe18a69542b7c1d.camel@linux.intel.com>
Subject: Re: [Patch v3 1/6] sched/fair: Determine active load balance for
 SMT sched groups
From:   Tim Chen <tim.c.chen@linux.intel.com>
To:     Shrikanth Hegde <sshegde@linux.vnet.ibm.com>
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
        Peter Zijlstra <peterz@infradead.org>
Date:   Sat, 15 Jul 2023 11:25:58 -0700
In-Reply-To: <a399af19aa8e1291558724509a1de2f52b3bad0a.camel@linux.intel.com>
References: <cover.1688770494.git.tim.c.chen@linux.intel.com>
         <e24f35d142308790f69be65930b82794ef6658a2.1688770494.git.tim.c.chen@linux.intel.com>
         <165778ce-7b8f-1966-af02-90ef481455b9@linux.vnet.ibm.com>
         <a399af19aa8e1291558724509a1de2f52b3bad0a.camel@linux.intel.com>
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


>=20
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 294a662c9410..3fc8d3a3bd22 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -9588,6 +9588,17 @@ static bool update_sd_pick_busiest(struct lb_env *=
env,
>                 break;
> =20
>         case group_smt_balance:
> +               /* no idle cpus on both groups handled by group_fully_bus=
y below */
> +               if (sgs->idle_cpus !=3D 0 || busiest->idle_cpus !=3D 0) {
> +                       if (sgs->idle_cpus > busiest->idle_cpus)
> +                               return false;
> +                       if (sgs->idle_cpus < busiest->idle_cpus)
> +                               return true;
> +                       if (sgs->sum_nr_running <=3D busiest_sum_nr_runni=
ng)

typo: should be busiest->sum->nr_running

> +                               return false;
> +                       else
> +                               return true;
> +               }
>=20

Tim
