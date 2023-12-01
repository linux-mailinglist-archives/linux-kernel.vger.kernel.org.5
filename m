Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFE788001CE
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 04:00:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232252AbjLAC7y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 21:59:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjLAC7x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 21:59:53 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F2121711;
        Thu, 30 Nov 2023 18:59:59 -0800 (PST)
Received: from dggpemd100001.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4ShHp650blzWj2q;
        Fri,  1 Dec 2023 10:59:10 +0800 (CST)
Received: from [10.67.120.108] (10.67.120.108) by
 dggpemd100001.china.huawei.com (7.185.36.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1258.28; Fri, 1 Dec 2023 10:59:57 +0800
Message-ID: <2bc81cf1-5d94-c108-a107-a746daadb64d@huawei.com>
Date:   Fri, 1 Dec 2023 10:59:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH] scsi: libsas: Put the disk offline if all recovery
 actions fail
Content-Language: en-CA
From:   yangxingui <yangxingui@huawei.com>
To:     <john.g.garry@oracle.com>, <yanaijie@huawei.com>,
        <damien.lemoal@opensource.wdc.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <wubo40@huawei.com>, <kangfenglong@huawei.com>
References: <20231130130118.14367-1-yangxingui@huawei.com>
In-Reply-To: <20231130130118.14367-1-yangxingui@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.120.108]
X-ClientProxiedBy: dggpemm100004.china.huawei.com (7.185.36.189) To
 dggpemd100001.china.huawei.com (7.185.36.94)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, please ignore this email, I need to update a new version, Thanks.

On 2023/11/30 21:01, Xingui Yang wrote:
> Currently, after all recovery actions in sas_eh_handle_sas_errors() fail
> for sas disk, we just clear all IO, but the disk is still online. Perhaps
> we should continue the subsequent recovery process for IO that cannot be
> processed. If it still fails, the disk will be offline in
> scsi_eh_ready_devs().
> 
> Signed-off-by: Xingui Yang <yangxingui@huawei.com>
> Signed-off-by: Bo Wu <wubo40@huawei.com>
> ---
>   drivers/scsi/libsas/sas_scsi_host.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/scsi/libsas/sas_scsi_host.c b/drivers/scsi/libsas/sas_scsi_host.c
> index 9047cfcd1072..3f9b99fa1769 100644
> --- a/drivers/scsi/libsas/sas_scsi_host.c
> +++ b/drivers/scsi/libsas/sas_scsi_host.c
> @@ -637,8 +637,8 @@ static void sas_eh_handle_sas_errors(struct Scsi_Host *shost, struct list_head *
>   			       SAS_ADDR(task->dev->sas_addr),
>   			       cmd->device->lun);
>   
> -			sas_eh_finish_cmd(cmd);
> -			goto clear_q;
> +			list_move_tail(&cmd->eh_entry, work_q);
> +			goto out;
>   		}
>   	}
>    out:
> 
