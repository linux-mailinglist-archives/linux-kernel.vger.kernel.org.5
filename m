Return-Path: <linux-kernel+bounces-56123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D636684C64E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 09:34:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03A0C1C2455A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 08:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACAF2208BE;
	Wed,  7 Feb 2024 08:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="dJPIS7oK"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 453F320326;
	Wed,  7 Feb 2024 08:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707294825; cv=none; b=OyHWWyM/aKIAnf+B4jKuzqEydazPIH8LgGdtQSoUZEEVFStZ/0W/EPdWVsjjvK6xNHi3GJl6+QzLaHoHAQJqn7IoCPuavsu0A2rcg1hM4fhc62gsSmSG3hKzjL4btihbBxV4JOXVr2Ia+Wq5s7/WVT+RehzzfZp8G1Hqqr0XqPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707294825; c=relaxed/simple;
	bh=7ztvdRUg0JACfXTIoiFoaH+96vgsr4rkkIQHFzepryM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C3MlOOCENiWSlDCHDx73vMYms15brpDuPTiVK54bE1y0Yl763YnkKT8AG2W6a+10dIVtwiHbJboVJqnhPdZRotxtDf2+LvZzmFHbzUrpOQR7Wg2AR/VTyhK7a0LucHz2pY+HHbm7AKGdVHJeKxiIZBrH2mg7JP0Bn8WbA2xnJ14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=dJPIS7oK; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4178XZYh059943;
	Wed, 7 Feb 2024 02:33:35 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707294815;
	bh=M4eUFAdAMgTey1JPDnTkYph1/oLKlhyx10HZpCpSf/0=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=dJPIS7oKmbvX9rCBikNzTVMrbpoo+sq2FUSr/RcyZ6nauYAMLpbX73e56wFmmiYBQ
	 c+pPMkOaNtVXdOdGHzWbc6z5nHafpy8C1Q+n2qAljW/wytkaOEeTkPC0SrLYxCMQVg
	 2Ezu3OmtfQKpSab0VYprhRi444swe6JO9W3Y2D18=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4178XYNE054235
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 7 Feb 2024 02:33:35 -0600
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 7
 Feb 2024 02:33:34 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 7 Feb 2024 02:33:34 -0600
Received: from localhost (dhruva.dhcp.ti.com [172.24.227.68])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4178XXrm063412;
	Wed, 7 Feb 2024 02:33:34 -0600
Date: Wed, 7 Feb 2024 14:03:33 +0530
From: Dhruva Gole <d-gole@ti.com>
To: =?utf-8?B?VGjDqW8=?= Lebrun <theo.lebrun@bootlin.com>
CC: Mark Brown <broonie@kernel.org>, Apurva Nandan <a-nandan@ti.com>,
        <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Gregory CLEMENT
	<gregory.clement@bootlin.com>,
        Vladimir Kondratiev
	<vladimir.kondratiev@mobileye.com>,
        Thomas Petazzoni
	<thomas.petazzoni@bootlin.com>,
        Tawfik Bayouk <tawfik.bayouk@mobileye.com>
Subject: Re: [PATCH v2 1/4] spi: cadence-qspi: put runtime in runtime PM
 hooks names
Message-ID: <20240207083333.jqghhzihzwz5yeeq@dhruva>
References: <20240205-cdns-qspi-pm-fix-v2-0-2e7bbad49a46@bootlin.com>
 <20240205-cdns-qspi-pm-fix-v2-1-2e7bbad49a46@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240205-cdns-qspi-pm-fix-v2-1-2e7bbad49a46@bootlin.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On Feb 05, 2024 at 15:57:29 +0100, Théo Lebrun wrote:
> Follow kernel naming convention with regards to power-management
> callback function names.
> 
> The convention in the kernel is:
>  - prefix_suspend means the system-wide suspend callback;
>  - prefix_runtime_suspend means the runtime PM suspend callback.
> The same applies to resume callbacks.
> 
> Fixes: 0578a6dbfe75 ("spi: spi-cadence-quadspi: add runtime pm support")

Not sure if it's a bug as such since there's no functional change other
than renaming.

> Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
> ---
>  drivers/spi/spi-cadence-quadspi.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
> index 74647dfcb86c..720b28d2980c 100644
> --- a/drivers/spi/spi-cadence-quadspi.c
> +++ b/drivers/spi/spi-cadence-quadspi.c
> @@ -1927,7 +1927,7 @@ static void cqspi_remove(struct platform_device *pdev)
>  	pm_runtime_disable(&pdev->dev);
>  }
>  
> -static int cqspi_suspend(struct device *dev)
> +static int cqspi_runtime_suspend(struct device *dev)
>  {
>  	struct cqspi_st *cqspi = dev_get_drvdata(dev);
>  	struct spi_controller *host = dev_get_drvdata(dev);
> @@ -1941,7 +1941,7 @@ static int cqspi_suspend(struct device *dev)
>  	return ret;
>  }
>  
> -static int cqspi_resume(struct device *dev)
> +static int cqspi_runtime_resume(struct device *dev)
>  {
>  	struct cqspi_st *cqspi = dev_get_drvdata(dev);
>  	struct spi_controller *host = dev_get_drvdata(dev);
> @@ -1956,8 +1956,8 @@ static int cqspi_resume(struct device *dev)
>  	return spi_controller_resume(host);
>  }
>  
> -static DEFINE_RUNTIME_DEV_PM_OPS(cqspi_dev_pm_ops, cqspi_suspend,
> -				 cqspi_resume, NULL);
> +static DEFINE_RUNTIME_DEV_PM_OPS(cqspi_dev_pm_ops, cqspi_runtime_suspend,
> +				 cqspi_runtime_resume, NULL);
>  


No objections as such,
Reviewed-by: Dhruva Gole <d-gole@ti.com>

-- 
Best regards,
Dhruva Gole <d-gole@ti.com>

