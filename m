Return-Path: <linux-kernel+bounces-69033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD8B0858397
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 18:10:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73561286006
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 17:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DD35130E4F;
	Fri, 16 Feb 2024 17:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="wV+xkORD"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B741132461;
	Fri, 16 Feb 2024 17:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708103391; cv=none; b=WIb/+rwFhCcFW3RCkyAcjcY6gbY1wI+Qq1DRhxetEL+V/Tpi4VmOfkpn41H+doaEmwFICeRC/wuqOoBJduGjddYyT0sJgd++xdn/ZNi6iFAz4jTfAwEfrZjq1qDpolRnHoKEBPLOmreACBTJ3yg2Qha4tZEX3ZBFM7hWMZk7Ozo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708103391; c=relaxed/simple;
	bh=id7Qb0uLD+1WFfUYgcQvzLQnvah3UPDv2V4cZ0mna8E=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sFYiiQ6bz/u9r6SNIQ7cJAFv08R8shwM/wrMdE0U/sraletXRMEsPV+kkeB7qX8rS6eIuRZxVvuCZsoE0/CfcxLBx77HKlGZDhoRuHyeTOp+Jj7gltLpgeWkdoLmG5tWSrjayWhNFVuX+cpYziSOnpuIJ8JOKBGjY5ZNcPodDZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=wV+xkORD; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41GH9U7h032772;
	Fri, 16 Feb 2024 11:09:30 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1708103370;
	bh=O9tDOl2PHm42EpIYjzIon6CdzywBxeNsoi7ymBAtfvA=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=wV+xkORDStCjpVYjAzP9AQmpE5i4aJR8fYlxblNX4EBLsbs+K0SAOINCu0fnqIYFD
	 gmbxGYydVivu/SBtpWd5fMBzPERHI+UBgCisS90sUH/CRgFqtF27kX9ZWF5GTSZvwo
	 ruYkbzaCIAJUGSs9Nsz35cmtr/sPoDkZpkfZuwD4=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41GH9UG4126974
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 16 Feb 2024 11:09:30 -0600
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 16
 Feb 2024 11:09:30 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 16 Feb 2024 11:09:30 -0600
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41GH9Uhd066950;
	Fri, 16 Feb 2024 11:09:30 -0600
Date: Fri, 16 Feb 2024 11:09:30 -0600
From: Nishanth Menon <nm@ti.com>
To: Udit Kumar <u-kumar1@ti.com>
CC: <kristo@kernel.org>, <ssantosh@kernel.org>, <chandru@ti.com>,
        <rishabh@ti.com>, <kamlesh@ti.com>, <francesco@dolcini.it>,
        <vigneshr@ti.com>, <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-clk@vger.kernel.org>
Subject: Re: [PATCH v4] clk: keystone: sci-clk: Adding support for non
 contiguous clocks
Message-ID: <20240216170930.cp5rg2iieaqogrwa@selected>
References: <20240213082640.457316-1-u-kumar1@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240213082640.457316-1-u-kumar1@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 13:56-20240213, Udit Kumar wrote:
> Most of clocks and their parents are defined in contiguous range,
> But in few cases, there is gap in clock numbers[0].
> Driver assumes clocks to be in contiguous range, and add their clock
> ids incrementally.
> 
> New firmware started returning error while calling get_freq and is_on
> API for non-available clock ids.
> 
> In this fix, driver checks and adds only valid clock ids.
> 
> [0] https://software-dl.ti.com/tisci/esd/latest/5_soc_doc/j7200/clocks.html
> Section Clocks for NAVSS0_CPTS_0 Device, clock id 12-15 not present.
> 
> Fixes: 3c13933c6033 ("clk: keystone: sci-clk: add support for dynamically probing clocks")
> Signed-off-by: Udit Kumar <u-kumar1@ti.com>
> ---
> Changelog
> Changes in v4
> - Added only incremental chanegs as per v3 discussion
> - Updated commit message
> - v3 was Reviewed-by, Dropping Reviewed-by as logic is changed
> Link to v3
> https://lore.kernel.org/all/20240207091100.4001428-1-u-kumar1@ti.com/ 
> 
> Changes in v3
> - instead of get_freq, is_auto API is used to check validilty of clock
> - Address comments of v2, to have preindex increment
> Link to v2 https://lore.kernel.org/all/20240206104357.3803517-1-u-kumar1@ti.com/
> 
> Changes in v2
> - Updated commit message
> - Simplified logic for valid clock id
> link to v1 https://lore.kernel.org/all/20240205044557.3340848-1-u-kumar1@ti.com/
> 
> 
> P.S
> Firmawre returns total num_parents count including non available ids.
> For above device id NAVSS0_CPTS_0, number of parents clocks are 16
> i.e from id 2 to 17. But out of these ids few are not valid.
> So driver adds only valid clock ids out ot total.
> 
> Original logs
> https://gist.github.com/uditkumarti/de4b36b21247fb36725ad909ce4812f6#file-original-logs
> Line 2630 for error
> 
> Logs with fix v4
> https://gist.github.com/uditkumarti/f25482a5e18e918010b790cffb39f572
> Line 2640
> 
> 
>  drivers/clk/keystone/sci-clk.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/clk/keystone/sci-clk.c b/drivers/clk/keystone/sci-clk.c
> index 35fe197dd303..eb2ef44869b2 100644
> --- a/drivers/clk/keystone/sci-clk.c
> +++ b/drivers/clk/keystone/sci-clk.c
> @@ -516,6 +516,7 @@ static int ti_sci_scan_clocks_from_dt(struct sci_clk_provider *provider)
>  	struct sci_clk *sci_clk, *prev;
>  	int num_clks = 0;
>  	int num_parents;
> +	bool state;
>  	int clk_id;
>  	const char * const clk_names[] = {
>  		"clocks", "assigned-clocks", "assigned-clock-parents", NULL
> @@ -586,6 +587,15 @@ static int ti_sci_scan_clocks_from_dt(struct sci_clk_provider *provider)
>  				clk_id = args.args[1] + 1;
>  
>  				while (num_parents--) {
> +					/* Check if this clock id is valid */
> +					ret = provider->ops->is_auto(provider->sci,
> +						sci_clk->dev_id, clk_id, &state);
> +
> +					if (ret) {
> +						clk_id++;
> +						continue;
> +					}
> +


Thanks. This makes more sense.

Reviewed-by: Nishanth Menon <nm@ti.com>
>  					sci_clk = devm_kzalloc(dev,
>  							       sizeof(*sci_clk),
>  							       GFP_KERNEL);
> -- 
> 2.34.1
> 

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

