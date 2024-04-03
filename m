Return-Path: <linux-kernel+bounces-129084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C30189648D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 08:32:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 779F11C214EF
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 06:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F54517BC2;
	Wed,  3 Apr 2024 06:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="FyYXXbpd"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D85933F9;
	Wed,  3 Apr 2024 06:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712125970; cv=none; b=XrFauUMsb+IDETPuxsbBxGtEGIMdeIFT3/J4U+rtPGPv8PGwYZ17ZLFIOrt1KwfjaxaeFtaSnS3tIyLpcJp4KwdeyXOARaNXFZ7fVEye9LF1uTL3uBjXFFSe0fRgdEQLejmy90fupdT244XYX75tzZWBJ1bHghUKuhYbVqgp5ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712125970; c=relaxed/simple;
	bh=siZsELP6DX7c8hys9u0DaWjnne+73kOXL9txZQcKfkc=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jPhgnEWfvxh21rISIRuKdwFMPtMiHou7vofCt8Qxppyj1Fdmj93bKqNZxXPmqe+zL5Mcm+aU+HfzYkT3lzG5fY9pqvmUWE0SP3w8cYYX9WRY3vEqCwlaQmzbzFPXUZhT+pMDmNO/YI4ReyWnCe53q4ahuc3byhkajyt6GJa491c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=FyYXXbpd; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4336Wddu061165;
	Wed, 3 Apr 2024 01:32:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1712125959;
	bh=McuWNcEt7vmmnKMGppietCh6HHnO1nPPZB141lG6H+o=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=FyYXXbpdu4rj2vVDwdhjSf8Ei+P+ljH8llWhrFHqT54bmn1nxldns6QG0KvCdhpda
	 U8N7o/b7TNExcPXkaxOhY9wkKKfkiMXXjxlMLiA8TvQHr4M+qFFjmW676LU4ue0WDy
	 60UbvF1z4if1L8q4ZMRA9kOXk33xBACFYOO8xoYc=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4336WdpZ012837
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 3 Apr 2024 01:32:39 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 3
 Apr 2024 01:32:38 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 3 Apr 2024 01:32:38 -0500
Received: from localhost (uda0492258.dhcp.ti.com [172.24.227.9])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4336Wbtg036685;
	Wed, 3 Apr 2024 01:32:38 -0500
Date: Wed, 3 Apr 2024 12:02:37 +0530
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: Siddharth Vadapalli <s-vadapalli@ti.com>, <lee@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>
Subject: Re: [PATCH] dt-bindings: mfd: syscon: Add ti,am62p-cpsw-mac-efuse
 compatible
Message-ID: <af61424e-7006-49f5-b614-3caa3674685a@ti.com>
References: <20240402105708.4114146-1-s-vadapalli@ti.com>
 <2e9b6a91-43d3-4b23-830d-40e607505d8c@kernel.org>
 <30065bdc-ccef-4610-b1c1-7661f801b8e9@ti.com>
 <4b1380a8-0136-4395-ba42-9bcff2e1bdb0@kernel.org>
 <aabea385-16e0-4116-a12b-3ce1e06574e3@ti.com>
 <eb7a0d5c-c197-44b9-baea-e9b54792b447@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <eb7a0d5c-c197-44b9-baea-e9b54792b447@kernel.org>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On Wed, Apr 03, 2024 at 08:27:06AM +0200, Krzysztof Kozlowski wrote:
> On 03/04/2024 07:35, Siddharth Vadapalli wrote:
> > On Tue, Apr 02, 2024 at 08:06:27PM +0200, Krzysztof Kozlowski wrote:
> >> On 02/04/2024 14:30, Siddharth Vadapalli wrote:
> >>> On Tue, Apr 02, 2024 at 02:08:32PM +0200, Krzysztof Kozlowski wrote:
> >>>> On 02/04/2024 12:57, Siddharth Vadapalli wrote:
> >>>>> The CTRLMMR_MAC_IDx registers within the CTRL_MMR space of TI's AM62p SoC
> >>>>> contain the MAC Address programmed in the eFuse. Add compatible for
> >>>>> allowing the CPSW driver to obtain a regmap for the CTRLMMR_MAC_IDx
> >>>>> registers within the System Controller device-tree node. The default MAC
> >>>>> Address for the interface corresponding to the first MAC port will be set
> >>>>> to the value programmed in the eFuse.
> >>>>>
> >>>>> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> >>>>> ---
> >>>>>
> >>>>> This patch is based on linux-next tagged next-20240402.
> >>>>
> >>>> Where is the DTS using it?
> >>>
> >>> The current implementation in the device-tree for older TI K3 SoCs is as
> >>> follows:
> >>>
> >>> 	cpsw_port1: port@1 {
> >>> 		reg = <1>;
> >>> 		ti,mac-only;
> >>> 		label = "port1";
> >>> 		phys = <&phy_gmii_sel 1>;
> >>> 		mac-address = [00 00 00 00 00 00];
> >>> 		ti,syscon-efuse = <&wkup_conf 0x200>;
> >>> 	};
> >>>
> >>> The "ti,syscon-efuse" property passes the reference to the System
> >>> Controller node as well as the offset to the CTRLMMR_MAC_IDx registers
> >>> within the CTRL_MMR space.
> >>
> >> Please reference upstream DTS or lore link to patch under review.
> > 
> > An example of the existing implementation in the device-tree for AM64x
> > is:
> > https://github.com/torvalds/linux/blob/d4e8c8ad5d14ad51ed8813442d81c43019fd669d/arch/arm64/boot/dts/ti/k3-am64-main.dtsi#L697
> > It uses:
> > 	ti,syscon-efuse = <&main_conf 0x200>;
> > 
> > and "main_conf" node is defined at:
> > https://github.com/torvalds/linux/blob/d4e8c8ad5d14ad51ed8813442d81c43019fd669d/arch/arm64/boot/dts/ti/k3-am64-main.dtsi#L40
> 
> It is quite different than your bindings, so your bindings are incorrect.

Sorry I didn't understand what you mean. The references I have provided
are for existing DTS where "main_conf"/"wkup_conf" (System Controller
nodes) have the compatible "syscon", unlike in AM62p at:
https://github.com/torvalds/linux/blob/20f8173afaac90dd9dca11be4aa602a47776077f/arch/arm64/boot/dts/ti/k3-am62p-wakeup.dtsi#L8
which has the "simple-bus" compatible for the "wkup_conf" node.

Also, shouldn't the device-tree bindings patches be posted first and get
merged before I post the device-tree patches that utilize the
compatible/properties that have been added in the bindings? That is the
reason why I had shared the "DIFF" for the DTS changes that I will be
posting once this patch for the new compatible is accepted.

Regards,
Siddharth.

