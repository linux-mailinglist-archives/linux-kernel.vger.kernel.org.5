Return-Path: <linux-kernel+bounces-165162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DD888B88DA
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 13:04:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98C0B1C22EB3
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 11:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60AD056763;
	Wed,  1 May 2024 11:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gWh76Eb0"
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C60A48CE0;
	Wed,  1 May 2024 11:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714561442; cv=none; b=nEczN4bD8DsZ839qUQh/P4pFN45Ck6PWJv1yPlJ3nI/JRFY+SM6iISnu7UcZiT1PtIyemwC+P5XvbcHpggWNLo9JGBghufz1v1Ea+344AzbP1mVpPNaSnCr8vcFKzqT5ir/xoXSGnUanmd4m5XWpTfP4tz02+DnpsagJSRt3XBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714561442; c=relaxed/simple;
	bh=Lv+nMOQFs0BluawuyLrKMUkT6cwH9pGWcIkHyav3pR0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BqAk3kZrYxsOFpof8fnmvWVka88ESdznm4FuVUZ1oMlcHD/6rTg9eq1VXbPdxJgGfOQl504C0/jCiCkaU3AF9cPiRtOuwHwRUod9/jCZ3L7qltvIuFFGDG6KC4+ni6/b+/J9MviHU5XmoL1hxQbIPr2mNuDI7OpMQ6jy55uGgNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gWh76Eb0; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5aa4204bacdso4076353eaf.2;
        Wed, 01 May 2024 04:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714561440; x=1715166240; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jet+oML+586hOmiIToGtwYMGYre9ZmsemSsDP6Wj4sU=;
        b=gWh76Eb0rvgsAJqokLpKNAtK5iQNATn4mNkn0f6o3QR3npeYwtbuqX3RB137Pr4TU7
         gilp4KGFHWwxTwRZWLYNlhFtA8JItK5h0B30iUjAgGFvCfLhwzqtOEdU897EuGSBB/A2
         EIsHH5g2UBjekCCdwAUdaXFakTnXdKMo9SLjU5lQDW5b9GY6rRiR4sFmNttgu8kskrrF
         AplQlTrPwPWEt5vbaZyquzdGbAKEPEkB5oIBnil1AZiUZhPdaPxD4u0EuVNAbNnDOdG8
         QoAb2VL3nBhQe9R0TBrl2GmexK9jBL92W+vLDRpR6rQcR6GarpkOWKWEuXVMyPR270Fs
         EAmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714561440; x=1715166240;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jet+oML+586hOmiIToGtwYMGYre9ZmsemSsDP6Wj4sU=;
        b=WX836kYYaUr+2Klr5xwKEaDNtDlrzpBAiiv8NQyOtgj+dCc1CRcuzpxp7P95yxhn3h
         3Lj7dKUKdRmbhW/1KSXJVeg52Prwwu9hyu2kRYFtP3Vp0phS+Pxw1I9Op4KLvFgpkbHd
         pMFoNzUCsx9hBndG3ZhCLBIG9117zQkmtincGABPvUc0CgsaLXGAp20ke5kd8i0zxytE
         y7+WT12XiuBlgCUFvap2iwDKJ94eIXVEt9BwDllv11QDdnzJED+nxZrGXf6FcacAkNH4
         MX64W+Hx1qETuckCjIrG0AhozBXJlLvXIegB4wTVigjcbEj2uWyOHF8lqfD5Ipq3G6vc
         BPuQ==
X-Forwarded-Encrypted: i=1; AJvYcCXPMYgGlMiaTQcYd+zKCTVclNjUH9xaG6FYS/f8Kl2QoAnSB+vRz1rXDvmkOAv+rvCiv5WGbVDq82nIJMJChwkHf333qICUZZF715Gt
X-Gm-Message-State: AOJu0Yy0U8UAPpN5A6zTI1zWjMMfqMvK/YFeUQA/jXmvm/wcRiiszYpr
	0EDRwt6Uu8OPPS17XbXUjMB6sdi5afUFGwn7GQMeQ41GbeUqend9XusOc4Yu9fy++JI+oKU6OA0
	bqFPPcuFg/V2ILl1lJgIkK0ZX2wI=
X-Google-Smtp-Source: AGHT+IGvr2xGduu9rKyaqbgAP+JsJNNCD1tDKh/BEYkdGrcGXI17CeFWB0RqX1SAgpl9fY5NwDnLg1RMbJeP+cw73h8=
X-Received: by 2002:a05:6358:703:b0:183:f7cb:af75 with SMTP id
 e3-20020a056358070300b00183f7cbaf75mr2410215rwj.32.1714561440176; Wed, 01 May
 2024 04:04:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240430213146.23187-1-laurent.pinchart@ideasonboard.com> <20240430213633.23767-1-laurent.pinchart@ideasonboard.com>
In-Reply-To: <20240430213633.23767-1-laurent.pinchart@ideasonboard.com>
From: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Date: Wed, 1 May 2024 13:03:42 +0200
Message-ID: <CAPybu_3E5M4uWoX0sOTxji9Rj25xajh9jbyJOSBsa+MV_h_GaA@mail.gmail.com>
Subject: Re: [PATCH 1/2] media: bcm2835-unicam: Drop usage of of_match_ptr()
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-media@vger.kernel.org, 
	Florian Fainelli <florian.fainelli@broadcom.com>, Ray Jui <rjui@broadcom.com>, 
	Scott Branden <sbranden@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Naushir Patuck <naush@raspberrypi.com>, Dave Stevenson <dave.stevenson@raspberrypi.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, linux-rpi-kernel@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Laurent

This is a dupe of:

https://patchwork.linuxtv.org/project/linux-media/patch/20240430-fix-ipu6-v=
1-1-9b31fbbce6e4@chromium.org/

regards!

On Tue, Apr 30, 2024 at 11:39=E2=80=AFPM Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> Using of_match_ptr() to set the .of_match_table field of the device
> driver results in the unicam_of_match table being unused on non-OF
> platforms, causing a compilation warning. Fix it by dropping usage of
> of_match_ptr(), which can be done because the .of_match_table field is
> part of the device_driver structure regardless of whether or not
> CONFIG_OF is selected.
>
> Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202404302324.8aTC84kE-lkp@i=
ntel.com/
> ---
>  drivers/media/platform/broadcom/bcm2835-unicam.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/media/platform/broadcom/bcm2835-unicam.c b/drivers/m=
edia/platform/broadcom/bcm2835-unicam.c
> index bd2bbb53070e..c590e26fe2cf 100644
> --- a/drivers/media/platform/broadcom/bcm2835-unicam.c
> +++ b/drivers/media/platform/broadcom/bcm2835-unicam.c
> @@ -2733,7 +2733,7 @@ static struct platform_driver unicam_driver =3D {
>         .driver =3D {
>                 .name   =3D UNICAM_MODULE_NAME,
>                 .pm     =3D pm_ptr(&unicam_pm_ops),
> -               .of_match_table =3D of_match_ptr(unicam_of_match),
> +               .of_match_table =3D unicam_of_match,
>         },
>  };
>
> --
> Regards,
>
> Laurent Pinchart
>
>


--=20
Ricardo Ribalda

