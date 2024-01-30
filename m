Return-Path: <linux-kernel+bounces-43891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEBA2841A76
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 04:23:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F745B25D5A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 03:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2541838388;
	Tue, 30 Jan 2024 03:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MgaQho1x"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A71AE374CC
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 03:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706584933; cv=none; b=FJWZjRcCcXjbLV1lTk0RDuKv1tyyT0tHp1KjANw9Ij9GyUcWnEh/QPD2wEDcpCrLHi5HeqG6aV3QToeB1do/u8XnTaNkgP6+RutoiQvCyAtFMINJY5MQL0RBnc48Qitt7L71VuqnfpdShkqz/P6CNgnnOQsi6DNJQponB2Z3JWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706584933; c=relaxed/simple;
	bh=hTM78LElmEuXY/I156Tkd5M/VZBKoB4TqBIat3HtxZg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kW+9zmvvy2vF0KNZbbq5PS0+UW/1OHqR1Pim8mg0JLWM9EPGg6xUsAOQAhx4Tmxe/J1P/sTZN1QahPNZS4yJi9aLR56H9YWvM8ML2nexWcLCBu/TeG/aDe9DWGwE2TTAzPvkTyGFPqlEB5LlCkdpWfiFXjcht9f8AnBMyaX8q6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=MgaQho1x; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-510221ab3ebso4717162e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 19:22:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706584930; x=1707189730; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vFwOvzgohKdirNbIQVbbIr9nG1jrmQvUigB0XE0d7lE=;
        b=MgaQho1xyuLg0nB6gIHfubFoaukRIexbldbqdYB9rPgXAwxhFV0Ln8aNtHkoC0LKRb
         Va4ACOlReucTtBN07oO7hO2ZwIRXYqiiejW23ABy+CvgQ/42A1WdcFI/9lMNvFMj4Q0G
         kpPijt+Oc1/bVwtI5EGqw4CNXxVhJ9vr+GVls=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706584930; x=1707189730;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vFwOvzgohKdirNbIQVbbIr9nG1jrmQvUigB0XE0d7lE=;
        b=UPu83QHBYVbNmm+iqNnndKizfHrlZa/HAsVkYokL08oEleCcjiGnR9prYPd/jeiwsW
         UgEyi2UkVYNyx177j37VpwP6F3llNtodQtoVZAj6MPgoqw7V3YdX9FfKwSagEzIzPWOv
         jLWhd8FDfF2peduJMLG9UHJCkDAeXLu2dVHekAMVElOUt8AKSB3fGY+fwb/u5Vb3jqRW
         gMY2j4fPi4OkPXiIOLolaYYctJ7E+kd/UityrJ+H9nlf0Y2UyN4m9gJmfeLl7y9MKmIV
         Ihw5PC++1eK9Ty3gSc+iQD9XrnMJLQCIzEqBWG4jcU6BQcAVAdWEkwrzbGdm0DuAImIS
         F3pw==
X-Gm-Message-State: AOJu0YzrmfuYOVyC6QlExn97/yVjj3ZHOk+PloLCjUU5lyKwZ2HW/8Z7
	I9ULIsbeSiflj/v8D6paAx+vU8vOqb6llqsoA+YxCD5M9uVqaSbY1BsZt0gYJ+XyLySWdm+lu8B
	HdpwfKxOT3OhEwicdUXUW6lTML5UWuv6nRcqV
X-Google-Smtp-Source: AGHT+IEL+eB3YpLwGh9C//tICADm74yD1KdefrBuKQSDktUlLhN43MqFdTiiqm0CjqgVnyYHjaOuXC+S0wL0bQ0K82Y=
X-Received: by 2002:a05:6512:3054:b0:511:150f:6363 with SMTP id
 b20-20020a056512305400b00511150f6363mr2506060lfb.32.1706584929429; Mon, 29
 Jan 2024 19:22:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240126063500.2684087-1-wenst@chromium.org> <20240126063500.2684087-3-wenst@chromium.org>
 <2c37a716-e4bb-4db3-a95f-a40e05b28cad@molgen.mpg.de>
In-Reply-To: <2c37a716-e4bb-4db3-a95f-a40e05b28cad@molgen.mpg.de>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Tue, 30 Jan 2024 11:21:58 +0800
Message-ID: <CAGXv+5H_Rmy1-38xhG48RWW8B9a4K3P0UO=ThUFYjc8T6WT2OA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] arm64: dts: mediatek: mt8183-pico6: Fix bluetooth node
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	Angelo Gioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Sean Wang <sean.wang@mediatek.com>, linux-bluetooth@vger.kernel.org, 
	netdev@vger.kernel.org, linux-mediatek@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 30, 2024 at 12:31=E2=80=AFAM Paul Menzel <pmenzel@molgen.mpg.de=
> wrote:
>
> Dear Chen-Yu,
>
>
> Thank you for your patch.
>
> Am 26.01.24 um 07:34 schrieb Chen-Yu Tsai:
> > Bluetooth is not a random device connected to the MMC/SD controller. It
> > is function 2 of the SDIO device.
> >
> > Fix the address of the bluetooth node. Also fix the node name and drop
> > the label.
>
> Excuse my ignorance: Is this a cosmetic fix or does it fix the device
> somehow?

It's a cosmetic change, since the driver already searches the whole device
tree for the specific compatible string. However it also fixes the device
tree description to match the actual hardware.

> > Fixes: 055ef10ccdd4 ("arm64: dts: mt8183: Add jacuzzi pico/pico6 board"=
)
> > Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> > Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>
> > ---
> > Changes since v1:
> > - Collected reviewed-by
> >
> >   arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-pico6.dts | 3 ++-
> >   1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-pico6.dt=
s b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-pico6.dts
> > index a2e74b829320..6a7ae616512d 100644
> > --- a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-pico6.dts
> > +++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-pico6.dts
> > @@ -82,7 +82,8 @@ pins-clk {
> >   };
> >
> >   &mmc1 {
> > -     bt_reset: bt-reset {
> > +     bluetooth@2 {
> > +             reg =3D <2>;
>
> To avoid confusion, would it be possible to use sdio as a =E2=80=9Cname=
=E2=80=9D.

Not sure where the confusion is. Bluetooth is the functionality this
SDIO function provides.

ChenYu

>
> >               compatible =3D "mediatek,mt7921s-bluetooth";
> >               pinctrl-names =3D "default";
> >               pinctrl-0 =3D <&bt_pins_reset>;
>
>
> Kind regards,
>
> Paul

