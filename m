Return-Path: <linux-kernel+bounces-100232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE8C28793CC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 13:10:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E122A1C213C1
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 12:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFEEC79DD9;
	Tue, 12 Mar 2024 12:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="rYNb7cln"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B06079B8C;
	Tue, 12 Mar 2024 12:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710245389; cv=none; b=kYY5y89esWNw9kD82SIFct3iDT/h3mfBs2Cw5W3WmCuEZpdrrDtRbcsOvJyKsyMqBpNa+rVc1FPBQmauSzIhzxcgb9DTtGJncXNhu2AgjNypksepmCpLuEeF3VfHYZoNlfHXkShl6/xAOXy+hMWcLeB14YEN6B20KMhcvQXnz1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710245389; c=relaxed/simple;
	bh=qNcgVnoMZNKbLLwk3Cc2u55XeJl8sYRlrIEOXpigolE=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i2Pz+frs9rBeA3KkNMxvYzfLycyAoet5Ig5vkuChJ1eT5VpL/hztWpSaJXjzHALiEWrHWfIUD9dsDFwKN/dnjgc+/5pceOIpTMXL7aaS2Rw9Cbwfqb7uMQwQ37XWE6JQDuLcZLGQi7qrAMlXeuGtj0KOIOwW+8mpXb6lETTF9aM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=rYNb7cln; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 42CC9WL5121145;
	Tue, 12 Mar 2024 07:09:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1710245372;
	bh=fhO3Vy9WQU0enXaZVgrglVzPKLoEWgXAeH3UAKGly/s=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=rYNb7clnFc3PA0U75OjJh/ojrRCxM5hvMez28cAn3kOZmBS4zpnAqIRZ2e5R65Jw6
	 8+j1Dv0PhHqb4UeCcdF1HjwBAaf19j+OcPXBD6FYV0wPdb8Z5Kn8AoPqtZ15W91iyw
	 0xQt1oae+7TTrZea6nZIWeh8LhMRAO/7LCDREHv0=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 42CC9W1s051738
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 12 Mar 2024 07:09:32 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 12
 Mar 2024 07:09:31 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 12 Mar 2024 07:09:31 -0500
Received: from localhost (dhruva.dhcp.ti.com [172.24.227.68])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 42CC9Ukb096706;
	Tue, 12 Mar 2024 07:09:31 -0500
Date: Tue, 12 Mar 2024 17:39:30 +0530
From: Dhruva Gole <d-gole@ti.com>
To: Sibi Sankar <quic_sibis@quicinc.com>
CC: <sudeep.holla@arm.com>, <cristian.marussi@arm.com>, <rafael@kernel.org>,
        <viresh.kumar@linaro.org>, <morten.rasmussen@arm.com>,
        <dietmar.eggemann@arm.com>, <lukasz.luba@arm.com>, <sboyd@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_mdtipton@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <nm@ti.com>
Subject: Re: [PATCH V4 2/2] cpufreq: scmi: Enable boost support
Message-ID: <20240312120930.5yp5vx7cbdkpc6id@dhruva>
References: <20240312094726.3438322-1-quic_sibis@quicinc.com>
 <20240312094726.3438322-3-quic_sibis@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240312094726.3438322-3-quic_sibis@quicinc.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On Mar 12, 2024 at 15:17:26 +0530, Sibi Sankar wrote:
> Certain platforms host a number of higher OPPs that are exclusive to
> CPUs within specific CPUfreq policies and not all CPUs within that
> CPUfreq policy are able to achieve those higher OPPs due to power
> constraints. These OPPs are marked as turbo in the freq_table and in
> the presence of such OPPs, let's enable boost by default.

Thanks, I like this commit message better than the prev rev.

> 
> Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
> Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
> ---
> 

Reviewed-by: Dhruva Gole <d-gole@ti.com>


-- 
Best regards,
Dhruva Gole <d-gole@ti.com>

