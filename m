Return-Path: <linux-kernel+bounces-131899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66D31898D83
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 19:51:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02DA3B25F68
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 17:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1858812CD9C;
	Thu,  4 Apr 2024 17:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ndufresne-ca.20230601.gappssmtp.com header.i=@ndufresne-ca.20230601.gappssmtp.com header.b="Q1FML0sB"
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A981C6BC
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 17:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712252479; cv=none; b=Pz9t6ldMbX2giKfKRHOUy3/h6Oy17+3JFuOp665GLJQp49yCHnprO7WOPe+zX6QLW5iMLemnsdjcDOZ2Aj6LuemuqiaacGBARePZ0dcOyCpKoJhi4QRY0mhWSV183a9b7r/jmZ6V5PHgsbNE2neFJK+cUCHojahgnBHjqo6pgZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712252479; c=relaxed/simple;
	bh=OA/jUJ05jo1vzjvMVzohJkoM+kxDKZwUgLxh7dqwh/8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cqY1wn5QxqrOg3aaZnJLe8Uu9IzYjtNn5vE39bBMmvuZ3cBBkQZrRfw7f1eqA6EddDgtdd2qPzGLIiiTxYQJMlTeZCR30faGsWa706cckVn6MFtoBl1QdJa8BiaEyLKRZNdkvA53/U9IlmKe6l3Cws4AjXJlJuLkpIcbO/Pv5aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ndufresne.ca; spf=none smtp.mailfrom=ndufresne.ca; dkim=pass (2048-bit key) header.d=ndufresne-ca.20230601.gappssmtp.com header.i=@ndufresne-ca.20230601.gappssmtp.com header.b=Q1FML0sB; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ndufresne.ca
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ndufresne.ca
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-6e50e8dcc72so617648a34.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 10:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20230601.gappssmtp.com; s=20230601; t=1712252476; x=1712857276; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PDCUlJMzIv/laHrjUCGrOmU4Uxm0ZKwh32oebCX4CUg=;
        b=Q1FML0sBLXmGl3v6o2JEGhd2xRFrZpCt5PAkmRiaRIMw6TBqJRx1IEXwlSGUBWeLcD
         KbDNPwEKJPBddDS0n2202LGIG8D+eWpbbeN93ZM1bmTeiguI7C5bErEjQpRJ/xIOJ1F8
         CQ2jIs99jQPiQkDxmGcG0MDQDyLiUFgsgsYGzo7nrlkbHQuFuG5NDx6AUewN766NXOzB
         5NOHjyF1lVEhI2Ucy1NBBS6+S3g+iK0fimg2DmJkaiKr5FvHz2/nP2AJ62OQ/iI4CvQy
         xgM2FgzfpFzPBOZUMv3D00kQsDOHy4bYddfvU7Ic6jG40oQ542gDftE6/egs1LhRiDCB
         B1dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712252476; x=1712857276;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PDCUlJMzIv/laHrjUCGrOmU4Uxm0ZKwh32oebCX4CUg=;
        b=JN1Sk7C32TZBBOiC47BvRyyl0Y5GGYrM8DC3253k6brXtDGuC3DLyfRnza7EFUgT2o
         yDqnyLg0ZZqwfFYXdOBVtMre6IcpNfkELNIXhUWFQ8NIHndCpCXIqqsJKjlXo6umnYVy
         GgA8142smunuonNB62vHrQZBGCDZfMWWJBdTm6oOmAdfqdGJyDoEoRum6YXYrz82tmAi
         IBrIsTR3mAGTE0DMpAQrVP0J//z7d695DsPyxE9chxDnsUvaVYeF7lAfsreZnJBCZsqL
         IPw2l4EMLeLyqoYT5VxRAr2Zic4U+J3kuYpwRHccsU2V86/ErHq6JKMPBe3kbCJHcg2p
         WZ6g==
X-Forwarded-Encrypted: i=1; AJvYcCUVgkKdMSRbEy5ZmNeMLAWGuBJ2j+DG2hXzf94YHGYu54Lbf9iPVF9VGCT7jBG5t5IAC5klIu9iVLEGn3V+pmMKbuDQNTlXD3oVuTzE
X-Gm-Message-State: AOJu0YyKwuonnWgTpEaT+XTlvL6UCaiU0v5col/6gdnRbkNzb/E3JL8C
	EuT0GtMT41IqGtU8YUHQHKgd3x1tUi7MyRC2RM0DB+A7tBjbkl0wJeunNw+Djf1+0DMnweTzwKi
	ZNog=
X-Google-Smtp-Source: AGHT+IH6SPgr9ERE/vwlY2jNucRJ8k5kekJ4QNJCT/jjb/z1ac1mW4/lQwO5MYeuUEjOj8KsCc0l4g==
X-Received: by 2002:a05:6870:c194:b0:22e:15fd:e247 with SMTP id h20-20020a056870c19400b0022e15fde247mr3396329oad.5.1712252476562;
        Thu, 04 Apr 2024 10:41:16 -0700 (PDT)
