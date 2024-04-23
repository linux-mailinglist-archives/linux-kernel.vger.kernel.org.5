Return-Path: <linux-kernel+bounces-154410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C46DE8ADBC6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 04:06:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E390282B95
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 02:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDCFE17543;
	Tue, 23 Apr 2024 02:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EpGiPlHo"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8204833FD
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 02:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713837996; cv=none; b=NEmK9/z+vLge3w03ztpzJu2LVfw5bxgJvhMzEIfHtcfhjx5tQ0Js+r6la6WlkRJphlXjxzVO/UB+e+0WZqMw+3eym//NTVddBj7IqYB6VuZx61K467E0wJ44cfyw9GZJJR9unU/Lu2x/lt1ABKgjA15773TfS2eVNbuw169gCQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713837996; c=relaxed/simple;
	bh=c2xonoCbADKF8/xTJiffDV6oZLP+9gnvZFV5ez6gLjI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tKtjgqiMo8p1txFD60Kbo1uzcSI1Csr50aB6hNKm4SqfmFLcbqP/4WG3qdYM+I3jmk90rG7jBhLceiBAL7f4ttnLuqEjTIwBkDTCcV8JwYS1e2nAIvRXqbwadGIEUxxYuC7Y67rLH0lJunxnQpZCDVEZnR8e2u8RueDG2GYV2eY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=EpGiPlHo; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-51ab4ee9df8so4994036e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 19:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1713837992; x=1714442792; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=waszPwSUwTOtETfRgHTu/kDUB/tVHu6WwyBPZl9yfsU=;
        b=EpGiPlHoY/3UhTLaqetCS75r+hTOqoqgYZknbBXjy4+5x+DmnRCQjmJh03QuEcCRS2
         Liy/FGWFGIBct/fNEn3QoMgFjfFYmK07a6nq5WUPIDCuafOu1Etna2uBCPd0x4pVikeQ
         tjF9oMyZ0krhe1Fzi3bErbVm2mGt2gLfPGf/Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713837992; x=1714442792;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=waszPwSUwTOtETfRgHTu/kDUB/tVHu6WwyBPZl9yfsU=;
        b=MFn+iLokMHhA/XS1bx6AGG6Hm8wKPRyy/8a1zh2vEPS1Bm9pCsRM8aZ2NKyPuvob+S
         NAuKhkq4ZwLYYouJ3+cDhbFCbVizZpqMkmhuH5YWN3JYHRyl952KWIi8sX6SCkWl3O2K
         XhQpzu9q9LbGBRLs9jZClHwx/z+K2mwQvRq9jEjts9rmN7MhdzFKVulhT6qzh2mNzQZf
         6Mro0u0AUqPEFfVvA+tKI/waNXLPFqMlNmrSFFBxej6MYxyoieb/TYXw1gnv1YjbdbbW
         pZDl467GMKC4A2B2KVOlUVC3OHS9rOefim2fAgvH50KKsSivNslV1fuN98UZuDDMcZQk
         aybA==
X-Gm-Message-State: AOJu0Ywl+JvccO3XHYjpBOqjoFIcTP66R+lSbbTFEGmee+CCm0MqozSJ
	bjxK/yPuKEB0ECG8l9qSwqrpaRLBl0ypwPXPFl4Tt9SkbXLbx8Xj6j5q8YtHqxoLlpozUCM1a7B
	JSyzgFKugPi+GEM8GPWMqRRPgxqSyccmHY7kV
X-Google-Smtp-Source: AGHT+IHSxZN5/ZTAOWxTdVIyOYGbht8Awo9JzkHMw50CzuxT5XJD1v5RAa5yTyWC3fhgxbCk7gW08+f6/osGC9HnEV8=
X-Received: by 2002:ac2:48b0:0:b0:51a:f3b9:f774 with SMTP id
 u16-20020ac248b0000000b0051af3b9f774mr5993796lfg.21.1713837992555; Mon, 22
 Apr 2024 19:06:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240418074652.126355-1-stevensd@chromium.org> <87wmopuobi.ffs@tglx>
In-Reply-To: <87wmopuobi.ffs@tglx>
From: David Stevens <stevensd@chromium.org>
Date: Tue, 23 Apr 2024 11:06:21 +0900
Message-ID: <CAD=HUj7cmO5x4aunD_sJoQ6BQxejiwqa8tMbORnGjB3gADiLxg@mail.gmail.com>
Subject: Re: [PATCH] genirq: Disable suspended irqs when restoring affinity
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 23, 2024 at 5:36=E2=80=AFAM Thomas Gleixner <tglx@linutronix.de=
> wrote:
>
> On Thu, Apr 18 2024 at 16:46, David Stevens wrote:
> > In irq_restore_affinity_of_irq(), after initializing an affinity
> > managed irq, disable the irq if it should be suspended. This ensures
> > that irqs are not delivered to drivers during the noirq phase of
> > resuming from S3, after non-boot CPUs are brought back online.
> >
> > Signed-off-by: David Stevens <stevensd@chromium.org>
> > ---
> >  kernel/irq/cpuhotplug.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/kernel/irq/cpuhotplug.c b/kernel/irq/cpuhotplug.c
> > index 1ed2b1739363..c00132013708 100644
> > --- a/kernel/irq/cpuhotplug.c
> > +++ b/kernel/irq/cpuhotplug.c
> > @@ -197,6 +197,8 @@ static void irq_restore_affinity_of_irq(struct irq_=
desc *desc, unsigned int cpu)
> >
> >       if (irqd_is_managed_and_shutdown(data)) {
> >               irq_startup(desc, IRQ_RESEND, IRQ_START_COND);
> > +             if (desc->istate & IRQS_SUSPENDED)
> > +                     __disable_irq(desc);
>
> Makes sense. But I rather avoid the whole startup/disable dance in this
> case and let resume_device_irqs() deal with it.

Thanks for taking a look at my patch. Should I send a v2 with your
suggestions, or will you create a patch for your tree yourself?

-David

