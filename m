Return-Path: <linux-kernel+bounces-135112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBC6989BB4D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 11:12:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2EA01B231E0
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 09:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B9E440871;
	Mon,  8 Apr 2024 09:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="e4yCBNH3"
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C79AD3D984
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 09:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712567541; cv=none; b=unkAYpEmcC+L5DruQeuhNIisZRcLXqLLqVCqATlU+encIWeTpuUY6xEJipKW4ahCl8P/+x2oRqse4Pw+8K3y8moEm4Ub38Ce9HsGI7sMOP0fVfnczcTbAdQ2yWr8ro6qkotLEWJQ1198zbyITG47aKiVkWUzRtT5yaNCuz/Wiqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712567541; c=relaxed/simple;
	bh=enur1LOj5KqyFC0kP8B0ViXTcPnakLNndi4E8TWOHLI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sp0MFqDt5d/6TsQBS1s0P28vOOQeX3JUOTHa4HL7prNYrqkGnAAAyyCK87WTs4QknrOc2NuPQgRy1bEKMgaAG7eEX+HZepLv4FHjxHdE3uN1dt7PFJe6TjWxbO5L6JwdrD8f10fMVN1mEizCVS+gql7a2KguFJ8VbcEKiNyXaTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=e4yCBNH3; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-78a66ba49dcso254022885a.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 02:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1712567534; x=1713172334; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BQ7k7b7gOG5IXFP+GFgEExqu4kGvcRryxWmlkgqGSi4=;
        b=e4yCBNH3oWFW/60oHJQTx3qR4gYtErYThg98QmeV85Ls3McfcqBcgU13b/hHJHV/ou
         sVZzQfMDcAEWIwU2WNC/TyDdSE/jXMtx1loEyqc+t7zmoWl0bT0+dmjME1e4cEPfPdW2
         UCiZCin77UWtZ2kB/Ta8c9iwAng5KBftysp50=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712567534; x=1713172334;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BQ7k7b7gOG5IXFP+GFgEExqu4kGvcRryxWmlkgqGSi4=;
        b=ApRU1vlyOyZ24L9bCvugIZDjattYytvg2cmEkTNsx6W26ZZU1bsAH8yRH3Zce4+zL9
         P/Dfm4nKqyQcHJy3yAnSVnEYAc6H08H99vaa+QuqD8nlKy7Ya8iAAUW58KRAr1KZwLTj
         yikrp3fQ4u3XDL86dinB/UABmjWQEgFNMZC3YZto2PbSK20GWaN/0vh8jpUtVDClimZI
         ID/r/GkSSbfozx86qlZ4dPRaeTMrG/Ke/ZuQ1oZuw8XOmTzfS7sQP7nkagYIb8yheT1u
         FceFF1iQK45e28rEGfiM8jG5vWBiJKyshd4J1ivBNZrQWKMoyEvwsSJ4kFoddhM3h86R
         oi0w==
X-Forwarded-Encrypted: i=1; AJvYcCU8c8cx1/wPxjZ0JPgRifsRLMB3J1lk6clGwzvcTGKyG9HPcgGghtvbWV58FCqkKNeBLdgoYTG9JJ1/IZcGu1JCHLqK0KMOwshyPIwx
X-Gm-Message-State: AOJu0YzXKgWzClKTKpzumvAWPbSmI+uVVvZvquEmMAFDFKmZWWe4DZnD
	ss56GV10FkBZg3DLIohQOA9jW1F0lpPaCXqOOfd6IuXQkQHQGQerGwZAWCHPE3MPa2NAVMiMLl8
	OeA==
X-Google-Smtp-Source: AGHT+IETjr38yupRE9ztUrJ4+AFQwQtMZwwwi1uqDsMjneC1HkmsZOvjke04UJCsW1SQwWo2YPh/Rw==
X-Received: by 2002:a05:620a:5233:b0:789:f0ac:1b5d with SMTP id dc51-20020a05620a523300b00789f0ac1b5dmr7944499qkb.34.1712567533774;
        Mon, 08 Apr 2024 02:12:13 -0700 (PDT)
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com. [209.85.160.171])
        by smtp.gmail.com with ESMTPSA id dw16-20020a05620a601000b0078d441bb2c2sm3060289qkb.48.2024.04.08.02.12.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Apr 2024 02:12:12 -0700 (PDT)
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-42ee0c326e8so376871cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 02:12:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXEHUcnKIUPmqX0gFwitJaYxmXrj+dk5fDhZP176x8ASvKmXDBl42oiFW/wgtBRsVX8wMnRzdDEK5HfhMOlfd4ScND/roKZ1x5B7wj2
X-Received: by 2002:a05:622a:6085:b0:431:5aa3:313f with SMTP id
 hf5-20020a05622a608500b004315aa3313fmr266078qtb.11.1712567529634; Mon, 08 Apr
 2024 02:12:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240327085250.3427496-1-wenst@chromium.org> <171156080808.3681700.13600868771478432605.robh@kernel.org>
In-Reply-To: <171156080808.3681700.13600868771478432605.robh@kernel.org>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 8 Apr 2024 02:11:54 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XqHwS9csZaY7fa1p55gFPBbdq7tcf6exjp+qjLGb32RQ@mail.gmail.com>
Message-ID: <CAD=FV=XqHwS9csZaY7fa1p55gFPBbdq7tcf6exjp+qjLGb32RQ@mail.gmail.com>
Subject: Re: [PATCH v2] dt-bindings: display: bridge: it6505: Add #sound-dai-cells
To: Rob Herring <robh@kernel.org>, Chen-Yu Tsai <wenst@chromium.org>
Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, dri-devel@lists.freedesktop.org, 
	Maxime Ripard <mripard@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Daniel Vetter <daniel@ffwll.ch>, Robert Foss <rfoss@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, Jonas Karlman <jonas@kwiboo.se>, 
	Andrzej Hajda <andrzej.hajda@intel.com>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Mar 27, 2024 at 10:33=E2=80=AFAM Rob Herring <robh@kernel.org> wrot=
e:
>
>
> On Wed, 27 Mar 2024 16:52:48 +0800, Chen-Yu Tsai wrote:
> > The ITE IT6505 display bridge can take one I2S input and transmit it
> > over the DisplayPort link.
> >
> > Add #sound-dai-cells (=3D 0) to the binding for it.
> >
> > Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> > ---
> > Changes since v1 [1]:
> > - Reference /schemas/sound/dai-common.yaml
> > - Change "additionalProperties: false" to "unevaluatedProperties: false=
"
> >
> > The driver side changes [2] are still being worked on.
> >
> > [1] https://lore.kernel.org/dri-devel/20240126073511.2708574-1-wenst@ch=
romium.org/
> > [2] https://lore.kernel.org/linux-arm-kernel/20230730180803.22570-4-jia=
xin.yu@mediatek.com/
> > ---
> >  .../devicetree/bindings/display/bridge/ite,it6505.yaml    | 8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
> >
>
> Reviewed-by: Rob Herring <robh@kernel.org>

Pushed to drm-misc-next:

325af1bef5b9 dt-bindings: display: bridge: it6505: Add #sound-dai-cells

