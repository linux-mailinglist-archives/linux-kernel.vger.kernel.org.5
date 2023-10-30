Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC71F7DC30D
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 00:20:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230352AbjJ3XUQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 19:20:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbjJ3XUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 19:20:15 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17B19E1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 16:20:12 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-99c3c8adb27so753450766b.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 16:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1698708009; x=1699312809; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4gcrr3kC74rReKv7GNSo411IeX5s50dNiJe54KXuM0I=;
        b=kPkmaHg2cHUgopcKDuTz222n+a42k6W35SuEowImKi7IsLYZRLkNBM0UmLpd+h1nud
         Udb9kwwrJ53cATHTlo6gFDKFWLMcCnO5SFz43T8aT4/tlo6WygFv5cnH1vm3ppb/hvzI
         KAMsuedz2hMXnG6WXK5BaN4i7dnWtw6rlpTy4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698708009; x=1699312809;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4gcrr3kC74rReKv7GNSo411IeX5s50dNiJe54KXuM0I=;
        b=CxrlZhRObm4XQf4aH7AVYb77AM6sqVzLb2ZUSF/JYllCO8YJeJkxQvf6LZs6Ls1Ugd
         bFMtHJIx6+UGdKUTNpI2MFsZHbUWa+bO+ZqjPUqWDQNtgmhLJnjYCy1SRd+o1vLwUCoi
         NGah74YI1jY7cOeSUo3WUjNHO9WuzRdLVyfze+ZOPbL7rFhPtK2kp6/4Kjv6kHHa4K2d
         l9qsKsTZ11h82Ogs6G+OAHuK+ueutHEIfgmFnsWw0DX2wwEqjP69CzWK0doJDVezE+ro
         +47SYPOtQY0eS7A2dLC0bhVfoQniwVYULq4tbNp6i472ak8LZ6AoVSbjZgUdg2ZJ2L6R
         6dug==
X-Gm-Message-State: AOJu0YxwPwB36Slm0VXgRX4srSI6By9+lMRWgmTQg4Np36fthjtQ3RlL
        DCzdGED5X2koios65wc4XFA7U2XYyaTf/rcuQSSMM+Iz
X-Google-Smtp-Source: AGHT+IEsmkOLKklEqlIx16duhmNHnwW+vySRIyW2k2E62Bg0l66S6/kGTnQ4IF62R7ksRpBrSbzPaA==
X-Received: by 2002:a17:907:3fa4:b0:9be:8ead:54c7 with SMTP id hr36-20020a1709073fa400b009be8ead54c7mr10198091ejc.12.1698708008816;
        Mon, 30 Oct 2023 16:20:08 -0700 (PDT)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id ci18-20020a170906c35200b009887f4e0291sm31017ejb.27.2023.10.30.16.20.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Oct 2023 16:20:08 -0700 (PDT)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-51e24210395so6397a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 16:20:08 -0700 (PDT)
X-Received: by 2002:a50:c04f:0:b0:542:d6e7:1e09 with SMTP id
 u15-20020a50c04f000000b00542d6e71e09mr46600edd.0.1698708007918; Mon, 30 Oct
 2023 16:20:07 -0700 (PDT)
MIME-Version: 1.0
References: <20231006151547.1.Ide945748593cffd8ff0feb9ae22b795935b944d6@changeid>
 <ZS-7DC9OH2DUejLY@FVFF77S0Q05N>
In-Reply-To: <ZS-7DC9OH2DUejLY@FVFF77S0Q05N>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 30 Oct 2023 16:19:55 -0700
X-Gmail-Original-Message-ID: <CAD=FV=V=Jqcq+oS1xQr71eqOHSbW4VHT=_AEDU6upjwsPKGKdg@mail.gmail.com>
Message-ID: <CAD=FV=V=Jqcq+oS1xQr71eqOHSbW4VHT=_AEDU6upjwsPKGKdg@mail.gmail.com>
Subject: Re: [PATCH 1/3] arm64: Disable GiC priorities on Mediatek devices w/
 firmware issues
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Marc Zyngier <maz@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Amit Daniel Kachhap <amit.kachhap@arm.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        James Morse <james.morse@arm.com>,
        Joey Gouly <joey.gouly@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Oct 18, 2023 at 4:01=E2=80=AFAM Mark Rutland <mark.rutland@arm.com>=
 wrote:
