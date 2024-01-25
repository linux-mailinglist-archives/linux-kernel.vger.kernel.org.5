Return-Path: <linux-kernel+bounces-38669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB82783C3E6
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 14:42:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82E0A28C265
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 13:42:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46B3656473;
	Thu, 25 Jan 2024 13:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="k5c7prwW"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E3255C12
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 13:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706190121; cv=none; b=CChtaI+vs/nUyV/uO8DqqTAWCQFuTf6RyiajD0iwTOoYoY5JAqlumZ5hQ4wme4/24L0CXBdVFh+0mdUlrqT1VTbpvsBsm+Ylpp3uwLRB/vj20TMQiFX9S6Wii2wzfzH+cLHx+fR34hxmB4fM6Yb/klxJW4jGiMfU74XpKxHE11M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706190121; c=relaxed/simple;
	bh=AX1dUumH3CvvkEaRCD4wfnz5Q5mVes9pmuZCVbsMNGM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MpAc4cqwxFEDrZGnkrm8ULQLZzykvqud5Hqswu3icqu6kJq0Yccd2Dz5RFZdJw0+Qvx+1d6d2o3pHDttN9ZN/TOeDH0Sht5EY0v9EcXE02EDeWvRWwV0f4nBNYEfnQOI5RAAWy5otl6jtQdui493w4yqmYv497hF5bZDcSDqtLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=k5c7prwW; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40PDfjrv098713;
	Thu, 25 Jan 2024 07:41:45 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706190105;
	bh=KMIpH3uPlBLfqHYLnBgcr5siGhFQwtREHfy6SYt0Mcg=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=k5c7prwWFeV8uDvMmu6vWceU6vDZajv7UisfL6JUKoux/SAaz50aXhjY1MJa78wfb
	 hlqyQPqhIGIYJTS4hFXW1f6Oaun/Z7B5Jtcfbg9JCVDGlNkdplRwmxizc/cMNLXqnN
	 I5n3nfBjVnl5GgSNWiwC/dYe2p6+qAHLnKmHgd0M=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40PDfjs7071341
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 25 Jan 2024 07:41:45 -0600
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 25
 Jan 2024 07:41:45 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 25 Jan 2024 07:41:45 -0600
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40PDfjQb005570;
	Thu, 25 Jan 2024 07:41:45 -0600
Date: Thu, 25 Jan 2024 07:41:45 -0600
From: Nishanth Menon <nm@ti.com>
To: Arnd Bergmann <arnd@arndb.de>
CC: Andrew Davis <afd@ti.com>, Russell King <linux@armlinux.org.uk>,
        Vignesh
 Raghavendra <vigneshr@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] ARM: configs: keystone: Remove this defconfig
Message-ID: <20240125134145.mjj3ihhdlcabuikz@jovial>
References: <20240124162857.111915-1-afd@ti.com>
 <20240124162857.111915-2-afd@ti.com>
 <20240124164116.k5ah56xvuclfkxdr@despise>
 <0ab47165-3ba3-4d34-aea0-9bc12fd5ff31@ti.com>
 <20240124180451.bptuhldi44leulr3@pectin>
 <5f5a2ecd-7878-46ba-9a85-a2a4ba060ad7@ti.com>
 <3cc8741e-6866-4068-9226-d46b68b7c801@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <3cc8741e-6866-4068-9226-d46b68b7c801@app.fastmail.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 20:56-20240124, Arnd Bergmann wrote:
> On Wed, Jan 24, 2024, at 19:52, Andrew Davis wrote:
> > On 1/24/24 12:04 PM, Nishanth Menon wrote:
> >> On 11:31-20240124, Andrew Davis wrote:
> >>> On 1/24/24 10:41 AM, Nishanth Menon wrote:
> >>>>
> >>>> There are a bunch of downstream folks who will have recipe fails etc if
> >>>> we do that. I am not sure we need to go down that route.
> >>>>
> >>>
> >>> That is the point of this patch, we want to stop any remaining downstream
> >>> folks from using this defconfig. It is not maintained nor updated like
> >>> the multi_v7_defconfig, any new or needed options will only be added to
> >>> multi-v7 defconfig.
> >>>
> >> 
> >> I am going to have to defer to ARM maintainers what they think..
> >> enabling LPAE etc in common multi_v7_config.
> >> 
> >
> > We are not enabling LPAE in common multi_v7_config, that can't be
> > done as many plats do not support it. Keystone will use the new
> > multi_v7_lpae_defconfig which was just added:
> >
> > e9faf9b0b07a ("ARM: add multi_v7_lpae_defconfig")
> >
> > That is what prompted me to make this change, we now have a
> > commonish config that works for Keystone.
> 
> I think adding keystone to multi_v7_defconfig is a good
> idea here for the reasons you explained. I don't mind keeping
> the other one around as well though, since keystone is
> a bit special.

Thanks Arnd.

Andrew,

Could you respin the series with just patch #1 and with the bloatmeter
details added to the commit message (please leave in NFS - that was
the standard operation mode for most of CI systems - I'd like to
continue leveraging that than have to hand test platforms.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

