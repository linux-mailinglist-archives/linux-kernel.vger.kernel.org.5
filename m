Return-Path: <linux-kernel+bounces-60231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 826048501AE
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 02:25:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4D241C27195
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 01:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38D604C90;
	Sat, 10 Feb 2024 01:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="PrvHJSfz"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCECC2116;
	Sat, 10 Feb 2024 01:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707528112; cv=none; b=WCjh2JneRDEjiV0g4LuNqZn8glYzRCPw+hfWQu/CrRA6Y8gjN6c95HBj9pUDNtzPmnfklqyqiCkHQbKIp0VoQ3mnCtm6CZ0+rs6PAKNDADjSsDLEh5ioaT9viPK8DMm2zkDQyClfzYh4movq/IPsL3iXVcwv4VutYrF/AmdYKg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707528112; c=relaxed/simple;
	bh=TIxZzeC/0GfDChnEMsFu4j1ALJeXBgp2+03IEBDMtcw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h+Qz9M13htk/SPYHlUN6ipxmuKlkb9Xfk4hn+ZZRhZaTIGNMCX+w/9/f1L/1RqbNMZM+EWbl/cjhDZKmtDUFEmopcllt9Gm9IJO95V1gfLHljokWk4nnFajdEOBLHmLvbEwGWKD/09NvsQ+Gx4sFIgjJlW9DJHTb8ig/5d32zRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=PrvHJSfz; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=dPJKmCY+cDQ7TBoc33Wmx47Gh+WQuX27uqcB77Gr2Jo=; b=PrvHJSfzIOohp+nFsDgvOARVud
	HfUm4CeSrqcO31y0f4JQN9zJH2CkWWR5TYAqe4NHZmMEmgqPpBkEzl2E9S2gUfcSWQdCizQbEjzUA
	UEI2TfLnqGAH+7KLhiENe/wTt/5DdNA6wXPhV0fnliP2uayXz06L3nBOrbThNjL3Nx2E=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rYc3u-007Qqu-GJ; Sat, 10 Feb 2024 02:21:46 +0100
Date: Sat, 10 Feb 2024 02:21:46 +0100
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
Subject: Re: [net-next PATCH v7 04/10] net: phy: qcom: move more function to
 shared library
Message-ID: <76460a45-2109-4600-9c87-414f88c76bc9@lunn.ch>
References: <20240206173115.7654-1-ansuelsmth@gmail.com>
 <20240206173115.7654-5-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240206173115.7654-5-ansuelsmth@gmail.com>

On Tue, Feb 06, 2024 at 06:31:07PM +0100, Christian Marangi wrote:
65;7402;1c> Move more function to shared library in preparation for introduction of
> new PHY Family qca807x that will make use of both functions from at803x
> and qca808x as it's a transition PHY with some implementation of at803x
> and some from the new qca808x.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