>
> On Fri, Oct 06, 2023 at 03:15:51PM -0700, Douglas Anderson wrote:
> > In commit 44bd78dd2b88 ("irqchip/gic-v3: Disable pseudo NMIs on
> > Mediatek devices w/ firmware issues") we added a method for detecting
> > Mediatek devices with broken firmware and disabled pseudo-NMI. While
> > that worked, it didn't address the problem at a deep enough level.
> >
> > The fundamental issue with this broken firmware is that it's not
> > saving and restoring several important GICR registers. The current
> > list is believed to be:
> > * GICR_NUM_IPRIORITYR
> > * GICR_CTLR
> > * GICR_ISPENDR0
> > * GICR_ISACTIVER0
> > * GICR_NSACR
> >
> > Pseudo-NMI didn't work because it was the only thing (currently) in
> > the kernel that relied on the broken registers, so forcing pseudo-NMI
> > off was an effective fix. However, it could be observed that calling
> > system_uses_irq_prio_masking() on these systems still returned
> > "true". That caused confusion and led to the need for
> > commit a07a59415217 ("arm64: smp: avoid NMI IPIs with broken MediaTek
> > FW"). It's worried that the incorrect value returned by
> > system_uses_irq_prio_masking() on these systems will continue to
> > confuse future developers.
> >
> > Let's fix the issue a little more completely by disabling IRQ
> > priorities at a deeper level in the kernel. Once we do this we can
> > revert some of the other bits of code dealing with this quirk.
> >
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > ---
> >
> >  arch/arm64/kernel/cpufeature.c | 21 +++++++++++++++++++++
> >  1 file changed, 21 insertions(+)
> >
> > diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeat=
ure.c
> > index 2806a2850e78..e35efab8efa9 100644
> > --- a/arch/arm64/kernel/cpufeature.c
> > +++ b/arch/arm64/kernel/cpufeature.c
> > @@ -2094,9 +2094,30 @@ static int __init early_enable_pseudo_nmi(char *=
p)
> >  }
> >  early_param("irqchip.gicv3_pseudo_nmi", early_enable_pseudo_nmi);
> >
> > +static bool are_gic_priorities_broken(void)
> > +{
> > +     bool is_broken =3D false;
> > +     struct device_node *np;
> > +
> > +     /*
> > +      * Detect broken Mediatek firmware that doesn't properly save and
> > +      * restore GIC priorities.
> > +      */
> > +     np =3D of_find_compatible_node(NULL, NULL, "arm,gic-v3");
> > +     if (np) {
> > +             is_broken =3D of_property_read_bool(np, "mediatek,broken-=
save-restore-fw");
> > +             of_node_put(np);
> > +     }
> > +
> > +     return is_broken;
> > +}
>
> I'm definitely in favour of detecting this in the cpucap, but I think it'=
d be
> better to parse the DT once on the boot CPU rather than on each CPU every=
 time
> it's brought up.
>
> I think if we add something like:
>
> #ifdef CONFIG_ARM64_PSEUDO_NMI
> static void detect_system_supports_pseudo_nmi(void)
> {
>         struct device_node *np;
>
>         if (!enable_pseudo_nmi)
>                 return;
>
>         /*
>          * Detect broken Mediatek firmware that doesn't properly save and
>          * restore GIC priorities.
>          */
>         np =3D of_find_compatible_node(NULL, NULL, "arm,gic-v3");
>         if (np && of_property_read_bool(np, "mediatek,broken-save-restore=
-fw")) {
>                 pr_info("Pseudo-NMI disabled due to Mediatek Chromebook G=
ICR save problem");
>                 enable_pseudo_nmi =3D false;
>         }
>         of_node_put(np);
> }
> #endif /* CONFIG_ARM64_PSEUDO_NMI */
> static inline void detect_system_supports_pseudo_nmi(void) { }
> #endif
>
> ... then we can call that from init_cpu_features() before we call
> setup_boot_cpu_capabilities(), and then the existing logic in
> can_use_gic_priorities() should just work as that returns the value of
> enable_pseudo_nmi.
>
> Note: of_node_put(NULL) does nothing, like kfree(NULL), so it's fine for =
that
> to be called in the !np case.
>
> Would you be happy to fold that in? I'm happy with a Suggested-by tag if =
so. :)

Yup, that looks good to me and I can fold it in (fixing a few nits
like missing "\n" and adding __init to the function). I'll wait to get
maintainers opinions on whether to fold patch #3 in here and then send
a v2.

-Doug
