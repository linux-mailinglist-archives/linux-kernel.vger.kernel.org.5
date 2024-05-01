Return-Path: <linux-kernel+bounces-165167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C58C8B88E2
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 13:08:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45894B23044
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 11:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C0F760B96;
	Wed,  1 May 2024 11:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LKv0+u4a"
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E36FB55E74;
	Wed,  1 May 2024 11:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714561670; cv=none; b=kPQpk0pJM+i3BBycff05CHAy0jVNy9XYl1rBh1GRyaF2ye6viG9iG7e3SJJCFbGJWEwdPFmleIp0qxaO4nNjdsKVg8JFmsUCvIaD4ObZRLR/6TxPIdWM1O27Z9Wd+TmjaRdVkubur3qGVWwipmXEF4j800c3dOIMMCZU6GugKtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714561670; c=relaxed/simple;
	bh=Ev1NKvpk0cWBz1EpfOWUQu3Lm+CxbBm3npCjmR6r0AU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JlAWUPmCC9Jhhzgcsrvh4XHZUJeERZe2S5gYBz5o2Ck4JpnCMr8kPRoeOBiQkLgFAGWwPOIRT4aJDN91X7vtgOPEumGpBIRsy5xl7Fkxv96xmYzxA7RvEWVxM7Ks4aMrt9uo7w+GpcR6Bp6Md+jQgrwc3GNsyF9xVxxM/OX7U/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LKv0+u4a; arc=none smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-7eb7f34f36dso3123471241.1;
        Wed, 01 May 2024 04:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714561668; x=1715166468; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A0l2TVspwRQjKP8222WHKDVi355O+HT2fuesfGrzhqU=;
        b=LKv0+u4aAgheKaj+MXebFrR8xS7Al2pRq1lj6sMnuwp/YPu3Fg4zn2yyUfozWXJzKw
         K3saihIMl7xFREDDO+HmPKnD/mFrMTyN+x3zW2GqPPT/q2C9rSr3/sTkVvMn8XCZ3xoT
         lT/hVCNLyfY/Mc9QTIWF3SVY1HfzwiWrAJ5JXTe/HAJt2xrh0a/vdI+nWN+mO9G/afil
         XREamCwOTvJRs4nGJ1rhsSIaOyFOle/xImr2c6s/q33XBvd4fJxFtvbZhqoOmVQJMtuM
         yej72nkMbLcSDT0jG5EeXnW6omGFzb2f2rbqFN144bJ96JUn37FHoY0cl5ewvmR69hUI
         7KWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714561668; x=1715166468;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A0l2TVspwRQjKP8222WHKDVi355O+HT2fuesfGrzhqU=;
        b=KAjc1wFxDkWf/jT4fnDQRT5uESkZ5Jao+m5phFTCiog3os6bBdkllGngHkWYFBKClR
         /+r8Ub8HV3dKm3TKKLMfqvV5bLQGo6p3PMNyj53W3FAe1s39bDutva0grjv4OloUqNFC
         HjQPVeersGyk1JECkQk3bSFhfBm0Nj6+ChnYPs6VdPLebBwAuzYgF3KBrfSrGTPh1uyL
         m1MTDV0XgqjRpbbS8HwVx06z6JhLTdiw2d9U0ywEz4+v5UEqfZ16IhfeE4zvQed/S3NE
         ZPgtPLowIcTVHyyw6bTCtdrzkvBn7GuIjt7Yj9vWJYTJHVG2LTeDihftu3rJeiMub8FA
         jdLw==
X-Forwarded-Encrypted: i=1; AJvYcCVUN1forLsJC505X16Xb9b5KJtLW4GYxs80Fb+zOUl61IyTuFyzfz+IlubHwjuY8Yo645TFsKnhfrAxrQVlV+oybx6OsmQ3hM5mGvOv
X-Gm-Message-State: AOJu0Yyed5DUzefj6pMkQZ0IXAtdfxgMbH0N6LA9APkxnHSjllwMF/zD
	w0LtIxIPqB56LAfb1Txy2HQOUMc3H283KtrhxwZGrTb12e2dIGm6xLn0Xr9OC0muXqVoQYpCzXT
	YN4EEVx5eNz6mO6qfG8tgnd7t7/mNcrD+
X-Google-Smtp-Source: AGHT+IF+35mhhv3KE6EKdfz01w68lMgz4WUI8xTRe9lIfLjv2SfpQccY2l0DCSSFk4alYmh23Tq+N8AbfLJXcWXSllQ=
X-Received: by 2002:a05:6122:d91:b0:4dc:fbc5:d47 with SMTP id
 bc17-20020a0561220d9100b004dcfbc50d47mr1862701vkb.16.1714561667072; Wed, 01
 May 2024 04:07:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240430213146.23187-1-laurent.pinchart@ideasonboard.com>
 <20240430213633.23767-1-laurent.pinchart@ideasonboard.com> <20240430213633.23767-2-laurent.pinchart@ideasonboard.com>
In-Reply-To: <20240430213633.23767-2-laurent.pinchart@ideasonboard.com>
From: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Date: Wed, 1 May 2024 13:07:29 +0200
Message-ID: <CAPybu_2xjWg8sUW9jk7n1UXLTsoGXfftxVqLaZcWzn+ZcCRhOg@mail.gmail.com>
Subject: Re: [PATCH 2/2] media: bcm2835-unicam: Include v4l2-subdev.h
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

I have to send a v2 of
https://patchwork.linuxtv.org/project/linux-media/list/?series=3D12759 I
can include this patch in that set if you want

Regards!

On Tue, Apr 30, 2024 at 11:39=E2=80=AFPM Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> The unicam driver uses the v4l2_subdev structure. Include the
> corresponding header instead of relying on indirect includes.
>
> Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Reported-by: kernel test robot <lkp@intel.com>
Reviewed-by: Ricardo Ribalda <ribalda@chromium.org>
> Closes: https://lore.kernel.org/oe-kbuild-all/202404302324.8aTC84kE-lkp@i=
ntel.com/
> ---
>  drivers/media/platform/broadcom/bcm2835-unicam.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/media/platform/broadcom/bcm2835-unicam.c b/drivers/m=
edia/platform/broadcom/bcm2835-unicam.c
> index c590e26fe2cf..3c7878d8d79b 100644
> --- a/drivers/media/platform/broadcom/bcm2835-unicam.c
> +++ b/drivers/media/platform/broadcom/bcm2835-unicam.c
> @@ -55,6 +55,7 @@
>  #include <media/v4l2-ioctl.h>
>  #include <media/v4l2-fwnode.h>
>  #include <media/v4l2-mc.h>
> +#include <media/v4l2-subdev.h>
>  #include <media/videobuf2-dma-contig.h>
>
>  #include "bcm2835-unicam-regs.h"
> --
> Regards,
>
> Laurent Pinchart
>
>


--=20
Ricardo Ribalda

