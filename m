Return-Path: <linux-kernel+bounces-133381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB8B889A309
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 19:04:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6644A2887E0
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 17:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2921171659;
	Fri,  5 Apr 2024 17:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="p9t3Lldm"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D9D17164E
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 17:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712336653; cv=none; b=ONJ0E5MuY4zWEOoCFEXoUMnJd3Jq+vANlfubFv5DAoKCfQzHmPbPxH9AjjdTmsS7y1jgxzPOXxL/Gv35KKak8thjlYLL5iqQg3IxIyD88PGHp7DjlyIv2Bjlbn/dFi0C5EhsMgQ+NYcFkEo+a6HFRhzAvmJZvTP3Vynik6SFtT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712336653; c=relaxed/simple;
	bh=OOgEwHqMz/Yvjc2goDeb8uEo8Ux7zxdqL7svhS7VDzM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IcOQzFlvDfS1B0Ui493grvjYZrTXIBHiXV1QLGdhG70c3A3LhjeTYRgggnt4Yf7KEHp7HZTeTLLfRDlbUJLQowB7CHZWOmTxskcVU5pOTa/LMhxtw8hF+RpK6gLhAtXduJ5aU3ogDj4Plvr7t0Tz/S/jzgFtzd9JJr/cPbWsXac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=p9t3Lldm; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2d87450361fso638891fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2024 10:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1712336648; x=1712941448; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0MbNjbvHvDDOSjIwkj/Strvo+EkSYgqBXUTM9ofNx5w=;
        b=p9t3LldmW4SOxNOxt9fcY7jPCvtbRUdbD4b63lKA8ata6eWL1uSoX3BPcyjIk8ZMDf
         NCvYd+Qel99IUgL4/m+2dojPLOj6aIPVkSXd2ZLDBcEQ26DzRpxmBOzOCGArdjWJvt6c
         OC2qBM6uAIiEvarYCQsOUBo+qvVi5y8Q8vqTPXjr3S6YMZzPuA6grCgMmToM2r4AbL7t
         fCuyGfop4upSgHQLNDbCkXcA6JNWUmyEeuxOsmD/L6Awc1ZbjKSbdo4V4CAm4KZj4336
         9AKFg+O4paRIjdIYiQWPo3wboXmuX1c8p2005zWJjbwjfZjYZ+EIILUR0Ew51JIp4bYD
         frCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712336648; x=1712941448;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0MbNjbvHvDDOSjIwkj/Strvo+EkSYgqBXUTM9ofNx5w=;
        b=AtJrwnkXRwnbRb2BELGVRdxNQA2cXwNKp1YIUMgL5lyNEkIHr+wzrzvtVGY4dVnCnD
         i/eUyBBqJRRtqkZxePo3fkfby0BFNJIYpb7otA+I3FB0oVduoxHd1N3Mq0WwcbfDNBpP
         MLV5xEBfpV5sSfd0dND90QIjsa76Xx/15MzdNfJq+Jk/REUf26CKnFvmE9xd3oS3Q0M3
         SZ3UvRbLyEv9JJqExvBZqHTqa1HAtvLt0lwGCb2VIJkykZm9Tmb9qTD2gnbxvYJkf4/m
         YWimDHna5sQslqYq2m3UthELhKhmCE/W6bLWY6a9W5n/KkYcqB2OKMZlX1Mddz1ZLuQ8
         bN4w==
X-Forwarded-Encrypted: i=1; AJvYcCVUebugPOm/vgeTtlDWTMEtVWBs3JbPEyAUm8xxiWId1uX5gK2VGloPdpQsK4ufcMkicU2a5sXJcbfOLlNS10y4LKqLFRensLSLrhF5
X-Gm-Message-State: AOJu0Yz5odjFOUCmYjz823tks5TwjvXKf6iITXMpuq30JuEpI7Rv04Tj
	okasHV5vj/dJ/gYoSJbIx1Qm4rtTAbB0DEDoJmuI4yauKq1BrlH17hUpkZOxVsEXjXetDzHzjtW
	ZwPMAeijbUi5DbfxGnPUCV1Sh+1y6TMNP3zKQmw==
X-Google-Smtp-Source: AGHT+IF/wUgVwYjkQB9QkUlJ3rk/lwdpphCX6bl6Br6T/1h0Jsz8GgHfi7aqte4he6pNM2ldIDRcVp8T/y+psXCWnc4=
X-Received: by 2002:a2e:be9a:0:b0:2d6:c94d:94c2 with SMTP id
 a26-20020a2ebe9a000000b002d6c94d94c2mr1833000ljr.46.1712336648097; Fri, 05
 Apr 2024 10:04:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240405003025.739603-1-tgamblin@baylibre.com> <fhrderkiwqzc7fw2hptz2la3aco72wlossqbrr4m42qllcpcpw@vhxflah2ex2a>
In-Reply-To: <fhrderkiwqzc7fw2hptz2la3aco72wlossqbrr4m42qllcpcpw@vhxflah2ex2a>
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 5 Apr 2024 12:03:56 -0500
Message-ID: <CAMknhBFgXdH63_N738qMt6tzK_zWdB-OWvYTWitmBuQNqrN+LQ@mail.gmail.com>
Subject: Re: [RFC PATCH 0/3] pwm: add support for duty_offset
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Trevor Gamblin <tgamblin@baylibre.com>, linux-pwm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, michael.hennerich@analog.com, 
	nuno.sa@analog.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 5, 2024 at 1:23=E2=80=AFAM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
> On Thu, Apr 04, 2024 at 08:30:22PM -0400, Trevor Gamblin wrote:

..

> > 2. Should __pwm_apply() explicitly disallow PWM_POLARITY_INVERSED and
> > duty_offset together?
>
> While there is no technical need for that, a configuration with both
> PWM_POLARITY_INVERSED and duty_offset > 0 is irritating. So I'd say yes,
> it should be disallowed. When I created the cdev API I even considered
> dropping .polarity for lowlevel drivers and convert them all to
> .duty_offset.
>
> Having said that I don't like the addition of .supports_offset to
> struct pwm_chip, which only signals a new incomplete evolution of the
> pwm framework. Better adapt all drivers and then assume all of them
> support it.

But not all chips can fully support this feature. I envisioned this
flag as something consumer drivers would check when they require a
chip capable of providing a phase offset between two PWM output
channels. This way, the consumer driver could fail to probe if the PWM
chip is not up to the task.

For example the consumer driver might require two coordinated signals like =
this:
      _                   _
PWM0 | |_________________| |_________________
           ___                 ___
PWM1 _____|   |_______________|   |__________

PWM0: duty_offset =3D 0, duty_cycle =3D 1, period =3D 10
PWM1: duty_offset =3D 2, duty_cycle =3D 2, period =3D 10

Do we need to do additional work to support cases like this? Or should
we just let it fail silently and let it generate incorrect signals if
someone attempts to use an unsupported hardware configuration?

