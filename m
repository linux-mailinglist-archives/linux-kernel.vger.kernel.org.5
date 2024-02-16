Return-Path: <linux-kernel+bounces-68055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F58C85756A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 05:56:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52B841C21DD0
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 04:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D21B2125CC;
	Fri, 16 Feb 2024 04:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="y3dnoF9V"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A8D10949;
	Fri, 16 Feb 2024 04:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708059379; cv=none; b=o1o5i7TpQPqidzo1vuAJsLYFWrQ4fTIJEPMiqQp66y2YhHaNC0rDjSPSl2m6oqflNdgUbBlXgGp0M6JVFV0AqO1owFNg0sX538at1jCswCF/xmi5e4KtCIYeSwdNU5+dBBuU5OF3qdgA+fpyeQ4vqaCXa6tBi6YaED/J93v3zds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708059379; c=relaxed/simple;
	bh=Ou/nvlq81aM0Pr2pbksSHMNjqsJyDRDF8w8n8nwXRT8=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IlzehRBt960ZknjgifEPrIGCgS8dLGVYxd1lUsZsWgH8EO+BqZAHpSuMc5LrZ9nZopM/k8AvE8WmQSBrUJ2gzcZdrpObkz3jrlpzAEgnX1sDALqf65QqXbS4cxyqTq68zxGyk88YzXz/rGWrApS3lRq70HSxLV7kbBChVdl/7+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=y3dnoF9V; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41G4u3lW106116;
	Thu, 15 Feb 2024 22:56:03 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1708059363;
	bh=0BWZF9w9AsUu7G1y8eWnUvz158xOK51p3kZtdi4wJS4=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=y3dnoF9V9AmTPYiaQPSkH5chQBs5FvegnTAZjEqMBCqN96U7i0DH/nZi88aeFWsdk
	 xPcJMwawLDZH+6rzzVkKLueGZKd6iAaSxp/cTwPoUlQHn6rMFvotf5unsrTEX0jpYE
	 zsxNznPrX3Tdkck2XyAmZp9oQT+CAKkGo1Ziu6LQ=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41G4u3JS014093
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 15 Feb 2024 22:56:03 -0600
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 15
 Feb 2024 22:56:03 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 15 Feb 2024 22:56:03 -0600
Received: from localhost (uda0492258.dhcp.ti.com [172.24.227.9])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41G4u2QJ052968;
	Thu, 15 Feb 2024 22:56:02 -0600
Date: Fri, 16 Feb 2024 10:26:01 +0530
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: Peter Rosin <peda@axentia.se>, Andrew Davis <afd@ti.com>
CC: Siddharth Vadapalli <s-vadapalli@ti.com>, <nm@ti.com>, <vigneshr@ti.com>,
        <kristo@kernel.org>, <robh@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <gregkh@linuxfoundation.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <c-vankar@ti.com>, <srk@ti.com>
Subject: Re: [PATCH v5] arm64: dts: ti: k3-j784s4-main: Fix mux-reg-masks in
 serdes_ln_ctrl
Message-ID: <4abe2bde-1171-4b77-b7bc-49491792a721@ti.com>
References: <20240213080348.248916-1-s-vadapalli@ti.com>
 <1be60db1-f292-1074-5898-801380e1fb22@axentia.se>
 <af73545a-1746-4e14-a3f2-772d72e6ff97@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <af73545a-1746-4e14-a3f2-772d72e6ff97@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 24/02/13 11:08AM, Andrew Davis wrote:
> On 2/13/24 3:19 AM, Peter Rosin wrote:
> > Hi!
> > 
> > 2024-02-13 at 09:03, Siddharth Vadapalli wrote:
> > > From: Chintan Vankar <c-vankar@ti.com>
> > > 
> > > Change offset in mux-reg-masks property for serdes_ln_ctrl node
> > > since reg-mux property is used in compatible.
> > > 
> > > Fixes: 2765149273f4 ("mux: mmio: use reg property when parent device is not a syscon")
> > > Signed-off-by: Chintan Vankar <c-vankar@ti.com>
> > > Acked-by: Andrew Davis <afd@ti.com>
> > > Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> > > ---
..

> > > +			mux-reg-masks = <0x0 0x3>, <0x4 0x3>, /* SERDES0 lane0/1 select */
> > > +					<0x8 0x3>, <0xc 0x3>, /* SERDES0 lane2/3 select */
> > > +					<0x10 0x3>, <0x14 0x3>, /* SERDES1 lane0/1 select */
> > > +					<0x18 0x3>, <0x1c 0x3>, /* SERDES1 lane2/3 select */
> > > +					<0x20 0x3>, <0x24 0x3>, /* SERDES2 lane0/1 select */
> > > +					<0x28 0x3>, <0x2c 0x3>; /* SERDES2 lane2/3 select */
> > >   			idle-states = <J784S4_SERDES0_LANE0_PCIE1_LANE0>,
> > >   				      <J784S4_SERDES0_LANE1_PCIE1_LANE1>,
> > >   				      <J784S4_SERDES0_LANE2_IP3_UNUSED>,
> > 
> > Ouch. I suspect there is a similar problem in
> > arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi:
> > 
> > 
> > 	fss: bus@47000000 {
> > 		compatible = "simple-bus";
> > 		reg = <0x0 0x47000000 0x0 0x100>;
> > 		#address-cells = <2>;
> > 		#size-cells = <2>;
> > 		ranges;
> > 
> > 		hbmc_mux: mux-controller@47000004 {
> > 			compatible = "reg-mux";
> > 			reg = <0x00 0x47000004 0x00 0x2>;
> > 			#mux-control-cells = <1>;
> > -			mux-reg-masks = <0x4 0x2>; /* HBMC select */
> > +			mux-reg-masks = <0x0 0x2>; /* HBMC select */
> > 		};
> > 
> > Who knows what non-upstreamed devices and devicetrees are affected?
> > I guess we need to revert 2765149273f4 ("mux: mmio: use reg property
> > when parent device is not a syscon") unless someone sees a sane way
> > to fix this.
> 
> There are only two in-tree nodes with "reg-mux" with a reg property: the
> one this patch fixes, and the hbmc_mux you point out, both in TI devices.
> I'd say it is safe to assume we are the only users, and our non-upstreamed
> DTs depend on that patch, reverting it would cause more issues for
> out-of-tree users than just fixing the two broken nodes above.

Peter,

Is it alright for this patch to be merged, given Andrew's response above?
The problem with "hbmc_mux" node that you pointed out above could be fixed
by another patch. Please let me know.

Regards,
Siddharth.

