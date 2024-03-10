Return-Path: <linux-kernel+bounces-98334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 932D087788C
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 21:58:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47459281892
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 20:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2144C3A29C;
	Sun, 10 Mar 2024 20:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HYKpUvHk"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE2A35F18;
	Sun, 10 Mar 2024 20:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710104322; cv=none; b=WLYynsibRFmDjoloGr+6iQR3ho2TTstLnIwaTRbdsal+tIapZA9hy4YVxF2PodpLdxw+xFRe6FCktwUaNtuAgFKYljtjc+U0Q44xx1esBK7Z/vS01kxCT45zIXcK78aVp3erA5f0YuAllEaRjq26c3+g03XP5X/bn25i6hITiYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710104322; c=relaxed/simple;
	bh=df3zYH9JJRXQUH2eC715T4ZOO6jiKt0s6CigHRhf0bo=;
	h=Date:To:Cc:Subject:From:References:In-Reply-To:Message-Id:
	 MIME-Version:Content-Type; b=DNJpplzvd7OmvpLd+voW8GqoeUD8MZxX+oiru7cZMORSFNPv+Emvn/3RKdXF4CC8qAVk5SW8Tduty4+j8nRl7dENdCrdcX6N0BfIukJLOYNnNBQ3Wyh8R4G+3/bIBYkfbq6WoG0qcBJuhsSt8mIQD2Hf68vZ0TJjRZdI2miixLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HYKpUvHk; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-56781070f38so8505218a12.0;
        Sun, 10 Mar 2024 13:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710104319; x=1710709119; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:references:from:subject:cc:to:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AdIM06nz++B/9Hlj7waoS5xxV2hFdN+qnGtNubidnNg=;
        b=HYKpUvHkK/UVDzKlLROzWWUcKVKR02bX9sevqS5AwRWrQUv/ettldHsMKeAnEtt7k/
         2NF84Q/uFHTyeZUdEJb3VhcywarrUtSyLn9o6IfWtqvqdEKF5qQDKDJe3G4Ii5dNxoN7
         pKGio8CS/FGep2ejGghwSnL8hqgXSQ4/qFylKikwZjZjY9lDIPljujKkcKW1Z2O4sZw4
         fRKaNTT3xJzlHWKaaoWaRiZ/OvWfJXQmAJfDSg9BdobkZcRpVl1lZR3yreBDrCaENm44
         lfi8ycZYlOzDJb/yZu0oKvJyyt4h/hYuwLnCNsb8N9Ko3ws3VpcZX+Au7CW4ZRF2yM5v
         qwdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710104319; x=1710709119;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:references:from:subject:cc:to:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AdIM06nz++B/9Hlj7waoS5xxV2hFdN+qnGtNubidnNg=;
        b=ebygd1SjDCUKMajfo0weoioyBIrIcy3TGbn3IcbaGDuVgZqFFuXFvQk6XucGvKCl8Y
         pGmXiKmbBbSUHU2K+Lw8J4bs3D8kZsQ5LdRZHdBwNT6s2TvIvM58y4t3+hXyTeiJV09I
         YFjzFVC/nNIkzt9nED9r2euVyerZdjVd9RXxvqmuLP0UZFJrYJ5e78AuTkYCr9Mh1c1N
         oVo6lR6YKZ/353hSB+51cGs36gPZ74fQpAdeLdwbqEhSu+JgN77+NGsjGw62mg0lXtgd
         UKsRnU4fAuD3eEXVCikkWzv6v+DI+sOVve1wxC2A2APOa+NCHUBk9J9UWTMpRKQQSHFw
         Jb7w==
X-Forwarded-Encrypted: i=1; AJvYcCXFAHYMN4qcvlBdi0IgJ39COXs55h38TuNnDOOdHo1iy3oR3BDJBtNcAYGCcmTqvwoJIeoJiFSIj8coXtOmapQebfXSmmsjDsqDfd9Y8cfr1pyk4Hs8E3IUVsnuqHBK9kP910Hciq97hZs=
X-Gm-Message-State: AOJu0YyUNjk4Zv/RcuTS2Yvlq9w7RQVNF2l/VMTjnyIG27/AwBnHCzOI
	vGEPRpotZPCV1pmj7af/Sv2ofWY/+WXOaEU/ZiH5JZmqexs/Gz5R
X-Google-Smtp-Source: AGHT+IGljSHKxMJzKayhGqWjLPgckT1W4X+jPP4cbkx77rPumlQ3/AWmb/5A4ZJyS0X55wYLgt+5tg==
X-Received: by 2002:a17:906:b117:b0:a45:d7fb:8423 with SMTP id u23-20020a170906b11700b00a45d7fb8423mr3914761ejy.9.1710104318611;
        Sun, 10 Mar 2024 13:58:38 -0700 (PDT)
Received: from localhost ([2a02:169:1e9:0:8f4d:9ee2:cc35:c67b])
        by smtp.gmail.com with ESMTPSA id b5-20020a170906d10500b00a45fb797ff1sm2200997ejz.116.2024.03.10.13.58.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Mar 2024 13:58:37 -0700 (PDT)
