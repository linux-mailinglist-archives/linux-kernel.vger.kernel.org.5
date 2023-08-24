Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5183C787539
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 18:24:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242511AbjHXQYJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 12:24:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242502AbjHXQXn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 12:23:43 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E88501BE;
        Thu, 24 Aug 2023 09:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692894221; x=1724430221;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=q9V0U1YKW0QwosCD9F4IkgFyJi6mucyN+dXeisMRhkU=;
  b=dJaAmeunr8JFWVP1uR351PsXn3aarn6kU/I+rs4iD+/s7F8sMt2SjsQL
   MzAW5pWFHFnNWM19pKCpjkocLAhKr3pPkGr+mY0ZK5DnwT75zn9oxSjtf
   q7lQcIjB2H7VjaDsyR5ZWV9TNsw38CNZSMb5KKf0x/0YkO+pcr0W021og
   8irW/nek8/rNp2E+NV6E/IKDyJfOVOVe6q62juxZBmGOwktpu82h56EXc
   EcoYavTJjTQwn0Jt9QnqRj0FIrrT6StoXqljhB9XHQvo6tXhGYNuSp8Jk
   iVMRNsaMZHE2paOWMo6BsA46WWZyIV+JzPLlswxDSZqwSeYrtUePs8H06
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="377235994"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="377235994"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2023 09:22:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="851582219"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="851582219"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 24 Aug 2023 09:22:15 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id D6B3768; Thu, 24 Aug 2023 19:22:13 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Alexander Sverdlin <alexander.sverdlin@siemens.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/3] spidev: Decrease indentation level in spidev_ioctl() SPI_IOC_RD_MODE*
Date:   Thu, 24 Aug 2023 19:22:07 +0300
Message-Id: <20230824162209.2890440-2-andriy.shevchenko@linux.intel.com>
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

Instead of defining a local controller variable inside an indented
block, move the definition to the top of spidev_ioctl() and reuse
it in the SPI_IOC_RD_MODE* and SPI_IOC_WR_MODE* cases.

This drops unneeded indentation and reduces amount of LoCs.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spidev.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spidev.c b/drivers/spi/spidev.c
index d13dc15cc191..dc516f0ca71f 100644
--- a/drivers/spi/spidev.c
+++ b/drivers/spi/spidev.c
@@ -357,6 +357,7 @@ spidev_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 	int			retval = 0;
 	struct spidev_data	*spidev;
 	struct spi_device	*spi;
+	struct spi_controller	*ctlr;
 	u32			tmp;
 	unsigned		n_ioc;
 	struct spi_ioc_transfer	*ioc;
@@ -376,6 +377,8 @@ spidev_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 		return -ESHUTDOWN;
 	}
 
+	ctlr = spi->controller;
+
 	/* use the buffer lock here for triple duty:
 	 *  - prevent I/O (from us) so calling spi_setup() is safe;
 	 *  - prevent concurrent SPI_IOC_WR_* from morphing
@@ -390,13 +393,9 @@ spidev_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 	case SPI_IOC_RD_MODE32:
 		tmp = spi->mode;
 
-		{
-			struct spi_controller *ctlr = spi->controller;
-
-			if (ctlr->use_gpio_descriptors && ctlr->cs_gpiods &&
-			    ctlr->cs_gpiods[spi_get_chipselect(spi, 0)])
-				tmp &= ~SPI_CS_HIGH;
-		}
+		if (ctlr->use_gpio_descriptors && ctlr->cs_gpiods &&
+		    ctlr->cs_gpiods[spi_get_chipselect(spi, 0)])
+			tmp &= ~SPI_CS_HIGH;
 
 		if (cmd == SPI_IOC_RD_MODE)
 			retval = put_user(tmp & SPI_MODE_MASK,
@@ -424,7 +423,6 @@ spidev_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 		else
 			retval = get_user(tmp, (u32 __user *)arg);
 		if (retval == 0) {
-			struct spi_controller *ctlr = spi->controller;
 			u32	save = spi->mode;
 
 			if (tmp & ~SPI_MODE_MASK) {
-- 
2.40.0.1.gaa8946217a0b

