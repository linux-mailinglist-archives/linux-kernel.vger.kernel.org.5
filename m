Return-Path: <linux-kernel+bounces-84852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ACAD186AC8A
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 12:06:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33C651F23580
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 11:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C928112E1CC;
	Wed, 28 Feb 2024 11:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kzKr0qQF"
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5419A12BE86
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 11:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709118331; cv=none; b=DP8RPRBa2y8UWOYWHo31Vj+BWcE8jU63Zx3td2s+FV4hr3/p1RKS4dVpEI2zXtfJld3ruTlueVrs4WhP1iEB3rUYiOgvpDjNbnO4xxVNS8v8pwb/lOO/jOfGhgrDZ+RBktA9ycJoaOBkJnmyawPI5szWX3VSZX6cuBg1b14CT7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709118331; c=relaxed/simple;
	bh=YSlyusQKQVJsJ6QiGNoJfitiHng4C0WHuFHr310kln8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VewUh/RmIemA9yGfsiOoy7y7hRps+08HvO02V7o2xGrKDrdm2WNJT5V45EV59wr94/Gkr/XCZ4lKojC7PDE5KqSKElaewxkazEqK2IPRbcq4I68aov9lrpuf81MmL5Rbvz40Kyg+kczMy7K7XFSZOTUxH7sfw9LHGj95OxsfVb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kzKr0qQF; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-7c7f3f66d17so47288139f.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 03:05:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709118328; x=1709723128; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SIN5TJ61NQTJqN5mR5pFOd0k+x3pH5IedFrp+UzE1z4=;
        b=kzKr0qQFLigCnAUcBik5hGbS39mRCXe9o67XsmHWQqHws/e/9fLkHNBrV4WXwIQ0yY
         zGYvdO1ErrjepfxbVI7Pi5Y/V4EBCRWKekW4b/v2H8vtlZxwVFZ+AIsHamrIlD5XrNmV
         dXzOF+Z+BbI0hJGveVq3+I9jw2zKeWwWog5LMBFkFT/ucZc238A1ClRuc/6TmCsktccr
         sfDKMy4rDpSbh4qTrI6doRlUtnkhot22EMeHDSIzQsBPVNpbWX0zJ6EpxGRwWHyC9VW+
         29BFjEJQbf0xHGo16kCPhg2pMWqJNXRRwlfqXryKVBxASl/H5tn9xh//YM/5kisNheiu
         AwGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709118328; x=1709723128;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SIN5TJ61NQTJqN5mR5pFOd0k+x3pH5IedFrp+UzE1z4=;
        b=KgBYrxM0zxYVF3P3eaolN4DzEVf3VBgf8GaK+pHxlLxyvn3QHSNMYl3hmhQK5ypeLI
         PHqEo8Nd3SA/KDBy0vIBlja2ZJjyWPH6LVIWEEvXILHuU2adBbzSidfD+L8426DfIear
         44mAr+cJEgYcAtXjDKQpkunjICHiUkDzmOFpr6KLuli/RcuzJOnzbECRoYIS8bBZhtJd
         kXTNCzQqZSBKmcQwRHlRr8YN9DDYfnKzQGl4AW1SwAUHeRUNLSDKIDc/nHnVcxNhj8d3
         s1xpb7kkf1uuti8WohK1cqVx3tuG2nJ0GIkvMPQElG9gzJOwhK/ppV4xyy75Jixg75qe
         9+Ow==
X-Forwarded-Encrypted: i=1; AJvYcCUWnUR2az7hqwdfzUK1Bg5X0NJi/KOe/6fjl4pD/KGaX/z/psMgU9LfReg+58harVe6kHvpSAKbB2YgqAMyBSjMDqYH7AHXZ7t6Usva
X-Gm-Message-State: AOJu0Yz7IGdvw0hV2wgwpATHCO+ByVk4BcokS83wiIrwK87fSpS5KcQM
	Bcgh4hIkXGil+qB4ekAMcKAmn4K+vZtPuLfPCy3CZ7aJhpPye0l3T1onNou6ms9k2DzOIDiGom0
	ZPkiCuCFrQkg2FnIqUYeDHqYbDTNBvwgIIAIo
X-Google-Smtp-Source: AGHT+IEtOPOXXjbhjWRTvlgw2RoCh449T+tuUODnpg0QVWyKCQfa5m8qgfwgP0ycVI+iuXGb9VZY8QV966FEbQYeMtw=
X-Received: by 2002:a05:6602:5a:b0:7c4:9ce4:aa3e with SMTP id
 z26-20020a056602005a00b007c49ce4aa3emr13999951ioz.7.1709118328434; Wed, 28
 Feb 2024 03:05:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221160215.484151-1-panikiel@google.com> <20240221160215.484151-9-panikiel@google.com>
 <13aeb2ff-72f4-49d9-b65e-ddc31569a936@linaro.org> <CAM5zL5q0oKoTMR0jSwYVAChCOJ9iKYPRFiU1vH4qDqhHALKz4w@mail.gmail.com>
 <20240227142911.GB3863852-robh@kernel.org>
