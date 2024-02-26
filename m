Return-Path: <linux-kernel+bounces-81276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C0E2F86733D
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 12:36:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A03828327D
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 11:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF9144D9F2;
	Mon, 26 Feb 2024 11:34:38 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 055594D9EA
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 11:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708947278; cv=none; b=Apqz37Ha3ZTg8Hk/V5J3hoBhFy0uqB7ehgGDOviHJS6zIE2kXpnfCXsvwUMW1s52v6sciPQXb6sQ1A2a7WyfGL1GZffzCEe30GYk55J6UCNd+idfNkqkYKp+H8rhYQk8l6Ld7WYXcWlvf2BTHCddRAunvvxkLNRrNKirCPo+BGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708947278; c=relaxed/simple;
	bh=lVfwInokKgU+vNjt3JKMIiKWDwiPGiObIbVaKwcKRHs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=FR4Bg4giySbkOjLfo5iRx0azSuPUPKIRD8iIxCfK2lKf8p07kipD9hyim+AkzGby4FYNG3rs1/1bZDJphqrb0GLv9cbEHdE/L/NcROEhtyA6Sx2OSYeMVDVFpzKyAFbU1jIhTmOavwQOg+P++Llqi3MLDp7zbi2f9D5SxfN1M04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Tjz4x1V1nz1xpSx;
	Mon, 26 Feb 2024 19:33:05 +0800 (CST)
Received: from kwepemd200005.china.huawei.com (unknown [7.221.188.238])
	by mail.maildlp.com (Postfix) with ESMTPS id 3CB0F1A0172;
	Mon, 26 Feb 2024 19:34:33 +0800 (CST)
Received: from kwepemd200013.china.huawei.com (7.221.188.133) by
 kwepemd200005.china.huawei.com (7.221.188.238) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Mon, 26 Feb 2024 19:34:32 +0800
Received: from [10.67.110.108] (10.67.110.108) by
 kwepemd200013.china.huawei.com (7.221.188.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1258.28; Mon, 26 Feb 2024 19:34:32 +0800
Message-ID: <c48aa5ff-8bce-52d7-6f52-ec18b74620d7@huawei.com>
Date: Mon, 26 Feb 2024 19:34:31 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v2] time: Use div64_ul() instead of do_div()
To: Thorsten Blum <thorsten.blum@toblux.com>
CC: <anna-maria@linutronix.de>, <frederic@kernel.org>, <jstultz@google.com>,
	<linux-kernel@vger.kernel.org>, <peterz@infradead.org>, <tglx@linutronix.de>
References: <E2A9A6AE-84F4-4C86-80CA-CC0C480FD9A8@toblux.com>
 <20240226090305.117120-2-thorsten.blum@toblux.com>
From: "Liao, Chang" <liaochang1@huawei.com>
In-Reply-To: <20240226090305.117120-2-thorsten.blum@toblux.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemd200013.china.huawei.com (7.221.188.133)



在 2024/2/26 17:03, Thorsten Blum 写道:
> Fixes Coccinelle/coccicheck warning reported by do_div.cocci.
> 
> Compared to do_div(), div64_ul() does not implicitly cast the divisor and
> does not unnecessarily calculate the remainder.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
> ---
> Changes in v2:
> - s/div64_long/div64_ul/ as suggested by Chang Liao
> ---
>  kernel/time/jiffies.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/time/jiffies.c b/kernel/time/jiffies.c
> index bc4db9e5ab70..fccee15e94d5 100644
> --- a/kernel/time/jiffies.c
> +++ b/kernel/time/jiffies.c
> @@ -91,7 +91,7 @@ int register_refined_jiffies(long cycles_per_second)
>  	/* shift_hz stores hz<<8 for extra accuracy */
>  	shift_hz = (u64)cycles_per_second << 8;
>  	shift_hz += cycles_per_tick/2;
> -	do_div(shift_hz, cycles_per_tick);
> +	shift_hz = div64_ul(shift_hz, cycles_per_tick);

LGTM

Reviewed-by: Liao Chang <liaochang1@huawei.com>

>  	/* Calculate nsec_per_tick using shift_hz */
>  	nsec_per_tick = (u64)NSEC_PER_SEC << 8;
>  	nsec_per_tick += (u32)shift_hz/2;

-- 
BR
Liao, Chang

