Return-Path: <linux-kernel+bounces-97890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EFD79877135
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 13:51:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AAAB281B0E
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 12:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 406173BBD8;
	Sat,  9 Mar 2024 12:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="I2F8pFDs"
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D03E21BDF4
	for <linux-kernel@vger.kernel.org>; Sat,  9 Mar 2024 12:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709988661; cv=none; b=rTu+sgFA/1Ce2HXeqzYGPbCpZ1BXThqNghJzW4WMbxPTJlCP/JCjdkXbw3EbgMWf7O/GZfoHZfbgFVBM3oEpZYh5mk2YYxOC8d/C/I4MddOU00u2DSB06BCpo/GTl7riY7+atLUfTBlARk/51qdHUxlCnKRpl9v/n7LGq7BVyyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709988661; c=relaxed/simple;
	bh=4V9xgRJtIxeDbMzKIrPVPo05iJQHnN0c6lIUZl7V4V8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VkMoqbV5JaUcvYlFnZelmZaBFeKnNHSp7UohUYcFlVoHVP5WXtLY3/1Au3er2zZXOUK0N2uvRRJGRtamzjNtJxfQnOIhwksp1A6ThucSHtBSr9COu2cHhAed4ut0CchbdFt3G3ct1ZUUfDscEHg2psfD9VEnp1IB4Wam0d/ZBXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=I2F8pFDs; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-dcd7c526cc0so2849361276.1
        for <linux-kernel@vger.kernel.org>; Sat, 09 Mar 2024 04:50:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709988659; x=1710593459; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FpdDui4dtfTDgXa3V4vSwAx/FAfCbg9OZ3d9WLKbM+w=;
        b=I2F8pFDsEDfk1zbRegAgqkNgTntvbQTwxtsS8Fipss3PGCCHNBs4j29fRw3eTnR+YX
         DHFI9bnB+TT1EzbH0nDqmiiKiQGExEzSBP+K55nAHW2zHpUexjBEVxeQVF9AdcGXUFVP
         H1P7Ld68tq/336gNPr9KstOjpPOuwFhhEqUE2DW6wYRrYo3pJMI3uy7KEfa6jcHW5GgF
         v2tdmiiyRJ6sMVeuPzg2RsqZi8+g8se7Xc2/W93uVty62ki+PdZ6ftliA63d0s5miXFJ
         CwgHYc39YxPa41qmUs0UOjjL03ZcDSddBeK+jCuisrAkL+7qYSsbmRcTWSyHYT2F+lFm
         klRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709988659; x=1710593459;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FpdDui4dtfTDgXa3V4vSwAx/FAfCbg9OZ3d9WLKbM+w=;
        b=DcEqMXav2j8b5B8160DvPxGDDISmb81iY1OFsl4Y1gXWS5vlWR5Ur1JiAh1+FVLSYB
         DmTkjfKikwSY/LI6F6G0UleSQLdrAzseQOZl8HBj+XAB8g9Tlj7oLvgOBcUOJjEURBiY
         vGnXKXibl6+MwRHsDmL/TkUadepcjUxA7J03Bx6F1bVhqpfzuI6qXD/r+ClkNmMXleeN
         CLYbOMe/bh3B0Ep42nwGnGaZpJTyrwFm3Dt2IurEJRR1D7VzOq7yqwF0Cbswi3TLNTmM
         VEFxsbyQSAMlI8yIq07QABt8lvEINrcT6x54SHTmsV1AAhMmRk5ENRVT7absCYLgGBBK
         Fg8Q==
X-Forwarded-Encrypted: i=1; AJvYcCW+Oi9MSG9T/9L1Rygws9Ha0f/0pvMV8bgFSs2fh/m6nfwmfwvfr2fnhtrGCrmcxlkHwCklWZii22zg0RRQFRQ7YouJy9nWaHPYQoM/
X-Gm-Message-State: AOJu0Yyg+i363QRvEj3mCGNWt+h8OD+9rwqbX1TX832pZo2afmGqKhbI
	lPmQbS3aXoglRSU3u6h0nZfRfTLgnXbPaGt/efMZ3k5uvdvd4P/IjT1KnmjWZCY9tIGyDUgLL54
	JqhGFITZOc2c0wI8GiHmK9YASIONBjSf+9RMC/A==
X-Google-Smtp-Source: AGHT+IGnUYF0gCMHLcf1QFwa56sieLf++DhvZeij5X23g7go7ltIIcQm14JZowxQn+1PenGYypISbvzmUaJpUZPWAgM=
X-Received: by 2002:a25:ac93:0:b0:dc7:8c3a:4e42 with SMTP id
 x19-20020a25ac93000000b00dc78c3a4e42mr1076338ybi.30.1709988658836; Sat, 09
 Mar 2024 04:50:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240307172334.1753343-1-sui.jingfeng@linux.dev>
 <20240307172334.1753343-2-sui.jingfeng@linux.dev> <CAA8EJpp8tsHi0RhsJXG+r6nOsV3AUC_n6jNHL0Cr6Ku2h3NMog@mail.gmail.com>
 <45f59f31-1f03-4a96-adb6-25c7cdd5e8a1@linux.dev> <CAA8EJpqq1-cEke6wEFZFDnpz4tFBcL6HF3=Qtf-8Q3WbogLS8A@mail.gmail.com>
 <c84fcdba-af50-4212-a8e3-f492c2b02ce4@linux.dev> <CAA8EJppTcPO3j7GpGcGbKPUjQ=3rTMMOrU1SYR3mtkWLztf2qQ@mail.gmail.com>
 <7535b3ba-6bbb-411c-82a4-cd4ac45de1a6@linux.dev> <CAA8EJpp3yd33pYweL_exrXMJ3g-m7-yjJrjiVMVMevOadBtt8g@mail.gmail.com>
 <b573ec32-fe07-498c-abe7-f9a16bdc1c21@linux.dev>
