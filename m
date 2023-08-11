Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18EA17790F0
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 15:42:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230303AbjHKNmv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 09:42:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjHKNms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 09:42:48 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F5F1ED;
        Fri, 11 Aug 2023 06:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691761368; x=1723297368;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3qCbXJc2LqA6wB4P5vKT0CVjgaPzi1I6Wyv4XAX2IK0=;
  b=grZy0lwnLMJL5PLZUMBd6w4or7JvD7gE2kgf1yLhx2D0UaBcQ7NkZYwZ
   XZYggAVT8Hq9B+sJUXt54NAnkE9pcayMr/ROSZzwigOq2TXoUAVAsKj9t
   UYPP0zi2XqOc4pa4f/UvJZHl5clEGvADc/QEJifA53psvDdceYopN6ZSW
   5vR53q9yxWNgLdkBICJ4kLdvuSyKLfrgDc/Xhygz4L/Aq/wGrzltC4e/P
   uMbiwynFnzkHYpLMQbaMVP4LvsybQIUGripSTMhg9ErqxrNrg65yqOd2g
   nmetYujmMp4vLguoAWU3SbNZVce9SXjxUiEndy3RTijrmY8RMHPMbEKdi
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="371682698"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; 
   d="scan'208";a="371682698"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2023 06:42:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="802669536"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; 
   d="scan'208";a="802669536"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004.fm.intel.com with ESMTP; 11 Aug 2023 06:42:39 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qUSPT-00HEuE-0U;
        Fri, 11 Aug 2023 16:42:35 +0300
Date:   Fri, 11 Aug 2023 16:42:34 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, Yangtao Li <frank.li@vivo.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Kamal Dasu <kamal.dasu@broadcom.com>,
        Al Cooper <alcooperx@gmail.com>,
        Michal Simek <michal.simek@amd.com>,
        Eugen Hristev <eugen.hristev@collabora.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        Steen Hegelund <Steen.Hegelund@microchip.com>,
        Daniel Machon <daniel.machon@microchip.com>,
        UNGLinuxDriver@microchip.com,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Brian Norris <briannorris@chromium.org>,
        Ye Xingchen <ye.xingchen@zte.com.cn>,
        Brad Larson <blarson@amd.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>,
        Swati Agarwal <swati.agarwal@amd.com>,
        Andy Tang <andy.tang@nxp.com>,
        Georgii Kruglov <georgy.kruglov@yandex.ru>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Doug Brown <doug@schmorgal.com>,
        Li Zetao <lizetao1@huawei.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 00/16] mmc: sdhci-pltfm: Minor clean up
Message-ID: <ZNY6yuLTjW/cHioP@smile.fi.intel.com>
References: <20230811130351.7038-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230811130351.7038-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 11, 2023 at 04:03:35PM +0300, Adrian Hunter wrote:
> Hi
> 
> sdhci_pltfm_unregister() does:
> 
> 	clk_disable_unprepare(pltfm_host->clk)
> 
> which prevents drivers from using devm_clk_get_enabled() or similar.
> 
> Move it out, and where drivers are doing devm_clk_get*() immediately
> followed by clk_prepare_enable(), combine them into devm_clk_get_*enabled().
> 
> sdhci_pltfm_register() and sdhci_pltfm_unregister() are not paired functions.
> That are just helpers and effectively get renamed:
> 
> 	sdhci_pltfm_register() -> sdhci_pltfm_init_and_add_host()
> 	sdhci_pltfm_unregister() -> sdhci_pltfm_remove()
> 
> Please note, the patches are based on top of some 
> "Convert to platform remove callback returning void"
> patches by Yangtao Li, which were posted here:
> 
> 	https://lore.kernel.org/linux-mmc/20230727070051.17778-1-frank.li@vivo.com/
> 
> Patches can also be found here:
> 
> 	https://github.com/ahunter6/linux/commits/sdhci-pltfm-cleanup-1

All look good to me, thanks!
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Adrian Hunter (16):
>       mmc: sdhci-pltfm: Add sdhci_pltfm_remove()
>       mmc: sdhci-bcm-kona: Use sdhci_pltfm_remove()
>       mmc: sdhci-brcmstb: Use sdhci_pltfm_remove()
>       mmc: sdhci-cadence: Use sdhci_pltfm_remove()
>       mmc: sdhci-dove: Use sdhci_pltfm_remove()
>       mmc: sdhci_f_sdh30: Use sdhci_pltfm_remove()
>       mmc: sdhci-iproc: Use sdhci_pltfm_remove()
>       mmc: sdhci-of-arasan: Use sdhci_pltfm_remove()
>       mmc: sdhci-of-at91: Use sdhci_pltfm_remove()
>       mmc: sdhci-of-esdhc: Use sdhci_pltfm_remove()
>       mmc: sdhci-of-hlwd: Use sdhci_pltfm_remove()
>       mmc: sdhci-of-sparx5: Use sdhci_pltfm_remove()
>       mmc: sdhci-pxav2: Use sdhci_pltfm_remove()
>       mmc: sdhci-st: Use sdhci_pltfm_remove()
>       mmc: sdhci-pltfm: Remove sdhci_pltfm_unregister()
>       mmc: sdhci-pltfm: Rename sdhci_pltfm_register()
> 
>  drivers/mmc/host/sdhci-bcm-kona.c  | 12 +++++++++++-
>  drivers/mmc/host/sdhci-brcmstb.c   | 18 +++++-------------
>  drivers/mmc/host/sdhci-cadence.c   | 17 ++++-------------
>  drivers/mmc/host/sdhci-dove.c      |  8 ++------
>  drivers/mmc/host/sdhci-iproc.c     | 14 +++-----------
>  drivers/mmc/host/sdhci-of-arasan.c |  4 +++-
>  drivers/mmc/host/sdhci-of-at91.c   |  2 +-
>  drivers/mmc/host/sdhci-of-esdhc.c  |  2 +-
>  drivers/mmc/host/sdhci-of-hlwd.c   |  4 ++--
>  drivers/mmc/host/sdhci-of-sparx5.c | 17 ++++++-----------
>  drivers/mmc/host/sdhci-pltfm.c     | 14 ++++++--------
>  drivers/mmc/host/sdhci-pltfm.h     |  8 ++++----
>  drivers/mmc/host/sdhci-pxav2.c     | 19 ++++++-------------
>  drivers/mmc/host/sdhci-st.c        |  4 +++-
>  drivers/mmc/host/sdhci_f_sdh30.c   |  2 +-
>  15 files changed, 58 insertions(+), 87 deletions(-)
> 
> 
> Regards
> Adrian

-- 
With Best Regards,
Andy Shevchenko


