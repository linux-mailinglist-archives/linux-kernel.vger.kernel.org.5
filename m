Return-Path: <linux-kernel+bounces-108790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 77D57880FFD
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 11:35:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21913282555
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 10:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51C442207A;
	Wed, 20 Mar 2024 10:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gzsNQH2w"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A9079D1;
	Wed, 20 Mar 2024 10:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710930873; cv=none; b=ksNzFRLLyO72lnWkQjqsOf6HfhufN+Ow/AUERqtmc0vfLqefvK70pZ6qL2OkrEnyOhaF4b//0CpPSXaMrzgBwYgGtUur4Rm9ZhhqUe4cgkLW5tJnkvwRk44FXT3VHrQV+8aWH2BlJ+KkSMhoAVUm6dYcDcd5rozB+GuGNeC11TY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710930873; c=relaxed/simple;
	bh=c2qwBaEAkvbEUyY0YDnRtDFz4GLo9+HrEfmU9+SQqM4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=duCegQmk1Q4R9ZS+0LqF4XGRSNrM3Fh+ghhoGoxuE8YfyZBRcWhRS6I7z6NA0ro1s/2rad96rFag06suluHDeCPuKnDcXvb1DqQzoP4aUH5hO9RX84FrQv8lBz3g2N0A2c/+2nY35oyz1RudGAUDt/hLaKqKvv311auOpgjkRWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gzsNQH2w; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-56b93b45779so2373280a12.1;
        Wed, 20 Mar 2024 03:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710930870; x=1711535670; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hkpqB38okF0AS/joA9j11d3DqIdtmpnIBh1u8NLndE0=;
        b=gzsNQH2wpo/92QmfvqjpKwnLGGdXDy46WCYYzPopi0srGe0jV8RYsYapc0aNQx75bh
         ldn4tcbI2sx0TcraR1CgH6B8dVcG2kg84UwhSEZZ5JMs7YCegAPBBHjcAdKiA01egmEH
         rauzTozzRY3D9vzmsBDvGM8nxTDvB1NPxaUXWUB29Norni/sortGwDcLPQwAkyTJX11v
         XmmVpYiOsYk7EJT9Wcq48rRmrjLr31U5vnltosuexyqwehycr1VdIoOS5InZCCFmCETB
         lHEAZQf6LwVkoBdGEN9vur9MCP495mIyNALIMxtlYGy61NvmuzVdZgYTMDWYdaHat+hl
         eWxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710930870; x=1711535670;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hkpqB38okF0AS/joA9j11d3DqIdtmpnIBh1u8NLndE0=;
        b=Tz5WJDPspNVVJUscIY3M89+LqeZABtpr5BerfS+pjWHHWDGdIByOuxdNvD9BoNIXfq
         ARXTMrhEJKB3Y2Bbr75iEeG/AWKfW1jaEacZ5/5unrwg0TL3XFEJrBCA4oc3ICZL0kJc
         wP7S3b3vJhOqH9DoLdgg2mrlUJSzDGUYigIpgRo8lyTgLC10GjIgdYKKQOhKLRmEpjie
         orjcD2aD2f8vPV+KY9KvgnkyQH88+ZV5qHjC3/h5NgVr+KJKUi8GP1o5QH7IRqiYHjPP
         sWZduk3YZJjAoE0sZKf7ZzdZhM4C2DP2iE97gqqBPvWINucxXRKxLcpotZ4GVh29NlYg
         qrtA==
X-Forwarded-Encrypted: i=1; AJvYcCUtQ848aVu3C8YclW0heu2UvN3RvKNMM/QfslzRCaNjEA7JDYrSmHidkMNF5p3Vj3kiB00yngt/caCSuPvWLry0CjOrwtX9ruFjyRzGwYL2K+vWG4Ltqr99m5hQclJJt4cCDKAkkhscsA==
X-Gm-Message-State: AOJu0Yw5mp4Cl7P72zVkw8WsITfkdAXZz/0USypbFJFOIjegD17yUxvH
	rV0fLH77YPg4syMLljmPyyYog7Edq9P6ge2uzTlc5dkrBulGURgciEesb6TXQi2mO1X6IHMD2sB
	Psn5rq0TjMacAws13VcUc6GDV6Pzx83MY6/Q=
X-Google-Smtp-Source: AGHT+IFXqVQ4u+NZd5Tof4gd+xKd3yOdecnFDWzX35wyiS18HrSZBTCyGE9DH0BfxP91KX7qkZTxBOniydTH8aMyfRA=
X-Received: by 2002:a17:906:6582:b0:a44:277c:1683 with SMTP id
 x2-20020a170906658200b00a44277c1683mr11849267ejn.53.1710930870036; Wed, 20
 Mar 2024 03:34:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240320073344.1563102-1-peng.fan@oss.nxp.com>
In-Reply-To: <20240320073344.1563102-1-peng.fan@oss.nxp.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 20 Mar 2024 12:33:53 +0200
Message-ID: <CAHp75Vf1K8c+7O5Cga3t+WiiSkk-yk_gATGJrMZ8rnPPtWLkWQ@mail.gmail.com>
Subject: Re: [PATCH V2] gpiolib: use dev_err() when gpiod_configure_flags failed
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: linus.walleij@linaro.org, brgl@bgdev.pl, andy@kernel.org, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Peng Fan <peng.fan@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 20, 2024 at 9:25=E2=80=AFAM Peng Fan (OSS) <peng.fan@oss.nxp.co=
m> wrote:
>
> From: Peng Fan <peng.fan@nxp.com>
>
> When gpio-ranges property was missed to be added in the gpio node,
> using dev_err() to show an error message will helping to locate issues
> easier.

I'm not convinced, so not my call to approve / reject, but see a remark bel=
ow.

..

>         ret =3D gpiod_configure_flags(desc, con_id, lookupflags, flags);
>         if (ret < 0) {
> -               dev_dbg(consumer, "setup of GPIO %s failed\n", con_id);
> +               dev_err(consumer, "setup of GPIO %s failed: %d\n", con_id=
, ret);
>                 gpiod_put(desc);
>                 return ERR_PTR(ret);

While at it, can you move it to be after the gpiod_put()?

>         }

--=20
With Best Regards,
Andy Shevchenko

