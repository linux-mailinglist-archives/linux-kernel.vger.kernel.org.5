Return-Path: <linux-kernel+bounces-128332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D69289599D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 18:23:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 869C2B2A42C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 16:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 630F614AD23;
	Tue,  2 Apr 2024 16:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="jZyU+o3A"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE868134BE;
	Tue,  2 Apr 2024 16:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712074460; cv=none; b=Zd/TR3+BM8fpKBOWE3bq3tNWJBlswvrmL/wTligPm57iHKSJdbKPV++xCT5CASfqro5ejKU5ZycldlI2bNH3G+r6jR3o9LOMvad9I3ATYmIfMlVHwug+JXiHo54GwT8YwA2+9bITb/2LQwaBV77b4PZX9ddhnGSWyZPGSSHVrmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712074460; c=relaxed/simple;
	bh=xHJ+tSHGGuQ9jsZ2apX+KntD2/XeUpIo2v53Ckmc8Gk=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RYSS3JDHQfIus+f2cp8UgaippUagspGFSgt1FSxMsoADVngPKhkwGKERRa+7Pl0gcVHOSNpjyNbvt9C0ByeL9RmxYM7UdB/kONF/Qkltb81p0m5vtwxyuC73HPacN2sra+yaWaGPvCGZUwS/5p+uCvNCimwCDIr1K4a20fTMTVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=jZyU+o3A; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 432GEAJY109149;
	Tue, 2 Apr 2024 11:14:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1712074450;
	bh=t1JMdyBrUjK+mhSrbszhUv7ANkg31fhvqLZ2TneV5yY=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=jZyU+o3A4wjOONqVBBnN6+Ucw3i2b3wetUSo/1k6gDR9pIARI3ha5YJ8eBOC7GhyK
	 rmrqAeU8jmDGXGEAQwf6hvryuWVgrr/eRTT2rJt3YloSOPZZkNiknad9/E9lFSYz7b
	 rI4WLC3eZgO58A2dfzJ6GE/4TUQIsKujRfHa1Yf4=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 432GEAPs034931
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 2 Apr 2024 11:14:10 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 2
 Apr 2024 11:14:09 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 2 Apr 2024 11:14:09 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 432GE9eE037640;
	Tue, 2 Apr 2024 11:14:09 -0500
Date: Tue, 2 Apr 2024 11:14:09 -0500
From: Nishanth Menon <nm@ti.com>
To: Nathan Morrisson <nmorrisson@phytec.com>
CC: <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <upstream@lists.phytec.de>,
        <w.egorov@phytec.de>
Subject: Re: [PATCH 2/2] arm64: dts: ti: k3-am642-phyboard-electra-rdk:
 Increase CAN max bitrate
Message-ID: <20240402161409.n4gjgivmsxskjfgx@spoils>
References: <20240402160825.1516036-1-nmorrisson@phytec.com>
 <20240402160825.1516036-3-nmorrisson@phytec.com>
 <20240402161203.q34gyqfaoewvjbky@unburned>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240402161203.q34gyqfaoewvjbky@unburned>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 11:12-20240402, Nishanth Menon wrote:
> On 09:08-20240402, Nathan Morrisson wrote:
> > The phyBOARD-Electra has two TCAN1044VDD CAN transceivers which
> > support CAN FD at 8 Mbps.
> > 
> > Increase the maximum bitrate to 8 Mbps.
> > 
> > Signed-off-by: Nathan Morrisson <nmorrisson@phytec.com>
> > ---
> >  arch/arm64/boot/dts/ti/k3-am642-phyboard-electra-rdk.dts | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/arm64/boot/dts/ti/k3-am642-phyboard-electra-rdk.dts b/arch/arm64/boot/dts/ti/k3-am642-phyboard-electra-rdk.dts
> > index 8237b8c815b8..522699ec65e8 100644
> > --- a/arch/arm64/boot/dts/ti/k3-am642-phyboard-electra-rdk.dts
> > +++ b/arch/arm64/boot/dts/ti/k3-am642-phyboard-electra-rdk.dts
> > @@ -42,7 +42,7 @@ can_tc1: can-phy0 {
> >  		pinctrl-names = "default";
> >  		pinctrl-0 = <&can_tc1_pins_default>;
> >  		#phy-cells = <0>;
> > -		max-bitrate = <5000000>;
> > +		max-bitrate = <8000000>;
> >  		standby-gpios = <&main_gpio0 32 GPIO_ACTIVE_HIGH>;
> >  	};
> >  
> > @@ -51,7 +51,7 @@ can_tc2: can-phy1 {
> >  		pinctrl-names = "default";
> >  		pinctrl-0 = <&can_tc2_pins_default>;
> >  		#phy-cells = <0>;
> > -		max-bitrate = <5000000>;
> > +		max-bitrate = <8000000>;
> >  		standby-gpios = <&main_gpio0 35 GPIO_ACTIVE_HIGH>;
> >  	};
> >  
> > -- 
> > 2.25.1
> > 
> 



> This is better at arch/arm64/boot/dts/ti/k3-am62p-main.dtsi.
> 

Woops.. wrong mail thread. :( Apologies on the spam.
-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

