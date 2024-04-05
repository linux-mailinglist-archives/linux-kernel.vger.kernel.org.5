Return-Path: <linux-kernel+bounces-132420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75CE18994B1
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 07:21:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FDBF1C227DD
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 05:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE07F21A04;
	Fri,  5 Apr 2024 05:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="AhJi/sZG"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C3B8EAC5;
	Fri,  5 Apr 2024 05:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712294502; cv=none; b=lAWiquoqOXqvlA+FtwzwmmBkMAiMdtG9siQd67llpZMoIzN9EyF4EbxouN4HoRUtHqIrWCJcA1zqgDtVSqO+ZKP8FpDQPdcSJLEb1FGToyC9HsUMRj0SLTnkFkHadryWHY6vUo0P9xyeV3qQb1l7DWTUlOT5qqngXsES7PkPb4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712294502; c=relaxed/simple;
	bh=sbp/BvXn/ocXeWLlUWHaTIcY8lwqdZrtwrfGm7hEV1Q=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WPkv3CBgUIR/2DDIVfw1dCQDY1gUp4HQmOLI1aABRqJSQRAyMHlIH40Rhh90uPxcEnFuTY/9MqL7u0igBOJjvnRkdUqrBk8eAWKwiURk8GSv5Q/57I3dvrbaTK1biti6GqmSd4zLl+ckMLzSqnKbUMILtdxPUlvrn5FuSkxUV/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=AhJi/sZG; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4355LMkL032194;
	Fri, 5 Apr 2024 00:21:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1712294482;
	bh=rUC31u9nczDP7owyqjPSB+1Eq1oH+xM4RGziXzYW0k8=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=AhJi/sZG9+dE6kumgP/Ws/t/dcNQDpfOEIaHs1NQTS6VM0q1V+FDjTLzjzjbCnE/1
	 sbq/iHzZhOXXv1LgOggYzY9ZVYE0QJX8aRfoDTZZp8VGll+cQvoo09wr77Y8seZjqu
	 6/5dJbKYdKLTOkt506O69Wq4aZw6vK3CCG28nDLk=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4355LLAR047800
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 5 Apr 2024 00:21:22 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 5
 Apr 2024 00:21:21 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 5 Apr 2024 00:21:21 -0500
Received: from localhost (uda0492258.dhcp.ti.com [172.24.227.9])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4355LK0C089520;
	Fri, 5 Apr 2024 00:21:21 -0500
Date: Fri, 5 Apr 2024 10:51:20 +0530
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: Siddharth Vadapalli <s-vadapalli@ti.com>, <lee@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>
Subject: Re: [PATCH] dt-bindings: mfd: syscon: Add ti,am62p-cpsw-mac-efuse
 compatible
Message-ID: <94bae793-ba4f-467f-917d-213fa3cd6faa@ti.com>
References: <20240402105708.4114146-1-s-vadapalli@ti.com>
 <2e9b6a91-43d3-4b23-830d-40e607505d8c@kernel.org>
 <30065bdc-ccef-4610-b1c1-7661f801b8e9@ti.com>
 <4b1380a8-0136-4395-ba42-9bcff2e1bdb0@kernel.org>
 <aabea385-16e0-4116-a12b-3ce1e06574e3@ti.com>
 <eb7a0d5c-c197-44b9-baea-e9b54792b447@kernel.org>
 <af61424e-7006-49f5-b614-3caa3674685a@ti.com>
 <083e50de-1c99-4a58-8b55-4dec26d97c1b@kernel.org>
 <9bca7d94-142e-4717-aea7-437805717a00@ti.com>
 <a895ddc8-5c18-49d7-86c4-b995bb946914@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <a895ddc8-5c18-49d7-86c4-b995bb946914@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On Thu, Apr 04, 2024 at 02:02:21PM +0530, Siddharth Vadapalli wrote:
