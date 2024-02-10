Return-Path: <linux-kernel+bounces-60232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 99C0C8501B2
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 02:26:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37654B27E92
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 01:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CFB8CA42;
	Sat, 10 Feb 2024 01:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="P18fgk+W"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08EE020E4;
	Sat, 10 Feb 2024 01:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707528218; cv=none; b=nunZ8ejB7sc4+NvkS4xtycAeah1JUwT7poftwQcVf5gKflvyxAKhfoYslca65Udjd5+iw5BztUqwJ8RHtdB9McSiNCp/CpbpbSKmlE9LOmA0+HPG/u/lXBjoq8KM/lTDBiXeot+9QsBE/4uKl4MR7S5qQDrkIbD0u+FDmEFoXMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707528218; c=relaxed/simple;
	bh=65v7rtkhp0OWl5DpM9D8vtYATJl34dNdTxTUsrC4894=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YqkOYWPI5Dn9+T8Wg/vTP1zH01WBmCqcMDBUCGJP/TZup+ZD9Ux9XG6bHnc1CWovYizHw3hyiTspzZkoeLsGv8F4QcZ69pAOvIcLNr+o377AH3zOKrZa8IOWat7xfN1hi8rYQDYTrFQVgYHVS6zWR8M60ZNK+VLOLAfsHrVJCOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=P18fgk+W; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=YUFLcEYfyUWvvnnOMjiq8Gpkyxsotwtv4BM5IK2k+8A=; b=P18fgk+WvNbVrWEbhD/eCl468L
	dLDfv+baay/0mjbZeHAI5SekxAL9ZQeH+hk1oQ8g9Ryt2orBO0g3+uSePLWOWStKTo9wl+bSbn4GL
	/FBfk3rciwkpwc7iMHp3bkqC/awfAEL3B/4les9mbC0fvjYKS1Qz8HGOcz/R80SOSb00=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rYc5c-007Qub-3u; Sat, 10 Feb 2024 02:23:32 +0100
Date: Sat, 10 Feb 2024 02:23:32 +0100
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
	linux-arm-msm@vger.kernel.org,
	Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [net-next PATCH v7 05/10] dt-bindings: net: Document Qcom
 QCA807x PHY package
Message-ID: <dd2954e7-3b8c-4ef2-92d6-00212af7535c@lunn.ch>
References: <20240206173115.7654-1-ansuelsmth@gmail.com>
 <20240206173115.7654-6-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240206173115.7654-6-ansuelsmth@gmail.com>

On Tue, Feb 06, 2024 at 06:31:08PM +0100, Christian Marangi wrote:
> Document Qcom QCA807x PHY package.
> 
> Qualcomm QCA807X Ethernet PHY is PHY package of 2 or 5
> IEEE 802.3 clause 22 compliant 10BASE-Te, 100BASE-TX and
> 1000BASE-T PHY-s.
> 
> Document the required property to make the PHY package correctly
> configure and work.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

