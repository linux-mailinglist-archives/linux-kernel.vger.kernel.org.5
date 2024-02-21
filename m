Return-Path: <linux-kernel+bounces-74051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EBF7B85CF51
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 05:33:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5659283411
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 04:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAE1739851;
	Wed, 21 Feb 2024 04:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="J+lJrh5B"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C0629AB
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 04:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708489993; cv=none; b=QLk3AnUKrg3zZ6a2408IIzgajjwU7hK6XpecEJi3mbyG6V3j9bwX7MJ0bKCx2GlO2KaTIwpC02ZqkhggLmLAQ9ZO9Lw+rBIFfmCZNX6eltM9w0n3Nx2lyEhN5vX1SoIlkg01hygvNNAx10ikeoiQl+3wH7jmVyUYyJ7dW9eKt8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708489993; c=relaxed/simple;
	bh=oL4jzuCKbGJSQdHdOTD8mVuXHXW9YeehgSh1yQfUYr4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d6qp+Qb7AYWS3Ek1XF/6cSWKwbR+5kLZAGEsmEwUi3l+B5swVLM1bslFYDe/7w4Zq1DTfMn4/B7rGpaAhHDYqfwMEQZJKxSMdcVAD58ywmr007xVyBfM4fhsdsRRRqa8tBA/21Nhyq6wgYUPGAuxtlGTIa9XEyNPuzS2qZ/C0I8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=J+lJrh5B; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5120ecfd75cso9635546e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 20:33:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708489989; x=1709094789; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vmY04dbj/vIU0t6pHPXsLFor7e8BbOlWKLitvKLNgfs=;
        b=J+lJrh5BApfGMGFXNqy8UADibA3r4E9St5n9eryvgEDE5ismvmwgOMyeET8WT0Yjhy
         ohk7hVIb3c4+6IKFUXLEysmML1qDkTGjOYSdKOAII5pOurKzbQcWKnpmqwkFqJFqz4v0
         RJdDvHbmpR/fK75rfOwrhsf82siUcJiORn8F8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708489989; x=1709094789;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vmY04dbj/vIU0t6pHPXsLFor7e8BbOlWKLitvKLNgfs=;
        b=ErCCSoxASK0ITlcDHaMOI36jbGEd5QaCe59QNJg7ngB+7G4rFwjkojDyiCw6x4x7qN
         EXbL+o3OWQwPTTvmDu0fBRVmSRjyjlux0K5QHBXBGahtsJ6tRwBdlCwvofUYydgGSOp9
         zokD6dJQKe0MwrjAPS9ZrrNa6SgR0L7z3USic/mijbuOhGbRb55KsDWyEyMugn8Y5DrE
         lDI6ZTG/mkLA78zTcZ2CJggS6+7VRv7A1Ih95pnV4rwYDEbAT/Yfue7kE9ahBFOY8nfI
         nsQh7Us1cWp5uTqE+euQSll/XFRiTd3AJeKVUKgRWqaE1ap8fxitUhYTSSSFUSa/9YS6
         U+zw==
X-Forwarded-Encrypted: i=1; AJvYcCXxyrz4DJwt680pH8i5aaty7yRwVULPYY5LtS9Ex3cS8PizYU1U/bJGTN2UUR9ZbtgzACWfjX/HCugHjhvThbn+xAi4pZ0ZaQ1Nid3l
X-Gm-Message-State: AOJu0YzOOfQ+050umsQitgCxJtk3BuyXgy7tqr9+ZOtLWbyednMjlwJ9
	p9tG5C70adRJ4Sl8w7rnKPjYKxUvzXQgycCH15Qq0pwg6GYCKbXkt5pheITJn6hNchxMRzLKfFK
	rHA==
