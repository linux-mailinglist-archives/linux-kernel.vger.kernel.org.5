Return-Path: <linux-kernel+bounces-94738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35211874491
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 00:42:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 671131C20886
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 23:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8F7E2577C;
	Wed,  6 Mar 2024 23:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xRbB9T79"
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 992051F932
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 23:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709768212; cv=none; b=IBjngEPAzls3yVuezfejgRO63iKp9bsdaQU+JBQFFwc5m5xdcYVtn2R1r/Qfm2tw86yRLI1iwJbM04PzW/HK8Omi1JJqt5AeT97mLdnGUXpPxfx4h6O2Gww4XkC3O+G+39Wfw3cQfX0wM/JLfWc/ehyTbJVPDbT8HKUbUkJXUec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709768212; c=relaxed/simple;
	bh=+Nx50Rnz3/XlK68LVUNUHXjbzKpSnQZRHmH74zypZtI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NCmXRsokp0PL7+rWMFddJHu8SuVdjF2cWytu1jvxjvnKFHwAHwokvF4W4+9Jg4BqGHLHlIEVQgucTQ/MnJoMLAk3di0gBiIZtlB/qTUCWj9x8/S7JPoeoaDZAN3nT9UN5bZ6+aun2hSZpREIHaMlkvRzXqYs1uD2D2mKYAUrLlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xRbB9T79; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-dc23bf7e5aaso279192276.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 15:36:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709768209; x=1710373009; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wpPCiCH5cmwsa/faM+4qtvxNPZ93fb+FSCJztY7spGA=;
        b=xRbB9T79BbpD9HOviY1Quww4okCcuL94pvvt1yRqSUbCq2LdN1Y59BDikmtnPLSCaC
         EGMMn/5SVmMC9AwyUClYCN0bZQiqVJW7iA+yWGzVMdo8e+Uy34b3tY1MjgrIU1e27lqy
         ZCOFgsTltPAv8QLlE2hMlB/fKBefdoQCOZoQhPV/hvU63F+6O4FaCXZUJ7l+4dlz+utS
         neYtxU3cpeIBfxktl0XvlygATJ5zpBR33IEQTd9Xsx+3tENo8RhfdxSB1nTeGl+T+xbp
         PBJ2BhreOP2XKXBacoT2Fb8Y1ZRBJksZxZxei7pyQxjXnFZxieRYhyNZTtVysTsobtpZ
         7Gqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709768209; x=1710373009;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wpPCiCH5cmwsa/faM+4qtvxNPZ93fb+FSCJztY7spGA=;
        b=PCy1OBjfJSeN6KXQWcF3vq5G56OIvLzSewAz5GMu52LXDaq9mLagP3HOAJEoWYiOuc
         QocAb6ebq8XNoCYkcfuRUdbVVuaWghGP6BAs3g/fUneNUEfpE0sJnwxpk/lL/LAKmCOc
         ewGj82oGKKFwwf2xk5o5rnag+Td7BBRs4wRPRBfLvMOOxRah3NGINxlCXE4UG/MAs/lT
         vZQIR21Mkc97eBKLRpxPequmT/9XLfF3kiYinXKei9kc/zQHZCo1NTiHoHw9HUcMY+KQ
         fz8cIdYpa6IzL07n36JU4fUJy23oX+hf+biXkkhtManEEYFBEUP8uLGMfWStStEcjMna
         xlog==
X-Forwarded-Encrypted: i=1; AJvYcCUctccooSjkcqXrx7cFdwtIDRHcUXxXEV6QeqIdH59mZQI2Wsv5OnCOje8LARtFIvyNEDGMKXRU7O6EhRCtbddiXcLQVeXQFYbCwZEJ
X-Gm-Message-State: AOJu0YxlbL1MuzuF43tmLNHN58Y5mYU+eT77BSc/DwYLA/f67XF1Rjwx
	pFmbWVGEOeeKzXa/PDvuhk47nPDPTqAjvMy0es68Wy5yJ+xguNyzTjClDUoMfwRn6sK9TLArioo
	c096MZuHRiBae3aYY9YM/iTm0bM2ADkQGVN/rvQ==
X-Google-Smtp-Source: AGHT+IHxdBBSeU/FWJXQoU5bYG6J5Znkxe2V8jpauvmmd8v3jfVHkDn5L/goLsRDrRyEdQX+qgOtS/LXCu5NgOFa8hs=
X-Received: by 2002:a25:f30f:0:b0:dcd:6dea:5d34 with SMTP id
 c15-20020a25f30f000000b00dcd6dea5d34mr14988569ybs.36.1709768209672; Wed, 06
 Mar 2024 15:36:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+G9fYtddf2Fd3be+YShHP6CmSDNcn0ptW8qg+stUKW+Cn0rjQ@mail.gmail.com>
 <d5c07950-6f42-4ac9-b0d8-776d444252ae@app.fastmail.com> <CAPLW+4=T1eGrWQcEJWvOcHgq9tnRhfi=AH_=qj1022k2WHmEhA@mail.gmail.com>
 <CAPLW+4mVTvPBW0hd9pV6AsSezxPAhwPByq3WmGpprtseTgy-wg@mail.gmail.com>
In-Reply-To: <CAPLW+4mVTvPBW0hd9pV6AsSezxPAhwPByq3WmGpprtseTgy-wg@mail.gmail.com>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Wed, 6 Mar 2024 17:36:38 -0600
Message-ID: <CAPLW+4n=7ND_Jijfxzi018QwACGhJe4UX2VAuDUd1tuO97OHfw@mail.gmail.com>
Subject: Re: WinLink E850-96: WARNING: at block/blk-settings.c:204 blk_validate_limits
To: Arnd Bergmann <arnd@arndb.de>, Jaehoon Chung <jh80.chung@samsung.com>, 
	Christoph Hellwig <hch@lst.de>
Cc: Naresh Kamboju <naresh.kamboju@linaro.org>, linux-block <linux-block@vger.kernel.org>, 
	lkft-triage@lists.linaro.org, open list <linux-kernel@vger.kernel.org>, 
	Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>, 
	Ulf Hansson <ulf.hansson@linaro.org>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Anders Roxell <anders.roxell@linaro.org>, linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 1, 2024 at 3:18=E2=80=AFPM Sam Protsenko <semen.protsenko@linar=
o.org> wrote:
>

[snip]

>
> Sorry, just noticed I commented on the wrong line. Here is the change I m=
ade:
>
> -               mmc->max_seg_size =3D 0x1000;
> +               mmc->max_seg_size =3D PAGE_SIZE;
>
> for (host->use_dma =3D=3D TRANS_MODE_IDMAC) case.
>

Just submitted the fix [1]. Please review.

[1] https://lore.kernel.org/all/20240306232052.21317-1-semen.protsenko@lina=
ro.org/T/#u

> > [snip]

