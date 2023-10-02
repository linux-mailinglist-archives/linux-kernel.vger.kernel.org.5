Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14D277B5B1E
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 21:19:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238544AbjJBTQo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 15:16:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjJBTQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 15:16:42 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BCF2AC
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 12:16:39 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-9a9d82d73f9so9163466b.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Oct 2023 12:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696274195; x=1696878995; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w025f/6AdfhrbLNyBq/UB//v5OtoztTxmfkB6A0lQtk=;
        b=BY+Ph2xgmcJS6lMgcv6xlOKb8em0H8WFes1SgQc+A5BMG3NyF0ZfssuGOcADXqeoTG
         KMBYcIICOwvooM6PxzaUhHHjTcylFXujXbvTUOXMCX82rVs0Aija7hNzWSVjI4l7hXr4
         hobcBO6xvPH+yce3wqulE7VKQ2olZYAHurbyU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696274195; x=1696878995;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w025f/6AdfhrbLNyBq/UB//v5OtoztTxmfkB6A0lQtk=;
        b=kmRUgMoR2ikrqlFQk6VKDMt4vIMV8cNrOFvaT6usT6aJBPd741yoD70O8jT0kur7sA
         fC64rYkOJSCm7UsoBxd8PYwkvZMeFpQB5NFYDGlSfpFfVUas266Bxi1GtRf9TawTpIvs
         YVXFrHo8DjWDq2EuL00doLLJoHXf6+KJ5XKSLBuP7ql6WlidGSNt0Os8Bzv0P5ZLjYiL
         t3XLD4xl6GcNVCEtc4YwriNaUxlsIn6/HbGGWmXhGS4AGByE0tDpJehfQzZyPRDsKYbR
         pwYT08gssKky6BjJhtsBRtVUqRTt4KVjjNmtiJ0pz+3dRxpZIKS5PbQfRSw61e5YH651
         Ntzw==
X-Gm-Message-State: AOJu0Yw1w/gv0SjApCY3BwLhxsdV5/UnEU3+jNF+0nDeTAG3TmppcoDk
        glo01KAIXpB3p285XCjfN03eMqFEb42sWuGuva+CMDKY
X-Google-Smtp-Source: AGHT+IEujgVPWMMXmsgkSY9hAz3qEOFmJNq5QfujHiwpgRcCig6vCDfC2EWhY9Gx7pt5oQb+NuKs8g==
X-Received: by 2002:a17:906:25b:b0:9a2:185b:5375 with SMTP id 27-20020a170906025b00b009a2185b5375mr10864731ejl.18.1696274195513;
        Mon, 02 Oct 2023 12:16:35 -0700 (PDT)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com. [209.85.128.43])
        by smtp.gmail.com with ESMTPSA id l6-20020a1709060e0600b009ae05f9eab3sm17462228eji.65.2023.10.02.12.16.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Oct 2023 12:16:35 -0700 (PDT)
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4053f24c900so17035e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Oct 2023 12:16:34 -0700 (PDT)
X-Received: by 2002:a05:600c:3b07:b0:400:46db:1bf2 with SMTP id
 m7-20020a05600c3b0700b0040046db1bf2mr28521wms.2.1696274194181; Mon, 02 Oct
 2023 12:16:34 -0700 (PDT)
MIME-Version: 1.0
References: <20231002094526.1.Ie8f760213053e3d11592f892b30912dbac6b8b48@changeid>
 <ZRr8r7XMoyDKaitd@FVFF77S0Q05N.cambridge.arm.com>
In-Reply-To: <ZRr8r7XMoyDKaitd@FVFF77S0Q05N.cambridge.arm.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 2 Oct 2023 12:16:17 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UeeL9uycVeKpOm+eDm3xHrOnKi2frt6a1qFG1HX9yEUg@mail.gmail.com>
Message-ID: <CAD=FV=UeeL9uycVeKpOm+eDm3xHrOnKi2frt6a1qFG1HX9yEUg@mail.gmail.com>
Subject: Re: [PATCH 1/2] arm64: smp: Fix pseudo NMI issues w/ broken Mediatek FW
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Valentin Schneider <vschneid@redhat.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        D Scott Phillips <scott@os.amperecomputing.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Misono Tomohiro <misono.tomohiro@fujitsu.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Oct 2, 2023 at 10:24=E2=80=AFAM Mark Rutland <mark.rutland@arm.com>=
 wrote:
