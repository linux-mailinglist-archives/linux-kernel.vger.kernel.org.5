Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABE2E7DC470
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 03:29:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233516AbjJaC2Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 22:28:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbjJaC2W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 22:28:22 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1521BE9;
        Mon, 30 Oct 2023 19:28:20 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id 46e09a7af769-6ce2fc858feso3005733a34.3;
        Mon, 30 Oct 2023 19:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698719299; x=1699324099; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mG+0u22Ez5LjKbUHwcGY134sP+y1ufdTeN3lJfckGbU=;
        b=czBNFodRM0nQ4TO0P28wvPfq09rY3khzh5xkaJ7iMJxfBg2VmVjvmi0Xnjp49wSp5X
         LkZXsR0Kc/J+Qvu3LwrK9y6JT46KMVamSLDZGrHE2d2RyyEFqnNroiNcl7R+tD4ex4KH
         OXsUGGHjGIRvdgG0oNYGEmuhrJdh3+aFOq8XqW7ndvjmbyiD8Db7t/stNxif5orbvea3
         Ct0iFq1NKcLurjF6GrYEEvlugfqVBxJoppFTXdakUi8pmXc2oUEaeNtiMRZl063ClhkS
         LgYb16xFED5X/bMmdISISVApfMQbmNZVYqAhsgmRxj/v+4KFeDleAcSbfATgOLVvV4LK
         UcDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698719299; x=1699324099;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mG+0u22Ez5LjKbUHwcGY134sP+y1ufdTeN3lJfckGbU=;
        b=GhECQgwZQujTi3MByur7jjNlHdKHbpFj3FLM/GXunxBQZvVdhD1uLV0/Tv3i3JSBl9
         lqfZsT+gKx6yOV/43H7SjlKPhdzzAMtcwwGLuj8MrDnsKVWYAJUgAsr5K4VhAIdM+v9M
         6L390XmUiUadSKXpczPY0Strfb4IDtsrwLYx2VADmbdXxkrF2ontYay4CNtz70L5LT+Y
         RpUNC4iHxusX4ItvmgOfIT2mJTevYHxd737HT0su5sRnPUXB9Qgx2mFb94wfXH5mqdT+
         bp2m9jTnUGMpwRskzosb8AM2XuwD6SHFcazlUjRIoW4mHDiu2cD++gd2ArSxrBO0MGRw
         2UKQ==
X-Gm-Message-State: AOJu0Yx8EFvaM8fh1dMoLeAQGA9lnohQMNpNgUYFeqHadSeP3qht/oqn
        R3gcHw3YvrfLSidkYwP7sx8=
X-Google-Smtp-Source: AGHT+IHMXqpHgXM+A1WEBm92w/REB6KgbFUhbItfXimyIXXQ0jypN6c3gADLq5Fd9BbKM7xnIBxl4A==
X-Received: by 2002:a05:6830:22c8:b0:6b8:7d12:423d with SMTP id q8-20020a05683022c800b006b87d12423dmr10440748otc.18.1698719299250;
        Mon, 30 Oct 2023 19:28:19 -0700 (PDT)
Received: from localhost.localdomain ([74.48.130.204])
        by smtp.googlemail.com with ESMTPSA id fa9-20020a056a002d0900b0068fece2c190sm178510pfb.70.2023.10.30.19.28.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 19:28:18 -0700 (PDT)
From:   Furong Xu <0x1207@gmail.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Joao Pinto <jpinto@synopsys.com>,
        Simon Horman <horms@kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Jacob Keller <jacob.e.keller@intel.com>
Cc:     netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        xfr@outlook.com, rock.xu@nio.com, Furong Xu <0x1207@gmail.com>
Subject: [PATCH net v3] net: stmmac: xgmac: Enable support for multiple Flexible PPS outputs
Date:   Tue, 31 Oct 2023 10:27:29 +0800
Message-Id: <20231031022729.2347871-1-0x1207@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From XGMAC Core 3.20 and later, each Flexible PPS has individual PPSEN bit
to select Fixed mode or Flexible mode. The PPSEN must be set, or it stays
in Fixed PPS mode by default.
XGMAC Core prior 3.20, only PPSEN0(bit 4) is writable. PPSEN{1,2,3} are
read-only reserved, and they are already in Flexible mode by default, our
new code always set PPSEN{1,2,3} do not make things worse ;-)

Fixes: 95eaf3cd0a90 ("net: stmmac: dwxgmac: Add Flexible PPS support")
Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Furong Xu <0x1207@gmail.com>
---
Changes in v3:
  - Tagged Fixes: and sent through net instead of net-next, thanks Jacob Keller.

Changes in v2:
  - Add comment for XGMAC_PPSEN description among different XGMAC core versions.
  - Update commit message, thanks Serge Semin.
---
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h     |  2 +-
 .../net/ethernet/stmicro/stmmac/dwxgmac2_core.c    | 14 +++++++++++++-
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
index 7a8f47e7b728..a4e8b498dea9 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
@@ -259,7 +259,7 @@
 	((val) << XGMAC_PPS_MINIDX(x))
 #define XGMAC_PPSCMD_START		0x2
 #define XGMAC_PPSCMD_STOP		0x5
-#define XGMAC_PPSEN0			BIT(4)
+#define XGMAC_PPSENx(x)			BIT(4 + (x) * 8)
 #define XGMAC_PPSx_TARGET_TIME_SEC(x)	(0x00000d80 + (x) * 0x10)
 #define XGMAC_PPSx_TARGET_TIME_NSEC(x)	(0x00000d84 + (x) * 0x10)
 #define XGMAC_TRGTBUSY0			BIT(31)
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
index f352be269deb..453e88b75be0 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
@@ -1178,7 +1178,19 @@ static int dwxgmac2_flex_pps_config(void __iomem *ioaddr, int index,
 
 	val |= XGMAC_PPSCMDx(index, XGMAC_PPSCMD_START);
 	val |= XGMAC_TRGTMODSELx(index, XGMAC_PPSCMD_START);
-	val |= XGMAC_PPSEN0;
+
+	/* XGMAC Core has 4 PPS outputs at most.
+	 *
+	 * Prior XGMAC Core 3.20, Fixed mode or Flexible mode are selectable for
+	 * PPS0 only via PPSEN0. PPS{1,2,3} are in Flexible mode by default,
+	 * and can not be switched to Fixed mode, since PPSEN{1,2,3} are
+	 * read-only reserved to 0.
+	 * But we always set PPSEN{1,2,3} do not make things worse ;-)
+	 *
+	 * From XGMAC Core 3.20 and later, PPSEN{0,1,2,3} are writable and must
+	 * be set, or the PPS outputs stay in Fixed PPS mode by default.
+	 */
+	val |= XGMAC_PPSENx(index);
 
 	writel(cfg->start.tv_sec, ioaddr + XGMAC_PPSx_TARGET_TIME_SEC(index));
 
-- 
2.34.1

