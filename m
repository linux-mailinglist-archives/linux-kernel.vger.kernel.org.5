Return-Path: <linux-kernel+bounces-118913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1D5488C118
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 12:45:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82AFD1F3A226
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 11:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 673985810C;
	Tue, 26 Mar 2024 11:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Xtmal4w9"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A1956BB39;
	Tue, 26 Mar 2024 11:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711453536; cv=none; b=EivnGhLowGfWdWE1MdBQ0hj3io9wf3wjHLDr8vPboaCo4+uXJy5Lby4koE9hhEsW8uHVtvwuQhT9G/i2+OtQU9diDmLreb8l850wmmyvVcKsffadyR90uy0fDBqyeoMfWJAhnohyrmxxtLc57XSIQoKSLr4ytVevmu7O6KwQsbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711453536; c=relaxed/simple;
	bh=HlNlH0D6rEhsgNqoAFKCIqa0DgA4RkOgomD4hxEXSF0=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Li+VoPzkAaRifJlqytZEGzsFUUE+z2e0nzNokncGfTiV6suiL3F/oEtOhQg2jHOBuM1a2dAWzM+Nwrys0ik1vOycIeNrmTLEz9TFb0gv8ttgG4Si+YQQ+Ml+q1jyNMPODTAXZbJ8M63ev3qkiPDHWvPQGbDJdCz1hCy6Y4H93t0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Xtmal4w9; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 42QBj0PP084354;
	Tue, 26 Mar 2024 06:45:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1711453500;
	bh=8ZZ+yXIpR+DpKAp94YWkD4hzM6wEtAwz6qiljaPQzLk=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=Xtmal4w9ngjiPLDraY0Ol5a9OjksXRTI4jUeVpLnXIJWtQzp5MUEOnaFPyP9JMsuH
	 KIPbH48Alj4mFYtw1/Bhg1AMlkDXC8T2pH83HYFTtJhw3Yfc/WWrgbP2AraSh10vug
	 aGGynT8kau7iyOXGB7WcwifzRZW2qjm5vry341fA=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 42QBj08Y001858
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 26 Mar 2024 06:45:00 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 26
 Mar 2024 06:45:00 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 26 Mar 2024 06:45:00 -0500
Received: from localhost (dhruva.dhcp.ti.com [172.24.227.68])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 42QBixZd053809;
	Tue, 26 Mar 2024 06:44:59 -0500
Date: Tue, 26 Mar 2024 17:14:58 +0530
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
        <linux-trace-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        Qais Yousef <qyousef@layalina.io>
Subject: Re: [PATCH v6 1/5] cpufreq: Add a cpufreq pressure feedback for the
 scheduler
Message-ID: <20240326114458.dfcvpodoihk5tlmz@dhruva>
References: <20240326091616.3696851-1-vincent.guittot@linaro.org>
 <20240326091616.3696851-2-vincent.guittot@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240326091616.3696851-2-vincent.guittot@linaro.org>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi,

On Mar 26, 2024 at 10:16:12 +0100, Vincent Guittot wrote:
> Provide to the scheduler a feedback about the temporary max available
> capacity. Unlike arch_update_thermal_pressure, this doesn't need to be
> filtered as the pressure will happen for dozens ms or more.
> 
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> Acked-by: Rafael J. Wysocki <rafael@kernel.org>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> Reviewed-by: Qais Yousef <qyousef@layalina.io>
> Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
> Tested-by: Lukasz Luba <lukasz.luba@arm.com>
> ---

LGTM,

Reviewed-by: Dhruva Gole <d-gole@ti.com>

-- 
Best regards,
Dhruva

