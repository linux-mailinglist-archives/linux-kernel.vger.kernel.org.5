Return-Path: <linux-kernel+bounces-104971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5960887D6CA
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 23:46:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AD7D1C20F31
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 22:46:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 385CE59B75;
	Fri, 15 Mar 2024 22:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gfs98Wq/"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF3259B6C
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 22:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710542776; cv=none; b=Kqj/o3U90J+wOO7uddSZrvzM0k1zixvQBUd5Pd38QdxNHrPWsb7YV2WWeer5igeloSs1pmqVWqs0uSGnGcfCoEyXmmEE1ZSgr9uRfsM2JOO+VsR8LVlfquLt8i3PcytFQySTeHcrN0IijKSV9WVaXFgTWRUxw4TlPvuDVK2caLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710542776; c=relaxed/simple;
	bh=7rbKQ2kldkcuLTTPV/EXyGKXkLn8P2KH0KqEjDDRkH4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n0dmJ/SdvK2ILLej5mhmyuGVk0tqvCg3wqjyaWp7X/y0jktX7CZFW+4YJt39W7mw2xYv/zDAhShWpDi7NwIjgqT8O6F3ZHCmmFulMP6tS9z8lTVaw4kJkjLGclPlNZMfrgrEP7fv6VTlXnPHnbg+C1k4+Fw4uR9b5IeEPLcx/Y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Gfs98Wq/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710542773;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cRIxaUBnHKjzxk/w28aUKJW59ZRRorJbI8C2dVILdKc=;
	b=Gfs98Wq/VWMOUyvaAvzznL2UsWKpn2pWc7MfU8nyFgMMlLyJdMj1UXvO+QwyuS9Beskw6N
	PnxJjF4p0J6Tg+4UWqXFoaMjaXTEechF0eC3RB1HQogpu8/07FZm9VutHMfYLnbGPhtogM
	bFogl4CCKgLbUcnSVjvq4Zsrbg+iO5M=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-400-vjteTknqN-yoG0AcKQ9Zsg-1; Fri, 15 Mar 2024 18:46:11 -0400
X-MC-Unique: vjteTknqN-yoG0AcKQ9Zsg-1
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-60a55cd262aso47491037b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 15:46:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710542771; x=1711147571;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cRIxaUBnHKjzxk/w28aUKJW59ZRRorJbI8C2dVILdKc=;
        b=VP3R+iypQHGoLVJryn3oDbzDa0G9TBE+Y4MyElRu8Ux6QWGuLSP2bPuzpVYPT1VRMz
         TM6d4QbnRqJA+GQXHSRGPmufeRbfUak+BdV0w72kxPCsYJ+KmapfRL40wfrvENaxzDuc
         IO2fXCm/cnJZz9duXW51mS7eVug1v9Ofcc3PYtCyhoxiTqm/rciDhi3GlL2nGGu+cvyb
         fzstnUjwTer0lPGaYNxOq0C3fW3rqwhA/MFNlLIkeugTf1jxhYrhSnANMs+GHV2Tfu8M
         /tXh0cE/ts8aNFs/Kx7PrgCF8e+/hx6TIwEUFcrk+tVyqZSGUdfS4YdJvPWE7+Euu5Gf
         twqg==
X-Forwarded-Encrypted: i=1; AJvYcCXlIxejcz26PxNR9ZEJCV8xrMpTQ7+xytqYQgrsjInMJFP5BBcyetGWBz6Dn3irxtqrmy+Xya7B7HjGbVgxQdSTW09+XD8UgQItQ4xW
X-Gm-Message-State: AOJu0YxFxLtYr1i0+VHoTP4pEu2YWVvH5b9U8onsOFkfdFDhrY5UWpO+
	V9fa+T6FM2u8eRaE9i3r8Gv//WQdcwI+1aLRx9jABsvStX7OV+ysKuJlH8o1xc6HDztTvMrRewx
	MhSOv4IoaUDSY++XchQudp3FIZDbeTkfOST60FaVsZRmMCUjb7loem5Cwte9omCPsoiapB8Gi7P
	Tw8U8sYro/7bp/qvXUvybvqiySXHoUn28zdSQu
X-Received: by 2002:a0d:c806:0:b0:5ff:7cca:a434 with SMTP id k6-20020a0dc806000000b005ff7ccaa434mr6671702ywd.51.1710542771357;
        Fri, 15 Mar 2024 15:46:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE546xo3HvJPY2qu672aEMFegdumCBfdse8Abcj5PGVflapFASYr5pywdAPdVOlwGoIO8LpM2ar7PP1CaBsKGQ=
X-Received: by 2002:a0d:c806:0:b0:5ff:7cca:a434 with SMTP id
 k6-20020a0dc806000000b005ff7ccaa434mr6671688ywd.51.1710542771075; Fri, 15 Mar
 2024 15:46:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240315212104.776936-1-lyude@redhat.com>
In-Reply-To: <20240315212104.776936-1-lyude@redhat.com>
From: David Airlie <airlied@redhat.com>
Date: Sat, 16 Mar 2024 08:45:59 +1000
Message-ID: <CAMwc25qaqyJa179rkBUgZKU5Otne1S07Z3ir0qK6a9mc=U3EZA@mail.gmail.com>
Subject: Re: [PATCH] drm/nouveau/dp: Fix incorrect return code in r535_dp_aux_xfer()
To: Lyude Paul <lyude@redhat.com>
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org, 
	Karol Herbst <kherbst@redhat.com>, Danilo Krummrich <dakr@redhat.com>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, Ben Skeggs <bskeggs@redhat.com>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Dave Airlie <airlied@redhat.com>

On Sat, Mar 16, 2024 at 7:21=E2=80=AFAM Lyude Paul <lyude@redhat.com> wrote=
:
>
> I've recently been seeing some unexplained GSP errors on my RTX 6000 from
> failed aux transactions:
>
>   [  132.915867] nouveau 0000:1f:00.0: gsp: cli:0xc1d00002 obj:0x00730000
>   ctrl cmd:0x00731341 failed: 0x0000ffff
>
> While the cause of these is not yet clear, these messages made me notice
> that the aux transactions causing these transactions were succeeding - no=
t
> failing. As it turns out, this is because we're currently not returning t=
he
> correct variable when r535_dp_aux_xfer() hits an error - causing us to
> never propagate GSP errors for failed aux transactions to userspace.
>
> So, let's fix that.
>
> Fixes: 4ae3a20102b2 ("nouveau/gsp: don't free ctrl messages on errors")
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> ---
>  drivers/gpu/drm/nouveau/nvkm/engine/disp/r535.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/disp/r535.c b/drivers/gp=
u/drm/nouveau/nvkm/engine/disp/r535.c
> index 6a0a4d3b8902d..027867c2a8c5b 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/engine/disp/r535.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/engine/disp/r535.c
> @@ -1080,7 +1080,7 @@ r535_dp_aux_xfer(struct nvkm_outp *outp, u8 type, u=
32 addr, u8 *data, u8 *psize)
>         ret =3D nvkm_gsp_rm_ctrl_push(&disp->rm.objcom, &ctrl, sizeof(*ct=
rl));
>         if (ret) {
>                 nvkm_gsp_rm_ctrl_done(&disp->rm.objcom, ctrl);
> -               return PTR_ERR(ctrl);
> +               return ret;
>         }
>
>         memcpy(data, ctrl->data, size);
> --
> 2.43.0
>


