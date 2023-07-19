Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F295C759E11
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 21:00:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230383AbjGSTAz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 15:00:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjGSTAy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 15:00:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E2D5171E;
        Wed, 19 Jul 2023 12:00:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 94C0A617D8;
        Wed, 19 Jul 2023 19:00:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4308C433C7;
        Wed, 19 Jul 2023 19:00:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689793252;
        bh=m8elIMgvNx0HITJE8wfTnOPbpAfIc6OxVFEIrgi6Ew8=;
        h=From:To:Cc:Subject:Date:From;
        b=DjlKZMgfXAhCiIO7wXFE/nLLfkycJD34db9ewHFpZ9oT9ADKGwF1dnYTDthUFvL9q
         L4duYNtIxCemXki5jslS2vAAhMOgdhrFlpZrxBvGx8eqQod0lhKKmtWFzlbUtUCDpC
         etDaMPL+oXFbmsEGkdJ8KgRACK9zXToeo3M0FA0UHF1RjXLaKupxXcPgNttkdiCPEL
         mtdYGpBxr/gtUp+sG9k2rfwLvIpJSRaGT4UheoGgE7mlA6FiHHTctW6MUly2M3+V8x
         DAI4aUx1iOKYyvCeIfFigHmEPXItG9RYLkP8PKJ57cOEdyEtLrxkSQiU1eMn/hp3hw
         nFXkNu+H55+eA==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Tudor Ambarus <tudor.ambarus@linaro.org>,
        Pratyush Yadav <pratyush@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Peter Foley <pefoley2@pefoley.com>,
        Pedro Falcato <pedro.falcato@gmail.com>,
        Michael Walle <michael@walle.cc>,
        Mark Brown <broonie@kernel.org>,
        Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
        Dhruva Gole <d-gole@ti.com>, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Subject: [PATCH] mtd: spi-nor: avoid holes in struct spi_mem_op
Date:   Wed, 19 Jul 2023 21:00:25 +0200
Message-Id: <20230719190045.4007391-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

gcc gets confused when -ftrivial-auto-var-init=pattern is used on sparse
bit fields such as 'struct spi_mem_op', which caused the previous false
positive warning about an uninitialized variable:

drivers/mtd/spi-nor/spansion.c: error: 'op' is used uninitialized [-Werror=uninitialized]

In fact, the variable is fully initialized and gcc does not see it being
used, so the warning is entirely bogus. The problem appears to be
a misoptimization in the initialization of single bit fields when the
rest of the bytes are not initialized.

A previous workaround added another initialization, which ended up
shutting up the warning in spansion.c, though it apparently still happens
in other files as reported by Peter Foley in the gcc bugzilla. The
workaround of adding a fake initialization seems particularly bad
because it would set values that can never be correct but prevent the
compiler from warning about actually missing initializations.

Revert the broken workaround and instead pad the structure to only
have bitfields that add up to full bytes, which should avoid this
behavior in all drivers.

I also filed a new bug against gcc with what I found, so this can
hopefully be addressed in future gcc releases. At the moment, only
gcc-12 and gcc-13 are affected.

Cc: Peter Foley <pefoley2@pefoley.com>
Cc: Pedro Falcato <pedro.falcato@gmail.com>
Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=110743
Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=108402
Link: https://godbolt.org/z/efMMsG1Kx
Fixes: 420c4495b5e56 ("mtd: spi-nor: spansion: make sure local struct does not contain garbage")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/mtd/spi-nor/spansion.c | 4 ++--
 include/linux/spi/spi-mem.h    | 4 ++++
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/spi-nor/spansion.c b/drivers/mtd/spi-nor/spansion.c
index 6d6466a3436e6..8397cf3cc3306 100644
--- a/drivers/mtd/spi-nor/spansion.c
+++ b/drivers/mtd/spi-nor/spansion.c
@@ -361,7 +361,7 @@ static int cypress_nor_determine_addr_mode_by_sr1(struct spi_nor *nor,
  */
 static int cypress_nor_set_addr_mode_nbytes(struct spi_nor *nor)
 {
-	struct spi_mem_op op = {};
+	struct spi_mem_op op;
 	u8 addr_mode;
 	int ret;
 
@@ -492,7 +492,7 @@ s25fs256t_post_bfpt_fixup(struct spi_nor *nor,
 			  const struct sfdp_parameter_header *bfpt_header,
 			  const struct sfdp_bfpt *bfpt)
 {
-	struct spi_mem_op op = {};
+	struct spi_mem_op op;
 	int ret;
 
 	ret = cypress_nor_set_addr_mode_nbytes(nor);
diff --git a/include/linux/spi/spi-mem.h b/include/linux/spi/spi-mem.h
index 8e984d75f5b6c..6b0a7dc48a4b7 100644
--- a/include/linux/spi/spi-mem.h
+++ b/include/linux/spi/spi-mem.h
@@ -101,6 +101,7 @@ struct spi_mem_op {
 		u8 nbytes;
 		u8 buswidth;
 		u8 dtr : 1;
+		u8 __pad : 7;
 		u16 opcode;
 	} cmd;
 
@@ -108,6 +109,7 @@ struct spi_mem_op {
 		u8 nbytes;
 		u8 buswidth;
 		u8 dtr : 1;
+		u8 __pad : 7;
 		u64 val;
 	} addr;
 
@@ -115,12 +117,14 @@ struct spi_mem_op {
 		u8 nbytes;
 		u8 buswidth;
 		u8 dtr : 1;
+		u8 __pad : 7;
 	} dummy;
 
 	struct {
 		u8 buswidth;
 		u8 dtr : 1;
 		u8 ecc : 1;
+		u8 __pad : 6;
 		enum spi_mem_data_dir dir;
 		unsigned int nbytes;
 		union {
-- 
2.39.2

