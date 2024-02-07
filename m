Return-Path: <linux-kernel+bounces-56261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E61384C808
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 10:54:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72C16B2717C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 09:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA2A9241E1;
	Wed,  7 Feb 2024 09:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="GYed4ve+"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB3625615;
	Wed,  7 Feb 2024 09:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707299626; cv=none; b=t8tkG/FWk6g+U72BFZvS2JxNRLvlcn4Rm3DcVrN++lyH0ArQHVzrXYbmYLwNOon06NA8zublxMXCabyLjxY9uul+qHULjIYe67b2Gux2Sht6t2GmP4QBEkIIqI7WGpkdyjem2JLBkF5+UrEz4cJqxmKQHJqcjImXzkl4SuWWEa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707299626; c=relaxed/simple;
	bh=EhcbUeQ4WmX6iQiB/9OpRHabAiHJuChv9OmU+jvAFHM=;
	h=From:To:CC:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Qcetu2dofF3zASAerz2AFgEWXVxKXY+psncSefSfbJgO6QnY4Nh48j83/sGfk2UGShlbwvQIHhZhUIIATTdQgQRYVT09pIM1v+g8KD2SmSdd5XUwbFeDQGNZfsgwtCkKEDkI+kGZqHpHvJlhXUK1jxXqfxlwZgwpmG/eQCipuxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=GYed4ve+; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4179rbjr015279;
	Wed, 7 Feb 2024 03:53:37 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707299617;
	bh=ipA46PctbVCKgyH3JHgV+xEV0H0JplKxxlpKT+8jS/Y=;
	h=From:To:CC:Subject:In-Reply-To:References:Date;
	b=GYed4ve+ja3vQMXYzFAMJ9/OkaWAwmPHJWYqfmreQK4qFLJFt0431oDIQy1epbkOm
	 a+JH/83ufv5V4GuKKLmKAW2uQkxaUjWoWRPE5vn+yrkVmxXQ3FrpzK0oAU6HlwpeZX
	 V1bf/bPnegdx2T+tWR9FYjbXMWlez9uSYbTn4e68=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4179rbT7033073
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 7 Feb 2024 03:53:37 -0600
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 7
 Feb 2024 03:53:37 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 7 Feb 2024 03:53:37 -0600
Received: from localhost (kamlesh.dhcp.ti.com [172.24.227.123])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4179ra06055493;
	Wed, 7 Feb 2024 03:53:36 -0600
From: Kamlesh Gurudasani <kamlesh@ti.com>
To: Udit Kumar <u-kumar1@ti.com>, <nm@ti.com>, <kristo@kernel.org>,
        <ssantosh@kernel.org>, <chandru@ti.com>, <rishabh@ti.com>
CC: <vigneshr@ti.com>, <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, Udit Kumar <u-kumar1@ti.com>
Subject: Re: [PATCH v3] clk: keystone: sci-clk: Adding support for non
 contiguous clocks
In-Reply-To: <20240207091100.4001428-1-u-kumar1@ti.com>
References: <20240207091100.4001428-1-u-kumar1@ti.com>
Date: Wed, 7 Feb 2024 15:23:36 +0530
Message-ID: <87le7wy50f.fsf@kamlesh.i-did-not-set--mail-host-address--so-tickle-me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Udit Kumar <u-kumar1@ti.com> writes:

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
Looks good to me.

Reviewed-by: Kamlesh Gurudasani <kamlesh@ti.com>

> -- 
> 2.34.1

