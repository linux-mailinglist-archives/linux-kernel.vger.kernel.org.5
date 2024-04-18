Return-Path: <linux-kernel+bounces-149459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ED098A9169
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 05:05:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71EF51C20C80
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 03:05:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55E534F888;
	Thu, 18 Apr 2024 03:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XMCD9oDY"
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF3965464A;
	Thu, 18 Apr 2024 03:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713409495; cv=none; b=poc9twVRxtr/EyWHB7CLC8o28sqP/XvizwuQ91LWWsnjkjnx1PJojE1j28a3iFRU/cMJ11teJMl5aa0WPKu7qUkYHtVjybypT8e8LpgrHBVMwBlSxMXKHU69tbtKw8dHp4Ndn2SZYjl5D0JpHtW0123tZxx9MWPuXcYogymOuz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713409495; c=relaxed/simple;
	bh=IYbsargPJwgAjYCUljsr0lTnKhEgUmtJDU007J3fZC4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tVZrHDKZBjcV+M7nuhFMm951dtExOJrNicua3mBkcNyFreuONWVK/WDVDI2RqlSWoC4T/Gvmuob3INoUeEtD6T7PX2/wqkHYk13TSgsl1vq22EgDMmGG5u3lZ6b0ZbBnt//uquKJWedlmuFRH1mqLGIz/JBlhhprMBaCFKk07Ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XMCD9oDY; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-369e3c29aedso1831135ab.1;
        Wed, 17 Apr 2024 20:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713409493; x=1714014293; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bxDTePvUuJpRciyRzWuf/NP9ERBrPpwmGa0ygfJXUdM=;
        b=XMCD9oDYCWHoSzCGFbc/y/nk/xWvJnImxRDLzTEtQFXNbLYFC725p2lLrX2OYv49hP
         kau+DkhKdhhcBbKs/HF1TYNa6FCBzbE73OD/VRpbehByO9WtP7DOUU/rYmueoQ1FJpZK
         LdpDRh3x+deEvvoQmwK8c+kaoEZarvCs6go35Im7c8juPdQRMq95+dzPRJZpqnphh8E/
         YemZCdCz0nshcJwsBm5CQ1lvKFbbbbxj5gjOYRg8pGM7WF8dqFXya/L82R3OI4fywA11
         pysdmlgBBn5lWENcXYGwS1UGLa3nwE9CM6zzCJVM7M9LzC+vADzwqLa2iRrsFuwk+9Gn
         2bHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713409493; x=1714014293;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bxDTePvUuJpRciyRzWuf/NP9ERBrPpwmGa0ygfJXUdM=;
        b=b4iykXj1xCkvLnzQ6NHBD6k6jyQShZY6L9Fz2T0cbUccUQmPto6QW8Pc5EvDNMKigi
         kht4A0kQ/v/QXKuhVW3mHVfiB6NDADrlleQl7URwQbMOOD9oOzZzWe8db/IWxCSFl+7L
         wdtpG0/K8J493kn3cFRUvtza042zAUlPV9B7z9XoB2Co/aDhgFzUFRHtSLm3NpjXdvb4
         9olS3nEyxPLVQ3yeqD78b0T4gbro+AVUDMPQ1N3eIObsYoWByHzlzFL5Cxd2i2EdtndF
         0MRjXlG01W7O46VyzPsTrrsFACiQVdryWrRE7AXuXTjMQh+gVefu294SY8z0UQvdZpaW
         /Iqw==
X-Forwarded-Encrypted: i=1; AJvYcCVMg1LTdbCr8F1IBfDJuHeIX4iiGn35enmmzCADkJF4hL9GGo5jThHABcbCFZvV5rcQ2KYFjKLiYwmP314gnJ9o/7P/aJyQNh9r3qPQ+nkX5MIY0HlrhkPxkzHTT3DWBnNErCuWS+ullErNkCju72VAmu50mPyMMSlTjEd1j44jAlB7pbTb
X-Gm-Message-State: AOJu0YzE/3U+2Gy29CrNaXPEMw0utzQanzVa2omEl7gEJKuWHryg14zx
	7wirsYH4bctFhNVILruC71shmjPxL25bcmjU/cHkeTkw9hPRVIGxJiVq55HaDOiTCBG1C2LMsod
	iyH2dYzL1EwlKjL0LQL1zOS/WXzY=
