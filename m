Return-Path: <linux-kernel+bounces-104067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CB7787C887
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 06:29:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 248BEB22B04
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 05:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 409E2101E6;
	Fri, 15 Mar 2024 05:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="fQb/pU1N"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1353DF51;
	Fri, 15 Mar 2024 05:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710480534; cv=none; b=sERd+RqRE/PlxOUYD4YjlIelBGoAYs9uYs0PBLhQaCmZ/jKBLpzeOg1K0NSS2YQsmzi+gImDB/oCfLQstva0D9PlDpSYJCw2kgds8tN3RcSK0DevekAK9atXjzFpmGOtENajNkn2nytsg6JKRi5QVgetHZCYJPPFLeSHUejPsH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710480534; c=relaxed/simple;
	bh=/xPxAzCyhJN43wEXC0maiJE/UWoPU0LwRgLXzSrXbZA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K/i/J7v91wjHeseCwSJ/84NKg6t4e+kF5NZqXPNcW2Jd0eH36Sjz73zZ6h7u1ei6PJVFFiMPE6z0Wgv5oMZ16OInkTjgRqwB9fm4YbzwbhWqbGeQT7TkttFN1W8jI/f7ksn7QJxcCfsJa3ehTKAa0okEJ0/L9or0FchRrXl0mXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=fQb/pU1N; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 42F5Rwhl009845;
	Fri, 15 Mar 2024 00:27:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1710480478;
	bh=/6G2n4e8p7C1eVE+gmMKGmm9QowQsFFL9iknvi5QMHI=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=fQb/pU1NAsoTLsgzpPTYk2XWYXulJ99R6WCw3e34GECDrhUBQ6BO49OWv5qEJGnjA
	 SpQtQ5nSGo3YFBtNzRyvsu7DhL90Kc2PkXerMTJ9y0PLuKclkcg/wkWxdvSc/jYCjC
	 et51MitlsDTSiRv1gYorkmu0FUDm0MjMG9kM8MCo=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 42F5Rw58005758
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 15 Mar 2024 00:27:58 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 15
 Mar 2024 00:27:57 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 15 Mar 2024 00:27:58 -0500
Received: from localhost (dhruva.dhcp.ti.com [172.24.227.68])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 42F5RvAV037118;
	Fri, 15 Mar 2024 00:27:57 -0500
Date: Fri, 15 Mar 2024 10:57:56 +0530
From: Dhruva Gole <d-gole@ti.com>
To: Marek Szyprowski <m.szyprowski@samsung.com>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, <linux-arm-kernel@lists.infradead.org>,
        "Rafael J.
 Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Stephan
 Gerhold <stephan@gerhold.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Christoph Lameter <cl@gentwo.org>,
        Mark
 Rutland <mark.rutland@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>, Will
 Deacon <will@kernel.org>,
        <stable@vger.kernel.org>
Subject: Re: [PATCH] cpufreq: dt: always allocate zeroed cpumask
Message-ID: <20240315052756.5w4zizrod3w7kzzn@dhruva>
References: <CGME20240314125628eucas1p161af377a50fd957f445397bc1404978b@eucas1p1.samsung.com>
 <20240314125457.186678-1-m.szyprowski@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240314125457.186678-1-m.szyprowski@samsung.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On Mar 14, 2024 at 13:54:57 +0100, Marek Szyprowski wrote:
> Commit 0499a78369ad ("ARM64: Dynamically allocate cpumasks and increase
> supported CPUs to 512") changed the handling of cpumasks on ARM 64bit,
> what resulted in the strange issues and warnings during cpufreq-dt
> initialization on some big.LITTLE platforms.
> 
> This was caused by mixing OPPs between big and LITTLE cores, because
> OPP-sharing information between big and LITTLE cores is computed on
> cpumask, which in turn was not zeroed on allocation. Fix this by
> switching to zalloc_cpumask_var() call.
> 
> Fixes: dc279ac6e5b4 ("cpufreq: dt: Refactor initialization to handle probe deferral properly")
> CC: stable@vger.kernel.org # v5.10+
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  drivers/cpufreq/cpufreq-dt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
> index 8bd6e5e8f121..2d83bbc65dd0 100644
> --- a/drivers/cpufreq/cpufreq-dt.c
> +++ b/drivers/cpufreq/cpufreq-dt.c
> @@ -208,7 +208,7 @@ static int dt_cpufreq_early_init(struct device *dev, int cpu)
>  	if (!priv)
>  		return -ENOMEM;
>  
> -	if (!alloc_cpumask_var(&priv->cpus, GFP_KERNEL))
> +	if (!zalloc_cpumask_var(&priv->cpus, GFP_KERNEL))
>  		return -ENOMEM;

Good catch!

Reviewed-by: Dhruva Gole <d-gole@ti.com>


-- 
Best regards,
Dhruva

