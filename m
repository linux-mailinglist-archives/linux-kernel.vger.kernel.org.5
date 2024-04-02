Return-Path: <linux-kernel+bounces-127587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D3A24894DFF
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 10:51:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10A761C2290F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 08:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EDDE57315;
	Tue,  2 Apr 2024 08:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="fZ+Mu4f8"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7884D56B95
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 08:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712047857; cv=none; b=jCo5fRMUMlzNbm1TunCnoY+FRP48GKSo6XXWbU9VrctogYKVmTVdZRqILu7ojIQTN3r2cr3h9aD+FmE1cRhphIyNdIZ5niBeS7o5/M2BDQKbuI33uBweFbA2fTo3mx1dQwbuVRZKwHdM8s5ZT3Ycd3bpdKpjFcs7l/tuhGkyZ/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712047857; c=relaxed/simple;
	bh=d56KSz8sH4cc/CJcFH4xN0gZ6zRS/QTrszJ0H2z6WYU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LtRSAhbYw+d3B4b8lqAf5DvznKdXr+UkGeokuTJEej7dziHhuY3iy3+iMqRW+mDGhisz2zvrkX+mdhFBBB975+/Ctu8UlhFTVb1n+j6jPOQChaATqAcNarT22RA3qC2nrMwt7jIeVrM76y7WWppBDYG26juyYih7i+jfMlIZV2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=fZ+Mu4f8; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2d718ee7344so47741551fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 01:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1712047853; x=1712652653; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wv6+xX61JtxGpKWZ45wliW2pFq+S5fBIUaTwceo8xO4=;
        b=fZ+Mu4f8Zv0Se3wyF76ZSUh2LSawVq9Xlnx6CMHyso6UY0M6IxFizcenlEQoi/eqq9
         oTpmzdbIVXFSJFjgwRp261n9N8+sasNx2AK0z66AVin8RRUIhD98g9qtN+OmQv+HwXcR
         VUzA42gllfP6CaraHvKbs1K2eiGKGQ2TVAGokFvuZpHUz6bOlFrUWj+64db1+mqu1O1h
         UD/q8qfv1SUkEKn1wTHpbadrh6X6JFi7Rx+f6Ya/sVTTadcDcp0QlG9JfY8rylpOiB8F
         3Wiq6T+nVEuqo2qcnNg3UUbps4Do1iLUQ4vhL9sD2Fszzv9FNadkDJ6bAjkLJHYm5E9I
         p3Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712047853; x=1712652653;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wv6+xX61JtxGpKWZ45wliW2pFq+S5fBIUaTwceo8xO4=;
        b=exOv4vSdMMVX0r3mWKi8Brs6Pl9Ag3SaBY7tOIfycKtkjGL/j4lMGcuYuKsNdIXGeO
         l6bvV7n/mAH2Qj/VVEygwosBbHReErsSNLdZGByr07XZTQ03+8+7jBMyQns3uHtms+iJ
         Tkl0/66StkIvU04VRmI1zdl8OSKfGkRhJWRF6ui9MRQW242zVWzSVEtYrBRvOvfO44yG
         x8GZy0oWqFnVGRPmgFxJvyLNpdsdRsSsXYuDKy1s4p+MiO76dkgu2FkEP89PchUNkF/l
         UjQKUEvRdeClC5r5OCu6GKYY1yvR8K17K8x+JdbBtqTW2VX/o/SmpqcEKjtb6G2z+wI8
         MOkg==
X-Forwarded-Encrypted: i=1; AJvYcCUJ/90z4N9ICnaX+4jEd8jCYH6U5+CdbNs5YThGWNLqe1ZE/bTeB3qR3VaUX8XaPmLy9ah6vyedY6IInxm97WC7IM3faFTl5fsIVAIA
X-Gm-Message-State: AOJu0YyyPEi5MHm9/qfrlTtBOn4/u3yurZqYEK2p9iqdH/k+7wPnNJa6
	+r5RsNvlCxH0Rom2gIklDzy6cT8S8pHpq7tVf4ja1s0TrB4SEOiHzutQHZd/LfIfiYewpf0B370
	3RPq4uBU3xrytuH9w7z144R+wLmbtT6sdm/iulw==
X-Google-Smtp-Source: AGHT+IGduSNxIydN/eNgINSn+xOiMxlwqSzSVthVPSafiIs8o0sXpk5/cAWBdV4gf12hs+oVvORpHioikkxS0Cer+n0=
X-Received: by 2002:a2e:a7c3:0:b0:2d4:3e82:117e with SMTP id
 x3-20020a2ea7c3000000b002d43e82117emr9024835ljp.32.1712047853624; Tue, 02 Apr
 2024 01:50:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240329144318.376939-1-dlechner@baylibre.com>
In-Reply-To: <20240329144318.376939-1-dlechner@baylibre.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 2 Apr 2024 10:50:42 +0200
Message-ID: <CAMRc=MfUQ5+Tq3M8=gABA_t+bumWs8=5RZ8gVJXxFLg0cvcMpA@mail.gmail.com>
Subject: Re: [PATCH] Documentation: gpio: fix typo
To: David Lechner <dlechner@baylibre.com>
Cc: Kent Gibson <warthog618@gmail.com>, Jonathan Corbet <corbet@lwn.net>, linux-gpio@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 29, 2024 at 3:43=E2=80=AFPM David Lechner <dlechner@baylibre.co=
m> wrote:
>
> EOPNOTSUPP has two 'P's.
>
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
>  Documentation/userspace-api/gpio/gpio-v2-get-line-ioctl.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/userspace-api/gpio/gpio-v2-get-line-ioctl.rst =
b/Documentation/userspace-api/gpio/gpio-v2-get-line-ioctl.rst
> index 56b975801b6a..6615d6ced755 100644
> --- a/Documentation/userspace-api/gpio/gpio-v2-get-line-ioctl.rst
> +++ b/Documentation/userspace-api/gpio/gpio-v2-get-line-ioctl.rst
> @@ -81,7 +81,7 @@ Only one event clock flag, ``GPIO_V2_LINE_FLAG_EVENT_CL=
OCK_xxx``, may be set.
>  If none are set then the event clock defaults to ``CLOCK_MONOTONIC``.
>  The ``GPIO_V2_LINE_FLAG_EVENT_CLOCK_HTE`` flag requires supporting hardw=
are
>  and a kernel with ``CONFIG_HTE`` set.  Requesting HTE from a device that
> -doesn't support it is an error (**EOPNOTSUP**).
> +doesn't support it is an error (**EOPNOTSUPP**).
>
>  The :c:type:`debounce_period_us<gpio_v2_line_attribute>` attribute may o=
nly
>  be applied to lines with ``GPIO_V2_LINE_FLAG_INPUT`` set. When set, debo=
unce
> --
> 2.43.2
>

Applied, thanks!

Bart

