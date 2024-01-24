Return-Path: <linux-kernel+bounces-37417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CB7183AFBB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 18:26:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53A5C1F2BA12
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 17:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F47082D7B;
	Wed, 24 Jan 2024 17:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="FZ2qjeaf"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F177F7C4;
	Wed, 24 Jan 2024 17:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706116921; cv=none; b=ubi9XXTKZHUzbDfa/Wvna71RrNAxMqlRPM7mB6JFRDWesEIQCMc94dVDmxtWfxq5pRXuIIhaOJ8+7/KwVzOlSYMugmKkw/Ul0BoefY/2AqhiJGV8yDl1m+QfjXBLbh69gBlIlaPZbS3pdCa5N4sNV6XnZO6s4c0nODF428FwO9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706116921; c=relaxed/simple;
	bh=7Zkqlj15DzRPQdb/WVAraZl43ecVYS8Atallm3D12ng=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LJJ002ywAOuuVk3O/j8H+EKc6G8lADfpqF/4EDtid3w3jVr0qJ9MUHoYLThLRI819kjHIKeJ5rSDcYkRSRL435MGoh99BG90w0CJHTrY/AKcGzA45eDVP+C0er7e7xKNNr+riSpRc4MlSACXmhd5VH4OGNNEvMWG1/ynFGdwuYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=FZ2qjeaf; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40OHLq3P110878;
	Wed, 24 Jan 2024 11:21:52 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706116912;
	bh=DmJpWLN7OHtRo6EnwRqfy6v8Zjdi8Isz8zrhFbkPXi4=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=FZ2qjeafGwe0hu5eUhRx4+Au1Nn+Vu4PdIqq0RqavgcnSLvyrlm/Of1CFiaykt5J0
	 0LmZWCex4XC6Ex2HFkIevDsXGw7s4ie5E/JjKZI2r029dIlFxORC1pOwqkWb6upLze
	 lpYKLFCkYQ/t25KCYTEiDoAfbM+gU2XPt3mrkdzI=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40OHLq8j029675
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 24 Jan 2024 11:21:52 -0600
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 24
 Jan 2024 11:21:51 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 24 Jan 2024 11:21:51 -0600
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40OHLpqf010551;
	Wed, 24 Jan 2024 11:21:51 -0600
Date: Wed, 24 Jan 2024 11:21:51 -0600
From: Nishanth Menon <nm@ti.com>
To: Jayesh Choudhary <j-choudhary@ti.com>
CC: Vaishnav Achath <vaishnav.a@ti.com>, <vigneshr@ti.com>,
        <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <bb@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <u-kumar1@ti.com>
Subject: Re: [PATCH] arm64: dts: ti: k3-am62p-mcu/wakeup: Disable MCU and
 wakeup R5FSS nodes
Message-ID: <20240124172151.ngxaq6k5tnvsx4jr@proud>
References: <20240121134017.374992-1-vaishnav.a@ti.com>
 <0fcec921-0220-4251-afa4-44db5e80d2ef@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <0fcec921-0220-4251-afa4-44db5e80d2ef@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 11:26-20240124, Jayesh Choudhary wrote:
> Hello Vaishnav,
> 
> On 21/01/24 19:10, Vaishnav Achath wrote:
> > K3 Remoteproc R5 driver requires reserved memory carveouts and
> > mailbox configuration to instantiate the cores successfully.
> > Since this is a board level dependency, keep the R5 subsytem
> > disabled at SoC dtsi, otherwise it results in probe errors like
> > below during AM62P SK boot:
> > 
> > r5fss@79000000: reserved memory init failed, ret = -22
> > r5fss@79000000: k3_r5_cluster_rproc_init failed, ret = -22
> > r5fss@78000000: reserved memory init failed, ret = -22
> > r5fss@78000000: k3_r5_cluster_rproc_init failed, ret = -22
> > 
> > Fixes: b5080c7c1f7e ("arm64: dts: ti: k3-am62p: Add nodes for more IPs")
> > 
> > Signed-off-by: Vaishnav Achath <vaishnav.a@ti.com>
> 
> Reviewed-by: Jayesh Choudhary <j-choudhary@ti.com>
> 
> > ---
> >   arch/arm64/boot/dts/ti/k3-am62p-mcu.dtsi    | 2 ++
> >   arch/arm64/boot/dts/ti/k3-am62p-wakeup.dtsi | 1 +
> >   2 files changed, 3 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/ti/k3-am62p-mcu.dtsi b/arch/arm64/boot/dts/ti/k3-am62p-mcu.dtsi
> > index c4b0b91d70cf..14eb9ba836d3 100644
> > --- a/arch/arm64/boot/dts/ti/k3-am62p-mcu.dtsi
> > +++ b/arch/arm64/boot/dts/ti/k3-am62p-mcu.dtsi
> > @@ -187,6 +187,8 @@ mcu_r5fss0: r5fss@79000000 {
> >   		ranges = <0x79000000 0x00 0x79000000 0x8000>,
> >   			 <0x79020000 0x00 0x79020000 0x8000>;
> >   		power-domains = <&k3_pds 7 TI_SCI_PD_EXCLUSIVE>;
> > +		status = "disabled";
> > +
> >   		mcu_r5fss0_core0: r5f@79000000 {
> >   			compatible = "ti,am62-r5f";
> >   			reg = <0x79000000 0x00008000>,
> > diff --git a/arch/arm64/boot/dts/ti/k3-am62p-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-am62p-wakeup.dtsi
> > index 19f42b39394e..10a7059b2d9b 100644
> > --- a/arch/arm64/boot/dts/ti/k3-am62p-wakeup.dtsi
> > +++ b/arch/arm64/boot/dts/ti/k3-am62p-wakeup.dtsi
> > @@ -78,6 +78,7 @@ wkup_r5fss0: r5fss@78000000 {
> >   		ranges = <0x78000000 0x00 0x78000000 0x8000>,
> >   			 <0x78100000 0x00 0x78100000 0x8000>;
> >   		power-domains = <&k3_pds 119 TI_SCI_PD_EXCLUSIVE>;
> > +		status = "disabled";

Is there a reason for difference in white space addition?

> >   		wkup_r5fss0_core0: r5f@78000000 {
> >   			compatible = "ti,am62-r5f";
> 
> Thanks.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

