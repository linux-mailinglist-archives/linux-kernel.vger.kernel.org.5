Return-Path: <linux-kernel+bounces-149215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 029238A8D43
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 22:50:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 859EDB2442B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 20:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3378F481A7;
	Wed, 17 Apr 2024 20:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GX7Kzbh3"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A1EEAC8;
	Wed, 17 Apr 2024 20:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713387004; cv=none; b=MHqcd6wwgyNPwNb2op3tBBf0G+IJxiZxMIxNseAhpqdzMZdppXASnJ4XGj7LIBP6KjO2dZs9mHZWaxG+w42B4EYggvQSp9JcImr7T5/TEvwKiyNEGGkFUhCCz+yg5lY520iGNaBWQq6JFLxK8flcMffEHojNyGqlEJbVvh5v1Zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713387004; c=relaxed/simple;
	bh=t6VcluM2g/Mu+jFisa9J/W3a8G4RAcSvmnsCy3JyYe8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FypZbu3EOKBsb0FQCGF8QmJpXwgH47bIQCA8P4d2+JdsJEcD6hZ221u0q93MNidBuOhsY4TvBphzp1rePCXtxhHZ4mGkI7V5k8dLQBgO8d7mgb4zF7LNvMlnr1xC7BnI4hQObkmg69hEkAozojamx7gt6qveT2gLfp8Ju2F35bE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GX7Kzbh3; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-56e2c1650d8so128783a12.0;
        Wed, 17 Apr 2024 13:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713387001; x=1713991801; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t6VcluM2g/Mu+jFisa9J/W3a8G4RAcSvmnsCy3JyYe8=;
        b=GX7Kzbh31rWCoZI97HFpP1fslezFBkDC51TfrdR9HCUs0POhMxXfPX4wl4eOAoKQii
         2JMAk7Y51iNNLvIqgrHu3lp48Xsv+yuKK2wR95QUIsJpn+fkZvXj2X012OvR+hcE3X4a
         MBQXJGh8HAi3hbOI5omnySWtXKNGc7nY+EyZVjbKDmdp2yxtRZrk5kOUERLizsYwRi8u
         q39/1zxq8qgptccJexjdfJ1ktMkCKN2kF3Zf5WKSH0IivQiPR/zRIBT31I83N9U81lmr
         MEHwtPkXjYXmZ64iSa/JKcBQP41Eisxdc7CrfMKXy0RWkLGC+Div4Dah0QlnmuBhdfwr
         9p1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713387001; x=1713991801;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t6VcluM2g/Mu+jFisa9J/W3a8G4RAcSvmnsCy3JyYe8=;
        b=j78Kk1KQFbcidtqtKSc/DxCDyc8/d9EmGOWR/Rg15pZrw5HiluYYJ5lMUeFgCR4gsT
         o11XTaO76XdPs4qq5IKtlMRiWhhIrSSDsh+G2tE5bIwapR/oV2l66r1ov7lCCmiLax3j
         iTQUAIJcksNbwklgFtYhYHA5AhjdSrJKXRrbT01d0NxYGGnBGXUdLHfvy4ZO2l0GRozY
         DgetWq5M9UyZBm1l1ExfpYODIRMiu07/f/P5tv21c819SIdB0xX3Xov0Evs7YVSEWdVs
         VsE6RJ9n5/hhlitT9yyP+9/J3cL2BKMmrwivCof8SpVEacY+DYD2ekNkRgmff7EreCas
         h+Kw==
X-Forwarded-Encrypted: i=1; AJvYcCXaKIg/QTJbAVsxmR2VNh1/j3WPS+vg4Sa4jC5bKok+baQ77rLnubC2qXSp9HFa8HJfTj869dLu5t17dy1c4157WGujaNDOA25kHQZfqKUUMdawOpxQJzKrmmHkVz7MKle0UYI4E4kYqw==
X-Gm-Message-State: AOJu0Yxab+v/TXW3ZXKaWdchOOFnKm7Fjq+Jd/N4eDSLsRG/dtAOuxA5
	LgANGob8mY8p69c52crrlU90yEcnCILIrwJxRPtyRLqEvGEzI+tFvvkIyixTZJP3fKNSrK5Eejc
	WGx5zMWVCm3gRl1Yzmj/dmExYKX8=
