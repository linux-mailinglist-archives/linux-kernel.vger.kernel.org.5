Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CE977D4BC9
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 11:19:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233950AbjJXJTx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 05:19:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232558AbjJXJTt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 05:19:49 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB48DC2
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 02:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698139187; x=1729675187;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=l2nhajNAdRYJlbrDuQ/yj4fPHTTxLS3ZUphedGiZKuQ=;
  b=UmS/gGqkVGY67lZv05hKHPulupWQoP+XrGI6cRI69RFQiuWZXTO/jBym
   cdpnumWaGiOMt27hF1uSdFonumz7pjwwCNDS/KqQIfAm4EjYRDEh2poWI
   JVQ+uridamRm3C0BEV/rXmalSUfkhcA8pDIVgwrBsAqeYHau5kHzkcOdF
   0fekOgMWUP8B5p/R7t/bRpbYB3uGxgqWiNV31oOoZKBEYVOOwZXDwhwPd
   D2Q/KdmxoP5W/kp4AahpftGJkHXa8R6zCv+6cctGNDeBHwMEybkSOWPo/
   7OfpuHSwobjFhCbHjd4SymzqCVwRK96QAGKjFFAr+Kmok4jY3ugbbvttK
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="366362795"
X-IronPort-AV: E=Sophos;i="6.03,247,1694761200"; 
   d="scan'208";a="366362795"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2023 02:19:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="849074498"
X-IronPort-AV: E=Sophos;i="6.03,247,1694761200"; 
   d="scan'208";a="849074498"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 24 Oct 2023 02:19:45 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 974B994; Tue, 24 Oct 2023 12:19:43 +0300 (EEST)
Date:   Tue, 24 Oct 2023 12:19:43 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Michael Walle <michael@walle.cc>
Cc:     AceLan Kao <acelan.kao@canonical.com>,
        Tudor Ambarus <tudor.ambarus@linaro.org>,
        Pratyush Yadav <pratyush@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mtd: spi-nor: Improve reporting for software reset
 failures
Message-ID: <20231024091943.GD3208943@black.fi.intel.com>
References: <20231024074332.462741-1-acelan.kao@canonical.com>
 <4c11d06931f9b4e29c0e8feafc18e763@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4c11d06931f9b4e29c0e8feafc18e763@walle.cc>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Oct 24, 2023 at 10:59:50AM +0200, Michael Walle wrote:
> [+Mika]
> 
> 
> > From: "Chia-Lin Kao (AceLan)" <acelan.kao@canonical.com>
> > 
> > When the software reset command isn't supported, we now report it as an
> > informational message(dev_info) instead of a warning(dev_warn).
> > This adjustment helps avoid unnecessary alarm and confusion regarding
> > software reset capabilities.
> > 
> > v2. only lower the priority for the not supported failure
> > 
> > Signed-off-by: Chia-Lin Kao (AceLan) <acelan.kao@canonical.com>
> > ---
> >  drivers/mtd/spi-nor/core.c | 10 ++++++++--
> >  1 file changed, 8 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
> > index 1b0c6770c14e..76920dbc568b 100644
> > --- a/drivers/mtd/spi-nor/core.c
> > +++ b/drivers/mtd/spi-nor/core.c
> > @@ -3252,7 +3252,10 @@ static void spi_nor_soft_reset(struct spi_nor
> > *nor)
> > 
> >  	ret = spi_mem_exec_op(nor->spimem, &op);
> >  	if (ret) {
> > -		dev_warn(nor->dev, "Software reset failed: %d\n", ret);
> > +		if (ret == -ENOTSUPP)
> 
> It bothers me that we use ENOTSUPP here. We should really use EOPNOTSUPP.
> The core uses EOPNOTSUPP everywhere except for the intel things.
> 
> Please have a look at changing that to EOPNOTSUPP. See also:
> https://lore.kernel.org/linux-mtd/85f9c462-c155-dc17-dc97-3254acfa55d2@microchip.com/

Makes sense.

> > +			dev_info(nor->dev, "Software reset enable command doesn't support:
> > %d\n", ret);
> 
> I'm not sure this is helpful. It's only the intel SPI controller which
> does magic things (instead of just issuing our commands). Mika, do you
> know wether your controller will do a reset on it's own? I presume so,
> because AFAIR you have some kind of high level controller which also does
> SFDP parsing and read opcode handling on their own.

Yes, that's right.
