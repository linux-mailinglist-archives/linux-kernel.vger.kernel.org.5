Return-Path: <linux-kernel+bounces-131109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E170898331
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 10:32:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 251E01C272E8
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 08:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B80C6D1B4;
	Thu,  4 Apr 2024 08:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="kseJMoFx"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F24C96BB4C;
	Thu,  4 Apr 2024 08:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712219563; cv=none; b=J3zklLzjNSX7UsrcihwoMeHI4tcGmXoFCja7u9rLsMJhH+yLs2thSI3FO7YreKMmJGOckDWwZRzE/Eb3jT6+KIBxdYQD1uk5KHIhD6JjKF+HUKB5y3XwK3mBkFj0tZilNnowBf1dIWYrN7jupaWBP64HuFhIon5ttaVE+Eo0mno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712219563; c=relaxed/simple;
	bh=p2900hK6xx3eWgvsWFsyDXuQ4qS8UtyhwhAwQaQq94U=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pVhdhUpAlCC66/bMR47yliY0HFLE6Fn3+j1Ipe7sRh1MrQPD2eAMS7rsKt+u7yZ2pz5whqsEpbErmzB2+kOtG/3jttrRDzUrlpwzA1oJiAlifZmJ7zfblN9d2Ha5W6JVK1MpzghkAWylBsCTPQJYvIGY19EsZMz1Aca1a07lnd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=kseJMoFx; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4348WNXu121426;
	Thu, 4 Apr 2024 03:32:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1712219543;
	bh=hmxMvt8eAd0WKcI2X6dAusa/LHBf3QDz5/1lLNPytnw=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=kseJMoFxlQz0XfNtP3nCjqrzfTYfBFBiKWziG+qbPpqae0hDzI0uHEOBHjj5Ij7B/
	 cMEtQLlqf+GIzcJw38U3xhwnDxI5wgebg+/Uff73GNsW/p0Hzbzma784mUIdy11Oja
	 HnY5Yge2Tji/VdTWnsx5+vximFLtUVpQmftcq/oM=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4348WNxX037479
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 4 Apr 2024 03:32:23 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 4
 Apr 2024 03:32:23 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 4 Apr 2024 03:32:23 -0500
Received: from localhost (uda0492258.dhcp.ti.com [172.24.227.9])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4348WLjf002065;
	Thu, 4 Apr 2024 03:32:22 -0500
Date: Thu, 4 Apr 2024 14:02:21 +0530
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: Siddharth Vadapalli <s-vadapalli@ti.com>, <lee@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>
Subject: Re: [PATCH] dt-bindings: mfd: syscon: Add ti,am62p-cpsw-mac-efuse
 compatible
Message-ID: <a895ddc8-5c18-49d7-86c4-b995bb946914@ti.com>
References: <20240402105708.4114146-1-s-vadapalli@ti.com>
 <2e9b6a91-43d3-4b23-830d-40e607505d8c@kernel.org>
 <30065bdc-ccef-4610-b1c1-7661f801b8e9@ti.com>
 <4b1380a8-0136-4395-ba42-9bcff2e1bdb0@kernel.org>
 <aabea385-16e0-4116-a12b-3ce1e06574e3@ti.com>
 <eb7a0d5c-c197-44b9-baea-e9b54792b447@kernel.org>
 <af61424e-7006-49f5-b614-3caa3674685a@ti.com>
 <083e50de-1c99-4a58-8b55-4dec26d97c1b@kernel.org>
 <9bca7d94-142e-4717-aea7-437805717a00@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <9bca7d94-142e-4717-aea7-437805717a00@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On Wed, Apr 03, 2024 at 12:18:10PM +0530, Siddharth Vadapalli wrote:
