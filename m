Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 532CB7F5B1F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 10:36:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231922AbjKWJgP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 04:36:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjKWJgN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 04:36:13 -0500
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79C2B1AE;
        Thu, 23 Nov 2023 01:36:19 -0800 (PST)
Received: by mail-ot1-x329.google.com with SMTP id 46e09a7af769-6d64c1155a8so429762a34.2;
        Thu, 23 Nov 2023 01:36:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700732179; x=1701336979; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dQhHNIKfWiIWad6NjUl3O8AGhzuURYHnVhK+SmvQomg=;
        b=Urd7garV3JSeoh8vnLumPumoZFRb39usTX5jVzYuKhVXZlS0+aJHuQcUNROT8AQ8Ou
         Vfx6qgDEhgxnVpA+NeRuUDdAf6/pw7Q2JxIXeQ4fcJVoWKqYWpre3Vl91Y7VnBz9TlTK
         V7oJEGHIpQwS3Z1/t5BvtKCpLBdxgHCGs28VoWOpeXeuvRAQUwOXFXmHT1dgPkIXBlDf
         mjsg2IQV0nIwi99Jwerpn1+enI3wzh+HMVcviqhObyW4dCW+u8HY2+fvAz/Y+FSTrXy5
         q8QIPFUyEbIXDcA9VbCI20UhuEmN7ivQLD2kNEfA3O5eeIfW5+4RPeOGEJIsmExRm+25
         ui/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700732179; x=1701336979;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dQhHNIKfWiIWad6NjUl3O8AGhzuURYHnVhK+SmvQomg=;
        b=nV/wH5ITCGEQckMFPEkwnMRs9GX8etQgu7Igb+v/rU1pibHwYgO2lqT3ZcKoac4qzc
         dOABTQWj+DdAPEFGcpcMuqiS1pIzGgQ5g1ycJ88wf9fUO17QGC41PJMZ87OryDyN8XWp
         pvQ6i2/NI+/aBQQGPdZJ68FypW9ZuluHiopN8H9uw2AfN+q/VLcDcBGVE2oMWBFCGrjO
         Nzyh06JJvrLePamUqq31VTUbyevV4EZbB91bEsd/W0JZV+MLOgN98y0w6ny1dNxcuM3R
         nakoWY6set7xi4/CymFhCB3Xu/meCWj3XCIA540uLizEMPLpiCk1k+kmQZ+vOap/gxX6
         4SJg==
X-Gm-Message-State: AOJu0Yz9Iqit1gxWllkZkU8PyYtp4db+z2c7urR37OTrj96a3cYAJN2c
        m2HpAEfYpCoWnpAcljUKrOU=
X-Google-Smtp-Source: AGHT+IEpKb2YEB93s5BEDe/ctdnNVWLRYV7AcKyFu0sGdgnl4YodP6t5BrbO/0iA6SuVCzPswe8etA==
X-Received: by 2002:a9d:6857:0:b0:6d6:4b8b:baf1 with SMTP id c23-20020a9d6857000000b006d64b8bbaf1mr5427820oto.23.1700732178744;
        Thu, 23 Nov 2023 01:36:18 -0800 (PST)
Received: from localhost.localdomain ([74.48.130.204])
        by smtp.googlemail.com with ESMTPSA id o13-20020a635a0d000000b005a9b20408a7sm922970pgb.23.2023.11.23.01.36.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 01:36:18 -0800 (PST)
From:   Furong Xu <0x1207@gmail.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Joao Pinto <jpinto@synopsys.com>,
        Simon Horman <horms@kernel.org>
Cc:     netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        xfr@outlook.com, rock.xu@nio.com, Furong Xu <0x1207@gmail.com>
Subject: [PATCH net v1] net: stmmac: xgmac: Disable FPE MMC interrupts
Date:   Thu, 23 Nov 2023 17:35:38 +0800
Message-Id: <20231123093538.2216633-1-0x1207@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit aeb18dd07692 ("net: stmmac: xgmac: Disable MMC interrupts
by default") leaves the FPE(Frame Preemption) MMC interrupts enabled.
Now we disable FPE TX and RX interrupts too.

Fixes: aeb18dd07692 ("net: stmmac: xgmac: Disable MMC interrupts by default")
Signed-off-by: Furong Xu <0x1207@gmail.com>
---
 drivers/net/ethernet/stmicro/stmmac/mmc_core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/mmc_core.c b/drivers/net/ethernet/stmicro/stmmac/mmc_core.c
index ea4910ae0921..cdd7fbde2bfa 100644
--- a/drivers/net/ethernet/stmicro/stmmac/mmc_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/mmc_core.c
@@ -177,8 +177,10 @@
 #define MMC_XGMAC_RX_DISCARD_OCT_GB	0x1b4
 #define MMC_XGMAC_RX_ALIGN_ERR_PKT	0x1bc
 
+#define MMC_XGMAC_FPE_TX_INTR_MASK	0x204
 #define MMC_XGMAC_TX_FPE_FRAG		0x208
 #define MMC_XGMAC_TX_HOLD_REQ		0x20c
+#define MMC_XGMAC_FPE_RX_INTR_MASK	0x224
 #define MMC_XGMAC_RX_PKT_ASSEMBLY_ERR	0x228
 #define MMC_XGMAC_RX_PKT_SMD_ERR	0x22c
 #define MMC_XGMAC_RX_PKT_ASSEMBLY_OK	0x230
@@ -352,6 +354,8 @@ static void dwxgmac_mmc_intr_all_mask(void __iomem *mmcaddr)
 {
 	writel(0x0, mmcaddr + MMC_RX_INTR_MASK);
 	writel(0x0, mmcaddr + MMC_TX_INTR_MASK);
+	writel(MMC_DEFAULT_MASK, mmcaddr + MMC_XGMAC_FPE_TX_INTR_MASK);
+	writel(MMC_DEFAULT_MASK, mmcaddr + MMC_XGMAC_FPE_RX_INTR_MASK);
 	writel(MMC_DEFAULT_MASK, mmcaddr + MMC_XGMAC_RX_IPC_INTR_MASK);
 }
 
-- 
2.34.1

