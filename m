Return-Path: <linux-kernel+bounces-50549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 945C5847A95
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 21:39:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B96C28470A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 20:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78A397A723;
	Fri,  2 Feb 2024 20:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mWdL9qfG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CABF7A705;
	Fri,  2 Feb 2024 20:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706906357; cv=none; b=VosYsLecc9Faqgr0U9NhHYUcXQFaAC5r6BOB1ktjl47QFVAazXX2l7N40w4lo2FrKMK1NzJLC9XV+Qp8CE8alXXFp45/Ug4hDbi8itAlHpCtN+b868L1c8rRh6znCbR0mk5hO4lQi0sjiCLH1ucDUyVfrS2Pt/zkIlGimkiZJpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706906357; c=relaxed/simple;
	bh=lUiZwAyJaZQ+4+AMBX9/v5QxyV7H20zeM9q/qx9XCac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CDDnzmHkFapCJkoa7sBg3NawFgR1z6Hh6i8YpMQZPFjlbG/PfZp2HjByQXomkFp9XnGqw65s6M9DwdRvV/Yz0NxDQiNWRswYOsr/Lp6sYJQFIJ+pns0FMFXRAQsPxWXJLiTaAJuXoJf0P6e/anB84f9EOmRdwVhblQ4pqFSLfl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mWdL9qfG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37F31C433F1;
	Fri,  2 Feb 2024 20:39:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706906357;
	bh=lUiZwAyJaZQ+4+AMBX9/v5QxyV7H20zeM9q/qx9XCac=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mWdL9qfGg9+QYiLHGqKxy5w13NQS3jS8kuZiGZQpV1EHP0DDuiG50vo53jUAMg7el
	 9Eg5SKbj+hgnPOOHe/DnUhehIBbvGqKvBPa2H6jt3Jd8CZrSKgmatkyFNVrwvVF/Mv
	 y/RM/pYp9W8S76hE1ryic+RHRHTv5/tY1d1yYFSMa12Da5W4RzYZpTIbiclMaGBNWk
	 BcaESKdR34K7KngBrj/kZNHznnAspo0bqYaVvQSbtfPUOqlb6XVN1I3bFuNZdZP14d
	 rLAQKz1fy1fH5ITZ0/9cE94sQkhjd8gRI//CQPBLvQ6EAtI52h/5BTcTfyREgrQj0o
	 8iSEimIbIsGRA==
Date: Fri, 2 Feb 2024 14:39:15 -0600
From: Rob Herring <robh@kernel.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Frank Rowand <frowand.list@gmail.com>,
	Robert Marko <robert.marko@sartura.hr>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Subject: Re: [net-next PATCH v5 6/9] dt-bindings: net: Document Qcom QCA807x
 PHY package
Message-ID: <20240202203915.GA1075521-robh@kernel.org>
References: <20240201151747.7524-1-ansuelsmth@gmail.com>
 <20240201151747.7524-7-ansuelsmth@gmail.com>
 <94dfc4c4-5fe6-438d-bcda-4f818eafd2f0@linaro.org>
 <65bd0678.050a0220.bf9e4.9bd2@mx.google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65bd0678.050a0220.bf9e4.9bd2@mx.google.com>

On Fri, Feb 02, 2024 at 04:12:53PM +0100, Christian Marangi wrote:
> On Fri, Feb 02, 2024 at 08:45:52AM +0100, Krzysztof Kozlowski wrote:
> > On 01/02/2024 16:17, Christian Marangi wrote:
> > > Document Qcom QCA807x PHY package.
> > > 
> > > Qualcomm QCA807X Ethernet PHY is PHY package of 2 or 5
> > > IEEE 802.3 clause 22 compliant 10BASE-Te, 100BASE-TX and
> > > 1000BASE-T PHY-s.
> > > 
> > > Document the required property to make the PHY package correctly
> > > configure and work.
> > > 
> > > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > > ---
> > >  .../devicetree/bindings/net/qcom,qca807x.yaml | 142 ++++++++++++++++++
> > 
> > Your bindings header must be squashed here. Headers are not separate
> > thing from the bindings.
> > 
> > >  1 file changed, 142 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/net/qcom,qca807x.yaml
> > > 
> > > diff --git a/Documentation/devicetree/bindings/net/qcom,qca807x.yaml b/Documentation/devicetree/bindings/net/qcom,qca807x.yaml
> > > new file mode 100644
> > > index 000000000000..1c3692897b02
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/net/qcom,qca807x.yaml
> > > @@ -0,0 +1,142 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/net/qcom,qca807x.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Qualcomm QCA807X Ethernet PHY
> > 
> > What is "X"? Wildcards are usually not expected.
> >
> 
> It's to identify the Ethrnet PHY family. Looks wrong to declare qca8072
> or qca8074 since they would refer to a more generic Family of devices.

