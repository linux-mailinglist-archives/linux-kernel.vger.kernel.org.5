Return-Path: <linux-kernel+bounces-56125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 39D2D84C65C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 09:39:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BE6E1C247ED
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 08:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A54CD208AB;
	Wed,  7 Feb 2024 08:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="XLbT1eeP"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1181208AD;
	Wed,  7 Feb 2024 08:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707295153; cv=none; b=m/MfHch615QN1+KJr9mTCpoj71MIzkJDWi9b8un9GBDo4qDgZv/TnUxlSmJubS1JDZKVJDq53Juudj4Sjfjng3sLCiDszvxlF5B54EX2uYutojzuPY5Z6oZCubZ+4mbSahm5o9tleIIIxyw1WxviZiUpGdr9iujFmOnnZrts5i4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707295153; c=relaxed/simple;
	bh=UcEcxwfB44HAyxzZ17CF5HCeMmAR7TRKz/jsE1aTWb0=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UiK0R5IiOkES4ydhKa87POvv9uovWfGhSPOVq6o9RENY4dUaDOJk5koDz/VGYaXLlzrG8wW/kzgYeMNEbUE316+SuXShIBSxvtycPCp+JLEuGptPCZ9mrstFoJhCeXkEycoXV1yFxySahdrxXOa+J/TC9Sv+Gon1KdsAFw2qI4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=XLbT1eeP; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4178d4Fl124506;
	Wed, 7 Feb 2024 02:39:04 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707295144;
	bh=6jXB9uF19lFysemaCo/GiNCOHv8JgQSc8aqtsrUA7M0=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=XLbT1eePzgVZPz/atNM0eh+8aFs61oTMhOe67578pW8r6rxuf43YhZmvCh5dhIEus
	 jNEYTdEVpbSRSRWkRYWn6j/O/dNbCWLK7Qs6/zMXGN3I70oi4gnFnFEY8YfIktgq4a
	 EvTmxeKviDrbzFTnVY8ERvuXEm2tIIJEhsZq9L5M=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4178d4qY059687
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 7 Feb 2024 02:39:04 -0600
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 7
 Feb 2024 02:39:04 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 7 Feb 2024 02:39:04 -0600
Received: from localhost (dhruva.dhcp.ti.com [172.24.227.68])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4178d3oU070309;
	Wed, 7 Feb 2024 02:39:03 -0600
Date: Wed, 7 Feb 2024 14:09:02 +0530
From: Dhruva Gole <d-gole@ti.com>
To: Mark Brown <broonie@kernel.org>
CC: =?utf-8?B?VGjDqW8=?= Lebrun <theo.lebrun@bootlin.com>,
        Apurva Nandan
	<a-nandan@ti.com>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Gregory CLEMENT
	<gregory.clement@bootlin.com>,
        Vladimir Kondratiev
	<vladimir.kondratiev@mobileye.com>,
        Thomas Petazzoni
	<thomas.petazzoni@bootlin.com>,
        Tawfik Bayouk <tawfik.bayouk@mobileye.com>
Subject: Re: [PATCH v2 2/4] spi: cadence-qspi: fix pointer reference in
 runtime PM hooks
Message-ID: <20240207083902.mzkcsqf3tbwkkxd2@dhruva>
References: <20240205-cdns-qspi-pm-fix-v2-0-2e7bbad49a46@bootlin.com>
 <20240205-cdns-qspi-pm-fix-v2-2-2e7bbad49a46@bootlin.com>
 <ZcD6yqc+o62x2AjA@finisterre.sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZcD6yqc+o62x2AjA@finisterre.sirena.org.uk>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Mark,

On Feb 05, 2024 at 15:12:10 +0000, Mark Brown wrote:
> On Mon, Feb 05, 2024 at 03:57:30PM +0100, Théo Lebrun wrote:
> > dev_get_drvdata() gets used to acquire the pointer to cqspi and the SPI
> > controller. Neither embed the other; this lead to memory corruption.
> > 
> > On a given platform (Mobileye EyeQ5) the memory corruption is hidden
> > inside cqspi->f_pdata. Also, this uninitialised memory is used as a
> > mutex (ctlr->bus_lock_mutex) by spi_controller_suspend().
> 
> Please place fixes at the start of serieses so that they don't end up
> with spurious dependencies on other changes and can more easily be
> applied as fixes.

Didn't really understand the comment here, aren't the 1,2 and 3 patches
fixes and the last one the non-fix? Thus fixes are indeed placed at
start of this series right?

Can you help understand with some example series?

-- 
Best regards,
Dhruva Gole <d-gole@ti.com>

