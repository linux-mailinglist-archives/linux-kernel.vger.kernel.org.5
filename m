Return-Path: <linux-kernel+bounces-118916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01EC688C120
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 12:47:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B08E92E048C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 11:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15E126BB39;
	Tue, 26 Mar 2024 11:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="lt/WW03m"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C0A5810C;
	Tue, 26 Mar 2024 11:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711453641; cv=none; b=qKEebiroHjFCgS/C5yioq15p19w9rBUYd8MWSw9fvWv3KMM40YTPYT7dXRyEIhiEjx3+wpK5Y/rIknsN7qBGqgf0YTiD5f+O4SjvY3VtMjGVeUIJLpMRc5HZekgS+Kf0cYc93SaM414fXeaCEwCCgUo6+9vTg/9bxBhvZHI1SKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711453641; c=relaxed/simple;
	bh=G8cxDTpcn6Dk3PzuJDxp5gUz+xViCQX62aAkRHSm314=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XhZEzR6WjN0/Gk+fHKV2OKqF1AhBqjsZIRmEaL4eW26e7WjrWt5vshr2O0tr+VefDkccxLSx7nC7VkFZ1ViCqoeooXg+rN9d7erGI37qvnYI0O28/gF7TqaxchQ7RGvK90LNI26ef1ceMm0SVjpeZjI4zlCrpZLnIQJfV7bDNAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=lt/WW03m; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 42QBkrQF084876;
	Tue, 26 Mar 2024 06:46:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1711453613;
	bh=OH9xpZHq5zm32WUZrXK8kfzeBNZUknI+dO6M8e8k1Bg=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=lt/WW03mCg4aA5F1zhkI72SVlqfuk1Nq/O2ox2YV76/VepAdV4so00zTl9t9RO5qJ
	 lIRoHZhbcMTNYm38OtZc+IFJyOtZYkiXCDmCW9kfyz66XqHU33nN9Cg62cQSvBS2uC
	 2Ox7S9+RemHlvkBadYGtM68N0IElgX5Flo8JAXh0=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 42QBkroS016480
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 26 Mar 2024 06:46:53 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 26
 Mar 2024 06:46:53 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 26 Mar 2024 06:46:53 -0500
Received: from localhost (dhruva.dhcp.ti.com [172.24.227.68])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 42QBkqBY011628;
	Tue, 26 Mar 2024 06:46:52 -0500
Date: Tue, 26 Mar 2024 17:16:51 +0530
From: Dhruva Gole <d-gole@ti.com>
To: Vincent Guittot <vincent.guittot@linaro.org>
CC: <linux@armlinux.org.uk>, <catalin.marinas@arm.com>, <will@kernel.org>,
        <sudeep.holla@arm.com>, <rafael@kernel.org>, <viresh.kumar@linaro.org>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <mingo@redhat.com>, <peterz@infradead.org>,
        <juri.lelli@redhat.com>, <dietmar.eggemann@arm.com>,
        <rostedt@goodmis.org>, <bsegall@google.com>, <mgorman@suse.de>,
        <bristot@redhat.com>, <vschneid@redhat.com>, <lukasz.luba@arm.com>,
        <rui.zhang@intel.com>, <mhiramat@kernel.org>,
        <daniel.lezcano@linaro.org>, <amit.kachhap@gmail.com>,
        <corbet@lwn.net>, <gregkh@linuxfoundation.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-trace-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v6 3/5] thermal/cpufreq: Remove
 arch_update_thermal_pressure()
Message-ID: <20240326114651.ibuoa5f7gk57t4if@dhruva>
References: <20240326091616.3696851-1-vincent.guittot@linaro.org>
 <20240326091616.3696851-4-vincent.guittot@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240326091616.3696851-4-vincent.guittot@linaro.org>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi,

On Mar 26, 2024 at 10:16:14 +0100, Vincent Guittot wrote:
> arch_update_thermal_pressure() aims to update fast changing signal which
> should be averaged using PELT filtering before being provided to the
> scheduler which can't make smart use of fast changing signal.
> cpufreq now provides the maximum freq_qos pressure on the capacity to the
> scheduler, which includes cpufreq cooling device. Remove the call to
> arch_update_thermal_pressure() in cpufreq cooling device as this is
> handled by cpufreq_get_pressure().
> 
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> Tested-by: Lukasz Luba <lukasz.luba@arm.com>
> ---

Makes sense,
Reviewed-by: Dhruva Gole <d-gole@ti.com>


-- 
Best regards,
Dhruva

