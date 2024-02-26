Return-Path: <linux-kernel+bounces-81351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60FED867497
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 13:18:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3618B236B0
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 12:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A439A604BB;
	Mon, 26 Feb 2024 12:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="fTgua61J"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 639091B27D;
	Mon, 26 Feb 2024 12:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708949895; cv=none; b=l66wRw84cTI/n0EAhFtjtNQty6lc9zXfdULoD7C4HJvGCAK1gkzfbXefKeAT+Sy9pT55SVqcfDnaOWhqV0XSg26iylMDJT5y57N0ZFROE3XWewrdODgjj1KIan37XGf1HTysNe/25nEOmqaS3FwPL9PAPNOzO4YgHy3pi1wlzEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708949895; c=relaxed/simple;
	bh=xCIWZpRxxNMSN7ob6nQ9iTG5SjMeUWZcqa1ESiv8Yps=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YK/vBnoYLxQ/Sp5ebhYbITnijcAUVG6uX9Vnubd45DRT8oNh9oOhSQO959VPnBdkZUOLV8kQ2FNQlHjKcQ+8ZFN6GOZ1Vd8vZanpE/nUbLUmXHH5HakRS64CY81EnLQIAYKwrM/NOk5PeBuWHMx+B8McCmLC4IEpTob8/bQHhm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=fTgua61J; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41QCI5TJ102410;
	Mon, 26 Feb 2024 06:18:05 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1708949885;
	bh=RFNVTfrO40yGnidmOJOOJB8JPl52qtzEiSN04cylThM=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=fTgua61Jk7NokrswsOrAn/pZRfeoXnlrOZJmkfBq8EZKcloAt/35uKzF8gGyJRnLU
	 /elxbwHJiMAuaFxHsZp2ibdCQ5bnxCtR5HuosOqaS96tRAYXkxjCNJNlEjzAGeaAta
	 r6MqNWI/F5gAu7n3wsP7FF4yh0CfSWXGBeRB6eZU=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41QCI5Oo120329
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 26 Feb 2024 06:18:05 -0600
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 26
 Feb 2024 06:18:05 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 26 Feb 2024 06:18:05 -0600
Received: from localhost (dhruva.dhcp.ti.com [172.24.227.68])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41QCI4of081093;
	Mon, 26 Feb 2024 06:18:05 -0600
Date: Mon, 26 Feb 2024 17:48:03 +0530
From: Dhruva Gole <d-gole@ti.com>
To: Mark Brown <broonie@kernel.org>
CC: Apurva Nandan <a-nandan@ti.com>,
        =?utf-8?B?VGjDqW8=?= Lebrun
	<theo.lebrun@bootlin.com>,
        <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Gregory CLEMENT
	<gregory.clement@bootlin.com>,
        Vladimir Kondratiev
	<vladimir.kondratiev@mobileye.com>,
        Thomas Petazzoni
	<thomas.petazzoni@bootlin.com>,
        Tawfik Bayouk <tawfik.bayouk@mobileye.com>, Nishanth <nm@ti.com>,
        Vignesh <vigneshr@ti.com>
Subject: Re: [PATCH v4 0/4] spi: cadence-qspi: Fix runtime PM and system-wide
 suspend
Message-ID: <20240226121803.5a7r5wkpbbowcxgx@dhruva>
References: <20240222-cdns-qspi-pm-fix-v4-0-6b6af8bcbf59@bootlin.com>
 <170862920925.104158.14642580909914879148.b4-ty@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <170862920925.104158.14642580909914879148.b4-ty@kernel.org>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Mark, Theo,

+ Nishanth, Vignesh (maintainers of TI K3)

On Feb 22, 2024 at 19:13:29 +0000, Mark Brown wrote:
> On Thu, 22 Feb 2024 11:12:28 +0100, Théo Lebrun wrote:
> > This fixes runtime PM and system-wide suspend for the cadence-qspi
> > driver. Seeing how runtime PM and autosuspend are enabled by default, I
> > believe this affects all users of the driver.
> > 
> > This series has been tested on both Mobileye EyeQ5 hardware and the TI
> > J7200 EVM board, under s2idle.
> > 
> > [...]
> 
> Applied to
> 
>    https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next
> 
> Thanks!
> 
> [1/4] spi: cadence-qspi: fix pointer reference in runtime PM hooks
>       commit: 32ce3bb57b6b402de2aec1012511e7ac4e7449dc
> [2/4] spi: cadence-qspi: remove system-wide suspend helper calls from runtime PM hooks
>       commit: 959043afe53ae80633e810416cee6076da6e91c6
> [3/4] spi: cadence-qspi: put runtime in runtime PM hooks names
>       commit: 4efa1250b59ebf47ce64a7b6b7c3e2e0a2a9d35a
> [4/4] spi: cadence-qspi: add system-wide suspend and resume callbacks
>       commit: 078d62de433b4f4556bb676e5dd670f0d4103376

It seems like between 6.8.0-rc5-next-20240220 and
6.8.0-rc5-next-20240222 some of TI K3 platform boot have been broken.

It particularly seemed related to these patches because we can see
cqspi_probe in the call trace and also cqspi_suspend toward the top.

See logs for kernel crash in [0] and working in [1]


[0] https://gist.github.com/DhruvaG2000/ed997452b41d6e5301598225fc579800
[1] https://gist.github.com/DhruvaG2000/d4e73111aeafaca555ba2d5208deb6dd

-- 
Best regards,
Dhruva Gole <d-gole@ti.com>

