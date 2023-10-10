Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C26507BF75F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 11:32:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230210AbjJJJcK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 05:32:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjJJJcI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 05:32:08 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24CBC93
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 02:32:06 -0700 (PDT)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4S4Vt76ML3ztT2L;
        Tue, 10 Oct 2023 17:27:27 +0800 (CST)
Received: from [10.67.121.177] (10.67.121.177) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Tue, 10 Oct 2023 17:32:03 +0800
CC:     <chenhao418@huawei.com>, <shenjian15@huawei.com>,
        <wangjie125@huawei.com>, <liuyonglong@huawei.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH drivers/perf: hisi:] drivers/perf: hisi: fix NULL pointer
 issue when uninstall hns3 pmu driver
To:     Jijie Shao <shaojijie@huawei.com>, <will@kernel.org>,
        <jonathan.cameron@huawei.com>, <mark.rutland@arm.com>,
        <yangyicong@hisilicon.com>
References: <20231009105038.126040-1-shaojijie@huawei.com>
From:   Yicong Yang <yangyicong@huawei.com>
Message-ID: <504cc838-d587-8bd0-601e-85f11b69c72b@huawei.com>
Date:   Tue, 10 Oct 2023 17:32:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20231009105038.126040-1-shaojijie@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.121.177]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jijie,

On 2023/10/9 18:50, Jijie Shao wrote:
> From: Hao Chen <chenhao418@huawei.com>
> 
> When uninstall hns3 pmu driver, it will call cpuhp_state_remove_instance()
> and then callback function hns3_pmu_offline_cpu() is called, it may cause
> NULL pointer call trace when other driver is installing or uninstalling
> concurrently.
> 

More information about the calltrace you've met and how to reproduce this?
I'm not sure why other drivers are involved.

> As John Garry's opinion, cpuhp_state_remove_instance() is used for shared
> interrupt, and using cpuhp_state_remove_instance_nocalls() is fine for PCIe
> or HNS3 pmu.
> 

I'm a bit confused here. We need to update the using CPU and migrate the perf
context as well as the interrupt affinity in cpuhp::teardown() callback, so
it make sense to not call this on driver detachment. But I cannot figure
out why this is related to the shared interrupt, more details?

> So, replace cpuhp_state_remove_instance() with
> cpuhp_state_remove_instance_nocalls() to fix this problem.
> 
> Fixes: 66637ab137b4 ("drivers/perf: hisi: add driver for HNS3 PMU")
> Signed-off-by: Hao Chen <chenhao418@huawei.com>
> Signed-off-by: Jijie Shao <shaojijie@huawei.com>
> ---
>  drivers/perf/hisilicon/hns3_pmu.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/perf/hisilicon/hns3_pmu.c b/drivers/perf/hisilicon/hns3_pmu.c
> index e0457d84af6b..16869bf5bf4c 100644
> --- a/drivers/perf/hisilicon/hns3_pmu.c
> +++ b/drivers/perf/hisilicon/hns3_pmu.c
> @@ -1556,8 +1556,8 @@ static int hns3_pmu_init_pmu(struct pci_dev *pdev, struct hns3_pmu *hns3_pmu)
>  	ret = perf_pmu_register(&hns3_pmu->pmu, hns3_pmu->pmu.name, -1);
>  	if (ret) {
>  		pci_err(pdev, "failed to register perf PMU, ret = %d.\n", ret);
> -		cpuhp_state_remove_instance(CPUHP_AP_PERF_ARM_HNS3_PMU_ONLINE,
> -					    &hns3_pmu->node);
> +		cpuhp_state_remove_instance_nocalls(CPUHP_AP_PERF_ARM_HNS3_PMU_ONLINE,
> +						    &hns3_pmu->node);
>  	}
>  
>  	return ret;
> @@ -1568,8 +1568,8 @@ static void hns3_pmu_uninit_pmu(struct pci_dev *pdev)
>  	struct hns3_pmu *hns3_pmu = pci_get_drvdata(pdev);
>  
>  	perf_pmu_unregister(&hns3_pmu->pmu);
> -	cpuhp_state_remove_instance(CPUHP_AP_PERF_ARM_HNS3_PMU_ONLINE,
> -				    &hns3_pmu->node);
> +	cpuhp_state_remove_instance_nocalls(CPUHP_AP_PERF_ARM_HNS3_PMU_ONLINE,
> +					    &hns3_pmu->node);
>  }
Thanks.



