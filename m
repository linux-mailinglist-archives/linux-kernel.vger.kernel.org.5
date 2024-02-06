Return-Path: <linux-kernel+bounces-55003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B38D84B623
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 14:14:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE72E289D36
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 13:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14AFC12F5B4;
	Tue,  6 Feb 2024 13:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="qEm0iTkc"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC3312FF9E;
	Tue,  6 Feb 2024 13:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707225277; cv=none; b=PnHqP8nonRoBBwXQJLA7yr2fLsV2jBir9nLlzoSNBsWfmXQF9Yon3CoAazdH5zMxohWfBGqx4aZtnwPsP0z8/h9ivUzW1u2wrQ9DO+YSxJBaqead2wLoSDSJpHkPIhSPNLDeeu3CDUTfHxbx2L2BHOk7ubbP0SekVv9l77YqFRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707225277; c=relaxed/simple;
	bh=xJ563m7J8c8KF2CNpV0DxVwgvbywjyIF+ubLmzjzq/M=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BsQy/33CCPLe2SiIjqFDnwgBnlYgSL/tdS1jwgDRrShxf3chNReAhS051EIGFoajMGc7IWZHEX0YX76WfAGR0YKomi/EM8Us4WFt5hPPU3wrtimBXNvxjlm/zEIyANl/ZO8l5EX4Gv8QSvVQHHTILnEKnvhJ0etOMdw4r1Rpl+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=qEm0iTkc; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 416DELra027646;
	Tue, 6 Feb 2024 07:14:21 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707225261;
	bh=7f11SCnakUG398AkJtCBBbS5GxwKNqEGvbb0NtIfvmA=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=qEm0iTkcYnHherRxcYhyQQcUMD67w+Q9L+rM8q02lWxk5QnDSjRmchoq7OhN6LEp3
	 tWNFhLsL2jyh23k6iSxBzgZHoRJLgXHCOWNCge0H8sOqnrMbbF6OA3DbAe69CodqZz
	 ui+qyuI1XNv+4QP94qJTDtQOZR9QFniz/waEbuK4=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 416DEKlN018551
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 6 Feb 2024 07:14:21 -0600
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 6
 Feb 2024 07:14:20 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 6 Feb 2024 07:14:20 -0600
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 416DEKqn036857;
	Tue, 6 Feb 2024 07:14:20 -0600
Date: Tue, 6 Feb 2024 07:14:20 -0600
From: Nishanth Menon <nm@ti.com>
To: Udit Kumar <u-kumar1@ti.com>
CC: <kristo@kernel.org>, <ssantosh@kernel.org>, <chandru@ti.com>,
        <rishabh@ti.com>, <vigneshr@ti.com>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>
Subject: Re: [PATCH v2] clk: keystone: sci-clk: Adding support for non
 contiguous clocks
Message-ID: <20240206131420.wtitflgav23jto2q@verbally>
References: <20240206104357.3803517-1-u-kumar1@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240206104357.3803517-1-u-kumar1@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 16:13-20240206, Udit Kumar wrote:
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
> Fixes: 3c13933c6033 ("clk: keystone: sci-clk: add support for dynamically probing clocks")
> 
> [0] https://software-dl.ti.com/tisci/esd/latest/5_soc_doc/j7200/clocks.html
> Section Clocks for NAVSS0_CPTS_0 Device,
> clock id 12-15 not present.
> 
> Signed-off-by: Udit Kumar <u-kumar1@ti.com>
> ---
> Changelog
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
> Logs with fix v2
> https://gist.github.com/uditkumarti/94e3e28d62282fd708dbfe37435ce1d9
> Line 2591
> 
> 
>  drivers/clk/keystone/sci-clk.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/clk/keystone/sci-clk.c b/drivers/clk/keystone/sci-clk.c
> index 35fe197dd303..ff249cbd54a1 100644
> --- a/drivers/clk/keystone/sci-clk.c
> +++ b/drivers/clk/keystone/sci-clk.c
> @@ -517,6 +517,7 @@ static int ti_sci_scan_clocks_from_dt(struct sci_clk_provider *provider)
>  	int num_clks = 0;
>  	int num_parents;
>  	int clk_id;
> +	u64 freq;
>  	const char * const clk_names[] = {
>  		"clocks", "assigned-clocks", "assigned-clock-parents", NULL
>  	};
> @@ -586,16 +587,23 @@ static int ti_sci_scan_clocks_from_dt(struct sci_clk_provider *provider)
>  				clk_id = args.args[1] + 1;
>  
>  				while (num_parents--) {
> +					/* Check if this clock id is valid */
> +					ret = provider->ops->get_freq(provider->sci,
> +						sci_clk->dev_id, clk_id, &freq);

get_freq is a bit expensive as it has to walk the clock tree to find
the clock frequency (at least the first time?). just wondering if
there is lighter alternative here?

> +
> +					clk_id++;
> +					if (ret)
> +						continue;
> +
>  					sci_clk = devm_kzalloc(dev,
>  							       sizeof(*sci_clk),
>  							       GFP_KERNEL);
>  					if (!sci_clk)
>  						return -ENOMEM;
>  					sci_clk->dev_id = args.args[0];
> -					sci_clk->clk_id = clk_id++;
> +					sci_clk->clk_id = clk_id - 1;
>  					sci_clk->provider = provider;
>  					list_add_tail(&sci_clk->node, &clks);
> -
	Spurious change.
>  					num_clks++;
>  				}
>  			}
> -- 
> 2.34.1
> 

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

