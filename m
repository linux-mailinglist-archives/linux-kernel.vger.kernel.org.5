Return-Path: <linux-kernel+bounces-80452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1281866887
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 04:08:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C37241C2136D
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 03:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CD8D1401B;
	Mon, 26 Feb 2024 03:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ILPuMCdU"
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5874C8C7;
	Mon, 26 Feb 2024 03:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708916821; cv=none; b=gAus0rTo7oeGfA0mg2nyEBeh8MOt0sW0q6ukIo/EN6N4ov88L4P8PnW4idAH36Qcv0/9m/Zgm/wqrdY/e5psonqQkLE1YQlVNpo0bH8G5YUZQZRDzBi1BZc7wEG3ha5vAiD+I/BG04NtarO7jQXLw3LXcbAJC54mFzqbCcylyhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708916821; c=relaxed/simple;
	bh=D7M+/3hboZz+LAxr74MW4UdD46BMltOm9t3uR6FJq4k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fScT3VhVFIcpY5HGuOfIJkUzlL4TQH7qGXqPPPGJlL3YvjxvCVqQvHp8Pr312OL44H8cQWpiTHlkVFIRYSH1joPhi6nt3xAxh9uG72SmNG7gaSpTwTXT+eGZPNj864ua3vK98cX3jzhNyk/7UcPx6qrX9tOKupFnZvad7S77LpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ILPuMCdU; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-7bb5fda069bso161351539f.0;
        Sun, 25 Feb 2024 19:06:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708916819; x=1709521619; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=co4XvUh7TjDQrDAUyyrMDpcdOWgo4eyeIjc6vPe2XRI=;
        b=ILPuMCdUGlv9Fl4ejnAAVP1+pQicI0u3s6qQKfCI3+EUEBxRDluZzOdUJzVTq3LO1x
         /hrOWzNYe2BgovZbtTnTSrAXKRWDuj7IqA6k8oxCMUbTcpQToZPvg1TayH5uI/hcme+d
         pQsFVmHte6MXkdy2j0sniTOppoj0m3wJYRa7jW/r1onRLqYnJn1Yajn4f4Wyc67ac/mL
         AyvfBdLi3izDMocR0gJ5kuedRkc1ov1guH12AEYk11+qCFbHWmH7Wcl5VB7DIMRvS5L8
         aXyY8S667GKVzCBtBkdaLnMulZBh3xY7I7u8NqDtg68NkFSdp5YQ9k1ijcq3zSnQXn1P
         hMVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708916819; x=1709521619;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=co4XvUh7TjDQrDAUyyrMDpcdOWgo4eyeIjc6vPe2XRI=;
        b=LW1y23HWM8KHYqTtfrUbqFNd40KShxX619Q3dRGhx/i5N0G4lVQ5bQOnwC/e+0GDh5
         hTpxBP1daCIbJQDbUW+coFmHtVlIDXvnwC8kv2bJX9GqhohzHKr3LTD2tYtuKpdofUKC
         54+MD2EwzA8JAK2iOzsijpZIoVsQ7+b/j5mXS0zVKYRodSnkPhnUpsynSdjh5DY8IzgG
         kQN7FfSJv6FEIGQWsHR4qsrhTpz/vQvJR6xvRqrDOshQli4fsyyj4wqc4W2pHBmJciLR
         vWbzb8K+zzRE7NP390enF0lpwKrS92FkyfpXgNfqvAq/LzBiMFw/d/SaRT56P8xQyO2w
         9Uew==
X-Forwarded-Encrypted: i=1; AJvYcCXm7QvjrVAiDQawbpbZbqw/Zsi9fLCUwYUafs+AFJ/TPkQ0bc96Mx6T+GNagC5/34XK82KVkqhz+gU5Rv2zH5VAjwvHCm75E+512JtNdgUIOylfCXS+PIA8h4Q3HSdtDT1U3VfUpmWOWA==
X-Gm-Message-State: AOJu0Yy9sCqf6vIVWygxlhVkU79/ztKxW09vM2rrUI+3C31YY/JJo92T
	1kErQAqPOpmRqHxMhPxtBAw4wz+GXsNnt6k7hTIH8fbtJA9ZkRC5RsFz+1JRrpXYzYWjgauhPt2
	N0m3RKdIzaa8NpS/PwmryuNp/ZU2UqG42
