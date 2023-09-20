Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 539537A8CCD
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 21:28:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbjITT2o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 15:28:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230096AbjITT2j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 15:28:39 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A61DDD;
        Wed, 20 Sep 2023 12:28:28 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2bfc1d8f2d2so1527691fa.0;
        Wed, 20 Sep 2023 12:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695238106; x=1695842906; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yRpb2GxtnVP5nWSE0kBTW6FlNIFe1bv1+IIvLCRkryM=;
        b=J89/KX1rrGeSm7nZZXyjFhCIYQi2CTeY96kmWBC0FVvy4u9hIPHDsK/p1DyRWpyBMJ
         fxxCPDURZmZSsIuPhPBkqjoOtHLTPuy+okI5DJOi4ZiqJi6d32s/+wrzbsIsxH72ZRss
         1O+vT04WvaiY2x5pD9E3oR526f21VcA4qgz6CFXknitRWPxBIaEK0spJyhleXN+qyaJg
         pVdYOs3g3KcnabVkv2OrDKltjDkMVB2S7J0cCk+OhuM9Eu1D3bnowI2PjF4m+tag7PYN
         ubm+Q5cBm8qAYQ8CCbn7VfXwtspHxa1DK+0NfCKviFy1ayGi3S/HMFlIrDJlJNY/Te9g
         kcAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695238106; x=1695842906;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yRpb2GxtnVP5nWSE0kBTW6FlNIFe1bv1+IIvLCRkryM=;
        b=wyXMbnoVznsu/dxDgZRiSXisqDcJ7Lrc++9owLbxuxzP3IXlLKo8TRR4Nxm+36Ry4V
         9tajnphzFNzQ/DjtHlYxsqBhnBuZF2sXs7xgrCQ9FkpMYzfOs40HOPus8YE+6hKd5ftS
         lKqY/fRAR4gw/Uem4tS7s0GI044ONokYFjO4UOFa+ZmczHgONDAuNy+PZumIEIanW7rs
         QBZEqwi2s00ATOGOOaN/CZPckz0qi433jsBtZ80v0mWZi5xyxqNZ9Z8i8tMeRwP+pNcM
         qoNQFQ1Aqb79xGbigp6ivRZsB6HT8Hw7V5qOoJ751F0WU4clW3fABAod8lNXuPECpKii
         gDBg==
X-Gm-Message-State: AOJu0YyZXRbvbleQFPDDk8QRTRdmSOrXCdqHWgbuXOkC4C7lV4WPHkYf
        Xi9rVv/21VcTPXaU3tuE0OU=
X-Google-Smtp-Source: AGHT+IGyHrILRPaV9pJ2zQgJeEVuZslG3NO98MRbEvq/YyXB/RrkwS0N6dvP/s2RWOZgLB2ubbRn0Q==
X-Received: by 2002:a2e:a60b:0:b0:2bf:f90e:2794 with SMTP id v11-20020a2ea60b000000b002bff90e2794mr2545427ljp.23.1695238106225;
        Wed, 20 Sep 2023 12:28:26 -0700 (PDT)
Received: from localhost ([178.176.85.138])
        by smtp.gmail.com with ESMTPSA id d19-20020a2eb053000000b002b9ec22d9fasm1105300ljl.29.2023.09.20.12.28.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 12:28:25 -0700 (PDT)
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Michal Simek <michal.simek@amd.com>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Borislav Petkov <bp@alien8.de>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Punnaiah Choudary Kalluri 
        <punnaiah.choudary.kalluri@xilinx.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 03/18] EDAC/synopsys: Extend memtypes supported by controller
Date:   Wed, 20 Sep 2023 22:26:48 +0300
Message-ID: <20230920192806.29960-4-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230920192806.29960-1-fancer.lancer@gmail.com>
References: <20230920192806.29960-1-fancer.lancer@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In accordance with [1] the DW uMCTL2 DDR controllers can support the next
DDR protocols: LPDDR, (LP)DDR(2|3|4). Even if the controller is configured
to support several of these memory chip types only one of these modes
could be enabled at runtime [2].

Taking all of that into account update the snps_get_mtype() procedure so
the DW uMCTL2 DDRC driver would be able to detect all the claimed to be
supported memory types in accordance with the table defined in [2]. Note
alas it's not possible do determine which MEMC DDR configs were enabled at
the IP-core synthesize. Therefore there is no other choice but to
initialize the EDAC MC mem-types capability field with all the types
claimed to be supported by the IP-core.

