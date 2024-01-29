Return-Path: <linux-kernel+bounces-42276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DAE6283FEF0
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 08:16:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19A551C20C2C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 07:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D29D54E1C1;
	Mon, 29 Jan 2024 07:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QigT3h7i"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68CEF4D595
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 07:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706512591; cv=none; b=J8alZtAWiP4/7tuygxgpnr2bHcGvkoIB3wX8dzPoTsUUNIEDFUVvog9gUHpk0mqCksD+uA2flUEZbtt024QOZT3Il6jFeNuQh6GSwAKMNy9K5I9NYRUwa8D5s2Smhb3SzvREltnmDpLt7ImilDsg6x2zcFeZHfVjYl0PnN/NtJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706512591; c=relaxed/simple;
	bh=hG7Vzfp17NEMbZ3kboNPbIEc5FlT8qqXwwpgqCE+nb4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rLCtEobrG9PtHVkdPiPrYJjAk3ZyTx4TYfLHm0hkloCvImo8yM7LKnqc07eLW2d13TSDiHgQqhIsZcfqE5Kv9GySpUqZynjr874H+ZQzGTB27bVtsvWqKrVw8dA+25qvjvN2RBNq3GCryj1eYhIhmdXRxdO71qF6zHJTWvLynM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=QigT3h7i; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-510f37d6714so1512568e87.2
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jan 2024 23:16:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706512587; x=1707117387; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GKVjPpRBlhrSt/tEcTU8BHnh+3o7uF091QzM4ro5QmU=;
        b=QigT3h7iNkQxGtwVgZk4mEthkLtatteMJZ8aD3L331FzmXtbTp1mVGJHgpRMsW+zJN
         7npXMpRFZZGpm2gcBDAuLkcpOO70zJO85a2uOUisB2DS+AECfYzLJqecwHZ0WDT9YKCF
         rhoQcGU1fg7hupR04dMQU5aM7gB5KAt6CpMBg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706512587; x=1707117387;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GKVjPpRBlhrSt/tEcTU8BHnh+3o7uF091QzM4ro5QmU=;
        b=f4T5T+z4vdMYY3ufz7+awAW6OKfkjEu/diHZh1Xd0YKylQFhBiuAuaYEYF0d2hzzT5
         d12uLod/i7oelaCb/MHyRwP4s9ZkiMXsCEsbIozFvCNWoJ3gmTOddUe5GhctHeox/YpF
         P8K552YJv3ZcJFPgh+j1uixHn6E5YSDKW6H+ytbkUcM45Cnl5nWQvVWfje0qco0A5HpV
         diZ6A+73eKF/igKrWe1e6G9UBLFqxbndNC+RgZQ2tujeLvrXNedq2WoS8RxWR31UYW1r
         02js9Fa+KmKO5w517GxIyweCFnMF2se+RX53GzzI6vMqLPmuPTM6LLqKim7EQpEw9wXv
         +vZA==
X-Gm-Message-State: AOJu0Yxst/I/tBJdVLLNFiDuUbpHwl+NbWAbxecmSDb8za68cgEQ8wuF
	6U2lBFM86RmvwvEAguUQvPnNhZBfYArfXHZWVcOqDac46jFGVQfiANA9veFpjSY/3KM1dwpvFQM
	jyQsILzFOKUZLtYR3TKFFC5s2Eka/pSOCPKnh
X-Google-Smtp-Source: AGHT+IEb0p1syRm7CrHn7mmVEwAtW1jrbzLAGOaEIdkZmX7QHvHCjeBg+3TTT52oNs9z67jT8ZgnE281V4VmoPUshog=
X-Received: by 2002:a05:6512:201c:b0:50e:ca2a:50f8 with SMTP id
 a28-20020a056512201c00b0050eca2a50f8mr2832350lfb.63.1706512587448; Sun, 28
 Jan 2024 23:16:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240126073511.2708574-1-wenst@chromium.org> <25e0a1c6-70dd-409b-927b-ef113e6a4cc4@linaro.org>
In-Reply-To: <25e0a1c6-70dd-409b-927b-ef113e6a4cc4@linaro.org>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Mon, 29 Jan 2024 15:16:16 +0800
Message-ID: <CAGXv+5FN+=Y-c74R2WguvP_2PZwArvsNd2SLy=aKEs06A4NhPw@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: display: bridge: it6505: Add #sound-dai-cells
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Robert Foss <rfoss@kernel.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
	Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Allen Chen <allen.chen@ite.com.tw>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 26, 2024 at 6:17=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 26/01/2024 08:35, Chen-Yu Tsai wrote:
> > The ITE IT6505 display bridge can take one I2S input and transmit it
> > over the DisplayPort link.
> >
> > Add #sound-dai-cells (=3D 0) to the binding for it.
> >
> > Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> > ---
> > The driver side changes [1] are still being worked on, but given the
> > hardware is very simple, it would be nice if we could land the binding
> > first and be able to introduct device trees that have this.
> >
> > [1] https://lore.kernel.org/linux-arm-kernel/20230730180803.22570-4-jia=
xin.yu@mediatek.com/
> >
> >  .../devicetree/bindings/display/bridge/ite,it6505.yaml         | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/display/bridge/ite,it650=
5.yaml b/Documentation/devicetree/bindings/display/bridge/ite,it6505.yaml
> > index 348b02f26041..7ec4decc9c21 100644
> > --- a/Documentation/devicetree/bindings/display/bridge/ite,it6505.yaml
> > +++ b/Documentation/devicetree/bindings/display/bridge/ite,it6505.yaml
> > @@ -52,6 +52,9 @@ properties:
> >      maxItems: 1
> >      description: extcon specifier for the Power Delivery
> >
> > +  "#sound-dai-cells":
> > +    const: 0
>
> In such case you also want to $ref /schemas/sound/dai-common.yaml.

Ack. I assume this also means I should change "additionalProperties: false"
to "unevaluatedProperties: false" in this file.

ChenYu

> Best regards,
> Krzysztof
>

