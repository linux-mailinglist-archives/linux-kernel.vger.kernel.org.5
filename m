Return-Path: <linux-kernel+bounces-148263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D81D98A7FFF
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 11:41:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DE271F224D4
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 09:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2104C132C39;
	Wed, 17 Apr 2024 09:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UuoZTE6Y"
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D3DC131BD6
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 09:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713346815; cv=none; b=etU6yuQVK/gwbm3Y1bojtasKr5hKki4nyE/ggPppeY/mlIjR395xD6GUTo5PLEqXYxWy3TYXa87uug2zyGZmPcB0PCJwEZkeRkeoBIU31UiDIw+sLFTPu5A/PAwREYTHOsLRgx/pYLWmrgNMM3ZfysOXwlOxWkqGMUMFmutbwS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713346815; c=relaxed/simple;
	bh=l7Yc46hYH1V/Pbg4b2fFx/WKSMKlWrcG4VqfJMfsMvI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tTdJ46U0ZIYOJnOPSHrZa7l5vD73+8jj3Lo1h15RCURVjuuDAdKLFAbI78nX/y56ABkjUfYzX8iDLTCGWci6eZ+RCt3y1ktKqIU/oMt4GKsjwMSllOCUgR+Qfu/+N3IvPA8t617ZeZ5/uQhIR1CfWTt+TszcAnQK5x4F2bFH51s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UuoZTE6Y; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-dc6d8bd618eso5271383276.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 02:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713346813; x=1713951613; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ygviRP1jIE8nmnslvVwo8drTHEdzU5aqCtfbO77o0wc=;
        b=UuoZTE6YKwS2Zq+p8WhFgmIJOQMx+gfcKUl0z00uJqnV9wxSJEIUUMgLzuUMLjGdZy
         nJDfBIgTPMD/Ge3D6uPvsI1bLMfsyPFK2OsvIATyygcrz92aYxhbNnJ7lpSJl92tgJ0G
         MXkHOl0xHIKH4EjTvih2Farb5l9aldCc/mD+rbBZFWmXwioUdCE9iA1eWGoIzKgHQEKA
         WJxVtOfZaPAZbh9YpOxb4Vqc43SLjTHX4uFOLN3pxCPh39TmKZZm5cfVI+p8eZt2HJW6
         QO0Fczim4WXVAJSevyQ2ig5ansXIL7BcqxyH4jJ+0wKcDUm+I+sHUH3nqsIo7YNTNM21
         w2tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713346813; x=1713951613;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ygviRP1jIE8nmnslvVwo8drTHEdzU5aqCtfbO77o0wc=;
        b=kgJ69ueQtQT7p4GzYzF50VTyNXEaXrVyP/vekIbHDUggRn4MjEqlZhrdJusHnm91jY
         qkoLJ7CkLnEtnFWZPsSvSRnY+DhXF8YO38a3N9+9JCEtvjLW2wU7gUl4dkzXb1I3+dkg
         m6s0+/pjx/i79IqNnFIAwOmVxboB+SJSF6NY3fbSkv1i6JuLZOBEyFGtsoDQWxf9PHd8
         pJccnSP/sBSKJ33N9PQnHLdANiPHXRV7cPN1QXOSF84RvWqXhHi6ZO+5LvGF+DWkemEc
         ilfV3Qi/NhI5wWCOix/pQJkcUPIelJpZ+JILzNYPGur7M2S2qMO5Ko0a5XLK+Pc+Ka2L
         JK8g==
X-Forwarded-Encrypted: i=1; AJvYcCWvtS4ASVIPtFPoza2KnmOLNsYoFQfI0tdvvC9dypb1GSQ5lTc3GFZBrcON1r+X79JuZsD29iPAIJcOAHSc6J9wBfU0xvTWOcX5TY5J
X-Gm-Message-State: AOJu0YwSYirJ5VI7oNW+DC9WH9DO8cshBQPp43Ftt9kB2KBRYR1wC7i6
	Csl0RzvAjNlDgMB8IdljEDS6P+66uIoMOR/FplG55higJEq1af1f68qG/CCbYU3RVp17mi1QJ/K
	O4LTrMkGkuLk571jpjKHSXAui4Eia8/0YYNrSXg==
