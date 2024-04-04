Return-Path: <linux-kernel+bounces-131111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1ED7898335
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 10:35:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EEFC28C4D3
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 08:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4764B6D1B4;
	Thu,  4 Apr 2024 08:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="tZzNUlr7"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC9665D73B;
	Thu,  4 Apr 2024 08:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712219703; cv=none; b=syVA9JVssUyOu7XtxsNG7d1rW1mpdPeXAj28lB9ZKMBofBvD3ZW+oFev47D/le6eUnJ1S65GTHDJaMC8zg05kWcaRcAIvQZwXMi4TbSJw3OYAx99gDfxLqmHwvci6ZBo4iCr4982wI4QB/XoqdM1c/DqWW0LbNg2dNyKi/sArJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712219703; c=relaxed/simple;
	bh=DQTSSWiiWCkefrYnZPQVvZGHFdYfwKXX7rU+vuILK3c=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CuN0aSgtzx9KdQyiPbbl1gCogvN86YqHNuawKbMpr1//l9oWg3kMUpNX9GLOfv7qCInDGX2nLVYWLUZwrG+XM92rGOtNlMirSNa6Pm1bNA03eO5NoGxbB1HIifZ3QzrpeojYTO4OrluhF4vPgp0qCc4VGuG9IhS6hlvp20+6XYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=tZzNUlr7; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4348YhOQ103551;
	Thu, 4 Apr 2024 03:34:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1712219683;
	bh=zKEXPE9es174/NXvmXcWvCz01yqeUuHdClVxb0krZBo=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=tZzNUlr7qNGsNyN7127Sjasos5RTHym4CSOzBPRJrUoJfif13JP1pFbZhDyP0CGad
	 3eQR+GaxYysbaW4r+Q0VECs6szrbHLo+Pel2HdPJaKImcAYcjGS6MX5bd7gXX2z4KY
	 cF+5DA7YSE/08NSvQBPmioAqBjdokvJ/xQ1HPc4Q=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4348YhOv039372
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 4 Apr 2024 03:34:43 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 4
 Apr 2024 03:34:43 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 4 Apr 2024 03:34:43 -0500
Received: from localhost (uda0492258.dhcp.ti.com [172.24.227.9])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4348Yg4W089889;
	Thu, 4 Apr 2024 03:34:42 -0500
Date: Thu, 4 Apr 2024 14:04:42 +0530
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: Vignesh Raghavendra <vigneshr@ti.com>
CC: Siddharth Vadapalli <s-vadapalli@ti.com>, <nm@ti.com>, <kristo@kernel.org>,
        <robh@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <srk@ti.com>
Subject: Re: [PATCH] arm64: dts: ti: k3-am62p-main: use eFuse MAC Address for
 CPSW3G Port 1
Message-ID: <77abfbd6-ee24-4a25-a05b-51bd7716a26f@ti.com>
References: <20240402094200.4036076-1-s-vadapalli@ti.com>
 <ae04c041-688c-4413-8f15-b37b4ea44aac@ti.com>
 <f7cadda8-c3cf-48a0-846a-1ff317a28292@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <f7cadda8-c3cf-48a0-846a-1ff317a28292@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On Tue, Apr 02, 2024 at 04:02:07PM +0530, Siddharth Vadapalli wrote:
> On Tue, Apr 02, 2024 at 03:25:41PM +0530, Vignesh Raghavendra wrote:
> > 
> > 
> > On 02/04/24 15:12, Siddharth Vadapalli wrote:
> > > Assign the MAC Address programmed in the eFuse registers as the default
> > > MAC Address for CPSW3G MAC Port 1. Utilize the "ti,syscon-efuse"
> > > device-tree property to do so.
> > > 
> > > Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> > > ---
> > > 
> > > This patch is based on linux-next tagged next-20240402.
> > > 
> > > Regards,
> > > Siddharth.
> > > 
> > >  arch/arm64/boot/dts/ti/k3-am62p-main.dtsi | 1 +
> > >  1 file changed, 1 insertion(+)
> > > 
> > > diff --git a/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi
> > > index 7337a9e13535..eb126f4a04dd 100644
> > > --- a/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi
> > > +++ b/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi
> > > @@ -696,6 +696,7 @@ cpsw_port1: port@1 {
> > >  				label = "port1";
> > >  				phys = <&phy_gmii_sel 1>;
> > >  				mac-address = [00 00 00 00 00 00];
> > > +				ti,syscon-efuse = <&wkup_conf 0x200>;
> > 
> > Sorry, how does this work? wkup_conf is not marked as "syscon" compatible?
> 
> Sorry I failed to realize that. So this will also require adding a
> custom property similar to:
> https://github.com/torvalds/linux/commit/cc1965b02d6cb18d9220dae06f7e2e0b0ebbea48
> followed by adding a new sub-node within wkup_conf corresponding to the
> MAC Address CTRL_MMR registers.
> 
> Thank you for reviewing the patch and pointing this out.

I have posted the v2 patch at:
https://patchwork.kernel.org/project/linux-arm-kernel/patch/20240404081845.622707-1-s-vadapalli@ti.com/
verifying that the MAC Address present in the CTRLMMR_MAC_IDx registers
is assigned to the network interface corresponding to CPSW3G MAC Port 1.

Regards,
Siddharth.

