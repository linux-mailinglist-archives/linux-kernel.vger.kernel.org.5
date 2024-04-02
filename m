Return-Path: <linux-kernel+bounces-127731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FC2E89501F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 12:32:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 517501C223E7
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 10:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8F7751021;
	Tue,  2 Apr 2024 10:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Mu4VtJeW"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36526DF6C;
	Tue,  2 Apr 2024 10:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712053952; cv=none; b=bdlG0xzP7kSSHZz8Nl9F4UEmOJJ++7m+p0XatHFLexWz4Z9BQBX0nznJDLTzI8EdNXrvZfGzaYiZ77bBYNCk3Q1c/2ujyJaeHQ4sqN16myvA+usf6V1RoVHNjRGVSrE53UWhdtbPBsfn7FCa6XZ2uitWzoRyX10A7TWGiPvOx6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712053952; c=relaxed/simple;
	bh=FGTkHGVJBQ7WLA4fbtaAPKtWLmKPTydm8JF3eXKX9uM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mzzyEl0FiCDAM1mT6U/U+WSWBIEn809vrosg699rYmlwtjYc/HLdMGfzi1yxyT1X/zXUcbJ655kEPm8C2zFvDdMtKBwpK43U/AJ7l4eeXNHKdSX8+RL1QIdALO/fq5F7wlWQ7cgLqnt4QlnMdAtGd7w6u9cMhHNibdAooUD+GkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Mu4VtJeW; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 432AW9ui090480;
	Tue, 2 Apr 2024 05:32:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1712053929;
	bh=wQVwSWKrm0EgnIxeUa2GAwM5gLQzgzwhftJoCoivg2s=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=Mu4VtJeW+3/ocUvg2FakGq3DVzE9EsNjcQC2aorHDidaK/6FYfG8q+vG1fm0dahkx
	 ljQtkXbS5yjyxVQzktrATkcMpg9nU9I9rVxDDJGui/Qxxw7Saipdk8IPiQkRpJ3pTM
	 2J/cWU7eLZyoSDBfY4tdlqszx1xLBy1IVG4wng0M=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 432AW9Kv060645
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 2 Apr 2024 05:32:09 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 2
 Apr 2024 05:32:09 -0500
Received: from fllvsmtp7.itg.ti.com (10.64.40.31) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 2 Apr 2024 05:32:09 -0500
Received: from localhost (uda0492258.dhcp.ti.com [172.24.227.9])
	by fllvsmtp7.itg.ti.com (8.15.2/8.15.2) with ESMTP id 432AW89V057057;
	Tue, 2 Apr 2024 05:32:09 -0500
Date: Tue, 2 Apr 2024 16:02:07 +0530
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: Vignesh Raghavendra <vigneshr@ti.com>
CC: Siddharth Vadapalli <s-vadapalli@ti.com>, <nm@ti.com>, <kristo@kernel.org>,
        <robh@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <srk@ti.com>
Subject: Re: [PATCH] arm64: dts: ti: k3-am62p-main: use eFuse MAC Address for
 CPSW3G Port 1
Message-ID: <f7cadda8-c3cf-48a0-846a-1ff317a28292@ti.com>
References: <20240402094200.4036076-1-s-vadapalli@ti.com>
 <ae04c041-688c-4413-8f15-b37b4ea44aac@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ae04c041-688c-4413-8f15-b37b4ea44aac@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On Tue, Apr 02, 2024 at 03:25:41PM +0530, Vignesh Raghavendra wrote:
> 
> 
> On 02/04/24 15:12, Siddharth Vadapalli wrote:
> > Assign the MAC Address programmed in the eFuse registers as the default
> > MAC Address for CPSW3G MAC Port 1. Utilize the "ti,syscon-efuse"
> > device-tree property to do so.
> > 
> > Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> > ---
> > 
> > This patch is based on linux-next tagged next-20240402.
> > 
> > Regards,
> > Siddharth.
> > 
> >  arch/arm64/boot/dts/ti/k3-am62p-main.dtsi | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi
> > index 7337a9e13535..eb126f4a04dd 100644
> > --- a/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi
> > +++ b/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi
> > @@ -696,6 +696,7 @@ cpsw_port1: port@1 {
> >  				label = "port1";
> >  				phys = <&phy_gmii_sel 1>;
> >  				mac-address = [00 00 00 00 00 00];
> > +				ti,syscon-efuse = <&wkup_conf 0x200>;
> 
> Sorry, how does this work? wkup_conf is not marked as "syscon" compatible?

Sorry I failed to realize that. So this will also require adding a
custom property similar to:
https://github.com/torvalds/linux/commit/cc1965b02d6cb18d9220dae06f7e2e0b0ebbea48
followed by adding a new sub-node within wkup_conf corresponding to the
MAC Address CTRL_MMR registers.

Thank you for reviewing the patch and pointing this out.

Regards,
Siddharth.

