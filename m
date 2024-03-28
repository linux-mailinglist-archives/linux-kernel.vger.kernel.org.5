Return-Path: <linux-kernel+bounces-123146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B8728902F2
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 16:22:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAC4F29573A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 15:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4B0E12F592;
	Thu, 28 Mar 2024 15:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="cUmTmHgU"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A588004F;
	Thu, 28 Mar 2024 15:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711639345; cv=none; b=M6r263yO2sKvG7Mka8YukvFi49KhIBvILbFKTnfksml+tlZnUcxLQ3Wv3sikyt6YB3XoqLhRgLupuechnpLqqVFSg/6j8sEMTj3F43+Vl5fhW+ZB4Xsvf2vgxV/gFj8Prut+uKc5LriDO93CyBPxRZ5UP97T/ynxw5cxxbxxBmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711639345; c=relaxed/simple;
	bh=bLg2e6mwBKjSve4OEmRJ0swgtQbc1H7j1+RXrYDfSrE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AA/tcOkWe3HJ+3CyhvJ56qb0ADK5HtL1DXry/Mmr0STIv/ZTrhVNrX66vlEA21c71nLbN+jZoL031+vwMrjxmL/8i6n/ea70vjqeX2LQQ1zjBL7p8MMq2ddi9lBqzAvgbs4p4fzOUdSs3Em2IyBC2U13WavNwCYBYQJT3B1GQLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=cUmTmHgU; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=0KikSW9ib+1cYtRn9w2uRLKS6BuW9Jey9jBSZin/1jU=; b=cUmTmHgUj+sE8DS9wRyBTtTkJ/
	lJDbO1E6Wtrjuk7CAXb74Ve72lGwIat6hzsxeftbnWWjAXDnv9H042dx0nk7TKn/372JTknDKKxTh
	9sI5+OituYqypJRXFELZUWuonXIf1ypJyZf4H522b+Z/nx9noHpJRzGWHfTO1kUmNIIc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rprZt-00BVng-WF; Thu, 28 Mar 2024 16:22:06 +0100
Date: Thu, 28 Mar 2024 16:22:05 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Russ Weight <russ.weight@linux.dev>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Mark Brown <broonie@kernel.org>,
	Frank Rowand <frowand.list@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, devicetree@vger.kernel.org,
	Dent Project <dentproject@linuxfoundation.org>
Subject: Re: [PATCH net-next v6 13/17] net: pse-pd: Use regulator framework
 within PSE framework
Message-ID: <0d91784a-48db-4e25-88e5-9994dfd3d68f@lunn.ch>
References: <20240326-feature_poe-v6-0-c1011b6ea1cb@bootlin.com>
 <20240326-feature_poe-v6-13-c1011b6ea1cb@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240326-feature_poe-v6-13-c1011b6ea1cb@bootlin.com>

On Tue, Mar 26, 2024 at 03:04:50PM +0100, Kory Maincent wrote:
> From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>
> 
> Integrate the regulator framework to the PSE framework for enhanced
> access to features such as voltage, power measurement, and limits, which
> are akin to regulators. Additionally, PSE features like port priorities
> could potentially enhance the regulator framework. Note that this
> integration introduces some implementation complexity, including wrapper
> callbacks, but the potential benefits make it worthwhile.
> 
> Regulator are using enable counter with specific behavior.
> Two calls to regulator_disable will trigger kernel warnings.
> If the counter exceeds one, regulator_disable call won't disable the
> PSE PI. These behavior isn't suitable for PSE control.
> Added a boolean 'enabled' state to prevent multiple calls to
> regulator_enable/disable. These calls will only be called from PSE
> framework as it won't have any regulator children, therefore no mutex are
> needed to safeguards this boolean.
> 
> regulator_get needs the consumer device pointer. Use PSE as regulator
> provider and consumer device until we have RJ45 ports represented in
> the Kernel.
> 
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

