Return-Path: <linux-kernel+bounces-55096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DBE1484B7AA
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 15:21:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F27FB250A0
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 14:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FD26132466;
	Tue,  6 Feb 2024 14:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Il3a4V3B"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00061131E54;
	Tue,  6 Feb 2024 14:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707229269; cv=none; b=BvqVkLhlDWqewmaN7K4KaElCJifP9HCsLD0/rxP8I+ED00e8hkxF+p5Sty0wKmNM7sdcGmgErrPr3Bw/Bk7tfo7InopK3oWRu6kJ6r1sqqnX22w1PP8l8vGKiYlZ/Izh9RFalxFDl1QSMbKjzhB/VLDo6dcLiYl18lQFngLGVbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707229269; c=relaxed/simple;
	bh=UeO/JaVc+8dCmn0PktIDyO8ktmpYIdfNC4J9vHuK1+w=;
	h=From:To:CC:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Vm0hIdMZ1eDBG2NtyIzD3THOTXyx3ZRL3LXYw1/7RkNc5AdLLSEazHI9b5CMDlYqQBnF5vYq3z5Q0w2N+OVF0PR02Kk5jEWgbb7tuUzEr4i1KHumrtZbEuEEZE18qQyicHi7zbzOgqhynUuRw9BLP8DmKn8yIhboah5dd7aBTmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Il3a4V3B; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 416EL2XR045115;
	Tue, 6 Feb 2024 08:21:02 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707229262;
	bh=WHpo3J/M6ocTsI+cka2VKGIgJnV5B1gIDTBuZSTikgc=;
	h=From:To:CC:Subject:In-Reply-To:References:Date;
	b=Il3a4V3BPpyrTht79cOdM0TMx9jAreS6SO7nWPXmvnFqn7jJi+0rnTnZY8qBBEz28
	 +eA2+6egse8voNQKFvuVgsSeTxtIQ3Vx6uWLp+wZqJP8flVmZiev7Q1ou23mAUmaDq
	 0mL3+zFHEBB31d7NFzHm8m6UESap63Lio/DjAHk8=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 416EL2Oj072071
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 6 Feb 2024 08:21:02 -0600
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 6
 Feb 2024 08:21:01 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 6 Feb 2024 08:21:01 -0600
Received: from localhost (kamlesh.dhcp.ti.com [172.24.227.123])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 416EL1bl113197;
	Tue, 6 Feb 2024 08:21:01 -0600
From: Kamlesh Gurudasani <kamlesh@ti.com>
To: Udit Kumar <u-kumar1@ti.com>, <nm@ti.com>, <kristo@kernel.org>,
        <ssantosh@kernel.org>, <chandru@ti.com>, <rishabh@ti.com>
CC: <vigneshr@ti.com>, <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, Udit Kumar <u-kumar1@ti.com>
Subject: Re: [PATCH v2] clk: keystone: sci-clk: Adding support for non
 contiguous clocks
In-Reply-To: <20240206104357.3803517-1-u-kumar1@ti.com>
References: <20240206104357.3803517-1-u-kumar1@ti.com>
Date: Tue, 6 Feb 2024 19:51:00 +0530
Message-ID: <87wmrhy8qb.fsf@kamlesh.i-did-not-set--mail-host-address--so-tickle-me>
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
..
> @@ -586,16 +587,23 @@ static int ti_sci_scan_clocks_from_dt(struct sci_clk_provider *provider)
>  				clk_id = args.args[1] + 1;
>  
>  				while (num_parents--) {
> +					/* Check if this clock id is valid */
> +					ret = provider->ops->get_freq(provider->sci,
> +						sci_clk->dev_id, clk_id, &freq);


> +
> +					clk_id++;
Why increment it here and subtract if get_freq succeeds (sci_clk->clk_id = clk_id - 1;), rather
if(ret) {
        clk_id++;
        continue;
}
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
and keep sci_clk->clk_id = clk_id++; intact

saves one subtraction

or even better

 - 				clk_id = args.args[1] + 1;
 + 				clk_id = args.args[1];
  				while (num_parents--) {
 +					/* Check if this clock id is valid */
 +					ret = provider->ops->get_freq(provider->sci,
 +						sci_clk->dev_id, ++clk_id, &freq);

and then no increments after, for clk_id

Regards,
Kamlesh

