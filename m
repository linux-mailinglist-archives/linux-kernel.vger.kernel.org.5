Return-Path: <linux-kernel+bounces-68524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EEFD857BBA
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 12:31:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB66A2817CD
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 11:31:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A608077F17;
	Fri, 16 Feb 2024 11:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IWxBdWfd"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 349FD77A0F;
	Fri, 16 Feb 2024 11:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708083085; cv=none; b=kMus4KpsQr2Kxik+vTkrwpIQR4NsuxD1I848M7L3K4mBNRXWw3cQwHre5vqd9g8MtF1O3FkKOo64X0FMp6irI5yxOsqHsZ0iFBJaQNEDUOJ6apfJ18AGg1bDFHwMLZzTqPLhcNtBv4C/zuD0JXYvAAOx2/11oGw/vr+dkN0GnJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708083085; c=relaxed/simple;
	bh=YyM2M4MIP+dAfmapZF1grt5im1QDWJvjaaUFj2w6KT0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mNZoqujCp0B1yCWMNrCQY7yFYXpAXv15ZdoMNV8iXGW03DFEwBIKc2kWL/AOL1fcj6x/kj5ICQoSHr74EwOnuqQeW24j24v7B+dYmfstyeQIiceCJHuvm3cZpZND334YS/m3L1otIxDQkS3/+v/t6PwVS3vv1DZ7i/IjCP7TtGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IWxBdWfd; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-5cddc5455aeso499450a12.1;
        Fri, 16 Feb 2024 03:31:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708083083; x=1708687883; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lyWfSKTdRSu/XPOYIRliEz8xFdTfpgDKmLuvOF0Pin8=;
        b=IWxBdWfdM7M09CTb26eh1SsZHdZ5O8H6uEHEYMTfm/3UOtqrCAHJd1KgyuJyeNAJiG
         cGTbCFURophUbdAb0qgFaCqUxURAn0qyf9lxpsGeUXpcfgcyLReJRED+Ja1aQSft54m1
         xmOHuDFrju/c5F0rI68NpgLUhP9IkevvA0bTxKyo/wt5HEpEu8HLHJ+rCOmprko/x3w4
         nKKz4mYt8PKgnGgm6D0BzZoYBNII5ajg+cphjhFiw26bwpUqKAH9sHApWRIob5yq1qIZ
         pn0IYgyaGlww7S8+N8tG6bTGSOjyg2ZzGZVAnr92f/DdCqXrAGE7tuQ9Z4ahHZGk36j4
         efng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708083083; x=1708687883;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lyWfSKTdRSu/XPOYIRliEz8xFdTfpgDKmLuvOF0Pin8=;
        b=l3QOxMVjycGN3ivR87AOcAIURajjUYzXt6dFPp9OSPVC5o3Vb340TX13gQ6vE2aORH
         vUvSWsQP2jUHOzhsyEqCJcJr3/rW/cykOeabBRUrzm7iF5IZ+sf2PXDRmNuNgwllYWnv
         XGtNpI2vENtrpvrRNPJl/5TDaEbYc6pLE5iS+Rs1dlA0SYnsRYtrYxF6gRPXNmd+dC/Y
         vOzHM6v7TBqpzJ6UkVhe275P1WUM2Tdph+WDnVKo3uZQ6zcUvCcIkxoDkRbf9LAf1AQE
         B/uzFPklpbcPtAvadRbsVved984j0O8E21xDL+vWqZdxyT0Bhy5Oa2IaiSn3fY4JnW64
         5UmQ==
