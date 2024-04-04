Return-Path: <linux-kernel+bounces-131126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 08D04898361
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 10:46:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 372501C26F91
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 08:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA66371B3B;
	Thu,  4 Apr 2024 08:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="x3LnyKNw"
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDB0559B61;
	Thu,  4 Apr 2024 08:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712220399; cv=none; b=HqS8edkyjqPWWMIJoSSwO2Vfc5E/5MLiHkYXc16PAx5JFXxL9fz6szv7/lxlgfT5K/2CHOe/A+FXpPQKYBnn1fZNTgl3XI1DTxzbxcP/NLCzsgeOvU2uRUAy4Y7vNOVsFlIay0Flg9IdWb0BW1zNXCq3NVtgmt6FLlowcOvLx5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712220399; c=relaxed/simple;
	bh=ULy23BdVwOg3nM6dJBIocsCHWzDPBNYc7lsB3kTJzMw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pyEtYnJiVMy+tYiTkcq2aCyuzc0CtCPc1o1b+s02X98rjRSU2C4xg4Y1aFDSW7zhqfQefIqFywqTED/PrTuMA02Nexozf6wNpfNG+77E0sKNjZ3y93kHPoZjurKGtHv3dfABzJ6nELcKS+otMUeFLAkiFvsOlgZiCgSiI4XvvMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=x3LnyKNw; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1712220387; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=yN9NXHIIQrWMKDXF9lcAAvhHqGpWd7OG1nzyd2CnLSU=;
	b=x3LnyKNwevqaNsiZ/j9nzCSkb6I/mQl1HBz+lWGUtd+z19XqY/6gmmMNNsyHHZSoQ2HBT6z5DJdCGwfGGXMFo1vt1QzGWCAUMiYxQUdYCjwCHbNqqUwFbyg79I3yWjdCSbEM0G3DtTb4hzIOAMzxuKwJmF/wTQm0hZP4HPe0yyQ=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0W3u3LIx_1712220385;
Received: from 30.39.185.155(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0W3u3LIx_1712220385)
          by smtp.aliyun-inc.com;
          Thu, 04 Apr 2024 16:46:26 +0800
Message-ID: <0724c357-1d74-47b8-85cb-bf344eb4cc52@linux.alibaba.com>
Date: Thu, 4 Apr 2024 16:46:24 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH net-next v5 02/11] net/smc: introduce loopback-ism for
 SMC intra-OS shortcut
To: Gerd Bayer <gbayer@linux.ibm.com>, wintera@linux.ibm.com,
 twinkler@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
 agordeev@linux.ibm.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, wenjia@linux.ibm.com, jaka@linux.ibm.com
Cc: borntraeger@linux.ibm.com, svens@linux.ibm.com,
 alibuda@linux.alibaba.com, tonylu@linux.alibaba.com,
 linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
 netdev@vger.kernel.org
References: <20240324135522.108564-1-guwen@linux.alibaba.com>
 <20240324135522.108564-3-guwen@linux.alibaba.com>
 <a9e1cdfba05279c36b7b85f327af66cf497d42b9.camel@linux.ibm.com>
From: Wen Gu <guwen@linux.alibaba.com>
In-Reply-To: <a9e1cdfba05279c36b7b85f327af66cf497d42b9.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/4/3 19:27, Gerd Bayer wrote:
> On Sun, 2024-03-24 at 21:55 +0800, Wen Gu wrote:
>> Configuration of this feature is managed through the config SMC_LO.
> 
> Hi Wen,
> 
> you could omit building smc_loopback.o if CONFIG_SMC_LO was not set if
> you included the following fixup-patch. I think it's cleaner to put a
> few parts of net/smc/af_smc.c under conditional compile rather than
> have most of the contents of net/smc/smc_loopback.c under #ifdef.
> 

Hi Gerd. That is a really good suggestion. It is much cleaner in this way.
I will improve it in next version. Thank you very much!

