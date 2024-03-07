Return-Path: <linux-kernel+bounces-95742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 48E3C8751F6
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 15:36:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE94D1F2695E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 14:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9EE11E87E;
	Thu,  7 Mar 2024 14:36:11 +0000 (UTC)
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3801E18E10;
	Thu,  7 Mar 2024 14:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709822171; cv=none; b=BypLOZjoCyGtA1YlTe/lVdsNB69l8M3hyZDXHwOp4tmebpJ7QdEBUmAeWvNLNHg3LtNB/+6dY/b53ARqKI9/2pLsdnbmw5QWEsffy7aBZ7QPmUVagpo7JkeBth5IAUi++zuTZsUn509F9Ywu4s2Ra6P3nYREQW7UU4P18VuspoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709822171; c=relaxed/simple;
	bh=IN+B13K/eqW9yzntEF91yCyCk7hS1yU/DuL07Ghww0k=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=OE9Vp0QQNHc+e3/0ZXATyU0223jl4prBcbY9A00QYgKRqzNE9KQ+HTszhv//5s/GsHzT0xWNOOdc/oplxzXbI4Zi0Kt7yqISUrJWOk/60ZdS4igFfeWH1t3+5PtwVZD0ii78qaDQyh8M4EHd6ygH43jhWseKfb+kcveIbAti+vA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4TrBck4sr8z1Q9mL;
	Thu,  7 Mar 2024 22:33:42 +0800 (CST)
Received: from kwepemm600012.china.huawei.com (unknown [7.193.23.74])
	by mail.maildlp.com (Postfix) with ESMTPS id 2AD1E140155;
	Thu,  7 Mar 2024 22:36:05 +0800 (CST)
Received: from [10.174.178.220] (10.174.178.220) by
 kwepemm600012.china.huawei.com (7.193.23.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 7 Mar 2024 22:36:04 +0800
Message-ID: <193904fa-d1d6-4bf8-9f49-e44969bdfd85@huawei.com>
Date: Thu, 7 Mar 2024 22:36:03 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] scsi: scsi_core: Fix IO hang when device removing
Content-Language: en-US
To: "James E . J . Bottomley" <jejb@linux.ibm.com>, "Martin K . Petersen"
	<martin.petersen@oracle.com>, <linux-scsi@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <louhongxiang@huawei.com>
References: <20231016020314.1269636-1-haowenchao2@huawei.com>
 <20231016020314.1269636-5-haowenchao2@huawei.com>
From: Wenchao Hao <haowenchao2@huawei.com>
In-Reply-To: <20231016020314.1269636-5-haowenchao2@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600012.china.huawei.com (7.193.23.74)

On 2023/10/16 10:03, Wenchao Hao wrote:
> shost_for_each_device() would skip devices which is in progress of
> removing, so scsi_run_queue() for these devices would be skipped in
> scsi_run_host_queues() after blocking hosts' IO.
> 
> IO hang would be caused if return true when state is SDEV_CANCEL with
> following order:
> 
> T1:					    T2:scsi_error_handler
> __scsi_remove_device()
>    scsi_device_set_state(sdev, SDEV_CANCEL)
>    ...
>    sd_remove()
>    del_gendisk()
>    blk_mq_freeze_queue_wait()
>    					    scsi_eh_flush_done_q()
> 					      scsi_queue_insert(scmd,...)
> 
> scsi_queue_insert() would not kick device's queue since commit
> 8b566edbdbfb ("scsi: core: Only kick the requeue list if necessary")
> 
> After scsi_unjam_host(), the scsi error handler would call
> scsi_run_host_queues() to trigger run queue for devices, while it
> would not run queue for devices which is in progress of removing
> because shost_for_each_device() would skip them.
> 
> So the requests added to these queues would not be handled any more,
> and the removing device process would hang too.
> 
> Fix this issue by using shost_for_each_device_include_deleted() in
> scsi_run_host_queues() to trigger a run queue for devices in removing.
> 

This issue is fixed by commit '6df0e077d76bd (scsi: core: Kick the requeue
list after inserting when flushing)', so do not need any more.

> Signed-off-by: Wenchao Hao <haowenchao2@huawei.com>
> ---
>   drivers/scsi/scsi_lib.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
> index 195ca80667d0..40f407ffd26f 100644
> --- a/drivers/scsi/scsi_lib.c
> +++ b/drivers/scsi/scsi_lib.c
> @@ -466,7 +466,7 @@ void scsi_run_host_queues(struct Scsi_Host *shost)
>   {
>   	struct scsi_device *sdev;
>   
> -	shost_for_each_device(sdev, shost)
> +	shost_for_each_device_include_deleted(sdev, shost)
>   		scsi_run_queue(sdev->request_queue);
>   }
>   


