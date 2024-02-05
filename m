Return-Path: <linux-kernel+bounces-52779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFB39849C94
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 15:05:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69496286649
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 14:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F12242C18E;
	Mon,  5 Feb 2024 14:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="mOezREo/"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43A1F23768;
	Mon,  5 Feb 2024 14:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707141914; cv=none; b=l5b2nc/Eow22bsSHVatH3vHDFoObjktWJFgcDrj0RrCS+c7iAVlZrCltyu3+9p+sK56j1Jq1nXlf1K2QEoqHlxWA6Y/6G0CWIs3pCjbFhqlB3zmyASkzP3gwm2/FTm7/Fo5r4HaK62/CG9wW907l+jhZEnBZba3/gu6iS8AxGfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707141914; c=relaxed/simple;
	bh=4bIEfg7PdUaON+zlchHH8C9f6qqA8dXeOfMbDZuxrhw=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rOdsxYSAFPFDKXvWxpO1Xu39IebRqulv7Ghriua0/R95bDm/93/Vv6xLvJUDRf5zX2WVsoJ2i4134AmTNf6Dxo1NVbT0+TUmhSBK6/wXmL6D03nZxUCggtAu2at0lsrZxlDECSGUW3swboT9xdCqBNPTzd1jiqcxC4liK1fdqMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=mOezREo/; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 415E50ig023002;
	Mon, 5 Feb 2024 08:05:00 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707141900;
	bh=tWHCZPGdnVP9n6u5fBWigVBsLLeSsPy8VL0rQblycqY=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=mOezREo/iNM/aeAbvC6SOz5GAuInx3j8MW55bLKM71fM4VJ8t7Nk0HvsZgKAxwML/
	 Wc+xXyOGBSXbDMZxmE92/1uDO0X9fWFd2dAkEGhGc5H0GgBfAJ0Lx68tWz0/OwGrIa
	 AwQub8cyiH8ru32LKiG/oFJ6RnenEzWRQU1lRTNE=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 415E50SH032340
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 5 Feb 2024 08:05:00 -0600
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 5
 Feb 2024 08:04:59 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 5 Feb 2024 08:04:59 -0600
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 415E4xjt050034;
	Mon, 5 Feb 2024 08:04:59 -0600
Date: Mon, 5 Feb 2024 08:04:59 -0600
From: Nishanth Menon <nm@ti.com>
To: Udit Kumar <u-kumar1@ti.com>
CC: <kristo@kernel.org>, <ssantosh@kernel.org>, <vigneshr@ti.com>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-clk@vger.kernel.org>
Subject: Re: [PATCH v1] clk: keystone: sci-clk: Adding support for non
 contiguous clocks
Message-ID: <20240205140459.orjvjqqtiugmyosc@obscurity>
References: <20240205044557.3340848-1-u-kumar1@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240205044557.3340848-1-u-kumar1@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 10:15-20240205, Udit Kumar wrote:
> Most of clocks and their parents are defined in contiguous range,
> But in few cases, there is gap in clock numbers[0].
> 
> Driver assumes clocks to be in contiguous range, and assigns
> accordingly.
> 
> New firmware started returning error in case of
> non-available clock id.  Therefore drivers throws error while
> re-calculate and other functions.

What changed here? started returning error for what API? also please fix
up 70 char alignment -> there extra spaces in your commit message.
> 
> In this fix, before assigning and adding clock in list,
> driver checks if given clock is valid or not.
> 
> Fixes: 3c13933c6033 ("clk: keystone: sci-clk: add support for dynamically probing clocks")
> 
> [0] https://software-dl.ti.com/tisci/esd/latest/5_soc_doc/j7200/clocks.html
> Section Clocks for NAVSS0_CPTS_0 Device,
> clock id 12-15 and 18-19 not present
> 
> Signed-off-by: Udit Kumar <u-kumar1@ti.com>
> ---
> Original logs
> https://gist.github.com/uditkumarti/de4b36b21247fb36725ad909ce4812f6#file-original-logs
> Line 2630 for error
> 
> Logs with fix
> https://gist.github.com/uditkumarti/de4b36b21247fb36725ad909ce4812f6#file-with-fix
> Line 2594 
> 
>  drivers/clk/keystone/sci-clk.c | 20 ++++++++++++++++----
>  1 file changed, 16 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/clk/keystone/sci-clk.c b/drivers/clk/keystone/sci-clk.c
> index 35fe197dd303..d417ec018d82 100644
> --- a/drivers/clk/keystone/sci-clk.c
> +++ b/drivers/clk/keystone/sci-clk.c
> @@ -517,6 +517,8 @@ static int ti_sci_scan_clocks_from_dt(struct sci_clk_provider *provider)
>  	int num_clks = 0;
>  	int num_parents;
>  	int clk_id;
> +	int max_clk_id;
> +	u64 freq;
>  	const char * const clk_names[] = {
>  		"clocks", "assigned-clocks", "assigned-clock-parents", NULL
>  	};
> @@ -584,6 +586,7 @@ static int ti_sci_scan_clocks_from_dt(struct sci_clk_provider *provider)
>  				}
>  
>  				clk_id = args.args[1] + 1;
> +				max_clk_id = clk_id + num_parents;
>  
>  				while (num_parents--) {
>  					sci_clk = devm_kzalloc(dev,
> @@ -592,11 +595,20 @@ static int ti_sci_scan_clocks_from_dt(struct sci_clk_provider *provider)
>  					if (!sci_clk)
>  						return -ENOMEM;
>  					sci_clk->dev_id = args.args[0];
> -					sci_clk->clk_id = clk_id++;
> -					sci_clk->provider = provider;
> -					list_add_tail(&sci_clk->node, &clks);
> +					/* check if given clock id is valid by calling get_freq */
> +					/* loop over max possible ids */
> +					do {
> +						sci_clk->clk_id = clk_id++;
>  
> -					num_clks++;
> +						ret = provider->ops->get_freq(provider->sci,
> +							   sci_clk->dev_id, sci_clk->clk_id, &freq);
> +					} while (ret != 0 && clk_id < max_clk_id);

take clock ids 0 1 2 3 -> Say 2 is reserved.
num_parents = 4
while(num_parents) Loop 1 ->  clk ID 0 is valid, list_add_tail
while(num_parents) Loop 2 ->  clk ID 1 is valid, list_add_tail
while(num_parents) Loop 3 ->  clk ID 2 is invalid.. so we scan forward
	to clk ID 3 -> list_add_tail
while(num_parents) Loop 4 ->  clk ID 4 is invalid.. but 5 is out of
	range, so we break off loop. sci_clk is still devm_kzalloced ->
	but since clk_id > max_clk_id, we jump off loop, and we dont add
	it to tail. so one extra allocation?
If we have multiple reserved intermediate ones, then we'd have as many
allocations that aren't linked? Could we not improve the logic a bit to
allocate just what is necessary?

> +
> +					sci_clk->provider = provider;
> +					if (ret == 0) {
> +						list_add_tail(&sci_clk->node, &clks);
> +						num_clks++;
> +					}
>  				}
>  			}
>  
> -- 
> 2.34.1
> 

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