Received: from nicolas-tpx395.localdomain ([2606:6d00:17:6448:fa75:a4ff:fe45:b56])
        by smtp.gmail.com with ESMTPSA id l13-20020a37f50d000000b0078a4d950935sm6051176qkk.12.2024.04.04.10.41.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 10:41:16 -0700 (PDT)
Message-ID: <bbcb66e9499120a86b367e7abdac2d8e2e704bfb.camel@ndufresne.ca>
Subject: Re: [PATCH v2 0/2] Enable JPEG encoding on rk3588
From: Nicolas Dufresne <nicolas@ndufresne.ca>
To: Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>, 
	linux-kernel@vger.kernel.org
Cc: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>, Philipp Zabel
 <p.zabel@pengutronix.de>, Mauro Carvalho Chehab <mchehab@kernel.org>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Heiko Stuebner <heiko@sntech.de>, Joerg Roedel <joro@8bytes.org>, Will
 Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Sebastian
 Reichel <sebastian.reichel@collabora.com>,  Cristian Ciocaltea
 <cristian.ciocaltea@collabora.com>, Dragan Simic <dsimic@manjaro.org>,
 Shreeya Patel <shreeya.patel@collabora.com>, Chris Morgan
 <macromorgan@hotmail.com>, Andy Yan <andy.yan@rock-chips.com>, Nicolas
 Frattaroli <frattaroli.nicolas@gmail.com>,  linux-media@vger.kernel.org,
 linux-rockchip@lists.infradead.org,  devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,  iommu@lists.linux.dev
Date: Thu, 04 Apr 2024 13:41:15 -0400
In-Reply-To: <20240327134115.424846-1-linkmauve@linkmauve.fr>
References: <20240327134115.424846-1-linkmauve@linkmauve.fr>
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

Hi,

Le mercredi 27 mars 2024 =C3=A0 14:41 +0100, Emmanuel Gil Peyrot a =C3=A9cr=
it=C2=A0:
> Only the JPEG encoder is available for now, although there are patches
> for the undocumented VP8 encoder floating around[0].

[0] seems like a broken link. The VP8 encoder RFC is for RK3399 (and Hantro=
 H1
posted by ST more recently). The TRM says "VEPU121(JPEG encoder only)", whi=
ch
suggest that the H.264 and VP8 encoders usually found on the VEPU121 are
removed. As Rockchip have remove the synthesize register while modifying th=
e H1
IP, it is difficult to verify. Confusingly the H.264 specific registers are
documented in the TRM around VEPU121.

>=20
> This has been tested on a rock-5b, resulting in four /dev/video*
> encoders.  The userspace program I=E2=80=99ve been using to test them is
> Onix[1], using the jpeg-encoder example, it will pick one of these four
> at random (but displays the one it picked):
> % ffmpeg -i <input image> -pix_fmt yuvj420p temp.yuv
> % jpeg-encoder temp.yuv <width> <height> NV12 <quality> output.jpeg

I don't like that we exposing each identical cores a separate video nodes. =
I
think we should aim for 1 device, and then multi-plex and schedule de cores=
 from
inside the Linux kernel.

Not doing this now means we'll never have an optimal hardware usage
distribution. Just consider two userspace software wanting to do jpeg encod=
ing.
If they both take a guess, they may endup using a single core. Where with p=
roper
scheduling in V4L2, the kernel will be able to properly distribute the load=
 I
insist on this, since if we merge you changes it becomes an ABI and we can'=
t
change it anymore.

I understand that this impose a rework of the mem2mem framework so that we =
can
run multiple jobs, but this will be needed anyway on RK3588, since the rkvd=
ec2,
which we don't have a driver yet is also multi-core, but you need to use 2 =
cores
when the resolution is close to 8K.

Nicolas

>=20
> [0] https://patchwork.kernel.org/project/linux-rockchip/list/?series=3D78=
9885
> [1] https://crates.io/crates/onix
>=20
> Changes since v1:
> - Dropped patches 1 and 4.
> - Use the proper compatible form, since this device should be fully
>   compatible with the VEPU of rk356x.
> - Describe where the VEPU121 name comes from, and list other encoders
>   and decoders present in this SoC.
> - Properly test the device tree changes, I previously couldn=E2=80=99t si=
nce I
>   was using a too recent version of python-jsonschema=E2=80=A6
>=20
> Emmanuel Gil Peyrot (2):
>   media: dt-binding: media: Document rk3588=E2=80=99s VEPU121
>   arm64: dts: rockchip: Add VEPU121 to rk3588
>=20
>  .../bindings/media/rockchip,rk3568-vepu.yaml  |  8 +-
>  arch/arm64/boot/dts/rockchip/rk3588s.dtsi     | 80 +++++++++++++++++++
>  2 files changed, 86 insertions(+), 2 deletions(-)
>=20


