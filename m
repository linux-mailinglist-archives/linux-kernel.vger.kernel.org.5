Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D163F779142
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 16:03:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234788AbjHKODO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 10:03:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbjHKODN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 10:03:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AB16D7;
        Fri, 11 Aug 2023 07:03:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3563461027;
        Fri, 11 Aug 2023 14:03:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88A98C433C8;
        Fri, 11 Aug 2023 14:03:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691762591;
        bh=Rwte/OWk/9AiP4X5ERNrL4uMce/okwOLafpa1wIjvcU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iHxF4zhpAyB1MpfdvOyE9wXlrfpIeAzo4t5tPxRh0wYKbOSc0LZXB5LdvRl98GgRD
         uc9bYvmtzMWnYB4RbApbvXg9nibbNKnOsnzSDs/UXtV039ZYpHmyUp7UhzjdyIS/4Z
         FPXKn0OgFrhWfCAe6S3+Ftl4Wzj7b6oLDw/AUoQoeTPZ8YiI3OOBtlz3quB0cVFjbq
         UjWMP53q61ClEw66XSwz56A1bes64qQj3FJybtKAm2Ie4fKexYIvkkYu/ya8+kw5lo
         xIiGj9zA1TgT/QMwTUaxI0oCUcYHb5AszCpcb7EwwrcHM7tME8q1ilm9GWKTrpA4uR
         LCoxTjbORxdGw==
Date:   Fri, 11 Aug 2023 22:02:59 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Peng Fan <peng.fan@nxp.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: Re: [PATCH V3 0/8] genpd: imx: relocate scu-pd and misc update
Message-ID: <20230811140259.GT151430@dragon>
References: <20230731064746.2717684-1-peng.fan@oss.nxp.com>
 <CAPDyKFqvP71ZDcamFo5AijhTXEJKHUPNE=-dOvXYw3pr4XxK6A@mail.gmail.com>
 <DU0PR04MB9417E648E4442FE8518CFB9E8812A@DU0PR04MB9417.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DU0PR04MB9417E648E4442FE8518CFB9E8812A@DU0PR04MB9417.eurprd04.prod.outlook.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 09, 2023 at 01:32:28AM +0000, Peng Fan wrote:
> > Subject: Re: [PATCH V3 0/8] genpd: imx: relocate scu-pd and misc update
> > 
> > On Mon, 31 Jul 2023 at 08:43, Peng Fan (OSS) <peng.fan@oss.nxp.com>
> > wrote:
> > >
> > > From: Peng Fan <peng.fan@nxp.com>
> > >
> > > V3:
> > >  return -EBUSY instead of return 0 in patch 4
> > >
> > > V2:
> > > Move drivers/firmware/imx/scu-pd.c to drivers/genpd/imx
> > >
> > > This patchset is to upstream NXP downstream scu-pd driver patches.
> > > patch is to relocate scu-pd to genpd
> > > patch 2,3 is to support more PDs
> > > patch 4 is to not power off console when no console suspend patch 5 is
> > > to suppress bind patch 6 is to make genpd align with HW state patch 7
> > > is to support LP mode in runtime suspend, OFF mode in system suspend.
> > > patch 8 is to change init level to avoid uneccessary defer probe
> > >
> > > V1:
> > > This patchset is to upstream NXP downstream scu-pd driver patches.
> > > patch 1,2 is to support more PDs
> > > patch 3 is to not power off console when no console suspend patch 4 is
> > > to suppress bind patch 5 is to make genpd align with HW state patch 6
> > > is to support LP mode in runtime suspend, OFF mode in system suspend.
> > > patch 7 is to change init level to avoid uneccessary defer probe
> > >
> > > Dong Aisheng (1):
> > >   genpd: imx: scu-pd: change init level to subsys_initcall
> > >
> > > Peng Fan (7):
> > >   genpd: imx: relocate scu-pd under genpd
> > >   genpd: imx: scu-pd: enlarge PD range
> > >   genpd: imx: scu-pd: add more PDs
> > >   genpd: imx: scu-pd: do not power off console if no_console_suspend
> > >   genpd: imx: scu-pd: Suppress bind attrs
> > >   genpd: imx: scu-pd: initialize is_off according to HW state
> > >   genpd: imx: scu-pd: add multi states support
> > >
> > >  drivers/firmware/imx/Makefile            |   1 -
> > >  drivers/genpd/imx/Makefile               |   1 +
> > >  drivers/{firmware => genpd}/imx/scu-pd.c | 193
> > > +++++++++++++++++++++--
> > >  3 files changed, 183 insertions(+), 12 deletions(-)  rename
> > > drivers/{firmware => genpd}/imx/scu-pd.c (70%)
> > >
> > 
> > Moving this to the new genpd subsystem makes sense to me.
> > 
> > Even if we can't get the whole series ready for v6.6, we can certainly pick
> > patch1. Either we can funnel this via my new genpd tree [1] or if Shawn
> > picks it up. If the latter, Shawn needs to merge my immutable branch [2]
> > before applying. I am fine either way.
> 
> There is no rush to catch v6.6 for this patchset.  It could go via your genpd
> tree for v6.7 from my view. Anyway, up to you and Shawn to decide.

I prefer to have this go via genpd tree.

Shawn
