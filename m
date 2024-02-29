Return-Path: <linux-kernel+bounces-86603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC54986C7B4
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 12:07:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C96B287078
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 11:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA75C7AE4D;
	Thu, 29 Feb 2024 11:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="wYdmg8hD"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 597443C697;
	Thu, 29 Feb 2024 11:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709204861; cv=none; b=pM1ipkFEb1dxV8IGddyH60jUeFSTWhxr8R0ETXeTZDZgYjp8QeChh58+YCvBozjWn2YDWK5CHAEtGRprVtUD8F7cU+RdALgpal/mQl76Zd7MHbFhYw+WJ3MOC+kU4/A47fLWNXeBwHks88oeaB6yzkiJZQ5OEnQDm5BxWxE116U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709204861; c=relaxed/simple;
	bh=6woYrNGGmti1ionHiX+IXL9TVfmw3HMDJPTe6tvqaec=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d9yN9F7YJG8kVPEHYVcmrSpaCJyqPRzJnu4bXGEJXr5dXhTr6tehocPyHzAN71Y2tXcYiFOpiEBo1kUu3LIHnk1QtJQ5bgMS8rywL81ZYRP/irDM3OR5tVErKb4ZqoUvZWWCDGu+7NRokIrevXY39rUNDzGROAkKL6WH08aPOIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=wYdmg8hD; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41TB78I0117818;
	Thu, 29 Feb 2024 05:07:08 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1709204828;
	bh=kT+jMioerjaTj1csrJhXVuPSunvGWjfs9lKtYjDvS7M=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=wYdmg8hDXocdsgAqT68GK4T+AcooDGiGsnO1fBqJQlz+2D/oUjoHrsyRs8vmiCfJq
	 3JOnR8TJQHTclr42uBd4G3tAAXgMcHea/z+iBbzFw62sOuqGADKStW52tXBCEQGwEk
	 DSYTt8XfaoL6mxS0VTnG98jmCbePy3zJdVDCgBsQ=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41TB78ir032992
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 29 Feb 2024 05:07:08 -0600
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 29
 Feb 2024 05:07:08 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 29 Feb 2024 05:07:08 -0600
Received: from localhost (uda0492258.dhcp.ti.com [172.24.227.9])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41TB77w2095232;
	Thu, 29 Feb 2024 05:07:07 -0600
Date: Thu, 29 Feb 2024 16:37:06 +0530
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: Roger Quadros <rogerq@kernel.org>
CC: Siddharth Vadapalli <s-vadapalli@ti.com>, Andrew Lunn <andrew@lunn.ch>,
        Jiri Pirko <jiri@resnulli.us>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <vladimir.oltean@nxp.com>, <hkallweit1@gmail.com>,
        <dan.carpenter@linaro.org>, <horms@kernel.org>,
        <yuehaibing@huawei.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <srk@ti.com>, Pekka Varis <p-varis@ti.com>
Subject: Re: [PATCH net-next] net: ethernet: ti: am65-cpsw: Add priv-flag for
 Switch VLAN Aware mode
Message-ID: <389aea37-ce0f-4b65-bf7c-d00c45b80e04@ti.com>
References: <20240227082815.2073826-1-s-vadapalli@ti.com>
 <Zd3YHQRMnv-ZvSWs@nanopsycho>
 <7d1496da-100a-4336-b744-33e843eba930@ti.com>
 <Zd7taFB2nEvtZh8E@nanopsycho>
 <49e531f7-9465-40ea-b604-22a3a7f13d62@ti.com>
 <10287788-614a-4eef-9c9c-a0ef4039b78f@lunn.ch>
 <0004e3d5-0f62-49dc-b51f-5a302006c303@ti.com>
 <0106ce78-c83f-4552-a234-1bf7a33f1ed1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <0106ce78-c83f-4552-a234-1bf7a33f1ed1@kernel.org>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On Thu, Feb 29, 2024 at 12:52:07PM +0200, Roger Quadros wrote:
