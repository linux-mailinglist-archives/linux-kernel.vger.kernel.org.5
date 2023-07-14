Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B131A753643
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 11:18:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235802AbjGNJSV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 05:18:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231415AbjGNJSS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 05:18:18 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC6682D77;
        Fri, 14 Jul 2023 02:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689326289; x=1720862289;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=H0rPHJ2jq2GzhHsonePV+vqX4ZEBf1cEpTQE3p6vSwE=;
  b=L8LfPZ4wD2c2davDQGqrFRU8kVeBWQtGLMOkPb0XmugTaWUT3QaWfrMk
   bDG5B2IiXDf8pHuL2TV1UAEvdOymhfvvtMwvCdV3w1IDMsPnogqcgrt2s
   MuYKaHZxSiGFMiXTn95WrgVSSr+x5IdIAVDwPjFygguDno8arnqS/46Gu
   GjtAfAXhZh4EUWWjG6J+OzHnGQzJmgidsTXPKxYxoKa2v53AM3a6LPY3/
   Dw4vmBPExw5trK5mo3fvPTo1BemrN8VGbgF0Ki4k1bMETXZ6pJaRJnFoR
   JckdNAJzrdoB6HzrNSWScmMjQsIya2x5t/vtKckBGIgO/BS/DlYNA3Flo
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="365469003"
X-IronPort-AV: E=Sophos;i="6.01,204,1684825200"; 
   d="scan'208";a="365469003"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2023 02:17:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="716281744"
X-IronPort-AV: E=Sophos;i="6.01,204,1684825200"; 
   d="scan'208";a="716281744"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 14 Jul 2023 02:17:44 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id A652C4BD; Fri, 14 Jul 2023 12:17:50 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mark Brown <broonie@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCH v4 3/4] spi: Use BITS_TO_BYTES()
Date:   Fri, 14 Jul 2023 12:17:47 +0300
Message-Id: <20230714091748.89681-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20230714091748.89681-1-andriy.shevchenko@linux.intel.com>
References: <20230714091748.89681-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

BITS_TO_BYTES() is the existing macro which takes care about full
bytes that may fully hold the given amount of bits. Use it.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 05f702339182..8d6304cb061e 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -3877,11 +3877,9 @@ static int __spi_validate(struct spi_device *spi, struct spi_message *message)
 	 */
 	if ((spi->mode & SPI_CS_WORD) && (!(ctlr->mode_bits & SPI_CS_WORD) ||
 					  spi_get_csgpiod(spi, 0))) {
-		size_t maxsize;
+		size_t maxsize = BITS_TO_BYTES(spi->bits_per_word);
 		int ret;
 
-		maxsize = (spi->bits_per_word + 7) / 8;
-
 		/* spi_split_transfers_maxsize() requires message->spi */
 		message->spi = spi;
 
-- 
2.40.0.1.gaa8946217a0b

