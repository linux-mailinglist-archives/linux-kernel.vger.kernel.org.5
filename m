Return-Path: <linux-kernel+bounces-129096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC4228964D7
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 08:48:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFA1D1C2136E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 06:48:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0520217C64;
	Wed,  3 Apr 2024 06:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="PF2hz8uL"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C8D237145;
	Wed,  3 Apr 2024 06:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712126902; cv=none; b=ZJsu4sRMiQskAfReUgvOk1ByPCpkZr+msx6UvM3mcTpvPaw49GDgm+YevFSwXIhuzhQrzg+7VcsehXmUAgsAPjGKrp/InnWUlKRtkFmWiZCsmY3BV0qY9kiyj172mPy9NfQG/I5Qnub2rk96mGd6iwjFp+7g4/Ts+oM7F4VhKFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712126902; c=relaxed/simple;
	bh=ERvOXIYH7R3XfV6SO8p/C91aA4+YKEuX8q1mTRMKL4k=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r4sH6oIELmVlFV2Hd+Bi8QgJY6iYvbwleb34xpLTURVeUiKgV2PzOaRznavGzN8OUO1anQ4DEPvHa6sAD4iyRcoiEtrRiFAPFWfICvSj8T9m44lb4I3TFLE9jq09zcydUqPJnnpHw6qsQnaSM8XbrgvJmtUo15g8HQ9qHaBE/CU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=PF2hz8uL; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4336mCj3093857;
	Wed, 3 Apr 2024 01:48:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1712126892;
	bh=ozCAiOJVyJp9kmQw+ziSzMoUvlTeRCGgW+PiesSnbTE=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=PF2hz8uLcR2Fl5d9ZVuzcu4u0H0rTn2l1gqC7ToOV+3a4n3pM6nxScNEVVKBlf+EY
	 95GiG98vsWkNQ4nBNr6ipwIRFY1jknuS/Ao6jERW8KCn1fvNGP6CGS4bktVhCzWyXd
	 Pyplju71Qaw/q56yqUbEQuv/O2UCno4ExK92v5Po=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4336mC8Z051334
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 3 Apr 2024 01:48:12 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 3
 Apr 2024 01:48:12 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 3 Apr 2024 01:48:12 -0500
Received: from localhost (uda0492258.dhcp.ti.com [172.24.227.9])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4336mBPM064524;
	Wed, 3 Apr 2024 01:48:11 -0500
Date: Wed, 3 Apr 2024 12:18:10 +0530
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: Siddharth Vadapalli <s-vadapalli@ti.com>, <lee@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>
Subject: Re: [PATCH] dt-bindings: mfd: syscon: Add ti,am62p-cpsw-mac-efuse
 compatible
Message-ID: <9bca7d94-142e-4717-aea7-437805717a00@ti.com>
References: <20240402105708.4114146-1-s-vadapalli@ti.com>
 <2e9b6a91-43d3-4b23-830d-40e607505d8c@kernel.org>
 <30065bdc-ccef-4610-b1c1-7661f801b8e9@ti.com>
 <4b1380a8-0136-4395-ba42-9bcff2e1bdb0@kernel.org>
 <aabea385-16e0-4116-a12b-3ce1e06574e3@ti.com>
 <eb7a0d5c-c197-44b9-baea-e9b54792b447@kernel.org>
 <af61424e-7006-49f5-b614-3caa3674685a@ti.com>
 <083e50de-1c99-4a58-8b55-4dec26d97c1b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <083e50de-1c99-4a58-8b55-4dec26d97c1b@kernel.org>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On Wed, Apr 03, 2024 at 08:40:19AM +0200, Krzysztof Kozlowski wrote:
