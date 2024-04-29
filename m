Return-Path: <linux-kernel+bounces-162940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DEE9D8B6272
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 21:39:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A40C28363F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 19:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 722E813B5AB;
	Mon, 29 Apr 2024 19:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="xWbJ9Vy0"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF2B17597;
	Mon, 29 Apr 2024 19:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714419563; cv=none; b=PQClUZRzU6kzmtxVqULRT1ydYenbAVN+yLDKHwBqPEfgP9qZyY215yxBp7BoDPtXyXDwPSl2qjhOTXQ1rqAQGCVDyKvXsrGeqQKp3VdXjrZdyo4/fa0hV5mXBJ+fhQsgNtOA+UxKU5AhnieH14Kx8kEB8Pp5UqSr8a3/7+1plv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714419563; c=relaxed/simple;
	bh=WhgcW/bisSpMZeVcT/iQoAmlUPS83pZyhBZcNJvwjkI=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XCNlnRHqYYpI6nuP82mzU5vPR4JWzReA0GtyG+x56o5Kot3O5VnzWQ1Nned3xADh3CWGNFWntX1ZPNv9EApIaXL/ORIbF3v+t/zmxaSvFb/OnsCzYM85CbwpHn2tK6gW0l/NqxTvh9jL/0Li1MrwSUPskZDhzmlv2xeFswXqwUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=xWbJ9Vy0; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43TJdCRA025117;
	Mon, 29 Apr 2024 14:39:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1714419552;
	bh=lVO2rgJjLq4yw9Oul8jln9aM6c3F0zQr/8SSJzsApYQ=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=xWbJ9Vy0/d5ip39xkTzF8xujH1O01/X1GWBuwV2fAnFSrT8ogcV6GvYb0X4p8VCOw
	 crR45GlvB0XLGWRFmD4QFYxUAhA4aO/0QCqn360r9l1AuTONz+smPNY5m7i0QIuU9k
	 0E5wMpnrQi90uHe70pSfMLydPDf9BY+n4qoKwP70=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43TJdCfU109555
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 29 Apr 2024 14:39:12 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 29
 Apr 2024 14:39:12 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 29 Apr 2024 14:39:11 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43TJdBQE093494;
	Mon, 29 Apr 2024 14:39:11 -0500
Date: Mon, 29 Apr 2024 14:39:11 -0500
From: Nishanth Menon <nm@ti.com>
To: Chintan Vankar <c-vankar@ti.com>
CC: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh@kernel.org>, Tero
 Kristo <kristo@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <s-vadapalli@ti.com>
Subject: Re: [PATCH v6 5/5] arm64: dts: ti: k3-j784s4: Add overlay for dual
 port USXGMII mode
Message-ID: <20240429193911.crcrasbcxnhxonlh@altitude>
References: <20240329053130.2822129-1-c-vankar@ti.com>
 <20240329053130.2822129-6-c-vankar@ti.com>
 <1cf7f439-45cc-42cb-b707-4c87c00015ac@linaro.org>
 <f406bac9-f4c1-4289-8239-82420cd300b8@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <f406bac9-f4c1-4289-8239-82420cd300b8@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 17:16-20240429, Chintan Vankar wrote:
> 
> 
> On 29/04/24 16:01, Krzysztof Kozlowski wrote:
> > On 29/03/2024 06:31, Chintan Vankar wrote:
> > > From: Siddharth Vadapalli <s-vadapalli@ti.com>
> > > 
> > > The CPSW9G instance of the CPSW Ethernet Switch supports USXGMII mode
> > > with MAC Ports 1 and 2 of the instance, which are connected to ENET
> > > Expansion 1 and ENET Expansion 2 slots on the EVM respectively, through
> > > the Serdes2 instance of the SERDES.
> > > 
> > > Enable CPSW9G MAC Ports 1 and 2 in fixed-link configuration USXGMII mode
> > > at 5 Gbps each.
> > > 
> > > Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> > > Signed-off-by: Chintan Vankar <c-vankar@ti.com>
> > > ---
> > > 
> > > Link to v5:
> > > https://lore.kernel.org/r/20240314072129.1520475-6-c-vankar@ti.com/
> > > 
> > > Changes from v5 to v6:
> > > - Updated order of properties in Device Nodes based on
> > >    https://docs.kernel.org/devicetree/bindings/dts-coding-style.html#order-of-properties-in-device-node
> > > 
> > >   arch/arm64/boot/dts/ti/Makefile               |  6 +-
> > >   .../ti/k3-j784s4-evm-usxgmii-exp1-exp2.dtso   | 81 +++++++++++++++++++
> > >   2 files changed, 86 insertions(+), 1 deletion(-)
> > >   create mode 100644 arch/arm64/boot/dts/ti/k3-j784s4-evm-usxgmii-exp1-exp2.dtso
> > > 
> > > diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
> > > index f8e47278df43..2d798ef415e4 100644
> > > --- a/arch/arm64/boot/dts/ti/Makefile
> > > +++ b/arch/arm64/boot/dts/ti/Makefile
> > > @@ -101,6 +101,7 @@ dtb-$(CONFIG_ARCH_K3) += k3-j722s-evm.dtb
> > >   dtb-$(CONFIG_ARCH_K3) += k3-am69-sk.dtb
> > >   dtb-$(CONFIG_ARCH_K3) += k3-j784s4-evm.dtb
> > >   dtb-$(CONFIG_ARCH_K3) += k3-j784s4-evm-quad-port-eth-exp1.dtbo
> > > +dtb-$(CONFIG_ARCH_K3) += k3-j784s4-evm-usxgmii-exp1-exp2.dtbo
> > >   # Build time test only, enabled by CONFIG_OF_ALL_DTBS
> > >   k3-am625-beagleplay-csi2-ov5640-dtbs := k3-am625-beagleplay.dtb \
> > > @@ -148,6 +149,8 @@ k3-j721s2-evm-pcie1-ep-dtbs := k3-j721s2-common-proc-board.dtb \
> > >   	k3-j721s2-evm-pcie1-ep.dtbo
> > >   k3-j784s4-evm-quad-port-eth-exp1-dtbs := k3-j784s4-evm.dtb \
> > >   	k3-j784s4-evm-quad-port-eth-exp1.dtbo
> > > +k3-j784s4-evm-usxgmii-exp1-exp2.dtbs := k3-j784s4-evm.dtb \
> > > +	k3-j784s4-evm-usxgmii-exp1-exp2.dtbo\
> > 
> > I have doubts this commit was ever built. It clearly fails, just like
> > now linux-next fails.
> > 
> 
> Apologies for the syntax error here, I will fix it and post next
> version.

Series dropped. Looks like it slipped my checker as well :(

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

