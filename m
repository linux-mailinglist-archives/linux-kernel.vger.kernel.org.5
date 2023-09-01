Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1950478FB9A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 12:11:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345815AbjIAKLZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 06:11:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231719AbjIAKLY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 06:11:24 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B82B31B2
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 03:11:20 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RcYb42GCnz6FGVs;
        Fri,  1 Sep 2023 18:06:24 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Fri, 1 Sep
 2023 11:11:17 +0100
Date:   Fri, 1 Sep 2023 11:11:16 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Jijie Shao <shaojijie@huawei.com>
CC:     <will@kernel.org>, <mark.rutland@arm.com>,
        <yangyicong@hisilicon.com>, <chenhao418@huawei.com>,
        <shenjian15@huawei.com>, <wangjie125@huawei.com>,
        <liuyonglong@huawei.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH V2 drivers/perf: hisi:] drivers/perf: hisi: fix set
 wrong filter mode for running events issue
Message-ID: <20230901111116.00006468@Huawei.com>
In-Reply-To: <20230901035027.3881389-1-shaojijie@huawei.com>
References: <20230901035027.3881389-1-shaojijie@huawei.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
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

On Fri, 1 Sep 2023 11:50:27 +0800
Jijie Shao <shaojijie@huawei.com> wrote:

> From: Hao Chen <chenhao418@huawei.com>

Mention which hisi pmu this is in the patch description (hns)

> 
> hns3_pmu_select_filter_mode() includes A series of mode judgments such

includes a series

> as global mode ,function mode, function-queue mode, port mode, port-tc
> mode.
> 
> For a special scenario:
> command use parameter
> perf stat -a -e hns3_pmu_sicl_0/bdf=0x3700,config=0x3,queue=0x0,
> and hns3_pmu_is_enabled_func_mode() has a judgement as below:
> if (!(pmu_event->filter_support & HNS3_PMU_FILTER_SUPPORT_FUNC))
> 
> filter_support of event 0x3 hasn't set bit for func mode, so it can't
> enter func-mode branch, and continue to func-queue mode judgement, port
> judgement, port-tc mode, then enter port-tc mode.
> 
> It's not up to expectations, it shouldn't enter any modes but
> return -ENOENT.
> 
> port-tc mode parameter show as below:
> perf stat -a -e hns3_pmu_sicl_0/config=0x00001,port=0x0,tc=0x1
> 
> port-tc mode should use bdf parameter as 0, so, add judgement of
> bdf parameter to fix it.

I don't follow the description here.  As far as I can see from the code
the change just checks that BDF is not set before allowing a port based
filter.

> 
> Signed-off-by: Hao Chen <chenhao418@huawei.com>
> Signed-off-by: Jijie Shao <shaojijie@huawei.com>
> ---
> changeLog:
>   v2: add more details in log message suggested by Will
>   v1 link: https://lore.kernel.org/all/20230816094619.3563784-1-shaojijie@huawei.com/
> ---
>  drivers/perf/hisilicon/hns3_pmu.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/perf/hisilicon/hns3_pmu.c b/drivers/perf/hisilicon/hns3_pmu.c
> index e0457d84af6b..2aa9cb045705 100644
> --- a/drivers/perf/hisilicon/hns3_pmu.c
> +++ b/drivers/perf/hisilicon/hns3_pmu.c
> @@ -998,12 +998,13 @@ static bool
>  hns3_pmu_is_enabled_port_tc_mode(struct perf_event *event,
>  				 struct hns3_pmu_event_attr *pmu_event)
>  {
> +	u16 bdf = hns3_pmu_get_bdf(event);
>  	u8 tc_id = hns3_pmu_get_tc(event);
>  
>  	if (!(pmu_event->filter_support & HNS3_PMU_FILTER_SUPPORT_PORT_TC))
>  		return false;
>  
> -	return tc_id != HNS3_PMU_FILTER_ALL_TC;
> +	return (tc_id != HNS3_PMU_FILTER_ALL_TC) && (!bdf);

No need for brackets on !bdf

>  }
>  
>  static bool

