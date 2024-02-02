Return-Path: <linux-kernel+bounces-50623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A451B847BD0
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 22:51:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33E4D1F2AFDD
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 21:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 578028592D;
	Fri,  2 Feb 2024 21:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="bTySsv6t"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D117D8060D;
	Fri,  2 Feb 2024 21:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706910649; cv=none; b=uDcQQrT/XhQI6NcwPyUOiVEICiMoFxLGLtp5fcWY7URVZ8DrUAXDpaX9wVLtLrJIKjuDZFvQwxxWxviWOg7y+5gbu+lMfiduIyfqXeYlCNw3onvxXXRb9aWiTmmz2vTNs3CKARNw4oqL4E7I4teFJ9t6QKcbDt6F4ucx8fj9JAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706910649; c=relaxed/simple;
	bh=O2Lsa5KL5GxKg5QnRfDjyLpIoTIAQCOszwP8LJlqAuo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZdBTb7pNAdYN+DyevOmnU585XBVZmbEXvnevtnIEkEByPA4Anf74lMeV2u0v/nvRnW1Rgr/BEnbVT+GzPWRaSEmoywxHD61vxnF8vojRzCJ4kgEKVS4xgUkoNNXcZyoFhAdJd9GP9iELAnh9JZqdUWMqgjBy7nRyqJ+ipuJ0NIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=bTySsv6t; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=NcIRGxju6SMTFH2+BO670Y4r/6YmRM2psDzw/RSO4YY=; b=bTySsv6tAo2nG6vDjflCwLCzzg
	yyvGGwyvsWA1nZv7jr0L+Z5cxITNBEfZnfIvqV2Nr4YrI6qzGDTXw0/NMRruC5rMV+GrriWFcPjRZ
	KlpeVRrQnE08zfUuj/mM+SBMTrT0CAiFfRwbXZNACfPssDVvML9oPinHV4a8Gt9TSbJ8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rW1Qh-006qsK-Dp; Fri, 02 Feb 2024 22:50:35 +0100
Date: Fri, 2 Feb 2024 22:50:35 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Rob Herring <robh@kernel.org>
Cc: Christian Marangi <ansuelsmth@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Frank Rowand <frowand.list@gmail.com>,
	Robert Marko <robert.marko@sartura.hr>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Subject: Re: [net-next PATCH v5 6/9] dt-bindings: net: Document Qcom QCA807x
 PHY package
Message-ID: <9e6298ad-a0c9-4c3e-b94b-13dec8c253c6@lunn.ch>
References: <20240201151747.7524-1-ansuelsmth@gmail.com>
 <20240201151747.7524-7-ansuelsmth@gmail.com>
 <20240202204536.GB1075521-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240202204536.GB1075521-robh@kernel.org>

> > +patternProperties:
> > +  ^ethernet-phy(@[a-f0-9]+)?$:
> 
> I don't get how an address is optional.

Its pretty unusual, but for example:

arch/arm/boot/dts/nxp/imx/imx6q-novena.dts

&fec {
        pinctrl-names = "default";
        pinctrl-0 = <&pinctrl_enet_novena>;
        phy-mode = "rgmii";
        phy-handle = <&ethphy>;
        phy-reset-gpios = <&gpio3 23 GPIO_ACTIVE_LOW>;
        status = "okay";

        mdio {
                #address-cells = <1>;
                #size-cells = <0>;

                ethphy: ethernet-phy {
                        compatible = "ethernet-phy-ieee802.3-c22";
                        rxc-skew-ps = <3000>;
                        rxdv-skew-ps = <0>;
                        txc-skew-ps = <3000>;
                        txen-skew-ps = <0>;
                        rxd0-skew-ps = <0>;
                        rxd1-skew-ps = <0>;
                        rxd2-skew-ps = <0>;
                        rxd3-skew-ps = <0>;
                        txd0-skew-ps = <3000>;
                        txd1-skew-ps = <3000>;
                        txd2-skew-ps = <3000>;
                        txd3-skew-ps = <3000>;
                };
        };
};

There is no reg property, because its optional. If there is no reg,
there is no address.

When phylib finds a DT blob like this, it enumerates the bus, and then
assigns the nodes to the devices it finds in the order it finds them.

Its old behaviour, from before the times of yaml validation, and
current best practices, etc. But because it works, it still used in
new bindings.

    Andrew

