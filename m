Return-Path: <linux-kernel+bounces-62226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7757D851D47
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 19:50:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C69DAB28D42
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 18:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E9A045BF3;
	Mon, 12 Feb 2024 18:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="SLjqtGML"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EE4A45BE6;
	Mon, 12 Feb 2024 18:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707763721; cv=none; b=hbM5srgbFOvYK6/KBt6JBszs+JficccYnuukh2uwhcWR5hn9ixMdVMi/5TDAsVKTDgNnR8DwAenFVUahn0POghM8F4p5jfKvCijypyBliJ8CsGEhhD4tnIGx+gW9XStdxL8hXOQ94NRLrrR5O7GXSqxAcOyu41aKp5lO84Gzc6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707763721; c=relaxed/simple;
	bh=rmSuvZ9VCPI0UhhTZVLVZILM/1fXstYqxDyzla5LooQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y2L799R9VfJUsHXk2qeLSwk7z6iJY/fqWCLsUHIoInnM0mbGXqRGs7hHNWiGToVlZx/pRzbEfXE2Qh7lfdohUHopTMhG1fu25rEASBAbWF2rPjnSQ8rpq6X7Z+OY6xIL07aA5fgRRPGWW2NPh7PIdh/zOQbHIWJyIBY14f5mh8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=SLjqtGML; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1707763717;
	bh=rmSuvZ9VCPI0UhhTZVLVZILM/1fXstYqxDyzla5LooQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SLjqtGMLqX0g2Ma1SgR6SVodhVloob9ICI8GWWXw9wWdoHXa2KAI9nbRzDWEaIHYY
	 y/yu7NEBjtg5yJFf23dYJ1TYRMmeVrY+OlA7k+Q2ABAujA1P11FAUIkXwUjQ+GQLUk
	 W3+fvx/rJu2Yn9dWlH6DEbYURC+kYfkaWqa/DP3EK2EWz+B70uZM7akFADc5U07jpp
	 O6XCpOuo9WPEtmxi9e/W4QDk8OAiFlosyfr9dUggVlZxYrJd1NuEtcFj1LaFHvNc4f
	 SwLxanuzW07EtFeLj2ZamN6mbkZf06gpEHisckAtStAWbUOPrn6tVyT4F034C8D9Lw
	 s3q+brWNjprqw==
Received: from mercury (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sre)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id A2F9E3782059;
	Mon, 12 Feb 2024 18:48:37 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
	id 3CE4A106A4BC; Mon, 12 Feb 2024 19:48:37 +0100 (CET)
Date: Mon, 12 Feb 2024 19:48:37 +0100
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Johan Jonker <jbx6244@yandex.com>
Cc: Heiko Stuebner <heiko@sntech.de>, Vinod Koul <vkoul@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, linux-rockchip@lists.infradead.org, 
	linux-phy@lists.infradead.org, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Frank Wang <frank.wang@rock-chips.com>, Kever Yang <kever.yang@rock-chips.com>, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCH v1 06/10] arm64: dts: rockchip: add USBDP phys on rk3588
Message-ID: <dsfne22iebd7mvyyskhpw3rkkfhlxpv32afht456vq3u52axyr@kgkxfzm5vn4c>
References: <20240209181831.104687-1-sebastian.reichel@collabora.com>
 <20240209181831.104687-7-sebastian.reichel@collabora.com>
 <6bc2f825-7e50-488d-a373-a211ac2cc8e1@yandex.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6bc2f825-7e50-488d-a373-a211ac2cc8e1@yandex.com>

Hi Johan,

On Sun, Feb 11, 2024 at 08:24:36PM +0100, Johan Jonker wrote:
> > +		u2phy1: usb2-phy@4000 {
> 
>         "usb2phy@[0-9a-f]+$":

Interesting. I would have expected that to pop up in dtbs_check, but
it does not for some reason. I will fix it for all usb2phy instances
in rk3588.

> > +			compatible = "rockchip,rk3588-usb2phy";
> > +			reg = <0x4000 0x10>;
> > +			interrupts = <GIC_SPI 394 IRQ_TYPE_LEVEL_HIGH 0>;
> 
> > +			resets = <&cru SRST_OTGPHY_U3_1>, <&cru SRST_P_USB2PHY_U3_1_GRF0>;
> > +			reset-names = "phy", "apb";
> > +			clocks = <&cru CLK_USB2PHY_HDPTXRXPHY_REF>;
> > +			clock-names = "phyclk";
> > +			clock-output-names = "usb480m_phy1";
> > +			#clock-cells = <0>;
> 
> Align with the (new) documentation
> about property ordering.
>
> > +			status = "disabled";
> > +
> > +			u2phy1_otg: otg-port {
> > +				#phy-cells = <0>;
> > +				status = "disabled";
> > +			};
> > +		};
> > +	};

The above follows everything from [0], which does not specify an
order for the "standard/common  properties". For those this follows
the order of existing usb2phy nodes. Did I miss any other new
Documentation?

[0] https://www.kernel.org/doc/html/next/devicetree/bindings/dts-coding-style.html#order-of-properties-in-device-node

-- Sebastian

