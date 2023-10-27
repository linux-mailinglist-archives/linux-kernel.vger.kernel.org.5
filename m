Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 363D47D8D48
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 04:57:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345190AbjJ0C5A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 22:57:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjJ0C46 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 22:56:58 -0400
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A130129;
        Thu, 26 Oct 2023 19:56:56 -0700 (PDT)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-1e9d3cc6e7aso997529fac.2;
        Thu, 26 Oct 2023 19:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698375415; x=1698980215; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LDZeSNoT/F6uceX8xPaWwPCrqzVzl/F9opDYqP7fPJg=;
        b=lv46pZwIs5MU/Tq1hR90liS7lPOwKAK2cOWtOdt82RlyRayp7exQ/o/lc/+5WfPbdb
         CJ0LOQkWYn6MuFUFL+NkchQ11aNU+M7fatURhkqV/cKArQqI08I7FcKvceJplnu6Ow6H
         bK7RaGk/iJG34AadzYHSkNeCKUxLaVV/0uoZvFHCKGaH+ch8f+J+WmWCaKW7jo1O6z9y
         hlGzIxb8560vsmnakGF/G/0L14/1Eu4E+UY1HEFuyDW3z/pOsO3gt0+v7La7aN9iOnL4
         5FxI5GjRLYJM9DsgSb7LWzQOr0cSMNPjJakeKdgfNAh7W2MtI8oOgsc0KKXClTRPDhKo
         zQNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698375415; x=1698980215;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LDZeSNoT/F6uceX8xPaWwPCrqzVzl/F9opDYqP7fPJg=;
        b=Bk+x7hGLMkyVNg6yv7lG3CCBF4ddIGpGEiRF5ehprOBXtRToCIoTuV02WVw0N8iQPt
         Tpx28dWcjr20DelOmi92Ub3G70UkkMywgi7IGv7ZRL6ZQodF2cqzSXdtQmIg1hIrUWLf
         Oq/DhtY7yNuj990yPyfVrFBH5IYtAq23Jrgap+2foVwGPuh10xXbkkkQlXohwACfR3Hw
         ZUtttWEAQ26lNLLvvlg9gUcZ6TZF0q88j2eFgng92fmdip9DvVSzhl3eeP4azdHbVzh+
         MISuZGbvlqBrygZivPpm4G/TomJGuvMFIyfTg285M1r+cwKRJXlBHqyZP+30XflR35KI
         E3Aw==
X-Gm-Message-State: AOJu0YyhjPS0Ji5NdZeUl+B0osVDyu24VvyRcyX3Ptqr3jqdSXO3N7n9
        UefFOYM3rM2kS4M91fK+UKSLkQR8cw0=
X-Google-Smtp-Source: AGHT+IGAnGmIB1mQEhtj+QsEa41nDsx78wO2RvvhhYj+HlCbTyldwYFUDGN/YyeLNRYe598RQaKFmw==
X-Received: by 2002:a05:6871:4188:b0:1e9:e063:ca6b with SMTP id lc8-20020a056871418800b001e9e063ca6bmr2108233oab.32.1698375414687;
        Thu, 26 Oct 2023 19:56:54 -0700 (PDT)
Received: from localhost.localdomain ([74.48.130.204])
        by smtp.googlemail.com with ESMTPSA id z127-20020a633385000000b005b82611378bsm275339pgz.52.2023.10.26.19.56.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 19:56:54 -0700 (PDT)
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
        Jacob Keller <jacob.e.keller@intel.com>
Cc:     netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        xfr@outlook.com, rock.xu@nio.com, Furong Xu <0x1207@gmail.com>
Subject: [PATCH net] net: stmmac: xgmac: Fix support for multiple Flexible PPS outputs
Date:   Fri, 27 Oct 2023 10:56:03 +0800
Message-Id: <20231027025603.1035668-1-0x1207@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From XGMAC Core 3.20 and later, each Flexible PPS has individual PPSEN bit
to select Fixed mode or Flexible mode. The PPSEN must be set, or it stays
in Fixed PPS mode by default.
XGMAC Core prior 3.20, corresponding PPSEN bits are read-only reserved,
always set PPSEN do not make things worse ;)

Fixes: 95eaf3cd0a90 ("net: stmmac: dwxgmac: Add Flexible PPS support")
Signed-off-by: Furong Xu <0x1207@gmail.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h      | 2 +-
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

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
index f352be269deb..53bb8f16c481 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
@@ -1178,7 +1178,7 @@ static int dwxgmac2_flex_pps_config(void __iomem *ioaddr, int index,
 
 	val |= XGMAC_PPSCMDx(index, XGMAC_PPSCMD_START);
 	val |= XGMAC_TRGTMODSELx(index, XGMAC_PPSCMD_START);
-	val |= XGMAC_PPSEN0;
+	val |= XGMAC_PPSENx(index);
 
 	writel(cfg->start.tv_sec, ioaddr + XGMAC_PPSx_TARGET_TIME_SEC(index));
 
-- 
2.34.1

