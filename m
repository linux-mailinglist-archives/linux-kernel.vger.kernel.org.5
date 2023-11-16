Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7828C7EDA40
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 04:31:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344782AbjKPDbG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 22:31:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjKPDbF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 22:31:05 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B48B5196;
        Wed, 15 Nov 2023 19:31:00 -0800 (PST)
Received: from dggpemd100001.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4SW56P6tYlzMmxg;
        Thu, 16 Nov 2023 11:26:21 +0800 (CST)
Received: from [10.67.120.108] (10.67.120.108) by
 dggpemd100001.china.huawei.com (7.185.36.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1258.23; Thu, 16 Nov 2023 11:30:58 +0800
Message-ID: <a3bd38bd-4f77-86e4-a983-4761536f2d63@huawei.com>
Date:   Thu, 16 Nov 2023 11:30:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH v2] scsi: libsas: Fix set zero-address when device-type !=
 NO_DEVICE
Content-Language: en-CA
To:     <john.g.garry@oracle.com>, <yanaijie@huawei.com>,
        <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <damien.lemoal@opensource.wdc.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <prime.zeng@hisilicon.com>,
        <kangfenglong@huawei.com>, <chenxiang66@hisilicon.com>
References: <20231114134632.41128-1-yangxingui@huawei.com>
From:   yangxingui <yangxingui@huawei.com>
In-Reply-To: <20231114134632.41128-1-yangxingui@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.120.108]
X-ClientProxiedBy: dggpemm500024.china.huawei.com (7.185.36.203) To
 dggpemd100001.china.huawei.com (7.185.36.94)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I've updated a new version, thanks.

On 2023/11/14 21:46, Xingui Yang wrote:
> Firstly, when ex_phy is added to the parent port, ex_phy->port is not set.
> As a result, sas_port_delete_phy() won' t be called in
> sas_unregister_devs_sas_addr() and it won't be deleted from the parent
> port's phy_list.
> 
> Secondly, phy->attached_sas_addr will be set to a zero-address when
> phy->linkrate < SAS_LINK_RATE_1_5_GBPS and device-type != NO_DEVICE during
> device registration, such as stp. It will create a new port and all other
> ex_phys whose addresses are zero will be added to the new port in
> sas_ex_get_linkrate(), and it may trigger BUG() as follows:
> 
> [562240.051046] sas: phy19 part of wide port with phy16
> [562240.051197] sas: ex 500e004aaaaaaa1f phy19:U:0 attached: 0000000000000000 (no device)
> [562240.051203] sas: done REVALIDATING DOMAIN on port 0, pid:435909, res 0x0
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
> So set ex_phy->port with parent_port when ex_phy is added to the parent
> port and don't set a zero-address when phy->attached_dev_type != NO_DEVICE.
> 
> Fixes: 7d1d86518118 ("[SCSI] libsas: fix false positive 'device attached' conditions")
> Signed-off-by: Xingui Yang <yangxingui@huawei.com>
> ---
> 
> v2 -> v1:
> 1. Set ex_phy->port with parent_port when ex_phy is added to the parent port
> 2. Set ex_phy to NULL when free expander
> 3. Update the comments
> 
> ---
>   drivers/scsi/libsas/sas_discover.c | 4 +++-
>   drivers/scsi/libsas/sas_expander.c | 3 +--
>   drivers/scsi/libsas/sas_internal.h | 1 +
>   3 files changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/scsi/libsas/sas_discover.c b/drivers/scsi/libsas/sas_discover.c
> index 8fb7c41c0962..8eb3888a9e57 100644
> --- a/drivers/scsi/libsas/sas_discover.c
> +++ b/drivers/scsi/libsas/sas_discover.c
> @@ -296,8 +296,10 @@ void sas_free_device(struct kref *kref)
>   	dev->phy = NULL;
>   
>   	/* remove the phys and ports, everything else should be gone */
> -	if (dev_is_expander(dev->dev_type))
> +	if (dev_is_expander(dev->dev_type)) {
>   		kfree(dev->ex_dev.ex_phy);
> +		dev->ex_dev.ex_phy = NULL;
> +	}
>   
>   	if (dev_is_sata(dev) && dev->sata_dev.ap) {
>   		ata_sas_tport_delete(dev->sata_dev.ap);
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
> diff --git a/drivers/scsi/libsas/sas_internal.h b/drivers/scsi/libsas/sas_internal.h
> index 3804aef165ad..e860d5b19880 100644
> --- a/drivers/scsi/libsas/sas_internal.h
> +++ b/drivers/scsi/libsas/sas_internal.h
> @@ -202,6 +202,7 @@ static inline void sas_add_parent_port(struct domain_device *dev, int phy_id)
>   		sas_port_mark_backlink(ex->parent_port);
>   	}
>   	sas_port_add_phy(ex->parent_port, ex_phy->phy);
> +	ex_phy->port = ex->parent_port;
>   }
>   
>   static inline struct domain_device *sas_alloc_device(void)
> 
