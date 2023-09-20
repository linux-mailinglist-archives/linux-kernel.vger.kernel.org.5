Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EBFF7A8CDB
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 21:29:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbjITT32 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 15:29:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230101AbjITT3N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 15:29:13 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F1A218D;
        Wed, 20 Sep 2023 12:28:56 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-501eec0a373so408053e87.3;
        Wed, 20 Sep 2023 12:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695238134; x=1695842934; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dSPG6G1jeOItVuaHV8to9W/3RsF6DlFlBIE3fQ0A7VI=;
        b=H4PdOimijOaI+icFx7NG9ZN9vofW2NsMBKtBngapQkEwvJnFqvgCI2heBWXmap7p6b
         uw4wZHZ4YHpHGXUAAt9t9qm9WZI44nwh7qraIuT0ddtpfNTshjFAOq3Z9MxNhQAJTfjo
         2XbGHsnnC2T18fnJLZriIiqvmt2icrDN1kwT2Svk0U2q/sAkn5LTg45V4CKU3ozm6c5F
         8+w1DfOOC1HGpuDDnGbRu6X7BF3fOJ+xAzPLMSVl6R+QlCFHY4LqyB9nbdOKAHEz8YzU
         3mdmiaaiU5gAjgFbYN991lcb4AvOedZheXFC7cRiQQUDxAKjV+k7BHlWLcQj5/2VyNEp
         e10A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695238134; x=1695842934;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dSPG6G1jeOItVuaHV8to9W/3RsF6DlFlBIE3fQ0A7VI=;
        b=h8Y3n4WRGwj/u1EHSaSVV9S1D1180nSPq7d3aM53vI8k1oWY+z7x5Ypgpo1XJIDV37
         NmmiJ3NxpELyySK0I9TRzAjdhOO2yYZwGkytgMjw6jTFEv9147QJhjcgH3lHnN2s/vAx
         jxfVIUZQ4j791XakBw/Hxs9d7tYQVl+yjB3RdHILWxbh36z2kkr0nVMlUWIcdrmXTB8W
         NSmZbiDuhBvqpUubV3m8vjrBxZRgICfLo0nTPz7q7GREJMGAbwkSwxH5NSiIYkWxTQh7
         nTmARxTSASDmyHM7sPITYn5gac9RICHyGPtOo9COK6ELqLwQegXoKy5EVrtcwKzxtK8B
         5rFg==
X-Gm-Message-State: AOJu0YxnlKVnDHzJvN5WBVfkOrWO9Eibnq4HOaK3D0O/Ejx20si1zepu
        Buin81DdV9VnI93EZHhN+f4=
X-Google-Smtp-Source: AGHT+IE4CKi5qzbdonKtH3syFc1QDsHYzWBoZm/gWrZLX2VxjB4N/bBbjITdQQHzwGC8uuJ42MoYbQ==
X-Received: by 2002:a19:e04c:0:b0:4fd:fabf:b6ee with SMTP id g12-20020a19e04c000000b004fdfabfb6eemr2561415lfj.9.1695238133794;
        Wed, 20 Sep 2023 12:28:53 -0700 (PDT)
Received: from localhost ([85.140.6.11])
        by smtp.gmail.com with ESMTPSA id eo25-20020a056512481900b00500b3157ec8sm2790111lfb.163.2023.09.20.12.28.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 12:28:53 -0700 (PDT)
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
Subject: [PATCH v4 10/18] EDAC/synopsys: Get corrected bit position
Date:   Wed, 20 Sep 2023 22:26:55 +0300
Message-ID: <20230920192806.29960-11-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230920192806.29960-1-fancer.lancer@gmail.com>
References: <20230920192806.29960-1-fancer.lancer@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the DQ-bus width is now available in the driver it can be utilized
to calculate the exact bit-position corrected by the ECC engine for any
Synopsys memory controller setup. A corrected error syndrome is exposed by
the ECCSTAT.corrected_bit_num field. A particular erroneous bit position
is described in the lookup table [1] which also contains a dependency
between the field value and the DQ-bus widths. The syndrome values table
basically represents a standard lookup table for the Hamming
(64,8)/(32,7)/(16,6) codes (the error-correcting bits placed at the
power-of-two positions) except that the zero value means error in the
ecc[0] bit.

So using the offsets from that table introduce a new inline method
snps_get_bitpos() which would provide the actual CE bit-position. The
method will be called if a corrected error is detected.

[1] DesignWare® Cores Enhanced Universal DDR Memory Controller (uMCTL2)
    Databook, Version 3.91a, October 2020, p.426-427

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
---
 drivers/edac/synopsys_edac.c | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
index e10778cead63..e08cb30b7a7d 100644
--- a/drivers/edac/synopsys_edac.c
+++ b/drivers/edac/synopsys_edac.c
@@ -10,6 +10,7 @@
 #include <linux/bits.h>
 #include <linux/edac.h>
 #include <linux/fs.h>
+#include <linux/log2.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/seq_file.h>
@@ -301,6 +302,7 @@ struct snps_ddrc_info {
  * @col:	Column number.
  * @bank:	Bank number.
  * @bankgrp:	Bank group number.
+ * @syndrome:	Error syndrome.
  * @bitpos:	Bit position.
  * @data:	Data causing the error.
  */
@@ -309,6 +311,7 @@ struct snps_ecc_error_info {
 	u32 col;
 	u32 bank;
 	u32 bankgrp;
+	u32 syndrome;
 	u32 bitpos;
 	u32 data;
 };
@@ -359,6 +362,27 @@ struct snps_edac_priv {
 #endif
 };
 
+/**
+ * snps_get_bitpos - Get DQ-bus corrected bit position.
+ * @syndrome:	Error syndrome.
+ * @dq_width:	Controller DQ-bus width.
+ *
+ * Return: actual corrected DQ-bus bit position starting from 0.
+ */
+static inline u32 snps_get_bitpos(u32 syndrome, enum snps_dq_width dq_width)
+{
+	/* ecc[0] bit */
+	if (syndrome == 0)
+		return BITS_PER_BYTE << dq_width;
+
+	/* ecc[1:x] bit */
+	if (is_power_of_2(syndrome))
+		return (BITS_PER_BYTE << dq_width) + ilog2(syndrome) + 1;
+
+	/* data[0:y] bit */
+	return syndrome - ilog2(syndrome) - 2;
+}
+
 /**
  * snps_get_error_info - Get the current ECC error info.
  * @priv:	DDR memory controller private instance data.
@@ -379,7 +403,7 @@ static int snps_get_error_info(struct snps_edac_priv *priv)
 	if (!regval)
 		return 1;
 
-	p->ceinfo.bitpos = FIELD_GET(ECC_STAT_BITNUM_MASK, regval);
+	p->ceinfo.syndrome = FIELD_GET(ECC_STAT_BITNUM_MASK, regval);
 
 	regval = readl(base + ECC_ERRCNT_OFST);
 	p->ce_cnt = FIELD_GET(ECC_ERRCNT_CECNT_MASK, regval);
@@ -387,6 +411,8 @@ static int snps_get_error_info(struct snps_edac_priv *priv)
 	if (!p->ce_cnt)
 		goto ue_err;
 
+	p->ceinfo.bitpos = snps_get_bitpos(p->ceinfo.syndrome, priv->info.dq_width);
+
 	regval = readl(base + ECC_CEADDR0_OFST);
 	p->ceinfo.row = FIELD_GET(ECC_CEADDR0_ROW_MASK, regval);
 
-- 
2.41.0

