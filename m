Return-Path: <linux-kernel+bounces-154551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C73A8ADD7E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 08:28:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0CBC1F21E1B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 06:28:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 740BD22F1C;
	Tue, 23 Apr 2024 06:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="hcM4JGFF";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="Bl73Wdja"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 541F418AED;
	Tue, 23 Apr 2024 06:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713853697; cv=none; b=iIMatzk+cOruKfOy/W2v7IFg1nnQrDCSQ7m3tvFtvQ6YFdz2MspbM8ac9jSNvJjrxPGJqeXgoI6jFsWNyaQTJ0AGFE4v55xtW5wzG/wwdAr57tZBgpTnkJEuj/0GGSpGFNciypiT9Qi3zbH8jawAYt3KoUZ0hIER8Mn2Vj0DRzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713853697; c=relaxed/simple;
	bh=bTqOlJPxf19hbYZuRhpdOowyks9931C1XB8PhVGIDM8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mz6EshwfNvbVMV8fzNFFwUzVLY63/eLD+e+NaDDezaxFNPUPFZHp4dlFndH7f9vPIFpYeEEw44BHrtFdTgvx9yDC3rXkI1qRXZ5DZQoKBowPF8/fmD4mmUhRtYl+eXH6O7pHg6XaIWx1+5fuUwEceF4lvJzECZ7Awx4vqt3ts9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=hcM4JGFF; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=Bl73Wdja reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1713853695; x=1745389695;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ekNGjMp4Zrx4F3nM7RoEMrNb3QuJRzTm83VI153eLUU=;
  b=hcM4JGFFZA6iPkRzqPYgvma51DtKjY0NuGA6VIlkSKTnYBl9t7bUl8qU
   p4oKViMMQHsFEeycJV3M/L7c1SzyCSKwrWRUoOADqkZMSW12L8R86SK6Y
   q1l6oKjib6/BdB1H0fQD8ZCB380QwV2ueEz2SIFQAMCExYcknEwMTb7uD
   tx53rtIrLdRP2kveizGv6aZKzke5CONySNtCHI6hmH1fqDHILKq3Avs8k
   sFIF70wjdMjbtP8Mt5oA9tbbbCMJR66l5INGhH9cEJPTMZU8zOBvxPXRJ
   jdvZTeck+Pb5n+vMwiPlzbg39edCj8gV17pZLRRKDBIxFqwdprbDOA5Cu
   g==;
X-IronPort-AV: E=Sophos;i="6.07,222,1708383600"; 
   d="scan'208";a="36554990"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 23 Apr 2024 08:28:13 +0200
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C75CA17515A;
	Tue, 23 Apr 2024 08:28:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1713853689;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=ekNGjMp4Zrx4F3nM7RoEMrNb3QuJRzTm83VI153eLUU=;
	b=Bl73WdjaVJUonUkmm6/VvfC9P8u9XubvvBXhguS429AKWdPK54G/hDvus7wElW/Yl+cpOV
	RE2/R0VmrI5S8aW6pOD2p/fuc5jgWMTXfFPnzo30ZqxqZXar/RRFMgCFd4+Q7wNIc1Wp+X
	DOhao5wykMaoHmWiz+gQQerzD7ZHt/f4SqnFbtg1jGRLAzM9hlAyC6bh/PCTWoUpEkRfTx
	pKgPDBknvPlFmXG6Pmuccm00s9Snb/P5VSsI7/DknmIntXmlLYkXaFBFVRNQBT2RLAJYoJ
	iwl/c3gi6TUSQw0Omz5w4TNeocK2e5XNGEdyxWsOQdOnZtibBZKMg4muS5mB/Q==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Frank Li <Frank.li@nxp.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Lucas Stach <l.stach@pengutronix.de>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 1/1] dt-bindings: interrupt-controller: fsl, irqsteer: Add imx8qxp support
Date: Tue, 23 Apr 2024 08:28:10 +0200
Message-ID: <4564666.LvFx2qVVIh@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <ZiaScfP5Ep81cPXJ@lizhi-Precision-Tower-5810>
References: <20240422064949.70778-1-alexander.stein@ew.tq-group.com> <ZiaScfP5Ep81cPXJ@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Last-TLS-Session-Version: TLSv1.3

Hi Frank,

Am Montag, 22. April 2024, 18:38:09 CEST schrieb Frank Li:
> On Mon, Apr 22, 2024 at 08:49:49AM +0200, Alexander Stein wrote:
> > Some SoC like i.MX8QXP use a power-domain for this IP. Add a SoC-specif=
ic
> > compatible, which also requires a power-domain.
> >=20
> > Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> > ---
>=20
> Next time, please cc imx@lists.linux.dev

I use the addresses from ./scripts/get_maintainer.pl, maybe you want to
add that to MAINTAINERS.

Thanks and best regards,
Alexander

> Frank
>=20
> > Thanks for the feedback.
> >=20
> > Changes in v3:
> > * Move 'allOf' before 'additionalProperties'
> > * Remove superfluous 'minItems: 1'
> >=20
> >  .../interrupt-controller/fsl,irqsteer.yaml      | 17 ++++++++++++++++-
> >  1 file changed, 16 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/Documentation/devicetree/bindings/interrupt-controller/fsl=
,irqsteer.yaml b/Documentation/devicetree/bindings/interrupt-controller/fsl=
,irqsteer.yaml
> > index 20ad4ad82ad64..3d33b75d6ecfa 100644
> > --- a/Documentation/devicetree/bindings/interrupt-controller/fsl,irqste=
er.yaml
> > +++ b/Documentation/devicetree/bindings/interrupt-controller/fsl,irqste=
er.yaml
> > @@ -14,7 +14,9 @@ properties:
> >      oneOf:
> >        - const: fsl,imx-irqsteer
> >        - items:
> > -          - const: fsl,imx8m-irqsteer
> > +          - enum:
> > +              - fsl,imx8m-irqsteer
> > +              - fsl,imx8qxp-irqsteer
> >            - const: fsl,imx-irqsteer
> > =20
> >    reg:
> > @@ -42,6 +44,9 @@ properties:
> >    clock-names:
> >      const: ipg
> > =20
> > +  power-domains:
> > +    maxItems: 1
> > +
> >    interrupt-controller: true
> > =20
> >    "#interrupt-cells":
> > @@ -70,6 +75,16 @@ required:
> >    - fsl,channel
> >    - fsl,num-irqs
> > =20
> > +allOf:
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            const: fsl,imx8qxp-irqsteer
> > +    then:
> > +      required:
> > +        - power-domains
> > +
> >  additionalProperties: false
> > =20
> >  examples:
>=20


=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/



