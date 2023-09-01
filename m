Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B8C878FD65
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 14:39:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349501AbjIAMjM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 08:39:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349523AbjIAMjL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 08:39:11 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 589FEE7F
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 05:39:08 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Rccxx6bJxz6HJbj;
        Fri,  1 Sep 2023 20:37:57 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Fri, 1 Sep
 2023 13:39:06 +0100
Date:   Fri, 1 Sep 2023 13:39:05 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Amit Singh Tomar <amitsinght@marvell.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <fenghua.yu@intel.com>,
        <reinette.chatre@intel.com>, <james.morse@arm.com>,
        <gcherian@marvell.com>, <robh@kernel.org>, <peternewman@google.com>
Subject: Re: [RFC 01/12] arm_mpam: Handle resource instances mapped to
 different controls
Message-ID: <20230901133905.00000c14@Huawei.com>
In-Reply-To: <20230815152712.1760046-2-amitsinght@marvell.com>
References: <20230815152712.1760046-1-amitsinght@marvell.com>
        <20230815152712.1760046-2-amitsinght@marvell.com>
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

On Tue, 15 Aug 2023 20:57:01 +0530
Amit Singh Tomar <amitsinght@marvell.com> wrote:

Hi Amit,

My comments are likely to be fairly superficial, at least partly because
we haven't yet had a good opportunity for a review of James' MPAM series
on top of which this sits. (side note that I'm keen that James posts
that so we can have at it properly)

Note James has a new version of the tree out so applying this was
a little messy.

> At the moment, configuring multiple resource instances (mapped to same
> control) under a resource class is not supported. For instance, on MARVELL
> SoC MPAMF_IDR_NS[RIS_MAX] (under LLC MSC) is 0x2, and there are three
> different resource at index 0,1,2. These are enumerated in
> TAD_CMN_MPAM_RIS_E:
> 
> 0: MSC
> 1: LTG
> 2: DTG

Sometimes I think the MPAM spec is just too flexible. We are going to see
an awful lot of corner cases.

> 
> LLC MSC resource at index 1, and 2 have cache portion partitioning
> feature, i.e., If MPAMCFG_PART_SEL_NS[RIS] is set to 1 (LTG) or to 2 (DTG),
> then MPAMF_IDR_NS[HAS_CPOR_PART] is set to 1. LTG resource has 16
> portion bitmap, and DTG has 18 portion bitmap (mapped to same
> CPOR control), and only one can be configured.

This patch description seems to first describe a clash between LTG and DTG
before going on to what the patch actually changes.
Do we need that initial description or can it be simplified
to just talk about...
> 
> LLC MSC resource at index 0 has the Priority partitioning features.
> If MPAMCFG_PART_SEL_NS[RIS] is set to 0 (MSC), then MPAMF_IDR_NS[HAS_PRI_PART]
> is set to 1, leaving HAS_CPOR_PART bit to 0. CPOR and PRI_PART are
> mutually exclusive resources as far configuration is concerned.
> 
> With this change, multiple resource instances that maps to different
> control, say LTG for CPOR, and MSC for PRI_PART is handled properly.
this second part?

> 
> Signed-off-by: Amit Singh Tomar <amitsinght@marvell.com>
> ---
>  drivers/platform/mpam/mpam_devices.c | 24 +++++++++++++++++++++++-
>  1 file changed, 23 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/mpam/mpam_devices.c b/drivers/platform/mpam/mpam_devices.c
> index 589ff1ef2b6b..137cbff925ba 100644
> --- a/drivers/platform/mpam/mpam_devices.c
> +++ b/drivers/platform/mpam/mpam_devices.c
> @@ -1829,6 +1829,19 @@ static void mpam_enable_init_class_features(struct mpam_class *class)
>  	class->props = ris->props;
>  }
>  
> +/* Club different resource properties under a class that resctrl uses,
> + * for instance, L3 cache that supports both CPOR, and DSPRI need to have
> + * knowledge of both cpbm_wd and dspri_wd.

Perhaps highlight that this case only matters if the two properties
are under different RIS.  I'm fairly sure that a valid implementation would
export both CPOR and DSPRI on the same RIS.


> + */
> +static void mpam_enable_club_class_features(struct mpam_class *class,
> +					    struct mpam_msc_ris *ris)
> +{
> +	class->props.features |= ris->props.features;
> +	class->props.cpbm_wd |= ris->props.cpbm_wd;
> +	class->props.dspri_wd |= ris->props.dspri_wd;
> +	class->props.num_csu_mon |= ris->props.num_csu_mon;
> +}
> +
>  /* Merge all the common resource features into class. */
>  static void mpam_enable_merge_features(void)
>  {
> @@ -1843,7 +1856,16 @@ static void mpam_enable_merge_features(void)
>  
>  		list_for_each_entry(comp, &class->components, class_list) {
>  			list_for_each_entry(ris, &comp->ris, comp_list) {
> -				__resource_props_mismatch(ris, class);
> +				/* There can be multiple resources under a class which is
> +				 * mapped to different controls, for instance L3 cache
> +				 * can have both CPOR and DSPRI implemented, and following

implemented with different RIS

> +				 * would avoid property mismatch later on when different
> +				 * resources are present.
> +				 */
> +				if (class->props.features != ris->props.features)
> +					mpam_enable_club_class_features(class, ris);

I think the __resource_props_mismatch still needs calling.  Consider
a pair or RIS A and B
A supports CPOR only with 12 partitions.
B supports CPOR with 10 partitions and DSPRI

This will expand the set to include both CPOR and DSPRI but
fail to catch the mismatch in partitions.

I'll hack some tests on top of my QEMU code to see if this works as
I think it does.

Jonathn

> +				else
> +					__resource_props_mismatch(ris, class);
>  
>  				class->nrdy_usec = max(class->nrdy_usec,
>  						     ris->msc->nrdy_usec);

