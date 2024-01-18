Return-Path: <linux-kernel+bounces-29991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B06C831659
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 11:02:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D368DB21EE1
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 10:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36D682033F;
	Thu, 18 Jan 2024 10:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FbSM+GLw"
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E1E5200CD
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 10:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705572126; cv=none; b=tXgbc0n69ovdizqOSC7sbVS5rIkygrcBkpqZzj5b5FBA8LOvQA0KYQRDc2KkfoJMFhqBD5eXB+T5oDG0rx/V7knx7/VnSZdh1A1GMygDtpY8oHjQyJQT0rE34Nx47aIGJt9k5445eJ+3RYPJnkqir3vIJaz3C4/yi81SJEu1k2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705572126; c=relaxed/simple;
	bh=soHeTw8nucVzer4yQdR+I0O2Kl9v9GMUXLJfbUAO134=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:
	 Received:X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gmail-Original-Message-ID:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding; b=BmBe4JyzQlLC2eZvzUNZWzm9OABcz8/3k052kuHxwM+gZzdnkI8FnAEWoBQ6zyRiD9TYGXgPwmoskWBVVRlVaLUpLhJzkZz38QiiCoBdlfLBtub1DCnVVBFOHr2TVBA+Y89Ob8uFTCIKDzXiZ8xFUXx1y+r+CnMOwcytPhl9nUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=FbSM+GLw; arc=none smtp.client-ip=209.85.217.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-469893c4c11so419615137.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 02:01:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1705572118; x=1706176918; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UsG4DowCs4KKFZiNp7kWGzZfbLS3E3qjNg9PmSz4SaI=;
        b=FbSM+GLwAonLvvNMSrQXi1wL6PBBuQwyJVYGA2wg56+oo0m5CT+hj9arc5Kb7rMs82
         x5ItwL8XRWJ4jCuo5JLFgaxcv5IfbgISkrgZd5aejtOoQus72ZR9NtVHy0R/e3bmC/A+
         +5Xmp3qJ5iUBnMewC69JYDSwhN5DZFzwU/11U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705572118; x=1706176918;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UsG4DowCs4KKFZiNp7kWGzZfbLS3E3qjNg9PmSz4SaI=;
        b=m1/DDYYEUClnntBb+sRv6hOeX85zVicKZHgD/HYgA91Iyc+M7saKwDkacs987xnzgn
         /QPQMQ1KLbLLO/Kbdqq8bH3Jt7pMmmK6UOYvE5RsvcZGrjvO7MMX4fNK/O8th3/l2Uh7
         uj3+pKUiG5ZslQKouDEQgZzq76zrKrIPBr1szntAuc4PpxkzEe6bKEGR+YjhFKUh1hr2
         p4xZnnZtpNoqaNiqe1E2bb2kyPHxEl19IPw8aQ05WLkqnzaYxbrEC/U0XxCYHmdQuBxy
         bH+HfRbQHNXJcNi4Z5MOUSF07tctcHui6eXV9tYOuuiiREb9J0hN+/lWB2HUkAthV17a
         9NTg==
X-Gm-Message-State: AOJu0YzuyHAdJPXZCoHVa8Keje77j/PJL+HfHIexINy6KcRL6rF9vcbe
	QP/7Kiz9OznqLENVLGJBsB2o3RSQ/ZUFnqNPaj4ZkLtVFR/qore5fVjguOr6+TzTGjKYhsSWGAo
	=
X-Google-Smtp-Source: AGHT+IELjCUzBnQ/ERj7dOIbDyaAmc0Hz4Jzrmg1U9xsuelu/uQFO1uh/77jgi/UUVzO/y9SYyKvpQ==
X-Received: by 2002:a05:6102:40f:b0:467:48c8:840d with SMTP id d15-20020a056102040f00b0046748c8840dmr516515vsq.38.1705572118207;
        Thu, 18 Jan 2024 02:01:58 -0800 (PST)
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com. [209.85.221.174])
        by smtp.gmail.com with ESMTPSA id j19-20020a056102335300b00467bfdd07bcsm1430060vse.32.2024.01.18.02.01.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jan 2024 02:01:56 -0800 (PST)
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-4b77948f7deso3459076e0c.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 02:01:56 -0800 (PST)
X-Received: by 2002:a1f:fe0b:0:b0:4b7:1d62:b48f with SMTP id
 l11-20020a1ffe0b000000b004b71d62b48fmr299907vki.24.1705572116196; Thu, 18 Jan
 2024 02:01:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240118085310.1139545-1-phoenixshen@google.com>
In-Reply-To: <20240118085310.1139545-1-phoenixshen@google.com>
From: Fei Shao <fshao@chromium.org>
Date: Thu, 18 Jan 2024 18:01:19 +0800
X-Gmail-Original-Message-ID: <CAC=S1njRz=d73J0ntKma2L85icqbCO79wLjrMpkQ0HgiDpdbrw@mail.gmail.com>
Message-ID: <CAC=S1njRz=d73J0ntKma2L85icqbCO79wLjrMpkQ0HgiDpdbrw@mail.gmail.com>
Subject: Re: [PATCH] Input: cros_ec_keyb: add support for base attached event
To: Ting Shen <phoenixshen@chromium.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Ting Shen <phoenixshen@google.com>, 
	Benson Leung <bleung@chromium.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Guenter Roeck <groeck@chromium.org>, 
	Tzung-Bi Shih <tzungbi@kernel.org>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
	chrome-platform@lists.linux.dev, =?UTF-8?B?am9ld3UgKOWQs+S7suaMryk=?= <joewu@msi.com>, 
	linux-input@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 18, 2024 at 4:54=E2=80=AFPM Ting Shen <phoenixshen@chromium.org=
> wrote:
>
> This CL maps ChromeOS EC's BASE_ATTACHED event to SW_DOCK,
Hi Ting,

The change itself looks good to me, but the userspace can already
detect keyboard attachment through USB events. Can you explain why
this becomes necessary?
And the Linux community doesn't use the term "CL". Please use general
terms like "commit" or "patch" as well as imperative sentences [1] in chang=
elog.

After that,
Reviewed-by: Fei Shao <fshao@chromium.org>

[1]: https://www.kernel.org/doc/html/latest/process/submitting-patches.html=
#describe-your-changes

Regards,
Fei



> to allow userspace detect that a keyboard is attached to the
> detachable device.
>
> Signed-off-by: Ting Shen <phoenixshen@google.com>
> ---
>
>  drivers/input/keyboard/cros_ec_keyb.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/input/keyboard/cros_ec_keyb.c b/drivers/input/keyboa=
rd/cros_ec_keyb.c
> index 30678a34cf647..d2e0d89d4ffdf 100644
> --- a/drivers/input/keyboard/cros_ec_keyb.c
> +++ b/drivers/input/keyboard/cros_ec_keyb.c
> @@ -128,6 +128,11 @@ static const struct cros_ec_bs_map cros_ec_keyb_bs[]=
 =3D {
>                 .code           =3D SW_TABLET_MODE,
>                 .bit            =3D EC_MKBP_TABLET_MODE,
>         },
> +       {
> +               .ev_type        =3D EV_SW,
> +               .code           =3D SW_DOCK,
> +               .bit            =3D EC_MKBP_BASE_ATTACHED,
> +       },
>  };
>
>  /*
> --
> 2.43.0.381.gb435a96ce8-goog
>