X-Google-Smtp-Source: AGHT+IGGLGnrUQ9nrHYPsVy25U00ZNtMaveq84GuXomc3KVt08jjd1t+uoCLYFMohUfM58+OQ0o4Sw==
X-Received: by 2002:a05:6512:34cc:b0:512:d643:8cf8 with SMTP id w12-20020a05651234cc00b00512d6438cf8mr22539lfr.62.1708489989365;
        Tue, 20 Feb 2024 20:33:09 -0800 (PST)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com. [209.85.128.47])
        by smtp.gmail.com with ESMTPSA id tz3-20020a170907c78300b00a3ee67806fasm1476619ejc.152.2024.02.20.20.33.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Feb 2024 20:33:08 -0800 (PST)
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-41270d0b919so8488465e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 20:33:08 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXryLYyPpmBldkI3WRKtCllWj9OCgjNg9rcqEHmTW6QGZQjwnYbWIhmB0p4PmCNn5AGbAkU9fhkTMD+IgxsAEh+aVfes/wEldSgN0bx
X-Received: by 2002:a5d:47a4:0:b0:33d:6ede:1149 with SMTP id
 4-20020a5d47a4000000b0033d6ede1149mr2829350wrb.35.1708489988167; Tue, 20 Feb
 2024 20:33:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1705581128-4604-1-git-send-email-shengjiu.wang@nxp.com> <1705581128-4604-8-git-send-email-shengjiu.wang@nxp.com>
In-Reply-To: <1705581128-4604-8-git-send-email-shengjiu.wang@nxp.com>
From: Tomasz Figa <tfiga@chromium.org>
Date: Wed, 21 Feb 2024 13:32:50 +0900
X-Gmail-Original-Message-ID: <CAAFQd5Ddip8n90Ma+d_kqgARoMRvpmk5Yyo+D_Csop6Ws8bHqw@mail.gmail.com>
Message-ID: <CAAFQd5Ddip8n90Ma+d_kqgARoMRvpmk5Yyo+D_Csop6Ws8bHqw@mail.gmail.com>
Subject: Re: [PATCH v12 07/15] media: v4l2: Add audio capture and output support
To: Shengjiu Wang <shengjiu.wang@nxp.com>
Cc: hverkuil@xs4all.nl, sakari.ailus@iki.fi, m.szyprowski@samsung.com, 
	mchehab@kernel.org, linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
	shengjiu.wang@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com, 
	nicoleotsuka@gmail.com, lgirdwood@gmail.com, broonie@kernel.org, 
	perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org, 
	linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 18, 2024 at 10:15=E2=80=AFPM Shengjiu Wang <shengjiu.wang@nxp.c=
om> wrote:
>
> Audio signal processing has the requirement for memory to
> memory similar as Video.
>
> This patch is to add this support in v4l2 framework, defined
> new buffer type V4L2_BUF_TYPE_AUDIO_CAPTURE and
> V4L2_BUF_TYPE_AUDIO_OUTPUT, defined new format v4l2_audio_format
> for audio case usage.
>
> The created audio device is named "/dev/v4l-audioX".
>
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---
>  .../userspace-api/media/v4l/buffer.rst        |  6 ++
>  .../media/v4l/dev-audio-mem2mem.rst           | 71 +++++++++++++++++++
>  .../userspace-api/media/v4l/devices.rst       |  1 +
>  .../media/v4l/vidioc-enum-fmt.rst             |  2 +
>  .../userspace-api/media/v4l/vidioc-g-fmt.rst  |  4 ++
>  .../media/videodev2.h.rst.exceptions          |  2 +
>  .../media/common/videobuf2/videobuf2-v4l2.c   |  4 ++
>  drivers/media/v4l2-core/v4l2-compat-ioctl32.c |  9 +++
>  drivers/media/v4l2-core/v4l2-dev.c            | 17 +++++
>  drivers/media/v4l2-core/v4l2-ioctl.c          | 53 ++++++++++++++
>  include/media/v4l2-dev.h                      |  2 +
>  include/media/v4l2-ioctl.h                    | 34 +++++++++
>  include/uapi/linux/videodev2.h                | 17 +++++
>  13 files changed, 222 insertions(+)
>  create mode 100644 Documentation/userspace-api/media/v4l/dev-audio-mem2m=
em.rst

For drivers/media/common/videobuf2:

Acked-by: Tomasz Figa <tfiga@chromium.org>

Best regards,
Tomasz

