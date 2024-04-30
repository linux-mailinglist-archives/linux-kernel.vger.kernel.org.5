Return-Path: <linux-kernel+bounces-163693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F9678B6E65
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 11:33:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0DB31C221B1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 09:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 715D8127E31;
	Tue, 30 Apr 2024 09:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dZ4pdO1X"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 600767EEF2
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 09:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714469577; cv=none; b=MAKdX3KEOydFSsesnFGzdvxXsoDYQFOy1tHaBzaqI2sn/pCbfQ3vVC4u4YwBG5mU2Zw09hAgbFB35qykgFpKraqaUTPL2JBpQNII4DqdFj0ct6N4s/GHUCMKct0Iaat/o3udbAqGlb5tzuXsh8OYZz4ZhQEI4Hf1t/H3+ERoLxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714469577; c=relaxed/simple;
	bh=6VlkZ94vfBaUMbJ4oTeQI2QukBnMnA4AUGq7pWtBJas=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qj9mATuFgpED8w8MfRjB5oS2kseV9fUbOPzKdgPGW22kpStjN4CaaWo9pdwPTCKhLXOnb7F0WErdNM7wdXcYdi7ZlMUIISUi1caqWQhQiWHG233fTstSv+YrcuKYEe5/MtNAyv6y47oIm1yaMuK/L4gHcqmewGynfu14u5gXkDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=dZ4pdO1X; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6f2f6142d64so5097164b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 02:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714469575; x=1715074375; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rZ1f3Q6BEnZTJT1SiGVBJeWSactvAosCQCCnwWRZCiM=;
        b=dZ4pdO1X3VrYtmBeozkPKcvwEKLLHpNOO1/jj6Gxv+CY88ZuCneIEcyhceSaRTb74U
         g1JDmpzT+For/q+DLSpyPALFLr4iZj+c2x69/MgfS5X7Wy0qRkvwdm7yE/QMjvVYcV7S
         CTfYB0k8gx+fVmMx5f31PIOoe/LQqL+9JT/F4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714469575; x=1715074375;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rZ1f3Q6BEnZTJT1SiGVBJeWSactvAosCQCCnwWRZCiM=;
        b=fj3MK9B4+NnrLhLIjKSZb35dEkxD/cgQEzZBlPSAIm5d/PWy/wQTqQ3/faErwC4UjO
         EbaO+saeNgmauIu+Lq/ah3Qmre4c+etNEWgGCKbh410MeWBP/ZdttmMsdiXViLd4AsBS
         F5pCPVTteNpozG8gQKy8GRV7JqOOSSGdax3wfUQXF291e52ZNklTBRx1p4/36g2f7UVY
         mIFmgiE0rVl5f11ZOs8i++ag7Tc/hEDFzGA/ujs0saZgcUeUt1TJ5EpDVgGcEDMu+kk5
         m1ZHWannSM/sDqz3UDVNv146Bm/t63VgoceF0O0nkvODCFyI0DHI1ZiB2XHYbyBHl3SV
         aDRQ==
X-Forwarded-Encrypted: i=1; AJvYcCU6iYc7SbFaKwQW1HwSyPUTe6lFVv3O43+0m35gyaoQUTQ9NlNaetJcrAOlOmjvAugdBrhSWhgPphbctS8Iqm0GYPajpFLuaUPxVZMq
X-Gm-Message-State: AOJu0Yw6awxci/6JQcMungCTzIO6sf6Shnt4njsWFSxSqh90+oa+ObfI
	6ACX4VITZ4x0lP/K3P5rYHcerIbf5JMQLecS/DEvOiUcjx4rO848DrlGe1XKrBhAQ7NQsqH5T1H
	uh2s3X6Z6ak5ldnAIlHy6B1wH1wdIUOi/DNMn
X-Google-Smtp-Source: AGHT+IHe4n3YPDXbWHUn5ncUC54LJGZHAP4fN5Liyf2K72GnMccBlNkfMj6dDGsch6IeTojaMR/TVjx0GT+KLwkPyEM=
X-Received: by 2002:a05:6a20:9c8f:b0:1ae:84b3:bb5c with SMTP id
 mj15-20020a056a209c8f00b001ae84b3bb5cmr12622020pzb.1.1714469574691; Tue, 30
 Apr 2024 02:32:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240429095333.3585438-1-treapking@chromium.org> <b3c69a78-78c9-4a15-829b-e4b36e16566a@collabora.com>
