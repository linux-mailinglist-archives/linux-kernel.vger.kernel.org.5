Return-Path: <linux-kernel+bounces-98481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14242877AA7
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 06:36:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45F761C212C9
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 05:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EEBCB647;
	Mon, 11 Mar 2024 05:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="jnaEBVz0"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC71DF9CC;
	Mon, 11 Mar 2024 05:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710135381; cv=none; b=UpYKIHOp6bKtmh3IrFe6F8i1aAnz75gwL4oGB/sW+yNBdFycOfBP7AVRsqWH5FQQRJnbXfQiM1f0zTEmCtGmn3awyIcgGfZ57rZHWkAzWDXl+8RRH57mP98N9JGgKxAGj1zgAB2mWP2C5HIzHKJCw5QUZDjLO+QleI6QucAbEKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710135381; c=relaxed/simple;
	bh=3s7VpcFiH+fbWcBakEtyV9bW10w7EJ7btYuoFKhJ59g=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AY29lDjfg+n94uvu6a3+DLBvQ5rCjuP77v1N7DSBVW7D2M2tcC3tzcyoR9RcTz+VMFf9WjWiWRGW28Iy3Xd/cvB2T0l1ZnWv+AnWw44iA0Ke9dGv2VbNKSQe50VdGaTMuRnCCb2m41lM1LLoR/2cJ1KcSnm2OE6ffIpT0SuXjMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=jnaEBVz0; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 42B5ZtFf123009;
	Mon, 11 Mar 2024 00:35:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1710135355;
	bh=qGe6oJXNsXPQ21VUg3fd7qbxMx8WX1t9u9eCGiXOklc=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=jnaEBVz0LJhLvdiC5pJFJUxUL4uxRuAuhD+0tFww04vPDowNMazSxq9rLx9ANZx2T
	 7ziQgt9TQoyu0HBkEDpzWRCL/aADbiHD+1A4Kxy/X+dJarFq6DjlY4liGH5IWQXC+G
	 SnrxZOaI0zR9I5YJjy43Ef6bAkuAh0pUMpdP1VHs=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 42B5Ztmw023170
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 11 Mar 2024 00:35:55 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 11
 Mar 2024 00:35:55 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 11 Mar 2024 00:35:55 -0500
Received: from localhost (dhruva.dhcp.ti.com [172.24.227.68])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 42B5Zsl4127577;
	Mon, 11 Mar 2024 00:35:54 -0500
Date: Mon, 11 Mar 2024 11:05:54 +0530
From: Dhruva Gole <d-gole@ti.com>
To: Sibi Sankar <quic_sibis@quicinc.com>
CC: <sudeep.holla@arm.com>, <cristian.marussi@arm.com>, <rafael@kernel.org>,
        <viresh.kumar@linaro.org>, <morten.rasmussen@arm.com>,
        <dietmar.eggemann@arm.com>, <lukasz.luba@arm.com>, <sboyd@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_mdtipton@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <nm@ti.com>
Subject: Re: [PATCH V3 1/2] firmware: arm_scmi: Add support for marking
 certain frequencies as boost
Message-ID: <20240311053554.36j2rq3wgtswwoom@dhruva>
References: <20240308104410.385631-1-quic_sibis@quicinc.com>
 <20240308104410.385631-2-quic_sibis@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240308104410.385631-2-quic_sibis@quicinc.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On Mar 08, 2024 at 16:14:09 +0530, Sibi Sankar wrote:
> All opps above the sustained level/frequency are treated as boost, so mark

I know that we use the terms boost and turbo interchangeably however I
would suggest to avoid confusion that we say "treated as turbo" just
because the variable is called turbo.

> them accordingly.
> 
> Suggested-by: Sudeep Holla <sudeep.holla@arm.com>
> Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
> ---
>  drivers/firmware/arm_scmi/perf.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/firmware/arm_scmi/perf.c b/drivers/firmware/arm_scmi/perf.c
> index 8e832d1ad825..64d9a90bf443 100644
> --- a/drivers/firmware/arm_scmi/perf.c
> +++ b/drivers/firmware/arm_scmi/perf.c
> @@ -857,7 +857,7 @@ static int scmi_dvfs_device_opps_add(const struct scmi_protocol_handle *ph,
>  				     struct device *dev, u32 domain)
>  {
>  	int idx, ret;
> -	unsigned long freq;
> +	unsigned long freq, sustained_freq;
>  	struct dev_pm_opp_data data = {};
>  	struct perf_dom_info *dom;
>  
> @@ -865,12 +865,18 @@ static int scmi_dvfs_device_opps_add(const struct scmi_protocol_handle *ph,
>  	if (IS_ERR(dom))
>  		return PTR_ERR(dom);
>  
> +	sustained_freq = dom->sustained_freq_khz * 1000UL;
> +
>  	for (idx = 0; idx < dom->opp_count; idx++) {
>  		if (!dom->level_indexing_mode)
>  			freq = dom->opp[idx].perf * dom->mult_factor;
>  		else
>  			freq = dom->opp[idx].indicative_freq * dom->mult_factor;
>  
> +		/* All opps above the sustained level/frequency are treated as boost */

Same here, would be better to say "turbo" than boost.

> +		if (freq > sustained_freq)
> +			data.turbo = true;

It's simple enough that we can write it as
data.turbo = (freq > sustained_freq_khz*1000) ? true : false;

We can avoid an additional variable and all the other code changes.


-- 
Best regards,
Dhruva Gole <d-gole@ti.com>

