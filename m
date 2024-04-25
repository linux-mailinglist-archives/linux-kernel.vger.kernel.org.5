Return-Path: <linux-kernel+bounces-159118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63EFE8B29A1
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 22:22:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E889D1F2313A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 20:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F60E153510;
	Thu, 25 Apr 2024 20:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=atishpatra.org header.i=@atishpatra.org header.b="MuTr2/Bv"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B99A15250D
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 20:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714076544; cv=none; b=C4vOsHfZjYPwlsSufSFrBiR7eG115clZs0EpOz9541NNcc2tjVH7yZlrnFuJ/PK6BWhmbmlxa7qXhK56CsI2X5OwoCqVIlgqToiSkyItLyEkb+3rpWlCCJXG8cxgeXmb+gML5qR8VhJ/Mz3cLt0PbV2FzPvXyDQJrJiwXMz9zMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714076544; c=relaxed/simple;
	bh=41YtzbVRrCg3XTTkSACQriKeXiqHI+7Llqjp7Wbx6M8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ENCvWAI/tzcb0Fzo2+jc4h6fk25909N5etm0V/2P6jv25kGuWqJ81pM+tetuLmXuyrVl3mWPnonuV/74iELhPTtutR32yn7D4AGKSoxG8FmlNxSa/J+pmzM2oiMxe5Krci1CLcZsRWM5n8GIixGi36g43sriE98Q90iA22BbJo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atishpatra.org; spf=pass smtp.mailfrom=atishpatra.org; dkim=pass (1024-bit key) header.d=atishpatra.org header.i=@atishpatra.org header.b=MuTr2/Bv; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atishpatra.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atishpatra.org
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2dae975d0dcso26078751fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 13:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google; t=1714076540; x=1714681340; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jqqSigyROQSHlUq3V4XKgpMi7kpUzFBPzo0oPCMdIRM=;
        b=MuTr2/BvwbDzZNJFMo5mmPEfXPy+1OgmNtQvPx/plFLVvvAwJz1p88W7350zeHZSoc
         EdOsJ9Met5Rk0YR2qgWWPPkInak9bRB4AMMy+rs8cZMVaZz8ZzAfM5aX5+jINk4DmJU3
         LbkrjIH6DwtObUIgvZsQXofjx0lH4IKyXqCNk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714076540; x=1714681340;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jqqSigyROQSHlUq3V4XKgpMi7kpUzFBPzo0oPCMdIRM=;
        b=o6akrFDN/N73H3o9lUHmMrZ6O5fPPrm9em+7JTzEfzmUZ9QxQ8WW7Si/i5So7vz7xo
         Ipd1Ihh2lzDxXqJqlQry5+PL7/lF8nr2/x+1C7JFZsMz1v47zVWDRAeNiTYJwX5AjYi+
         zWzJb6i9tVDQX1Vg7A8DgUc/tlZsFKtMmoLhRq8dweZCbwMK7FfwRy0HQBjeUGF/XKwC
         POgi7XzHnacGFvAaiTZk9tNtvXiwfohQjyiScvdH5oAbqi/42ttaHSfj2HrtR2qAO2oi
         VH+8Yu/HqDUiV61zqTLsS4X17amQbEKfbiAsHlPUyj06uwHS9ZLsqYD96ZIj0gimLrHb
         +L+A==
X-Forwarded-Encrypted: i=1; AJvYcCW2J2wIQfMN9E9pycdcSF2zcJpWAklFpkFatAh0+wnnfYgaiShEQ5pbgmnpyumbdUkDaMpZnCD9Nf+ReW7H0eD/90Jhb5N6sJWEbXSr
X-Gm-Message-State: AOJu0Yw4kkiVKwD6RnT3vOgfjk59I8UCoRa6axCOZx1mvOoGLv35VFp6
	U5gg2B8Sc4AnME4YwTTpi3R8U5bvvV5Qb+V+q64Gf8HrN7R5c7rICPhdk87UHoQoOFuQisvKYpS
	bBFHXqyrkqPq1RMybIuGPgzhvqg3dsmA68nvV
