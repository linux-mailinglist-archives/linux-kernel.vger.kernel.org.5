Return-Path: <linux-kernel+bounces-56289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E88E684C857
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 11:12:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4C38286E87
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 10:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E14B024B39;
	Wed,  7 Feb 2024 10:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="YYEr6K84"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A6952555B;
	Wed,  7 Feb 2024 10:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707300733; cv=none; b=s4ZB9SpQb6Rd8ERJzuXIrCnjm1NlcAQTRS7Un7Tf2mFR/g+pIVqjLO5j2+irEI2h2LOnvTnm0Z+9jB3p5X6ZAQBL05czmEnBVOx9E6vOP6vEQOipAE+KYXY4u5oIH5hck6gqXJuB0WoVZM24H/GJpcnPkCRJ/Q9F2fcFUM/LZ7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707300733; c=relaxed/simple;
	bh=6eAa97AAM+Zrppk/jFlzjcGYXEoA6vfzrgMwvLeqPjw=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GfXR00Lg5ZIVnFc5Y6a3ZlDatIcSPTQ0Da4QcQ6tkyiH8ZoZHmM5wryyRn0rlFjN79FzkkIz4SmsNZyZHgVctZLHQ4kss4BIIh0g1hXHwzvIHc6BWD1SU/958eD5Ot1p3gH14VM+BFlH3BltGFxDvMcsHMI9I0zYBgL9+w3SqTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=YYEr6K84; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 417AC3rt109951;
	Wed, 7 Feb 2024 04:12:03 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707300723;
	bh=8KU4np8TMP6PhBPxRc5id+srJ+xGzKni1I+FXO6apvo=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=YYEr6K848fsReEZ73FCffj9PxJrn901DTaeHruDL7p9v06JQBQRrB8pG5op0+9WoR
	 46ItSDB7O1EpYb6pCiQblW8fcDPIJuRVifcp1OGfTXa32x1EadFhF9sOYqYm5v6Mah
	 V1HIZKSZFH8g3FybTK1UTcDo1RBaLjPz9GoCz8+0=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 417AC35m058800
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 7 Feb 2024 04:12:03 -0600
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 7
 Feb 2024 04:12:02 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 7 Feb 2024 04:12:02 -0600
Received: from localhost (dhruva.dhcp.ti.com [172.24.227.68])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 417AC29Q083080;
	Wed, 7 Feb 2024 04:12:02 -0600
Date: Wed, 7 Feb 2024 15:42:01 +0530
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
        Tawfik Bayouk <tawfik.bayouk@mobileye.com>
Subject: Re: [PATCH v2 2/4] spi: cadence-qspi: fix pointer reference in
 runtime PM hooks
Message-ID: <20240207101201.64cpxbns2gnqtoxi@dhruva>
References: <20240205-cdns-qspi-pm-fix-v2-0-2e7bbad49a46@bootlin.com>
 <20240205-cdns-qspi-pm-fix-v2-2-2e7bbad49a46@bootlin.com>
 <20240207084253.fxrnoskda5x6usqo@dhruva>
 <CYYQOHJ4783D.39ZQKS2IK40RV@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CYYQOHJ4783D.39ZQKS2IK40RV@bootlin.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On Feb 07, 2024 at 10:28:59 +0100, Théo Lebrun wrote:
> Hello,
> 
> On Wed Feb 7, 2024 at 9:42 AM CET, Dhruva Gole wrote:
> > On Feb 05, 2024 at 15:57:30 +0100, Théo Lebrun wrote:
> > > dev_get_drvdata() gets used to acquire the pointer to cqspi and the SPI
> > > controller. Neither embed the other; this lead to memory corruption.
> > > 
> > > On a given platform (Mobileye EyeQ5) the memory corruption is hidden
> > > inside cqspi->f_pdata. Also, this uninitialised memory is used as a
> > > mutex (ctlr->bus_lock_mutex) by spi_controller_suspend().
> > > 
> > > Fixes: 2087e85bb66e ("spi: cadence-quadspi: fix suspend-resume implementations")
> > > Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
> > > ---
> > >  drivers/spi/spi-cadence-quadspi.c | 6 ++----
> > >  1 file changed, 2 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
> > > index 720b28d2980c..1a27987638f0 100644
> > > --- a/drivers/spi/spi-cadence-quadspi.c
> > > +++ b/drivers/spi/spi-cadence-quadspi.c
> > > @@ -1930,10 +1930,9 @@ static void cqspi_remove(struct platform_device *pdev)
> > >  static int cqspi_runtime_suspend(struct device *dev)
> > >  {
> > >  	struct cqspi_st *cqspi = dev_get_drvdata(dev);
> > > -	struct spi_controller *host = dev_get_drvdata(dev);
> >
> > Or you could do:
> > +	struct spi_controller *host = cqspi->host;
> 
> Indeed. I preferred minimizing line count as I didn't see a benefit to
> introducing a new variable. It goes away new patch anyway. If you
> prefer it this way tell me and I'll fix it for next revision.

I mean since you're going to have to respin then do make this change, it
will further minimise the number of lines of change right?

It goes away in last patch but if atall in some older kernel only
suspend resume support is there then only this will get picked so it's
still not useless code.


-- 
Best regards,
Dhruva Gole <d-gole@ti.com>

