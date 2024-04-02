Return-Path: <linux-kernel+bounces-127936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D0B898952FA
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 14:30:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DCEE1C21871
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 12:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6362F79DDB;
	Tue,  2 Apr 2024 12:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="PC4/IFUe"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3FC6335A7;
	Tue,  2 Apr 2024 12:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712061019; cv=none; b=lViCyPhxAu6dt0EFjghEWld6t4vAWLJn+BvcjEHxxeHvYLRCzEdezm1D2VscHSdWdvWQmFcGrZB3EKOrdfe13qfqXf1brp9X3Acl39rhfQH0tHl8rUv2anYVNRs/ivJEsUL0yIWaLAwNiViA5tGkFDpB2m3fs1gYcdwOLfCqtdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712061019; c=relaxed/simple;
	bh=ITCvpKJ5crNKh2Mzg3Vl0P7uLJLninjN71HBR/CKb7c=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ivye3u00YizWjedapZIUwpRXvN7/2lO6Gju7oySV2y0VWfdrOHNhc6uZJUWzwOgCLGmyqXo8LBu7Ci+0aVFjdNlYVdYcfhKf+TVfwr8sxNiOjqMsQXk7zcBfoWVJDCF3Zj5QElJmEkBRMkc6arlC8F7EefM1MRPtFr5Zsm6+DZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=PC4/IFUe; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 432CU64D047428;
	Tue, 2 Apr 2024 07:30:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1712061006;
	bh=rGB3cBxrxbzfkvdRjNadDZ6vfn6sw2z3o275CLvw278=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=PC4/IFUe05AXGx8mHQVVXUvyBHzEtHrFVPtrFW9ScWZJLJ+9tM2V0Nqv1yA7i+JIe
	 FWxt3BBQKqPi88nL0vK0K0HbIJ1M8vjYxj8lPXlTQUbAQPnoxHODwUKJo+daDTvRdY
	 +WtWeiI2TxyvFOyeFm5vc9Zw37ux5gITeIyeu6mg=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 432CU2nT025956
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 2 Apr 2024 07:30:06 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 2
 Apr 2024 07:30:03 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 2 Apr 2024 07:30:03 -0500
Received: from localhost (uda0492258.dhcp.ti.com [172.24.227.9])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 432CU261087192;
	Tue, 2 Apr 2024 07:30:03 -0500
Date: Tue, 2 Apr 2024 18:00:02 +0530
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: Siddharth Vadapalli <s-vadapalli@ti.com>, <lee@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>
Subject: Re: [PATCH] dt-bindings: mfd: syscon: Add ti,am62p-cpsw-mac-efuse
 compatible
Message-ID: <30065bdc-ccef-4610-b1c1-7661f801b8e9@ti.com>
References: <20240402105708.4114146-1-s-vadapalli@ti.com>
 <2e9b6a91-43d3-4b23-830d-40e607505d8c@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <2e9b6a91-43d3-4b23-830d-40e607505d8c@kernel.org>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On Tue, Apr 02, 2024 at 02:08:32PM +0200, Krzysztof Kozlowski wrote:
> On 02/04/2024 12:57, Siddharth Vadapalli wrote:
> > The CTRLMMR_MAC_IDx registers within the CTRL_MMR space of TI's AM62p SoC
> > contain the MAC Address programmed in the eFuse. Add compatible for
> > allowing the CPSW driver to obtain a regmap for the CTRLMMR_MAC_IDx
> > registers within the System Controller device-tree node. The default MAC
> > Address for the interface corresponding to the first MAC port will be set
> > to the value programmed in the eFuse.
> > 
> > Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> > ---
> > 
> > This patch is based on linux-next tagged next-20240402.
> 
> Where is the DTS using it?

The current implementation in the device-tree for older TI K3 SoCs is as
follows:

	cpsw_port1: port@1 {
		reg = <1>;
		ti,mac-only;
		label = "port1";
		phys = <&phy_gmii_sel 1>;
		mac-address = [00 00 00 00 00 00];
		ti,syscon-efuse = <&wkup_conf 0x200>;
	};

The "ti,syscon-efuse" property passes the reference to the System
Controller node as well as the offset to the CTRLMMR_MAC_IDx registers
within the CTRL_MMR space.

This implementation works only when the System Controller node
(wkup_conf or its equivalent depending on the SoC) has the compatible
"syscon". From AM62p SoC onwards, it was decided that the System
Controller nodes have to be modelled as a "simple-bus", due to which the
"syscon" based regmapping within the driver that uses the
"ti,syscon-efuse" property will no longer work directly. Therefore, with
this patch, the upcoming device-tree changes for AM62p will be:

1) Update in the System Controller node to use the newly added
compatible for mapping the CTRLMMR_MAC_IDx registers:

	wkup_conf: bus@43000000 {
		compatible = "simple-bus";
		reg = <0x00 0x43000000 0x00 0x20000>;
		#address-cells = <1>;
		#size-cells = <1>;
		ranges = <0x00 0x00 0x43000000 0x20000>;
		bootph-all;

		chipid: chipid@14 {
                        reg = <0x14 0x4>;
                        bootph-all;
                };
+
+               cpsw_mac_efuse: cpsw-mac-efuse@200 {
+                       compatible = "ti,am62p-cpsw-mac-efuse", "syscon";
+                       reg = <0x200 0x8>;
+               };
        };

2) Update within the cpsw_port1 node for passing the "cpsw_mac_efuse"
node:

		cpsw_port1: port@1 {
			reg = <1>;
			ti,mac-only;
			label = "port1";
			phys = <&phy_gmii_sel 1>;
			mac-address = [00 00 00 00 00 00];
+			ti,syscon-efuse = <&cpsw_mac_efuse 0x0>;
		};

> 
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Thank you for reviewing and acking this patch.

Regards,
Siddharth.