>  From 11a9cfce550f0c4df10eafdd30aa4226d4d522a8 Mon Sep 17 00:00:00 2001
> From: Gerd Bayer <gbayer@linux.ibm.com>
> Date: Wed, 3 Apr 2024 11:43:36 +0200
> Subject: [PATCH] fixup! net/smc: introduce loopback-ism for SMC intra-
> OS
>   shortcut
> 
> ---
>   net/smc/Makefile       | 5 +++--
>   net/smc/af_smc.c       | 6 ++++++
>   net/smc/smc_loopback.c | 8 --------
>   3 files changed, 9 insertions(+), 10 deletions(-)
> 
> diff --git a/net/smc/Makefile b/net/smc/Makefile
> index a8c37111abe1..3b73c9d561bb 100644
> --- a/net/smc/Makefile
> +++ b/net/smc/Makefile
> @@ -4,5 +4,6 @@ obj-$(CONFIG_SMC)	+= smc.o
>   obj-$(CONFIG_SMC_DIAG)	+= smc_diag.o
>   smc-y := af_smc.o smc_pnet.o smc_ib.o smc_clc.o smc_core.o smc_wr.o
> smc_llc.o
>   smc-y += smc_cdc.o smc_tx.o smc_rx.o smc_close.o smc_ism.o
> smc_netlink.o smc_stats.o
> -smc-y += smc_tracepoint.o smc_loopback.o
> -smc-$(CONFIG_SYSCTL) += smc_sysctl.o
> +smc-y += smc_tracepoint.o
> +smc-$(CONFIG_SMC_LO)	+= smc_loopback.o
> +smc-$(CONFIG_SYSCTL)	+= smc_sysctl.o
> diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
> index fce7a5b2ce5c..bcbf600cd271 100644
> --- a/net/smc/af_smc.c
> +++ b/net/smc/af_smc.c
> @@ -3574,11 +3574,13 @@ static int __init smc_init(void)
>   		goto out_sock;
>   	}
>   
> +#if IS_ENABLED(CONFIG_SMC_LO)
>   	rc = smc_loopback_init();
>   	if (rc) {
>   		pr_err("%s: smc_loopback_init fails with %d\n",
> __func__, rc);
>   		goto out_ib;
>   	}
> +#endif
>   
>   	rc = tcp_register_ulp(&smc_ulp_ops);
>   	if (rc) {
> @@ -3590,8 +3592,10 @@ static int __init smc_init(void)
>   	return 0;
>   
>   out_lo:
> +#if IS_ENABLED(CONFIG_SMC_LO)
>   	smc_loopback_exit();
>   out_ib:
> +#endif
>   	smc_ib_unregister_client();
>   out_sock:
>   	sock_unregister(PF_SMC);
> @@ -3628,7 +3632,9 @@ static void __exit smc_exit(void)
>   	tcp_unregister_ulp(&smc_ulp_ops);
>   	sock_unregister(PF_SMC);
>   	smc_core_exit();
> +#if IS_ENABLED(CONFIG_SMC_LO)
>   	smc_loopback_exit();
> +#endif
>   	smc_ib_unregister_client();
>   	smc_ism_exit();
>   	destroy_workqueue(smc_close_wq);
> diff --git a/net/smc/smc_loopback.c b/net/smc/smc_loopback.c
> index 994fe39930ad..8d0181635ded 100644
> --- a/net/smc/smc_loopback.c
> +++ b/net/smc/smc_loopback.c
> @@ -19,7 +19,6 @@
>   #include "smc_ism.h"
>   #include "smc_loopback.h"
>   
> -#if IS_ENABLED(CONFIG_SMC_LO)
>   #define SMC_LO_V2_CAPABLE	0x1 /* loopback-ism acts as ISMv2 */
>   #define SMC_LO_SUPPORT_NOCOPY	0x1
>   #define SMC_DMA_ADDR_INVALID	(~(dma_addr_t)0)
> @@ -442,20 +441,13 @@ static void smc_lo_dev_remove(void)
>   	smc_lo_dev_exit(lo_dev);
>   	put_device(&lo_dev->dev); /* device_initialize in
> smc_lo_dev_probe */
>   }
> -#endif
>   
>   int smc_loopback_init(void)
>   {
> -#if IS_ENABLED(CONFIG_SMC_LO)
>   	return smc_lo_dev_probe();
> -#else
> -	return 0;
> -#endif
>   }
>   
>   void smc_loopback_exit(void)
>   {
> -#if IS_ENABLED(CONFIG_SMC_LO)
>   	smc_lo_dev_remove();
> -#endif
>   }

