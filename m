Return-Path: <linux-kernel+bounces-19443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FB5D826CF9
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 12:37:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 773421C220D6
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 11:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC82C2941D;
	Mon,  8 Jan 2024 11:37:31 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB3C29419
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 11:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4T7sSp4LbGz1Q7tv;
	Mon,  8 Jan 2024 19:35:54 +0800 (CST)
Received: from dggpemm100001.china.huawei.com (unknown [7.185.36.93])
	by mail.maildlp.com (Postfix) with ESMTPS id 31C101A0192;
	Mon,  8 Jan 2024 19:37:25 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 8 Jan 2024 19:37:24 +0800
Message-ID: <52ac2f13-6439-490f-98a6-79f79b9897e9@huawei.com>
Date: Mon, 8 Jan 2024 19:37:23 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hwtracing: hisi_ptt: Move type check to the beginning of
 hisi_ptt_pmu_event_init()
Content-Language: en-US
To: Yang Jihong <yangjihong1@huawei.com>, <yangyicong@hisilicon.com>,
	<jonathan.cameron@huawei.com>, <alexander.shishkin@linux.intel.com>,
	<linux-kernel@vger.kernel.org>
References: <20240108112024.3514498-1-yangjihong1@huawei.com>
From: Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <20240108112024.3514498-1-yangjihong1@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm100001.china.huawei.com (7.185.36.93)



On 2024/1/8 19:20, Yang Jihong wrote:
> When perf_init_event() calls perf_try_init_event() to init pmu driver,
> searches for the next pmu driver only when the return value is -ENOENT.
> Therefore, hisi_ptt_pmu_event_init() needs to check the type at the
> beginning of the function.
> Otherwise, in the case of perf-task mode, perf_try_init_event() returns
> -EOPNOTSUPP and skips subsequent pmu drivers, causes perf_init_event() to
> fail.
> 

Maybe

Fixes: ff0de066b463 ("hwtracing: hisi_ptt: Add trace function support 
for HiSilicon PCIe Tune and Trace device")

It fixes my non hw event issue(perf list hw), thanks.

> Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
> ---
>   drivers/hwtracing/ptt/hisi_ptt.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/hwtracing/ptt/hisi_ptt.c b/drivers/hwtracing/ptt/hisi_ptt.c
> index a991ecb7515a..24a1f7797aeb 100644
> --- a/drivers/hwtracing/ptt/hisi_ptt.c
> +++ b/drivers/hwtracing/ptt/hisi_ptt.c
> @@ -995,6 +995,9 @@ static int hisi_ptt_pmu_event_init(struct perf_event *event)
>   	int ret;
>   	u32 val;
>   
> +	if (event->attr.type != hisi_ptt->hisi_ptt_pmu.type)
> +		return -ENOENT;
> +
>   	if (event->cpu < 0) {
>   		dev_dbg(event->pmu->dev, "Per-task mode not supported\n");
>   		return -EOPNOTSUPP;
> @@ -1003,9 +1006,6 @@ static int hisi_ptt_pmu_event_init(struct perf_event *event)
>   	if (event->attach_state & PERF_ATTACH_TASK)
>   		return -EOPNOTSUPP;
>   
> -	if (event->attr.type != hisi_ptt->hisi_ptt_pmu.type)
> -		return -ENOENT;
> -
>   	ret = hisi_ptt_trace_valid_filter(hisi_ptt, event->attr.config);
>   	if (ret < 0)
>   		return ret;

