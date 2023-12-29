Return-Path: <linux-kernel+bounces-13173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 959888200B2
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 18:13:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 362F2B21AD4
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 17:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8207D12B75;
	Fri, 29 Dec 2023 17:12:50 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C424C12B61;
	Fri, 29 Dec 2023 17:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3bbc5cd15b6so367348b6e.0;
        Fri, 29 Dec 2023 09:12:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703869968; x=1704474768;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HdiTaY4wXcOHiFobHYaOWoRTwcwWY53xK1QwAvbQC8E=;
        b=dTjcBoqcAfRy/6p41TbGYdFruKKuW3UJu9q+y9vqlZMpLIqD9Oj7mVpf5kbIZ+fm4o
         DR3WAwHvzCBNBOeR6gQrroITJ2Gw6u+A+cW3o4HC5Eh+cOH77mLe5uyBXrvx54FXcU5p
         FJEdeAL+ta+MAwuZAKB0bmS1/F53CUESkfNQbWEoykkf4MhjVnzero3e1BD/qm+4P+bg
         Zsv6lbUYE6/3GRlysZIGnTTLxeE4dj5tYtWaejJnzyDsburpVZXwjQDYrMe/DLFKSYcq
         Vie8MjWt3W3gH2ku+7A6cNOEJSBD3By+q3Kgy/mBmpBr1Cq16FaqYXiL7q2WnmbuJIgU
         d8tg==
X-Gm-Message-State: AOJu0YynTl20tZ02sgRizMOZnvgrok1mUX6AG38hNhdTVlM1Z0Bo1XR8
	SB23A1a+7TTQOX40OHBMXLhJq1AzwYYL2UaVDe0=
X-Google-Smtp-Source: AGHT+IFfyXOQC8zU2QuZ7sMVZIymxpNx27SsWQtka+nbAAgX317CZe3KvSGEwVOQknk1f83gxxIBuBKxIZ3q+8e1hRQ=
X-Received: by 2002:a4a:ce87:0:b0:594:ec5f:f697 with SMTP id
 f7-20020a4ace87000000b00594ec5ff697mr5429797oos.0.1703869967849; Fri, 29 Dec
 2023 09:12:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231228145416.GAZY2MGLY6THMkAZ2W@fat_crate.local>
In-Reply-To: <20231228145416.GAZY2MGLY6THMkAZ2W@fat_crate.local>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 29 Dec 2023 18:12:36 +0100
Message-ID: <CAJZ5v0j3Wb-9Czb50u=NWjNz-W8mgMDEarWY7XG49d+LdzKAYw@mail.gmail.com>
Subject: Re: [PATCH] cpuidle: haltpoll: Do not enable interrupts when entering idle
To: "Borislav Petkov (AMD)" <bp@alien8.de>
Cc: linux-pm@vger.kernel.org, forza@tnonline.net, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 28, 2023 at 3:54=E2=80=AFPM Borislav Petkov (AMD) <bp@alien8.de=
> wrote:
>
> Hi,
>
> I think PeterZ's massaging from
>
>   https://lore.kernel.org/all/20230112194314.845371875@infradead.org/
>
> missed one.
>
> @Forza, if you want to have your real name in the patch tags below and
> thus be part of git history, lemme know. If you don't want them there,
> either.
>
> Thx.
>
> ---
> From: Borislav Petkov (AMD) <bp@alien8.de>

I would have appreciated a Subject: line here.

>
> The cpuidle governors' ->enter() methods are supposed to be IRQ
> invariant:

cpuidle governors have no ->enter() callbacks, drivers do.  And this
particular haltpoll is a driver (there is a haltpoll governor too,
confusingly enough).

>
>   5e26aa933911 ("cpuidle/poll: Ensure IRQs stay disabled after cpuidle_st=
ate::enter() calls")
>   bb7b11258561 ("cpuidle: Move IRQ state validation")
>
> Do that in the haltpoll governor too.

And so s/governor/driver/ here.

> Fixes: 5e26aa933911 ("cpuidle/poll: Ensure IRQs stay disabled after cpuid=
le_state::enter() calls")
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D218245
> Reported-by: <forza@tnonline.net>
> Tested-by: <forza@tnonline.net>
> Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>

Nevertheless, applied (with the changelog adjustments mentioned above).

> ---
>  drivers/cpuidle/cpuidle-haltpoll.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/cpuidle/cpuidle-haltpoll.c b/drivers/cpuidle/cpuidle=
-haltpoll.c
> index e66df22f9695..d8515d5c0853 100644
> --- a/drivers/cpuidle/cpuidle-haltpoll.c
> +++ b/drivers/cpuidle/cpuidle-haltpoll.c
> @@ -25,13 +25,12 @@ MODULE_PARM_DESC(force, "Load unconditionally");
>  static struct cpuidle_device __percpu *haltpoll_cpuidle_devices;
>  static enum cpuhp_state haltpoll_hp_state;
>
> -static int default_enter_idle(struct cpuidle_device *dev,
> -                             struct cpuidle_driver *drv, int index)
> +static __cpuidle int default_enter_idle(struct cpuidle_device *dev,
> +                                       struct cpuidle_driver *drv, int i=
ndex)
>  {
> -       if (current_clr_polling_and_test()) {
> -               local_irq_enable();
> +       if (current_clr_polling_and_test())
>                 return index;
> -       }
> +
>         arch_cpu_idle();
>         return index;
>  }
> --
> 2.42.0.rc0.25.ga82fb66fed25
>
>
> --
> Regards/Gruss,
>     Boris.
>
> https://people.kernel.org/tglx/notes-about-netiquette

