Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E9C1759743
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 15:48:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230333AbjGSNsS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 09:48:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjGSNsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 09:48:16 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0430D197
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 06:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689774496; x=1721310496;
  h=from:to:cc:subject:date:message-id;
  bh=LjqK/tmNoiLq39k4+y5wWdRySbSnPHlhMJYPPGh+QG0=;
  b=l6o15yjWzItd+v74o6fT6q0tW5nDzESQPnrZ91H0kEn6vxtrnzAGaN7B
   WlTrrpnGrKa4oIr5CSss94fHE0p/I6LHKy/5F8n8rhLCwBaxTipgRyWIl
   O9AmBeRJlIUA+UAmpgZ3Px8SOScUh3gUZpNYWwCW3Afgmddo9IKfu+mFY
   Qd8zee9FR8vQLuiFKwMA/8D4x7OXn6h/ckFihg9A1+jgEsYCdnDPNcqAy
   LEGNbnxKoAj7ZUUdezj3QF0Qv9TX+a3+6N2SsIx9EizYpncrJwuyOautM
   ugWbuZg0uWblwYiBAnblBtHN/MhpkZiQftqP3L9bwvKNrm0PkadkfJkmS
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="365348307"
X-IronPort-AV: E=Sophos;i="6.01,216,1684825200"; 
   d="scan'208";a="365348307"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2023 06:48:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="789426638"
X-IronPort-AV: E=Sophos;i="6.01,216,1684825200"; 
   d="scan'208";a="789426638"
Received: from srikandan-ilbpg12.png.intel.com ([10.88.229.69])
  by fmsmga008.fm.intel.com with ESMTP; 19 Jul 2023 06:47:51 -0700
From:   mahesh.r.vaidya@intel.com
To:     tudor.ambarus@linaro.org, pratyush@kernel.org, michael@walle.cc,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     andriy.shevchenko@linux.intel.com, jarkko.nikula@intel.com,
        furong.zhou@intel.com, mallikarjunappa.sangannavar@intel.com,
        nandhini.srikandan@intel.com, rashmi.a@intel.com,
        mahesh.r.vaidya@intel.com
Subject: [PATCH v1] mtd: spi-nor: macronix: Add support for MX77U25650F
Date:   Wed, 19 Jul 2023 21:27:00 +0800
Message-Id: <20230719132700.15274-1-mahesh.r.vaidya@intel.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mahesh R Vaidya <mahesh.r.vaidya@intel.com>

The MX7725650F is production chip for new design from Macronix
with a lesser memory of 256Mbit with unique security features
like Permanent 4 I/O RPMC, Secured 8K OTP support.

Validated by read, erase, write and read back.
Tested on Intel RPL, PASS.
Tested-by: Mahesh R Vaidya <mahesh.r.vaidya@intel.com>

Signed-off-by: Mahesh R Vaidya <mahesh.r.vaidya@intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/mtd/spi-nor/macronix.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mtd/spi-nor/macronix.c b/drivers/mtd/spi-nor/macronix.c
index 04888258e891..995936ba58e2 100644
--- a/drivers/mtd/spi-nor/macronix.c
+++ b/drivers/mtd/spi-nor/macronix.c
@@ -103,6 +103,9 @@ static const struct flash_info macronix_nor_parts[] = {
 	{ "mx66u2g45g",	 INFO(0xc2253c, 0, 64 * 1024, 4096)
 		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ)
 		FIXUP_FLAGS(SPI_NOR_4B_OPCODES) },
+	{ "mx77u25650f",  INFO(0xc27539, 0, 64 * 1024, 512)
+		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ)
+		FIXUP_FLAGS(SPI_NOR_4B_OPCODES) },
 };
 
 static void macronix_nor_default_init(struct spi_nor *nor)
-- 
2.17.1