[1] DesignWare® Cores Enhanced Universal DDR Memory Controller (uMCTL2)
Databook, Version 3.91a, October 2020, p.501
[2] DesignWare® Cores Enhanced Universal DDR Memory Controller (uMCTL2)
Databook, Version 3.91a, October 2020, p.501

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
---
 drivers/edac/synopsys_edac.c | 41 ++++++++++++++++++++++++------------
 1 file changed, 27 insertions(+), 14 deletions(-)

diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
index 10716f365c6f..e08e9f3c81cb 100644
--- a/drivers/edac/synopsys_edac.c
+++ b/drivers/edac/synopsys_edac.c
@@ -102,11 +102,14 @@
 #define DDR_MSTR_BUSWIDTH_16		2
 #define DDR_MSTR_BUSWIDTH_32		1
 #define DDR_MSTR_BUSWIDTH_64		0
+#define DDR_MSTR_MEM_MASK		GENMASK(5, 0)
 #define DDR_MSTR_MEM_LPDDR4		BIT(5)
 #define DDR_MSTR_MEM_DDR4		BIT(4)
 #define DDR_MSTR_MEM_LPDDR3		BIT(3)
-#define DDR_MSTR_MEM_DDR2		BIT(2)
+#define DDR_MSTR_MEM_LPDDR2		BIT(2)
+#define DDR_MSTR_MEM_LPDDR		BIT(1)
 #define DDR_MSTR_MEM_DDR3		BIT(0)
+#define DDR_MSTR_MEM_DDR2		0
 
 /* ECC CFG0 register definitions */
 #define ECC_CFG0_MODE_MASK		GENMASK(2, 0)
@@ -535,21 +538,29 @@ static u32 snps_get_memsize(void)
  */
 static enum mem_type snps_get_mtype(const void __iomem *base)
 {
-	enum mem_type mt;
-	u32 memtype;
+	u32 regval;
 
-	memtype = readl(base + DDR_MSTR_OFST);
+	regval = readl(base + DDR_MSTR_OFST);
+	regval = FIELD_GET(DDR_MSTR_MEM_MASK, regval);
 
-	if ((memtype & DDR_MSTR_MEM_DDR3) || (memtype & DDR_MSTR_MEM_LPDDR3))
-		mt = MEM_DDR3;
-	else if (memtype & DDR_MSTR_MEM_DDR2)
-		mt = MEM_RDDR2;
-	else if ((memtype & DDR_MSTR_MEM_LPDDR4) || (memtype & DDR_MSTR_MEM_DDR4))
-		mt = MEM_DDR4;
-	else
-		mt = MEM_EMPTY;
+	switch (regval) {
+	case DDR_MSTR_MEM_DDR2:
+		return MEM_DDR2;
+	case DDR_MSTR_MEM_DDR3:
+		return MEM_DDR3;
+	case DDR_MSTR_MEM_LPDDR:
+		return MEM_LPDDR;
+	case DDR_MSTR_MEM_LPDDR2:
+		return MEM_LPDDR2;
+	case DDR_MSTR_MEM_LPDDR3:
+		return MEM_LPDDR3;
+	case DDR_MSTR_MEM_DDR4:
+		return MEM_DDR4;
+	case DDR_MSTR_MEM_LPDDR4:
+		return MEM_LPDDR4;
+	}
 
-	return mt;
+	return MEM_RESERVED;
 }
 
 /**
@@ -597,7 +608,9 @@ static void snps_mc_init(struct mem_ctl_info *mci, struct platform_device *pdev)
 	platform_set_drvdata(pdev, mci);
 
 	/* Initialize controller capabilities and configuration */
-	mci->mtype_cap = MEM_FLAG_DDR3 | MEM_FLAG_DDR2;
+	mci->mtype_cap = MEM_FLAG_LPDDR | MEM_FLAG_DDR2 | MEM_FLAG_LPDDR2 |
+			 MEM_FLAG_DDR3 | MEM_FLAG_LPDDR3 |
+			 MEM_FLAG_DDR4 | MEM_FLAG_LPDDR4;
 	mci->edac_ctl_cap = EDAC_FLAG_NONE | EDAC_FLAG_SECDED;
 	mci->scrub_cap = SCRUB_FLAG_HW_SRC;
 	mci->scrub_mode = SCRUB_NONE;
-- 
2.41.0

