Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC1CE7D06D2
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 05:25:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346887AbjJTDZH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 23:25:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233400AbjJTDZE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 23:25:04 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF5A2181;
        Thu, 19 Oct 2023 20:25:00 -0700 (PDT)
Received: from canpemm100004.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4SBVJ367hGzrTKr;
        Fri, 20 Oct 2023 11:22:11 +0800 (CST)
Received: from [10.174.179.14] (10.174.179.14) by
 canpemm100004.china.huawei.com (7.192.105.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Fri, 20 Oct 2023 11:24:57 +0800
Subject: Re: [PATCH] scsi: libsas: fix set zero-address when device-type !=
 NO_DEVICE
To:     Xingui Yang <yangxingui@huawei.com>, <john.g.garry@oracle.com>,
        <jejb@linux.ibm.com>, <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <prime.zeng@hisilicon.com>,
        <kangfenglong@huawei.com>, <xiabing12@h-partners.com>
References: <20231020024240.7708-1-yangxingui@huawei.com>
From:   Jason Yan <yanaijie@huawei.com>
Message-ID: <31524a87-9e02-5e43-5d71-5747c2e6e6b0@huawei.com>
Date:   Fri, 20 Oct 2023 11:24:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20231020024240.7708-1-yangxingui@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.14]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm100004.china.huawei.com (7.192.105.92)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/10/20 10:42, Xingui Yang wrote:
> phy->attached_sas_addr will be set to a zero-address when
> phy->linkrate < SAS_LINK_RATE_1_5_GBPS but device-type != NO_DEVICE,
> and it may trigger BUG() as follows when do revalidate with zero-address:

Hi  Xingui,

Why is this zero-addressed PHY added to another port? A zero-addressed 
PHY should not belong to any port.

Thanks,
Jason

> 
> [562240.062536] sas: ex 500e004aaaaaaa1f phy0 new device attached
> [562240.062616] sas: ex 500e004aaaaaaa1f phy00:U:5 attached: 0000000000000000 (stp)
> [562240.062680]  port-7:7:0: trying to add phy phy-7:7:19 fails: it's already part of another port
> [562240.085064] ------------[ cut here ]------------
> [562240.096612] kernel BUG at drivers/scsi/scsi_transport_sas.c:1083!
> [562240.109611] Internal error: Oops - BUG: 0 [#1] SMP
> [562240.343518] Process kworker/u256:3 (pid: 435909, stack limit = 0x0000000003bcbebf)
> [562240.421714] Workqueue: 0000:b4:02.0_disco_q sas_revalidate_domain [libsas]
> [562240.437173] pstate: 40c00009 (nZcv daif +PAN +UAO)
> [562240.450478] pc : sas_port_add_phy+0x13c/0x168 [scsi_transport_sas]
> [562240.465283] lr : sas_port_add_phy+0x13c/0x168 [scsi_transport_sas]
> [562240.479751] sp : ffff0000300cfa70
> [562240.674822] Call trace:
> [562240.682709]  sas_port_add_phy+0x13c/0x168 [scsi_transport_sas]
> [562240.694013]  sas_ex_get_linkrate.isra.5+0xcc/0x128 [libsas]
> [562240.704957]  sas_ex_discover_end_dev+0xfc/0x538 [libsas]
> [562240.715508]  sas_ex_discover_dev+0x3cc/0x4b8 [libsas]
> [562240.725634]  sas_ex_discover_devices+0x9c/0x1a8 [libsas]
> [562240.735855]  sas_ex_revalidate_domain+0x2f0/0x450 [libsas]
> [562240.746123]  sas_revalidate_domain+0x158/0x160 [libsas]
> [562240.756014]  process_one_work+0x1b4/0x448
> [562240.764548]  worker_thread+0x54/0x468
> [562240.772562]  kthread+0x134/0x138
> [562240.779989]  ret_from_fork+0x10/0x18
> 
> So set a zero-address for phy->attached_sas_addr only when
> phy->attached_dev_type == NO_DEVICE.
> 
> Fixes: 7d1d86518118 ("[SCSI] libsas: fix false positive 'device attached' conditions")
> 
> Signed-off-by: Xingui Yang <yangxingui@huawei.com>
> ---
>   drivers/scsi/libsas/sas_expander.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/scsi/libsas/sas_expander.c b/drivers/scsi/libsas/sas_expander.c
> index a2204674b680..5a81754d3768 100644
> --- a/drivers/scsi/libsas/sas_expander.c
> +++ b/drivers/scsi/libsas/sas_expander.c
> @@ -239,8 +239,7 @@ static void sas_set_ex_phy(struct domain_device *dev, int phy_id,
>   	/* help some expanders that fail to zero sas_address in the 'no
>   	 * device' case
>   	 */
> -	if (phy->attached_dev_type == SAS_PHY_UNUSED ||
> -	    phy->linkrate < SAS_LINK_RATE_1_5_GBPS)
> +	if (phy->attached_dev_type == SAS_PHY_UNUSED)
>   		memset(phy->attached_sas_addr, 0, SAS_ADDR_SIZE);
>   	else
>   		memcpy(phy->attached_sas_addr, dr->attached_sas_addr, SAS_ADDR_SIZE);
> 
