Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 753C7787531
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 18:24:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242491AbjHXQXf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 12:23:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242483AbjHXQXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 12:23:13 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ED0619AC;
        Thu, 24 Aug 2023 09:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692894192; x=1724430192;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JFT3ymVXjR1RLSxdJttkiZY5DC9NsR7CjrAq8kMVtrg=;
  b=ht9dsrw08+rb4YcivnfjxvswRz8maXsoFTVjkeYGTNJmm9No6OxuPYAg
   Vpdv/ZglEWZvN89nU5p5zd7EEzCDJq8cLXXFQlc7tBQWr62ZymEV7j9rs
   HfaB3Xe/yeQy8X5wtWnxZOzb7iefKbQvDIdsPnuNBWTrCNuTZpXGPZG9W
   0OGXvmuqGyM3orf8mxDjDequurfXeAGDB5Zt1Aa66XtBiGME0si5vXQCK
   KIxlr0swMXKknMZzx7U/6YFWWK+EFG6Ke1WHJ+TGoMaZIUQozO0hfRUYN
   EIAaLBQhS9hG44P3qG8EXu1ZiREJNW4wETWK1z5WGG6Vlcse+9V7iy/bv
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="359487450"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="359487450"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2023 09:22:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="766599817"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="766599817"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 24 Aug 2023 09:22:15 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id F390924C; Thu, 24 Aug 2023 19:22:13 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Alexander Sverdlin <alexander.sverdlin@siemens.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>
Subject: [PATCH v1 3/3] spidev: Simplify SPI_IOC_RD_MODE* cases in spidev_ioctl()
Date:   Thu, 24 Aug 2023 19:22:09 +0300
Message-Id: <20230824162209.2890440-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20230824162209.2890440-1-andriy.shevchenko@linux.intel.com>
References: <20230824162209.2890440-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The temporary variable tmp is not used outside of the
SPI_IOC_RD_MODE* cases, hence we can optimize its use.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Lukas Wunner <lukas@wunner.de>
---
 drivers/spi/spidev.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spidev.c b/drivers/spi/spidev.c
index e324b42c658c..c5450217528b 100644
--- a/drivers/spi/spidev.c
+++ b/drivers/spi/spidev.c
@@ -391,17 +391,15 @@ spidev_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 	/* read requests */
 	case SPI_IOC_RD_MODE:
 	case SPI_IOC_RD_MODE32:
-		tmp = spi->mode;
+		tmp = spi->mode & SPI_MODE_MASK;
 
 		if (ctlr->use_gpio_descriptors && spi_get_csgpiod(spi, 0))
 			tmp &= ~SPI_CS_HIGH;
 
 		if (cmd == SPI_IOC_RD_MODE)
-			retval = put_user(tmp & SPI_MODE_MASK,
-					  (__u8 __user *)arg);
+			retval = put_user(tmp, (__u8 __user *)arg);
 		else
-			retval = put_user(tmp & SPI_MODE_MASK,
-					  (__u32 __user *)arg);
+			retval = put_user(tmp, (__u32 __user *)arg);
 		break;
 	case SPI_IOC_RD_LSB_FIRST:
 		retval = put_user((spi->mode & SPI_LSB_FIRST) ?  1 : 0,
-- 
2.40.0.1.gaa8946217a0b

