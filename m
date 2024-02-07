Return-Path: <linux-kernel+bounces-56353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDB4384C91B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 12:00:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F12E31C25A08
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 11:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01A0717C65;
	Wed,  7 Feb 2024 11:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XzV2Foia"
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DFB817BD4
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 11:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707303625; cv=none; b=ifP8mZbF4PXXbSO0/uO+gefLQbD0E+v4eam7+G0w+v0ZkheoQFkwNa4CaHRpTYyGM6ZayN/TmoA0oE2k2lQUZSveXZaiDhNsJGH4jIAvVMngW5VCG7I62mVC0fVsAvbTIUbMT8cUNlg74QvtfMZlCxEsHGWMQjI9p5UAN9rtfes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707303625; c=relaxed/simple;
	bh=IUilT9WOclCQtH5VWRVonZk3/qbzSqxOlZhEZ5eLUvc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I6e0AJArIOr6ARDXMPFgUEJ24Oncow6i4jtGzjcE98x9qj3GaiOXLubFU7hX/yejiP51ZGzAcHFthzTtggVxtTP/yLXtat+qrTSeSaruXVrJAiFqMv5ZbXLabRRnejRqteucfvYSdClwTwBcwaNLZ1rtUDFzOcrmuR9nZ42R3t8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XzV2Foia; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-dc6e08fde11so453807276.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Feb 2024 03:00:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707303622; x=1707908422; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=e1oTkTP4QkeaUyMu3TaMQMZZ/Iz+5n4/yJ7O/hUjUWM=;
        b=XzV2Foia4jUfoenSnk3wMTR0XWfdz7ILJ0s0lBBr5fzGXVg77FcTg63ZLYtoWr5GRU
         NzFHuu6GbwJ5lB0oFrRF82NnIgVlGHGhYioMqliq7O5Ly+A3LKXOoIpAKISvnus6ZTO7
         ipyYYi3ESQ+oOEpMNBaPXl/gQX1rsQKxdm80bPMW0JCPvE8ABK3D5eqsbRRfF0umKR8g
         GeP6QgAKx6Dc/HN4bnpqs3oNaYSNQRS9roCAZ7DWGjqK+KF1RoX/cyeuwTAI642Tk5ip
         MqNFwZ8pigKeYeUxwD3Pfzzsb2VqX4a/+fCrBIQ9HHeB5zZxoZ/gm09FT/l6mNFUmiN/
         MlUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707303622; x=1707908422;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e1oTkTP4QkeaUyMu3TaMQMZZ/Iz+5n4/yJ7O/hUjUWM=;
        b=u7hyENty/ZLF2LdCzg2hH9cp1JmSskT6nxiV7r6ycc3gfW+W89J0I0Gf0wDzNDzpDk
         2AGiD+LxHz3dQPeVxRKFb0zz/X3PuuBpqRpQykKV00FUlKuzsC3vgwKe9IdZLjkhSgTe
         xDTiIu7q9xesqSp376dAdKkFqgU4C/+DvFH5f8tus3M94i07MfWte6o7B8aifk9a4HAx
         uKa2vmN9layAV1ihVQ5jMstV4E3OJM19WOe9kAg67/9CUsV4qCD4bIzIsjuZzkU4qZ/f
         lxn9HeuAgGrRynNF0Y44MoFSejSCpNVWhQBUnvJg0WWJyFd0vYB5LaC7C6Jeyr544Tgp
         /MJA==
X-Gm-Message-State: AOJu0YxyD1u/vYzvhWfgf87DQ0V2jWhM94ITCbiVyq7+s99xBqSActU3
	kIj3arKM7Sdx139n54UurenOMEilO949pa7w3we7pcE8uaWjvpke6PIGueglSb2TGI7QfesV5AP
	xSzY9NWh51F/IjWXgQcMFYj7qYd5EYjAlplvXyA==
X-Google-Smtp-Source: AGHT+IGQdKkGiez+TnRZfGQM7DgkVjmdX5toNOIRXKKSNj/a8pEzFI29tXzE1B1btGc7p72ZOLZ8rhOfOywvyz6IHmk=
X-Received: by 2002:a05:6902:4c2:b0:dbd:2b6:6cfd with SMTP id
 v2-20020a05690204c200b00dbd02b66cfdmr3769507ybs.2.1707303620647; Wed, 07 Feb
 2024 03:00:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240205222556.299481-1-tjakobi@math.uni-bielefeld.de>
In-Reply-To: <20240205222556.299481-1-tjakobi@math.uni-bielefeld.de>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Wed, 7 Feb 2024 13:00:08 +0200
Message-ID: <CAA8EJpqv2moyu6XUtCHb_EK-HLKSCgTa8CgchEVBg06PQKMM+w@mail.gmail.com>
Subject: Re: [PATCH] drm: panel-orientation-quirks: Add quirk for Aya Neo KUN
To: cubic2k@gmail.com
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Tobias Jakobi <tjakobi@math.uni-bielefeld.de>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 6 Feb 2024 at 01:57, <cubic2k@gmail.com> wrote:
>
> From: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
>
> Similar to the other Aya Neo devices this one features
> again a portrait screen, here with a native resolution
> of 1600x2560.
>
> Signed-off-by: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>

As you don't seem to be the author of the patch, this needs your sign-off too.

> ---
>  drivers/gpu/drm/drm_panel_orientation_quirks.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/gpu/drm/drm_panel_orientation_quirks.c b/drivers/gpu/drm/drm_panel_orientation_quirks.c
> index d5c15292ae93..03224f8860ce 100644
> --- a/drivers/gpu/drm/drm_panel_orientation_quirks.c
> +++ b/drivers/gpu/drm/drm_panel_orientation_quirks.c
> @@ -196,6 +196,12 @@ static const struct dmi_system_id orientation_data[] = {
>                   DMI_MATCH(DMI_BOARD_NAME, "NEXT"),
>                 },
>                 .driver_data = (void *)&lcd800x1280_rightside_up,
> +       }, {    /* AYA NEO KUN */
> +               .matches = {
> +                 DMI_EXACT_MATCH(DMI_BOARD_VENDOR, "AYANEO"),
> +                 DMI_MATCH(DMI_BOARD_NAME, "KUN"),
> +               },
> +               .driver_data = (void *)&lcd1600x2560_rightside_up,
>         }, {    /* Chuwi HiBook (CWI514) */
>                 .matches = {
>                         DMI_MATCH(DMI_BOARD_VENDOR, "Hampoo"),
> --
> 2.43.0
>


-- 
With best wishes
Dmitry

