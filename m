Return-Path: <linux-kernel+bounces-69832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54312858F48
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 13:15:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 874A21C21247
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 12:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC5C86A01E;
	Sat, 17 Feb 2024 12:15:06 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A8569E03
	for <linux-kernel@vger.kernel.org>; Sat, 17 Feb 2024 12:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708172106; cv=none; b=Fyq4hfGgCXA1ytkr+KINop/XTaxcTfL2ggmnTQmMxAdBHWiCkC0BmVo4bm/cBlkpyTz0COP7JPY/CHClzG229ru1MfenqoDiAdq1g29ybDLZA02qKslDhk3tOKouOJwvxyeMsZpJCJTaddBWzrm9ggMYu3topc05mTDJRApOdq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708172106; c=relaxed/simple;
	bh=S2t8ZmWnf3+Vn3K2L7tspN0gX9dvNd1USxfVoDWBbZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qpSTAbq9ypzWZOWCIwVlZ+RduoFfUMdO2A6W4dHWlZINZc2iDUP0i/v6wvESMA3isGOC4iUcPOhrwaEYfL4PxLEquIN1gydVM6Tk5gxgwcPHGSpO4b5rtOUdq/Z8VNS4v7WQT3ed8EghnMnJW+08EDND127V8U9uPtiOUDzfxZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1rbJaS-0000RV-Fa; Sat, 17 Feb 2024 13:14:32 +0100
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1rbJaP-001GBa-EN; Sat, 17 Feb 2024 13:14:29 +0100
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1rbJaP-00CwUe-15;
	Sat, 17 Feb 2024 13:14:29 +0100
Date: Sat, 17 Feb 2024 13:14:29 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
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
	Conor Dooley <conor+dt@kernel.org>, Mark Brown <broonie@kernel.org>,
	Frank Rowand <frowand.list@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, devicetree@vger.kernel.org,
	Dent Project <dentproject@linuxfoundation.org>
Subject: Re: [PATCH net-next v4 14/17] dt-bindings: net: pse-pd: Add bindings
 for PD692x0 PSE controller
Message-ID: <ZdCjJcPbbBGYVtuo@pengutronix.de>
References: <20240215-feature_poe-v4-0-35bb4c23266c@bootlin.com>
 <20240215-feature_poe-v4-14-35bb4c23266c@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240215-feature_poe-v4-14-35bb4c23266c@bootlin.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On Thu, Feb 15, 2024 at 05:02:55PM +0100, Kory Maincent wrote:
> Add the PD692x0 I2C Power Sourcing Equipment controller device tree
> bindings documentation.
> 
> This patch is sponsored by Dent Project <dentproject@linuxfoundation.org>.
> 
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
> ---
..
> +        pse_pis {
> +          #address-cells = <1>;
> +          #size-cells = <0>;
> +
> +          pse_pi0: pse_pi@0 {
> +            reg = <0>;
> +            #pse-cells = <0>;
> +            pairset-names = "alternative-a", "alternative-b";
> +            pairsets = <&phys0>, <&phys1>;
> +          };
> +          pse_pi1: pse_pi@1 {
> +            reg = <1>;
> +            #pse-cells = <0>;
> +            pairset-names = "alternative-a";
> +            pairsets = <&phys2>;

According to latest discussions, PSE PI nodes will need some
additional, board specific, information:
- this controller do not implements polarity switching, we need to know
  what polarity is implemented on this board. The 802.3 spec provide not
  really consistent names for polarity configurations:
  - Alternative A MDI-X
  - Alternative A MDI
  - Alternative B X
  - Alternative B S
  The board may implement one of polarity configurations per alternative
  or have additional helpers to switch them without using PSE
  controller.
  Even if specification explicitly say:
  "The PD shall be implemented to be insensitive to the polarity of the power
   supply and shall be able to operate per the PD Mode A column and the PD
   Mode B column in Table 33–13"
  it is possible to find reports like this:
  https://community.ui.com/questions/M5-cant-take-reversed-power-polarity-/d834d9a8-579d-4f08-80b1-623806cc5070

  Probably this kind of property is a good fit:
  polarity-supported = "MDI-X", "MDI", "X", "S";

- Except of polarity, we have alternative-b variant with direct or
  phantom feeding (No idea if it is proper description). Theoretically, this
  difference would affect electrical rating specifications.
  For example direct path for alternate-b (10/100Mbit only), would have
  higher rating as the path over coils/magnetics. Practically, vendors do not
  make different ratings for this paths, so no need to care about it for now
  until someone will be able to provide good reason.
  Here is example of RJ45 connector with integrated magnetics with PoE support
  where alternative-a feed over magnetics and alternative-b is feed directly:
  https://www.te.com/commerce/DocumentDelivery/DDEController?Action=srchrtrv&DocNm=5-2337992-4&DocType=Customer+Drawing&DocLang=English&PartCntxt=5-2337992-4&DocFormat=pdf 

  (the last topic is more an answer to my self and for archive :))

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

