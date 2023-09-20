Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40B307A8C50
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 21:11:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbjITTLi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 15:11:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbjITTLa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 15:11:30 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E9F0C2;
        Wed, 20 Sep 2023 12:11:24 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2c129cb7770so1099631fa.1;
        Wed, 20 Sep 2023 12:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695237082; x=1695841882; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SOzZD92zaXAANSSJuQi8lUO8jcRVO2h2VCNQ1+CPjLg=;
        b=aVEXoDtskz2UKfXKOn7Jf8V8CjiHa10tc31BO95awIAzzhlhbQ1AxGoFUYiE9gUfOp
         6h2fhnl3oLdVH4MHAymb1i0603gJqoZwiSUF3eG25rYbBHCtx2YsEVuYmaMISPmdi4nT
         XgyLkNPcHgE1lvbdyM+l2JgYk1fSVK5bDHmldk3CZk802sX11676wQUc/eXDAOBmYKDg
         2vPuQqmtQi4RulNF6isMs3vUE7ozRxW6J6n9Ct60nP3WVHGeuIhXTfSmJk7QTzSgv23A
         +9ovkwh/ZIDzKrPYhkRXsaXgCXTNgcsLqJ1VwhrFKsOvwo4uey4vDkHzcSAysb+7Sc1X
         kdfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695237082; x=1695841882;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SOzZD92zaXAANSSJuQi8lUO8jcRVO2h2VCNQ1+CPjLg=;
        b=qczS6yegyvJgIXe17YlyE0Dn96Qflj9tmnB1bL9pjhgV+KoRQmulHlQTBFDY8F+Ah0
         AXAdnrJehHcHkrjAF+81XJGgHj1yhO/JG2+iya3xWMrzQ+SykU/04rC5wA/0KKn+j/0+
         Qu6CqAsdfRFI4lkxtOMtbNvtecZ0D2uOw5m6nU7vxJHLXRzzFYeZIw5bY3YNm+NXMGH6
         p6P/M37JER0zuPQwE4S6aK0HMkfMDQ3Dfwd03qsSpZWfD59o7V9q2C/xjEG4nW/c4+Fd
         JdCdZc4oQYF8zyA6XW9ddR5EXITBN3nb1SRlzoZygAEg1liqkTC5ogu4278AYPxzZzXn
         /cVA==
X-Gm-Message-State: AOJu0Yw+02sXWFBZIL4WZw93z48DmZR1mXZGfC/jCXO9t8ndJYnxkHGC
        myTvetRPbR0XkG4Iizqk3Jw=
X-Google-Smtp-Source: AGHT+IGoZ96V+G1d/YUQj+Y5RWTQKPaREb6RoceSVpNeh+joRF/L+Ofo/NpGOHNhubiVImEchz2i+w==
X-Received: by 2002:a2e:90d5:0:b0:2bf:f861:f523 with SMTP id o21-20020a2e90d5000000b002bff861f523mr1361029ljg.4.1695237082187;
        Wed, 20 Sep 2023 12:11:22 -0700 (PDT)
Received: from localhost ([83.149.21.16])
        by smtp.gmail.com with ESMTPSA id a14-20020a2ebe8e000000b002bffb3f8cebsm1996479ljr.54.2023.09.20.12.11.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 12:11:21 -0700 (PDT)
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Michal Simek <michal.simek@amd.com>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Borislav Petkov <bp@alien8.de>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>,
        Manish Narani <manish.narani@xilinx.com>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Punnaiah Choudary Kalluri 
        <punnaiah.choudary.kalluri@xilinx.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, Borislav Petkov <bp@suse.de>
Subject: [PATCH v4 02/20] EDAC/synopsys: Fix generic device type detection procedure
Date:   Wed, 20 Sep 2023 22:10:26 +0300
Message-ID: <20230920191059.28395-3-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230920191059.28395-1-fancer.lancer@gmail.com>
References: <20230920191059.28395-1-fancer.lancer@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

