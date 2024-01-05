Return-Path: <linux-kernel+bounces-18359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 897B8825C0B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 22:13:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A71C1F240E3
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 21:13:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C7B522EEA;
	Fri,  5 Jan 2024 21:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="qjy0+Z+e"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D5A7358A4
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 21:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from [192.168.1.114] (unknown [185.145.125.130])
	by mail.ispras.ru (Postfix) with ESMTPSA id 3F35140737A3;
	Fri,  5 Jan 2024 21:13:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 3F35140737A3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1704489208;
	bh=pGz5BeUn1J1tLUOnuc57+4ifZTNHWxB2x2fBLp9vnFE=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
	b=qjy0+Z+eEeWLGd73OAA7npgyIBsdSzQogG9Ujge6ZiMDH75iVPWiQ2OuDGRhXrnCi
	 zdZZCg9KakFJ9uwPfUPyHpNQPjA/N9mcNujSbe4DwUH8ghvo3nxjIQbrQg4Qa3sQWH
	 q5DTuLrHYKxpF7qUt7ZRD7FxSFJH64WiVlyHdOTs=
Subject: Re: [PATCH] therm.c: Adding an array index check before accessing an
 element.
To: Andrey Shumilin <shum.sdl@nppct.ru>, Karol Herbst <kherbst@redhat.com>
Cc: Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@redhat.com>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
 linux-kernel@vger.kernel.org,
 "lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>
References: <20231116063028.35871-1-shum.sdl@nppct.ru>
From: Alexey Khoroshilov <khoroshilov@ispras.ru>
Message-ID: <5be85b32-7339-d306-897e-142332807c9b@ispras.ru>
Date: Fri, 5 Jan 2024 20:50:34 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20231116063028.35871-1-shum.sdl@nppct.ru>
Content-Type: text/plain; charset=utf-8
Content-Language: ru-RU
Content-Transfer-Encoding: 7bit

> Subject: therm.c: Adding an array index check before accessing an element.

As

$ git log --oneline drivers/gpu/drm/nouveau/nvkm/subdev/bios/therm.c
a215721fb64e drm/nouveau/bios/therm: pointers are 32-bit
46484438ab7d drm/nouveau/bios: convert to new-style nvkm_subdev
7f5f518fd70b drm/nouveau/bios: remove object accessor functions
60b29d207179 drm/nouveau/bios: switch to subdev printk macros
9ace404b1098 drm/nouveau/device: include core/device.h automatically for
subdevs/engines
d390b48027f8 drm/nouveau/bios: namespace + nvidia gpu names (no binary
change)
c39f472e9f14 drm/nouveau: remove symlinks, move core/ to nvkm/ (no code
changes)

shows, a better prefix should be
drm/nouveau/bios: or drm/nouveau/bios/therm:
and there should not be a dot at the end.

e.g.
drm/nouveau/bios: avoid invalid memory memory access in
nvbios_therm_fan_parse()


On 16.11.2023 09:30, Andrey Shumilin wrote:
> It is possible to access an element at index -1 if at the first iteration of the loop the result of switch is equal to 0x25
> 


If nvbios_rd08(bios, entry + 0) returns 0x25 before 0x24, buffer
underrun happens as far as &fan->trip[fan->nr_fan_trip - 1] points to
invalid memory.

> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Signed-off-by: Andrey Shumilin <shum.sdl@nppct.ru>
> ---
>  drivers/gpu/drm/nouveau/nvkm/subdev/bios/therm.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/bios/therm.c b/drivers/gpu/drm/nouveau/nvkm/subdev/bios/therm.c
> index 5babc5a7c7d5..78387053f214 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/bios/therm.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/bios/therm.c
> @@ -180,6 +180,8 @@ nvbios_therm_fan_parse(struct nvkm_bios *bios, struct nvbios_therm_fan *fan)
>  			cur_trip->fan_duty = duty_lut[(value & 0xf000) >> 12];
>  			break;
>  		case 0x25:
> +			if (fan->nr_fan_trip == 0)
> +				fan->nr_fan_trip++;

I would suggest to return -EINVAL if the assumption on valid nr_fan_trip
is failed.


>  			cur_trip = &fan->trip[fan->nr_fan_trip - 1];
>  			cur_trip->fan_duty = value;
>  			break;
> 

--
Alexey

