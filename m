Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CFD77BB4FB
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 12:20:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231621AbjJFKUp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 06:20:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231611AbjJFKUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 06:20:44 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8BCDF0
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 03:20:40 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-503397ee920so2469562e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Oct 2023 03:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696587639; x=1697192439; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZMO0y6d1gIggTjy/nwhhxTiY2T6sUr92V5iWg7Ms3S4=;
        b=Ut39RhwBZUKUu1s8TvTBoXXQe+alXgRNOF6BD8jgz1pGE8R1BVTxDeunvVluyriSfv
         5q+6O9rO9+u4wA8bGmHqklsrqobAbohoW0ED8oAsn7nEZBjK0X9OCv+UcJG/FI1IgpJm
         oghkYd7fZisGlgvWCNoVE3reALdyoLb3NNSyI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696587639; x=1697192439;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZMO0y6d1gIggTjy/nwhhxTiY2T6sUr92V5iWg7Ms3S4=;
        b=OlEzLK2c+WWsT8bpv18PMWpJoernW6Kb02S3h0rgXVNU3f4j/s761lxHjWSuuchLqy
         luPMOM8eP8aYawyM/eh4/BKQByltar4dswOgdE1h98eEbKUrgI7k/prNLWwFRK+d168G
         17GGQzVQrpSprubkvobzDPTd3NwkY3l0isLUmOM372hMIUbDj9jCy56vYaTxLSj36KDp
         He8kQaj7HOFETo2NExbhV17XDd0wCL8LlhWbORFpZ8asx3pWvtXaEnl8BArb9p2Yz1rX
         doZV7XBmx3//bYfniRLCOxcjDtD/YtHVy8HYFhTfxjLVxoZ4IL6t+6HsLtm1tXUZfTRl
         6GJA==
X-Gm-Message-State: AOJu0YxiM6ImdgPC7o3SfeAjrTtr5tIyloS7xykELDzCSs0xUKxT/t+M
        er16RSnXa9ncnX5UP3gt25g1yv8REJUhJtcRR9cNsg==
X-Google-Smtp-Source: AGHT+IEiszbiTGbErCkaGwOmwLTqn/3ZFNKuaOGdePa5MncEL3HFq5l3iPfNyaX178j2q02TmjHlawqg9j94X4q/aJA=
X-Received: by 2002:ac2:4e87:0:b0:503:3816:c42c with SMTP id
 o7-20020ac24e87000000b005033816c42cmr6141584lfr.41.1696587639012; Fri, 06 Oct
 2023 03:20:39 -0700 (PDT)
MIME-Version: 1.0
References: <20231002094526.1.Ie8f760213053e3d11592f892b30912dbac6b8b48@changeid>
 <ZRr8r7XMoyDKaitd@FVFF77S0Q05N.cambridge.arm.com>
In-Reply-To: <ZRr8r7XMoyDKaitd@FVFF77S0Q05N.cambridge.arm.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Fri, 6 Oct 2023 18:20:26 +0800
Message-ID: <CAGXv+5Fm66CJidLsfJRYuSndeMJHLfdwAWDdUHyx8TeMvuoJ0A@mail.gmail.com>
Subject: Re: [PATCH 1/2] arm64: smp: Fix pseudo NMI issues w/ broken Mediatek FW
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Valentin Schneider <vschneid@redhat.com>,
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

On Tue, Oct 3, 2023 at 1:24=E2=80=AFAM Mark Rutland <mark.rutland@arm.com> =
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

Tested-by: Chen-Yu Tsai <wenst@chromium.org>

> ---
>  arch/arm64/kernel/smp.c      | 5 ++++-
>  drivers/irqchip/irq-gic-v3.c | 2 +-
>  2 files changed, 5 insertions(+), 2 deletions(-)
>
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
>                 return false;
>
>         switch (ipi) {
> diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
> index 787ccc880b22d..737da1b9aabf2 100644
> --- a/drivers/irqchip/irq-gic-v3.c
> +++ b/drivers/irqchip/irq-gic-v3.c
> @@ -106,7 +106,7 @@ static DEFINE_STATIC_KEY_TRUE(supports_deactivate_key=
);
>   * - Figure 4-7 Secure read of the priority field for a Non-secure Group=
 1
>   *   interrupt.
>   */
> -static DEFINE_STATIC_KEY_FALSE(supports_pseudo_nmis);
> +DEFINE_STATIC_KEY_FALSE(supports_pseudo_nmis);
>
>  DEFINE_STATIC_KEY_FALSE(gic_nonsecure_priorities);
>  EXPORT_SYMBOL(gic_nonsecure_priorities);
> --
> 2.30.2
>
>