>
> On Mon, Oct 02, 2023 at 09:45:29AM -0700, Douglas Anderson wrote:
> > Some mediatek devices have the property
> > "mediatek,broken-save-restore-fw" in their GIC. This means that,
> > although the hardware supports pseudo-NMI, the firmware has a bug
> > that blocks enabling it. When we're in this state,
> > system_uses_irq_prio_masking() will return true but we'll fail to
> > actually enable the IRQ in the GIC.
> >
> > Let's make the code handle this. We'll detect that we failed to
> > request an IPI as NMI and fallback to requesting it normally. Though
> > we expect that either all of our requests will fail or all will
> > succeed, it's just as cheap to keep a per-IPI bitmap and that keeps us
> > robust.
> >
> > Fixes: 331a1b3a836c ("arm64: smp: Add arch support for backtrace using =
pseudo-NMI")
> > Reported-by: Chen-Yu Tsai <wenst@chromium.org>
> > Closes: https://issuetracker.google.com/issues/197061987#comment68
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > ---
> >
> >  arch/arm64/kernel/smp.c | 19 ++++++++++++-------
> >  1 file changed, 12 insertions(+), 7 deletions(-)
>
> I'm not too keen on falling back here when we have no idea why the reques=
t failed.
>
> I'd prefer if we could check the `supports_pseudo_nmis` static key direct=
ly to
> account for the case of broken FW, e.g. as below.
>
> Mark.
>
> ---->8----
> From 72fdec05c64a74f21871b44c7c760bbe07cac044 Mon Sep 17 00:00:00 2001
> From: Mark Rutland <mark.rutland@arm.com>
> Date: Mon, 2 Oct 2023 18:00:36 +0100
> Subject: [PATCH] arm64: smp: avoid NMI IPIs with broken MediaTek FW
>
> Some MediaTek devices have broken firmware which corrupts some GICR
> registers behind the back of the OS, and pseudo-NMIs cannot be used on
> these devices. For more details see commit:
>
>   44bd78dd2b8897f5 ("irqchip/gic-v3: Disable pseudo NMIs on Mediatek devi=
ces w/ firmware issues")
>
> We did not take this problem into account in commit:
>
>   331a1b3a836c0f38 ("arm64: smp: Add arch support for backtrace using pse=
udo-NMI")
>
> Since that commit arm64's SMP code will try to setup some IPIs as
> pseudo-NMIs, even on systems with broken FW. The GICv3 code will
> (rightly) reject attempts to request interrupts as pseudo-NMIs,
> resulting in boot-time failures.
>
> Avoid the problem by taking the broken FW into account when deciding to
> request IPIs as pseudo-NMIs. The GICv3 driver maintains a static_key
> named "supports_pseudo_nmis" which is false on systems with broken FW,
> and we can consult this within ipi_should_be_nmi().
>
> Fixes: 331a1b3a836c0f38 ("arm64: smp: Add arch support for backtrace usin=
g pseudo-NMI")
> Reported-by: Chen-Yu Tsai <wenst@chromium.org>
> Closes: https://issuetracker.google.com/issues/197061987#comment68
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Douglas Anderson <dianders@chromium.org>
> Cc: Marc Zyngier <maz@kernel.org>
> ---
>  arch/arm64/kernel/smp.c      | 5 ++++-
>  drivers/irqchip/irq-gic-v3.c | 2 +-
>  2 files changed, 5 insertions(+), 2 deletions(-)

Sure, this is OK w/ me as long as folks don't mind accessing the
global here, it's OK w/ me:

Reviewed-by: Douglas Anderson <dianders@chromium.org>

It seems to work for me, thus:

Tested-by: Douglas Anderson <dianders@chromium.org>


> diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
> index 814d9aa93b21b..061c69160f90f 100644
> --- a/arch/arm64/kernel/smp.c
> +++ b/arch/arm64/kernel/smp.c
> @@ -964,7 +964,10 @@ static void smp_cross_call(const struct cpumask *tar=
get, unsigned int ipinr)
>
>  static bool ipi_should_be_nmi(enum ipi_msg_type ipi)
>  {
> -       if (!system_uses_irq_prio_masking())
> +       DECLARE_STATIC_KEY_FALSE(supports_pseudo_nmis);
> +
> +       if (!system_uses_irq_prio_masking() ||
> +           !static_branch_likely(&supports_pseudo_nmis))

One thought, actually, is whether we should actually change
system_uses_irq_prio_masking() to return the correct value. What do
you think?

-Doug