Declare them all or provide some justification such as the exact model 
is discoverable (and better be sure power on is the same in order to do 
discovery).

> What would be the correct way? We have many other case on net with
> schema called qca8k that refer to the family of Ethernet Switch but in
> it refer to qca8327 qca8337 qca8334...
> 
> > > +
> > > +maintainers:
> > > +  - Christian Marangi <ansuelsmth@gmail.com>
> > > +  - Robert Marko <robert.marko@sartura.hr>
> > > +
> > > +description: |
> > > +  Qualcomm QCA807X Ethernet PHY is PHY package of 2 or 5
> > > +  IEEE 802.3 clause 22 compliant 10BASE-Te, 100BASE-TX and
> > > +  1000BASE-T PHY-s.
> > > +
> > > +  They feature 2 SerDes, one for PSGMII or QSGMII connection with
> > > +  MAC, while second one is SGMII for connection to MAC or fiber.
> > > +
> > > +  Both models have a combo port that supports 1000BASE-X and
> > > +  100BASE-FX fiber.
> > > +
> > > +  Each PHY inside of QCA807x series has 4 digitally controlled
> > > +  output only pins that natively drive LED-s for up to 2 attached
> > > +  LEDs. Some vendor also use these 4 output for GPIO usage without
> > > +  attaching LEDs.
> > > +
> > > +  Note that output pins can be set to drive LEDs OR GPIO, mixed
> > > +  definition are not accepted.
> > > +
> > > +  PHY package can be configured in 3 mode following this table:
> > > +
> > > +                First Serdes mode       Second Serdes mode
> > > +  Option 1      PSGMII for copper       Disabled
> > > +                ports 0-4
> > > +  Option 2      PSGMII for copper       1000BASE-X / 100BASE-FX
> > > +                ports 0-4
> > > +  Option 3      QSGMII for copper       SGMII for
> > > +                ports 0-3               copper port 4
> > > +
> > > +$ref: ethernet-phy-package.yaml#
> > > +
> > > +properties:
> > > +  compatible:
> > > +    const: qcom,qca807x-package
> > > +
> > > +  qcom,package-mode:
> > 
> > Where is definition of this property with type and description?
> > 
> > > +    enum:
> > > +      - qsgmii
> > > +      - psgmii
> > > +
> > > +  qcom,tx-driver-strength:
> > 
> > Use proper unit suffix.
> > 
> > https://github.com/devicetree-org/dt-schema/blob/main/dtschema/schemas/property-units.yaml
> > 
> > > +    description: set the TX Amplifier value in mv.
> > > +      If not defined, 600mw is set by default.
> > > +    $ref: /schemas/types.yaml#/definitions/uint32
> > > +    enum: [140, 160, 180, 200, 220,
> > > +           240, 260, 280, 300, 320,
> > > +           400, 500, 600]
> > > +
> > > +patternProperties:
> > > +  ^ethernet-phy(@[a-f0-9]+)?$:
> > > +    $ref: ethernet-phy.yaml#
> > > +
> > > +    properties:
> > > +      gpio-controller:
> > > +        description: set the output lines as GPIO instead of LEDs
> > > +        type: boolean

You only need 'gpio-controller: true'. The core already defines the 
type.

> > > +
> > > +      '#gpio-cells':
> > > +        description: number of GPIO cells for the PHY

Not a useful description. Normally, you'd describe what's in the cells, 
but GPIO is standardized so no need (unless you are deviating from the 
norm).

> > > +        const: 2
> > > +
> > > +    dependencies:
> > > +      gpio-controller: ['#gpio-cells']
> > 
> > Why do you need it? None of gpio-controllers do it, I think.
> > 
> 
> Well gpio-controller property is optional and having that declared and
> #gpio-cells skipped will result in an error on probe. I think it should
> be the opposite with other schema having to declare this.

If you think everything else is wrong, then please fix them. :)

> 
> In usual way for gpio-controller both property are defined as required
> but you can see some (to-be-converted) txt files whith comments where
> they say:
> 
> ./mux/adi,adgs1408.txt:10:- gpio-controller : if present, #gpio-cells is required.
> 
> Should I instead add this condition in the if right below?

The core schema enforces this dependency, so you don't need to.

Rob

