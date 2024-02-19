Return-Path: <linux-kernel+bounces-71516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A69A985A684
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 15:54:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8EE71C2203C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 14:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34A56376EC;
	Mon, 19 Feb 2024 14:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="0q6JjzVg"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7C9E376EB;
	Mon, 19 Feb 2024 14:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708354457; cv=none; b=SoInrIjDw0et4rSqTnsPderAmuoizvJ3E1jJgbv7vwWp1hiGbJAe+sF0UXRVXkxaAcKIx/boczKS68+I9dzvAytr3DE60DhY8AKGUrYXanVN6PDz6N2eex/8jYYDO9hB1fkqK+UkoWtp1i+1HKZyP1HIxuUjmiy2t9YPNsKY4Nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708354457; c=relaxed/simple;
	bh=NByqa5JR2sbTrM+lED8CMmGy7fktPgFCBzkQex3upck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fcAhzwsIJPNdp1Ow9GTtYx757p2nKAt7yiKuTX7C+oUGwXdktWWoBaJtXO4oicv8ChVy5gd/Ut/ZbKv1W1QK5LDlTAEllSbee+zc/j9TX2SrTOK6zaAkxN9x38apuSWKmOdsX2n35HxiETz5C2bmlNgvgWvxX5QvwgLt+TpbEWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=0q6JjzVg; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=1A2eoDTWMwIQFZSM+uBH2DkpzzVuHBOEOyCA7oEZ4xY=; b=0q6JjzVgLkl2r2kzkNIYOgzQhi
	1O/QJsD412PmUpJx2B9C+HVEufUbi87WeWI7pmOmjyQOs0Uv5+4vziNKxpmTugxVLBfKsmVW7RcaC
	d3hUlNgIQaeutXBpT2BfONiQuqKE0oDeypf1joMmT7DOVp8fZLUIB+XFMzpWzCdNhzkM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rc523-008CcE-W9; Mon, 19 Feb 2024 15:54:12 +0100
Date: Mon, 19 Feb 2024 15:54:11 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: =?iso-8859-1?Q?K=F6ry?= Maincent <kory.maincent@bootlin.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Russ Weight <russ.weight@linux.dev>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Mark Brown <broonie@kernel.org>,
	Frank Rowand <frowand.list@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, devicetree@vger.kernel.org,
	Dent Project <dentproject@linuxfoundation.org>
Subject: Re: [PATCH net-next v4 14/17] dt-bindings: net: pse-pd: Add bindings
 for PD692x0 PSE controller
Message-ID: <042ab32c-666e-44f7-8ba1-db9a82f351d1@lunn.ch>
References: <20240215-feature_poe-v4-0-35bb4c23266c@bootlin.com>
 <20240215-feature_poe-v4-14-35bb4c23266c@bootlin.com>
 <ZdCjJcPbbBGYVtuo@pengutronix.de>
 <20240219153840.507be7b3@kmaincent-XPS-13-7390>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240219153840.507be7b3@kmaincent-XPS-13-7390>

> Mmh not sure we want to support broken cases that does not follow the spec.
> Should we?

We should specify the properties a device following the spec should
use. These are the common properties we expect all devices should be
using.

Broken devices can however have additional properties, defined in
their own binding. And if we see a pattern for broken properties, we
could pull them out into a -broken.yaml binding, which the broken
devices could share. 

    Andrew