> On Wed, Apr 03, 2024 at 08:40:19AM +0200, Krzysztof Kozlowski wrote:
> > On 03/04/2024 08:32, Siddharth Vadapalli wrote:
> > > On Wed, Apr 03, 2024 at 08:27:06AM +0200, Krzysztof Kozlowski wrote:
> > >> On 03/04/2024 07:35, Siddharth Vadapalli wrote:
> > >>> On Tue, Apr 02, 2024 at 08:06:27PM +0200, Krzysztof Kozlowski wrote:
> > >>>> On 02/04/2024 14:30, Siddharth Vadapalli wrote:
> > >>>>> On Tue, Apr 02, 2024 at 02:08:32PM +0200, Krzysztof Kozlowski wrote:
> > >>>>>> On 02/04/2024 12:57, Siddharth Vadapalli wrote:
> > >>>>>>> The CTRLMMR_MAC_IDx registers within the CTRL_MMR space of TI's AM62p SoC
> > >>>>>>> contain the MAC Address programmed in the eFuse. Add compatible for
> > >>>>>>> allowing the CPSW driver to obtain a regmap for the CTRLMMR_MAC_IDx
> > >>>>>>> registers within the System Controller device-tree node. The default MAC
> > >>>>>>> Address for the interface corresponding to the first MAC port will be set
> > >>>>>>> to the value programmed in the eFuse.
> > >>>>>>>
> > >>>>>>> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> > >>>>>>> ---
> > >>>>>>>
> > >>>>>>> This patch is based on linux-next tagged next-20240402.
> > >>>>>>
> > >>>>>> Where is the DTS using it?
> > >>>>>
> > >>>>> The current implementation in the device-tree for older TI K3 SoCs is as
> > >>>>> follows:
> > >>>>>
> > >>>>> 	cpsw_port1: port@1 {
> > >>>>> 		reg = <1>;
> > >>>>> 		ti,mac-only;
> > >>>>> 		label = "port1";
> > >>>>> 		phys = <&phy_gmii_sel 1>;
> > >>>>> 		mac-address = [00 00 00 00 00 00];
> > >>>>> 		ti,syscon-efuse = <&wkup_conf 0x200>;
> > >>>>> 	};
> > >>>>>
> > >>>>> The "ti,syscon-efuse" property passes the reference to the System
> > >>>>> Controller node as well as the offset to the CTRLMMR_MAC_IDx registers
> > >>>>> within the CTRL_MMR space.
> > >>>>
> > >>>> Please reference upstream DTS or lore link to patch under review.
> > >>>
> > >>> An example of the existing implementation in the device-tree for AM64x
> > >>> is:
> > >>> https://github.com/torvalds/linux/blob/d4e8c8ad5d14ad51ed8813442d81c43019fd669d/arch/arm64/boot/dts/ti/k3-am64-main.dtsi#L697
> > >>> It uses:
> > >>> 	ti,syscon-efuse = <&main_conf 0x200>;
> > >>>
> > >>> and "main_conf" node is defined at:
> > >>> https://github.com/torvalds/linux/blob/d4e8c8ad5d14ad51ed8813442d81c43019fd669d/arch/arm64/boot/dts/ti/k3-am64-main.dtsi#L40
> > >>
> > >> It is quite different than your bindings, so your bindings are incorrect.
> > > 
> > > Sorry I didn't understand what you mean. The references I have provided
> > > are for existing DTS where "main_conf"/"wkup_conf" (System Controller
> > > nodes) have the compatible "syscon", unlike in AM62p at:
> > > https://github.com/torvalds/linux/blob/20f8173afaac90dd9dca11be4aa602a47776077f/arch/arm64/boot/dts/ti/k3-am62p-wakeup.dtsi#L8
> > > which has the "simple-bus" compatible for the "wkup_conf" node.
> > > 
> > > Also, shouldn't the device-tree bindings patches be posted first and get
> > > merged before I post the device-tree patches that utilize the
> > > compatible/properties that have been added in the bindings? That is the
> > > reason why I had shared the "DIFF" for the DTS changes that I will be
> > > posting once this patch for the new compatible is accepted.
> > > 
> > 
> > That's not the process. I will be NAKing bindings which do not have any
> > users, because I do not trust you test them.
> > 
> > The process is almost always:
> > 1. Send bindings,
> > 2. Send driver changes (if applicable) in the same patchset.
> > 3. Send DTS, usually in separate patches and provide lore link to the
> > bindings in the changelog or cover letter.
> 
> Thank you for clarifying. I will post the DTS patches corresponding to
> this patch and reference this patch in the DTS patch series.

I have posted the DTS patch at:
https://patchwork.kernel.org/project/linux-arm-kernel/patch/20240404081845.622707-1-s-vadapalli@ti.com/
indicating the dependency on this bindings patch.

Regards,
Siddharth.