X-Google-Smtp-Source: AGHT+IHuINer4ennmzfrVuJg5GvqotCsbUk7jjI6Q7Gtr0n2ni9mP1sVfZMvdd1GPJJ6demJaFrEesCnvRyy1+BF+Tc=
X-Received: by 2002:a05:6902:561:b0:dcb:b0f0:23fc with SMTP id
 a1-20020a056902056100b00dcbb0f023fcmr13939501ybt.22.1713346812834; Wed, 17
 Apr 2024 02:40:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240307140728.190184-1-claudiu.beznea.uj@bp.renesas.com>
 <20240307140728.190184-9-claudiu.beznea.uj@bp.renesas.com>
 <CAPDyKFos=FP3GxX+5qAmBpqrR-8Q7MRhhV3HvPAtu2K6x=7XEw@mail.gmail.com> <28508184-96f0-41b7-90bc-506d53cedaf9@tuxon.dev>
In-Reply-To: <28508184-96f0-41b7-90bc-506d53cedaf9@tuxon.dev>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 17 Apr 2024 11:39:36 +0200
Message-ID: <CAPDyKFpQUdq5Rj+Rk-fyPFTLuz6=vt2ovR3MgH3zPQDeKa1u0A@mail.gmail.com>
Subject: Re: [PATCH v2 08/10] clk: renesas: rzg2l-cpg: Add suspend/resume
 support for power domains
To: claudiu beznea <claudiu.beznea@tuxon.dev>
Cc: geert+renesas@glider.be, mturquette@baylibre.com, sboyd@kernel.org, 
	robh@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	magnus.damm@gmail.com, linux-renesas-soc@vger.kernel.org, 
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 17 Apr 2024 at 10:05, claudiu beznea <claudiu.beznea@tuxon.dev> wrote:
>
> Hi, Ulf,
>
> On 16.04.2024 15:07, Ulf Hansson wrote:
> > On Thu, 7 Mar 2024 at 15:10, Claudiu <claudiu.beznea@tuxon.dev> wrote:
> >>
> >> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> >>
> >> RZ/G3S supports deep sleep states that it can reach with the help of the
> >> TF-A.
> >>
> >> RZ/G3S has a few power domains (e.g. GIC) that need to be always-on while
> >> Linux is running. These domains are initialized (and powered on) when
> >> clock driver is probed.
> >>
> >> As the TF-A takes control at the very last(suspend)/first(resume)
> >> phase of configuring the deep sleep state, it can do it's own settings on
> >> power domains.
> >
> > For my understanding, can you please elaborate on this part a bit.
> > What does the "last suspend/resume phase" mean, more exactly, here?
>
> The RZ/G3S SoC support a power saving mode where most of the SoC parts are
> turned off and the system RAM is switched to retention mode. This is done
> with the help of TF-A. The handshake b/w Linux and TF-A is done though the
> drivers/firmware/psci/psci.c driver.
>
> After Linux finishes the execution of suspend code the control is taken by
> TF-A. TF-A does the final settings on the system (e.g. switching the RAM to
> retention mode) and power off most of the SoC parts.
>
> By the last phase of the suspend I'm referring to the TF-A doing the final
> adjustments for the system to switch to this power saving mode.
>
> When resuming, as the TF-A is the 1st one being executed on the system
> (this is what I called above the 1st phase of the resume), TF-A moves the
> DDR out of retention mode, reconfigure basic IPs (like in boot case as most
> of the SoC parts were powered off) and then give the control to Linux which
> will execute the resume code.

Alright, thanks for clarifying! This makes sense to me now!

