Return-Path: <linux-kernel+bounces-158505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD7568B215B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 14:08:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A4F02858EF
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 12:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64EFD12D205;
	Thu, 25 Apr 2024 12:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="dA7fJRgS"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26E0912CDAE;
	Thu, 25 Apr 2024 12:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714046801; cv=none; b=kwR19ijU/HiUMB/g/GgQC3BGq+mTVwi0MhkiEwfgQWYx48Dj+9hv+AbtaaVFMI23QvhRDUFUPfeHwvPMxmeZVdDEIEQBts8sO6fEfGgh/Y+Mw5ldAjK942zWwTQxzHKaX02Z+Q1WYmEiUXzqkSqGw2mr4ROAzkWjyO9OYxXqvGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714046801; c=relaxed/simple;
	bh=4jOnxjjtXjkmUlIHjxkZtfD/gWWCPtWUS2GdtYJdUEI=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d0znyvvFbwHxVuXK5jeguCpiTWbGTouP9OQkukJd7giVMtkwHqClPCRTuIshT8wurXpauFayAObMoVHDbVMO73kuX4ezfqIVRKZtXUFiYslnMfsWDM/PK2XhA4vvSbW3S0f4dmE6uy5ZP8SafepOx9iZw+Scw8v6VdWTZ9FJxbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=dA7fJRgS; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43PC6Wke040261;
	Thu, 25 Apr 2024 07:06:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1714046792;
	bh=lyHC/hKqFn4jdVZHq91Jj5fOmrUXRr1HXnaZQElx23c=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=dA7fJRgSM8iSmIJqNuqx3+vdLUsF5WZux0a3sltsj3SwmRoWiQHou6z26D92e3u/Y
	 h+oLTemj3jT3EIsd5BBVfwvEqeVsv5/99R54KBenpUULjHTf+9ATIHWZzPrbaVsda2
	 RrUunOQWDJeMnRsQ3drYebumfF+ZzlJZ215iJXxs=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43PC6WLp010056
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 25 Apr 2024 07:06:32 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 25
 Apr 2024 07:06:32 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 25 Apr 2024 07:06:32 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43PC6WHA032962;
	Thu, 25 Apr 2024 07:06:32 -0500
Date: Thu, 25 Apr 2024 07:06:32 -0500
From: Nishanth Menon <nm@ti.com>
To: Siddharth Vadapalli <s-vadapalli@ti.com>
CC: <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>
Subject: Re: [PATCH v3] arm64: dts: ti: k3-am62p: use eFuse MAC Address for
 CPSW3G Port 1
Message-ID: <20240425120632.wshj2hflo3weq222@parsley>
References: <20240404124614.891416-1-s-vadapalli@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240404124614.891416-1-s-vadapalli@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 18:16-20240404, Siddharth Vadapalli wrote:
> Add the "ethernet-mac-syscon" node within "wkup_conf" node corresponding to
> the CTRLMMR_MAC_IDx registers within the CTRL_MMR space. Assign the
> compatible "ti,am62p-cpsw-mac-efuse" to enable "syscon_regmap" operations
> on these registers. The MAC Address programmed in the eFuse is accessible
> through the CTRLMMR_MAC_IDx registers. The "ti,syscon-efuse" device-tree
> property points to the CTRLMMR_MAC_IDx registers, allowing the CPSW driver
> to fetch the MAC Address and assign it to the network interface associated
> with CPSW3G MAC Port 1.
> 
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>

Please rebase this patch. This no longer applies to  next-20240424
(possibly due to dependencies integrated) - will be good to rebase it
once tomorrow's next is applied.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

