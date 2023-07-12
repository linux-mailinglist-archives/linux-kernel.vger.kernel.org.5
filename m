Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E76E75109B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 20:36:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232565AbjGLSga (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 14:36:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbjGLSg3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 14:36:29 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3562E77
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 11:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689186987; x=1720722987;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=fvDv1aow+xj65zgsSNHkjZqO0ZIvtyAYRkgsfpJWQk8=;
  b=P2W2Z4wGnufVRGrGBcZz/SyT0CXlNcoBArUXGr5iyndhj7LNarFlCt9r
   XgR1CQND26LHh8ZZJcz7wUJbdnp/l8t5D+3bYE3tpY+R9Ikw8dQt1sX9O
   JtFzIgdHs/wcwDagYMYm62Ic25ZUmE2UrWTucNeNxPGYp4Br+WxZmoi/E
   28QzoD4jIAvfqcQp7JhauBZsBP1Is16AQw0fR9c1DA+t1mAM9M0j/9l99
   Ia99aRaj3G5zooz/w/CBfIlkVEkwBFsYWpwWyveSmEr1t9YTPpTruiF9x
   8b9kFLn8zqzN7MWtuD4kCCCZoxyaEUpHIcgtURXOy58NBDKi9MlFU84RU
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="344571121"
X-IronPort-AV: E=Sophos;i="6.01,200,1684825200"; 
   d="scan'208";a="344571121"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2023 11:36:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="845746694"
X-IronPort-AV: E=Sophos;i="6.01,200,1684825200"; 
   d="scan'208";a="845746694"
Received: from shyammoh-mobl1.amr.corp.intel.com (HELO [10.209.117.95]) ([10.209.117.95])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2023 11:36:26 -0700
Message-ID: <3fa9b9675e381dc483c4656d86253955dcb96f2e.camel@linux.intel.com>
Subject: Re: [PATCH] sched/topology: Align group flags when removing
 degenerate domain
From:   Tim Chen <tim.c.chen@linux.intel.com>
To:     Chen Yu <yu.c.chen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     Ricardo Neri <ricardo.neri@intel.com>,
        Tim Chen <tim.c.chen@intel.com>,
        Yicong Yang <yangyicong@huawei.com>,
        linux-kernel@vger.kernel.org
Date:   Wed, 12 Jul 2023 11:36:26 -0700
In-Reply-To: <20230713013133.2314153-1-yu.c.chen@intel.com>
References: <20230713013133.2314153-1-yu.c.chen@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2023-07-13 at 09:31 +0800, Chen Yu wrote:
> The flags of the child of a given scheduling domain are used to initializ=
e
> the flags of its scheduling groups. When the child of a scheduling domain
> is degenerated, the flags of its local scheduling group need to be update=
d
> to align with the flags of its new child domain.
>=20
> The flag SD_SHARE_CPUCAPACITY was aligned in
> Commit bf2dc42d6beb ("sched/topology: Propagate SMT flags when removing d=
egenerate domain").
> Further generalize this alignment so other flags can be used later, such =
as
> in cluster-based task wakeup. [1]
>=20
> Link: https://lore.kernel.org/lkml/20230530115527.GC156198@hirez.programm=
ing.kicks-ass.net #1
> Suggested-by: Ricardo Neri <ricardo.neri@intel.com>
> Reported-by: Yicong Yang <yangyicong@huawei.com>
> Closes: https://lore.kernel.org/lkml/ce714341-af58-2522-69a8-321f02c82893=
@huawei.com/
> Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> ---
>  kernel/sched/topology.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index d3a3b2646ec4..ff02d7deec0c 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -722,8 +722,7 @@ cpu_attach_domain(struct sched_domain *sd, struct roo=
t_domain *rd, int cpu)
> =20
>  			if (parent->parent) {
>  				parent->parent->child =3D tmp;
> -				if (tmp->flags & SD_SHARE_CPUCAPACITY)
> -					parent->parent->groups->flags |=3D SD_SHARE_CPUCAPACITY;
> +				parent->parent->groups->flags =3D tmp->flags;
>  			}
> =20
>  			/*

Reviewed-by: Tim Chen <tim.c.chen@linux.intel.com>