X-Google-Smtp-Source: AGHT+IF4B/X5wDlBK5ZE6nu0kabAtnKZd0CLt6Zmf82VAKpv4y+0nWbEQbBgs0SXoVfnZXL/yyJsBcb46bUJReWjsfI=
X-Received: by 2002:a92:ce4e:0:b0:364:21b0:6050 with SMTP id
 a14-20020a92ce4e000000b0036421b06050mr6842464ilr.6.1708916818961; Sun, 25 Feb
 2024 19:06:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1708675339-8180-1-git-send-email-shengjiu.wang@nxp.com> <1786327.VLH7GnMWUR@steina-w>
In-Reply-To: <1786327.VLH7GnMWUR@steina-w>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Mon, 26 Feb 2024 11:06:48 +0800
Message-ID: <CAA+D8AMU69B1Bf3tbbvtkJz_pYY0VNaQMhBXxZvDYug=_DHxYg@mail.gmail.com>
Subject: Re: [PATCH 1/2] arm64: dts: imx8mp-evk: Add HDMI audio sound card support
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, 
	festevam@gmail.com, linux-imx@nxp.com, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Shengjiu Wang <shengjiu.wang@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 23, 2024 at 5:06=E2=80=AFPM Alexander Stein
<alexander.stein@ew.tq-group.com> wrote:
>
> Hi,
>
> thanks for the patch.
>
> Am Freitag, 23. Februar 2024, 09:02:18 CET schrieb Shengjiu Wang:
> > The AUD2HTX is a digital module that provides a bridge between
> > the Audio Subsystem and the HDMI RTX Subsystem. This
> > module includes intermediate storage to queue SDMA transactions
> > prior to being synchronized and passed to the HDMI
> > RTX Subsystem over the Audio Link.
> >
> > AUD2HTX works as the cpu dai in HDMI audio sound card.
> >
> > Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> > ---
> >  arch/arm64/boot/dts/freescale/imx8mp-evk.dts | 12 ++++++++++++
> >  arch/arm64/boot/dts/freescale/imx8mp.dtsi    | 10 ++++++++++
> >  2 files changed, 22 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts b/arch/arm64/=
boot/dts/freescale/imx8mp-evk.dts
> > index f87fa5a948cc..63f6e72fa18a 100644
> > --- a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
> > +++ b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
> > @@ -138,6 +138,14 @@ simple-audio-card,codec {
> >
> >       };
> >
> > +     sound-hdmi {
> > +             compatible =3D "fsl,imx-audio-hdmi";
> > +             model =3D "audio-hdmi";
> > +             audio-cpu =3D <&aud2htx>;
> > +             hdmi-out;
> > +             status =3D "okay";
>
> No need for 'status' here.

ok, will remove it.

>
> Don't you need to configure the PAI as well? See [1]
> for downstream implementation. I'm wondering because I had to hack someth=
ing
> similar. Without I got no HDMI audio.

Yes, the PAI part is needed.
But this commit is just for sound card dts update.

Best regards
Wang shengjiu

>
> Best regards,
> Alexander
>
> [1] https://github.com/Freescale/linux-fslc/blob/6.1-2.0.x-imx/drivers/gp=
u/drm/imx/imx8mp-hdmi-pavi.c#L51-L59
>
> > +     };
> > +
> >       reserved-memory {
> >               #address-cells =3D <2>;
> >               #size-cells =3D <2>;
> > @@ -191,6 +199,10 @@ &A53_3 {
> >       cpu-supply =3D <&reg_arm>;
> >  };
> >
> > +&aud2htx {
> > +     status =3D "okay";
> > +};
> > +
> >  &eqos {
> >       pinctrl-names =3D "default";
> >       pinctrl-0 =3D <&pinctrl_eqos>;
> > diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boo=
t/dts/freescale/imx8mp.dtsi
> > index 9ab9c057f41e..721ab630d895 100644
> > --- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> > +++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> > @@ -1513,6 +1513,16 @@ micfil: audio-controller@30ca0000 {
> >                                       status =3D "disabled";
> >                               };
> >
> > +                             aud2htx: aud2htx@30cb0000 {
> > +                                     compatible =3D "fsl,imx8mp-aud2ht=
x";
> > +                                     reg =3D <0x30cb0000 0x10000>;
> > +                                     interrupts =3D <GIC_SPI 130 IRQ_T=
YPE_LEVEL_HIGH>;
> > +                                     clocks =3D <&audio_blk_ctrl IMX8M=
P_CLK_AUDIOMIX_AUD2HTX_IPG>;
> > +                                     clock-names =3D "bus";
> > +                                     dmas =3D <&sdma2 26 2 0>;
> > +                                     dma-names =3D "tx";
> > +                                     status =3D "disabled";
> > +                             };
> >                       };
> >
> >                       sdma3: dma-controller@30e00000 {
> >
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