X-Google-Smtp-Source: AGHT+IHRKX1tdI8zogX+a2YNb9TstRLegJJP9XfxDyAqAFU+rTRkTUENh/cfe816KPB4rWxlbPae2hQrCSWBHmTZvIA=
X-Received: by 2002:a05:6e02:1806:b0:36b:3bc7:f338 with SMTP id
 a6-20020a056e02180600b0036b3bc7f338mr1625970ilv.3.1713409492972; Wed, 17 Apr
 2024 20:04:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1713345932-6408-1-git-send-email-shengjiu.wang@nxp.com> <c3bcefc9-61de-44aa-8412-17ea42e7048c@kernel.org>
In-Reply-To: <c3bcefc9-61de-44aa-8412-17ea42e7048c@kernel.org>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Thu, 18 Apr 2024 11:04:38 +0800
Message-ID: <CAA+D8ANB1v1ei6ez6KSWoXLMqk+6CvThY3qrDsqO=tHOC0DNhg@mail.gmail.com>
Subject: Re: [PATCH] ASoC: dt-bindings: fsl,ssi: Convert to YAML
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Shengjiu Wang <shengjiu.wang@nxp.com>, lgirdwood@gmail.com, broonie@kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	linux-sound@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 17, 2024 at 10:16=E2=80=AFPM Krzysztof Kozlowski <krzk@kernel.o=
rg> wrote:
>
> On 17/04/2024 11:25, Shengjiu Wang wrote:
> > Convert the fsl,ssi binding to YAML.
> >
>
> ...
>
> > +description:
> > +  Notes on fsl,playback-dma and fsl,capture-dma
> > +  On SOCs that have an SSI, specific DMA channels are hard-wired for p=
layback
> > +  and capture.  On the MPC8610, for example, SSI1 must use DMA channel=
 0 for
> > +  playback and DMA channel 1 for capture.  SSI2 must use DMA channel 2=
 for
> > +  playback and DMA channel 3 for capture.  The developer can choose wh=
ich
> > +  DMA controller to use, but the channels themselves are hard-wired.  =
The
> > +  purpose of these two properties is to represent this hardware design=
.
> > +
> > +  The device tree nodes for the DMA channels that are referenced by
> > +  "fsl,playback-dma" and "fsl,capture-dma" must be marked as compatibl=
e with
> > +  "fsl,ssi-dma-channel".  The SOC-specific compatible string (e.g.
> > +  "fsl,mpc8610-dma-channel") can remain.  If these nodes are left as
> > +  "fsl,elo-dma-channel" or "fsl,eloplus-dma-channel", then the generic=
 Elo DMA
> > +  drivers (fsldma) will attempt to use them, and it will conflict with=
 the
> > +  sound drivers.
> > +
> > +properties:
> > +  compatible:
> > +    oneOf:
> > +      - items:
> > +          - enum:
> > +              - fsl,imx50-ssi
> > +              - fsl,imx53-ssi
> > +          - enum:
> > +              - fsl,imx51-ssi
> > +          - enum:
> > +              - fsl,imx21-ssi
>
> That's a mess... you cannot have enums as fallbacks.

