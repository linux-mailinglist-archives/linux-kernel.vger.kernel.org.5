Return-Path: <linux-kernel+bounces-86848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76DDD86CBAE
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 15:36:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A85321C20D25
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 14:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00FA01369A8;
	Thu, 29 Feb 2024 14:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="n1bSE8Ex"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E19E013D31D
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 14:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709217363; cv=none; b=MrnQ6N4pb9imLda3qKfAGoCdx05xa2pZiSaOjLaHt0ulgMS/RWf6x6dxO9prk/hlalRYe81HoMkU/drBs+JV78Xy8fzXtRdTik2SDcSI0ohUXZUQqUo2w95p1PQ4EWppsBpmiD7OoNCsnn6m5WDuPJdTx1muV5roZ/81oEmzHgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709217363; c=relaxed/simple;
	bh=u0JUBhjQ4sGb7MtY00JcSowml0hWIM4BZxLrLYwauig=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s7qk9ncSV89yC6jlLiM4y97zF4XhWWwg3bbPV+L7zBrE17sKZ2AmJhnazd6hhAzWXjuBXV/s1kcBZIKD2WMCfxOI4pK4phCq2JSp1OZds+mYo4PuNsz32E/3V++9PqYerVX0vSVAAZ1esJ/l2NKri+3suBoBIaLU/Rc73/prvA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=n1bSE8Ex; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2d21cdbc85bso10601061fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 06:36:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1709217359; x=1709822159; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sz88iOY6NApYHzpIrcMwxyE6MowEg0Dpz6Nm6MlbMsA=;
        b=n1bSE8Ex0gTzYUbmetmN+kltXoAJj4bUW/nHi41qGUWt/uBRW9SMF8sMkIBcGq9ZbD
         Iamf0j06+t+jicwb1Gle+T6M/PrhVoYDTq5yCuCAmY3iQ+mDh6iLuu53V9fSzSZ8MogE
         mqFZa5kQPJ1KsZGVjpEoMdcw08uws5ToT3Lt46WFn+/eBqH7CIY0Re6oSrvBSW2fUB/Q
         Py+56nOteLTlYc/7L8nfAEoF2iXzb4Zxb9Y9FodVBgIGBfBsIjNdmTHktMCVb8E4dANa
         oTE4pyIlzVDujmB8WhDqT0bbUC490uIg7nxLVpw592RLZJzeapW68tK6R+LbWtLQynoz
         5DWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709217359; x=1709822159;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sz88iOY6NApYHzpIrcMwxyE6MowEg0Dpz6Nm6MlbMsA=;
        b=ZlfH1N3V6+X9+v7QhsoFkmJx3QRdCZNoCfZBoi4Rgl3Lo22DZQa60a+gHruZk+7LlL
         0gvm+T7n9n9JVCls5HrIFtmf2DA2LHiLQr3d+9Ri4ipQpEL61NX3+0sBfyKPqzjwv4Lg
         QXCEOCAQRoTlVasZsuapmJKMrzX/gYuzjb+lSOZvPQncgM0PSAEoTqVCt2kkoMG4Zkem
         nBH0sD9lt0XAwqmXVmzur1BdOFVtzCHCJCtZvAb/f8pyR0y66G0z3PjobjJ4P+uD27I5
         8JT5heJCEUZaYYmWJuDXZGJ/igUBHKhljSxCTgdDzeoYp+mhSfUEhgM95LksBEARLHo6
         JC3Q==
X-Forwarded-Encrypted: i=1; AJvYcCVFQ2BAPRcwE2RtW9wNfI4z1yPDTZwET46mO5gvnaQgoX7V2Sl72JUODx2QVVLLncCTruRGbXBD+NdysXBesAVQgVrOG/rg7ktBJeiT
X-Gm-Message-State: AOJu0YwA5+JCdewl2NNNxRxqA83m6k8uUoSMbLaxq/37RXx1JpyPUnYH
	luNBts+fWrEIOgoEShuxufgzm1mtxYYHhxPu89ZvpHo+gTNSGnosOUYKYNHkMWX/yV5UIYqKCzk
	LIZurCDRFT9BbqVvhaYcXamEvw9zV1og8aUkzwg==
X-Google-Smtp-Source: AGHT+IGHaNP/H4vHZKJ4y6B0kLqYob2bOrCNEIsNueH3s9653/jhA47m7OSjPlN4MpQUmkuqNouzzi7ynvk1S67YLaI=
X-Received: by 2002:a2e:7218:0:b0:2d2:d0ba:2586 with SMTP id
 n24-20020a2e7218000000b002d2d0ba2586mr1517275ljc.24.1709217359043; Thu, 29
 Feb 2024 06:35:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240228-ad7944-mainline-v3-0-781b922334af@baylibre.com>
 <20240228-ad7944-mainline-v3-1-781b922334af@baylibre.com> <06235b66-6948-49b3-b881-198443a421df@linaro.org>
In-Reply-To: <06235b66-6948-49b3-b881-198443a421df@linaro.org>
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 29 Feb 2024 08:35:47 -0600
Message-ID: <CAMknhBHhrNc-6qggSD1pt8djc9cv93dyNON8c_np6RwqT3yzig@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: iio: adc: add ad7944 ADCs
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: linux-iio@vger.kernel.org, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 29, 2024 at 3:40=E2=80=AFAM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 28/02/2024 19:10, David Lechner wrote:
> > This adds a new binding for the Analog Devices, Inc. AD7944, AD7985, an=
d
> > AD7986 ADCs.
> >
> > Signed-off-by: David Lechner <dlechner@baylibre.com>
> > ---
> >  .../devicetree/bindings/iio/adc/adi,ad7944.yaml    | 213 +++++++++++++=
++++++++
> >  MAINTAINERS                                        |   8 +
> >  2 files changed, 221 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7944.yaml =
b/Documentation/devicetree/bindings/iio/adc/adi,ad7944.yaml
> > new file mode 100644
> > index 000000000000..2564ef4f58cc
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7944.yaml
> > @@ -0,0 +1,213 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> >
> > v2 changes:
> > - Removed default 'multi' value from adi,spi-mode property. This simpli=
fies
> >   things a bit by not having to check for two possible conditions (abse=
nce of
> >   property or explicit default value). Now, only absence of property is=
 valid to
> >   indicate the default mode. Constraints that depend on this property a=
re
> >   updated accordingly.
> > - Fixed spelling of 'conventional'.
> > - Expanded description to call out potential confusion of '3-wire' mode=
 being
> >   unrelated to the standard spi-3wire property.
> > - Added standard '#daisy-chained-devices' property for chain mode.
> > - Relaxed requirement of cnv-gpios since it was determined that an acti=
ve high
> >   CS could actually be used in chain mode.
>
> ? Please don't edit patches manually... Use git or git+b4. Or quilt?
>
> Best regards,
> Krzysztof
>

Oh geez, yeah really dumb mistake. Will resend. I do use b4 but it
doesn't handle per-patch changelogs that I know of.

