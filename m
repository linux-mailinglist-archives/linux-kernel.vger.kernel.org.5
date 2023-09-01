Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B5E578FD43
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 14:30:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347206AbjIAMae (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 08:30:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235335AbjIAMad (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 08:30:33 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3F5C10F8
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 05:30:23 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RccgV5ZvCz67pFc;
        Fri,  1 Sep 2023 20:25:26 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Fri, 1 Sep
 2023 13:30:20 +0100
Date:   Fri, 1 Sep 2023 13:30:19 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Amit Singh Tomar <amitsinght@marvell.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <fenghua.yu@intel.com>,
        <reinette.chatre@intel.com>, <james.morse@arm.com>,
        <gcherian@marvell.com>, <robh@kernel.org>, <peternewman@google.com>
Subject: Re: [RFC 02/12] arm_mpam: resctrl: Detect priority partitioning
 capability
Message-ID: <20230901133019.000033b2@Huawei.com>
In-Reply-To: <20230815152712.1760046-3-amitsinght@marvell.com>
References: <20230815152712.1760046-1-amitsinght@marvell.com>
        <20230815152712.1760046-3-amitsinght@marvell.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Aug 2023 20:57:02 +0530
Amit Singh Tomar <amitsinght@marvell.com> wrote:

> ARM MPAM supports different control that can be applied to different
> resources in the system, for instance priority partitioning control
> where priority value is generated from one MSC, propagates over
> interconnect to other MSC (known as downstream priority), or can be
> applied within an MSC for internal operations.

Hi Amit,

This talks about INTPRI as well as DSPRI, but only checks for DSPRI.
I couldn't work out why my INTPRI test wasn't resulting in anything
new turning up in schemata.

Should make that clear  However even better would be to enable both
and we definitely want an interface that allows for either or both.

Jonathan

> 
> This change lets the resctrl know the about MSC's priority partitioning
> capability.
> 
> Signed-off-by: Amit Singh Tomar <amitsinght@marvell.com>
> ---
>  drivers/platform/mpam/mpam_resctrl.c | 14 ++++++++++++++
>  include/linux/resctrl.h              |  4 ++++
>  2 files changed, 18 insertions(+)
> 
> diff --git a/drivers/platform/mpam/mpam_resctrl.c b/drivers/platform/mpam/mpam_resctrl.c
> index 1dbfb6f6dd34..09618d9ceb1d 100644
> --- a/drivers/platform/mpam/mpam_resctrl.c
> +++ b/drivers/platform/mpam/mpam_resctrl.c
> @@ -435,6 +435,16 @@ static bool cache_has_usable_cpor(struct mpam_class *class)
>  	return (class->props.cpbm_wd <= RESCTRL_MAX_CBM);
>  }
>  
> +static bool cache_has_usable_priority_part(struct mpam_class *class)
> +{
> +	struct mpam_props *cprops = &class->props;
> +
> +	if (!mpam_has_feature(mpam_feat_dspri_part, cprops))
> +		return false;
> +
> +	return (class->props.dspri_wd <= RESCTRL_MAX_DSPRI);
> +}
> +
>  static bool cache_has_usable_csu(struct mpam_class *class)
>  {
>  	struct mpam_props *cprops;
> @@ -691,6 +701,7 @@ static int mpam_resctrl_resource_init(struct mpam_resctrl_res *res)
>  	    res->resctrl_res.rid == RDT_RESOURCE_L3) {
>  		bool has_csu = cache_has_usable_csu(class);
>  		bool has_mbwu = class_has_usable_mbwu(class);
> +		bool has_ppart = cache_has_usable_priority_part(class);
>  
>  		/* TODO: Scaling is not yet supported */
>  		r->cache.cbm_len = class->props.cpbm_wd;
> @@ -718,6 +729,9 @@ static int mpam_resctrl_resource_init(struct mpam_resctrl_res *res)
>  			exposed_alloc_capable = true;
>  		}
>  
> +		if (has_ppart)
> +			r->priority_cap = true;
> +
>  		/*
>  		 * MBWU counters may be 'local' or 'total' depending on where
>  		 * they are in the topology. If The counter is on the L3, its
> diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
> index 3ad308e9e226..a98ba5828211 100644
> --- a/include/linux/resctrl.h
> +++ b/include/linux/resctrl.h
> @@ -38,6 +38,8 @@ int proc_resctrl_show(struct seq_file *m,
>   */
>  #define RESCTRL_MAX_CBM			32
>  
> +#define RESCTRL_MAX_DSPRI               63
> +
>  /* The format for packing fields into the u64 'id' exposed to user-space */
>  #define RESCTRL_ID_CLOSID	GENMASK_ULL(31, 0)
>  #define RESCTRL_ID_RMID		GENMASK_ULL(63, 32)
> @@ -195,6 +197,7 @@ struct resctrl_membw {
>   * @rid:		The index of the resource
>   * @alloc_capable:	Is allocation available on this machine
>   * @mon_capable:	Is monitor feature available on this machine
> + * @priority_capable:   Is priority partitioning feature available on this machine
>   * @num_rmid:		Number of RMIDs available
>   * @cache_level:	Which cache level defines scope of this resource
>   * @cache:		Cache allocation related data
> @@ -212,6 +215,7 @@ struct rdt_resource {
>  	int			rid;
>  	bool			alloc_capable;
>  	bool			mon_capable;
> +	bool                    priority_cap;
>  	int			num_rmid;
>  	int			cache_level;
>  	struct resctrl_cache	cache;

