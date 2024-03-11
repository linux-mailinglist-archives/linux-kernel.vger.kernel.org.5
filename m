Return-Path: <linux-kernel+bounces-98474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72E51877A92
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 06:27:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5B5C1C21405
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 05:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5BC7AD49;
	Mon, 11 Mar 2024 05:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="FUjoOWE7"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C7EE54C;
	Mon, 11 Mar 2024 05:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710134852; cv=none; b=fBp8fdEyEvbn99Jkj24EmbldUzFMumAjDGGhs2+g1ueppmjeWV8wcWqEOQQ4CaO/+Hk1TGDaxt/ttnWe1flNGj8rmHRZILJuIUH0D8F6Kk57LBTaedBLwF8BBM8Pt+riuPWSng0aAD4RDsHZysP9AS9mGs5NSPUmdZdj7NRRTlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710134852; c=relaxed/simple;
	bh=Lj1Ko0OaD1ZRf1I5oKT78KNZ+mBUf0V0V06Nyns5m5k=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HRrax13gjfu9Wn/lR65PGGN4B94rtKqDPxbWW1Uzl5t2aUhNn/riSQKWRft+NoxMTfLy9755D5hkzA8rcS5uku8b02zdEbANfALn9iHit8UWJFPOqflYhUwjjWzKqW+sqJ9wpgiuCHLvqcldix6LJQKVhGJEgGhTh/0nNHc49WU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=FUjoOWE7; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 42B5QrOV119765;
	Mon, 11 Mar 2024 00:26:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1710134813;
	bh=/QS4flGaV72pHQT1zN8FWRnbbRvdTfxPqlBeYm8/pq8=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=FUjoOWE7KLA08lIzNTyvuuNwKDC8S1x6U2Er8yPUg9q0msDJ2kkm6uzsXA5uJKBsq
	 2k8gKKf0LWcu2WyhHfNGOhbntjoNmrelrfIRW+6mygkpnSqhUG6HY8EDZVNgPb+UH1
	 BxVVjoBKjDgjcV9pu9XpCI1dlesUADx6O1W67a58=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 42B5QrZn108507
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 11 Mar 2024 00:26:53 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 11
 Mar 2024 00:26:52 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 11 Mar 2024 00:26:52 -0500
Received: from localhost (dhruva.dhcp.ti.com [172.24.227.68])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 42B5QpPg086960;
	Mon, 11 Mar 2024 00:26:52 -0500
Date: Mon, 11 Mar 2024 10:56:51 +0530
From: Dhruva Gole <d-gole@ti.com>
To: Viresh Kumar <viresh.kumar@linaro.org>
CC: Sibi Sankar <quic_sibis@quicinc.com>, <dietmar.eggemann@arm.com>,
        <rafael@kernel.org>, <xuwei5@hisilicon.com>, <zhanjie9@hisilicon.com>,
        <sudeep.holla@arm.com>, <cristian.marussi@arm.com>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <quic_rgottimu@quicinc.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-pm@vger.kernel.org>
Subject: Re: [PATCH V2] cpufreq: Fix per-policy boost behavior on SoCs using
 cpufreq_boost_set_sw
Message-ID: <20240311052651.uedxt2wvywqlrsac@dhruva>
References: <20240308103630.383371-1-quic_sibis@quicinc.com>
 <20240311045044.7vvzbsx5nqs5a2lr@vireshk-i7>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240311045044.7vvzbsx5nqs5a2lr@vireshk-i7>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi,

On Mar 11, 2024 at 10:20:44 +0530, Viresh Kumar wrote:
> On 08-03-24, 16:06, Sibi Sankar wrote:
> > +		/* Let the per-policy boost flag mirror the cpufreq_driver boost during init */
> > +		if (cpufreq_driver->boost_enabled)
> > +			policy->boost_enabled = policy_has_boost_freq(policy) ? true : false;
> 
> Can be written as:
> 
> policy->boost_enabled = cpufreq_boost_enabled() && policy_has_boost_freq(policy);

I would like to recommend the same.

> 
> Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>

Rest looks fine,
Reviewed-by: Dhruva Gole <d-gole@ti.com>

-- 
Best regards,
Dhruva Gole <d-gole@ti.com>

