Return-Path: <linux-kernel+bounces-38699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 93F0F83C449
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 15:05:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23FFBB22177
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 14:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01DD56280C;
	Thu, 25 Jan 2024 14:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Kl/zaH+S"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 895BE627FE;
	Thu, 25 Jan 2024 14:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706191489; cv=none; b=qHMhGQotaeld2oVWKe2L2JAttdpK+0RNX+Ut5H55PPC16sxe09egKW1zmwF/K2dzD1Ux+oMzK/4tzjzHeRN4wbORy4A/VevOk6jg+ANL6l1tfU95WtqwA/HNlvr8uxTbnPPhFptXYJ8zKUjmVLPFMX3K3+b4yoibyoWEEoTTpsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706191489; c=relaxed/simple;
	bh=IB+Wda9MOMHc0wdwn2N3+ileOMYk2feFsUX1tnPk9XE=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LRKpBAT9OHDDsF+pWukOTk6EhXl/KG9pQFob/0+lqXIithYXzYaAXP3QnT+b46YhaHT9Mh1wsAueKxnBXZeLlMMxKI6qRdqrVofhWYzL0niAIvWcnu45drUKQN7GoHTkD4pBiXlx4x7X2k/bWRu3qQeWmC2WP6M5fMa67STEXFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Kl/zaH+S; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40PE4cws004654;
	Thu, 25 Jan 2024 08:04:38 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706191478;
	bh=qRsbD8WCY5mnHfKFptKalBRsw3deKt3m0bDDYt63AzY=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=Kl/zaH+SmanGy58qmhqvfgC7OC68VwGeqZcOfWiTpe0oHXzJkoUDRRScj3k5eFaH5
	 oSNfxA5Sc2SOBi7SfdZ2CVi+o+hJFYy1sQxqrmyMZjNhyLLlyWWhV7Qi8LnOzC6x2y
	 dHfH5zqb52NL7pzidCWKKmD6SiliGwNbSZd9oz8I=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40PE4cTM005116
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 25 Jan 2024 08:04:38 -0600
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 25
 Jan 2024 08:04:38 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 25 Jan 2024 08:04:38 -0600
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40PE4cf2036883;
	Thu, 25 Jan 2024 08:04:38 -0600
Date: Thu, 25 Jan 2024 08:04:38 -0600
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
Message-ID: <20240125140438.lmjrjzxqoy5lgsir@corset>
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
> > Is there a reason for difference in white space addition?
> > 
> 
> For mcu_r5fss0_core0 child node there was no blank line as per the
> recommended coding style : https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/dts-coding-style.rst#n124
> 
> So I added a newline there and wkup_r5fss0 already had it correct, since the
> change was trivial it was not mentioned in commit message.
> 

For some reason i was misled to think that the EoL spacing was messed
up. Looking at
https://lore.kernel.org/all/20240121134017.374992-1-vaishnav.a@ti.com/ i
realise it is being fixed properly in the patch. Oops.. my bad.


Reviewed-by: Nishanth Menon <nm@ti.com>
-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

