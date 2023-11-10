Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FE037E7E67
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 18:44:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235059AbjKJRoe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 12:44:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234970AbjKJRnu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 12:43:50 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E7067D89
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 22:44:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699598672; x=1731134672;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZyHt+VfbPMQzYvTzv5ldHjaRfCK13bx2BmONpzM1eic=;
  b=JXX4UfsEvonRLhSWEKMrzdJ9QmtnSR4x/Cp0X8+l6on2SPlJ8d/bIJkV
   cW54SqGqrnKQ14Zok0jlcmInvPDWNSJ5y2SplaJ/9zPkmkTiHUcoP9UIq
   FUZ1IJSFGlJ1Gyn5Vey44XQldWFQoDgRZUDMOfyrqJtgwFNXO7Ukiin49
   BYLn8+ABhnLVIMi2du+F31rSj9A8USMuTrWQos9y/tulfOKdjkNkEcBpo
   SrBpF39vY1JX7h9ZCckUwIXYHO2ZtLkM8hBUDzhuEjyBP2VQTVyw+I36H
   reziCMP7bvcm84MyigNNFqZE85g6ogkaAKrhggY1lxhA4DxgEuczXa7mo
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10889"; a="421226984"
X-IronPort-AV: E=Sophos;i="6.03,291,1694761200"; 
   d="scan'208";a="421226984"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2023 21:37:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10889"; a="792776503"
X-IronPort-AV: E=Sophos;i="6.03,291,1694761200"; 
   d="scan'208";a="792776503"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 09 Nov 2023 21:37:22 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 77AB114F; Fri, 10 Nov 2023 07:37:21 +0200 (EET)
Date:   Fri, 10 Nov 2023 07:37:21 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     AceLan Kao <acelan.kao@canonical.com>
Cc:     Tudor Ambarus <tudor.ambarus@linaro.org>,
        Pratyush Yadav <pratyush@kernel.org>,
        Michael Walle <michael@walle.cc>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Dhruva Gole <d-gole@ti.com>, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/2] spi: Replace -ENOTSUPP with -EOPNOTSUPP in op
 checking
Message-ID: <20231110053721.GG17433@black.fi.intel.com>
References: <20231108094303.46303-1-acelan.kao@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231108094303.46303-1-acelan.kao@canonical.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Nov 08, 2023 at 05:43:02PM +0800, AceLan Kao wrote:
> From: "Chia-Lin Kao (AceLan)" <acelan.kao@canonical.com>
> 
> No functional changes are introduced by this patch; it's a code cleanup
> to use the correct error code.

Probably good to mention here that this affect only the "SPI MEM"
drivers and the core parts. Also you could explain here that the reaosn
for this is to make sure we use unified "operation not supported" return
code accross these.

Does some kernel-doc need updating as well to make sure the future
drivers will return the correct one if they do not support given
optional operations?

> Signed-off-by: Chia-Lin Kao (AceLan) <acelan.kao@canonical.com>
> 
> ---
> v5. distinguish -EOPNOTSUPP from -ENOTSUPP
> ---
>  drivers/mtd/nand/spi/core.c | 2 +-
>  drivers/spi/atmel-quadspi.c | 2 +-
>  drivers/spi/spi-ath79.c     | 2 +-
>  drivers/spi/spi-bcm-qspi.c  | 2 +-
>  drivers/spi/spi-mem.c       | 6 +++---
>  drivers/spi/spi-npcm-fiu.c  | 2 +-
>  drivers/spi/spi-ti-qspi.c   | 4 ++--
>  drivers/spi/spi-wpcm-fiu.c  | 2 +-

I think you should include the SPI subsystem maintainer as well, at
least for visibility.
