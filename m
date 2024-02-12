Return-Path: <linux-kernel+bounces-61106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E971850D5C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 06:24:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D14081F24373
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 05:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1C6F613A;
	Mon, 12 Feb 2024 05:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Uq8BAV6z"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC15C12A;
	Mon, 12 Feb 2024 05:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707715488; cv=none; b=k6eLeuM48snCgYa69wX5y+V251XYj2jIKqVeqpYgb0zHesr3t9yvSQgNW1tjWjLD78zt2DPB+OrP6QkjXflo2iY4INEY/7AMe9E/K8D/fko0Y8VuXEd8YWtkU+FO/rqc0mQk9fkcg+xqydfxoXTp5bR7n/xdW4igwblteLAqut4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707715488; c=relaxed/simple;
	bh=nA6bRx9p8484xsE1w5FmfW4ys5rFwxKUV/WD7VpBGn8=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=opOyS2avm6hOl4u7KacVO+CbhwmxWaxNrrJqyvFmhtkSL/AV8+QxD30ppSYGZxr/NIOwCw7CPzPIdzneW1eLyIwWD0t+gM3jHmQjdpSqn7u99B0SsZd4QCKFXX2f9VxOv76IEGJVPQIRIHgnqX8/VXEiMDTLOc/bnaymWQCUu74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Uq8BAV6z; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41C5ObuT050823;
	Sun, 11 Feb 2024 23:24:37 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707715477;
	bh=7Hp6G/GdYyjOnzbjiVH1nN7uo7IlLichcM9tg8rvZtg=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=Uq8BAV6zjyfy6pN0eYb6wfpqDHIeK6qEuAsm7eeG8UVygg5bjRAaVTfRYch6i1IRV
	 +2Efb4JHVwiTgFPP6wHcMfgp3sCH5fXYTA6NdDi9BZkYs8D1LNhS55Q6axYr6bkHmU
	 axHiIo1eDJ5k47ERfMMAbtdXAq02zkQ6mDTWrayo=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41C5ObZl129248
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sun, 11 Feb 2024 23:24:37 -0600
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sun, 11
 Feb 2024 23:24:37 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sun, 11 Feb 2024 23:24:37 -0600
Received: from localhost (dhruva.dhcp.ti.com [172.24.227.68])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41C5OaGO067453;
	Sun, 11 Feb 2024 23:24:37 -0600
Date: Mon, 12 Feb 2024 10:54:35 +0530
From: Dhruva Gole <d-gole@ti.com>
To: =?utf-8?B?VGjDqW8=?= Lebrun <theo.lebrun@bootlin.com>
CC: Mark Brown <broonie@kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Gregory CLEMENT
	<gregory.clement@bootlin.com>,
        Vladimir Kondratiev
	<vladimir.kondratiev@mobileye.com>,
        Thomas Petazzoni
	<thomas.petazzoni@bootlin.com>,
        Tawfik Bayouk <tawfik.bayouk@mobileye.com>
Subject: Re: [PATCH 1/4] spi: cadence-qspi: assert each subnode flash CS is
 valid
Message-ID: <20240212052435.vpisjmqxoe4aff2f@dhruva>
References: <20240209-cdns-qspi-cs-v1-0-a4f9dfed9ab4@bootlin.com>
 <20240209-cdns-qspi-cs-v1-1-a4f9dfed9ab4@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240209-cdns-qspi-cs-v1-1-a4f9dfed9ab4@bootlin.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi,

On Feb 09, 2024 at 14:45:30 +0100, Théo Lebrun wrote:
> Check each flash CS against the num-cs property from devicetree.
> Fallback to the driver max supported value (CQSPI_MAX_CHIPSELECT) if
> num-cs isn't present.
> 
> cqspi->num_chipselect is set in cqspi_of_get_pdata() to the num-cs
> devicetree property, or to CQSPI_MAX_CHIPSELECT if num-cs is not set.

Makes sense,

> 
> Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
> ---
>  drivers/spi/spi-cadence-quadspi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
> index d44a0c501879..7ba4d5d16fd2 100644
> --- a/drivers/spi/spi-cadence-quadspi.c
> +++ b/drivers/spi/spi-cadence-quadspi.c
> @@ -1635,7 +1635,7 @@ static int cqspi_setup_flash(struct cqspi_st *cqspi)
>  			return ret;
>  		}
>  
> -		if (cs >= CQSPI_MAX_CHIPSELECT) {
> +		if (cs >= cqspi->num_chipselect) {

Reviewed-by: Dhruva Gole <d-gole@ti.com>


-- 
Best regards,
Dhruva Gole <d-gole@ti.com>

