Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2926478FE50
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 15:32:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349748AbjIANcm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 09:32:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232143AbjIANcl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 09:32:41 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB3F8CDD
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 06:32:36 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Rcf3v6z4Mz6J7tR;
        Fri,  1 Sep 2023 21:28:11 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Fri, 1 Sep
 2023 14:32:34 +0100
Date:   Fri, 1 Sep 2023 14:32:33 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Amit Singh Tomar <amitsinght@marvell.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <fenghua.yu@intel.com>,
        <reinette.chatre@intel.com>, <james.morse@arm.com>,
        <gcherian@marvell.com>, <robh@kernel.org>, <peternewman@google.com>
Subject: Re: [RFC 11/12] arm_mpam: Fix Downstream priority mask
Message-ID: <20230901143233.0000480e@Huawei.com>
In-Reply-To: <20230815152712.1760046-12-amitsinght@marvell.com>
References: <20230815152712.1760046-1-amitsinght@marvell.com>
        <20230815152712.1760046-12-amitsinght@marvell.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
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

On Tue, 15 Aug 2023 20:57:11 +0530
Amit Singh Tomar <amitsinght@marvell.com> wrote:

> MPAMF_PRI_IDR_NS[DSPRI_WD] determines the number of implemented bits in
> the downstream priority field (MPAMCFG_PRI_NS). For instance, if the value
> of DSPRI_WD is 4, then the maximum value for dspri is 0xf, and mask should
> be GENMASK(3,0).
> 
> But with current implementation, it turned out to be GENMASK(4,0) .i.e.
> 0x1f instead of 0xf.
> 
> u16 dspri = GENMASK(rprops->dspri_wd, 0);
> 
> Let's fix it, by subtracting 1 from DSPRI_WD value.
> 
> Signed-off-by: Amit Singh Tomar <amitsinght@marvell.com>

> ---
>  drivers/platform/mpam/mpam_devices.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/mpam/mpam_devices.c b/drivers/platform/mpam/mpam_devices.c
> index c0c83c04c77c..59022e42920c 100644
> --- a/drivers/platform/mpam/mpam_devices.c
> +++ b/drivers/platform/mpam/mpam_devices.c
> @@ -1099,7 +1099,7 @@ static void mpam_reprogram_ris_partid(struct mpam_msc_ris *ris, u16 partid,
>  	struct mpam_msc *msc = ris->msc;
>  	u16 bwa_fract = MPAMCFG_MBW_MAX_MAX;
>  	struct mpam_props *rprops = &ris->props;
> -	u16 dspri = GENMASK(rprops->dspri_wd, 0);
> +	u16 dspri = GENMASK((rprops->dspri_wd-1), 0);

Spaces around the -

>  	u16 intpri = GENMASK(rprops->intpri_wd, 0);

Please fix intpri as well. Argument is the same.

I'm assuming / hoping James will squash this into relevant patch in his tree.

>  
>  	lockdep_assert_held(&msc->lock);

