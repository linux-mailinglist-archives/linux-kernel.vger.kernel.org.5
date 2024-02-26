Return-Path: <linux-kernel+bounces-80468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D90778668C0
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 04:28:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F5841F21BBB
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 03:28:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43F401401B;
	Mon, 26 Feb 2024 03:28:49 +0000 (UTC)
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE72BC8C7
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 03:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708918128; cv=none; b=ESS47M1B80rNFqjtxvrvLIN1/MWZBcUh2FfTcfOMkkUT3XzMJdO+CZmdexcIB7JBAdvs5cZeTY0xACmXxA8RydBpMS8LUTrBpCwHyUGU+aSPXccXiT9OIWioVMr2ECDmFwzIn3QrFJY70hIVMEkG/Oed2k2/GlvRZ633a974stw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708918128; c=relaxed/simple;
	bh=Q9IMP5W6DExwGPIPuDXfsAR4MKCV2Ob7P/qKfk3D3tQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=T14duZddQ18L3zohsXcLJqA6V2hIsmP7MuS/24io2Z6wtBkli3IZ20sXn9UTpz2giZsoy+KIDL9rdjekKgWrxG02zle91o0XTQsTjr23jhUc1bqiJM5t0G2y2INyGLYsgknLrt6Hpb4fst2eKP4qSoU/8smSpMIWpBU4Eqz0Li0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4TjmHT5l5Cz1X3QC;
	Mon, 26 Feb 2024 11:26:29 +0800 (CST)
Received: from kwepemd500003.china.huawei.com (unknown [7.221.188.36])
	by mail.maildlp.com (Postfix) with ESMTPS id 212891400D4;
	Mon, 26 Feb 2024 11:28:43 +0800 (CST)
Received: from kwepemd200013.china.huawei.com (7.221.188.133) by
 kwepemd500003.china.huawei.com (7.221.188.36) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Mon, 26 Feb 2024 11:28:42 +0800
Received: from [10.67.110.108] (10.67.110.108) by
 kwepemd200013.china.huawei.com (7.221.188.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1258.28; Mon, 26 Feb 2024 11:28:42 +0800
Message-ID: <4bc9df7f-ea00-ad5e-02f0-d4cae6f005ad@huawei.com>
Date: Mon, 26 Feb 2024 11:28:41 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH] time: Use div64_long() instead of do_div()
To: Thorsten Blum <thorsten.blum@toblux.com>, <linux-kernel@vger.kernel.org>
CC: Thomas Gleixner <tglx@linutronix.de>, Anna-Maria Behnsen
	<anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>, "Peter
 Zijlstra" <peterz@infradead.org>, John Stultz <jstultz@google.com>
References: <20240225232541.17659-2-thorsten.blum@toblux.com>
From: "Liao, Chang" <liaochang1@huawei.com>
In-Reply-To: <20240225232541.17659-2-thorsten.blum@toblux.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemd200013.china.huawei.com (7.221.188.133)

Thorsten,

在 2024/2/26 7:25, Thorsten Blum 写道:
> Fixes Coccinelle/coccicheck warning reported by do_div.cocci.
> 
> Compared to do_div(), div64_long() does not implicitly cast the divisor and
> does not unnecessarily calculate the remainder.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
> ---
>  kernel/time/jiffies.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/time/jiffies.c b/kernel/time/jiffies.c
> index bc4db9e5ab70..9d23178e2b6a 100644
> --- a/kernel/time/jiffies.c
> +++ b/kernel/time/jiffies.c
> @@ -91,7 +91,7 @@ int register_refined_jiffies(long cycles_per_second)
>  	/* shift_hz stores hz<<8 for extra accuracy */
>  	shift_hz = (u64)cycles_per_second << 8;
>  	shift_hz += cycles_per_tick/2;
> -	do_div(shift_hz, cycles_per_tick);
> +	shift_hz = div64_long(shift_hz, cycles_per_tick);

I am considering using div64_ul() to calculate the result. as shift_hz is
unsigned long, assume the sign bit of divisor cycles_per_tick never be set
in this context,then div64_long() will do a extra sign extension for result.
Or are there other recommendations?

Thanks.

>  	/* Calculate nsec_per_tick using shift_hz */
>  	nsec_per_tick = (u64)NSEC_PER_SEC << 8;
>  	nsec_per_tick += (u32)shift_hz/2;

-- 
BR
Liao, Chang

