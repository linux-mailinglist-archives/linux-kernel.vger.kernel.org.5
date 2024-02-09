Return-Path: <linux-kernel+bounces-59497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73C6184F7FE
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 15:58:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA08AB23ECA
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 14:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C864C71B59;
	Fri,  9 Feb 2024 14:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qzfw1Rft"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F27FD6BB5F;
	Fri,  9 Feb 2024 14:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707490651; cv=none; b=gg4alN16mSNQq3ck9B25N5cCIDCRa3yQFDpdXRpAwErQY5lR5s0gJ5/YH7UgLpcE/6qxXZwdW4wUS5aZj/d0+15HwJdSPnpixXuU0pRUb5B/jsyJr3F0lnkTdHxbJa5LDF/166Yajk4OrkmDkE+6sT/qfhZaF9DIJjLCOcjjbNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707490651; c=relaxed/simple;
	bh=Yw3xbGS7sANi6u4O2AuPZ8rYPjitulFONHb6FzpsJNI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PK1XFZ0WXoQ0vEfTFSeD7VfwDBRx+DaeXDVwrxx5aPFSuLO8Uw66K+5IzswZaKT2EKip8Pp/7KOeOU3i9g6KSvXtpnTHDhmDOC/mDi3PCKMBkMN7u7nG7c5Sv++VJOH2BGdPoni3MGKCO1DmqE8S7p0MV+NVNV/aKLuCTO1pr0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qzfw1Rft; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01B6EC433C7;
	Fri,  9 Feb 2024 14:57:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707490650;
	bh=Yw3xbGS7sANi6u4O2AuPZ8rYPjitulFONHb6FzpsJNI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qzfw1Rftaazb7bUVp2w2hHfqC5oqw6CHvqgb72FKCzWCsdJ65jYJdSoTLfMj/Mtrq
	 MDamhJ629Oq4vCF1ilvj6LrrZfdqi6QaABAmLyqno3eIe2MExt0APxYaeLbgbF1FQb
	 LNtbxMIv79xep+JX5jtfSWXnmCWLHpiQKCNyYgYBOf5e0GB9ElmQvGoOGUbzWuuc7R
	 fl+7mpzbsfJIjtHcQOVf3/FHn0Zf+vAuxBWdmMI+IbLKyY/LRyI6ujpzImxrRUX8NG
	 Y+Gaer0W5AYCrkF/HwWa1YrLdqYt+pMapDBnMfo81mXqHa31Z0pPLtRFnZGmg7SqdN
	 hFd+gJ0nUzaqw==
Date: Fri, 9 Feb 2024 14:57:27 +0000
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
Subject: Re: [PATCH net-next v3 14/17] dt-bindings: net: pse-pd: Add bindings
 for PD692x0 PSE controller
Message-ID: <20240209145727.GA3702230-robh@kernel.org>
References: <20240208-feature_poe-v3-0-531d2674469e@bootlin.com>
 <20240208-feature_poe-v3-14-531d2674469e@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240208-feature_poe-v3-14-531d2674469e@bootlin.com>

On Thu, Feb 08, 2024 at 02:08:51PM +0100, Kory Maincent wrote:
> Add the PD692x0 I2C Power Sourcing Equipment controller device tree
> bindings documentation.
> 
> Sponsored-by: Dent Project <dentproject@linuxfoundation.org>
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
> ---
> 
> Changes in v2:
> - Enhance ports-matrix description.
> - Replace additionalProperties by unevaluatedProperties.
> - Drop i2c suffix.
> 
> Changes in v3:
> - Remove ports-matrix parameter.
> - Add description of all physical ports and managers.
> - Add pse_pis subnode moving to the API of pse-controller binding.
> - Remove the MAINTAINERS section for this driver as I will be maintaining
>   all pse-pd subsystem.
> ---
>  .../bindings/net/pse-pd/microchip,pd692x0.yaml     | 157 +++++++++++++++++++++
>  1 file changed, 157 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/pse-pd/microchip,pd692x0.yaml b/Documentation/devicetree/bindings/net/pse-pd/microchip,pd692x0.yaml
> new file mode 100644
> index 000000000000..57ba5365157c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/pse-pd/microchip,pd692x0.yaml
> @@ -0,0 +1,157 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/pse-pd/microchip,pd692x0.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Microchip PD692x0 Power Sourcing Equipment controller
> +
> +maintainers:
> +  - Kory Maincent <kory.maincent@bootlin.com>
> +
> +allOf:
> +  - $ref: pse-controller.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - microchip,pd69200
> +      - microchip,pd69210
> +      - microchip,pd69220
> +
> +  reg:
> +    maxItems: 1
> +
> +  managers:
> +    $ref: "#/$defs/managers"
> +    description:
> +      List of the PD69208T4/PD69204T4/PD69208M PSE managers. Each manager
> +      have 4 or 8 physical ports according to the chip version. No need to
> +      specify the SPI chip select as it is automatically detected by the
> +      PD692x0 PSE controller. The PSE managers have to be described from
> +      the lowest chip select to the greatest one, which is the detection
> +      behavior of the PD692x0 PSE controller. The PD692x0 support up to
> +      12 PSE managers which can expose up to 96 physical ports. All
> +      physical ports available on a manager have to be described in the
> +      incremental order even if they are not used.

Looks to me like you just need 3 PSE cells: <manager> <port> <A|B>

Really, no need for each piece of data to its own cell, so it could be 
merged into 1 or 2 cells.

But cell data is generally supposed to be meaningful to the provider and 
opaque to the consumer. It's not clear to me who needs to know 
alternative A vs. B. That seems more like a property of the PHY than the 
power provider? 

Rob

