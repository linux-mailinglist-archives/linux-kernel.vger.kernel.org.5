Return-Path: <linux-kernel+bounces-38674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB91E83C3F4
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 14:44:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B0671C229B3
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 13:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4EE256775;
	Thu, 25 Jan 2024 13:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="UpLpM2Nh"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D1457866;
	Thu, 25 Jan 2024 13:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706190261; cv=none; b=ciey6gSHVIJvQXwmv0rtDGJgO/y+RghUNkTENJxhuorWzXR+7NYUZHcL8dDFgvCQlJHbB7U1v7iVBXjn3FY9IXQdy1pDfE8Pqi1KXFyBSf3WrVQeW5WxXFe3kDFfirYyl/pSjW0t9wyCWd9zJDozq2iK7sLGYlCnnGfQNclXB/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706190261; c=relaxed/simple;
	bh=U3wRvNY2O/dctsYNoVNOBsBZpab8oQr3jJ3UTtBJXxc=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VDgoYbZ9Dl7I90HSP/59dBqSQHfifcEXnRqVRrn1tPxCGvFIQxuO01XojJxWoWy54uvFLV39Y5igjSO7g94icamZI7HeXFzFb5XADkUUwrJV4hA+t2hITNSOSz3Fsr5cVVjUP0XRrgpjZ48jdmzRczafY+pJPDnFaAw62cZk9ZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=UpLpM2Nh; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40PDiCGO029911;
	Thu, 25 Jan 2024 07:44:12 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706190252;
	bh=3aBB0bLA/J/XooeXP4TOiES6sNIVwzVCNgkBINyuOlQ=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=UpLpM2Nh4Ki+T6yGdnWiuX3ihIfMWhJ4lXTSjgS40VAeoulXsoLoq+kSwBU0yREwD
	 cGG6o+WxERwldMesBBXQWODaHVMLm4dXh7z2c1yDz1afTA6wl5bMFcd7++ZVrk6lgf
	 BMTSVYuGXETxkdQfZnsmZgtfYdkAOJdWguLFbGQw=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40PDiCEG017297
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 25 Jan 2024 07:44:12 -0600
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 25
 Jan 2024 07:44:11 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 25 Jan 2024 07:44:11 -0600
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40PDiBAf064454;
	Thu, 25 Jan 2024 07:44:11 -0600
Date: Thu, 25 Jan 2024 07:44:11 -0600
From: Nishanth Menon <nm@ti.com>
To: Chintan Vankar <c-vankar@ti.com>
CC: Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, Tero
 Kristo <kristo@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <afd@ti.com>, <srk@ti.com>, <s-vadapalli@ti.com>,
        <r-gunasekaran@ti.com>, <danishanwar@ti.com>, <tony@atomide.com>,
        Jayesh Choudhary <j-choudhary@ti.com>
Subject: Re: [PATCH v2 2/5] arm64: dts: ti: k3-j784s4: Add Main CPSW2G node
Message-ID: <20240125134411.nzw7mou7cth7hh4m@postage>
References: <20240118094454.2656734-1-c-vankar@ti.com>
 <20240118094454.2656734-3-c-vankar@ti.com>
 <20240119131810.2qg2zkb3xi4km74q@irritable>
 <51317410-ae05-45ab-a0d3-3bcb5e925122@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <51317410-ae05-45ab-a0d3-3bcb5e925122@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 15:02-20240125, Chintan Vankar wrote:
> 
> On 19/01/24 18:48, Nishanth Menon wrote:
> > On 15:14-20240118, Chintan Vankar wrote:
> > > From: Siddharth Vadapalli<s-vadapalli@ti.com>
> > > 
> > > J784S4 SoC has a Main CPSW2G instance of the CPSW Ethernet Switch.
> > > 
> > > Add the device-tree nodes for the Main CPSW2G instance and enable it.
> > > 
> > > Signed-off-by: Siddharth Vadapalli<s-vadapalli@ti.com>
> > > Signed-off-by: Jayesh Choudhary<j-choudhary@ti.com>
> > > Signed-off-by: Chintan Vankar<c-vankar@ti.com>
> > > ---
> > >   arch/arm64/boot/dts/ti/k3-j784s4-evm.dts   | 47 +++++++++++++++
> > >   arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi | 68 ++++++++++++++++++++++
> > >   2 files changed, 115 insertions(+)
> > Please do not mix the SoC and evm changes in the same patch.
> Okay. I will separate them in the v3 series
> > Also, any benefits of giving the second instance an alias?
> 
> Yes, there are benefits of adding an alias,
> 
> I will add aliases for both Main and MCU cpsw2g,
> 
> and post it in a future series.

If there is benefit, squash to current patch.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

