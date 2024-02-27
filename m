Return-Path: <linux-kernel+bounces-83154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CD1A868F95
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 13:00:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26B01281ACB
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 12:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 149E713A257;
	Tue, 27 Feb 2024 12:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="X0no55qn"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EE0E13A248;
	Tue, 27 Feb 2024 12:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709035216; cv=none; b=UOHDhOh7fSN3bEuojbMqXnPxNKb6xL/4ka1fr7cWLvlUwcDg3unBkkaydSxgFMalcYM6SeeSWsmyuzdjq67rJkbw9HqWWffkLWdWCXJCNCygvTbpRWStsFEA7UwvSoevlgifZEiToHRAioJ7eLO0LvV+xoZ9QugyXmqzoIGB+0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709035216; c=relaxed/simple;
	bh=pOszhTKQNEu35qb/7owM5gJ7ykZzlWstTGz0UrU/dnA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AnZzVOICfVt/mGr5Tk8XBHS5t1oF8pRWRUa3fBbODbHEAWx3KIKDJMZRCkSrUKPJaLpSoGvboHz8d+zaHrlbJJpdZh11hK6IdoJDu/Gq78WB/LmEAeT07NHDxRUlynlbeaYqsu+jjORs0CiUW0y8h3XomdWgoVBZ77Lww7kfe8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=X0no55qn; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41RC05ae078257;
	Tue, 27 Feb 2024 06:00:05 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1709035205;
	bh=t2FUyV8TLdZWr/wvgxXZeazI21EEdXnm1V1u8CFX4ww=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=X0no55qn0A2dlHsqdoUMVaFW65/7jjULcAe2CdFVPCP/WMJjUWVnAkiYttpL6Mnt8
	 smRmXhwHVHhylUavvhJMXxaz3UJ5bIKs8HNePbXbIB6ZMTPIbBpYwYJFErSIhkmY5o
	 0EdL2wmsinQB4GhTHP9//FkFt6EAQE4TWrAt23vI=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41RC03f6028611
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 27 Feb 2024 06:00:04 -0600
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 27
 Feb 2024 06:00:04 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 27 Feb 2024 06:00:04 -0600
Received: from localhost (dhruva.dhcp.ti.com [172.24.227.68])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41RC03Om050421;
	Tue, 27 Feb 2024 06:00:03 -0600
Date: Tue, 27 Feb 2024 17:30:01 +0530
From: Dhruva Gole <d-gole@ti.com>
To: =?utf-8?B?VGjDqW8=?= Lebrun <theo.lebrun@bootlin.com>
CC: Mark Brown <broonie@kernel.org>, Apurva Nandan <a-nandan@ti.com>,
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
Message-ID: <20240227120001.rozlhxfyf6edwvzc@dhruva>
References: <20240222-cdns-qspi-pm-fix-v4-0-6b6af8bcbf59@bootlin.com>
 <170862920925.104158.14642580909914879148.b4-ty@kernel.org>
 <20240226121803.5a7r5wkpbbowcxgx@dhruva>
 <CZF1U6LPB3XB.1BXJPWRGB4TH@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CZF1U6LPB3XB.1BXJPWRGB4TH@bootlin.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi,

On Feb 26, 2024 at 14:36:17 +0100, Théo Lebrun wrote:
> Hello Dhruva,
> 
> On Mon Feb 26, 2024 at 1:18 PM CET, Dhruva Gole wrote:
> > Hi Mark, Theo,
> >
> > + Nishanth, Vignesh (maintainers of TI K3)
> >
> > On Feb 22, 2024 at 19:13:29 +0000, Mark Brown wrote:
> > > On Thu, 22 Feb 2024 11:12:28 +0100, Théo Lebrun wrote:
> > > > This fixes runtime PM and system-wide suspend for the cadence-qspi
> > > > driver. Seeing how runtime PM and autosuspend are enabled by default, I
> > > > believe this affects all users of the driver.
> > > > 
> > > > This series has been tested on both Mobileye EyeQ5 hardware and the TI
> > > > J7200 EVM board, under s2idle.
> > > > 
> > > > [...]
> > > 
> > > Applied to
> > > 
> > >    https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next
> > > 
> > > Thanks!
> > > 
> > > [1/4] spi: cadence-qspi: fix pointer reference in runtime PM hooks
> > >       commit: 32ce3bb57b6b402de2aec1012511e7ac4e7449dc
> > > [2/4] spi: cadence-qspi: remove system-wide suspend helper calls from runtime PM hooks
> > >       commit: 959043afe53ae80633e810416cee6076da6e91c6
> > > [3/4] spi: cadence-qspi: put runtime in runtime PM hooks names
> > >       commit: 4efa1250b59ebf47ce64a7b6b7c3e2e0a2a9d35a
> > > [4/4] spi: cadence-qspi: add system-wide suspend and resume callbacks
> > >       commit: 078d62de433b4f4556bb676e5dd670f0d4103376
> >
> > It seems like between 6.8.0-rc5-next-20240220 and
> > 6.8.0-rc5-next-20240222 some of TI K3 platform boot have been broken.
> >
> > It particularly seemed related to these patches because we can see
> > cqspi_probe in the call trace and also cqspi_suspend toward the top.
> >
> > See logs for kernel crash in [0] and working in [1]
> 
> I'm guessing we are talking about tags next-20240220 and next-20240222
> on: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/
> 
> Neither of those tags include the patches about fixing PM hooks.
> 
>    ⟩ # next-20240220
>    ⟩ git log --oneline --author theo.lebrun 2d5c7b7eb345 \
>       drivers/spi/spi-cadence-quadspi.c
> 
>    ⟩ # next-20240222
>    ⟩ git log --oneline --author theo.lebrun e31185ce00a9 \
>       drivers/spi/spi-cadence-quadspi.c
>    0f3841a5e115 spi: cadence-qspi: report correct number of chip-select
>    7cc3522aedb5 spi: cadence-qspi: set maximum chip-select to 4
>    0d62c64a8e48 spi: cadence-qspi: assert each subnode flash CS is valid
>    ⟩ # Those are unrelated patches.
> 
> Also it shows from the calltrace: this series renames the runtime
> suspend/resume hooks to cqspi_runtime_* while the callstack you gave
> talks about cqspi_suspend. It only gets called at system-wide suspend
> following this series.
> 
> My guess is that this series will rather fix the issue that you are now
> facing. :-) Could you try applying them and checking if that fixes your
> error?

Indeed, it seems like kernelci generated 22Feb and no future builds in
our case hence we were not testing the -next with your patches applied.

Please pardon the confusion.

The boot logs are here with local linux build from 27 Feb -next:

https://gist.github.com/DhruvaG2000/78ef6f2953b0940ef8ea38797f2ec6cb

It does seem like these patches help us fix the previous regressions.
Thanks for the fixes.


-- 
Best regards,
Dhruva Gole <d-gole@ti.com>

