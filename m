Return-Path: <linux-kernel+bounces-60237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A0B78501CA
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 02:41:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D535D28AE71
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 01:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D5A94C7B;
	Sat, 10 Feb 2024 01:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Bmxw64vw"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A8B81C14;
	Sat, 10 Feb 2024 01:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707529264; cv=none; b=c3EBXq2sTM7iIM7DCN87/GpDtS9Mm5WwgqyH1oONpzvcS2kkpHn/V5V4SCQKQ14G/M8z9y1jpIk87Ukbx3CdKb7NW1TK+xn0u72gmKwyuYxxvYtuizs+/LdQUvs+i7f1JXrUFvGPbemAbnVa/3jzArQfYXsKQIzjK5b6qwtuvdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707529264; c=relaxed/simple;
	bh=hVfdbdnWIeE05iuF/4Y5LtYZEBfwBiXJn7WfSygtUd8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rcPuTYlWTJPLReYhihnptDQY2HNMfX1V09He5eJ7u1wUvKMPlhmsZhDOrI3BFdoF9W/aIweR/KpxsAUJgoRBrJjeuYlQejzquLPK5R2eSGCCX4S8WBrW2ka/zRwDzswxsb+viopg8pvDp3hxpK331bxxmBV43oh9U4VtQjfs2GA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Bmxw64vw; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=odzVVBa3rbBYMjwCb9ejTVEXe50omTJoRD5jfRvsAaM=; b=Bmxw64vwVWesdaEEqIMbUtdPbn
	7e+eoUgNxh2mbYjzMoofw+HsqoYtaDUoyW5urAGgTRQVPegGxPgjZ9IXbrbWxwSG8qkH3tsclKm5S
	jTOoD3urxfuXIodK60C1aCPUH6V1V/ZGC1nbI1ADUEE69ilWagfUYTuzymhJf7nZ6sO0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rYcMS-007QyB-Mp; Sat, 10 Feb 2024 02:40:56 +0100
Date: Sat, 10 Feb 2024 02:40:56 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Robert Marko <robert.marko@sartura.hr>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Subject: Re: [net-next PATCH v7 07/10] net: phy: qcom: add support for
 QCA807x PHY Family
Message-ID: <d1766037-65bc-4b2b-be4b-3d32bd80a62a@lunn.ch>
References: <20240206173115.7654-1-ansuelsmth@gmail.com>
 <20240206173115.7654-8-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240206173115.7654-8-ansuelsmth@gmail.com>

On Tue, Feb 06, 2024 at 06:31:10PM +0100, Christian Marangi wrote:
> From: Robert Marko <robert.marko@sartura.hr>
> 
> This adds driver for the Qualcomm QCA8072 and QCA8075 PHY-s.
> 
> They are 2 or 5 port IEEE 802.3 clause 22 compliant 10BASE-Te,
> 100BASE-TX and 1000BASE-T PHY-s.
> 
> They feature 2 SerDes, one for PSGMII or QSGMII connection with
> MAC, while second one is SGMII for connection to MAC or fiber.
> 
> Both models have a combo port that supports 1000BASE-X and
> 100BASE-FX fiber.
> 
> PHY package can be configured in 3 mode following this table:
> 
>               First Serdes mode       Second Serdes mode
> Option 1      PSGMII for copper       Disabled
>               ports 0-4
> Option 2      PSGMII for copper       1000BASE-X / 100BASE-FX
>               ports 0-4
> Option 3      QSGMII for copper       SGMII for
>               ports 0-3               copper port 4
> 
> Each PHY inside of QCA807x series has 4 digitally controlled
> output only pins that natively drive LED-s.
> But some vendors used these to driver generic LED-s controlled
> by userspace, so lets enable registering each PHY as GPIO
> controller and add driver for it.
> 
> These are commonly used in Qualcomm IPQ40xx, IPQ60xx and IPQ807x
> boards.
> 
> Co-developed-by: Christian Marangi <ansuelsmth@gmail.com>
> Signed-off-by: Robert Marko <robert.marko@sartura.hr>
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

