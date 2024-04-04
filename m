Return-Path: <linux-kernel+bounces-131250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D03889854E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 12:44:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 678AA1C253A4
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 10:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A7E97FBD2;
	Thu,  4 Apr 2024 10:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="w5b/AW7V"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE9C757F8;
	Thu,  4 Apr 2024 10:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712227441; cv=none; b=UP3ZU3wu7MSGdDCkULYABfTrOaJtLBbK1W1vQHYlth/BmE1QOZAxkBzZ1QaH6kRh5zRnwh1a5eKZFzikwgYdFsqcSG+Nd0AG13e/mlIPWTZF9S7r8LhvZ6gve/Kui/qnKWUXWVKUms1MNKmJtBDIR6DSXEEGOsdGrbcnNZfvemk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712227441; c=relaxed/simple;
	bh=im0U2lGAC8oYpE4ZyZgF/GiHDRRRhKqeeMqneU193vI=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hkLX73oP34etqWhXqaLB9acT6IcKIB+6dVFPes6KePGcJiRtcC4IFPT0C+3VxCs3Dgt7eJ+3bw2xiF9bPb9J+GopuC8TKjXd6N/12Cd0+EOR5uThFbWbB9dR2UqBzbMD3nuf1a7jtcC0yqp1UDBBu/AZPRiEp3mYlDXvsptIUuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=w5b/AW7V; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 434Ahldv015728;
	Thu, 4 Apr 2024 05:43:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1712227427;
	bh=M+oBweR6MlGgVONdsaWLLnpajziUTagpZ5rITcOUqaY=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=w5b/AW7VHoQSlNeBbZz0yLBVpKFDTeWvt78mavZzHJff0c1kPYjIcDWQJH1uPUOdA
	 /sIDcOCHgFmU6RQ9zmCMoB9VlvG8D1+epA6ipEXQmPXN2mVjfZTiGDCxA/GugxjCi0
	 bWA74OTt9pyVqkiyB4ob5qbCl5mq8LyIVTHXkFgA=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 434Ahlj5048907
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 4 Apr 2024 05:43:47 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 4
 Apr 2024 05:43:47 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 4 Apr 2024 05:43:47 -0500
Received: from localhost (uda0492258.dhcp.ti.com [172.24.227.9])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 434AhkTn107605;
	Thu, 4 Apr 2024 05:43:46 -0500
Date: Thu, 4 Apr 2024 16:13:46 +0530
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC: Siddharth Vadapalli <s-vadapalli@ti.com>, <afd@ti.com>, <nm@ti.com>,
        <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>
Subject: Re: [PATCH v2] arm64: dts: ti: k3-am62p: use eFuse MAC Address for
 CPSW3G Port 1
Message-ID: <55d82eb2-faab-4019-ab9c-55063bb4849e@ti.com>
References: <20240404081845.622707-1-s-vadapalli@ti.com>
 <18eb0e55-38ad-44f9-90b7-1917d8c0d5bb@linaro.org>
 <75b53dda-23aa-4915-944a-4d9a619bd165@ti.com>
 <903ad855-ab26-4ef3-80bd-249917056188@linaro.org>
 <a0df1035-8616-413d-9058-e6163bdf06cc@ti.com>
 <e80f2073-d5b5-40b2-9a48-bbe29e84d17c@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <e80f2073-d5b5-40b2-9a48-bbe29e84d17c@linaro.org>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On Thu, Apr 04, 2024 at 12:31:47PM +0200, Krzysztof Kozlowski wrote:
> On 04/04/2024 12:16, Siddharth Vadapalli wrote:
> >>> I was following the convention that other mfd-syscon compatible nodes
> >>> seemed to be using:
> >>> https://github.com/torvalds/linux/blob/41bccc98fb7931d63d03f326a746ac4d429c1dd3/arch/arm64/boot/dts/ti/k3-am65-main.dtsi#L502
> >>> The node is:
> >>> dss_oldi_io_ctrl: dss-oldi-io-ctrl@41e0
> >>> corresponding to the compatible:
> >>> "ti,am654-dss-oldi-io-ctrl"
> >>> which was added by commit:
> >>> https://github.com/torvalds/linux/commit/cb523495ee2a5938fbdd30b8a35094d386c55c12
> >>
> >> So if that one was wrong, then what? I don't know really what type of
> >> device is it, but just because one contributor called it that way, does
> >> not mean you should keep going. Maybe investigate why that contributor
> >> did not decide to follow Devicetree spec recommendation?
> > 
> > Yes, it doesn't justify the convention. I seem to have picked a wrong
> > example when figuring out the convention for naming the node. I plan to
> > name it as:
> > ethernet-mac-efuse
> > while retaining the label "cpsw_mac_efuse" since CPSW is the name of the
> > Ethernet Switch on the SoC. Please let me know if it is acceptable. I
> > will post the v3 patch based on your feedback.
> 
> Label is fine, there is no restriction/guideline on labels, so choose
> descriptive or something useful for you. Just the node name. If this is
> syscon, then usually system-controller. If this is efuse, then maybe
> efuse, even though previously I was looking at this more as a syscon.

I will change it to "ethernet-mac-syscon" to indicate the MMIO nature of
the node. eFuse might give the wrong impression, despite the fact that
the contents of the register are based on the contents of an eFuse.

I will post the v3 patch with the following changes:
1. Rename "cpsw-mac-efuse" as "ethernet-mac-syscon"
2. Rename "cpsw_mac_efuse" as "cpsw_mac_syscon"

Regards,
Siddharth.