ok, will use const.
>
> > +      - items:
> > +          - enum:
> > +              - fsl,imx25-ssi
> > +              - fsl,imx27-ssi
> > +              - fsl,imx35-ssi
> > +              - fsl,imx51-ssi
> > +              - fsl,imx6q-ssi
> > +              - fsl,imx6sl-ssi
> > +              - fsl,imx6sx-ssi
> > +          - enum:
> > +              - fsl,imx21-ssi
> > +              - fsl,imx51-ssi
> > +      - items:
> > +          - const: fsl,mpc8610-ssi
> > +
> > +  cell-index:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    enum: [0, 1, 2]
> > +    description: The SSI index
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +  fsl,fifo-depth:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    description:
> > +      The number of elements in the transmit and receive FIFOs.
> > +      This number is the maximum allowed value for SFCSR[TFWM0].
> > +
> > +  clocks:
> > +    items:
> > +      - description: The ipg clock for register access
> > +      - description: clock for SSI master mode
> > +    minItems: 1
> > +
> > +  clock-names:
> > +    items:
> > +      - const: ipg
> > +      - const: baud
> > +    minItems: 1
> > +
> > +  dmas:
> > +    oneOf:
> > +      - items:
> > +          - description: DMA controller phandle and request line for R=
X
> > +          - description: DMA controller phandle and request line for T=
X
> > +      - items:
> > +          - description: DMA controller phandle and request line for R=
X0
> > +          - description: DMA controller phandle and request line for T=
X0
> > +          - description: DMA controller phandle and request line for R=
X1
> > +          - description: DMA controller phandle and request line for T=
X1
> > +
> > +  dma-names:
> > +    oneOf:
> > +      - items:
> > +          - const: rx
> > +          - const: tx
> > +      - items:
> > +          - const: rx0
> > +          - const: tx0
> > +          - const: rx1
> > +          - const: tx1
> > +
> > +  codec-handle:
> > +    $ref: /schemas/types.yaml#/definitions/phandle
> > +    description:
> > +      Phandle to a 'codec' node that defines an audio
> > +      codec connected to this SSI.  This node is typically
> > +      a child of an I2C or other control node.
> > +
> > +  fsl,fiq-stream-filter:
> > +    type: boolean
> > +    description:
> > +      Disabled DMA and use FIQ instead to filter the codec stream.
> > +      This is necessary for some boards where an incompatible codec
> > +      is connected to this SSI, e.g. on pca100 and pcm043.
> > +
> > +  fsl,mode:
> > +    $ref: /schemas/types.yaml#/definitions/string
> > +    enum: [ ac97-slave, ac97-master, i2s-slave, i2s-master,
> > +            lj-slave, lj-master, rj-slave, rj-master ]
> > +    description: |
> > +      "ac97-slave" - AC97 mode, SSI is clock slave
> > +      "ac97-master" - AC97 mode, SSI is clock master
> > +      "i2s-slave" - I2S mode, SSI is clock slave
> > +      "i2s-master" - I2S mode, SSI is clock master
> > +      "lj-slave" - Left justified mode, SSI is clock slave
> > +      "lj-master" - Left justified mode, SSI is clock master
> > +      "rj-slave" - Right justified mode, SSI is clock slave
> > +      "rj-master" - Right justified mode, SSI is clock master
> > +
> > +  fsl,ssi-asynchronous:
> > +    type: boolean
> > +    description: If specified, the SSI is to be programmed in asynchro=
nous
> > +      mode.  In this mode, pins SRCK, STCK, SRFS, and STFS must
> > +      all be connected to valid signals.  In synchronous mode,
> > +      SRCK and SRFS are ignored.  Asynchronous mode allows
> > +      playback and capture to use different sample sizes and
> > +      sample rates.  Some drivers may require that SRCK and STCK
> > +      be connected together, and SRFS and STFS be connected
> > +      together.  This would still allow different sample sizes,
> > +      but not different sample rates.
> > +
> > +  fsl,playback-dma:
> > +    $ref: /schemas/types.yaml#/definitions/phandle
> > +    description: Phandle to a node for the DMA channel to use for
> > +      playback of audio.  This is typically dictated by SOC
> > +      design. Only used on Power Architecture.
> > +
> > +  fsl,capture-dma:
> > +    $ref: /schemas/types.yaml#/definitions/phandle
> > +    description: Phandle to a node for the DMA channel to use for
> > +      capture (recording) of audio.  This is typically dictated
> > +      by SOC design. Only used on Power Architecture.
> > +
> > +  "#sound-dai-cells":
> > +    const: 0
> > +    description: optional, some dts node didn't add it.
>
> The question is: is this DAI or not?

Yes, it is a DAI. so, is there any issue here?

>
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - interrupts
> > +  - fsl,fifo-depth
> > +
> > +unevaluatedProperties: false
>
> This must be additionalProperties:false. Use example-schema as
> reference... unless you want to reference dai-common.yaml, but then that
> one is missing.

As it is a DAI,  so I should include dai-common.yaml,  right?

Best regards
Shengjiu Wang

>
> Best regards,
> Krzysztof
>