In-Reply-To: <b573ec32-fe07-498c-abe7-f9a16bdc1c21@linux.dev>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sat, 9 Mar 2024 14:50:47 +0200
Message-ID: <CAA8EJpo1Zk5Z80Jh24ygJH-djfHrLK7wVC8AFe99AOetWpmUgw@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] drm/bridge: Add fwnode based helpers to get the
 next bridge
To: Sui Jingfeng <sui.jingfeng@linux.dev>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Robert Foss <rfoss@kernel.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
	Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Phong LE <ple@baylibre.com>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 9 Mar 2024 at 13:25, Sui Jingfeng <sui.jingfeng@linux.dev> wrote:
>
> Hi,
>
>
> On 2024/3/9 18:39, Dmitry Baryshkov wrote:
> > On Sat, 9 Mar 2024 at 11:33, Sui Jingfeng <sui.jingfeng@linux.dev> wrot=
e:
> >> Hi,
> >>
> >>
> >> On 2024/3/8 04:40, Dmitry Baryshkov wrote:
> >>>>> But really, there is nothing so hard about it:
> >>>>> - Change of_node to fw_node, apply an automatic patch changing this=
 in
> >>>>> bridge drivers.
> >>>>> - Make drm_of_bridge functions convert passed of_node and comp
> >>>>>
> >>>>> After this we can start cleaning up bridge drivers to use fw_node A=
PI
> >>>>> natively as you did in your patches 2-4.
> >>>> Yes, it's not so hard. But I'm a little busy due to other downstream=
 developing
> >>>> tasks. Sorry, very sorry!
> >>>>
> >>>> During the talk with you, I observed that you are very good at fwnod=
e domain.
> >>>> Are you willing to help the community to do something? For example, =
currently
> >>>> the modern drm bridge framework is corrupted by legacy implement, is=
 it possible
> >>>> for us to migrate them to modern? Instead of rotting there? such as =
the lontium-lt9611uxc.c
> >>>> which create a drm connector manually, not modernized yet and it's D=
T dependent.
> >>>> So, there are a lot things to do.
> >>> Actually, lontium-lt9611uxc.c does both of that =F0=9F=98=89 It suppo=
rts
> >>> creating a connector and it as well supports attaching to a chain
> >>> without creating a connector. Pretty nice, isn't it?
> >>
> >> But why the drm_bridge_connector helpers and/or the drm_connector brid=
ge can't suit you need?
> >> Coding this way just add boilerplate into drm bridge subsystem, right?
> > Because there are platforms, like iMX LCDIF which can use the
> > lt9611uxc bridge, but do not make use of the drm_bridge_connector yet.
> >
>
> Well, I have just grepped across the drm-tip kernel branch, but I don't f=
ind
> iMX LCDIF you mentioned. See the search results pasted at bellow.

Please take a look at the commit 8ddce13ae696 ("drm/bridge: lt9611: Do
not generate HFP/HBP/HSA and EOT packet"). As you can see from the
description, Marek has been using this bridge with th iMX8MM / iMX8MP
boards. As soon as mxsfb has been updated to pass
DRM_BRIDGE_ATTACH_NO_CONNECTOR, we can drop corresponding code from
LT9611UXC driver.

> $ find . -name "*.dts" -type f | xargs grep "lontium,lt9611uxc"
> ./arm64/boot/dts/qcom/sm8450-hdk.dts:           compatible =3D "lontium,l=
t9611uxc";
> ./arm64/boot/dts/qcom/qrb5165-rb5.dts:          compatible =3D "lontium,l=
t9611uxc";
> ./arm64/boot/dts/qcom/qrb2210-rb1.dts:          compatible =3D "lontium,l=
t9611uxc";
> ./arm64/boot/dts/qcom/qrb4210-rb2.dts:          compatible =3D "lontium,l=
t9611uxc";
> ./arm64/boot/dts/qcom/sm8350-hdk.dts:           compatible =3D "lontium,l=
t9611uxc";
>
>
> So I can't see the drm driver that you refer to, can you pointed it out f=
or study
> purpose? Even it's exist, however, back to that time, why don't you posti=
ng a patch
> to switch it to the canonical design as you mentioned and give the commun=
ity a clean
> design?

If you have iMX8 hardware, please do it. I don't have these boards and
I do not have an intention of acquiring them.

> And those are just *reasons*, from the viewpoint of the *result*.
> The merged patch results in a 'side-by-side' implement and boilerplate ad=
ded
> into drm bridges subsystem, the results doesn't change no matter what the
> reason is, right?

--=20
With best wishes
Dmitry

