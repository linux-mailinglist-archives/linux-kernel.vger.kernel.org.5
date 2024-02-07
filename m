Return-Path: <linux-kernel+bounces-56292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CCB8184C85D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 11:14:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A38C2884C3
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 10:14:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5056E24B2A;
	Wed,  7 Feb 2024 10:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="vwamRFRm"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E006A24B34;
	Wed,  7 Feb 2024 10:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707300874; cv=none; b=UYbIq7fuNTd1Y7cQTS+vmrW+LGoc1/VvNpDQUZy69bRjkxnxDlDvy22c+SE2fOfmduZ6Ffq3HwN+IXbBSgvVLs8mM5xS/SCwkumxmkkDVgbh0GXReoN7JXplXV6PYDuYwICtLaQdSyd7KpuE8J27sheE9GJ0Eo7WPKOVxASWLWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707300874; c=relaxed/simple;
	bh=P183eMW6DaHUYF92qSRTkmhYeCW8erNWQol9I2XOFuQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mo4oca5su4KsnKlBBh2QVxRP7TA+Rb0MFvjf96xkok0ozbm4fcnhlNsNVAVxMwCSUTNMi4heWooLZMmQYTaRF8JT40cP3dN8rLsn/x1PPDky2b9ocv/o2yx5glDOI3p/hoevScg/SZq+Nur40gAXaV7RP6rlbG54IByfBY/g5kM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=vwamRFRm; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 417AEK1C070828;
	Wed, 7 Feb 2024 04:14:20 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707300860;
	bh=Iq6ybKkO1aW9WfaqZp6GVQH0nzFKXX1+rPSibyuIf50=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=vwamRFRmh+OBAViUS77VQ6kCPdIbf4gucoFwx7kmXTnDrJaRRe+7XUopSQlcKFgJk
	 c2xf3OUieAJFn257lKtDHGbUBnMRn9eaW29dQbZFLHmrXKR9HM6wf89KzIEZ+6WcOb
	 R/+LCVlVKkjj7iOAeo4a2wI9MvNrbLEa5qHqk4tI=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 417AEJXr029380
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 7 Feb 2024 04:14:19 -0600
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 7
 Feb 2024 04:14:18 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 7 Feb 2024 04:14:19 -0600
Received: from localhost (dhruva.dhcp.ti.com [172.24.227.68])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 417AEIaw085890;
	Wed, 7 Feb 2024 04:14:18 -0600
Date: Wed, 7 Feb 2024 15:44:17 +0530
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
Message-ID: <20240207101417.tn5z5cpauqmno7dn@dhruva>
References: <20240205-cdns-qspi-pm-fix-v2-0-2e7bbad49a46@bootlin.com>
 <20240205-cdns-qspi-pm-fix-v2-2-2e7bbad49a46@bootlin.com>
 <ZcD6yqc+o62x2AjA@finisterre.sirena.org.uk>
 <20240207083902.mzkcsqf3tbwkkxd2@dhruva>
 <ZcNSWPucn6Vg43Wu@finisterre.sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZcNSWPucn6Vg43Wu@finisterre.sirena.org.uk>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hey,

On Feb 07, 2024 at 09:50:16 +0000, Mark Brown wrote:
> On Wed, Feb 07, 2024 at 02:09:02PM +0530, Dhruva Gole wrote:
> > On Feb 05, 2024 at 15:12:10 +0000, Mark Brown wrote:
> 
> > > Please place fixes at the start of serieses so that they don't end up
> > > with spurious dependencies on other changes and can more easily be
> > > applied as fixes.
> 
> > Didn't really understand the comment here, aren't the 1,2 and 3 patches
> > fixes and the last one the non-fix? Thus fixes are indeed placed at
> > start of this series right?
> 
> Patch 1 is a rename, this is obviously cosmetic and not a bug fix.


Well, Theo, seems like you better fix the first patch, then reorder and
send a v3 :)


-- 
Best regards,
Dhruva Gole <d-gole@ti.com>