> 
> 
> On 29/02/2024 11:27, Siddharth Vadapalli wrote:
> > On Wed, Feb 28, 2024 at 02:36:55PM +0100, Andrew Lunn wrote:
> >>> What if there is no kernel behavior associated with it? How can it be mimicked
> >>> then?
> >>
> >> Simple. Implement the feature in software in the kernel for
> >> everybody. Then offload it to your hardware.
> >>
> >> Your hardware is an accelerator. You use it to accelerate what linux
> >> can already do. If Linux does not have the feature your accelerator
> >> has, that accelerator feature goes unused.
> > 
> > Is it acceptable to have a macro in the Ethernet Driver to conditionally
> > disable/enable the feature (via setting the corresponding bit in the
> > register)?
> > 
> > The current implementation is:
> > 
> > 	/* Control register */
> > 	writel(AM65_CPSW_CTL_P0_ENABLE | AM65_CPSW_CTL_P0_TX_CRC_REMOVE |
> > 	       AM65_CPSW_CTL_VLAN_AWARE | AM65_CPSW_CTL_P0_RX_PAD,
> > 	       common->cpsw_base + AM65_CPSW_REG_CTL);
> > 
> > which sets the "AM65_CPSW_CTL_VLAN_AWARE" bit by default.
> > 
> > Could it be changed to:
> > 
> > #define TI_K3_CPSW_VLAN_AWARE 1
> > 
> > ....
> > 
> > 	/* Control register */
> > 	val = AM65_CPSW_CTL_P0_ENABLE | AM65_CPSW_CTL_P0_TX_CRC_REMOVE |
> > 	      AM65_CPSW_CTL_P0_RX_PAD;
> > 
> > #ifdef TI_K3_CPSW_VLAN_AWARE
> > 	val |= AM65_CPSW_CTL_VLAN_AWARE;
> > #endif
> > 
> > 	writel(val, common->cpsw_base + AM65_CPSW_REG_CTL);
> > 
> > Since no additional configuration is necessary to disable/enable the
> > functionality except clearing/setting a bit in a register, I am unsure of
> > the implementation for the offloading part being suggested. Please let me
> > know if the above implementation is an acceptable alternative.
> 
> This doesn't really solve the problem as it leaves the question open as to
> who will set TI_K3_CPSW_VLAN_AWARE. And the configuration is then fixed at build.

I have set it above in my proposed solution:
#define TI_K3_CPSW_VLAN_AWARE 1
to match the existing driver implementation where it is already set by
default. Yes, the configuration is fixed at build since the implementation
in this patch which allows toggling it at runtime doesn't appear to be
acceptable, despite being quite similar to how the "Round Robin" and
"Fixed" Priority modes can be toggled using the "p0-rx-ptype-rrobin"
ethtool priv-flag.

> 
> Can you please explain in which scenario the default case does not work for you?
> Why would end user want to disable VLAN_AWARE mode?
> 
> TRM states
> "Transmit packets are NOT modified during switch egress when the VLAN_AWARE bit in the
> CPSW_CONTROL_REG register is cleared to 0h. This means that the switch is not in VLAN-aware mode."
> 
> The same problem would also apply to cpsw.c and cpsw_new.c correct?
> 
> A bit later the driver does this
> 
>         /* switch to vlan unaware mode */
>         cpsw_ale_control_set(common->ale, HOST_PORT_NUM, ALE_VLAN_AWARE, 1);
>         cpsw_ale_control_set(common->ale, HOST_PORT_NUM,
>                              ALE_PORT_STATE, ALE_PORT_STATE_FORWARD);
> 
> The comment says vlan unaware but code is setting ALE_VLAN_AWARE to 1.
> Is the comment wrong?

I have mentioned the following in my commit message to avoid confusion:
"The CPSW Ethernet Switch on TI's K3 SoCs can be configured to operate in
VLAN Aware or VLAN Unaware modes of operation. This is different from
the ALE being VLAN Aware and Unaware."

with emphasis being on "This is different from the ALE being VLAN Aware and
Unaware."

ALE_VLAN_AWARE belongs to the "CPSW_ALE_CONTROL" register and is defined
as:
ALE_VLAN_AWARE determines how traffic is forwarded using VLAN rules.
0h = Simple switch rules, packets forwarded to all ports for unknown
destinations.
1h = VLAN Aware rules, packets forwarded based on VLAN members.

On the other hand, AM65_CPSW_CTL_VLAN_AWARE belongs to the "CPSW_CONTROL"
register and is defined as:
VLAN Aware Mode:
0h = CPSW_NU is in the VLAN unaware mode.
1h = CPSW_NU is in the VLAN aware mode.

They are completely different and offer entirely different
functionality. CPSW_VLAN_AWARE corresponding to the
AM65_CPSW_CTL_VLAN_AWARE bit enables further packet processing:
VLAN tag addition/removal/replacement
which is a layer on top of the Software generated packets Egressing out
of the Ethernet Switch ports, or Forwarded packets Egressing out of the
Ethernet Switch ports. If the aforementioned modification is handled in
Software for example and we don't want packets from Software or on the
Forwarding path to be modified, then turning off the CPSW_VLAN_AWARE
mode is necessary.

Regards,
Siddharth.

