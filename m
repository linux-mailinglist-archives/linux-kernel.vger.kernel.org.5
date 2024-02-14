Return-Path: <linux-kernel+bounces-65670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABDC285503F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 18:28:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67B1D285813
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 17:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C714127B5F;
	Wed, 14 Feb 2024 17:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="w2hgGoFr"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D8D127B44;
	Wed, 14 Feb 2024 17:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707931385; cv=none; b=ca3oGsbkhCmDKePq/Y/pfAa2TZjn75vOFCF/6QMyRh2ZIwlMl9rRA10n0AfxhHqrWtZ+6VzO81aTZLoQ9kafRL7+XL5OuGKdrocB4xMSR2yVBI3tE87G9NRaCYRglCTi9da21hMbabqjS3tKctkYOZRcKpC/KjVmS4GJh9mtml8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707931385; c=relaxed/simple;
	bh=N2N9KIJ9K4NuU5JrIGnCagcRufSl/68MS18mA10+2CM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H4vCQhOzXZezBh9L3PYnUoHZPSS1X5Y4Gm7Lfo9ztvxE5XwQRRs7Qls5maBiiukk25CaruguUmAO7m5YVYOw01MW2OEX8Qq7vhgI8EwTc2RrJ0eJa3d6m5t2pEId/hhY+PPtMhXNRGKRhDW/N53HelbwznQa856VpXXbiGQVtOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=w2hgGoFr; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Y0fyhuSydzeZFzeqfdy5rCRESdUy2kNN+FLC6ikFSgU=; b=w2hgGoFrpYDiQuksDlHcafKVP/
	iCAOm6cVAXO4hLj1UonKowN366ryG4JXJJoVAdG3yqLb7R62W1njmMG1GAuysQ3MNJEb7IlOoyJP0
	w3ZcgqkAQQR+gEhGXRxlr4172zZ9HtxlGp9EWuLN2sxzQoBlhIm1aFORE4ACXO8/a2gQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1raIyN-007oCm-1K; Wed, 14 Feb 2024 18:23:03 +0100
Date: Wed, 14 Feb 2024 18:23:03 +0100
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
Subject: Re: [PATCH net-next v3 09/17] MAINTAINERS: Add myself to pse
 networking maintainer
Message-ID: <9b8f9b2d-e4e0-4118-bcdb-c809e4f3d1bc@lunn.ch>
References: <20240208-feature_poe-v3-0-531d2674469e@bootlin.com>
 <20240208-feature_poe-v3-9-531d2674469e@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240208-feature_poe-v3-9-531d2674469e@bootlin.com>

On Thu, Feb 08, 2024 at 02:08:46PM +0100, Kory Maincent wrote:
> As I add support for PoE in PSE networking subsystem it seems legitimate
> to be added to the maintainers.
> 
> Sponsored-by: Dent Project <dentproject@linuxfoundation.org>
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

