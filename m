Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F246F787538
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 18:24:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242506AbjHXQYI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 12:24:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242500AbjHXQXm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 12:23:42 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 179FE1736;
        Thu, 24 Aug 2023 09:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692894221; x=1724430221;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ax0zHaeo1VbO9tta1swVNEvMf/cRovUF7DQd8Gh1DLo=;
  b=XflR0nA8kfstZBWi/XIKWg1UKTbtRexw205bEKucbhDGifqxKy7Jsiaq
   0+FS7PplDGBfwxkxGerI/ZSosFl6c+9Gn2sU6URQtP65k1H9WRzwprVfq
   K96S83rloAY6ZRBg/NzcbAS7aMbmU8LiCpKACqo/boneCChBaIh/x+0OM
   EGgZjHnPj55tQwN6ZPsVWLxLoGTi0Ye/Va8oWWE/YnQB+Hdu0THyYFNdn
   BfIenw70P+bjV4TnmZdlxonjqmLjOx6pj+taEemyPiojlQ137ygeEangR
   IAtAFvOce4T2oEmitHWurm3HHWasBbElqvhKHxRXwhjp7ZJDR/XpOQipR
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="377235990"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="377235990"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2023 09:22:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="851582218"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="851582218"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 24 Aug 2023 09:22:15 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id E528E1CA; Thu, 24 Aug 2023 19:22:13 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Alexander Sverdlin <alexander.sverdlin@siemens.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 2/3] spidev: Switch to use spi_get_csgpiod()
Date:   Thu, 24 Aug 2023 19:22:08 +0300
Message-Id: <20230824162209.2890440-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20230824162209.2890440-1-andriy.shevchenko@linux.intel.com>
References: <20230824162209.2890440-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

spidev_ioctl() checks if there is an SPI chip select is driven by GPIO.
Instead of current code, we can call spi_get_csgpiod().

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spidev.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spidev.c b/drivers/spi/spidev.c
index dc516f0ca71f..e324b42c658c 100644
--- a/drivers/spi/spidev.c
+++ b/drivers/spi/spidev.c
@@ -393,8 +393,7 @@ spidev_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 	case SPI_IOC_RD_MODE32:
 		tmp = spi->mode;
 
-		if (ctlr->use_gpio_descriptors && ctlr->cs_gpiods &&
-		    ctlr->cs_gpiods[spi_get_chipselect(spi, 0)])
+		if (ctlr->use_gpio_descriptors && spi_get_csgpiod(spi, 0))
 			tmp &= ~SPI_CS_HIGH;
 
 		if (cmd == SPI_IOC_RD_MODE)
@@ -430,8 +429,7 @@ spidev_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 				break;
 			}
 
-			if (ctlr->use_gpio_descriptors && ctlr->cs_gpiods &&
-			    ctlr->cs_gpiods[spi_get_chipselect(spi, 0)])
+			if (ctlr->use_gpio_descriptors && spi_get_csgpiod(spi, 0))
 				tmp |= SPI_CS_HIGH;
 
 			tmp |= spi->mode & ~SPI_MODE_MASK;
-- 
2.40.0.1.gaa8946217a0b

