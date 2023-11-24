Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31DAB7F6A4D
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 02:56:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbjKXBzv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 20:55:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjKXBzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 20:55:49 -0500
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B7D0D7F;
        Thu, 23 Nov 2023 17:55:55 -0800 (PST)
Received: by mail-oi1-x22c.google.com with SMTP id 5614622812f47-3b52360cdf0so754784b6e.2;
        Thu, 23 Nov 2023 17:55:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700790954; x=1701395754; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LyxNW8uNH7iQptXLfUQU9KTeCyjsm7ymwbCx+5iTF1Y=;
        b=EBZq/bKG94aD7bf8bPErmQ81Q67mZXhKEh8OJmKpxICOZcyzM8xXGqvvaUzPQwq9w4
         zQbMXChTPldXZiwru6NkNK4KT8LR9i9wIv367u7zg9pBmpAqKvomwhpt1Ty0hVojTSlg
         p9CdDNSCBT+CygI7V4qe6gldRZW0PFNZ9oraoI2Hvkpf6TVA0VA6SfvZzMPbe/XGYamJ
         Xj01Z3Jkn+SElgf2Hnf/GV+5mkDgb9vaP9i/XiSH/YCxcKTiai1aktOdtz07Yj1Djp2q
         PVrv9ijrXCYDRAX3dGNec39AjzxGw19ybPNWvutcOu1ckImvMzACbdY+ilEMopDZzdsW
         2F4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700790954; x=1701395754;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LyxNW8uNH7iQptXLfUQU9KTeCyjsm7ymwbCx+5iTF1Y=;
        b=sdUIlyxGQ5XlaWdLkwDpBtBMtljHRE+4pdhTzri38PSsMMWA95cN932wYqgRiXycBx
         Bc1+cMGcveJ/mc5X8VQNHnTk0Ex2YnkoqWqk9MaFle8EChINQY47JZjeQ5gDKTtO7iMA
         TGipW6mBVFR0QhKTWhitWst0GA8378yN/nuVEhKrvbrpcu6pISxERCYJZi+A9GA+F45f
         ATEub0qH15M8AUYSDE95eLTmowvZcq1EqZ3BJ1JEwIW303bgKCwzoDmP+dTzhKEQ+jxb
         rhYCgq/7l0k1F0gr7GVF9IVJlUtltwo58zuOYjUc4ecPGZOhwWj7vQ31VKe1evCm8154
         AXLQ==
X-Gm-Message-State: AOJu0Yzy3hU9z9zaar0N2SzDbdbXsh0Vd2sN1t4X600ACM+F6gd3yjYu
        g+bAuLxr+/pGIZTBFB36UW4=
X-Google-Smtp-Source: AGHT+IGjt9vU6cD5V+1YXxif0d29i+KbMwSlR2P7yRUyPFecaEYgEXMOWyJrBq8DeHZsNSvmam5zUg==
X-Received: by 2002:a54:4587:0:b0:3a9:b9eb:998e with SMTP id z7-20020a544587000000b003a9b9eb998emr1166283oib.51.1700790954616;
        Thu, 23 Nov 2023 17:55:54 -0800 (PST)
Received: from localhost.localdomain ([74.48.130.204])
        by smtp.googlemail.com with ESMTPSA id 9-20020a631049000000b005c1ce3c960bsm1991128pgq.50.2023.11.23.17.55.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 17:55:54 -0800 (PST)
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
Subject: [PATCH net v2 1/1] net: stmmac: xgmac: Disable FPE MMC interrupts
Date:   Fri, 24 Nov 2023 09:54:33 +0800
Message-Id: <20231124015433.2223696-1-0x1207@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit aeb18dd07692 ("net: stmmac: xgmac: Disable MMC interrupts
by default") tries to disable MMC interrupts to avoid a storm of
unhandled interrupts, but leaves the FPE(Frame Preemption) MMC
interrupts enabled.
Now we mask FPE TX and RX interrupts to disable all MMC interrupts.

Fixes: aeb18dd07692 ("net: stmmac: xgmac: Disable MMC interrupts by default")
Signed-off-by: Furong Xu <0x1207@gmail.com>
---
Changes in v2:
  - Update commit message, thanks Wojciech and Andrew.
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

