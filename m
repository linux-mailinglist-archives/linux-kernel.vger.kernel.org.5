Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7FDB754558
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 01:23:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbjGNXXI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 19:23:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjGNXXH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 19:23:07 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AC7B198A
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 16:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689376986; x=1720912986;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=UFNjXLKITbspSo/eDpkcEH18zDiE7dmQzWrzA+9BOXk=;
  b=lkBV0mrmri4X1qLdl3vJ7Ato2IeceF3qs0dNNU5vsR8yE+5a2uLwjiuF
   gbuan7YQM/vzSL3Kvfg1AUOX4BM0B8eWFnllsbajRVQoHiqH15sQe/wwc
   zeISkkyPg3up97eHClB+kCqbAeI/BI9MeNIhxpe9AUzQnMXF9VvcJUV1T
   LuFpxrshsCfHvvQGo1yJjD9OTuHKL8GfWKIANbFeiW3b2990jVordJZT/
   BBfFBEHENctbuQcV1yz0rxmODQNIpU6zDkqVH0rTnPo07U8HJm54uFzrI
   5Viw7W/DON9pmaUf+eqXsbTre4p56Hc618daqaJuBvlfnklv+aCFTGmYl
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10771"; a="350470827"
X-IronPort-AV: E=Sophos;i="6.01,206,1684825200"; 
   d="scan'208";a="350470827"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2023 16:23:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10771"; a="1053239783"
X-IronPort-AV: E=Sophos;i="6.01,206,1684825200"; 
   d="scan'208";a="1053239783"
Received: from bmuller-mobl.amr.corp.intel.com (HELO [10.209.37.94]) ([10.209.37.94])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2023 16:23:04 -0700
Message-ID: <8333da418828569495f3b92919e6980a5dac0295.camel@linux.intel.com>
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
Date:   Fri, 14 Jul 2023 16:23:04 -0700
In-Reply-To: <f9a51b01bdddd739faedb196156e69fbad41f9f5.camel@linux.intel.com>
References: <cover.1688770494.git.tim.c.chen@linux.intel.com>
         <4eacbaa236e680687dae2958378a6173654113df.1688770494.git.tim.c.chen@linux.intel.com>
         <c5a49136-3549-badd-ec8f-3de4e7bb7b7d@linux.vnet.ibm.com>
         <f9a51b01bdddd739faedb196156e69fbad41f9f5.camel@linux.intel.com>
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

On Fri, 2023-07-14 at 13:44 -0700, Tim Chen wrote:
> > >=20
> > > +static inline long sibling_imbalance(struct lb_env *env,
> > > +				    struct sd_lb_stats *sds,
> > > +				    struct sg_lb_stats *busiest,
> > > +				    struct sg_lb_stats *local)
> > > +{
> > > +	int ncores_busiest, ncores_local;
> > > +	long imbalance;
> >=20
> > can imbalance be unsigned int or unsigned long? as sum_nr_running is un=
signed int.
>=20
> It could be made unsigned long.=20
>=20
>=20
Though in theory the imbalance can be both positive or negative. We are
considering only positive imbalance here as we only pull task to local grou=
p
and do not push task from local group.

Tim
