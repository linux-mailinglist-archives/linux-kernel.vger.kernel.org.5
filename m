Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67B697A8D62
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 21:59:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230252AbjITT7F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 15:59:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230245AbjITT6r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 15:58:47 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD6BA1A6;
        Wed, 20 Sep 2023 12:58:31 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-5041cc983f9so395558e87.3;
        Wed, 20 Sep 2023 12:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695239910; x=1695844710; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5gQNVrm7iIcbZwXELuXpCO4/Kc8sgd3nqGULmM7glBg=;
        b=Ci6+SbDwOE2ZU6hIgAJ48qiFD/STDWEHZKo8LWxMdYRLpYiRlLv11j2GE9s5TRwSig
         Abg6ebqON65fSTCBtRIpnoRO5g6iFeteuzZWOYDjLk8GMrojcq79muzbqu7FMPXVDFvf
         NxvgyVkz9bETjtL/nK9yYNYbt4WqByu3K/UWAmdIe1VqgSfJvCvvES87oSrMEA3r0Fsa
         WdTfDnpqX2cEZlbVDcLqdDAnTkPTEOKjzQoUXhQejc9qAmaXi4DSsYsPezkm60E6WPPm
         hTk16Bsw/KrYayRPRUTy34BWcCV1LXcx/ZrX7Jf+O55SreBiZt02oQXSuJT+8XzOZ5hC
         n6ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695239910; x=1695844710;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5gQNVrm7iIcbZwXELuXpCO4/Kc8sgd3nqGULmM7glBg=;
        b=YVFitUTQ/WkdSKotUnD4ncl0t2bTLeM8Csfxo/ci7i8r/tQdzIlRLNQH6kXSRaYJ4y
         odvpgJ49Q6sJKJILbsJwmiReEl+Nm6qSsk1m8jTj15WQrIWL66Vmxk8SaDm27JrrPNRN
         lPbq+mwtegUcKJSso4VM/EXtAXObi6oq2wDQIFzx8ID9FrG4Fcnp0BtfY6Ay8trAxYSP
         eJkNoWp4YD/oJzty4AptcjGNH6W7XUIP8WeQ/wKibC03i7oO7WMJj8SF4HREkGz6DvVR
         Jr6Y1xtQqlHSvm8lwIbjrnt8KB/D3ZUsuEqxgKeOPBfe93YJDnqrGJE9+2Cb77i13m/3
         UFxQ==
X-Gm-Message-State: AOJu0YzXJsqZDn+Hy+bF5i+q4mWbTDyTfOl7RJTY0jouS1jluZoiFDrN
        zzud6/AqTqnKT724FJGQGB0=
X-Google-Smtp-Source: AGHT+IFTZA+isPECDl01It/LKg4pFSJa6ZcL9RzJNGot72/yXPzDyakTQXl62QQorYr+n6ys1foImw==
X-Received: by 2002:ac2:4d08:0:b0:503:525:243b with SMTP id r8-20020ac24d08000000b005030525243bmr2663869lfi.58.1695239909866;
        Wed, 20 Sep 2023 12:58:29 -0700 (PDT)
Received: from localhost ([83.149.21.189])
        by smtp.gmail.com with ESMTPSA id d8-20020ac244c8000000b005033891f3c0sm568023lfm.246.2023.09.20.12.58.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 12:58:29 -0700 (PDT)
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
Subject: [PATCH v4 13/13] EDAC/synopsys: Add BT1 DDRC support
Date:   Wed, 20 Sep 2023 22:56:44 +0300
Message-ID: <20230920195720.32047-14-fancer.lancer@gmail.com>
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

Baikal-T1 SoC is equipped with the DW uMCTl2 DDRC v2.61a with 32-bit
DQ-bus accepting DDR2/DDR3 SDRAMs of up to 2 ranks, 1:2 HIF/SDRAM clocks
rate ratio, HIF interface burst length of 8 Full DQ-bus words, 40-bit
System/Application address width and 128-bits data width, 3 System address
regions with block size 256MB. There is SEC/DED ECC capability with Scrub
(RMW) and Scrubber features.

Since the Baikal-T1 DDR controller supports Sideband ECC add the
controller support to the DW uMCTL2 DDRC EDAC driver. The most of the
parameters listed above will be autodetected except HIF burst length and
SAR block size, which will be set by means of the Baikal-T1-specific
initialization method. The controller compatible string "baikal,bt1-ddrc"
will be used to attach the driver to the kernel device. It's chosen in
accordance with the just updated DT-bindings.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>

---

Changelog v4:
- Explicitly set snps_ddrc_info.dq_width for Baikal-T1 DDRC for better
  maintainability.
- Explicitly set sys_app_map.minsize to SZ_256M instead of using a helper
  macro DDR_MIN_SARSIZE.
---
 drivers/edac/synopsys_edac.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
index e589aa9f7876..04cde79eb3f6 100644
--- a/drivers/edac/synopsys_edac.c
+++ b/drivers/edac/synopsys_edac.c
@@ -1349,6 +1349,21 @@ static int zynqmp_init_plat(struct snps_edac_priv *priv)
 	return 0;
 }
 
+/*
+ * bt1_init_plat - Baikal-T1-specific platform initialization.
+ * @priv:	DDR memory controller private data.
+ *
+ * Return: always zero.
+ */
+static int bt1_init_plat(struct snps_edac_priv *priv)
+{
+	priv->info.dq_width = SNPS_DQ_32;
+	priv->info.hif_burst_len = SNPS_DDR_BL8;
+	priv->sys_app_map.minsize = SZ_256M;
+
+	return 0;
+}
+
 /**
  * snps_get_dtype - Return the controller memory width.
  * @mstr:	Master CSR value.
@@ -2476,6 +2491,7 @@ static int snps_mc_remove(struct platform_device *pdev)
 
 static const struct of_device_id snps_edac_match[] = {
 	{ .compatible = "xlnx,zynqmp-ddrc-2.40a", .data = zynqmp_init_plat },
+	{ .compatible = "baikal,bt1-ddrc", .data = bt1_init_plat },
 	{ .compatible = "snps,ddrc-3.80a" },
 	{ }
 };
-- 
2.41.0

