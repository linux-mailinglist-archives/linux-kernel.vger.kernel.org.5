Return-Path: <linux-kernel+bounces-139332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D1EE8A0182
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 22:53:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4D1FB22788
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 20:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69A39181CFF;
	Wed, 10 Apr 2024 20:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DTkCloQ+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A50F315EFAD;
	Wed, 10 Apr 2024 20:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712782367; cv=none; b=fMoEo2fARRjUHGWvwQ6CmKLKsPKvS2WrK2AJSzoXaeiUDXzPpucIR6ed1usCncbwXEXN3R9ZlCgPDU6+uhKifzvP5c/YIX11fCGBtlTKX63nE2dkEcU1+aIA/a7fPZtWjksbWIudJmSjp11uZog0EaUXNUnMOl+/DaEPTdHyQsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712782367; c=relaxed/simple;
	bh=N38KD+SiZS1U4XcfM3Ay0nwghgVyE56H0CZwBOKGYX4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dIxT73oR4kX8doguqzS8Jqs7zeD+8+1jT7G69JbniSCNipryiI6Tesdi8KTpaBuBGwVt0u1COgUY7+djwIqIggoevOiA+Ey2vdakCxTwREzai6eZXK+2T+AoK3v8teaiDTWG4dy1NkDSqWzNfNZS+BG9tOi6uMuMICXQ965XEyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DTkCloQ+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E348CC433C7;
	Wed, 10 Apr 2024 20:52:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712782367;
	bh=N38KD+SiZS1U4XcfM3Ay0nwghgVyE56H0CZwBOKGYX4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DTkCloQ+PnMVIErVzlkWkCxPmRqK8GauL+JqEFrb48YRzYgVQyV8Aip9J0UvT9En9
	 LsfpdpHQ/+duzNJhs65P56FnjIgvs31L2TfFRv3p0y5CZI1eCnyu6P+IvQ2sR1hrTe
	 faZahArzV7TpookNkNNoXWLEyRUB3KfCcd31MFueXfG55TGHVwDBeYFHzRMrfM0zI9
	 irHJ2heLvubaXvjDDDSfpB0FhmZukUp37jpytNLTTtXCoJ+WORQOLcRc4YjhAcxQuK
	 yBOJVUklSAsD4G2z2dSuFjBTOUMX9J2cDdJclsrySj7+TVPEH/oFinnojQL9GLhAkG
	 3aCZNFFH1bAZg==
Date: Wed, 10 Apr 2024 15:52:44 -0500
From: Rob Herring <robh@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: Zhi Mao <zhi.mao@mediatek.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Hans de Goede <hdegoede@redhat.com>,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Alain Volmat <alain.volmat@foss.st.com>,
	Paul Elder <paul.elder@ideasonboard.com>,
	Mehdi Djait <mehdi.djait@bootlin.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Bingbu Cao <bingbu.cao@intel.com>, linux-media@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, shengnan.wang@mediatek.com,
	yaya.chang@mediatek.com, yunkec@chromium.org, 10572168@qq.com
Subject: Re: [PATCH 1/2] media: dt-bindings: i2c: add Giantec GT97xx VCM
 driver
Message-ID: <20240410205244.GA1290088-robh@kernel.org>
References: <20240410104002.1197-1-zhi.mao@mediatek.com>
 <20240410104002.1197-2-zhi.mao@mediatek.com>
 <20240410-rice-fringe-4ae992217a2f@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240410-rice-fringe-4ae992217a2f@spud>

On Wed, Apr 10, 2024 at 12:27:07PM +0100, Conor Dooley wrote:
> Hey,
> 
> On Wed, Apr 10, 2024 at 06:40:01PM +0800, Zhi Mao wrote:
> > Add YAML device tree binding for GT97xx VCM driver,
> 
> Please don't mention drivers here, bindings are for hardware.
> 
> > and the relevant MAINTAINERS entries.
> > 
> > Signed-off-by: Zhi Mao <zhi.mao@mediatek.com>
> > ---
> >  .../bindings/media/i2c/giantec,gt97xx.yaml    | 91 +++++++++++++++++++
> >  1 file changed, 91 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/media/i2c/giantec,gt97xx.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/media/i2c/giantec,gt97xx.yaml b/Documentation/devicetree/bindings/media/i2c/giantec,gt97xx.yaml
> > new file mode 100644
> > index 000000000000..8c9f1eb4dac8
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/media/i2c/giantec,gt97xx.yaml
> > @@ -0,0 +1,91 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +# Copyright (c) 2020 MediaTek Inc.
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/media/i2c/giantec,gt97xx.yaml#
> 
> Filename patching compatible please.
> 
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Giantec Semiconductor, Crop. GT97xx Voice Coil Motor (VCM)
> > +
> > +maintainers:
> > +  - Zhi Mao <zhi.mao@mediatek.com>
> > +
> > +description: |-
> > +  The Giantec GT97xx is a 10-bit DAC with current sink capability.
> > +  The DAC is controlled via I2C bus that operates at clock rates up to 1MHz.
> > +  This chip integrates Advanced Actuator Control (AAC) technology
> > +  and is intended for driving voice coil lens in camera modules.
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - giantec,gt9768 # for GT9768 VCM
> > +      - giantec,gt9769 # for GT9769 VCM
> 
> I don't think these comments are needed, they should be clear from the
> compatibles, no?
> 
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  vin-supply: true
> > +
> > +  vdd-supply: true
> > +
> > +  giantec,aac-mode:
> > +    description:
> > +      Indication of AAC mode select.
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    enum:
> > +      - 1    #  AAC2 mode(operation time# 0.48 x Tvib)
> > +      - 2    #  AAC3 mode(operation time# 0.70 x Tvib)
> > +      - 3    #  AAC4 mode(operation time# 0.75 x Tvib)
> > +      - 5    #  AAC8 mode(operation time# 1.13 x Tvib)
> 
> I dislike these enum based properties and I would rather this either be
> the values themselves (0.48, 0.70 etc).

Except that those would have to be strings for floats or fractions. For 
properties which have little chance of being something common and aren't 
any form of standard unit, I think it is fine to just use the h/w 
specific values. 

The first question to ask whether these parameters are common to 
all/many voice coil motors?


> > +    default: 2
> > +
> > +  giantec,aac-timing:
> > +    description:
> > +      Number of AAC Timing count that controlled by one 6-bit period of
> > +      vibration register AACT[5:0], the unit of which is 100 us.
> 
> Then the property should be in a standard unit of time, not "random" hex
> numbers that correspond to register values.

Here, I agree.

Rob

