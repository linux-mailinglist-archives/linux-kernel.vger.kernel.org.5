Return-Path: <linux-kernel+bounces-131230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7D948984E0
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 12:16:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 584F81F25612
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 10:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C76B7603A;
	Thu,  4 Apr 2024 10:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="OkfKZM0t"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5AFA745C3;
	Thu,  4 Apr 2024 10:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712225789; cv=none; b=b2M6T5NqYBKQKFYFVMnRFIs6bb/dfs1sZ5NrU7LL60NT2ERet34HIck0yxvVgoNbVWBLBdWE5DsDVJ8yWFYh4vTI9wz10Y9bxXmmSJRrdWwUi6quxep2puT7o/LRGwfLJWO20S6e3URtFDi7Ik83TB/XLB90di7nxQLcfkITQ8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712225789; c=relaxed/simple;
	bh=RA3YXp95XvHtDO4XPP8u2yWotPeIqKvBg4+L0oRoQl4=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JCh1dxFgAcHD2bCwzzJaDPBbwJaoFDRcd16EJh7xBf93PaGaa7TEjks1qd7E10pgDpltSMzoRUtriuBlqb1m4fAR9AydZcPA0QNS8Iga64XnNCpjBVdKbKUmM+mKI4Fhvfq2mrcFtHIMTkAhfCSWETVnzy/Orvm5eghuSYWoSVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=OkfKZM0t; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 434AGHZo010046;
	Thu, 4 Apr 2024 05:16:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1712225777;
	bh=K09Az5yAkNL2uNDRy1cAcJwTnDrohVX6gc31VbDkJ0w=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=OkfKZM0teHraQX1K4KT5Dy2ROUID1ILnzShDL+cq2R9c1ReuRwsKy7frbA8y/F3xt
	 ix5b8sftVgFrSztj8VyqrRTnnDU2Oq5FTUBNqdPldnh0BAya3lXnLo/BRusHHOYSsV
	 +SWzn5FQx7ZojMTmQYCAb9otNj56ZbdTBsPfBF2A=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 434AGHON026933
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 4 Apr 2024 05:16:17 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 4
 Apr 2024 05:16:17 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 4 Apr 2024 05:16:17 -0500
Received: from localhost (uda0492258.dhcp.ti.com [172.24.227.9])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 434AGGXY060696;
	Thu, 4 Apr 2024 05:16:17 -0500
Date: Thu, 4 Apr 2024 15:46:16 +0530
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC: Siddharth Vadapalli <s-vadapalli@ti.com>, <afd@ti.com>, <nm@ti.com>,
        <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>
Subject: Re: [PATCH v2] arm64: dts: ti: k3-am62p: use eFuse MAC Address for
 CPSW3G Port 1
Message-ID: <a0df1035-8616-413d-9058-e6163bdf06cc@ti.com>
References: <20240404081845.622707-1-s-vadapalli@ti.com>
 <18eb0e55-38ad-44f9-90b7-1917d8c0d5bb@linaro.org>
 <75b53dda-23aa-4915-944a-4d9a619bd165@ti.com>
 <903ad855-ab26-4ef3-80bd-249917056188@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <903ad855-ab26-4ef3-80bd-249917056188@linaro.org>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On Thu, Apr 04, 2024 at 12:00:09PM +0200, Krzysztof Kozlowski wrote:
> On 04/04/2024 11:12, Siddharth Vadapalli wrote:
> > On Thu, Apr 04, 2024 at 10:43:04AM +0200, Krzysztof Kozlowski wrote:
> >> On 04/04/2024 10:18, Siddharth Vadapalli wrote:
> >>> Add the "cpsw-mac-efuse" node within "wkup_conf" node corresponding to the
> >>> CTRLMMR_MAC_IDx registers within the CTRL_MMR space. Assign the compatible
> >>> "ti,am62p-cpsw-mac-efuse" to enable "syscon_regmap" operations on these
> >>> registers. The MAC Address programmed in the eFuse is accessible through
> >>> the CTRLMMR_MAC_IDx registers. The "ti,syscon-efuse" device-tree property
> >>> points to the CTRLMMR_MAC_IDx registers, allowing the CPSW driver to fetch
> >>> the MAC Address and assign it to the network interface associated with
> >>> CPSW3G MAC Port 1.
> >>>
> >>> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> >>> ---
> >>>

..

> 
> > 
> >>
> >>>  			};
> >>>  
> >>>  			cpsw_port2: port@2 {
> >>> diff --git a/arch/arm64/boot/dts/ti/k3-am62p-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-am62p-wakeup.dtsi
> >>> index a84756c336d0..df9d40f64e3b 100644
> >>> --- a/arch/arm64/boot/dts/ti/k3-am62p-wakeup.dtsi
> >>> +++ b/arch/arm64/boot/dts/ti/k3-am62p-wakeup.dtsi
> >>> @@ -18,6 +18,11 @@ chipid: chipid@14 {
> >>>  			reg = <0x14 0x4>;
> >>>  			bootph-all;
> >>>  		};
> >>> +
> >>> +		cpsw_mac_efuse: cpsw-mac-efuse@200 {
> >>
> >> Node names should be generic. See also an explanation and list of
> >> examples (not exhaustive) in DT specification:
> >> https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation
> > 
> > I was following the convention that other mfd-syscon compatible nodes
> > seemed to be using:
> > https://github.com/torvalds/linux/blob/41bccc98fb7931d63d03f326a746ac4d429c1dd3/arch/arm64/boot/dts/ti/k3-am65-main.dtsi#L502
> > The node is:
> > dss_oldi_io_ctrl: dss-oldi-io-ctrl@41e0
> > corresponding to the compatible:
> > "ti,am654-dss-oldi-io-ctrl"
> > which was added by commit:
> > https://github.com/torvalds/linux/commit/cb523495ee2a5938fbdd30b8a35094d386c55c12
> 
> So if that one was wrong, then what? I don't know really what type of
> device is it, but just because one contributor called it that way, does
> not mean you should keep going. Maybe investigate why that contributor
> did not decide to follow Devicetree spec recommendation?

Yes, it doesn't justify the convention. I seem to have picked a wrong
example when figuring out the convention for naming the node. I plan to
name it as:
ethernet-mac-efuse
while retaining the label "cpsw_mac_efuse" since CPSW is the name of the
Ethernet Switch on the SoC. Please let me know if it is acceptable. I
will post the v3 patch based on your feedback.

Regards,
Siddharth.

