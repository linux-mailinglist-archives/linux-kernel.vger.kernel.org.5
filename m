Return-Path: <linux-kernel+bounces-62072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D9E45851B0A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 18:15:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 152A81C22C1F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 17:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B32C33F9EF;
	Mon, 12 Feb 2024 17:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="S3xJSVsW"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F143F9D6;
	Mon, 12 Feb 2024 17:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707758002; cv=none; b=QqoSWecVzbzD1RYquL3tQgPMQ2gWHBIqy8wVQQ8GOkqjiehdn6VByg48tAibEcJl7t/qtSX9a3MjF8xRTlJRyOUPImMk3nMPSEw4SwAKUH/W8LirSASuquHHH7xbZhPCGcvb0Ks6goQxDAf5rCf+KU88GeGgkuJiBuBl8DKd9xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707758002; c=relaxed/simple;
	bh=dsbr0JzI0K/C/i8Mp3MJyf2UUlU1fv5w1ZItT9s5p/w=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ZQileVRnBT2k9GIdDgIStTWB3rX+03Vv25BsYlDINmAJTiIp9fOGaSWkrnUR7e3eP0LUpnVRmlINIIFvncltoS+sO/6fvkUR9UIWhZd+QCDTvVc8p2vTKjM/tWv7Rx6Jba4J2pFX7PKTseAq2ZN6MHOJLucI3v+PcsCiVpXkHU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=S3xJSVsW; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41CHDH25083309;
	Mon, 12 Feb 2024 11:13:17 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707757997;
	bh=/goh5bYm7kak+eE/3tyXMap6BlROBx5h/vGSs9PbcH0=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=S3xJSVsW6F2E3UY/Vd3qwpYmUEc5WJexYw6n4XTmh+E7naY/aH2D10M+H2MecsQyJ
	 xo1F/vHMQ6AjImywxzCyMBJLyX8EBd4aQLxj01hho4teSlrZoGo/apdNctTa8IPeyg
	 bVJtK14k+o6bxJGb5+dffPcxyImSpdoaObLXn0uk=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41CHDH7k093690
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 12 Feb 2024 11:13:17 -0600
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 12
 Feb 2024 11:13:16 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 12 Feb 2024 11:13:16 -0600
Received: from [10.249.42.149] ([10.249.42.149])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41CHDG5l025075;
	Mon, 12 Feb 2024 11:13:16 -0600
Message-ID: <ccd51fa3-d944-42c3-9915-6c4fbe2b78a6@ti.com>
Date: Mon, 12 Feb 2024 11:13:16 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/7] mmc: sdhci_am654: Write ITAPDLY for DDR52 timing
Content-Language: en-US
To: Judith Mendez <jm@ti.com>, Ulf Hansson <ulf.hansson@linaro.org>
CC: Adrian Hunter <adrian.hunter@intel.com>, <linux-mmc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20240207011520.3128382-1-jm@ti.com>
 <20240207011520.3128382-3-jm@ti.com>
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20240207011520.3128382-3-jm@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 2/6/24 7:15 PM, Judith Mendez wrote:
> For DDR52 timing, DLL is enabled but tuning is not carried
> out, therefore the ITAPDLY value in PHY CTRL 4 register is
> not correct. Fix this by writing ITAPDLY after enabling DLL.
> 
> Fixes: a161c45f2979 ("mmc: sdhci_am654: Enable DLL only for some speed modes")
> Signed-off-by: Judith Mendez <jm@ti.com>
> ---
> Changelog:
> v1->v2:
> - Call sdhci_am654_write_itapdly() in sdhci_am654_set_clock()
>   instead of sdhci_am654_setup_dll()
> ---
>   drivers/mmc/host/sdhci_am654.c | 1 +
>   1 file changed, 1 insertion(+)

See how much easier this patch is this way :)

Reviewed-by: Andrew Davis <afd@ti.com>

> 
> diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
> index 2c66a965c225..b50db5d4a452 100644
> --- a/drivers/mmc/host/sdhci_am654.c
> +++ b/drivers/mmc/host/sdhci_am654.c
> @@ -299,6 +299,7 @@ static void sdhci_am654_set_clock(struct sdhci_host *host, unsigned int clock)
>   
>   	if (timing > MMC_TIMING_UHS_SDR25 && clock >= CLOCK_TOO_SLOW_HZ) {
>   		sdhci_am654_setup_dll(host, clock);
> +		sdhci_am654_write_itapdly(sdhci_am654, sdhci_am654->itap_del_sel[timing]);
>   		sdhci_am654->dll_enable = true;
>   	} else {
>   		sdhci_am654_setup_delay_chain(sdhci_am654, timing);

