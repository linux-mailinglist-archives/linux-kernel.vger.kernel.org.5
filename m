Return-Path: <linux-kernel+bounces-38673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D38283C3F2
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 14:44:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFA551C24569
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 13:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B7EE5676C;
	Thu, 25 Jan 2024 13:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="YbRem9aB"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D40158114;
	Thu, 25 Jan 2024 13:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706190238; cv=none; b=TKR1KArJXlo8NIo2q9FkwRWnYKDk0etVmRsF8W4P2mbEQaA0L5mMB1MB19jDM6kxCFEfaOkKlN/ek08qiwKmHanobrmbjJHYoJmLwLdJvhHsxrrONcwermQVjp3hvprRvgL2/I2gSfyk7113frIu8n3jtPZ8bWHnrcoSdv0UG7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706190238; c=relaxed/simple;
	bh=uxtBabVZoIxX1rXoTyZaUDap/Zujw1w8+jvXnRMCn8Y=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XEKhcJ/P8IXSiZTdS20wwwAu9flk48QaM2cLcbN2iJkQ9KFdr0kadwSJNEVVGfy9KHfjiK4U9IIyrmY8wfGF0LfXO3ZMCJfc/3nIEkxMWeHnXqKaSe+RHgi6DhmDPEJSTnTuSR+Wio+1NBf/l3ZkXx0jG9OeCR6Mdg9gs5MpQfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=YbRem9aB; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40PDhdOt116135;
	Thu, 25 Jan 2024 07:43:39 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706190219;
	bh=r2lrXBYSssJ7OnQOBdMOIycQN4ypBfbTdn/rkYN0/SE=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=YbRem9aByDzpoE7pijyaC//GONs4L5Ju2pRLnJtVATYFMhK5NybYRA8ZUIKDMJ3dt
	 FJnhxYAiB51tQxfUxVvqQCyAylEWG+LisFnPsRVY7DeLWO8lZiPL13mBfmaVb6JnPK
	 APEHuNxpeklLkgenmKKg47EY1lXclSyd1Vngu6BI=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40PDhdeE089103
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 25 Jan 2024 07:43:39 -0600
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 25
 Jan 2024 07:43:39 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 25 Jan 2024 07:43:39 -0600
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40PDhcnh063679;
	Thu, 25 Jan 2024 07:43:38 -0600
Date: Thu, 25 Jan 2024 07:43:38 -0600
From: Nishanth Menon <nm@ti.com>
To: Vaishnav Achath <vaishnav.a@ti.com>
CC: Jayesh Choudhary <j-choudhary@ti.com>, <vigneshr@ti.com>,
        <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <bb@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <u-kumar1@ti.com>
Subject: Re: [PATCH] arm64: dts: ti: k3-am62p-mcu/wakeup: Disable MCU and
 wakeup R5FSS nodes
Message-ID: <20240125134338.5rrentfbw5grbrqk@caution>
References: <20240121134017.374992-1-vaishnav.a@ti.com>
 <0fcec921-0220-4251-afa4-44db5e80d2ef@ti.com>
 <20240124172151.ngxaq6k5tnvsx4jr@proud>
 <2291204f-97d5-4887-b68f-8789fe85f838@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <2291204f-97d5-4887-b68f-8789fe85f838@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 11:17-20240125, Vaishnav Achath wrote:
> Hi Nishanth,
> 
> On 24/01/24 22:51, Nishanth Menon wrote:
> > On 11:26-20240124, Jayesh Choudhary wrote:
> > > Hello Vaishnav,
> > > 
> > > On 21/01/24 19:10, Vaishnav Achath wrote:
> > > > K3 Remoteproc R5 driver requires reserved memory carveouts and
> > > > mailbox configuration to instantiate the cores successfully.
> > > > Since this is a board level dependency, keep the R5 subsytem
> > > > disabled at SoC dtsi, otherwise it results in probe errors like
> > > > below during AM62P SK boot:
> > > > 
> > > > r5fss@79000000: reserved memory init failed, ret = -22
> > > > r5fss@79000000: k3_r5_cluster_rproc_init failed, ret = -22
> > > > r5fss@78000000: reserved memory init failed, ret = -22
> > > > r5fss@78000000: k3_r5_cluster_rproc_init failed, ret = -22
> > > > 
> > > > Fixes: b5080c7c1f7e ("arm64: dts: ti: k3-am62p: Add nodes for more IPs")
> > > > 
> > > > Signed-off-by: Vaishnav Achath <vaishnav.a@ti.com>
> > > 
> > > Reviewed-by: Jayesh Choudhary <j-choudhary@ti.com>
> > > 
> > > > ---
> > > >    arch/arm64/boot/dts/ti/k3-am62p-mcu.dtsi    | 2 ++
> > > >    arch/arm64/boot/dts/ti/k3-am62p-wakeup.dtsi | 1 +
> > > >    2 files changed, 3 insertions(+)
> > > > 
> > > > diff --git a/arch/arm64/boot/dts/ti/k3-am62p-mcu.dtsi b/arch/arm64/boot/dts/ti/k3-am62p-mcu.dtsi
> > > > index c4b0b91d70cf..14eb9ba836d3 100644
> > > > --- a/arch/arm64/boot/dts/ti/k3-am62p-mcu.dtsi
> > > > +++ b/arch/arm64/boot/dts/ti/k3-am62p-mcu.dtsi
> > > > @@ -187,6 +187,8 @@ mcu_r5fss0: r5fss@79000000 {
> > > >    		ranges = <0x79000000 0x00 0x79000000 0x8000>,
> > > >    			 <0x79020000 0x00 0x79020000 0x8000>;
> > > >    		power-domains = <&k3_pds 7 TI_SCI_PD_EXCLUSIVE>;
> > > > +		status = "disabled";
> > > > +

	^^ Look here.

> > > >    		mcu_r5fss0_core0: r5f@79000000 {
> > > >    			compatible = "ti,am62-r5f";
> > > >    			reg = <0x79000000 0x00008000>,
> > > > diff --git a/arch/arm64/boot/dts/ti/k3-am62p-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-am62p-wakeup.dtsi
> > > > index 19f42b39394e..10a7059b2d9b 100644
> > > > --- a/arch/arm64/boot/dts/ti/k3-am62p-wakeup.dtsi
> > > > +++ b/arch/arm64/boot/dts/ti/k3-am62p-wakeup.dtsi
> > > > @@ -78,6 +78,7 @@ wkup_r5fss0: r5fss@78000000 {
> > > >    		ranges = <0x78000000 0x00 0x78000000 0x8000>,
> > > >    			 <0x78100000 0x00 0x78100000 0x8000>;
> > > >    		power-domains = <&k3_pds 119 TI_SCI_PD_EXCLUSIVE>;
> > > > +		status = "disabled";
> > 

	^^ no white space here.

> > Is there a reason for difference in white space addition?
> > 
> 
> For mcu_r5fss0_core0 child node there was no blank line as per the
> recommended coding style : https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/dts-coding-style.rst#n124
> 
> So I added a newline there and wkup_r5fss0 already had it correct, since the
> change was trivial it was not mentioned in commit message.

Sigh, please add a EoL here to keep the look consistent between mcu and
wakeup dtsis. there is no need to state in commit message.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

