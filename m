Return-Path: <linux-kernel+bounces-65832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA71C85529A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 19:48:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD2281C21B8A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 18:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AD57138488;
	Wed, 14 Feb 2024 18:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RT44B/rs"
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E20F134738
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 18:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707936525; cv=none; b=cnYbBWj6IA40OWE8UCoe2LPV1M6pj55gXaSMzUjJMD/1w8nbIXtHffCEkpw+Kk/PZNlOlMYaQFni1qMU9a+Ul5Z/jS38XC1iD78iBLyOiqpKCY78J7y6NFHNju/nGLWPGsVP+frdpJnWR7+8Y0FiZi2XAzzGPGnOBqClNdVmDJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707936525; c=relaxed/simple;
	bh=3/R/erT++Rcj1T7TQq1/HhtyldOKCqwUtdZjFCgSzhE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pRHThGYq/U+19N7E8WtM3XsCB6aFtycaJSAbXjMqhbczwZcy5zrjYZAa0pk+cDP+EI8Sai+oF7urKPsO8p6svb1CRoCuv/dNBYSFQkWOnhawul91thSiOQdoZawgtuah0HUKhtbqWEj/zuuyuegRppPGsMbdqIUwXFRhH1A6IuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RT44B/rs; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-dc745927098so4941681276.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 10:48:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707936523; x=1708541323; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3/R/erT++Rcj1T7TQq1/HhtyldOKCqwUtdZjFCgSzhE=;
        b=RT44B/rsIlOfkCw8s3q0eM9duuNbREw69bD3jeZVKnmpitsZfTuGmlx2MY/VfAkTxP
         1NukZnCxg8ZwJY0y1ZPlbamV6awUOQDCZy7urrKAdufFMg/vWqh5sE4PzVJAWcp0Y7Nm
         Q+NQCvVF9hjVpwCEwz8HO7BzXa00pyV+BbzQ8aG4Bj/AbHFqVWog7mBGy9DQG//6kC0C
         /kiQGfABKpiJzv+Mzev5FMWc3StJX1verRYSlFjMbnY77tiSVT2JvL0DAvpJHCDDMnp0
         OAni0WjIOfcIzeoAsjk7djzgULotEPLQds2juNj4u9PbsvtHhiaC4EiiPlKbgqBMzzVG
         mbJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707936523; x=1708541323;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3/R/erT++Rcj1T7TQq1/HhtyldOKCqwUtdZjFCgSzhE=;
        b=R5bX+dHHwQCekCbvX2WWr/xJlToBJcFlX9VB9lvNaEya3La70sY3TL8TFCOK5oKin1
         0CgFoWuc9GthntK0xFjObnwpPKYYDMv9DVzgi9wgh4hRXpqNQ1XqryoyHH3u5WrUXWKv
         gXqeKzsiRYe/H+aJ8/tIZuDt7S+uGcmfcL29SSVjqmd1haPngqPtTjGrE2SH04yMQ7xK
         tonweO0lR+7GffvxOE8hTJOXpMCnVuVAcVvtCNZEroB7g/15XeagBA0j1QYlPc2BigMX
         Gg1EFYirMwFsXp43IK8fHIvvLnf+lv4ahNLy3fRauYiLDrVdWX/I/1zQMEWd76UqzXwL
         RC5Q==
X-Forwarded-Encrypted: i=1; AJvYcCV19PNSY2OyNQ9733ixoyohjW2OGnLlpNv9ch2nLXnGs85ITmfKvlHXheDSh2BTBz7k02O9E5nB1sNy04GGrzP+kgZqzB5Gw3EniYse
X-Gm-Message-State: AOJu0YzxnlvdKYkEOy7ARHskbYnUzUzX5humyqZpMYBd4TvZ5QVh367Q
	CpejIRcdvliV2gmFLfjly/e6CRgbfnZS/0iiIpFSzgO5QwUZ69tgGV9Rjk6tC5lfQhBJz39XH2h
	1ok5j4B0na2aU1dKASSWdzyZbXdI=
X-Google-Smtp-Source: AGHT+IGHfqvl3LMR8EEDi8+yJy/tvGYLLH5XqVYrHAv7DIxc/wDgqHyCwfLqr2P7SbYADKbqGW5vT7pJ4rBbrl+Qrgs=
X-Received: by 2002:a25:d810:0:b0:dcb:d653:8ad9 with SMTP id
 p16-20020a25d810000000b00dcbd6538ad9mr3210955ybg.12.1707936522979; Wed, 14
 Feb 2024 10:48:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240212132515.2660837-2-andriy.shevchenko@linux.intel.com>
 <20240212132515.2660837-4-andriy.shevchenko@linux.intel.com>
 <Zcoe9axtLXxB7Jeo@smile.fi.intel.com> <CAMuHMdUJ4gSGo4A0BVGkieWvNyqa9Dv_rQVMFj9N8GWYoKCZVg@mail.gmail.com>
 <CANiq72muoZHzX+qNKabYWnH738okKqrfAruUOpY-4WUJBLP=Yw@mail.gmail.com>
 <Zcz7Cfc5XSM2MtKV@smile.fi.intel.com> <CANiq72ntYrPyybUDavPuT+anrwfjPb27P8VbL+toMvyp8K293w@mail.gmail.com>
 <Zcz9WNXpRzv8THKW@smile.fi.intel.com>
In-Reply-To: <Zcz9WNXpRzv8THKW@smile.fi.intel.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 14 Feb 2024 19:48:31 +0100
Message-ID: <CANiq72mYMztZG5Y5v6m+h2xroDFyyf0Kn7aZ2D7p6p4k_YtTcw@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] auxdisplay: Move cfag12864b.h to the subsystem folder
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	linux-kernel@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 14, 2024 at 6:50=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> It's a standard practice in the Linux kernel development.
> If it's not a so critical issue, why should we rebase?
>
> rebasing will break SHA sums and it's not appreciated especially at the l=
ate
> rcX weeks. Linus can even refuse to accept a PR based on this fact.

I am well aware of what rebasing does and the rules for PRs to Linus, thank=
 you.

First of all, you should have not applied the patch this quickly.
Nobody gave a tag for it and you yourself are the author. Even if
someone gave you a tag, 2 days is way too little time for something
like auxdisplay. 2 weeks would be a more reasonable time frame.

The point is: you seem to be rejecting feedback on the basis that you
already applied a patch that you yourself authored 2 days ago. Not
good.

Now, for branches in linux-next, what you should avoid is rebasing
wildly, but you can still do so if needed. If you are uncomfortable
with that, then you should avoid rushing patches to begin with so that
you don't have to do that.

Regarding PRs to Linus, we are still in -rc4. There is plenty of time
to bake things in `linux-next`. Unless you meant to sent this to a -rc
release. But in that case: 1) there is no rush, 2) please see the
first point again.

Cheers,
Miguel

