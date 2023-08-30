Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB9E278E04D
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:16:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239740AbjH3TSn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:18:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244286AbjH3Mws (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 08:52:48 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DD2E132;
        Wed, 30 Aug 2023 05:52:44 -0700 (PDT)
Received: from kwepemm600012.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4RbPJ560kqzLpBF;
        Wed, 30 Aug 2023 20:49:25 +0800 (CST)
Received: from [10.174.178.220] (10.174.178.220) by
 kwepemm600012.china.huawei.com (7.193.23.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Wed, 30 Aug 2023 20:52:37 +0800
Message-ID: <3fc45984-46f9-dec2-ecce-68d6897874a9@huawei.com>
Date:   Wed, 30 Aug 2023 20:52:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] scsi:libsas: Simplify sas_queue_reset and remove unused
 code
Content-Language: en-US
To:     John Garry <john.g.garry@oracle.com>,
        Jason Yan <yanaijie@huawei.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Damien Le Moal <dlemoal@kernel.org>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <louhongxiang@huawei.com>
References: <20230729102451.2452826-1-haowenchao2@huawei.com>
From:   "haowenchao (C)" <haowenchao2@huawei.com>
In-Reply-To: <20230729102451.2452826-1-haowenchao2@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.220]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600012.china.huawei.com (7.193.23.74)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/7/29 18:24, Wenchao Hao wrote:
> sas_queue_reset is always called with param "wait" set to 0, so
> remove it from this function's param list. And remove unused
> function sas_wait_eh.
> 

Ping...

> Signed-off-by: Wenchao Hao <haowenchao2@huawei.com>
> ---
>   drivers/scsi/libsas/sas_scsi_host.c | 41 +++--------------------------
>   1 file changed, 3 insertions(+), 38 deletions(-)
> 
> diff --git a/drivers/scsi/libsas/sas_scsi_host.c b/drivers/scsi/libsas/sas_scsi_host.c
> index 94c5f14f3c16..3f01e77eaee3 100644
> --- a/drivers/scsi/libsas/sas_scsi_host.c
> +++ b/drivers/scsi/libsas/sas_scsi_host.c
> @@ -387,37 +387,7 @@ struct sas_phy *sas_get_local_phy(struct domain_device *dev)
>   }
>   EXPORT_SYMBOL_GPL(sas_get_local_phy);
>   
> -static void sas_wait_eh(struct domain_device *dev)
> -{
> -	struct sas_ha_struct *ha = dev->port->ha;
> -	DEFINE_WAIT(wait);
> -
> -	if (dev_is_sata(dev)) {
> -		ata_port_wait_eh(dev->sata_dev.ap);
> -		return;
> -	}
> - retry:
> -	spin_lock_irq(&ha->lock);
> -
> -	while (test_bit(SAS_DEV_EH_PENDING, &dev->state)) {
> -		prepare_to_wait(&ha->eh_wait_q, &wait, TASK_UNINTERRUPTIBLE);
> -		spin_unlock_irq(&ha->lock);
> -		schedule();
> -		spin_lock_irq(&ha->lock);
> -	}
> -	finish_wait(&ha->eh_wait_q, &wait);
> -
> -	spin_unlock_irq(&ha->lock);
> -
> -	/* make sure SCSI EH is complete */
> -	if (scsi_host_in_recovery(ha->core.shost)) {
> -		msleep(10);
> -		goto retry;
> -	}
> -}
> -
> -static int sas_queue_reset(struct domain_device *dev, int reset_type,
> -			   u64 lun, int wait)
> +static int sas_queue_reset(struct domain_device *dev, int reset_type, u64 lun)
>   {
>   	struct sas_ha_struct *ha = dev->port->ha;
>   	int scheduled = 0, tries = 100;
> @@ -425,8 +395,6 @@ static int sas_queue_reset(struct domain_device *dev, int reset_type,
>   	/* ata: promote lun reset to bus reset */
>   	if (dev_is_sata(dev)) {
>   		sas_ata_schedule_reset(dev);
> -		if (wait)
> -			sas_ata_wait_eh(dev);
>   		return SUCCESS;
>   	}
>   
> @@ -444,9 +412,6 @@ static int sas_queue_reset(struct domain_device *dev, int reset_type,
>   		}
>   		spin_unlock_irq(&ha->lock);
>   
> -		if (wait)
> -			sas_wait_eh(dev);
> -
>   		if (scheduled)
>   			return SUCCESS;
>   	}
> @@ -499,7 +464,7 @@ int sas_eh_device_reset_handler(struct scsi_cmnd *cmd)
>   	struct sas_internal *i = to_sas_internal(host->transportt);
>   
>   	if (current != host->ehandler)
> -		return sas_queue_reset(dev, SAS_DEV_LU_RESET, cmd->device->lun, 0);
> +		return sas_queue_reset(dev, SAS_DEV_LU_RESET, cmd->device->lun);
>   
>   	int_to_scsilun(cmd->device->lun, &lun);
>   
> @@ -522,7 +487,7 @@ int sas_eh_target_reset_handler(struct scsi_cmnd *cmd)
>   	struct sas_internal *i = to_sas_internal(host->transportt);
>   
>   	if (current != host->ehandler)
> -		return sas_queue_reset(dev, SAS_DEV_RESET, 0, 0);
> +		return sas_queue_reset(dev, SAS_DEV_RESET, 0);
>   
>   	if (!i->dft->lldd_I_T_nexus_reset)
>   		return FAILED;

