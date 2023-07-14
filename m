Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE24F753398
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 09:52:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235490AbjGNHv7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 03:51:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233638AbjGNHv5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 03:51:57 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 33C9E30EA;
        Fri, 14 Jul 2023 00:51:56 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 79C9A80A8;
        Fri, 14 Jul 2023 07:51:55 +0000 (UTC)
Date:   Fri, 14 Jul 2023 10:51:54 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Nishanth Menon <nm@ti.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Tero Kristo <kristo@kernel.org>
Subject: Re: [PATCH 15/18] soc: ti: Mover power-domain drivers to the genpd
 dir
Message-ID: <20230714075154.GD5194@atomide.com>
References: <20230707140434.723349-1-ulf.hansson@linaro.org>
 <20230707140434.723349-16-ulf.hansson@linaro.org>
 <20230707175048.6yees6d3evcomyux@vacation>
 <CAPDyKFoc0hr=9LEtwwwe3R6rMn0b7TB1MCZN0ArUq+h9Pud08Q@mail.gmail.com>
 <20230711124901.7b3tw374n7eldjpj@puppy>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230711124901.7b3tw374n7eldjpj@puppy>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Nishanth Menon <nm@ti.com> [230711 12:49]:
> On 11:16-20230711, Ulf Hansson wrote:
> > On Fri, 7 Jul 2023 at 19:50, Nishanth Menon <nm@ti.com> wrote:
> > >
> > > On 16:04-20230707, Ulf Hansson wrote:
> > > > Cc: Nishanth Menon <nm@ti.com>
> > > > Cc: Santosh Shilimkar <ssantosh@kernel.org>
> > > > Cc: Tero Kristo <kristo@kernel.org>
> > > > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > > > ---
> > > >  MAINTAINERS                                   | 3 ++-
> > > >  drivers/genpd/Makefile                        | 1 +
> > > >  drivers/genpd/ti/Makefile                     | 3 +++
> > > >  drivers/{soc => genpd}/ti/omap_prm.c          | 0
> > > >  drivers/{soc => genpd}/ti/ti_sci_pm_domains.c | 0
> > > >  drivers/soc/ti/Makefile                       | 2 --
> > > >  6 files changed, 6 insertions(+), 3 deletions(-)
> > > >  create mode 100644 drivers/genpd/ti/Makefile
> > > >  rename drivers/{soc => genpd}/ti/omap_prm.c (100%)
> > > >  rename drivers/{soc => genpd}/ti/ti_sci_pm_domains.c (100%)
> > > >
> > > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > > index 9e580df3e5db..3cf16ffac892 100644
> > > > --- a/MAINTAINERS
> > > > +++ b/MAINTAINERS
> > > > @@ -21101,7 +21101,7 @@ F:    drivers/irqchip/irq-ti-sci-inta.c
> > > >  F:   drivers/irqchip/irq-ti-sci-intr.c
> > > >  F:   drivers/reset/reset-ti-sci.c
> > > >  F:   drivers/soc/ti/ti_sci_inta_msi.c
> > > > -F:   drivers/soc/ti/ti_sci_pm_domains.c
> > > > +F:   drivers/genpd/ti/ti_sci_pm_domains.c
> > > >  F:   include/dt-bindings/soc/ti,sci_pm_domain.h
> > > >  F:   include/linux/soc/ti/ti_sci_inta_msi.h
> > > >  F:   include/linux/soc/ti/ti_sci_protocol.h
> > > > @@ -21335,6 +21335,7 @@ L:    linux-kernel@vger.kernel.org
> > > >  L:   linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
> > > >  S:   Maintained
> > > >  T:   git git://git.kernel.org/pub/scm/linux/kernel/git/ti/linux.git
> > > > +F:   drivers/genpd/ti/omap_prm.c
> > >
> > > Probably the wrong place for this as omap_prm is'nt a keystone navigator
> > > driver set. Maybe Tony has a suggestion?
> > 
> > I guess we could add it to the OMAP2+ section then?
> 
> That would be my suggestion.

Makes sense to me too.

Regards,

Tony
