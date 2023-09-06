Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A604793541
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 08:26:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241132AbjIFG0z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 02:26:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbjIFG0u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 02:26:50 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7445197
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 23:26:45 -0700 (PDT)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RgXNf2zTPzhZDx;
        Wed,  6 Sep 2023 14:22:42 +0800 (CST)
Received: from [10.67.121.177] (10.67.121.177) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Wed, 6 Sep 2023 14:26:41 +0800
CC:     <shenjian15@huawei.com>, <wangjie125@huawei.com>,
        <liuyonglong@huawei.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <will@kernel.org>,
        <jonathan.cameron@huawei.com>, <mark.rutland@arm.com>,
        <yangyicong@hisilicon.com>
Subject: Re: [PATCH V2 drivers/perf: hisi:] drivers/perf: hisi: fix set wrong
 filter mode for running events issue
To:     Jijie Shao <shaojijie@huawei.com>, <chenhao418@huawei.com>
References: <20230901035027.3881389-1-shaojijie@huawei.com>
From:   Yicong Yang <yangyicong@huawei.com>
Message-ID: <a2111bbf-4d40-2112-6f3a-86c152e7ee0b@huawei.com>
Date:   Wed, 6 Sep 2023 14:26:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20230901035027.3881389-1-shaojijie@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.121.177]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/9/1 11:50, Jijie Shao wrote:
> From: Hao Chen <chenhao418@huawei.com>
> 
> hns3_pmu_select_filter_mode() includes A series of mode judgments such
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
> 

Will the change here block the below unsupported case for event 0x3?

$ perf stat -a -e hns3_pmu_sicl_0/bdf=0x0,config=0x3,queue=0x0/

Otherwise you should handle this case.

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
>  }
>  
>  static bool
> 
