Return-Path: <linux-kernel+bounces-134245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3A6289AF6F
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 10:09:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AFB4282BDA
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 08:09:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF98111711;
	Sun,  7 Apr 2024 08:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ndufresne-ca.20230601.gappssmtp.com header.i=@ndufresne-ca.20230601.gappssmtp.com header.b="eHA8wJQ9"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E9B10A0E
	for <linux-kernel@vger.kernel.org>; Sun,  7 Apr 2024 08:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712477371; cv=none; b=exr01fm+j6xlIKcUpZr6fQtc9q3HYI0Cb364O+88bzcz9QFVAfiNC5TCVFyVA2KNDGm0IkWdI8QQyXdUa27dCG0w+jLkduf7WrkInjwuKBCjzye4zXkeGVYx7lMPgx8eV/xFcYXS74jT4hu4L16/wMTg6HFg3N3lpGROkaLkHbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712477371; c=relaxed/simple;
	bh=L5AAMQbSoF0YudkIwfBHSSHgJwFQtAS3w22mcBvp7F0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FTPzfxg/w3ZKT2YURq4n3vNNRJOeN4gO0lJdcWri3MuKdzDZAWPBnRN8xLfHfN+VLJVS5QKtE6wpoQO3GKrlqDQOYqg4dVktBheVJzZeRk3edd1aGei1U+gNZvvjw2i2B7PSJ1eEAQqZi+zBIQXqbguUllMGF6EO/z0A2M6XL+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ndufresne.ca; spf=none smtp.mailfrom=ndufresne.ca; dkim=pass (2048-bit key) header.d=ndufresne-ca.20230601.gappssmtp.com header.i=@ndufresne-ca.20230601.gappssmtp.com header.b=eHA8wJQ9; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ndufresne.ca
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ndufresne.ca
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-516d487659bso2729349e87.2
        for <linux-kernel@vger.kernel.org>; Sun, 07 Apr 2024 01:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20230601.gappssmtp.com; s=20230601; t=1712477368; x=1713082168; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RoR1pZo3Vw2aL2foO6O0rlclxwNL4uebAWFaAlNYhYo=;
        b=eHA8wJQ9uOAlvgGF9crKXIBujUfFI8vSlRUb1ZXHo3GQ403c345zGzNuEzJjtl0lkS
         twuQpNRAPaL8yMG4zvdDC/7b/Q2hjCoAwWe0IoPdJMH75O1Du3ghN24qYwe+3GkyL4gI
         c32clIHqfHTSxpfc9EedsOyEeVagsWZRD85h0F/NpYN9Rvxgj8iG+B8tzia8hHCru6zU
         rNXvZwRUuM63hW7PQBls++jCIjEky/wARmijlYSqLPdz6AgMLl9mOpTpe+FA/VPngoe3
         RjACHjgtnz2fwps8NEuvxms7f3NUKPt0Lpfjkaf5QBy4JJtkpODtCYGOjEZe6iODF7b0
         soWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712477368; x=1713082168;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RoR1pZo3Vw2aL2foO6O0rlclxwNL4uebAWFaAlNYhYo=;
        b=fds50cEq1o3ZWhk4/DesBlYamfFRjFMIly9NJoJPywqCjHj+WQygkVxP7aeAVwRGlr
         DEM74XXAuj2ePJgbmdB00myS4RUU3fzBjZoAtEwPOdHz7G3jNojZbyRu9yIBHzihsbGr
         pjmjQwHmLftz5BGWQkCs3foqHhOhqXWdOUUd0bHy2Fda8/zTnHM2aPc7ghHx3rI/DAAt
         X94jE8QSBo6jzcAeh5RAHz4R5NXspzdJNbRMMwO84LLuqWTAax8ouN5KJ9C0UrQNZIhk
         VP+aoXtss3Jka7lesYQrphFKaUL0A5k0VueXjycWUAP7BOmo4AKDrn6GqC6IgQydLOc9
         /Ypg==
X-Gm-Message-State: AOJu0YxqxwpvYsV7lbdGm8OgD1DFAqSnZ1TVeKM4TM7yQ8QsNgncufaX
	oNz+F2EZ+jgqKnNVkrlBNEfLljVlo9c/YyzzLx71faQ5s0rnazqaxZHJkloLiKA=
X-Google-Smtp-Source: AGHT+IH0P9sWNMW1yyWdHET4wFxBLnPE44dQ6iyO/SJlklsjpRQZxUghb+32SdG+wT+lEVbRaNVwUg==
X-Received: by 2002:ac2:4c3c:0:b0:516:d482:d720 with SMTP id u28-20020ac24c3c000000b00516d482d720mr3681790lfq.30.1712477368029;
        Sun, 07 Apr 2024 01:09:28 -0700 (PDT)
Received: from nicolas-tpx395.localdomain (ip-185-104-138-24.ptr.icomera.net. [185.104.138.24])
        by smtp.gmail.com with ESMTPSA id s7-20020adfea87000000b0033e7de97214sm6144093wrm.40.2024.04.07.01.09.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Apr 2024 01:09:27 -0700 (PDT)
