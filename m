Return-Path: <linux-kernel+bounces-87942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0238586DB42
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 06:51:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DDAC1F239E6
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 05:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5758151C5E;
	Fri,  1 Mar 2024 05:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="KaB+2CkX"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E77BE5102B;
	Fri,  1 Mar 2024 05:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709272259; cv=none; b=CdCpDIokjkyJX4aGCwFt6jh8rgbpnpIzK6tS4ySHgjle0TRE5jbH7CVEPIfvswOCUD1f+VYkvjIomU6eaht4Uxfs9Y9S5JzzC8cA2FJ3Rd8AWOGHU6GVgpLvWMGpIsZ+WPEqSsrOL0hRT2T16FDbbDkudp0oNM2UR/UpW5w4CC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709272259; c=relaxed/simple;
	bh=cy8RvHTQeOlKoMUvyR4FX+JMJkf0W5FUeBWmR+7NzR8=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V1YdQCwHQMl31N3EAOrMdsdw+6OFA4M661aOHE+z5XnqICwDl32aDLdZAxiXH2Q0KUxROH9aG8mKTqhUeWJfjvWu/X1u46qicT4GrDWfDKlesM0gBh9brb8lL1TKhB5I/2tee6Lqc/Gs8D8LGY8QRS/inGxiuBap+3bh/UmRJ34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=KaB+2CkX; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4215oilY022069;
	Thu, 29 Feb 2024 23:50:44 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1709272244;
	bh=l/IHIBNQJg2GWl1+ZS5pYPMdeQurLluEVUepeTAXvHo=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=KaB+2CkXuTLYb2EyCmjhLUOc8TMiVsV19V9k4dXsRxaVZ/+1kJEkTcOgIdUlxmsuM
	 8onmuJ1MwgGheZBXd7nvdCSbSgg0L4EINRBkTl9pvBhiJjhw3xq1L9SfT+8g58MYYW
	 drKHhYFKjWYTPIgxXbKvljIgx0tnaU/1FcwQzsZo=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4215oiPr079739
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 29 Feb 2024 23:50:44 -0600
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 29
 Feb 2024 23:50:44 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 29 Feb 2024 23:50:44 -0600
Received: from localhost (dhruva.dhcp.ti.com [172.24.227.68])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4215ohEY032418;
	Thu, 29 Feb 2024 23:50:43 -0600
Date: Fri, 1 Mar 2024 11:20:42 +0530
From: Dhruva Gole <d-gole@ti.com>
To: Viresh Kumar <viresh.kumar@linaro.org>
CC: "Rafael J. Wysocki" <rafael@kernel.org>, <linux-pm@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Daniel Lezcano
	<daniel.lezcano@linaro.org>,
        Manaf Meethalavalappu Pallikunhi
	<quic_manafm@quicinc.com>,
        Roman Stratiienko <r.stratiienko@gmail.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cpufreq: Don't unregister cpufreq cooling on CPU hotplug
Message-ID: <20240301055042.p4jaa4v3tshlbwnb@dhruva>
References: <1333a397b93e0e15cb7cb358e21a289bc7d71a63.1709193295.git.viresh.kumar@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1333a397b93e0e15cb7cb358e21a289bc7d71a63.1709193295.git.viresh.kumar@linaro.org>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi,

On Feb 29, 2024 at 13:42:07 +0530, Viresh Kumar wrote:
> Offlining a CPU and bringing it back online is a common operation and it
> happens frequently during system suspend/resume, where the non-boot CPUs
> are hotplugged out during suspend and brought back at resume.
> 
> The cpufreq core already tries to make this path as fast as possible as
> the changes are only temporary in nature and full cleanup of resources
> isn't required in this case. For example the drivers can implement
> online()/offline() callbacks to avoid a lot of tear down of resources.
> 
> On similar lines, there is no need to unregister the cpufreq cooling
> device during suspend / resume, but only while the policy is getting
> removed.
> 
> Moreover, unregistering the cpufreq cooling device is resulting in an
> unwanted outcome, where the system suspend is eventually aborted in the
> process.  Currently, during system suspend the cpufreq core unregisters
> the cooling device, which in turn removes a kobject using device_del()
> and that generates a notification to the userspace via uevent broadcast.
> This causes system suspend to abort in some setups.
> 
> This was also earlier reported (indirectly) by Roman [1]. Maybe there is
> another way around to fixing that problem properly, but this change
> makes sense anyways.
> 
> Move the registering and unregistering of the cooling device to policy
> creation and removal times onlyy.
> 
> Reported-by: Manaf Meethalavalappu Pallikunhi <quic_manafm@quicinc.com>
> Reported-by: Roman Stratiienko <r.stratiienko@gmail.com>
> Link: https://patchwork.kernel.org/project/linux-pm/patch/20220710164026.541466-1-r.stratiienko@gmail.com/ [1]
> Tested-by: Manaf Meethalavalappu Pallikunhi <quic_manafm@quicinc.com>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---

Makes sense to me,

Reviewed-by: Dhruva Gole <d-gole@ti.com>

-- 
Best regards,
Dhruva Gole <d-gole@ti.com>

