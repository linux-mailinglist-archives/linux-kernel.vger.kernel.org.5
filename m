Return-Path: <linux-kernel+bounces-61102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21964850D4A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 06:01:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54729B2430D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 05:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B23E566A;
	Mon, 12 Feb 2024 05:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="y22d1QJo"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA221848;
	Mon, 12 Feb 2024 05:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707714058; cv=none; b=T6rOYBxDcW/mExVJ0LyifQcUOZmcvYgfbdF+vg/umyU+bXFkYUlEgHSAQ6uU+lKe+39lJKJyWU+Rf0995JeeKXpSowI9f1VS0adiI8ob6E0OLI7Teh3ZSHwXy5ER5qTly6PB9EhAQmvbxaWUZ4b23/GrE4RpoblfN7TvCmU5udg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707714058; c=relaxed/simple;
	bh=UqWMj9uDHukL4DBYWfxcwU/fLexZUxvDVJJvOajLm9g=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BN8c77KIXcnnpqCNgFDqhuDe2WqEKu9Y0qoKZcspB++aFtkmavuQIdq1JZ0vNAQOAEm3wyMrXPfKyoKAMUQKC1meTglsS9deE1jB4QxzKq1ngBk/HrJGh0O3Wf6OgrRVOyxBtt8feAp1o4PrCG0qdctYa14mXASTP5FKb5q16Ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=y22d1QJo; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41C50aYJ017183;
	Sun, 11 Feb 2024 23:00:36 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707714036;
	bh=67vX1QhNKpfwzOCQ+Q1QAwvyUV1I31hXYBJPEruQMAE=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=y22d1QJoryw9QG669wBa8gxDoxyXcgThBWuiPq6hQ9izqvVDZCv8b3RAT5XJCXW0t
	 JD7rqOhHSE4H3O/2d0UNNkNfELy0tWktAAyxMgl/C5YcS/ZfIDc7ogG+DUrSoP0J3k
	 cnaXvxM6JK8sJn36JjSMd6GR6O86fPC/2P2PQyO8=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41C50aWm085042
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sun, 11 Feb 2024 23:00:36 -0600
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sun, 11
 Feb 2024 23:00:35 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sun, 11 Feb 2024 23:00:35 -0600
Received: from localhost (dhruva.dhcp.ti.com [172.24.227.68])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41C50ZYf030254;
	Sun, 11 Feb 2024 23:00:35 -0600
Date: Mon, 12 Feb 2024 10:30:34 +0530
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
Subject: Re: [PATCH v3 1/4] spi: cadence-qspi: fix pointer reference in
 runtime PM hooks
Message-ID: <20240212050034.ks7zdectyotcuh6t@dhruva>
References: <20240209-cdns-qspi-pm-fix-v3-0-540ac222f26b@bootlin.com>
 <20240209-cdns-qspi-pm-fix-v3-1-540ac222f26b@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240209-cdns-qspi-pm-fix-v3-1-540ac222f26b@bootlin.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Theo!

On Feb 09, 2024 at 14:55:50 +0100, Théo Lebrun wrote:
> dev_get_drvdata() gets used to acquire the pointer to cqspi and the SPI
> controller. Neither embed the other; this lead to memory corruption.
> 
> On a given platform (Mobileye EyeQ5) the memory corruption is hidden
> inside cqspi->f_pdata. Also, this uninitialised memory is used as a
> mutex (ctlr->bus_lock_mutex) by spi_controller_suspend().
> 
> Fixes: 2087e85bb66e ("spi: cadence-quadspi: fix suspend-resume implementations")
> Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
> ---
>  drivers/spi/spi-cadence-quadspi.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
> index 74647dfcb86c..d19ba024c80b 100644
> --- a/drivers/spi/spi-cadence-quadspi.c
> +++ b/drivers/spi/spi-cadence-quadspi.c
> @@ -1930,10 +1930,9 @@ static void cqspi_remove(struct platform_device *pdev)
>  static int cqspi_suspend(struct device *dev)
>  {
>  	struct cqspi_st *cqspi = dev_get_drvdata(dev);
> -	struct spi_controller *host = dev_get_drvdata(dev);
>  	int ret;
>  
> -	ret = spi_controller_suspend(host);
> +	ret = spi_controller_suspend(cqspi->host);
>  	cqspi_controller_enable(cqspi, 0);
>  
>  	clk_disable_unprepare(cqspi->clk);
> @@ -1944,7 +1943,6 @@ static int cqspi_suspend(struct device *dev)
>  static int cqspi_resume(struct device *dev)
>  {
>  	struct cqspi_st *cqspi = dev_get_drvdata(dev);
> -	struct spi_controller *host = dev_get_drvdata(dev);
>  
>  	clk_prepare_enable(cqspi->clk);
>  	cqspi_wait_idle(cqspi);
> @@ -1953,7 +1951,7 @@ static int cqspi_resume(struct device *dev)
>  	cqspi->current_cs = -1;
>  	cqspi->sclk = 0;
>  
> -	return spi_controller_resume(host);
> +	return spi_controller_resume(cqspi->host);

Looks good,
Reviewed-by: Dhruva Gole <d-gole@ti.com>


--
Best regards,
Dhruva Gole <d-gole@ti.com>

