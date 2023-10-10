Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10C597C01AC
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 18:32:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233612AbjJJQcD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 12:32:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232892AbjJJQb5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 12:31:57 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3B31AF;
        Tue, 10 Oct 2023 09:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696955516; x=1728491516;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ytB0frCPdmRXHl9oVp9UEDdaPdm875JeU+Ur4Pw4Tgo=;
  b=I3E2D8xxXY6ZPk65P88BT6VzLgncJb8jTD3IA3FtUPuN14bem3T17X2j
   DBKjB0JZaH6PhMCj0nIA18Q4aY1PmOcnguJpLGD7I8mhJHnrAqtMgukET
   qRnf8d7gae44FQf0hYVu8TI6WJJFKgUWz6s5VvjYAT3abHCKO4rlZt5ws
   IabeNXgwwUfbEMNO4l3e5HXlp/byg1kWWZAxmd5PuGKUDR6HNRI3kGfKC
   xqRTENeRaBius6JUe5dxT3gptS9/CRb4RHBLoWw4qdS5A4X9a/C6rymRr
   g9QY3HbQwXJQ+S9P9+i3hKkFpI13pGiy2bLyOY0zKKpgK84H+ZCPt+kXE
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="6006234"
X-IronPort-AV: E=Sophos;i="6.03,213,1694761200"; 
   d="scan'208";a="6006234"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2023 09:31:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="1000761482"
X-IronPort-AV: E=Sophos;i="6.03,213,1694761200"; 
   d="scan'208";a="1000761482"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 10 Oct 2023 09:31:05 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id D1554128; Tue, 10 Oct 2023 19:31:03 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mark Brown <broonie@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH v1 1/1] spi: Don't use flexible array in struct spi_message definition
Date:   Tue, 10 Oct 2023 19:31:00 +0300
Message-Id: <20231010163100.89734-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The struct spi_message can be embedded into another structures.
With that the flexible array might be problematic as sparse
complains about it, although there is no real issue in the code
because when the message is embedded it doesn't use flexible array
member. That memeber is a private to spi_message_alloc() API, so
move it to that API in a form of an inherited data type.

Reported-by: Marc Kleine-Budde <mkl@pengutronix.de>
Fixes: 75e308ffc4f0 ("spi: Use struct_size() helper"))
Closes: https://lore.kernel.org/r/20231009-onshore-underage-c58415adfd92-mkl@pengutronix.de
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/spi/spi.h | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 7f8b478fdeb3..487da1f6e4b7 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -1086,8 +1086,6 @@ struct spi_transfer {
  * @state: for use by whichever driver currently owns the message
  * @resources: for resource management when the SPI message is processed
  * @prepared: spi_prepare_message was called for the this message
- * @t: for use with spi_message_alloc() when message and transfers have
- *	been allocated together
  *
  * A @spi_message is used to execute an atomic sequence of data transfers,
  * each represented by a struct spi_transfer.  The sequence is "atomic"
@@ -1142,9 +1140,6 @@ struct spi_message {
 
 	/* List of spi_res resources when the SPI message is processed */
 	struct list_head        resources;
-
-	/* For embedding transfers into the memory of the message */
-	struct spi_transfer	t[];
 };
 
 static inline void spi_message_init_no_memset(struct spi_message *m)
@@ -1203,17 +1198,21 @@ struct spi_transfer *xfers, unsigned int num_xfers)
  */
 static inline struct spi_message *spi_message_alloc(unsigned ntrans, gfp_t flags)
 {
-	struct spi_message *m;
+	struct spi_message_with_transfers {
+		struct spi_message m;
+		struct spi_transfer t[];
+	} *mwt;
+	unsigned i;
 
-	m = kzalloc(struct_size(m, t, ntrans), flags);
-	if (m) {
-		unsigned i;
+	mwt = kzalloc(struct_size(mwt, t, ntrans), flags);
+	if (!mwt)
+		return NULL;
 
-		spi_message_init_no_memset(m);
-		for (i = 0; i < ntrans; i++)
-			spi_message_add_tail(&m->t[i], m);
-	}
-	return m;
+	spi_message_init_no_memset(&mwt->m);
+	for (i = 0; i < ntrans; i++)
+		spi_message_add_tail(&mwt->t[i], &mwt->m);
+
+	return &mwt->m;
 }
 
 static inline void spi_message_free(struct spi_message *m)
-- 
2.40.0.1.gaa8946217a0b