In-Reply-To: <b3c69a78-78c9-4a15-829b-e4b36e16566a@collabora.com>
From: Pin-yen Lin <treapking@chromium.org>
Date: Tue, 30 Apr 2024 17:32:43 +0800
Message-ID: <CAEXTbpf2HOQj_AxHGbsgOXVF_HyKttL=z7Mi8QStcmuOS+yN7g@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: mediatek: mt8192-asurada: Add off-on-delay-us
 for pp3300_mipibrdg
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, 
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, 
	"moderated list:ARM/Mediatek SoC support" <linux-arm-kernel@lists.infradead.org>, 
	"moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>, 
	=?UTF-8?B?TsOtY29sYXMgRiAuIFIgLiBBIC4gUHJhZG8=?= <nfraprado@collabora.com>, 
	"open list:ARM/Mediatek SoC support" <linux-kernel@vger.kernel.org>, Hsin-Te Yuan <yuanhsinte@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Angelo,

On Tue, Apr 30, 2024 at 4:17=E2=80=AFPM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Il 29/04/24 11:53, Pin-yen Lin ha scritto:
> > Set off-on-delay-us to 500000 us for pp3300_mipibrdg to make sure it
> > complies with the panel sequence. Explicit configuration on the
> > regulator node is required because mt8192-asurada uses the same power
> > supply for the panel and the anx7625 DP bridge. So powering on/off the
> > DP bridge could break the power sequence requirement for the panel.
> >
> > Fixes: f9f00b1f6b9b ("arm64: dts: mediatek: asurada: Add display regula=
tors")
> > Signed-off-by: Pin-yen Lin <treapking@chromium.org>
> >
>
> Uhm, there might be more to it - I don't think that this should ever happ=
en.
>
> The regulator is refcounted, so...
>   * Bridge on: panel goes off, but regulator doesn't turn off (refcount=
=3D1)
>     * Panel resume -> sequence respected (refcount=3D2 -> wait -> more vr=
egs, etc)
>   * Bridge off: panel is already off (refcount=3D0)
>     * Bridge resume -> refcount=3D1, no panel commands yet

The off-on-delay could be violated because the bridge driver does not
check the delay.

>     * Panel resume -> refcount=3D2, wait -> more vregs, etc
>
> Can you please describe the issue that you're getting?

The symptom we observed is that the device has a small chance to
reboot to a black panel, and we think the panel's unprepare delay (the
time to power down completely) might not be satisfied because the
bridge doesn't check that when it enables the regulator. Even if the
regulator is enabled by the panel driver, the delay can also be
violated in the following sequence:

* t=3D0ms, bridge on: panel goes off, but regulator doesn't turn off
(refcount=3D1). The .unprepared_time in panel_edp is updated
* t=3D300ms, bridge off, regulator goes off (refcount=3D0)
* t=3D600ms, panel on, the panel driver thinks the unprepare delay
(500ms) is satisfied, but the regulator was disabled 300ms ago.

Did I miss anything here? Or should I add more detail to the commit message=
?

>
> Cheers,
> Angelo
>
Regards,
Pin-yen

> > ---
> >
> >   arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi | 1 +
> >   1 file changed, 1 insertion(+)
> >
> > diff --git a/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi b/arch/ar=
m64/boot/dts/mediatek/mt8192-asurada.dtsi
> > index 7a704246678f..08d71ddf3668 100644
> > --- a/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
> > +++ b/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
> > @@ -147,6 +147,7 @@ pp3300_mipibrdg: regulator-3v3-mipibrdg {
> >               regulator-boot-on;
> >               gpio =3D <&pio 127 GPIO_ACTIVE_HIGH>;
> >               vin-supply =3D <&pp3300_g>;
> > +             off-on-delay-us =3D <500000>;
> >       };
> >
> >       /* separately switched 3.3V power rail */
>