In-Reply-To: <20240227142911.GB3863852-robh@kernel.org>
From: =?UTF-8?Q?Pawe=C5=82_Anikiel?= <panikiel@google.com>
Date: Wed, 28 Feb 2024 12:05:17 +0100
Message-ID: <CAM5zL5pXu5sbzCHY_BrCJ7eZj-p9n0tCo6CmuTqUpvniTrqWJg@mail.gmail.com>
Subject: Re: [PATCH v2 8/9] media: dt-bindings: Add Intel Displayport RX IP
To: Rob Herring <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, airlied@gmail.com, 
	akpm@linux-foundation.org, conor+dt@kernel.org, daniel@ffwll.ch, 
	dinguyen@kernel.org, hverkuil-cisco@xs4all.nl, 
	krzysztof.kozlowski+dt@linaro.org, maarten.lankhorst@linux.intel.com, 
	mchehab@kernel.org, mripard@kernel.org, tzimmermann@suse.de, 
	devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
	chromeos-krk-upstreaming@google.com, ribalda@chromium.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 27, 2024 at 3:29=E2=80=AFPM Rob Herring <robh@kernel.org> wrote=
:
>
> On Mon, Feb 26, 2024 at 11:59:42AM +0100, Pawe=C5=82 Anikiel wrote:
> > On Mon, Feb 26, 2024 at 10:13=E2=80=AFAM Krzysztof Kozlowski
> > <krzysztof.kozlowski@linaro.org> wrote:
> > >
> > > On 21/02/2024 17:02, Pawe=C5=82 Anikiel wrote:
> > > > The Intel Displayport RX IP is a part of the DisplayPort Intel FPGA=
 IP
> > > > Core. It implements a DisplayPort 1.4 receiver capable of HBR3 vide=
o
> > > > capture and Multi-Stream Transport. The user guide can be found her=
e:
> > > >
> > > > https://www.intel.com/programmable/technical-pdfs/683273.pdf
> > > >
> > > > Signed-off-by: Pawe=C5=82 Anikiel <panikiel@google.com>
> > > > ---
> > > >  .../devicetree/bindings/media/intel,dprx.yaml | 160 ++++++++++++++=
++++
> > > >  1 file changed, 160 insertions(+)
> > > >  create mode 100644 Documentation/devicetree/bindings/media/intel,d=
prx.yaml
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/media/intel,dprx.yam=
l b/Documentation/devicetree/bindings/media/intel,dprx.yaml
> > > > new file mode 100644
> > > > index 000000000000..31025f2d5dcd
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/media/intel,dprx.yaml
> > > > @@ -0,0 +1,160 @@
> > > > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > > > +%YAML 1.2
> > > > +---
> > > > +$id: http://devicetree.org/schemas/media/intel,dprx.yaml#
> > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > +
> > > > +title: Intel DisplayPort RX IP
> > > > +
> > > > +maintainers:
> > > > +  - Pawe=C5=82 Anikiel <panikiel@google.com>
> > > > +
> > > > +description: |
> > > > +  The Intel Displayport RX IP is a part of the DisplayPort Intel F=
PGA IP
> > > > +  Core. It implements a DisplayPort 1.4 receiver capable of HBR3 v=
ideo
> > > > +  capture and Multi-Stream Transport.
> > > > +
> > > > +  The IP features a large number of configuration parameters, foun=
d at:
> > > > +  https://www.intel.com/content/www/us/en/docs/programmable/683273=
/23-3-20-0-1/sink-parameters.html
> > > > +
> > > > +  The following parameters have to be enabled:
> > > > +    - Support DisplayPort sink
> > > > +    - Enable GPU control
> > > > +  The following parameters' values have to be set in the devicetre=
e:
> > > > +    - RX maximum link rate
> > > > +    - Maximum lane count
> > > > +    - Support MST
> > > > +    - Max stream count (only if Support MST is enabled)
> > > > +
> > > > +properties:
> > > > +  compatible:
> > > > +    const: intel,dprx-20.0.1
> > > > +
> > > > +  reg:
> > > > +    maxItems: 1
> > > > +
> > > > +  interrupts:
> > > > +    maxItems: 1
> > > > +
> > > > +  intel,max-link-rate:
> > > > +    $ref: /schemas/types.yaml#/definitions/uint32
> > > > +    description: Max link rate configuration parameter
> > >
> > > Please do not duplicate property name in description. It's useless.
> > > Instead explain what is this responsible for.
> > >
> > > Why max-link-rate would differ for the same dprx-20.0.1? And why
> > > standard properties cannot be used?
> > >
> > > Same for all questions below.
> >
> > These four properties are the IP configuration parameters mentioned in
> > the device description. When generating the IP core you can set these
> > parameters, which could make them differ for the same dprx-20.0.1.
> > They are documented in the user guide, for which I also put a link in
> > the description. Is that enough? Or should I also document these
> > parameters here?
>
> Use the standard properties: link-frequencies and data-lanes. Those go
> under the port(s) because they are inheritly per logical link.

The DP receiver has one input interface (a deserialized DP stream),
and up to four output interfaces (the decoded video streams). The "max
link rate" and "max lane count" parameters only describe the input
interface to the receiver. However, the port(s) I am using here are
for the output streams. They are not affected by those parameters, so
I don't think these properties should go under the output port(s).

The receiver doesn't have an input port in the DT, because there isn't
any controllable entity on the other side - the deserializer doesn't
have any software interface. Since these standard properties
(link-frequencies and data-lanes) are only defined in
video-interfaces.yaml (which IIUC describes a graph endpoint), I can't
use them directly in the device node.

Do you see a way to use these standard properties here?

