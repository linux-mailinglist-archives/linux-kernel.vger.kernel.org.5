Return-Path: <linux-kernel+bounces-162677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 132A08B5EE2
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 18:22:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C150E283FB8
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 16:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 612F484D1D;
	Mon, 29 Apr 2024 16:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="gXWJHXrs"
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 651B7824AA
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 16:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714407759; cv=none; b=Bq2Z8Wvhw5O0O6V18j1ajct1zm+RGfaU59bR3Jd5CfRpwtju9rkvfbCGH6D6kYCW5fi9bbG7QMe24QYcZvnaDhx2lCYE+OpUD24WCoqZIl+cKauzVrLy0Jl3AaSi3EOTpGzD8b3AUIpbCUYmIq8c59moKsOt/aDHMds1N9uEVtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714407759; c=relaxed/simple;
	bh=u0+/7vXRxiPmei0+kpf17a4ntZLaXDuHi6UGR+lOk/Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QtG3tS1xgSmOdituFBAJQUG/iGd9nWtbDM9XOVPhBLtDSdJFdKY2BWzDi1zmw+qQpA1UkFNl6HKouYM4ecbM6MFgkMVlYl6QMi5yyceXYlwsDz5iUcfdvGDrXxs/dPbn59yEhjgjxnhqgD+htW7d2sQERqPRf7PQ9/5GzlobtMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=gXWJHXrs; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5af27a0dde1so2964132eaf.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 09:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1714407756; x=1715012556; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZFh9S8iYJPFidlD2u3WsMVkPvkc/JSLTc7zLKFIpkEo=;
        b=gXWJHXrsZOEnbVt2QKFadctgumwxQslwZLFt5FLI7/SsKhAtUqbQ7/YwpzrCAoXsks
         DBC4QaRByfgkNiR1tENzUC+Piw9P6SwE+KdcNv6fRJotMrqVm6cn2NUxBUydlIxHKdKy
         vmbCodz6ZqyIraPnXo1bjI7AKipTu7OFx/jbkvG/nCmWQ/s1TYrTcS8pwliThYqX9LcS
         4/WCR5Myo2FpBsJmGMRcLan4Q13vSE7cxj6pqvQDw4gqMbUUny07Nnsp/Jd9B0PyqwI/
         bhkPLYqyAge/Q3gjK8RpKa1I3OK8IO8UnsSg2AAxDNB700hEuf2evR5eUKOjS+6nDO6D
         NYxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714407756; x=1715012556;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZFh9S8iYJPFidlD2u3WsMVkPvkc/JSLTc7zLKFIpkEo=;
        b=U9gAgEe0WDlFmC6nz71xnVFDsGRTbWfzNqYHpUaDMgvao2KME2bYWPr03s1IEYkjs4
         fTv3pI3b1May5Hk7ZpPso1PEFs+GJbUJaXxmqsLROfkwXXCpSGRgH5SOk/dgNsytySGh
         SvmfsyklO6Qq6MgHwDdQCRGJh+ph8W99p1NqJBHfELpID59X6T6eAJb0eGV1epKHE5S9
         vMzj3VJ5Bb5/K/fjWzNvRyCdmMacDz+g5VEnAarhiRhOdlRbPvKfsUJZPXIgmYtpoQWI
         oY3J5j3tlkoK+b+ob+mylmhK7fslNipCuxo8+9y+VLwpzGg0xNTdpyAZi7J5Ee8Pr1H0
         WoTA==
X-Forwarded-Encrypted: i=1; AJvYcCWsagA6WCgWv1zqDqYkb7fCDN+v7Yy0NwgNrUzZCwrqFKikSt4HIt5qDgsMr2seOX8LTdKp0bEPxEuhKAsOqJvZtjqlus84LRymKUQV
X-Gm-Message-State: AOJu0YxvlUqMDKtwzE7sAZ0tVPOBvILfYpP99e7jD6w8ruVizNXajrVX
	oN37rl+BnCeXeqkV/O2nRr9oDVTgSvHGVV0eSlQ32g1YvpbYpQQ10bDHq2wjz/A2V3F64MbXhWn
	dmPe0Ch5GczBJa7A0rGEsRPJDYm4rhJONqZg41Q==