Date: Sun, 10 Mar 2024 21:58:37 +0100
To: Martino Fontana <tinozzo123@gmail.com>
Cc: djogorchock@gmail.com, jikos@kernel.org, benjamin.tissoires@redhat.com,
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Ryan McClelland
 <rymcclel@gmail.com>
Subject: Re: [PATCH v2] HID: nintendo: use ida for LED player id
From: "Silvan Jegen" <s.jegen@gmail.com>
References: <20240310180322.25508-2-tinozzo123@gmail.com>
In-Reply-To: <20240310180322.25508-2-tinozzo123@gmail.com>
Message-Id: <2TCU3VNKI7TD9.2PWW1CG9ZHYBA@homearch.localdomain>
User-Agent: mblaze/1.2-27-gea64d39 (2024-02-07)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Heyhey

One question below.

Martino Fontana <tinozzo123@gmail.com> wrote:
> Previously, the leds pattern would just increment with every controller
> connected. This wouldn't take into consideration when controllers are
> disconnected. The same controller could be connected and disconnected
> with the pattern increasing player count each time.
>=20
> This patch changes it by using an ID allocator in order to assign the
> player id, the same way hid-playstation does.
>=20
> Signed-off-by: Martino Fontana <tinozzo123@gmail.com>
> Signed-off-by: Ryan McClelland <rymcclel@gmail.com>
> ---
> Changes for v2:
>=20
> ida_free now frees the correct id, instead of an id that got moduloed.
>=20
>  drivers/hid/hid-nintendo.c | 27 +++++++++++++++------------
>  1 file changed, 15 insertions(+), 12 deletions(-)
>=20
> diff --git a/drivers/hid/hid-nintendo.c b/drivers/hid/hid-nintendo.c
> index ccc4032fb2b0..6ab4c2ec4a5d 100644
> --- a/drivers/hid/hid-nintendo.c
> +++ b/drivers/hid/hid-nintendo.c
> @@ -34,6 +34,7 @@
>  #include <linux/device.h>
>  #include <linux/kernel.h>
>  #include <linux/hid.h>
> +#include <linux/idr.h>
>  #include <linux/input.h>
>  #include <linux/jiffies.h>
>  #include <linux/leds.h>
> @@ -569,6 +570,7 @@ static const enum led_brightness joycon_player_led_pa=
tterns[JC_NUM_LED_PATTERNS]
>  struct joycon_ctlr {
>  	struct hid_device *hdev;
>  	struct input_dev *input;
> +	u32 player_id;
>  	struct led_classdev leds[JC_NUM_LEDS]; /* player leds */
>  	struct led_classdev home_led;
>  	enum joycon_ctlr_state ctlr_state;
> @@ -2283,7 +2285,8 @@ static int joycon_home_led_brightness_set(struct le=
d_classdev *led,
>  	return ret;
>  }
> =20
> -static DEFINE_SPINLOCK(joycon_input_num_spinlock);
> +static DEFINE_IDA(nintendo_player_id_allocator);
> +
>  static int joycon_leds_create(struct joycon_ctlr *ctlr)
>  {
>  	struct hid_device *hdev =3D ctlr->hdev;
> @@ -2294,20 +2297,19 @@ static int joycon_leds_create(struct joycon_ctlr =
*ctlr)
>  	char *name;
>  	int ret;
>  	int i;
> -	unsigned long flags;
>  	int player_led_pattern;
> -	static int input_num;
> -
> -	/*
> -	 * Set the player leds based on controller number
> -	 * Because there is no standard concept of "player number", the pattern=

> -	 * number will simply increase by 1 every time a controller is connecte=
d.
> -	 */
> -	spin_lock_irqsave(&joycon_input_num_spinlock, flags);
> -	player_led_pattern =3D input_num++ % JC_NUM_LED_PATTERNS;
> -	spin_unlock_irqrestore(&joycon_input_num_spinlock, flags);
> =20
>  	/* configure the player LEDs */
> +	ctlr->player_id =3D U32_MAX;
> +	ret =3D ida_alloc(&nintendo_player_id_allocator, GFP_KERNEL);
> +	if (ret < 0) {
> +		hid_warn(hdev, "Failed to allocate player ID, skipping; ret=3D%d\n", r=
et);
> +		goto home_led;
> +	}
> +	ctlr->player_id =3D ret;
> +	player_led_pattern =3D ret % JC_NUM_LED_PATTERNS;
> +	hid_info(ctlr->hdev, "assigned player %d led pattern", player_led_patte=
rn + 1);
> +
>  	for (i =3D 0; i < JC_NUM_LEDS; i++) {
>  		name =3D devm_kasprintf(dev, GFP_KERNEL, "%s:%s:%s",
>  				      d_name,
> @@ -2789,6 +2791,7 @@ static void nintendo_hid_remove(struct hid_device *=
hdev)
>  	spin_unlock_irqrestore(&ctlr->lock, flags);
> =20
>  	destroy_workqueue(ctlr->rumble_queue);
> +	ida_free(&nintendo_player_id_allocator, ctlr->player_id);

The PlayStation driver also destroys the allocator on module exit. Do
we not have to do the same in this module?

Cheers,
Silvan

>  	hid_hw_close(hdev);
>  	hid_hw_stop(hdev);