X-Forwarded-Encrypted: i=1; AJvYcCUKD+x2lyHldfiIzXUbahcKsffQbMapUrWsCrs4osH24vl0hpJmOv4QI5wP0KNu3c2yq2cW8kVPcrfYOIFIKB/jD1fGpH2SmiedMYvYnrXjHm8LT7aZ5L9GxcEaXJ17/Kk0M/Uudn2ROTf0kGaFApChki4ur8fWAPzV0kyeFSGPAisp
X-Gm-Message-State: AOJu0Yy3kIVdUCFRLv0q/pUuSOQJ8d0/xFv38dC9NPha+lvFD5Wcw+bO
	utrpECeNz4OLeYoX/7MzZUhW9nmBUUQCWICwMz5QRXsXDJjBVgTtxn3nVw6y9Lkgfjy/lRsHAXv
	GG6nCdqIy8xwC4JQjAPtjmbzcg+w=
X-Google-Smtp-Source: AGHT+IEvROAdajvDaGhJmYch+/Aub0Z04uX1ZnjW2ApKdi35HTbO5+Uw3JnvWpTAQ1JVmcbINMpElpvcdSPaIErNnAE=
X-Received: by 2002:a17:90a:d702:b0:299:273c:7331 with SMTP id
 y2-20020a17090ad70200b00299273c7331mr2771398pju.41.1708083083212; Fri, 16 Feb
 2024 03:31:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240203165307.7806-1-aford173@gmail.com> <20240203165307.7806-10-aford173@gmail.com>
 <5916132.MhkbZ0Pkbq@steina-w>
In-Reply-To: <5916132.MhkbZ0Pkbq@steina-w>
From: Adam Ford <aford173@gmail.com>
Date: Fri, 16 Feb 2024 05:31:12 -0600
Message-ID: <CAHCN7x+80iw0PWa4F4dMA=3RRaChNEO534LPACXd6FK0ndAHpw@mail.gmail.com>
Subject: Re: [PATCH V8 09/12] dt-bindings: display: imx: add binding for
 i.MX8MP HDMI TX
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: linux-arm-kernel@lists.infradead.org, dri-devel@lists.freedesktop.org, 
	marex@denx.de, frieder.schrempf@kontron.de, 
	Lucas Stach <l.stach@pengutronix.de>, Andrzej Hajda <andrzej.hajda@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	NXP Linux Team <linux-imx@nxp.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Liu Ying <victor.liu@nxp.com>, 
	Ulf Hansson <ulf.hansson@linaro.org>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 16, 2024 at 3:05=E2=80=AFAM Alexander Stein
<alexander.stein@ew.tq-group.com> wrote:
>
> Hi all,
>
> Am Samstag, 3. Februar 2024, 17:52:49 CET schrieb Adam Ford:
> > From: Lucas Stach <l.stach@pengutronix.de>
> >
> > The HDMI TX controller on the i.MX8MP SoC is a Synopsys designware IP
> > core with a little bit of SoC integration around it.
> >
> > Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> > Signed-off-by: Adam Ford <aford173@gmail.com>
> >
> > ---
> > V3:  Change name and location to better idenfity as a bridge and
> >      HDMI 2.0a transmitter
> >
> >      Fix typos and feedback from Rob and added ports.
> > ---
> >  .../display/bridge/fsl,imx8mp-hdmi-tx.yaml    | 102 ++++++++++++++++++
> >  1 file changed, 102 insertions(+)
> >  create mode 100644
> > Documentation/devicetree/bindings/display/bridge/fsl,imx8mp-hdmi-tx.yam=
l
> >
> > diff --git
> > a/Documentation/devicetree/bindings/display/bridge/fsl,imx8mp-hdmi-tx.y=
aml
> > b/Documentation/devicetree/bindings/display/bridge/fsl,imx8mp-hdmi-tx.y=
aml
> > new file mode 100644
> > index 000000000000..3791c9f4ebab
> > --- /dev/null
> > +++
> > b/Documentation/devicetree/bindings/display/bridge/fsl,imx8mp-hdmi-tx.y=
aml
> > @@ -0,0 +1,102 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/display/bridge/fsl,imx8mp-hdmi-tx.y=
aml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Freescale i.MX8MP DWC HDMI TX Encoder
> > +
> > +maintainers:
> > +  - Lucas Stach <l.stach@pengutronix.de>
> > +
> > +description:
> > +  The i.MX8MP HDMI transmitter is a Synopsys DesignWare
> > +  HDMI 2.0a TX controller IP.
> > +
> > +allOf:
> > +  - $ref: /schemas/display/bridge/synopsys,dw-hdmi.yaml#
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - fsl,imx8mp-hdmi-tx
> > +
> > +  reg-io-width:
> > +    const: 1
> > +
> > +  clocks:
> > +    maxItems: 4
> > +
> > +  clock-names:
> > +    items:
> > +      - const: iahb
> > +      - const: isfr
> > +      - const: cec
> > +      - const: pix
> > +
> > +  power-domains:
> > +    maxItems: 1
> > +
> > +  ports:
> > +    $ref: /schemas/graph.yaml#/properties/ports
> > +
> > +    properties:
> > +      port@0:
> > +        $ref: /schemas/graph.yaml#/properties/port
> > +        description: Parallel RGB input port
> > +
> > +      port@1:
> > +        $ref: /schemas/graph.yaml#/properties/port
> > +        description: HDMI output port
> > +
> > +    required:
> > +      - port@0
> > +      - port@1
>
> Is this really correct that port@1 is required? AFAICS this host already
> supports HPD and DDC by itself, so there is no need for a dedicated HDMI
> connector.
> With the current state of the drivers this output port is completely igno=
red
> anyway. Yet it works for a lot of people.

