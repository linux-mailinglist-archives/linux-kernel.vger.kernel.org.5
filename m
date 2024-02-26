Return-Path: <linux-kernel+bounces-80369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E06A86676E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 02:06:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7B3C281167
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 01:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE5427460;
	Mon, 26 Feb 2024 01:06:48 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75B38323D
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 01:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708909608; cv=none; b=pU38ZBNe6ZZhM/G5JmP8f2v3lzGhCpSwX8kG32Ga8vokLy30EM/vdCfcSqB/tFTbp/WduzsXbTtJABDUZ46bxfb22QcjBBASgpJUpcxhUmwmZP9GUrELnPuPTvdTeW014AYk0/qBycI3+WPhO/pUI63UUIIxCIQpTeOSlfHLYZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708909608; c=relaxed/simple;
	bh=SEXPvnaY7yd34ru/qiOeLlmHyc5xD9+6IPA0q8XSUK4=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=F0TtZiv64lI3Sw24fvgQnLcC/LHSusyqALS4rJ+/f4u2AeELDvYeYALtcAZAM1F1Z3lbpxV5vkVRwUdJvsX2NpJFtOco2bRXyr9Mz9wYd7F4oATz4doEPK2e0HpTKBQZ3uego3iQgUUDXwuQQ6kgswO2CoI3E/jFtQCGdJ+N/Jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Tjj8N4PHwz1xpNJ;
	Mon, 26 Feb 2024 09:05:08 +0800 (CST)
Received: from kwepemm600003.china.huawei.com (unknown [7.193.23.202])
	by mail.maildlp.com (Postfix) with ESMTPS id 2EAC214040F;
	Mon, 26 Feb 2024 09:06:36 +0800 (CST)
Received: from [10.67.111.205] (10.67.111.205) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 26 Feb 2024 09:06:35 +0800
Subject: Re: [PATCH v2] hwtracing: hisi_ptt: Move type check to the beginning
 of hisi_ptt_pmu_event_init()
To: Suzuki Poulouse <suzuki.poulose@arm.com>
CC: <wangkefeng.wang@huawei.com>, <yangyicong@huawei.com>,
	<yangyicong@hisilicon.com>, <jonathan.cameron@huawei.com>,
	<alexander.shishkin@linux.intel.com>, <mathieu.poirier@linaro.org>,
	<john.garry@huawei.com>, <linux-kernel@vger.kernel.org>
References: <20240108121906.3514820-1-yangjihong1@huawei.com>
From: Yang Jihong <yangjihong1@huawei.com>
Message-ID: <979bdbe5-f01a-dfa8-6550-0f684d8f3b08@huawei.com>
Date: Mon, 26 Feb 2024 09:06:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240108121906.3514820-1-yangjihong1@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600003.china.huawei.com (7.193.23.202)

Hello,

PING.

Thanks,
Yang

On 2024/1/8 20:19, Yang Jihong wrote:
> When perf_init_event() calls perf_try_init_event() to init pmu driver,
> searches for the next pmu driver only when the return value is -ENOENT.
> Therefore, hisi_ptt_pmu_event_init() needs to check the type at the
> beginning of the function.
> Otherwise, in the case of perf-task mode, perf_try_init_event() returns
> -EOPNOTSUPP and skips subsequent pmu drivers, causes perf_init_event() to
> fail.
> 
> Fixes: ff0de066b463 ("hwtracing: hisi_ptt: Add trace function support for HiSilicon PCIe Tune and Trace device")
> Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
> ---
> 
> Changes since v1:
>   - Add fixes tag.
> 
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
> 

