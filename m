Return-Path: <linux-kernel+bounces-29639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92DE8831127
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 02:56:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5EEC1C21909
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 01:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06E2028FE;
	Thu, 18 Jan 2024 01:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HgUBKWhI"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E4548486
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 01:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705542989; cv=none; b=c/Nvszyumi0F7hlmcJPD5gO9Gm4fi2eI8s0wUXdTp2RiyVsksyckLmeGnisA3nI9er47StzI9ERgM2m3Jipzh9MYKQ6U/BMWEpcO8vNu03fMUxxaTo559hKzt52N5TCVn7GnCJWWLq+QThMQ2+povKdOCOh3IPHDe+BPvuc2hbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705542989; c=relaxed/simple;
	bh=dF0XeZAgKGf0FwsjUO5CoglAwAzJt8K4q+Vqm+pAa+4=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=IzK6gdenzyAsbLpm9J/QabmSOfadMNyprsmE+qOa/TjH1eiztL0lgqsdJuNPTl86fL44lNd0TLrr+W6HPblft9ZVRRUjVeidlGUCVMQCcKoNsZEWjjZoazvOdmt3GzO+gXDTJCfPaEkw0FgiQGZGtpFIzMIBPocOLgoyoaYNMkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HgUBKWhI; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a293f2280c7so1354653366b.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 17:56:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705542982; x=1706147782; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4sMKLwhhWm9+j1ob9vaGlonXEkVtE5eNqda4+zT2k6s=;
        b=HgUBKWhILLgHqMpbLDvOtyVQBofCF0t6VHiRBcKIyhPvCzvMb1bsIfpcNvaITByAB1
         SCMuVi7ib0NKAHzjoDm8jr1GclQTnLdo//lIYXb4QUfb/hoJTmYQLJpfuTae/hYFxpId
         IT/k+foopUj5FcaTndpgFgQI7wby0x1q/Bp8MdSYbolJMe5rC7IkLiOY+LPyuG4pnIjJ
         a8KZ5jUKPFG8I3G5zXG+VVN2j7Qae9J306eUn/1S7yHjpmNUvvHudSlABnBlYNFHw7vC
         7D5icSX9m4WBj2NCTXJ3GpHx8D+nE0QI5RGPGh4RCwlSiUggS/ZpzymuKr3qGbJ76yWE
         lGxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705542982; x=1706147782;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4sMKLwhhWm9+j1ob9vaGlonXEkVtE5eNqda4+zT2k6s=;
        b=FdfP8nVY/+RqcrM1xS0XGxq8xfEXont+qSmIr7buHoML7BrNVXFOT2Efurze87sJPM
         7LX9zd+NgSp7TIC+UcqqF7PwZ9S6VmU1dJbBRklRwfSSmK8hjxYLa4ZGaZxnQXE7vpT+
         /IabvDh25RC1H26k16IBc9gqREfPVHee60t741fh03FS+dZTys7ChmvgwNH+7e8CK6rn
         u0sDNAvRA8a/LnpSAt0KqF8nXo436jxZIWVn4QfVREuF0aERWrgTRRtj5sGHu+gcaVKr
         xvDhxSMzXkubfUfrM38Wb1Q1zLOO6WbzIMa7jnVlkJMT2OvI9bACQCIchlp/9dSVgwjO
         EKPw==
X-Gm-Message-State: AOJu0YxGrXcuTREMBcjDCY6wae1HSQIhicYEGclqDoR9ut7GgvQCBRK4
	IS+5yrTuwFMZ+mtz1LWZjLh7bIUMB3Seoqcg8kWqYaoN2QfFPHcNhTizlqXkVh0RleBVuWUSti1
	BGj5XOzoNJyzZGx/FMjOhwaBZeM0=
X-Google-Smtp-Source: AGHT+IExyadU6u2dEU08U1gT/xsHu6doWuX+IR7Am3UJ+nlqGITJiJqfEPa0d6e6E59TzEXbtAtmGfiZD+ZkYqrbgU8=
X-Received: by 2002:a17:906:b117:b0:a2e:d378:7612 with SMTP id
 u23-20020a170906b11700b00a2ed3787612mr25597ejy.133.1705542982435; Wed, 17 Jan
 2024 17:56:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240117031212.1104034-1-nunes.erico@gmail.com> <20240117031212.1104034-3-nunes.erico@gmail.com>
In-Reply-To: <20240117031212.1104034-3-nunes.erico@gmail.com>
From: Qiang Yu <yuq825@gmail.com>
Date: Thu, 18 Jan 2024 09:56:10 +0800
Message-ID: <CAKGbVbsc7KHFLr9bxZzzuK4tkv2JpSnW4vTCpHBU-nP8Fbshnw@mail.gmail.com>
Subject: Re: [PATCH v1 2/6] drm/lima: reset async_reset on pp hard reset
To: Erico Nunes <nunes.erico@gmail.com>
Cc: dri-devel@lists.freedesktop.org, lima@lists.freedesktop.org, 
	anarsoul@gmail.com, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Sumit Semwal <sumit.semwal@linaro.org>, christian.koenig@amd.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

GP should also need this.

Regards,
Qiang

On Wed, Jan 17, 2024 at 11:12=E2=80=AFAM Erico Nunes <nunes.erico@gmail.com=
> wrote:
>
> Lima pp jobs use an async reset to avoid having to wait for the soft
> reset right after a job. The soft reset is done at the end of a job and
> a reset_complete flag is expected to be set at the next job.
> However, in case the user runs into a job timeout from any application,
> a hard reset is issued to the hardware. This hard reset clears the
> reset_complete flag, which causes an error message to show up before the
> next job.
> This is probably harmless for the execution but can be very confusing to
> debug, as it blames a reset timeout on the next application to submit a
> job.
> Reset the async_reset flag when doing the hard reset so that we don't
> get that message.
>
> Signed-off-by: Erico Nunes <nunes.erico@gmail.com>
> ---
>  drivers/gpu/drm/lima/lima_pp.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/gpu/drm/lima/lima_pp.c b/drivers/gpu/drm/lima/lima_p=
p.c
> index a5c95bed08c0..a8f8f63b8295 100644
> --- a/drivers/gpu/drm/lima/lima_pp.c
> +++ b/drivers/gpu/drm/lima/lima_pp.c
> @@ -191,6 +191,13 @@ static int lima_pp_hard_reset(struct lima_ip *ip)
>         pp_write(LIMA_PP_PERF_CNT_0_LIMIT, 0);
>         pp_write(LIMA_PP_INT_CLEAR, LIMA_PP_IRQ_MASK_ALL);
>         pp_write(LIMA_PP_INT_MASK, LIMA_PP_IRQ_MASK_USED);
> +
> +       /*
> +        * if there was an async soft reset queued,
> +        * don't wait for it in the next job
> +        */
> +       ip->data.async_reset =3D false;
> +
>         return 0;
>  }
>
> --
> 2.43.0
>

