Return-Path: <linux-kernel+bounces-48795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE2E7846192
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 20:57:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A7091C26987
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 19:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E753285620;
	Thu,  1 Feb 2024 19:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Rga2t7da"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73CA343AC7;
	Thu,  1 Feb 2024 19:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706817433; cv=none; b=O3zOONPgM09wSwOgdOwxnvUP34tNOd4I/4ZyW0p7eZI63HTqLwthy6U+HzUDoYvl90biSIj3q6pP8WsHc02c2z8ZicowSbXcRwpvOoDnRitAgxDV5tryw38sieDK78GrHsOzVuLL99Bzm2nm3iILATP3vNWNCKu0M+b0m2bVl3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706817433; c=relaxed/simple;
	bh=ol9N1lJCePXG9KbFQml9LFiQXcpHsS3l0tt3C7TW5L8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=SrqErZDeLhPtmdL5Zpkpi/owoal+Du0VS8Pjfze5+x4R/h1N5PNVfkVe87kfvqOBnjvcqF0iIzWOXfgmytAImj3cqG7yutkj1Yo9OrrgZvTeSdgHsPz7RijyXaUANUL8bi5FRYKOeiYXaOVHKzC/tj7Y4TlZ5RFp7PD05HbkhhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Rga2t7da; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 411Jv8gA088108;
	Thu, 1 Feb 2024 13:57:08 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706817428;
	bh=hE1/l4zMpnxYPVqEXqNT5s0ss+mbTkIpn37KX3goCCs=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=Rga2t7daQZ1QrUzv+pR/2mLGpLqYl32VvcaMwaGOH5Ce6SbegbZ3mu8CJtzQQQziz
	 JFN/784L5R7wBFAoMIAPgmvvaagQMtyrh8c0eWoXtSwR5BSOsofdajALA2T+Iv/glT
	 NLBapuF0yXNuXSuCalceV+X1+0eKnixwNSeF4MjE=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 411Jv8rY116300
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 1 Feb 2024 13:57:08 -0600
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 1
 Feb 2024 13:57:08 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 1 Feb 2024 13:57:08 -0600
Received: from [10.249.42.149] ([10.249.42.149])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 411Jv7ks076716;
	Thu, 1 Feb 2024 13:57:07 -0600
Message-ID: <7c40a415-f2d5-4a39-8c7e-7e7a05e0bdb3@ti.com>
Date: Thu, 1 Feb 2024 13:57:07 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 4/5] mmc: sdhci_am654: Add ITAPDLYSEL in
 sdhci_j721e_4bit_set_clock
Content-Language: en-US
To: Judith Mendez <jm@ti.com>, Ulf Hansson <ulf.hansson@linaro.org>
CC: Adrian Hunter <adrian.hunter@intel.com>, <linux-mmc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Randolph Sapp <rs@ti.com>,
        Vignesh
 Raghavendra <vigneshr@ti.com>
References: <20240131215044.3163469-1-jm@ti.com>
 <20240131215044.3163469-5-jm@ti.com>
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20240131215044.3163469-5-jm@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 1/31/24 3:50 PM, Judith Mendez wrote:
> Add ITAPDLYSEL to sdhci_j721e_4bit_set_clock function.
> This allows to set the correct ITAPDLY for timings that
> do not carry out tuning.
> 
> Fixes: 1accbced1c32 ("mmc: sdhci_am654: Add Support for 4 bit IP on J721E")

You are adding this as a new feature, and not having a feature doesn't mean
the initial patch was broken. If this patch was backported to kernels only
containing the above patch it would cause more issues, so no need for the
fixes tags on this nor the last patch.

Andrew

> Signed-off-by: Judith Mendez <jm@ti.com>
> ---
>   drivers/mmc/host/sdhci_am654.c | 10 ++++++++--
>   1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
> index 5ac82bc70706..f5dc981c470d 100644
> --- a/drivers/mmc/host/sdhci_am654.c
> +++ b/drivers/mmc/host/sdhci_am654.c
> @@ -321,6 +321,7 @@ static void sdhci_j721e_4bit_set_clock(struct sdhci_host *host,
>   	unsigned char timing = host->mmc->ios.timing;
>   	u32 otap_del_sel;
>   	u32 itap_del_ena;
> +	u32 itap_del_sel;
>   	u32 mask, val;
>   
>   	/* Setup Output TAP delay */
> @@ -329,12 +330,17 @@ static void sdhci_j721e_4bit_set_clock(struct sdhci_host *host,
>   	mask = OTAPDLYENA_MASK | OTAPDLYSEL_MASK;
>   	val = (0x1 << OTAPDLYENA_SHIFT) | (otap_del_sel << OTAPDLYSEL_SHIFT);
>   
> +	/* Setup Input TAP delay */
>   	itap_del_ena = sdhci_am654->itap_del_ena[timing];
> +	itap_del_sel = sdhci_am654->itap_del_sel[timing];
>   
> -	mask |= ITAPDLYENA_MASK;
> -	val |= (itap_del_ena << ITAPDLYENA_SHIFT);
> +	mask |= ITAPDLYENA_MASK | ITAPDLYSEL_MASK;
> +	val |= (itap_del_ena << ITAPDLYENA_SHIFT) | (itap_del_sel << ITAPDLYSEL_SHIFT);
>   
> +	regmap_update_bits(sdhci_am654->base, PHY_CTRL4, ITAPCHGWIN_MASK,
> +			   1 << ITAPCHGWIN_SHIFT);
>   	regmap_update_bits(sdhci_am654->base, PHY_CTRL4, mask, val);
> +	regmap_update_bits(sdhci_am654->base, PHY_CTRL4, ITAPCHGWIN_MASK, 0);
>   
>   	regmap_update_bits(sdhci_am654->base, PHY_CTRL5, CLKBUFSEL_MASK,
>   			   sdhci_am654->clkbuf_sel);