>
>
> >
> >>
> >> Thus, to restore the proper Linux state, add rzg2l_cpg_resume() which
> >> powers on the always-on domains and rzg2l_cpg_complete() which activates
> >> the power down mode for the IPs selected through CPG_PWRDN_IP{1, 2}.
> >>
> >> Along with it, added the suspend_check member to the RZ/G2L power domain
> >> data structure whose purpose is to checks if a domain can be powered off
> >> while the system is going to suspend. This is necessary for the serial
> >> console domain which needs to be powered on if no_console_suspend is
> >> available in bootargs.
> >>
> >> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> >> ---
> >>
> >> Changes in v2:
> >> - none; this patch is new
> >>
> >>  drivers/clk/renesas/rzg2l-cpg.c | 66 ++++++++++++++++++++++++++++++---
> >>  drivers/clk/renesas/rzg2l-cpg.h |  1 +
> >>  2 files changed, 62 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/drivers/clk/renesas/rzg2l-cpg.c b/drivers/clk/renesas/rzg2l-cpg.c
> >> index b36700f4a9f5..b18af227177e 100644
> >> --- a/drivers/clk/renesas/rzg2l-cpg.c
> >> +++ b/drivers/clk/renesas/rzg2l-cpg.c
> >> @@ -15,6 +15,7 @@
> >>  #include <linux/clk.h>
> >>  #include <linux/clk-provider.h>
> >>  #include <linux/clk/renesas.h>
> >> +#include <linux/console.h>
> >>  #include <linux/delay.h>
> >>  #include <linux/device.h>
> >>  #include <linux/init.h>
> >> @@ -139,6 +140,7 @@ struct rzg2l_pll5_mux_dsi_div_param {
> >>   * @num_resets: Number of Module Resets in info->resets[]
> >>   * @last_dt_core_clk: ID of the last Core Clock exported to DT
> >>   * @info: Pointer to platform data
> >> + * @domains: generic PM domains
> >>   * @mux_dsi_div_params: pll5 mux and dsi div parameters
> >>   */
> >>  struct rzg2l_cpg_priv {
> >> @@ -155,6 +157,8 @@ struct rzg2l_cpg_priv {
> >>
> >>         const struct rzg2l_cpg_info *info;
> >>
> >> +       struct generic_pm_domain **domains;
> >> +
> >>         struct rzg2l_pll5_mux_dsi_div_param mux_dsi_div_params;
> >>  };
> >>
> >> @@ -1570,12 +1574,14 @@ struct rzg2l_cpg_pm_domains {
> >>   * struct rzg2l_cpg_pd - RZ/G2L power domain data structure
> >>   * @genpd: generic PM domain
> >>   * @priv: pointer to CPG private data structure
> >> + * @suspend_check: check if domain could be powered off in suspend
> >>   * @conf: CPG PM domain configuration info
> >>   * @id: RZ/G2L power domain ID
> >>   */
> >>  struct rzg2l_cpg_pd {
> >>         struct generic_pm_domain genpd;
> >>         struct rzg2l_cpg_priv *priv;
> >> +       int (*suspend_check)(void);
> >>         struct rzg2l_cpg_pm_domain_conf conf;
> >>         u16 id;
> >>  };
> >> @@ -1676,6 +1682,13 @@ static int rzg2l_cpg_power_off(struct generic_pm_domain *domain)
> >>         struct rzg2l_cpg_reg_conf pwrdn = pd->conf.pwrdn;
> >>         struct rzg2l_cpg_priv *priv = pd->priv;
> >>
> >> +       if (pd->suspend_check) {
> >> +               int ret = pd->suspend_check();
> >> +
> >> +               if (ret)
> >> +                       return ret;
> >> +       }
> >> +
> >
> > This should not be needed at all, I think.
> >
> > Instead, genpd should be able to take the correct decision during
> > system-wide suspend and simply avoid calling the ->power_off()
> > callback, when that is needed.
> >
> > If I understand correctly, GENPD_FLAG_ACTIVE_WAKEUP is set for the
> > genpd in question. The only remaining thing would then be to let the
> > console driver, during system suspend, check whether
> > "console_suspend_enabled" is set and then call device_set_awake_path()
> > for its device. In this way, genpd should then keep the corresponding
> > PM domain powered-on.
>
> You're right! I've checked it and all good w/o ->suspend_check() if
> device_set_wakeup_path() is called for the console driver.
>
> I'll send an update for it.

Great! Please keep me posted on the entire series for next version. I
will try to continue to help review this.

>
> >
> >>         /* Set MSTOP. */
> >>         if (mstop.mask)
> >>                 writel(mstop.mask | (mstop.mask << 16), priv->base + mstop.off);
> >> @@ -1687,8 +1700,14 @@ static int rzg2l_cpg_power_off(struct generic_pm_domain *domain)
> >>         return 0;
> >>  }
> >>
> >> -static int __init rzg2l_cpg_pd_setup(struct rzg2l_cpg_pd *pd, bool always_on)
> >> +static int rzg2l_pd_suspend_check_console(void)
> >>  {
> >> +       return console_suspend_enabled ? 0 : -EBUSY;
> >> +}
> >> +
> >> +static int __init rzg2l_cpg_pd_setup(struct rzg2l_cpg_pd *pd, u32 flags)
> >> +{
> >> +       bool always_on = !!(flags & RZG2L_PD_F_ALWAYS_ON);
> >>         struct dev_power_governor *governor;
> >>
> >>         pd->genpd.flags |= GENPD_FLAG_PM_CLK | GENPD_FLAG_ACTIVE_WAKEUP;
> >> @@ -1700,6 +1719,8 @@ static int __init rzg2l_cpg_pd_setup(struct rzg2l_cpg_pd *pd, bool always_on)
> >>         } else {
> >>                 pd->genpd.power_on = rzg2l_cpg_power_on;
> >>                 pd->genpd.power_off = rzg2l_cpg_power_off;
> >> +               if (flags & RZG2L_PD_F_CONSOLE)
> >> +                       pd->suspend_check = rzg2l_pd_suspend_check_console;
> >>                 governor = &simple_qos_governor;
> >>         }
> >>
> >> @@ -1719,7 +1740,7 @@ static int __init rzg2l_cpg_add_clk_domain(struct rzg2l_cpg_priv *priv)
> >>
> >>         pd->genpd.name = np->name;
> >>         pd->priv = priv;
> >> -       ret = rzg2l_cpg_pd_setup(pd, true);
> >> +       ret = rzg2l_cpg_pd_setup(pd, RZG2L_PD_F_ALWAYS_ON);
> >>         if (ret)
> >>                 return ret;
> >>
> >> @@ -1778,13 +1799,13 @@ static int __init rzg2l_cpg_add_pm_domains(struct rzg2l_cpg_priv *priv)
> >>         domains->onecell_data.domains = domains->domains;
> >>         domains->onecell_data.num_domains = info->num_pm_domains;
> >>         domains->onecell_data.xlate = rzg2l_cpg_pm_domain_xlate;
> >> +       priv->domains = domains->domains;
> >>
> >>         ret = devm_add_action_or_reset(dev, rzg2l_cpg_genpd_remove, &domains->onecell_data);
> >>         if (ret)
> >>                 return ret;
> >>
> >>         for (unsigned int i = 0; i < info->num_pm_domains; i++) {
> >> -               bool always_on = !!(info->pm_domains[i].flags & RZG2L_PD_F_ALWAYS_ON);
> >>                 struct rzg2l_cpg_pd *pd;
> >>
> >>                 pd = devm_kzalloc(dev, sizeof(*pd), GFP_KERNEL);
> >> @@ -1796,11 +1817,11 @@ static int __init rzg2l_cpg_add_pm_domains(struct rzg2l_cpg_priv *priv)
> >>                 pd->id = info->pm_domains[i].id;
> >>                 pd->priv = priv;
> >>
> >> -               ret = rzg2l_cpg_pd_setup(pd, always_on);
> >> +               ret = rzg2l_cpg_pd_setup(pd, info->pm_domains[i].flags);
> >>                 if (ret)
> >>                         return ret;
> >>
> >> -               if (always_on) {
> >> +               if (info->pm_domains[i].flags & RZG2L_PD_F_ALWAYS_ON) {
> >>                         ret = rzg2l_cpg_power_on(&pd->genpd);
> >>                         if (ret)
> >>                                 return ret;
> >> @@ -1890,9 +1911,43 @@ static int __init rzg2l_cpg_probe(struct platform_device *pdev)
> >>         if (error)
> >>                 return error;
> >>
> >> +       dev_set_drvdata(dev, priv);
> >> +
> >>         return 0;
> >>  }
> >>
> >> +static int rzg2l_cpg_resume(struct device *dev)
> >> +{
> >> +       struct rzg2l_cpg_priv *priv = dev_get_drvdata(dev);
> >> +       const struct rzg2l_cpg_info *info = priv->info;
> >> +
> >> +       /* Power on always ON domains. */
> >> +       for (unsigned int i = 0; i < info->num_pm_domains; i++) {
> >> +               if (info->pm_domains[i].flags & RZG2L_PD_F_ALWAYS_ON) {
> >> +                       int ret = rzg2l_cpg_power_on(priv->domains[i]);
> >> +
> >> +                       if (ret)
> >> +                               return ret;
> >> +               }
> >> +       }
> >
> > I don't quite understand why this is needed? Is always-on PM domains
> > being powered-off during system wide suspend, so you need to power
> > them on again?
>
> Yes, as power to most of the system parts is cut off during sytem suspend
> (and DDR is kept in retention mode) and the resume is almost like a cold
> boot where the TF-A does basic re-initialization and then pass execution to
>  Linux resume code.

Hmm. If these are really always-on PM domains, why isn't the FW
powering them on again then before returning to Linux after a system
resume?

In a way it sounds to me that they aren't really always-on PM domains,
as Linux seems to be capable of turning them on/off too, right?

That said, perhaps using GENPD_FLAG_RPM_ALWAYS_ON instead of
GENPD_FLAG_ALWAYS_ON for some PM domains can be another way forward?
In this way, the ->power_on|off() callbacks can be used to turn on/off
the PM domains, but only during system suspend/resume. Would that
work?

[...]

Kind regards
Uffe

