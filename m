Return-Path: <linux-kernel+bounces-154512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50C698ADCF7
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 06:55:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 815B71C218DE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 04:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10357200A0;
	Tue, 23 Apr 2024 04:55:41 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ECD21CFB5
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 04:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713848140; cv=none; b=ZHN+PQPFT05thQaNVBlSdG0/jEPOlLZpREVrE18zKyLHr61etObQiS8eIXKBbGyDUvjMvC4v2Ciju6qySDeJ1Wt7xNRi999FIhgpI8wVozm6LjBcxQonr2UqiK7GOM/3Tawhm0hsCQpi3MTvh6/t0ixt8S5O+3AIBudcg3yPphw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713848140; c=relaxed/simple;
	bh=SOwdi7HG2+z5wZidwvPN/H71xJ+z4d8xd6bHwCAQBbQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=q59unPUCtyQQwlv1hHldlCW4VCTbHEktkH1S9Neazxj22WEme5sPS1+ejnB789d5YuoDHUa7QwhYr2dxfUt2YHS9x3lH6AQCCccGZ9tco5UgoF/grpHXpXhtkh4qwAfBLAZ2uzmv/adZy6jVB99gx4xcFw1D/PPRo/dmX1oEfdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4VNqTz4pWFzXksc;
	Tue, 23 Apr 2024 12:52:07 +0800 (CST)
Received: from kwepemm600012.china.huawei.com (unknown [7.193.23.74])
	by mail.maildlp.com (Postfix) with ESMTPS id 3CA5F1800B8;
	Tue, 23 Apr 2024 12:55:35 +0800 (CST)
Received: from [10.174.178.220] (10.174.178.220) by
 kwepemm600012.china.huawei.com (7.193.23.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 23 Apr 2024 12:55:34 +0800
Message-ID: <00b43845-c990-481f-be0a-4bf15ada8b3c@huawei.com>
Date: Tue, 23 Apr 2024 12:55:22 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] workqueue: Fix rescuer task's name truncated
To: Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, Aaron
 Tomlin <atomlin@atomlin.com>, <linux-kernel@vger.kernel.org>
CC: Wenchao Hao <haowenchao22@gmail.com>
References: <20240423182104.1812150-1-haowenchao2@huawei.com>
Content-Language: en-US
From: Wenchao Hao <haowenchao2@huawei.com>
In-Reply-To: <20240423182104.1812150-1-haowenchao2@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600012.china.huawei.com (7.193.23.74)

On 2024/4/24 2:21, Wenchao Hao wrote:
> Task comm of task is limitted to 16, prefix "kworker/R-" is added for
> rescuer worker's task, which cause most task name is truncated as
> following:
> 
> root   81  0.0  0.0  0  0 ?   I<   11:18   0:00 [kworker/R-xprti]
> root   82  0.0  0.0  0  0 ?   I<   11:18   0:00 [kworker/R-cfg80]
> root   85  0.0  0.0  0  0 ?   I<   11:18   0:00 [kworker/R-nfsio]
> root   86  0.0  0.0  0  0 ?   I<   11:18   0:00 [kworker/R-xfsal]
> root   87  0.0  0.0  0  0 ?   I<   11:18   0:00 [kworker/R-xfs_m]
> root   88  0.0  0.0  0  0 ?   I<   11:18   0:00 [kworker/R-acpi_]
> root   93  0.0  0.0  0  0 ?   I<   11:18   0:00 [kworker/R-iscsi]
> root   95  0.0  0.0  0  0 ?   I<   11:18   0:00 [kworker/R-scsi_]
> root   97  0.0  0.0  0  0 ?   I<   11:18   0:00 [kworker/R-scsi_]
> root   99  0.0  0.0  0  0 ?   I<   11:18   0:00 [kworker/R-scsi_]
> 
> I want to fix this issue by split rescuer name to 2 part like other
> kworker, the normal part is "kworker/R" which is set to task_struct's comm,
> another part is wq->name which is added to kworker's desc. These 2 parts
> would be merged in wq_worker_comm().
> 
> Fixes: b6a46f7263bd ("workqueue: Rename rescuer kworker")
> 
> Signed-off-by: Wenchao Hao <haowenchao2@huawei.com>
> ---
>   kernel/workqueue.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/workqueue.c b/kernel/workqueue.c
> index 0066c8f6c154..0ce9e8597a4d 100644
> --- a/kernel/workqueue.c
> +++ b/kernel/workqueue.c
> @@ -5430,7 +5430,7 @@ static int init_rescuer(struct workqueue_struct *wq)
>   	}
>   
>   	rescuer->rescue_wq = wq;
> -	rescuer->task = kthread_create(rescuer_thread, rescuer, "kworker/R-%s", wq->name);
> +	rescuer->task = kthread_create(rescuer_thread, rescuer, "kworker/R");
>   	if (IS_ERR(rescuer->task)) {
>   		ret = PTR_ERR(rescuer->task);
>   		pr_err("workqueue: Failed to create a rescuer kthread for wq \"%s\": %pe",
> @@ -5439,6 +5439,8 @@ static int init_rescuer(struct workqueue_struct *wq)
>   		return ret;
>   	}
>   
> +	snprintf(rescuer->desc, sizeof(rescuer->desc), "%s", wq->name);
> +
>   	wq->rescuer = rescuer;
>   	if (wq->flags & WQ_UNBOUND)
>   		kthread_bind_mask(rescuer->task, wq_unbound_cpumask);
> @@ -6289,6 +6291,8 @@ void wq_worker_comm(char *buf, size_t size, struct task_struct *task)
>   						  worker->desc);
>   			}
>   			raw_spin_unlock_irq(&pool->lock);
> +		} else if (worker->desc[0] != '\0') {
> +			scnprintf(buf + off, size - off, "-%s", worker->desc);
>   		}


Hi Tejun and all:

I added another logic in wq_worker_comm() to append worker's desc when
worker is not attached to a work pool. I don't know why the origin
logic only append worker's desc when worker is attached to a work pool,
so I am not sure if it's safe to using worker here directly.

>   	}
>   


