Return-Path: <linux-kernel+bounces-105729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EE1587E38E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 07:06:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E3C91C2069E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 06:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D201249EB;
	Mon, 18 Mar 2024 06:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="fYM4gLlY"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E94FD28E11;
	Mon, 18 Mar 2024 06:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710741940; cv=none; b=mjxw8RSiv6bfkGJ/WORepVuA+aTo9vIrsdEMF6jQDo3wlvlBEQs6uidl4VN3wBkzCUwz6q5nL1BZm0TwPYUvuMGKdnGtOTJnIS2aWVBeR4VgfEn6jobvzxxNFWeJBDLsWmFoAxvqNIWS1uupUiQb3Gnqx+jev2LkpnGdXQOJWac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710741940; c=relaxed/simple;
	bh=k+1F4DGdkmIP5BKndrQeSdoViUYt0iKqzHFCr1rNXyE=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PTvfQfc/v87KyHZMYu7VLntHws1IvVBDsC3EIpptVG4l8XW9brrrASBE2RqukbSz/gN6Peo0sPPqImgIB1/RDWtY1/JXroWNkU8R8AfmNoyEBoks7DOs/upQrQdj2u6YQNhHIYh1PNLYOcuqifkj7p/qzQH2WZm+Rp06BBMHylo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=fYM4gLlY; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 42I65ICW118987;
	Mon, 18 Mar 2024 01:05:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1710741919;
	bh=fV9zpmrpCZiHMRmbkTtXXxqdU1tu4LBt/7BJp3jTS+0=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=fYM4gLlYWsh3CUC9Kco8/NZIZufuOsaLtV032G5E499q00xPWdJOYVR2D0vI4WQSY
	 KUkBBgb8uq0PKlbsakTJiQQdj37O8gnsL6ZwkJrkzU/nFi0cshM9iCNkJjq1Jdzr5g
	 rp91az2dtMZmApqTzgtB3RA7j9MkKhWUmS1gj+Ig=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 42I65IpT024513
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 18 Mar 2024 01:05:18 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 18
 Mar 2024 01:05:18 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 18 Mar 2024 01:05:18 -0500
Received: from localhost (dhruva.dhcp.ti.com [172.24.227.68])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 42I65HB3095934;
	Mon, 18 Mar 2024 01:05:18 -0500
Date: Mon, 18 Mar 2024 11:35:17 +0530
From: Dhruva Gole <d-gole@ti.com>
To: Jagadeesh Kona <quic_jkona@quicinc.com>
CC: "Rafael J . Wysocki" <rafael@kernel.org>,
        Kevin Hilman
	<khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>, Pavel Machek
	<pavel@ucw.cz>,
        Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad
 Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette
	<mturquette@baylibre.com>,
        Andy Gross <agross@kernel.org>, Stephen Boyd
	<sboyd@kernel.org>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Vikash
 Garodia <quic_vgarodia@quicinc.com>,
        "Bryan O'Donoghue"
	<bryan.odonoghue@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Abel Vesa
	<abel.vesa@linaro.org>, Taniya Das <quic_tdas@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-media@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, Imran Shaik <quic_imrashai@quicinc.com>,
        Ajit
 Pandey <quic_ajipan@quicinc.com>
Subject: Re: [PATCH V5 2/5] PM: domains: Add the domain HW-managed mode to
 the summary
Message-ID: <20240318060517.d3cq4thijjp55xd6@dhruva>
References: <20240315111046.22136-1-quic_jkona@quicinc.com>
 <20240315111046.22136-3-quic_jkona@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240315111046.22136-3-quic_jkona@quicinc.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On Mar 15, 2024 at 16:40:43 +0530, Jagadeesh Kona wrote:
> From: Abel Vesa <abel.vesa@linaro.org>
> 
> Now that genpd supports dynamically switching the control for an
> attached device between hardware- and software-mode,  let's add this
> information to the genpd summary in debugfs.

"under managed by column" would be good to add as well

> 
> Suggested-by: Taniya Das <quic_tdas@quicinc.com>
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> Signed-off-by: Jagadeesh Kona <quic_jkona@quicinc.com>
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Reviewed-by: Bjorn Andersson <andersson@kernel.org>
> ---
>  drivers/pmdomain/core.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
> index 70d8634dd9e8..18a101215c9c 100644
> --- a/drivers/pmdomain/core.c
> +++ b/drivers/pmdomain/core.c
> @@ -3173,6 +3173,15 @@ static void rtpm_status_str(struct seq_file *s, struct device *dev)
>  	seq_printf(s, "%-25s  ", p);
>  }
>  
> +static void mode_status_str(struct seq_file *s, struct device *dev)
> +{
> +	struct generic_pm_domain_data *gpd_data;
> +
> +	gpd_data = to_gpd_data(dev->power.subsys_data->domain_data);
> +
> +	seq_printf(s, "%20s", gpd_data->hw_mode ? "HW" : "SW");
> +}
> +
>  static void perf_status_str(struct seq_file *s, struct device *dev)
>  {
>  	struct generic_pm_domain_data *gpd_data;
> @@ -3231,6 +3240,7 @@ static int genpd_summary_one(struct seq_file *s,
>  		seq_printf(s, "\n    %-50s  ", kobj_path);
>  		rtpm_status_str(s, pm_data->dev);
>  		perf_status_str(s, pm_data->dev);
> +		mode_status_str(s, pm_data->dev);
>  		kfree(kobj_path);
>  	}
>  
> @@ -3247,8 +3257,8 @@ static int summary_show(struct seq_file *s, void *data)
>  	int ret = 0;
>  
>  	seq_puts(s, "domain                          status          children                           performance\n");
> -	seq_puts(s, "    /device                                             runtime status\n");
> -	seq_puts(s, "----------------------------------------------------------------------------------------------\n");
> +	seq_puts(s, "    /device                                             runtime status                           managed by\n");
> +	seq_puts(s, "------------------------------------------------------------------------------------------------------------\n");

LGTM,

Reviewed-by: Dhruva Gole <d-gole@ti.com>

-- 
Best regards,
Dhruva Gole <d-gole@ti.com>

