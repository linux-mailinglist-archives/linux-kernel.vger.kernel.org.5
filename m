Return-Path: <linux-kernel+bounces-29398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EBADD830DB5
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 21:07:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A9CA1C21F6D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 20:07:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76DD024B35;
	Wed, 17 Jan 2024 20:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="3draHPj8"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 991CA28E08;
	Wed, 17 Jan 2024 20:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705521921; cv=none; b=EXgN1mbuGuuRKgNNeSxXQlwEII8WZlJZT32sL+gkQ1LUgaMVuGqnpdYogjf/isTUC0PCaeLX2s3vNSYXRShXCn3ykeNVlTsrHaU7X4727pvgAWqEJSS3gnl3rw6MoSjsIgrvEMtab3QVdXZd2l7zuRPhi71g87R5kIFMNRHiEsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705521921; c=relaxed/simple;
	bh=E6dxYMy2Z2QQ0y4jy0+hi+7kwOw9cSpS2xhCTEdsc/s=;
	h=DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To; b=OW8gE7RUMyloozOun8WvtV2ZrI4xNK5H5T8Q1a92XF9mnwF+e74acqdBQcluj6xBOCMRm+/3UTjNqR6n0Exla/6+acbnOx2O8LgyP+VY28kv2h33m2rKvj9dGVBU9t71gOJMdI5T4rhwkrBV4ELxLeOS2MunH7jiJSdnSMdyhOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=3draHPj8; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=R6Lc/SpeoZHjRLO/GO2tIVDi6ZtvIYMTaxkExG+20Jo=; b=3draHPj8t5mDQDFbBv4roebFZx
	rwjM497PSAeoci7h2LvI2jrqsw8Hz3hd6mcxMjkS9fZ7AvRicv5INfMox2ULL+byoce8Qy96RlaJ8
	6gp2gJNqNNV5cBwWN/HW0GI94olfSl2G0a4AA6QCGCBLJ50sDfFGQkVyK9a1R9vxLMLw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rQC9m-005Qig-J3; Wed, 17 Jan 2024 21:05:02 +0100
Date: Wed, 17 Jan 2024 21:05:02 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Sergey Ryazanov <ryazanov.s.a@gmail.com>
Cc: Christian Marangi <ansuelsmth@gmail.com>,
	Robert Marko <robert.marko@sartura.hr>,
	Vladimir Oltean <olteanv@gmail.com>,
	Rob Herring <robh+dt@kernel.org>, Luo Jie <quic_luoj@quicinc.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Andy Gross <agross@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [net-next PATCH RFC v3 1/8] dt-bindings: net: document ethernet
 PHY package nodes
Message-ID: <1fb9448f-c2c8-4e01-aa12-5f60f2b49160@lunn.ch>
References: <20231126015346.25208-1-ansuelsmth@gmail.com>
 <20231126015346.25208-2-ansuelsmth@gmail.com>
 <0926ea46-1ce4-4118-a04c-b6badc0b9e15@gmail.com>
 <659aedb1.df0a0220.35691.1853@mx.google.com>
 <0f4ec2ff-4ef7-4667-adef-d065cfbc0a91@gmail.com>
 <65a7210f.df0a0220.d10b2.1162@mx.google.com>
 <c81af808-d836-4054-b596-4a53b05f4c78@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c81af808-d836-4054-b596-4a53b05f4c78@gmail.com>

> On one hand it makes sense and looks useful for software development. On
> another, it looks like a violation of the main DT designing rule, when DT
> should be used to describe that hardware properties, which can not be learnt
> from other sources.
> 
> As far as I understand this specific chip, each of embedded PHYs has its own
> MDIO bus address and not an offset from a main common address. Correct me
> please, if I am got it wrong.

I don't have the datasheet for this specific PHY. But the concept of a
quad PHY in one package is well known. Take for example the
VSC8584. The datasheet is open on Microchips website. It has four
strapping pins to determine the addresses of the PHYs in the
package. The PHY number, 0 - 3 determine bits 0-1 of the MDIO
address. The 4 strapping pins then determine bit 2-5 of the address.

In theory, each PHY could have its own strapping pins, allowing it to
be set to any address, and two PHYs could even have the same
address. But i doubt anybody actually builds hardware like that. I
expect the base addresses is set at the package level, and then PHYs
are just offsets from this.

So to me, a range property does seem reasonable. However, I agree, we
need acceptance from the DT Maintainers.

     Andrew

