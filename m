Return-Path: <linux-kernel+bounces-67670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B1D5856EE6
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 21:52:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 269C6B210AC
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 20:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A5C113B2BC;
	Thu, 15 Feb 2024 20:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="goLAtfVr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6599B13B293;
	Thu, 15 Feb 2024 20:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708030368; cv=none; b=HTFi4BF3sAaHu6HedXnPXSk1GaLKqwElCKcTGaOnHpgwUc/NvsJor02yW5+UlHhB3WeHap+/UhXcpxnkW2iu1ClWXn8Ty0EZoy3fGVbDnGNMnJDYzxsaH0jorWNyC1smWkI1jQyCs8DrR3LHV5lDFH6y8VsAKyHH7rYAc9qOtbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708030368; c=relaxed/simple;
	bh=Av6COBMGvbBgCAaGuD1gcM1sjuS4XKo36Ub7qNtB1Q0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yn9Oay4WrUp8niLu86YoQOtCG2ReTaveJJohxXzA2RsuCQY8xp0y0HyX66SM+Bz7W6ZRoKuYUT3kK3EkYoGV5Oat2V81+hd/o8wKMJB6bN+6e+E7vSoa+2d3JYalZnYAKg/y0+EyYE7+eyw3PwkrGy7Z0wD9YI1Fc94RJf3u/nA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=goLAtfVr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C0D8C433F1;
	Thu, 15 Feb 2024 20:52:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708030367;
	bh=Av6COBMGvbBgCAaGuD1gcM1sjuS4XKo36Ub7qNtB1Q0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=goLAtfVrUVQAGrqoYfGle7Ir7lKrAhPROqJkehCegdGaXWoT3cLTrIIRU48vmF4hI
	 hmLmSxyMhc6T1L9dkSafU8mZ8aAa6IRw5GN1TYlkdnYUPuyhWOicZnXrbiMKPwpeC9
	 4uFNQpvhpeLEYk8u35HNhWFLGWkGGd1Mb8L/RBmVlRchl2xSz/mhMcnoadZzMEAmhc
	 xwf5hciyhaIXero+PR9u90F5e98cwtGimgFp4cg8Nnc41o5O84+bEg6BSMQeM756iX
	 FYoH9c/6sqRjEuOBnUTcFc+o3vdXqjQVbw3c04L0eJIFz2WRoAX8u7/yKf/xQsywOK
	 NoOJhU4jCM40A==
Received: by mercury (Postfix, from userid 1000)
	id D6EF31061C37; Thu, 15 Feb 2024 21:52:44 +0100 (CET)
Date: Thu, 15 Feb 2024 21:52:44 +0100
From: Sebastian Reichel <sre@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, NXP Linux Team <linux-imx@nxp.com>, 
	Dong Aisheng <aisheng.dong@nxp.com>, Linus Walleij <linus.walleij@linaro.org>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Mark Brown <broonie@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 06/17] dt-bindings: soc: imx: fsl,imx-iomuxc-gpr: add
 imx6
Message-ID: <vncxxpe4ts2nybyrrgqps44eyj3t2ss63ado2pqiycpponxyy4@mhp3egl4c27a>
References: <20240213010347.1075251-1-sre@kernel.org>
 <20240213010347.1075251-7-sre@kernel.org>
 <20240215145520.GA20171-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240215145520.GA20171-robh@kernel.org>

Hi,

On Thu, Feb 15, 2024 at 08:55:20AM -0600, Rob Herring wrote:
> On Tue, Feb 13, 2024 at 02:00:55AM +0100, Sebastian Reichel wrote:
> > Add compatibles used by different i.MX6 variants to the i.MX IOMUX
> > Controller GPR binding.
> > 
> > Signed-off-by: Sebastian Reichel <sre@kernel.org>
> > ---
> >  .../bindings/soc/imx/fsl,imx-iomuxc-gpr.yaml   | 18 +++++++++++++++++-
> >  1 file changed, 17 insertions(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/soc/imx/fsl,imx-iomuxc-gpr.yaml b/Documentation/devicetree/bindings/soc/imx/fsl,imx-iomuxc-gpr.yaml
> > index 1da1b758b4ae..8451cb4dd87c 100644
> > --- a/Documentation/devicetree/bindings/soc/imx/fsl,imx-iomuxc-gpr.yaml
> > +++ b/Documentation/devicetree/bindings/soc/imx/fsl,imx-iomuxc-gpr.yaml
> > @@ -17,7 +17,23 @@ properties:
> >    compatible:
> >      oneOf:
> >        - items:
> > -          - const: fsl,imx8mq-iomuxc-gpr
> > +          - enum:
> > +              - fsl,imx6q-iomuxc-gpr
> > +              - fsl,imx8mq-iomuxc-gpr
> > +          - const: syscon
> > +          - const: simple-mfd
> > +      - items:
> > +          - enum:
> > +              - fsl,imx6sl-iomuxc-gpr
> > +              - fsl,imx6sll-iomuxc-gpr
> > +              - fsl,imx6ul-iomuxc-gpr
> > +          - const: fsl,imx6q-iomuxc-gpr
> > +          - const: syscon
> 
> A bit odd that imx6q is a simple-mfd above, but not here. I suppose 
> that could be valid if the variants here don't have sub-devices or they 
> do, but have a dependency on the parent.

These do not have sub-nodes, while the other instances have.

> Acked-by: Rob Herring <robh@kernel.org>

Thanks,

-- Sebastian

