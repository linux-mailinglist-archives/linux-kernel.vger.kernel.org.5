Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C942880CF20
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 16:12:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344102AbjLKPMm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 10:12:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343886AbjLKPMi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 10:12:38 -0500
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B19FDEB;
        Mon, 11 Dec 2023 07:12:43 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 86060E0002;
        Mon, 11 Dec 2023 15:12:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1702307562;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AK2BzAx/YAHFbh+6Z+0veROK6HPT0/oAubfaxj7UV2s=;
        b=HztDremxIKWyhs4ljQkUaZkbUnkwWn3NamgaEJlyhZLnq7OoF09J2svtlEqppxF+2rFsmS
        FNMGnqBM38azQmBQUAq/NYb8lNmqBEBsaWeCZFspt0Xg3hYHkLJpZMgjMOBI153sp/nTF1
        l7oUhk9myflVEYuLZh8u25rzeHSv/7yyonWorOnDUgCWHI0rwIxfjBaI3/y0y/dfcLGlYd
        pXUqTfZ4d1pRpLAlaVvuVyf5bl2c4/bOnlI/IOwEXBbuE3gEYCubQegSqP/ILiyd2gUqCY
        tSXqIC+Qbr/PG+7ES0+Tt0GkMzm3ENvr/yj/MKDjwUL4Is0B36EMq1qiWd7L4A==
From:   Romain Gantois <romain.gantois@bootlin.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Ard Biesheuvel <ardb@kernel.org>
Cc:     Romain Gantois <romain.gantois@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Herve Codina <herve.codina@bootlin.com>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-efi@vger.kernel.org
Subject: [RFC PATCH 1/6] block: partitions: efi: Move efi.h header to include/linux/gpt.h
Date:   Mon, 11 Dec 2023 16:12:37 +0100
Message-ID: <20231211151244.289349-2-romain.gantois@bootlin.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231211151244.289349-1-romain.gantois@bootlin.com>
References: <20231211151244.289349-1-romain.gantois@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: romain.gantois@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The GPT parser located in the block layer defines all of the GPT-specific
data structures and logic that are necessary to parse this kind of
partition table. However, it is also specifically tailored for block
devices.

Assuming that different GPT parsers will be implemented in other kernel
subsystems, it is desirable to create a common set of GPT struct
definitions, macros and helpers, so as to limit code reuse between parsers.

As a first step towards this common codebase, this commit moves the efi.h
header, that contains GPT-specific definitions, to include/linux/gpt.h.

There is no functional change.

Signed-off-by: Romain Gantois <romain.gantois@bootlin.com>
---
 MAINTAINERS                                   | 3 ++-
 block/partitions/efi.c                        | 2 +-
 block/partitions/msdos.c                      | 2 +-
 block/partitions/efi.h => include/linux/gpt.h | 0
 4 files changed, 4 insertions(+), 3 deletions(-)
 rename block/partitions/efi.h => include/linux/gpt.h (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 97f51d5ec1cf..22e37e2ea1ae 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9233,7 +9233,8 @@ GUID PARTITION TABLE (GPT)
 M:	Davidlohr Bueso <dave@stgolabs.net>
 L:	linux-efi@vger.kernel.org
 S:	Maintained
-F:	block/partitions/efi.*
+F:	block/partitions/efi.c
+F:	include/linux/gpt.h
 
 HABANALABS PCI DRIVER
 M:	Oded Gabbay <ogabbay@kernel.org>
diff --git a/block/partitions/efi.c b/block/partitions/efi.c
index 5e9be13a56a8..db50c3f2bab3 100644
--- a/block/partitions/efi.c
+++ b/block/partitions/efi.c
@@ -87,8 +87,8 @@
 #include <linux/ctype.h>
 #include <linux/math64.h>
 #include <linux/slab.h>
+#include <linux/gpt.h>
 #include "check.h"
-#include "efi.h"
 
 /* This allows a kernel command line option 'gpt' to override
  * the test for invalid PMBR.  Not __initdata because reloading
diff --git a/block/partitions/msdos.c b/block/partitions/msdos.c
index b5d5c229cc3b..d0376cf27448 100644
--- a/block/partitions/msdos.c
+++ b/block/partitions/msdos.c
@@ -27,9 +27,9 @@
  */
 #include <linux/msdos_fs.h>
 #include <linux/msdos_partition.h>
+#include <linux/gpt.h>
 
 #include "check.h"
-#include "efi.h"
 
 /*
  * Many architectures don't like unaligned accesses, while
diff --git a/block/partitions/efi.h b/include/linux/gpt.h
similarity index 100%
rename from block/partitions/efi.h
rename to include/linux/gpt.h
-- 
2.43.0