> On 03/04/2024 08:32, Siddharth Vadapalli wrote:
> > On Wed, Apr 03, 2024 at 08:27:06AM +0200, Krzysztof Kozlowski wrote:
> >> On 03/04/2024 07:35, Siddharth Vadapalli wrote:
> >>> On Tue, Apr 02, 2024 at 08:06:27PM +0200, Krzysztof Kozlowski wrote:
> >>>> On 02/04/2024 14:30, Siddharth Vadapalli wrote:
> >>>>> On Tue, Apr 02, 2024 at 02:08:32PM +0200, Krzysztof Kozlowski wrote:
> >>>>>> On 02/04/2024 12:57, Siddharth Vadapalli wrote:
> >>>>>>> The CTRLMMR_MAC_IDx registers within the CTRL_MMR space of TI's AM62p SoC
> >>>>>>> contain the MAC Address programmed in the eFuse. Add compatible for
> >>>>>>> allowing the CPSW driver to obtain a regmap for the CTRLMMR_MAC_IDx
> >>>>>>> registers within the System Controller device-tree node. The default MAC
> >>>>>>> Address for the interface corresponding to the first MAC port will be set
> >>>>>>> to the value programmed in the eFuse.
> >>>>>>>
> >>>>>>> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> >>>>>>> ---
> >>>>>>>
> >>>>>>> This patch is based on linux-next tagged next-20240402.
> >>>>>>
> >>>>>> Where is the DTS using it?
> >>>>>
> >>>>> The current implementation in the device-tree for older TI K3 SoCs is as
> >>>>> follows:
> >>>>>
> >>>>> 	cpsw_port1: port@1 {
> >>>>> 		reg = <1>;
> >>>>> 		ti,mac-only;
> >>>>> 		label = "port1";
> >>>>> 		phys = <&phy_gmii_sel 1>;
> >>>>> 		mac-address = [00 00 00 00 00 00];
> >>>>> 		ti,syscon-efuse = <&wkup_conf 0x200>;
> >>>>> 	};
> >>>>>
> >>>>> The "ti,syscon-efuse" property passes the reference to the System
> >>>>> Controller node as well as the offset to the CTRLMMR_MAC_IDx registers
> >>>>> within the CTRL_MMR space.
> >>>>
> >>>> Please reference upstream DTS or lore link to patch under review.
> >>>
> >>> An example of the existing implementation in the device-tree for AM64x
> >>> is:
> >>> https://github.com/torvalds/linux/blob/d4e8c8ad5d14ad51ed8813442d81c43019fd669d/arch/arm64/boot/dts/ti/k3-am64-main.dtsi#L697
> >>> It uses:
> >>> 	ti,syscon-efuse = <&main_conf 0x200>;
> >>>
> >>> and "main_conf" node is defined at:
> >>> https://github.com/torvalds/linux/blob/d4e8c8ad5d14ad51ed8813442d81c43019fd669d/arch/arm64/boot/dts/ti/k3-am64-main.dtsi#L40
> >>
> >> It is quite different than your bindings, so your bindings are incorrect.
> > 
> > Sorry I didn't understand what you mean. The references I have provided
> > are for existing DTS where "main_conf"/"wkup_conf" (System Controller
> > nodes) have the compatible "syscon", unlike in AM62p at:
> > https://github.com/torvalds/linux/blob/20f8173afaac90dd9dca11be4aa602a47776077f/arch/arm64/boot/dts/ti/k3-am62p-wakeup.dtsi#L8
> > which has the "simple-bus" compatible for the "wkup_conf" node.
> > 
> > Also, shouldn't the device-tree bindings patches be posted first and get
> > merged before I post the device-tree patches that utilize the
> > compatible/properties that have been added in the bindings? That is the
> > reason why I had shared the "DIFF" for the DTS changes that I will be
> > posting once this patch for the new compatible is accepted.
> > 
> 
> That's not the process. I will be NAKing bindings which do not have any
> users, because I do not trust you test them.
> 
> The process is almost always:
> 1. Send bindings,
> 2. Send driver changes (if applicable) in the same patchset.
> 3. Send DTS, usually in separate patches and provide lore link to the
> bindings in the changelog or cover letter.

Thank you for clarifying. I will post the DTS patches corresponding to
this patch and reference this patch in the DTS patch series.

Regards,
Siddharth.

