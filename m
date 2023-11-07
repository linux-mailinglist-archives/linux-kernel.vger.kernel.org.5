Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 673697E38B6
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 11:18:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233838AbjKGKSX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 05:18:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjKGKSV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 05:18:21 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54274ED
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 02:18:19 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 605EFC433C8;
        Tue,  7 Nov 2023 10:18:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699352299;
        bh=q8eY4EmrfBXA7u5V9AK9XhPz+GlLL9tTLPPqNj+/O/k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=utqlKarTZNJ4XwUGN3QZ2N1tzNPwdVdtG6LxAjX8pE1VX1C+buPLjmvdCm2Q7zNov
         p8vhw4Pb1krnOx4/XyMhDUmtZTfXFywc/ssufmGuMnn+E8qkKdUimfX081lxqbXp8z
         m0CDTKaDyRN/0jgXs7LutAQ3dbVgeAyZdwDg6sI7gOOUt39tCvSs8gEEPBoI/79ilZ
         r0pQ5/zxabo2bJgIK8/xpWi6krxZHWEzAj83AnxoN6HFgE96x4x+wIAE21vYvHLa8h
         jAnAVNkTXQYukvnf28GgVFPJKcy+EqA+FQ8dj7tPHbR76Aw4vswoT2LX/Yq9swEYQu
         PlB0QFSdwLJPw==
Date:   Tue, 7 Nov 2023 10:18:12 +0000
From:   Will Deacon <will@kernel.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <maz@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
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
Subject: Re: [PATCH 1/3] arm64: Disable GiC priorities on Mediatek devices w/
 firmware issues
Message-ID: <20231107101812.GC18944@willie-the-truck>
References: <20231006151547.1.Ide945748593cffd8ff0feb9ae22b795935b944d6@changeid>
 <ZS-7DC9OH2DUejLY@FVFF77S0Q05N>
 <CAD=FV=V=Jqcq+oS1xQr71eqOHSbW4VHT=_AEDU6upjwsPKGKdg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD=FV=V=Jqcq+oS1xQr71eqOHSbW4VHT=_AEDU6upjwsPKGKdg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 30, 2023 at 04:19:55PM -0700, Doug Anderson wrote:
> On Wed, Oct 18, 2023 at 4:01 AM Mark Rutland <mark.rutland@arm.com> wrote:
> > On Fri, Oct 06, 2023 at 03:15:51PM -0700, Douglas Anderson wrote:
> > > diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> > > index 2806a2850e78..e35efab8efa9 100644
> > > --- a/arch/arm64/kernel/cpufeature.c
> > > +++ b/arch/arm64/kernel/cpufeature.c
> > > @@ -2094,9 +2094,30 @@ static int __init early_enable_pseudo_nmi(char *p)
> > >  }
> > >  early_param("irqchip.gicv3_pseudo_nmi", early_enable_pseudo_nmi);
> > >
> > > +static bool are_gic_priorities_broken(void)
> > > +{
> > > +     bool is_broken = false;
> > > +     struct device_node *np;
> > > +
> > > +     /*
> > > +      * Detect broken Mediatek firmware that doesn't properly save and
> > > +      * restore GIC priorities.
> > > +      */
> > > +     np = of_find_compatible_node(NULL, NULL, "arm,gic-v3");
> > > +     if (np) {
> > > +             is_broken = of_property_read_bool(np, "mediatek,broken-save-restore-fw");
> > > +             of_node_put(np);
> > > +     }
> > > +
> > > +     return is_broken;
> > > +}
> >
> > I'm definitely in favour of detecting this in the cpucap, but I think it'd be
> > better to parse the DT once on the boot CPU rather than on each CPU every time
> > it's brought up.
> >
> > I think if we add something like:
> >
> > #ifdef CONFIG_ARM64_PSEUDO_NMI
> > static void detect_system_supports_pseudo_nmi(void)
> > {
> >         struct device_node *np;
> >
> >         if (!enable_pseudo_nmi)
> >                 return;
> >
> >         /*
> >          * Detect broken Mediatek firmware that doesn't properly save and
> >          * restore GIC priorities.
> >          */
> >         np = of_find_compatible_node(NULL, NULL, "arm,gic-v3");
> >         if (np && of_property_read_bool(np, "mediatek,broken-save-restore-fw")) {
> >                 pr_info("Pseudo-NMI disabled due to Mediatek Chromebook GICR save problem");
> >                 enable_pseudo_nmi = false;
> >         }
> >         of_node_put(np);
> > }
> > #endif /* CONFIG_ARM64_PSEUDO_NMI */
> > static inline void detect_system_supports_pseudo_nmi(void) { }
> > #endif
> >
> > ... then we can call that from init_cpu_features() before we call
> > setup_boot_cpu_capabilities(), and then the existing logic in
> > can_use_gic_priorities() should just work as that returns the value of
> > enable_pseudo_nmi.
> >
> > Note: of_node_put(NULL) does nothing, like kfree(NULL), so it's fine for that
> > to be called in the !np case.
> >
> > Would you be happy to fold that in? I'm happy with a Suggested-by tag if so. :)
> 
> Yup, that looks good to me and I can fold it in (fixing a few nits
> like missing "\n" and adding __init to the function). I'll wait to get
> maintainers opinions on whether to fold patch #3 in here and then send
> a v2.

No preference from me; I assume this stuff's all going in together anyway.

Will
