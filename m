Return-Path: <linux-kernel+bounces-33154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD262836556
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 15:26:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 946A31F2435B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 14:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F90A3D56E;
	Mon, 22 Jan 2024 14:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="jr1UCVj1"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB5623D550;
	Mon, 22 Jan 2024 14:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705933564; cv=none; b=joOAZ8IW9nB+o62ZONNKy/AnSQhOflERtW0RiYzcxwnPSbAI9j5CPAIcc+xBCW9pxQbQGjdSBFcDreWE4xth/UIFQfEQi/1kkP+bVax5usQHO+AoN6h6ICnMIvSJ/LEWzef3sIS8kVDxnp9SJJTunxU8S+hdeJiyCJJPHFy6DLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705933564; c=relaxed/simple;
	bh=pjnm2lVqgNCInFj28zDKIV7ML2AgLtVB+44YgPff9vM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YUyT/JMxaOszL0D5bp2zsUK+DDoX+QzxRJC+MNOnSDz04/ACLJCLQdyPAhZ607iJ/1u6F2twvXpw0V/V3o3kw33IfA3pKV/lryz5CnRURrDh9Fcza4uBtAnJ8ckjen148HDykE6zG5cdkH4qEsaP1xRrct4S97waok44hDHo8mU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=jr1UCVj1; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ZgpoVOQM8qrxQhdVveMCPFTkIxUppA0Pw9b82iO99kI=; b=jr1UCVj1Q4Bptbe9SGYAU94oiy
	+J3vFXfAUmclOcNEKiS/+8BISG6iv9l4K7FuRewcUy5Q4BfmJFtWoYCTxooiqKP6+NnNQNfyb2kTq
	S5M9atD4TW+8KRdWxeJUAqi4r+hRuUjIeD9Qm5yNjNBe3hPRt48tN5yplKPrGtyTTUAM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rRvEz-005jLv-Qg; Mon, 22 Jan 2024 15:25:33 +0100
Date: Mon, 22 Jan 2024 15:25:33 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jie Luo <quic_luoj@quicinc.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, agross@kernel.org,
	andersson@kernel.org, konrad.dybcio@linaro.org, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, corbet@lwn.net, catalin.marinas@arm.com,
	will@kernel.org, p.zabel@pengutronix.de, linux@armlinux.org.uk,
	shannon.nelson@amd.com, anthony.l.nguyen@intel.com,
	jasowang@redhat.com, brett.creeley@amd.com, rrameshbabu@nvidia.com,
	joshua.a.hay@intel.com, arnd@arndb.de, geert+renesas@glider.be,
	neil.armstrong@linaro.org, dmitry.baryshkov@linaro.org,
	nfraprado@collabora.com, m.szyprowski@samsung.com, u-kumar1@ti.com,
	jacob.e.keller@intel.com, netdev@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, ryazanov.s.a@gmail.com,
	ansuelsmth@gmail.com, quic_kkumarcs@quicinc.com,
	quic_suruchia@quicinc.com, quic_soni@quicinc.com,
	quic_pavir@quicinc.com, quic_souravp@quicinc.com,
	quic_linchen@quicinc.com, quic_leiwei@quicinc.com
Subject: Re: [PATCH net-next 02/20] dt-bindings: net: qcom,ppe: Add bindings
 yaml file
Message-ID: <6fbfc205-fffa-42bd-8019-368559db77ac@lunn.ch>
References: <20240110114033.32575-1-quic_luoj@quicinc.com>
 <20240110114033.32575-3-quic_luoj@quicinc.com>
 <1d1116da-9af3-49e4-a180-cff721df5df5@linaro.org>
 <749136bc-3db9-4b2d-a9ca-e5fb5985f639@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <749136bc-3db9-4b2d-a9ca-e5fb5985f639@quicinc.com>

> > > +++ b/Documentation/devicetree/bindings/net/qcom,ppe.yaml
> > > @@ -0,0 +1,1330 @@
> > > +# SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/net/qcom,ppe.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Qualcomm Packet Process Engine Ethernet controller
> > 
> > Where is the ref to ethernet controllers schema?
> Sorry, the title above is not describing the device for this dtbindings
> correctly.  It should say "Qualcomm Packet Process Engine". The
> reference to the schema for PPE is mentioned above.

I think you are not correctly understanding the comment. within the
PPE you have a collection of Ethernet interfaces. All the common
properties for Ethernet ports are described in

Documentation/devicetree/bindings/net/ethernet-controller.yaml

so you are expected to reference this schema.

> > > +description:
> > > +  The PPE(packet process engine) is comprised of three componets, Ethernet
> > > +  DMA, Switch core and Port wrapper, Ethernet DMA is used to transmit and
> > > +  receive packets between Ethernet subsytem and host. The Switch core has
> > > +  maximum 8 ports(maximum 6 front panel ports and two FIFO interfaces),
> > > +  among which there are GMAC/XGMACs used as external interfaces and FIFO
> > > +  interfaces connected the EDMA/EIP, The port wrapper provides connections
> > > +  from the GMAC/XGMACS to SGMII/QSGMII/PSGMII/USXGMII/10G-BASER etc, there
> > > +  are maximu 3 UNIPHY(PCS) instances supported by PPE.

I think a big part of the problem here is, you have a flat
representation of the PPE. But device tree is very hierarchical. The
hardware itself is also probably very hierarchical. Please spend some
timer studying other DT descriptions of similar hardware. Then throw
away this vendor crap DT binding and start again from scratch, with a
hierarchical description of the hardware.

	Andrew