First of all the enum dev_type constants describe the memory DRAM chips
used at the stick, not the entire DQ-bus width (see the enumeration kdoc
for details). So what is returned from the zynqmp_get_dtype() function and
then specified to the dimm_info->dtype field is definitely incorrect.
Secondly the DRAM chips type has nothing to do with the data bus width
specified in the MSTR.data_bus_width CSR field. That CSR field just
determines the part of the whole DQ-bus currently used to access the data
from the all DRAM memory chips. So it doesn't indicate the individual
chips type. Thirdly the DRAM chips type can be determined only in case of
the DDR4 protocol by means of the MSTR.device_config field state (it is
supposed to be set by the system firmware). Finally the DW uMCTL2 DDRC ECC
capability doesn't depend on the memory chips type. Moreover it doesn't
depend on the utilized data bus width in runtime either. The IP-core
reference manual says in [1,2] that the ECC support can't be enabled
during the IP-core synthesizes for the DRAM data bus widths other than 16,
32 or 64.  At the same time the bus width mode (MSTR.data_bus_width)
doesn't change the ECC feature availability. Thus it was wrong to
determine the ECC state with respect to the DQ-bus width mode.

Fix all of the mistakes described above in the zynqmp_get_dtype() and
zynqmp_get_ecc_state() methods: specify actual DRAM chips data width only
for the DDR4 protocol and return that it's UNKNOWN in the rest of the
cases; determine ECC availability by the ECCCFG0.ecc_mode field state
only (that field can't be modified anyway if the IP-core was synthesized
with no ECC support).

[1] DesignWare® Cores Enhanced Universal DDR Memory Controller (uMCTL2)
Databook, Version 3.91a, October 2020, p. 421.
[2] DesignWare® Cores Enhanced Universal DDR Memory Controller (uMCTL2)
Databook, Version 3.91a, October 2020, p. 633.

Fixes: b500b4a029d5 ("EDAC, synopsys: Add ECC support for ZynqMP DDR controller")
Signed-off-by: Serge Semin <fancer.lancer@gmail.com>

---

Changelog v2:
- Include "linux/bitfield.h" header file to get the FIELD_GET macro
  definition. (@tbot)
---
 drivers/edac/synopsys_edac.c | 49 +++++++++++++++---------------------
 1 file changed, 20 insertions(+), 29 deletions(-)

diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
index 014a2176c2c1..b463bd802961 100644
--- a/drivers/edac/synopsys_edac.c
+++ b/drivers/edac/synopsys_edac.c
@@ -675,26 +675,25 @@ static enum dev_type zynq_get_dtype(const void __iomem *base)
  */
 static enum dev_type zynqmp_get_dtype(const void __iomem *base)
 {
-	enum dev_type dt;
-	u32 width;
-
-	width = readl(base + CTRL_OFST);
-	width = (width & ECC_CTRL_BUSWIDTH_MASK) >> ECC_CTRL_BUSWIDTH_SHIFT;
-	switch (width) {
-	case DDRCTL_EWDTH_16:
-		dt = DEV_X2;
-		break;
-	case DDRCTL_EWDTH_32:
-		dt = DEV_X4;
-		break;
-	case DDRCTL_EWDTH_64:
-		dt = DEV_X8;
-		break;
-	default:
-		dt = DEV_UNKNOWN;
+	u32 regval;
+
+	regval = readl(base + CTRL_OFST);
+	if (!(regval & MEM_TYPE_DDR4))
+		return DEV_UNKNOWN;
+
+	regval = (regval & DDRC_MSTR_CFG_MASK) >> DDRC_MSTR_CFG_SHIFT;
+	switch (regval) {
+	case DDRC_MSTR_CFG_X4_MASK:
+		return DEV_X4;
+	case DDRC_MSTR_CFG_X8_MASK:
+		return DEV_X8;
+	case DDRC_MSTR_CFG_X16_MASK:
+		return DEV_X16;
+	case DDRC_MSTR_CFG_X32_MASK:
+		return DEV_X32;
 	}
 
-	return dt;
+	return DEV_UNKNOWN;
 }
 
 /**
@@ -731,19 +730,11 @@ static bool zynq_get_ecc_state(void __iomem *base)
  */
 static bool zynqmp_get_ecc_state(void __iomem *base)
 {
-	enum dev_type dt;
-	u32 ecctype;
+	u32 regval;
 
-	dt = zynqmp_get_dtype(base);
-	if (dt == DEV_UNKNOWN)
-		return false;
+	regval = readl(base + ECC_CFG0_OFST) & SCRUB_MODE_MASK;
 
-	ecctype = readl(base + ECC_CFG0_OFST) & SCRUB_MODE_MASK;
-	if ((ecctype == SCRUB_MODE_SECDED) &&
-	    ((dt == DEV_X2) || (dt == DEV_X4) || (dt == DEV_X8)))
-		return true;
-
-	return false;
+	return (regval == SCRUB_MODE_SECDED);
 }
 
 /**
-- 
2.41.0