X-Google-Smtp-Source: AGHT+IFKgLGHx+BKJCv5SD2jm/e2+vh+LMFxfwH0dJjRXsjjJLUlmmNC4x7PzAmlyxFpMw53xJhAl3d5oxwc0MIYzj4=
X-Received: by 2002:a4a:44c6:0:b0:5ac:9f86:cc0d with SMTP id
 o189-20020a4a44c6000000b005ac9f86cc0dmr12775696ooa.6.1714407756077; Mon, 29
 Apr 2024 09:22:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240226065113.1690534-1-nick.hu@sifive.com> <CAPDyKFph3WsZMmALnzBQKE4S_80Ji5h386Wi0vHda37QUsjMtg@mail.gmail.com>
In-Reply-To: <CAPDyKFph3WsZMmALnzBQKE4S_80Ji5h386Wi0vHda37QUsjMtg@mail.gmail.com>
From: Nick Hu <nick.hu@sifive.com>
Date: Tue, 30 Apr 2024 00:22:25 +0800
Message-ID: <CAKddAkDcdaXKzpcKN=LCCx9S4Trv+joLX2s=nyhzaRtM5HorqA@mail.gmail.com>
Subject: Re: [PATCH] cpuidle: riscv-sbi: Add cluster_pm_enter()/exit()
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: palmer@dabbelt.com, anup@brainfault.org, rafael@kernel.org, 
	daniel.lezcano@linaro.org, paul.walmsley@sifive.com, linux-pm@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	zong.li@sifive.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ulf

On Mon, Apr 29, 2024 at 10:32=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.or=
g> wrote:
>
> On Mon, 26 Feb 2024 at 07:51, Nick Hu <nick.hu@sifive.com> wrote:
> >
> > When the cpus in the same cluster are all in the idle state, the kernel
> > might put the cluster into a deeper low power state. Call the
> > cluster_pm_enter() before entering the low power state and call the
> > cluster_pm_exit() after the cluster woken up.
> >
> > Signed-off-by: Nick Hu <nick.hu@sifive.com>
>
> I was not cced this patch, but noticed that this patch got queued up
> recently. Sorry for not noticing earlier.
>
> If not too late, can you please drop/revert it? We should really move
> away from the CPU cluster notifiers. See more information below.
>
> > ---
> >  drivers/cpuidle/cpuidle-riscv-sbi.c | 24 ++++++++++++++++++++++--
> >  1 file changed, 22 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/cpuidle/cpuidle-riscv-sbi.c b/drivers/cpuidle/cpui=
dle-riscv-sbi.c
> > index e8094fc92491..298dc76a00cf 100644
> > --- a/drivers/cpuidle/cpuidle-riscv-sbi.c
> > +++ b/drivers/cpuidle/cpuidle-riscv-sbi.c
> > @@ -394,6 +394,7 @@ static int sbi_cpuidle_pd_power_off(struct generic_=
pm_domain *pd)
> >  {
> >         struct genpd_power_state *state =3D &pd->states[pd->state_idx];
> >         u32 *pd_state;
> > +       int ret;
> >
> >         if (!state->data)
> >                 return 0;
> > @@ -401,6 +402,10 @@ static int sbi_cpuidle_pd_power_off(struct generic=
_pm_domain *pd)
> >         if (!sbi_cpuidle_pd_allow_domain_state)
> >                 return -EBUSY;
> >
> > +       ret =3D cpu_cluster_pm_enter();
> > +       if (ret)
> > +               return ret;
>
> Rather than using the CPU cluster notifiers, consumers of the genpd
> can register themselves to receive genpd on/off notifiers.
>
> In other words, none of this should be needed, right?
>
Thanks for the feedback!
Maybe I miss something, I'm wondering about a case like below:
If we have a shared L2 cache controller inside the cpu cluster power
domain and we add this controller to be a consumer of the power
domain, Shouldn't the genpd invoke the domain idle only after the
shared L2 cache controller is suspended?
Is there a way that we can put the L2 cache down while all cpus in the
same cluster are idle?
> [...]
>
> Kind regards
> Uffe

