Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A58337ADADB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 17:02:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232470AbjIYPCY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 11:02:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbjIYPCW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 11:02:22 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C48EB101;
        Mon, 25 Sep 2023 08:02:15 -0700 (PDT)
Received: from kwepemm000012.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RvQym20rJzrSxy;
        Mon, 25 Sep 2023 23:00:00 +0800 (CST)
Received: from [10.174.178.220] (10.174.178.220) by
 kwepemm000012.china.huawei.com (7.193.23.142) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Mon, 25 Sep 2023 23:02:13 +0800
Message-ID: <6531a3b0-915d-8078-b265-95231405ac4d@huawei.com>
Date:   Mon, 25 Sep 2023 23:02:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 1/2] scsi: core: scsi_device_online() return false if
 state is SDEV_CANCEL
Content-Language: en-US
To:     "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        <linux-scsi@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <louhongxiang@huawei.com>
References: <20230922093636.2645961-1-haowenchao2@huawei.com>
 <20230922093636.2645961-2-haowenchao2@huawei.com>
From:   Wenchao Hao <haowenchao2@huawei.com>
In-Reply-To: <20230922093636.2645961-2-haowenchao2@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.220]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm000012.china.huawei.com (7.193.23.142)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/9/22 17:36, Wenchao Hao wrote:
> SDEV_CANCEL is set when removing device and scsi_device_online() should
> return false if sdev_state is SDEV_CANCEL.
> 
> IO hang would be caused if return true when state is SDEV_CANCEL with
> following order:
> 
> T1:					    T2:scsi_error_handler
> __scsi_remove_device()
>    scsi_device_set_state(sdev, SDEV_CANCEL)
>    					    scsi_eh_flush_done_q()
> 					    if (scsi_device_online(sdev))
> 					      scsi_queue_insert(scmd,...)
> 
> The command added by scsi_queue_insert() would never be handled any
> more.
> 
> Signed-off-by: Wenchao Hao <haowenchao2@huawei.com>
> ---
>   include/scsi/scsi_device.h | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/include/scsi/scsi_device.h b/include/scsi/scsi_device.h
> index 75b2235b99e2..c498a12f7715 100644
> --- a/include/scsi/scsi_device.h
> +++ b/include/scsi/scsi_device.h
> @@ -517,7 +517,8 @@ static inline int scsi_device_online(struct scsi_device *sdev)
>   {
>   	return (sdev->sdev_state != SDEV_OFFLINE &&
>   		sdev->sdev_state != SDEV_TRANSPORT_OFFLINE &&
> -		sdev->sdev_state != SDEV_DEL);
> +		sdev->sdev_state != SDEV_DEL &&
> +		sdev->sdev_state != SDEV_CANCEL);
>   }
>   static inline int scsi_device_blocked(struct scsi_device *sdev)
>   {

Return false when if sdev_state is SDEV_CANCEL seems change some flow in
error handle, but I don't know if we should introduce these changes.
I think it's both ok to finish the failed command or try more recovery steps.

For example, in scsi_eh_bus_device_reset(), when scsi_try_bus_device_reset()
returned SUCCEED but the sdev_state is SDEV_CANCEL, should skip TUR and just
call scsi_eh_finish_cmd() to add this LUN's error command to done_q?

We can address the issue of IO hang described in this patch by running
scsi_device's queue regardless of the scsi_device's state and it seems
a better solution because the main reason of IO hang is as following:

scsi_restart_operations()
	-> scsi_run_host_queues()
		-> shost_for_each_device() // skip scsi_device with SDEV_DEL
					   // or SDEV_CANCEL state
