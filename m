Return-Path: <linux-kernel+bounces-56501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 024C684CAEF
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 13:54:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3561D1C25FD7
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 12:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5CBB768EF;
	Wed,  7 Feb 2024 12:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="N5gE6h6/"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC11B24208;
	Wed,  7 Feb 2024 12:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707310465; cv=none; b=eL18C7E+5DW8Kpa6u7FOHXsHHQLqU8r6e6hRNoToGnOU6X4IIVDmUoYpAUZ1o1FyjZqAD8xX3VATywAk575lnpm70FEKoLE8SF7E5eltwYDLh/wlRI8oNLqnwP11Ara6aDmgFSzF9wYlws2lJNNSrRQ4FiXukfd8YjyzO0bOwdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707310465; c=relaxed/simple;
	bh=0dgVTyRDyIITEw8cjx/bO5qjXxVQQNS5aCdwjS7/6us=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I8vJ/e+Y22MM2GyL+ikblsyEgRg44OlnwXzg6fl97Dh9JF/8SA02Ox1r+9rMy+4JQGyxcsj3MNj7oi+yHuND14BvAssLEbG+Vo668AdWr9JXidQGTpriMmsSMUwJu7a6pA4e3Q6z2+w2m66GzoUJmP8v+FA0zPDu4x4I4wWVbW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=N5gE6h6/; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 417CsBdp121309;
	Wed, 7 Feb 2024 06:54:11 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707310451;
	bh=/M9KAPNd5z2NR6F6xgrGXHPVw+rjKoUC+4SOpn6mtiE=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=N5gE6h6/hLjlX6TbkCtPrKh5vRFkzS+KahqSVhxacypUrHq4P/XRSOFU/oHomAChv
	 JsR2t+ekh6PexlcdKrBeu86PyoS6FWFZr0nEo/iVAob6ioNoNabkwHWn+QhfDqMxi4
	 zojEteZiUXeZpAQBKX6SN97E4XSuv/GJxm8ADkLY=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 417CsBdH072448
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 7 Feb 2024 06:54:11 -0600
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 7
 Feb 2024 06:54:10 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 7 Feb 2024 06:54:11 -0600
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 417CsA3J074777;
	Wed, 7 Feb 2024 06:54:10 -0600
Date: Wed, 7 Feb 2024 06:54:10 -0600
From: Nishanth Menon <nm@ti.com>
To: Udit Kumar <u-kumar1@ti.com>
CC: <kristo@kernel.org>, <ssantosh@kernel.org>, <chandru@ti.com>,
        <rishabh@ti.com>, <kamlesh@ti.com>, <vigneshr@ti.com>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-clk@vger.kernel.org>
Subject: Re: [PATCH v3] clk: keystone: sci-clk: Adding support for non
 contiguous clocks
Message-ID: <20240207125410.r2q3jcplvif7dvt2@tumbling>
References: <20240207091100.4001428-1-u-kumar1@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240207091100.4001428-1-u-kumar1@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 14:41-20240207, Udit Kumar wrote:
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
> Logs with fix v3
> https://gist.github.com/uditkumarti/94e3e28d62282fd708dbfe37435ce1d9#file-v3
> Line 2586
> 
> 
>  drivers/clk/keystone/sci-clk.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/clk/keystone/sci-clk.c b/drivers/clk/keystone/sci-clk.c
> index 35fe197dd303..31b7df05d7bb 100644
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
> @@ -583,16 +584,23 @@ static int ti_sci_scan_clocks_from_dt(struct sci_clk_provider *provider)
>  					num_parents = 255;
>  				}
>  
> -				clk_id = args.args[1] + 1;
> +				clk_id = args.args[1];
>  
>  				while (num_parents--) {
> +					/* Check if this clock id is valid */
> +					ret = provider->ops->is_auto(provider->sci,
> +						sci_clk->dev_id, ++clk_id, &state);

A bit too nice coding ;) => I had been confused momentarily by clk_id = args.args[1]
change just above till I saw that you are pre-incrementing
clk_id - Is there a harm in leaving the original clk_id increment logic
alone (it was much simpler to read up)?

> +
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
> +					sci_clk->clk_id = clk_id;
>  					sci_clk->provider = provider;
>  					list_add_tail(&sci_clk->node, &clks);
>  
> -- 
> 2.34.1
> 

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