One of the feedback responses Lucas got was that it was missing the
reference to the HDMI connector, so I added it as a response to that
feedback.  I have tried device trees with and without it, and it
doesn't impact anything, but It seems like there may be a requirement
for it.

adam
>
> Best regards,
> Alexander
>
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - clocks
> > +  - clock-names
> > +  - interrupts
> > +  - power-domains
> > +  - ports
> > +
> > +unevaluatedProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/clock/imx8mp-clock.h>
> > +    #include <dt-bindings/interrupt-controller/irq.h>
> > +    #include <dt-bindings/power/imx8mp-power.h>
> > +
> > +    hdmi@32fd8000 {
> > +        compatible =3D "fsl,imx8mp-hdmi-tx";
> > +        reg =3D <0x32fd8000 0x7eff>;
> > +        interrupts =3D <0 IRQ_TYPE_LEVEL_HIGH>;
> > +        clocks =3D <&clk IMX8MP_CLK_HDMI_APB>,
> > +                 <&clk IMX8MP_CLK_HDMI_REF_266M>,
> > +                 <&clk IMX8MP_CLK_32K>,
> > +                 <&hdmi_tx_phy>;
> > +        clock-names =3D "iahb", "isfr", "cec", "pix";
> > +        power-domains =3D <&hdmi_blk_ctrl IMX8MP_HDMIBLK_PD_HDMI_TX>;
> > +        reg-io-width =3D <1>;
> > +        ports {
> > +           #address-cells =3D <1>;
> > +           #size-cells =3D <0>;
> > +           port@0 {
> > +             reg =3D <0>;
> > +
> > +             hdmi_tx_from_pvi: endpoint {
> > +               remote-endpoint =3D <&pvi_to_hdmi_tx>;
> > +             };
> > +          };
> > +
> > +          port@1 {
> > +            reg =3D <1>;
> > +              hdmi_tx_out: endpoint {
> > +                remote-endpoint =3D <&hdmi0_con>;
> > +              };
> > +          };
> > +        };
> > +    };
>
>
> --
> TQ-Systems GmbH | M=C3=BChlstra=C3=9Fe 2, Gut Delling | 82229 Seefeld, Ge=
rmany
> Amtsgericht M=C3=BCnchen, HRB 105018
> Gesch=C3=A4ftsf=C3=BChrer: Detlef Schneider, R=C3=BCdiger Stahl, Stefan S=
chneider
> http://www.tq-group.com/
>
>

