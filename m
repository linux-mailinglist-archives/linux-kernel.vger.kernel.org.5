Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2290B7A8D53
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 21:58:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230295AbjITT62 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 15:58:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230228AbjITT6Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 15:58:24 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A177D8;
        Wed, 20 Sep 2023 12:58:11 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2c038a1e2e6so2728211fa.2;
        Wed, 20 Sep 2023 12:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695239889; x=1695844689; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mRfHOWyS91vzVwejPj0vpq+g8xJCLUmXQ16geMum0B4=;
        b=d8PBC+VNoV70VJbTh5RSlgjKcRX2RMVIuEYqQruHJKutQebt0zeU0uDEkrJRo6pq+C
         tDt/s3SlurGVHGBm9lV+v7XWevSd+HM91VmbFeviyhcL05jM5Lr+a4EnGZqbCN9bpIDa
         l6VT2T2ea8nrBoNgx5oc2fFJK5WDMTM7Jpar4gd3uBuMRtk0TjC4iXq+3PfKViqiZWiq
         LVcxTjTducWVNHnn/DpM0PN3MD0ZpxkFqlJpdYeDvl6odey5l9HBQZFmpXZljAI6+84t
         DJgEeu8qHIWAiSsLo3RwATZZpb15K5x3RE54OcFqG4dl+wqXYYokLY1W1voEqIzT3BDX
         UwEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695239889; x=1695844689;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mRfHOWyS91vzVwejPj0vpq+g8xJCLUmXQ16geMum0B4=;
        b=NNiJYuFIon8e14s1d239bf6AQ13KG8EQ3PQjQC5+vCOuw2W7OZWpLR1zo629/pp7HS
         lYdoYMqXH/aLAlEChfiRlUIUc48Use7vJ0anNeHoh2EirenC1s5vsLS26/Kc6bhxl5n7
         DgLN9H+mknU//MC8IZRNIWvS6SV4yv3MWnJfZxvhD7p6jDjKdpvpAI0R1UklIJ0RHvCD
         N6+Ol5kB6meJKwkYIRCQOOyIDapflGSED2ODO83E8SWctYzb/fyHFBWwGmVxRmvAudOk
         KL7Nozqo9jk1lHyQhvFxFryRoUaNKh+w03Svka/VhjFwWwBQZs5Ur8S/syzujrXF5Ozs
         o89w==
X-Gm-Message-State: AOJu0Yw8tR0M1ysTWkAupvEcYOHGsRI3MkzucLsveAvjxok9kwH46hV8
        L7YhgsqBUN2uAc8TwiNIE9Q=
X-Google-Smtp-Source: AGHT+IEhkeWO5iqHVcZbgwdbs2SL/BUg1QSfo+mbevfgbf8qk8U9vY+ktIQYS1YUrsCWQZJH8B2YQw==
X-Received: by 2002:a2e:96d5:0:b0:2bf:e9e8:de23 with SMTP id d21-20020a2e96d5000000b002bfe9e8de23mr3254452ljj.16.1695239889401;
        Wed, 20 Sep 2023 12:58:09 -0700 (PDT)
Received: from localhost ([83.149.21.16])
        by smtp.gmail.com with ESMTPSA id t15-20020a2e780f000000b002c02e57c72bsm821321ljc.140.2023.09.20.12.58.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 12:58:08 -0700 (PDT)
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Michal Simek <michal.simek@amd.com>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Borislav Petkov <bp@alien8.de>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Punnaiah Choudary Kalluri 
        <punnaiah.choudary.kalluri@xilinx.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 06/13] EDAC/synopsys: Add data poisoning disable support
Date:   Wed, 20 Sep 2023 22:56:37 +0300
Message-ID: <20230920195720.32047-7-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230920195720.32047-1-fancer.lancer@gmail.com>
References: <20230920195720.32047-1-fancer.lancer@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Even though being a pure-debug feature currently the data poison can't be
disabled once it has been initialized and enabled. Irrespective to the way
the feature has been implemented it doesn't seem right since the system
may print false ECC errors in case if the poisoned address is accessed by
the kernel or by the user-space applications. It's possible since the
poisoned address isn't reserved in any kernel mm subsystems. Even though
that doesn't seem right either at least it's tolerable since the ECC data
poison is supposed to be utilized in the framework of the EDAC driver
debugging, but having the feature non-switchable can't be justified that
easy especially seeing it's not that hard to implement.