Message-ID: <ed0b32ec6da10f46ff5d820612bfe700388fae1e.camel@ndufresne.ca>
Subject: Re: [PATCH v2 0/2] Enable JPEG encoding on rk3588
From: Nicolas Dufresne <nicolas@ndufresne.ca>
To: Link Mauve <linkmauve@linkmauve.fr>
Cc: linux-kernel@vger.kernel.org, Ezequiel Garcia
 <ezequiel@vanguardiasur.com.ar>, Philipp Zabel <p.zabel@pengutronix.de>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>,  Heiko Stuebner <heiko@sntech.de>, Joerg Roedel
 <joro@8bytes.org>, Will Deacon <will@kernel.org>,  Robin Murphy
 <robin.murphy@arm.com>, Sebastian Reichel
 <sebastian.reichel@collabora.com>, Cristian Ciocaltea
 <cristian.ciocaltea@collabora.com>, Dragan Simic <dsimic@manjaro.org>,
 Shreeya Patel <shreeya.patel@collabora.com>, Chris Morgan
 <macromorgan@hotmail.com>, Andy Yan <andy.yan@rock-chips.com>, Nicolas
 Frattaroli <frattaroli.nicolas@gmail.com>,  linux-media@vger.kernel.org,
 linux-rockchip@lists.infradead.org,  devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,  iommu@lists.linux.dev
Date: Sun, 07 Apr 2024 10:08:58 +0200
In-Reply-To: <ZhAI6tQZTD7BTosI@desktop>
References: <20240327134115.424846-1-linkmauve@linkmauve.fr>
	 <bbcb66e9499120a86b367e7abdac2d8e2e704bfb.camel@ndufresne.ca>
	 <ZhAI6tQZTD7BTosI@desktop>
Autocrypt: addr=nicolas@ndufresne.ca; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Le vendredi 05 avril 2024 =C3=A0 16:21 +0200, Link Mauve a =C3=A9crit=C2=A0=
:
> On Thu, Apr 04, 2024 at 01:41:15PM -0400, Nicolas Dufresne wrote:
> > Hi,
>=20
> Hi,
>=20
> >=20
> > Le mercredi 27 mars 2024 =C3=A0 14:41 +0100, Emmanuel Gil Peyrot a =C3=
=A9crit=C2=A0:
> > > Only the JPEG encoder is available for now, although there are patche=
s
> > > for the undocumented VP8 encoder floating around[0].
> >=20
> > [0] seems like a broken link. The VP8 encoder RFC is for RK3399 (and Ha=
ntro H1
> > posted by ST more recently). The TRM says "VEPU121(JPEG encoder only)",=
 which
> > suggest that the H.264 and VP8 encoders usually found on the VEPU121 ar=
e
> > removed. As Rockchip have remove the synthesize register while modifyin=
g the H1
> > IP, it is difficult to verify. Confusingly the H.264 specific registers=
 are
> > documented in the TRM around VEPU121.
>=20
> Ah, the link became, and was indeed ST=E2=80=99s series:
> https://patchwork.kernel.org/project/linux-rockchip/list/?series=3D789885=
&archive=3Dboth
>=20
> But the TRM part 1 says the VEPU121 supports H.264 encoding (page 367),
> and it=E2=80=99s likely they didn=E2=80=99t remove just VP8 support since=
 the codec
> features are pretty close to H.264=E2=80=99s.
>=20
> >=20
> > >=20
> > > This has been tested on a rock-5b, resulting in four /dev/video*
> > > encoders.  The userspace program I=E2=80=99ve been using to test them=
 is
> > > Onix[1], using the jpeg-encoder example, it will pick one of these fo=
ur
> > > at random (but displays the one it picked):
> > > % ffmpeg -i <input image> -pix_fmt yuvj420p temp.yuv
> > > % jpeg-encoder temp.yuv <width> <height> NV12 <quality> output.jpeg
> >=20
> > I don't like that we exposing each identical cores a separate video nod=
es. I
> > think we should aim for 1 device, and then multi-plex and schedule de c=
ores from
> > inside the Linux kernel.
>=20
> I agree, but this should be handled in the driver not in the device
> tree, and it can be done later.

As the behaviour we want is that these cores becomes a group and get schedu=
le
together, its certainly a good time to slow down and evaluate if that part =
needs
to be improve in the DT too.

Hantro G1/H1 and VEPU/VDPU121 combos originally shared the same sram region=
 Its
not clear if any of these cores have this limitation and if this should be
expressed in the DT / driver.

>=20
> >=20
> > Not doing this now means we'll never have an optimal hardware usage
> > distribution. Just consider two userspace software wanting to do jpeg e=
ncoding.
> > If they both take a guess, they may endup using a single core. Where wi=
th proper
> > scheduling in V4L2, the kernel will be able to properly distribute the =
load. I
> > insist on this, since if we merge you changes it becomes an ABI and we =
can't
> > change it anymore.
>=20
> Will it really become ABI just like that?  Userspace should always
> discover the video nodes and their capabilities and not hardcode e.g. a
> specific /dev/videoN file for a specific codec.  I would argue that this
> series would let userspace do JPEG encoding right away, even if in a
> less optimal way than if the driver would round-robin them through a
> single video node, but that can always be added in a future version.

Might be on the gray side, but there is good chances software written for y=
our
specific board can stop working after te grouping is done.

>=20
> >=20
> > I understand that this impose a rework of the mem2mem framework so that=
 we can
> > run multiple jobs, but this will be needed anyway on RK3588, since the =
rkvdec2,
> > which we don't have a driver yet is also multi-core, but you need to us=
e 2 cores
> > when the resolution is close to 8K.
>=20
> I think the mediatek JPEG driver already supports that, would it be ok
> to do it the same way?

I don't know for JPEG, the MTK vcoder do support cascading cores. This is
different from concurrent cores. In MTK architecture, for some of the codec=
,
there is LAT (entropy decoder) and CORE (the reconstruction block) that are
split.

Nicolas

