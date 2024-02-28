Return-Path: <linux-kernel+bounces-85382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D45E86B536
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 17:43:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BADF128B5CD
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 16:43:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 117EE200D6;
	Wed, 28 Feb 2024 16:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DnmEeXzq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E3806EF13;
	Wed, 28 Feb 2024 16:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709138572; cv=none; b=XSwFjPAalmM2zy+H/SgGqjvBPymiwGuez5rD9eMPMTAMsx4bcqVoivo4kaDm65lVGnbzi6b+siR/oqmz1oPSh2pLfvgQPVseaV3dccZNNMI+pZHtmVQnHm88M8irqQQwcbPF/JYSp/Sr0v5T7DMt8Nf8sY/rcqAwmf/hasoyQJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709138572; c=relaxed/simple;
	bh=w34PS7US7MJmkyMNpW5sS+Wml2/zjKiX667GmM7Bcmg=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=e2ThVXdVMLO/wzCKL3f+vxOLX2I767AqbH3lzO4+1+5ML0Kzg/PawQesQiDE/IbloZ2O62s7hsVc0w6ZmGztGGnsy2KqCY8tdrMOlnCD3kDQ81UhE8ShpxjEOzN1Kd6F86qR7bPq/2AjFJyaLBC9qO1mjcd4ITUiocx38PKJuTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DnmEeXzq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7927CC433F1;
	Wed, 28 Feb 2024 16:42:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709138571;
	bh=w34PS7US7MJmkyMNpW5sS+Wml2/zjKiX667GmM7Bcmg=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=DnmEeXzqBJtCFoixO9DkqqjWAPGtxg9babn+o5HoiUfnrqph4SsxsoslsgunXiyvF
	 xWKGL9W/NIcNeKlhfBePUOpqVOpJ7dK+Od5dVOZCnphgN9OZigR7/vM8WGP44geT9b
	 bsIQ0QCAc0DZeVicX0b7G6IZaHLmZfEmw2PQ8Y0CIWktdsOAu18OhzIq5lhMaxK0Hc
	 vMze6FuWTqdn/9TBe5GGeAxMnWv9Xc1DHibhHpWOjDTTu7zrlYmwzZvGKgHNyOUYUL
	 ws/+8oFvijUgNzEGSJ1lY98egoQOlM4u3ObHH85Ht0Nl/3UKR/TdqQmvI2Mh6czEgH
	 /SpiyIXES7A9A==
Date: Wed, 28 Feb 2024 10:42:50 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Conor Dooley <conor+dt@kernel.org>, 
 Oleksij Rempel <o.rempel@pengutronix.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, 
 Russ Weight <russ.weight@linux.dev>, Heiner Kallweit <hkallweit1@gmail.com>, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>, 
 Luis Chamberlain <mcgrof@kernel.org>, linux-doc@vger.kernel.org, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Dent Project <dentproject@linuxfoundation.org>, 
 Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh+dt@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Eric Dumazet <edumazet@google.com>, Mark Brown <broonie@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>
In-Reply-To: <20240227-feature_poe-v5-11-28f0aa48246d@bootlin.com>
References: <20240227-feature_poe-v5-0-28f0aa48246d@bootlin.com>
 <20240227-feature_poe-v5-11-28f0aa48246d@bootlin.com>
Message-Id: <170913856921.224923.13844056647540488488.robh@kernel.org>
Subject: Re: [PATCH net-next v5 11/17] dt-bindings: net: pse-pd: Add
 another way of describing several PSE PIs


On Tue, 27 Feb 2024 15:42:53 +0100, Kory Maincent wrote:
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
> 
> This patch is sponsored by Dent Project <dentproject@linuxfoundation.org>.
> 
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
> ---
> 
> Changes in v3:
> - New patch
> 
> Changes in v4:
> - Remove $def
> - Fix pairset-names item list
> - Upgrade few properties description
> - Update the commit message
> 
> Changes in v5:
> - Fix yamllint error.
> - Replace underscore by dash in properties names.
> - Add polarity-supported property.
> ---
>  .../bindings/net/pse-pd/pse-controller.yaml        | 100 ++++++++++++++++++++-
>  1 file changed, 97 insertions(+), 3 deletions(-)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
/Documentation/devicetree/bindings/net/pse-pd/pse-controller.yaml:86:111: [warning] line too long (111 > 110 characters) (line-length)
/Documentation/devicetree/bindings/net/pse-pd/pse-controller.yaml:88:111: [warning] line too long (111 > 110 characters) (line-length)
/Documentation/devicetree/bindings/net/pse-pd/pse-controller.yaml:89:111: [warning] line too long (111 > 110 characters) (line-length)
/Documentation/devicetree/bindings/net/pse-pd/pse-controller.yaml:90:111: [warning] line too long (111 > 110 characters) (line-length)
/Documentation/devicetree/bindings/net/pse-pd/pse-controller.yaml:91:111: [warning] line too long (111 > 110 characters) (line-length)
/Documentation/devicetree/bindings/net/pse-pd/pse-controller.yaml:92:111: [warning] line too long (111 > 110 characters) (line-length)
/Documentation/devicetree/bindings/net/pse-pd/pse-controller.yaml:93:111: [warning] line too long (111 > 110 characters) (line-length)
/Documentation/devicetree/bindings/net/pse-pd/pse-controller.yaml:94:111: [warning] line too long (111 > 110 characters) (line-length)
/Documentation/devicetree/bindings/net/pse-pd/pse-controller.yaml:95:111: [warning] line too long (111 > 110 characters) (line-length)

dtschema/dtc warnings/errors:

doc reference errors (make refcheckdocs):
Warning: Documentation/devicetree/bindings/net/pse-pd/pse-controller.yaml references a file that doesn't exist: Documentation/networking/pse-pd/pse-pi.rst
Documentation/devicetree/bindings/net/pse-pd/pse-controller.yaml: Documentation/networking/pse-pd/pse-pi.rst

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240227-feature_poe-v5-11-28f0aa48246d@bootlin.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