X-Google-Smtp-Source: AGHT+IFAS0Vx6zJ8q71LCwUAqEEt2U8m/AKyfn45JERsHJeTEw6P8lopex0Wp1m7BwKSb0wEkMNTAMNCEUYMhcMmQ18=
X-Received: by 2002:a2e:2e15:0:b0:2d8:79d6:454d with SMTP id
 u21-20020a2e2e15000000b002d879d6454dmr242743lju.23.1714076539984; Thu, 25 Apr
 2024 13:22:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240425232933.4111680-1-atishp@rivosinc.com> <20240425232933.4111680-2-atishp@rivosinc.com>
 <d2742ee1-7e3c-4c0d-8172-d3543fe78e5e@sifive.com>
In-Reply-To: <d2742ee1-7e3c-4c0d-8172-d3543fe78e5e@sifive.com>
From: Atish Patra <atishp@atishpatra.org>
Date: Thu, 25 Apr 2024 13:22:08 -0700
Message-ID: <CAOnJCUKtEZxK4TdL7G6zXBWDibFUwHMNz9cDcMMRT3p9jTrXkQ@mail.gmail.com>
Subject: Re: [kvm-riscv/for-next 1/2] drivers/perf: riscv: Remove the warning
 from stop function
To: Samuel Holland <samuel.holland@sifive.com>
Cc: Atish Patra <atishp@rivosinc.com>, linux-kernel@vger.kernel.org, 
	Alexandre Ghiti <alexghiti@rivosinc.com>, Andrew Jones <ajones@ventanamicro.com>, 
	Anup Patel <anup@brainfault.org>, Conor Dooley <conor.dooley@microchip.com>, 
	linux-riscv@lists.infradead.org, kvm-riscv@lists.infradead.org, 
	Mark Rutland <mark.rutland@arm.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 25, 2024 at 1:08=E2=80=AFPM Samuel Holland
<samuel.holland@sifive.com> wrote:
>
> On 2024-04-25 6:29 PM, Atish Patra wrote:
> > The warning message was initially added just to indicate that counter
> > stop function is being called while the event is already stopped.
> >
> > However, we update the state to stopped case now in an overflow handler
> > after stopping the counter. If there is another child overflow handler
> > is registered (e.g kvm) it may call stop again which will trigger the
> > warning.
> >
> > Fixes : commit 22f5dac41004d ("drivers/perf: riscv: Implement SBI PMU s=
napshot function")
>
> This may be intentional, since you wanted these to be squashed, but this =
isn't
> the right format for a Fixes: tag (no space before ":" and no "commit"). =
Otherwise,
>

Yeah. Just wanted to be explicit as the commit is based on kvm-riscv
queue and not based on upstream commit.

> Reviewed-by: Samuel Holland <samuel.holland@sifive.com>
>
> > Signed-off-by: Atish Patra <atishp@rivosinc.com>
> > ---
> >  drivers/perf/riscv_pmu.c | 2 --
> >  1 file changed, 2 deletions(-)
> >
> > diff --git a/drivers/perf/riscv_pmu.c b/drivers/perf/riscv_pmu.c
> > index 36d348753d05..78c490e0505a 100644
> > --- a/drivers/perf/riscv_pmu.c
> > +++ b/drivers/perf/riscv_pmu.c
> > @@ -191,8 +191,6 @@ void riscv_pmu_stop(struct perf_event *event, int f=
lags)
> >       struct hw_perf_event *hwc =3D &event->hw;
> >       struct riscv_pmu *rvpmu =3D to_riscv_pmu(event->pmu);
> >
> > -     WARN_ON_ONCE(hwc->state & PERF_HES_STOPPED);
> > -
> >       if (!(hwc->state & PERF_HES_STOPPED)) {
> >               if (rvpmu->ctr_stop) {
> >                       rvpmu->ctr_stop(event, 0);
>


--=20
Regards,
Atish