So in order to have the ECC data poison switchable define three possible
values acceptable by the "inject_data_poison" DebugFS node:
1. "CE" - emit correctable error (as before).
2. "UE" - emit uncorrectable error (used to be any non-"CE" value).
3. Any other value - disable data poison feature.

Note the macros describing the data poison-related fields of the ECC_CFG0
register need to be redefined in a way so they would be used to separately
switch the feature on/off and to select the type of the ECC error. As a
result the suggest solution turns into a proper ECC_CFG0 CSRs fields setup
based on the value written to the "inject_data_poison" DebugFS node.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
---
 drivers/edac/synopsys_edac.c | 29 ++++++++++++++++++++---------
 1 file changed, 20 insertions(+), 9 deletions(-)

diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
index 90640b2f877a..3735c784fac9 100644
--- a/drivers/edac/synopsys_edac.c
+++ b/drivers/edac/synopsys_edac.c
@@ -123,6 +123,10 @@
 #define ECC_CFG0_DIS_SCRUB		BIT(4)
 #define ECC_CFG0_MODE_MASK		GENMASK(2, 0)
 
+/* ECC CFG1 register definitions */
+#define ECC_CFG1_POISON_BIT		BIT(1)
+#define ECC_CFG1_POISON_EN		BIT(0)
+
 /* ECC status register definitions */
 #define ECC_STAT_UE_MASK		GENMASK(23, 16)
 #define ECC_STAT_CE_MASK		GENMASK(15, 8)
@@ -154,10 +158,6 @@
 #define ECC_POISON1_BANK_MASK		GENMASK(26, 24)
 #define ECC_POISON1_ROW_MASK		GENMASK(17, 0)
 
-/* DDRC ECC CE & UE poison mask */
-#define ECC_CEPOISON_MASK		GENMASK(1, 0)
-#define ECC_UEPOISON_MASK		BIT(0)
-
 /* DDRC address mapping parameters */
 #define DDR_ADDRMAP_NREGS		12
 
@@ -1787,10 +1787,14 @@ static ssize_t snps_inject_data_poison_read(struct file *filep, char __user *ubu
 	int pos;
 
 	regval = readl(priv->baseaddr + ECC_CFG1_OFST);
-	errstr = FIELD_GET(ECC_CEPOISON_MASK, regval) == ECC_CEPOISON_MASK ?
-		 "Correctable Error" : "UnCorrectable Error";
+	if (!(regval & ECC_CFG1_POISON_EN))
+		errstr = "Off";
+	else if (regval & ECC_CFG1_POISON_BIT)
+		errstr = "CE";
+	else
+		errstr = "UE";
 
-	pos = scnprintf(buf, sizeof(buf), "Data Poisoning: %s\n\r", errstr);
+	pos = scnprintf(buf, sizeof(buf), "%s\n", errstr);
 
 	return simple_read_from_buffer(ubuf, size, offp, buf, pos);
 }
@@ -1801,6 +1805,7 @@ static ssize_t snps_inject_data_poison_write(struct file *filep, const char __us
 	struct mem_ctl_info *mci = filep->private_data;
 	struct snps_edac_priv *priv = mci->pvt_info;
 	char buf[SNPS_DBGFS_BUF_LEN];
+	u32 regval;
 	int rc;
 
 	rc = simple_write_to_buffer(buf, sizeof(buf), offp, ubuf, size);
@@ -1808,10 +1813,16 @@ static ssize_t snps_inject_data_poison_write(struct file *filep, const char __us
 		return rc;
 
 	writel(0, priv->baseaddr + DDR_SWCTL);
+
+	regval = readl(priv->baseaddr + ECC_CFG1_OFST);
 	if (strncmp(buf, "CE", 2) == 0)
-		writel(ECC_CEPOISON_MASK, priv->baseaddr + ECC_CFG1_OFST);
+		regval |= ECC_CFG1_POISON_BIT | ECC_CFG1_POISON_EN;
+	else if (strncmp(buf, "UE", 2) == 0)
+		regval = (regval & ~ECC_CFG1_POISON_BIT) | ECC_CFG1_POISON_EN;
 	else
-		writel(ECC_UEPOISON_MASK, priv->baseaddr + ECC_CFG1_OFST);
+		regval &= ~ECC_CFG1_POISON_EN;
+	writel(regval, priv->baseaddr + ECC_CFG1_OFST);
+
 	writel(1, priv->baseaddr + DDR_SWCTL);
 
 	return size;
-- 
2.41.0