> On Wed, Apr 03, 2024 at 12:18:10PM +0530, Siddharth Vadapalli wrote:
> > On Wed, Apr 03, 2024 at 08:40:19AM +0200, Krzysztof Kozlowski wrote:
> > > On 03/04/2024 08:32, Siddharth Vadapalli wrote:
> > > > On Wed, Apr 03, 2024 at 08:27:06AM +0200, Krzysztof Kozlowski wrote:
> > > >> On 03/04/2024 07:35, Siddharth Vadapalli wrote:
> > > >>> On Tue, Apr 02, 2024 at 08:06:27PM +0200, Krzysztof Kozlowski wrote:
> > > >>>> On 02/04/2024 14:30, Siddharth Vadapalli wrote:
> > > >>>>> On Tue, Apr 02, 2024 at 02:08:32PM +0200, Krzysztof Kozlowski wrote:
> > > >>>>>> On 02/04/2024 12:57, Siddharth Vadapalli wrote:
> > > >>>>>>> The CTRLMMR_MAC_IDx registers within the CTRL_MMR space of TI's AM62p SoC
> > > >>>>>>> contain the MAC Address programmed in the eFuse. Add compatible for
> > > >>>>>>> allowing the CPSW driver to obtain a regmap for the CTRLMMR_MAC_IDx
> > > >>>>>>> registers within the System Controller device-tree node. The default MAC
> > > >>>>>>> Address for the interface corresponding to the first MAC port will be set
> > > >>>>>>> to the value programmed in the eFuse.
> > > >>>>>>>
> > > >>>>>>> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> > > >>>>>>> ---
> > > >>>>>>>
> > > >>>>>>> This patch is based on linux-next tagged next-20240402.
> > > >>>>>>
> > > >>>>>> Where is the DTS using it?
> > > >>>>>
> > > >>>>> The current implementation in the device-tree for older TI K3 SoCs is as
> > > >>>>> follows:
> > > >>>>>
> > > >>>>> 	cpsw_port1: port@1 {
> > > >>>>> 		reg = <1>;
> > > >>>>> 		ti,mac-only;
> > > >>>>> 		label = "port1";
> > > >>>>> 		phys = <&phy_gmii_sel 1>;
> > > >>>>> 		mac-address = [00 00 00 00 00 00];
> > > >>>>> 		ti,syscon-efuse = <&wkup_conf 0x200>;
> > > >>>>> 	};
> > > >>>>>
> > > >>>>> The "ti,syscon-efuse" property passes the reference to the System
> > > >>>>> Controller node as well as the offset to the CTRLMMR_MAC_IDx registers
> > > >>>>> within the CTRL_MMR space.
> > > >>>>
> > > >>>> Please reference upstream DTS or lore link to patch under review.
> > > >>>
> > > >>> An example of the existing implementation in the device-tree for AM64x
> > > >>> is:
> > > >>> https://github.com/torvalds/linux/blob/d4e8c8ad5d14ad51ed8813442d81c43019fd669d/arch/arm64/boot/dts/ti/k3-am64-main.dtsi#L697
> > > >>> It uses:
> > > >>> 	ti,syscon-efuse = <&main_conf 0x200>;
> > > >>>
> > > >>> and "main_conf" node is defined at:
> > > >>> https://github.com/torvalds/linux/blob/d4e8c8ad5d14ad51ed8813442d81c43019fd669d/arch/arm64/boot/dts/ti/k3-am64-main.dtsi#L40
> > > >>
> > > >> It is quite different than your bindings, so your bindings are incorrect.
> > > > 
> > > > Sorry I didn't understand what you mean. The references I have provided
> > > > are for existing DTS where "main_conf"/"wkup_conf" (System Controller
> > > > nodes) have the compatible "syscon", unlike in AM62p at:
> > > > https://github.com/torvalds/linux/blob/20f8173afaac90dd9dca11be4aa602a47776077f/arch/arm64/boot/dts/ti/k3-am62p-wakeup.dtsi#L8
> > > > which has the "simple-bus" compatible for the "wkup_conf" node.
> > > > 
> > > > Also, shouldn't the device-tree bindings patches be posted first and get
> > > > merged before I post the device-tree patches that utilize the
> > > > compatible/properties that have been added in the bindings? That is the
> > > > reason why I had shared the "DIFF" for the DTS changes that I will be
> > > > posting once this patch for the new compatible is accepted.
> > > > 
> > > 
> > > That's not the process. I will be NAKing bindings which do not have any
> > > users, because I do not trust you test them.
> > > 
> > > The process is almost always:
> > > 1. Send bindings,
> > > 2. Send driver changes (if applicable) in the same patchset.
> > > 3. Send DTS, usually in separate patches and provide lore link to the
> > > bindings in the changelog or cover letter.
> > 
> > Thank you for clarifying. I will post the DTS patches corresponding to
> > this patch and reference this patch in the DTS patch series.
> 
> I have posted the DTS patch at:
> https://patchwork.kernel.org/project/linux-arm-kernel/patch/20240404081845.622707-1-s-vadapalli@ti.com/
> indicating the dependency on this bindings patch.

Hello Krzysztof,

Do I have to post a v2 for this patch? You had Acked it initially but I
am not sure if the discussion so far will make it unclear to readers
regarding the acceptance of this patch. Thank you for Acking the v3 DTS
patch at:
https://patchwork.kernel.org/project/linux-arm-kernel/patch/20240404124614.891416-1-s-vadapalli@ti.com/

Since the v3 DTS patch mentions this bindings patch as a dependency, I
wanted to be sure whether I have to post a v2 for this or that won't be
required.

Regards,
Siddharth.

