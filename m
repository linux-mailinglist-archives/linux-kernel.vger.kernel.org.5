Return-Path: <linux-kernel+bounces-159686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 949528B3231
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 10:21:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5508B21512
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 08:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 706C513C8F4;
	Fri, 26 Apr 2024 08:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="UAx6Ppw6"
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4984713C912
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 08:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714119660; cv=none; b=r0Ow9JUibhGHncJzOpYGg/U1PqgOgYaAe84DDxAwGtPYaKdNqrZWK8WgSgszj2RtyzcYIw6nI6qB9O5ZpXAx1bKBuSBWYsDpwPRQ+/ws4g0ep5SQ8k/lmjzLReanrfh63BV4XJaCLherde76KigSYoiFaY6XaRJpZmm60tjsBvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714119660; c=relaxed/simple;
	bh=2QwY/idrWWstb2VS57g5qy6TKTu8YrTelcs1NllY2gE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N//KBj/5egqjgxB8EtatLHycyPB3C57u2XoS37AAZAsryvVn8Etz/xvc7OkesGCPUBwwsqdQbe/5HvlM/v9pkmpFlSfrSxWsUVsZoGhE0vB5HXRZVxhb9h8HnWRe5GscFMS3C8Yz8C08lXERtpPPbEdQKEKFBMPtUtgpFACnUhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=UAx6Ppw6; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-7d9c2096c29so84712539f.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 01:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1714119658; x=1714724458; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DOO+Oxe5RqdUN11iHoDt4ydzdK+8AI7NsGcbenw3d/A=;
        b=UAx6Ppw6A4wbEg9mFet1cI+rY5Tkj7+1UuOPcHdJWHNQR/sdpDoU0fy0F8Y24/QO6T
         siItHpR3P6Zt7A49GVrqLiJ1UorbTJNshGX86IGrwEKO5olBKed3/+vr6sm1KBLIgxZ+
         DFs4/V7An5HuM0NI75thEJSwWYnltF0liD+yU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714119658; x=1714724458;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DOO+Oxe5RqdUN11iHoDt4ydzdK+8AI7NsGcbenw3d/A=;
        b=sLHwr3CqFSJzqOFpCCrxilYN6SDU176zc0m+wKMTnVtrKUewBfRR8yME1NjPHl8fYU
         bI6ty3zbICFl24h7Zxp8nAHL30HKZeM+uA6mQxVjnQAzYGD6Y/wsXcXFF6zz3ahnS0f5
         3Qkb0PsxF7n6qYNKbRKOQUJQb9akXyKvKCTzjoHSb33oXVRO6+0uUMTtZU4vSe6ruE6y
         eluaXL6ONz0468l7jGsThKpROmK/rHWhzKIMB4VFpsbEU2xH6+7JTXpdpEt+LWZLXjH9
         E8woI8DKR/BVRStnBDZfpArJhm6WWsYwTQfYGbcBinL/uIoXbCMYZ8ojgHZczGazjyvJ
         hoXg==
X-Forwarded-Encrypted: i=1; AJvYcCUHgLCX4MEJDo+Ys9DcHiCk2hxikh30z4rEQ3t7QujIERo51xUnzJbfLDpGVykZujTvOTbFwSm6c3U4p55c0aMUYbNX8PTT80sZouya
X-Gm-Message-State: AOJu0YwRX+8ckw7QKq8Gk370TLWrbVbNc0CV5DXxYC4SwAKln9wzVLWL
	+gsfDEiwYsbGfZctwlk3X11Aa6thrZR3pD6x6NQKrhwSypVXUHiGDaAcgpPPDNSnN8WPb8dOTUs
	697R9BTIiuvGRgYJxaEhtevNIAhqQ/+X+QO5R
X-Google-Smtp-Source: AGHT+IGpFrMmIiUOGeU8GqDVHvij5e/EHFi3eql6VH19ZiFzL8S3bxOTPVDJXE8//vqh4sKVAKaAYPJDw3yidMK+gL8=
X-Received: by 2002:a05:6602:f11:b0:7de:9c6b:79de with SMTP id
 hl17-20020a0566020f1100b007de9c6b79demr2387497iob.14.1714119658470; Fri, 26
 Apr 2024 01:20:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240425192748.1761522-1-zack.rusin@broadcom.com>
In-Reply-To: <20240425192748.1761522-1-zack.rusin@broadcom.com>
From: Martin Krastev <martin.krastev@broadcom.com>
Date: Fri, 26 Apr 2024 11:20:47 +0300
Message-ID: <CAKLwHdVZSRtnCe_=pTw0kUaTEvCRKqypcq-u2f50o=xRQCrASA@mail.gmail.com>
Subject: Re: [PATCH] drm/vmwgfx: Fix invalid reads in fence signaled events
To: Zack Rusin <zack.rusin@broadcom.com>
Cc: dri-devel@lists.freedesktop.org, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, ian.forbes@broadcom.com, 
	maaz.mombasawala@broadcom.com, zdi-disclosures@trendmicro.com, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

LGTM!

Reviewed-by: Martin Krastev <martin.krastev@broadcom.com>

Regards,
Martin

On Thu, Apr 25, 2024 at 10:27=E2=80=AFPM Zack Rusin <zack.rusin@broadcom.co=
m> wrote:
>
> Correctly set the length of the drm_event to the size of the structure
> that's actually used.
>
> The length of the drm_event was set to the parent structure instead of
> to the drm_vmw_event_fence which is supposed to be read. drm_read
> uses the length parameter to copy the event to the user space thus
> resuling in oob reads.
>
> Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
> Fixes: 8b7de6aa8468 ("vmwgfx: Rework fence event action")
> Reported-by: zdi-disclosures@trendmicro.com # ZDI-CAN-23566
> Cc: David Airlie <airlied@gmail.com>
> CC: Daniel Vetter <daniel@ffwll.ch>
> Cc: Zack Rusin <zack.rusin@broadcom.com>
> Cc: Broadcom internal kernel review list <bcm-kernel-feedback-list@broadc=
om.com>
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-kernel@vger.kernel.org
> Cc: <stable@vger.kernel.org> # v3.4+
> ---
>  drivers/gpu/drm/vmwgfx/vmwgfx_fence.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_fence.c b/drivers/gpu/drm/vmwg=
fx/vmwgfx_fence.c
> index 2a0cda324703..5efc6a766f64 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_fence.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_fence.c
> @@ -991,7 +991,7 @@ static int vmw_event_fence_action_create(struct drm_f=
ile *file_priv,
>         }
>
>         event->event.base.type =3D DRM_VMW_EVENT_FENCE_SIGNALED;
> -       event->event.base.length =3D sizeof(*event);
> +       event->event.base.length =3D sizeof(event->event);
>         event->event.user_data =3D user_data;
>
>         ret =3D drm_event_reserve_init(dev, file_priv, &event->base, &eve=
nt->event.base);
> --
> 2.40.1
>

