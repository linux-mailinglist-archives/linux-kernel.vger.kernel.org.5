Return-Path: <linux-kernel+bounces-82711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BAE0868877
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 06:03:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 023421F25299
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 05:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9191252F72;
	Tue, 27 Feb 2024 05:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Jckyg9de"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 518E66FC6;
	Tue, 27 Feb 2024 05:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709010205; cv=none; b=UyKCWL7zevOK6gZFCbSJ3J+9IMTQdJ6rAAtgPPUiq+SrMjY/uh5bZJm/y6yCQ4aQi/ZAsqAojNpK09P/nB7H3TTHbeiB53uteg5jrGpLMZaQcG9G/9eobMZfCs7t4Q/q90cC9SXWTW53nEXh+sTUJgs5z/hXV+TZSXfR2G4bvY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709010205; c=relaxed/simple;
	bh=zn+LZ68INYGtLFzMzpG5jHrDf2H85SB8RON2Z4Njto4=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UGzEY2JrUz/mEdYKb1dYvg9igMz0VvXcQeGlXB4mzYtm3vMS/ophsSwrfUuCCaGXihwe2H5+mE0fJ9K3PISVEWHTrD5DGAP6MiuAcnRVbMjPvzch5jg3NYr21n+SczYe6+gk/o3WK7ONX/uUrK0Ys9OAw243o2m3pN/jhMPZ9nA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Jckyg9de; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41R5394p060557;
	Mon, 26 Feb 2024 23:03:09 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1709010189;
	bh=qVKe4exgb9ItG/EjAGjjBRmDC+GWBLdlO5at6pUwauw=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=Jckyg9de/NCsnknpzJ90E1XnCxF/cR1dYi35jtXcuwAvPwarWXNb2fTsulGAf8gkI
	 LacO6TryTuEv5bZDvpFahAknR8r2kuK7OBajkcxUi9HHRXQhf/dvML8dmVz4VhWZgy
	 /drqzxBCRWiqjETKKW+VSqp1cJt0zx90I5Z+KfAI=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41R539Tx116288
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 26 Feb 2024 23:03:09 -0600
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 26
 Feb 2024 23:03:09 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 26 Feb 2024 23:03:09 -0600
Received: from localhost (dhruva.dhcp.ti.com [172.24.227.68])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41R538eW026596;
	Mon, 26 Feb 2024 23:03:09 -0600
Date: Tue, 27 Feb 2024 10:33:08 +0530
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
Message-ID: <20240227050308.js4stf4men446efh@dhruva>
References: <20240222-cdns-qspi-pm-fix-v4-0-6b6af8bcbf59@bootlin.com>
 <170862920925.104158.14642580909914879148.b4-ty@kernel.org>
 <20240226121803.5a7r5wkpbbowcxgx@dhruva>
 <69f3dcd7-b79f-4b4f-aecb-dc559d74e6e4@sirena.org.uk>
 <cb74a9f9-abfa-4a94-b4a9-bf41ddc697eb@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cb74a9f9-abfa-4a94-b4a9-bf41ddc697eb@sirena.org.uk>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi,

On Feb 26, 2024 at 13:40:00 +0000, Mark Brown wrote:
> On Mon, Feb 26, 2024 at 01:27:57PM +0000, Mark Brown wrote:
> > On Mon, Feb 26, 2024 at 05:48:03PM +0530, Dhruva Gole wrote:
> > > On Feb 22, 2024 at 19:13:29 +0000, Mark Brown wrote:
> 
> > [    1.709414] Call trace:
> > [    1.711852]  __mutex_lock.constprop.0+0x84/0x540
> > [    1.716460]  __mutex_lock_slowpath+0x14/0x20
> > [    1.720719]  mutex_lock+0x48/0x54
> > [    1.724026]  spi_controller_suspend+0x30/0x7c
> > [    1.728377]  cqspi_suspend+0x1c/0x6c
> > [    1.731944]  pm_generic_runtime_suspend+0x2c/0x44
> > [    1.736640]  genpd_runtime_suspend+0xa8/0x254
> 
> > (it's generally helpful to provide the most relevant section directly.)
> 
> > The issue here appears to be that we've registered for runtime suspend
> > prior to registering the controller...
> 
> Actually, no - after this series cqspi_suspend() is the system not
> runtime PM operation and should not be called from runtime suspend.  How
> is that happening?

I tried dropping this entire series, it doesn't really solve the kernel
boot issues. Also this particular stack dump isn't easily reproducible
either. Perhaps this series may not be the rootcause, I will need some
more time to see what's breaking boot for us.

But for now this series seems to be in the clear. Will keep you posted
if I find anything funny here.

FYI- We're just using the arm64 defconfig and respective device DTs


-- 
Best regards,
Dhruva Gole <d-gole@ti.com>

