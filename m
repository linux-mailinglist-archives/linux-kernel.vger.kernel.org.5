Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0659A78FE34
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 15:17:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349710AbjIANRj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 09:17:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233600AbjIANRj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 09:17:39 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 451ED10E7
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 06:17:35 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Rcdjy2yvdz6K627;
        Fri,  1 Sep 2023 21:12:38 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Fri, 1 Sep
 2023 14:17:32 +0100
Date:   Fri, 1 Sep 2023 14:17:31 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Amit Singh Tomar <amitsinght@marvell.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <fenghua.yu@intel.com>,
        <reinette.chatre@intel.com>, <james.morse@arm.com>,
        <gcherian@marvell.com>, <robh@kernel.org>, <peternewman@google.com>
Subject: Re: [RFC 12/12] arm_mpam: Program Downstream priority value
Message-ID: <20230901141731.00006f46@Huawei.com>
In-Reply-To: <20230815152712.1760046-13-amitsinght@marvell.com>
References: <20230815152712.1760046-1-amitsinght@marvell.com>
        <20230815152712.1760046-13-amitsinght@marvell.com>
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

On Tue, 15 Aug 2023 20:57:12 +0530
Amit Singh Tomar <amitsinght@marvell.com> wrote:

> Now that Downstream priorities values can be passed from resource control
> schemata file, let's program it into memory mapped Priority Partition
> Configuration Register.
> 
> Signed-off-by: Amit Singh Tomar <amitsinght@marvell.com>
> ---
> TODO:
> 	* Invert Priority value based on DSPRI_0_IS_LOW, suggested
>           by James. 

Ah. In testing I just hit this as well as I was expecting the default
to change depending on 0_IS_LOW.



> ---
>  drivers/platform/mpam/mpam_devices.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/platform/mpam/mpam_devices.c b/drivers/platform/mpam/mpam_devices.c
> index 59022e42920c..8af6424bb27b 100644
> --- a/drivers/platform/mpam/mpam_devices.c
> +++ b/drivers/platform/mpam/mpam_devices.c
> @@ -1153,8 +1153,12 @@ static void mpam_reprogram_ris_partid(struct mpam_msc_ris *ris, u16 partid,
>  
>  		if (mpam_has_feature(mpam_feat_intpri_part, rprops))
>  			pri_val |= FIELD_PREP(MPAMCFG_PRI_INTPRI, intpri);
> -		if (mpam_has_feature(mpam_feat_dspri_part, rprops))
> -			pri_val |= FIELD_PREP(MPAMCFG_PRI_DSPRI, dspri);
> +		if (mpam_has_feature(mpam_feat_dspri_part, rprops)) {
> +			if (mpam_has_feature(mpam_feat_dspri_part, cfg)) {
> +				pri_val |= FIELD_PREP(MPAMCFG_PRI_DSPRI, cfg->dspri & dspri);

Note that it's not as simple as inverting the value for DSPRI_0_IS_LOW setting being the opposite
as in that case dspri is st to 0 a few lines up... So this always ends up 0.

> +			} else
> +				pri_val |= FIELD_PREP(MPAMCFG_PRI_DSPRI, dspri);
> +		}
>  
>  		mpam_write_partsel_reg(msc, PRI, pri_val);
>  	}