X-Google-Smtp-Source: AGHT+IFA8KNHMlNf/iAxCcPVh3Su8L1Ji2NTnzwGJKbUlfmLRFAeyN7nHywkOQ5MbRQlFk6S+nmLKPAf4SAE5xt18pU=
X-Received: by 2002:a17:906:717:b0:a55:5516:39fa with SMTP id
 y23-20020a170906071700b00a55551639famr355938ejb.64.1713387001149; Wed, 17 Apr
 2024 13:50:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240410072102.1200869-1-andy.shevchenko@gmail.com>
 <ZhpC3lLD-BHqJEZz@ishi> <CAMRc=MerqbYue_uubSkr0ta3wr+yQxfFMfk+vAUZa+C2oR+udQ@mail.gmail.com>
 <CAHp75VcofgAQLFVLdsA-A1AkjVzQBJWtam=w00+z9-rueZyv8A@mail.gmail.com>
 <CAMRc=MejJTnawn1=_x9Va-QJRctjoc3TJanVqQ0uZbpmDzpyjw@mail.gmail.com>
 <CAHp75VcXoEhxA+qO=MMoUanZeCP5hPXd9q7n-8AuRrotEfbYFw@mail.gmail.com> <CAMRc=McrxEeS-BdgSEswJ+x_qDYJ7Gn_fKP8n-ctCzk2BuP29A@mail.gmail.com>
In-Reply-To: <CAMRc=McrxEeS-BdgSEswJ+x_qDYJ7Gn_fKP8n-ctCzk2BuP29A@mail.gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 17 Apr 2024 23:49:25 +0300
Message-ID: <CAHp75VdDRYU7UguQQSm+QTRPMpsteno2pEQ2kz_03cEjFatJXg@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] gpio: sch: Switch to memory mapped IO accessors
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: William Breathitt Gray <wbg@kernel.org>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Andy Shevchenko <andy@kernel.org>, 
	Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 17, 2024 at 11:46=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl=
> wrote:
> On Wed, Apr 17, 2024 at 10:41=E2=80=AFPM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > On Wed, Apr 17, 2024 at 9:19=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev=
pl> wrote:
> > > On Wed, Apr 17, 2024 at 10:05=E2=80=AFAM Andy Shevchenko
> > > <andy.shevchenko@gmail.com> wrote:
> > > > On Wed, Apr 17, 2024 at 12:17=E2=80=AFAM Bartosz Golaszewski <brgl@=
bgdev.pl> wrote:
> > > > > On Sat, Apr 13, 2024 at 10:31=E2=80=AFAM William Breathitt Gray <=
wbg@kernel.org> wrote:

..

> > > > > I applied it as is, if anyone wants it, this can be sent on top o=
f it.
> > > >
> > > > Thanks, but I assumed this should go via my tree and as PR to you. =
At
> > > > least I have it already in my for-next.
> > >
> > > You didn't respond in any way about picking it up.
> >
> > Hmm... I'm the author of it and I'm a maintainer for that driver. I'm
> > not sure if it's mandatory to respond for that purpose. Usually I
> > asked the opposite, i.e. when I'm not going to pick the thing up.
> >
> > > Can you just drop
> > > it from your branch?
> >
> > It's possible, but I will need to rebase, which is not a good thing to
> > perform. What about just leaving it as is and letting git to (nicely)
> > solve this?
>
> It won't be solved nicely, we'll get a warning about the same commit
> appearing twice with different hashes.

Oh, this sounds like a new check in Linux Next? Or somewhere else?

> Whatever, I dropped it from my tree, it was the HEAD anyway.

Thank you!

--=20
With Best Regards,
Andy Shevchenko

