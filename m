Return-Path: <linux-kernel+bounces-100233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 67D5D8793D1
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 13:10:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC467B255EB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 12:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C10F47A130;
	Tue, 12 Mar 2024 12:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="CLetRgdt"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 479A079DB7;
	Tue, 12 Mar 2024 12:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710245409; cv=none; b=GUKSGPA/wXUUhmY8rnLP3zyKrSrO4x0lexas5zDaCuvitTXhqIV8rBZbAaTUcf+PgzTPlxdrR5/vc8Z7LPyOotGZth3E9gUxy19L+Z1XxJGqEUKbUNvqoo1X5dsmU2w5vqMuwlt+FzduLvdX27IwwT+Qb+qZHhpDrDRZEo8jeek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710245409; c=relaxed/simple;
	bh=J4zrMDxZt2mY8Udzz7B1aFiT7+U5KtBZSVCQ3MaLmpo=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VizAA2Kh/XbiOts0cpRhIQoq+u1zIe3qPx4Z8GjS3frunopVOQxBIV4IdXP5QwGpHvmmmrE6KHxHyHDRTNvp1LIdMU0Lw0VHUaMOTDDMNn8B19baZOaCfxC3DE2Hm2Z0BN2eomDjkCOhupax5+7+DkiFpP5IvH6RX2hQlx5hCAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=CLetRgdt; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 42CC9s6B012541;
	Tue, 12 Mar 2024 07:09:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1710245394;
	bh=jFq7cp9kr/StC4iPZ08B/XrH/vo+1Llvr7u+BugBMVo=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=CLetRgdtEPCY0LQU4SzmoVPWu+qih/PoJn2kqxT058qKg1IjM0MC+5s1Ay3lIGVZG
	 rrtJhZXj3kZ8b7UZpHlqvHDOTiITKKfEqvFV1JjHdf6B2fyvmb37JvDto0kCPiXBvX
	 8iaZZ7lx02/P5vrrsD+lT+ULXcdcC+6KibUaFgBM=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 42CC9sA5130325
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 12 Mar 2024 07:09:54 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 12
 Mar 2024 07:09:54 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 12 Mar 2024 07:09:54 -0500
Received: from localhost (dhruva.dhcp.ti.com [172.24.227.68])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 42CC9rsn097251;
	Tue, 12 Mar 2024 07:09:54 -0500
Date: Tue, 12 Mar 2024 17:39:53 +0530
From: Dhruva Gole <d-gole@ti.com>
To: Sibi Sankar <quic_sibis@quicinc.com>
CC: <sudeep.holla@arm.com>, <cristian.marussi@arm.com>, <rafael@kernel.org>,
        <viresh.kumar@linaro.org>, <morten.rasmussen@arm.com>,
        <dietmar.eggemann@arm.com>, <lukasz.luba@arm.com>, <sboyd@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_mdtipton@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <nm@ti.com>
Subject: Re: [PATCH V4 1/2] firmware: arm_scmi: Add support for marking
 certain frequencies as turbo
Message-ID: <20240312120953.u6lfmgw33rcosjwl@dhruva>
References: <20240312094726.3438322-1-quic_sibis@quicinc.com>
 <20240312094726.3438322-2-quic_sibis@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240312094726.3438322-2-quic_sibis@quicinc.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On Mar 12, 2024 at 15:17:25 +0530, Sibi Sankar wrote:
> All opps above the sustained frequency are treated as turbo, so mark them
> accordingly.
> 
> Suggested-by: Sudeep Holla <sudeep.holla@arm.com>
> Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
> Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
> ---
> 
> v4:
> * Pickup Rbs
> * Use turbo and simplify setting turbo. [Dhruva/Viresh]
> 
>  drivers/firmware/arm_scmi/perf.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/firmware/arm_scmi/perf.c b/drivers/firmware/arm_scmi/perf.c
> index 8e832d1ad825..345fff167b52 100644
> --- a/drivers/firmware/arm_scmi/perf.c
> +++ b/drivers/firmware/arm_scmi/perf.c
> @@ -871,6 +871,9 @@ static int scmi_dvfs_device_opps_add(const struct scmi_protocol_handle *ph,
>  		else
>  			freq = dom->opp[idx].indicative_freq * dom->mult_factor;
>  
> +		/* All OPPs above the sustained frequency are treated as turbo */
> +		data.turbo = freq > dom->sustained_freq_khz * 1000;
> +

Reviewed-by: Dhruva Gole <d-gole@ti.com>

>  		data.level = dom->opp[idx].perf;
>  		data.freq = freq;
>  
> -- 
> 2.34.1
> 

-- 
Best regards,
Dhruva Gole <d-gole@ti.com>

