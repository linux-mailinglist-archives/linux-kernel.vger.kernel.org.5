Return-Path: <linux-kernel+bounces-67970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB8288573BD
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 03:16:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC3DA1C2292B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 02:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00274F9FE;
	Fri, 16 Feb 2024 02:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nSNIGP04"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D553DF46;
	Fri, 16 Feb 2024 02:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708049799; cv=none; b=mBaoY+yOPEZX722qNhz/F7FWDb6rZFJ5uhqQtm6a3/zIikMcdsE/wdNG9fCgX6q7CXY/tO6G2WEObIaXbtrVxL57TFfPePDk7AupLo8UwzyFuHM7AJ0jDABagx5loi4CmuaomHjgOVx59aA2UW3BHRicDx/xPAobH6HXhUrhb8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708049799; c=relaxed/simple;
	bh=2EcLmFQaTtw8KYBCCwxoWbIhAbsCHLV2pI2UyME+f+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MSz5G2To0HnjOhMQcVJE+2spMXWYXCJbJ5YqyqPbFmRDfu1qM4Ghugmhk3mOg6ya52fsglMhQli/mf/1igYGLQKNntvYEAJPfigbI9KtNSgxk967iA9vqEir5RaUq1Tc9bYUuQPaS0QF7DibnBZyuhobUCvifvr2ClSxcXR80TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nSNIGP04; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F6EBC433F1;
	Fri, 16 Feb 2024 02:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708049798;
	bh=2EcLmFQaTtw8KYBCCwxoWbIhAbsCHLV2pI2UyME+f+c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nSNIGP04e8ZsnBqhMsljHL6u8ikroL+Q5CdY8QPYjgLrVtOWWX9PWLT32zAqR0Wpa
	 Ic+bykhaO/IxEPcM+AytqgZsRC5rPgAmDeK4UDvaCGpMb4MlGc9uJcjpaDf+yrUgH+
	 Llx4vs87QLpfH/wP8gb3a4rWl5VvQeSVPZkD0LdLIaxg85Ci4haX2qeea/V2PEKfio
	 A5QmHlfzHn17VAMzvfd3vLRW0RQPco63ySgPSu+t+MGT6MplXGEM2hrcCHiQ1YDLRn
	 O98s18rLU51Cp/EGLMs3H8MJBJIUOQ+zqV6SATYMWHd8qWt0AT9AbRTcYPENwwJ980
	 qYDGoOm6TmgiA==
Date: Thu, 15 Feb 2024 20:16:36 -0600
From: Rob Herring <robh@kernel.org>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Russ Weight <russ.weight@linux.dev>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Mark Brown <broonie@kernel.org>,
	Frank Rowand <frowand.list@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, devicetree@vger.kernel.org,
	Dent Project <dentproject@linuxfoundation.org>
Subject: Re: [PATCH net-next v4 11/17] dt-bindings: net: pse-pd: Add another
 way of describing several PSE PIs
Message-ID: <20240216021636.GA831217-robh@kernel.org>
References: <20240215-feature_poe-v4-0-35bb4c23266c@bootlin.com>
 <20240215-feature_poe-v4-11-35bb4c23266c@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240215-feature_poe-v4-11-35bb4c23266c@bootlin.com>

On Thu, Feb 15, 2024 at 05:02:52PM +0100, Kory Maincent wrote:
> PSE PI setup may encompass multiple PSE controllers or auxiliary circuits
> that collectively manage power delivery to one Ethernet port.
> Such configurations might support a range of PoE standards and require
> the capability to dynamically configure power delivery based on the
> operational mode (e.g., PoE2 versus PoE4) or specific requirements of
> connected devices. In these instances, a dedicated PSE PI node becomes
> essential for accurately documenting the system architecture. This node
> would serve to detail the interactions between different PSE controllers,
> the support for various PoE modes, and any additional logic required to
> coordinate power delivery across the network infrastructure.
> 
> The old usage of "#pse-cells" is unsuficient as it carries only the PSE PI
> index information.

Every time I read this sentence I'm just going to ask why not add more 
data besides index to the cells?

This all still looks pretty much the same. I guess there was 
explanation in the long response on the last version, but I haven't had 
time to digest it and won't until I'm back next week at the earliest.

Rob

