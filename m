Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E52F77F888D
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 07:03:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229584AbjKYGCP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 01:02:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjKYGCN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 01:02:13 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE084170B;
        Fri, 24 Nov 2023 22:02:19 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1ce3084c2d1so20589835ad.3;
        Fri, 24 Nov 2023 22:02:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700892139; x=1701496939; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FclhQf3qesEshzQHC5UsLSEyaxrJX7Yi4QUTwlsrBzo=;
        b=SvFpBoa47fRi2Geddtva6RFAc4RXcc1IV0EhDx4gsyJQHdqDBifQD8OxahCSiWySGY
         PWJD8WG6iUxC7NooIDXVZv4G1oR/RjG1vCoqLiKRTthM68wwQmnO16B9XuvJs6MtLK1c
         oe7z54rfeMnk5nCllOhxJncpindbAx4LbTI/zA+j3/2+tXto7WNQMBx2K43+aWD6OvTH
         w6oxqherCJqJBtxreDqkzdEde52sUvF9SRvW0XkJVjKzjr73zXOn+aHfxONptMfJqG9F
         bJf8J2HYN2MCOHWhIcSgSwyZkL4BdgqmL0J9TxwoWZJ8Bqofbr2jnuzPqd2LVeTeBL2o
         l7xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700892139; x=1701496939;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FclhQf3qesEshzQHC5UsLSEyaxrJX7Yi4QUTwlsrBzo=;
        b=q2jRqWhGCWHcBw/Yl4k/DjCozLZw0st6P07wSrA/rz7ajbagQOhuiC6dhNnY2drwpo
         g+WCQGUM/+kDR6iwj0eFUKsAZw6zDa8WSf+6WjZ6qDFa8yjD0x4E63Q7pQ48qbJE4IxX
         n16YyloMXsq7VPZGKJPg1VX4B3jjwmLoVhYS8/+FfmihlB+ZLs1sfGgoFCoVLuInIAnF
         8osFsxfe3TVzABmtCxYAnYcwkirkxkT3agDDT5O06QRSJnCLjsJWkZqWAaTThZNm91Xa
         UN2/RJBDnFgPiU+PzkjH5yNf062rPPStw7zqD63rcJp5a+vMEhyj6QSvCCeJLawp9Z5Z
         Xkmg==
X-Gm-Message-State: AOJu0YxGGVmqhL5IXhszWWnNbGPxsCDLIfDRW4C/PNEIDNoPGYUt2aqf
        HS2AqhkfLPfozJTpFPZ78mM=
X-Google-Smtp-Source: AGHT+IEyIZv6kPKcJuJsdF5mkhJzsr0Y/Z/jY64tcTkX225IcRn/vjh+aCjOupIC+C0YVipqna0Edg==
X-Received: by 2002:a17:903:2596:b0:1cf:9d88:a0ef with SMTP id jb22-20020a170903259600b001cf9d88a0efmr4177631plb.59.1700892139281;
        Fri, 24 Nov 2023 22:02:19 -0800 (PST)
Received: from localhost.localdomain ([74.48.130.204])
        by smtp.googlemail.com with ESMTPSA id h11-20020a170902f7cb00b001c9c97beb9csm4142059plw.71.2023.11.24.22.02.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 22:02:18 -0800 (PST)
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
        xfr@outlook.com, rock.xu@nio.com, Furong Xu <0x1207@gmail.com>,
        Larysa Zaremba <larysa.zaremba@intel.com>
Subject: [PATCH net v3] net: stmmac: xgmac: Disable FPE MMC interrupts
Date:   Sat, 25 Nov 2023 14:01:26 +0800
Message-Id: <20231125060126.2328690-1-0x1207@gmail.com>
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
by default") tries to disable MMC interrupts to avoid a storm of
unhandled interrupts, but leaves the FPE(Frame Preemption) MMC
interrupts enabled, FPE MMC interrupts can cause the same problem.
Now we mask FPE TX and RX interrupts to disable all MMC interrupts.

Fixes: aeb18dd07692 ("net: stmmac: xgmac: Disable MMC interrupts by default")
Reviewed-by: Larysa Zaremba <larysa.zaremba@intel.com>
Signed-off-by: Furong Xu <0x1207@gmail.com>
---
Changes in v3:
  - Update commit message, thanks Larysa.
  - Rename register defines, thanks Serge.

Changes in v2:
  - Update commit message, thanks Wojciech and Andrew.
---
 drivers/net/ethernet/stmicro/stmmac/mmc_core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/mmc_core.c b/drivers/net/ethernet/stmicro/stmmac/mmc_core.c
index ea4910ae0921..6a7c1d325c46 100644
--- a/drivers/net/ethernet/stmicro/stmmac/mmc_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/mmc_core.c
@@ -177,8 +177,10 @@
 #define MMC_XGMAC_RX_DISCARD_OCT_GB	0x1b4
 #define MMC_XGMAC_RX_ALIGN_ERR_PKT	0x1bc
 
+#define MMC_XGMAC_TX_FPE_INTR_MASK	0x204
 #define MMC_XGMAC_TX_FPE_FRAG		0x208
 #define MMC_XGMAC_TX_HOLD_REQ		0x20c
+#define MMC_XGMAC_RX_FPE_INTR_MASK	0x224
 #define MMC_XGMAC_RX_PKT_ASSEMBLY_ERR	0x228
 #define MMC_XGMAC_RX_PKT_SMD_ERR	0x22c
 #define MMC_XGMAC_RX_PKT_ASSEMBLY_OK	0x230
@@ -352,6 +354,8 @@ static void dwxgmac_mmc_intr_all_mask(void __iomem *mmcaddr)
 {
 	writel(0x0, mmcaddr + MMC_RX_INTR_MASK);
 	writel(0x0, mmcaddr + MMC_TX_INTR_MASK);
+	writel(MMC_DEFAULT_MASK, mmcaddr + MMC_XGMAC_TX_FPE_INTR_MASK);
+	writel(MMC_DEFAULT_MASK, mmcaddr + MMC_XGMAC_RX_FPE_INTR_MASK);
 	writel(MMC_DEFAULT_MASK, mmcaddr + MMC_XGMAC_RX_IPC_INTR_MASK);
 }
 
-- 
2.34.1

