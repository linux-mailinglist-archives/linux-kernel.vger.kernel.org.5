Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95FB37750A1
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 04:03:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbjHICC7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 22:02:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjHICC5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 22:02:57 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CA9EF3;
        Tue,  8 Aug 2023 19:02:57 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id 46e09a7af769-6bcac140aaaso4940205a34.2;
        Tue, 08 Aug 2023 19:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691546576; x=1692151376;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Axs5IugcYQGA7KHD1wIEp1iCvcichKmuTF1YhYLpm2s=;
        b=IPmEF+Oc+Ymen9pbBQ1kQ8m7nBbjb4gHbbg5mwwR0AmavHfv0v/afWFmI45rIrXeJR
         mYt3a3r1MH9dHxkBqWc0bzKhcaYSbV8sjI0S4ED/COMmjNegeZ4K8tmKZVgASKIo8OMc
         UPKjfVGLLhljpEreQ6YVWiuZy8feXQwC6Jy5jRU/k+n1Lhi+byJCviv/mHU4MgYZOz8E
         QNIe19Tf7PN6pWRhEe1s/N/di1l1KD6IkaNCWTiOyS+MpdqX/pDMsvp1i1iDCdY/M2Ua
         XJrfKnVE60cmSSWKz/qBt1E4weGTXXtmWmrQi8j0F2RlvGuG+G9k9ZlxlsztSAq6NsPA
         oLNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691546576; x=1692151376;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Axs5IugcYQGA7KHD1wIEp1iCvcichKmuTF1YhYLpm2s=;
        b=BvwsfhxEF+XA4eDMDGTi+Ui/ScSEIrcdovnlmVaDa59HxalzkZESrWerDZ2Mmi4Iwv
         R/bfSEmlSbwZRj5IrmvmylGJzcVHfkM3LOVMR6RuygiPB2c5fCh//6BmlRzMKDVZ7Qm5
         nKtvUMOx72cohlb63zUBEvE7YCOfGiaJik2wWNHr+frLvO8p1OHyoJ76+heFkUWCzrgP
         iPq1kLMYgpU3UUHKKAZKw8P9Mng4FmpvTig6uvzNiAdoOg8+RkAcg99Umi+cA3U1G9fB
         bDNh4Hguwo1bQ+qqWMq06i3Sxa4oeexXOcf9T/pFUYdO4EsOUlSifWCCVuOi5tyDVwWd
         SlPg==
X-Gm-Message-State: AOJu0Yx7HA2KZMk4+9fqxKGnnrovZHw1Kv1oWh5ehiq2ZcfQH2jJs0QJ
        Wwrz2wU2lfO9YqR9Qzm0xWc=
X-Google-Smtp-Source: AGHT+IHlgYgM84isX0Aajw5zqTgIYkCyQoIlFM65l9Iv7mC6XODNv+KRtcVU5ZT2+cB8K2U5tIwfAA==
X-Received: by 2002:a05:6830:1e52:b0:6b9:f1d3:160 with SMTP id e18-20020a0568301e5200b006b9f1d30160mr1505440otj.11.1691546576354;
        Tue, 08 Aug 2023 19:02:56 -0700 (PDT)
Received: from localhost.localdomain ([198.211.45.220])
        by smtp.googlemail.com with ESMTPSA id v19-20020aa78093000000b00672401787c6sm8726941pff.109.2023.08.08.19.02.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 19:02:55 -0700 (PDT)
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
Subject: [PATCH net-next v3 1/1] net: stmmac: xgmac: RX queue routing configuration
Date:   Wed,  9 Aug 2023 10:02:38 +0800
Message-Id: <20230809020238.1136732-1-0x1207@gmail.com>
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

Commit abe80fdc6ee6 ("net: stmmac: RX queue routing configuration")
introduced RX queue routing to DWMAC4 core.
This patch extend the support to XGMAC2 core.

Signed-off-by: Furong Xu <0x1207@gmail.com>
---
Changes in v3:
  - Clean unused defines

Changes in v2:
  - Convert the shift ops to FIELD_PREP
---
 .../net/ethernet/stmicro/stmmac/dwxgmac2.h    | 12 +++++++
 .../ethernet/stmicro/stmmac/dwxgmac2_core.c   | 34 +++++++++++++++++--
 2 files changed, 44 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
index 1913385df685..5f931afab9aa 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
@@ -74,8 +74,20 @@
 #define XGMAC_RXQEN(x)			GENMASK((x) * 2 + 1, (x) * 2)
 #define XGMAC_RXQEN_SHIFT(x)		((x) * 2)
 #define XGMAC_RXQ_CTRL1			0x000000a4
+#define XGMAC_AVCPQ			GENMASK(31, 28)
+#define XGMAC_AVCPQ_SHIFT		28
+#define XGMAC_PTPQ			GENMASK(27, 24)
+#define XGMAC_PTPQ_SHIFT		24
+#define XGMAC_TACPQE			BIT(23)
+#define XGMAC_DCBCPQ			GENMASK(19, 16)
+#define XGMAC_DCBCPQ_SHIFT		16
+#define XGMAC_MCBCQEN			BIT(15)
+#define XGMAC_MCBCQ			GENMASK(11, 8)
+#define XGMAC_MCBCQ_SHIFT		8
 #define XGMAC_RQ			GENMASK(7, 4)
 #define XGMAC_RQ_SHIFT			4
+#define XGMAC_UPQ			GENMASK(3, 0)
+#define XGMAC_UPQ_SHIFT			0
 #define XGMAC_RXQ_CTRL2			0x000000a8
 #define XGMAC_RXQ_CTRL3			0x000000ac
 #define XGMAC_PSRQ(x)			GENMASK((x) * 8 + 7, (x) * 8)
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
index a0c2ef8bb0ac..38782662ff98 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
@@ -127,6 +127,36 @@ static void dwxgmac2_tx_queue_prio(struct mac_device_info *hw, u32 prio,
 	writel(value, ioaddr + reg);
 }
 
+static void dwxgmac2_rx_queue_routing(struct mac_device_info *hw,
+				      u8 packet, u32 queue)
+{
+	void __iomem *ioaddr = hw->pcsr;
+	u32 value;
+
+	static const struct stmmac_rx_routing dwxgmac2_route_possibilities[] = {
+		{ XGMAC_AVCPQ, XGMAC_AVCPQ_SHIFT },
+		{ XGMAC_PTPQ, XGMAC_PTPQ_SHIFT },
+		{ XGMAC_DCBCPQ, XGMAC_DCBCPQ_SHIFT },
+		{ XGMAC_UPQ, XGMAC_UPQ_SHIFT },
+		{ XGMAC_MCBCQ, XGMAC_MCBCQ_SHIFT },
+	};
+
+	value = readl(ioaddr + XGMAC_RXQ_CTRL1);
+
+	/* routing configuration */
+	value &= ~dwxgmac2_route_possibilities[packet - 1].reg_mask;
+	value |= (queue << dwxgmac2_route_possibilities[packet - 1].reg_shift) &
+		 dwxgmac2_route_possibilities[packet - 1].reg_mask;
+
+	/* some packets require extra ops */
+	if (packet == PACKET_AVCPQ)
+		value |= FIELD_PREP(XGMAC_TACPQE, 1);
+	else if (packet == PACKET_MCBCQ)
+		value |= FIELD_PREP(XGMAC_MCBCQEN, 1);
+
+	writel(value, ioaddr + XGMAC_RXQ_CTRL1);
+}
+
 static void dwxgmac2_prog_mtl_rx_algorithms(struct mac_device_info *hw,
 					    u32 rx_alg)
 {
@@ -1463,7 +1493,7 @@ const struct stmmac_ops dwxgmac210_ops = {
 	.rx_queue_enable = dwxgmac2_rx_queue_enable,
 	.rx_queue_prio = dwxgmac2_rx_queue_prio,
 	.tx_queue_prio = dwxgmac2_tx_queue_prio,
-	.rx_queue_routing = NULL,
+	.rx_queue_routing = dwxgmac2_rx_queue_routing,
 	.prog_mtl_rx_algorithms = dwxgmac2_prog_mtl_rx_algorithms,
 	.prog_mtl_tx_algorithms = dwxgmac2_prog_mtl_tx_algorithms,
 	.set_mtl_tx_queue_weight = dwxgmac2_set_mtl_tx_queue_weight,
@@ -1524,7 +1554,7 @@ const struct stmmac_ops dwxlgmac2_ops = {
 	.rx_queue_enable = dwxlgmac2_rx_queue_enable,
 	.rx_queue_prio = dwxgmac2_rx_queue_prio,
 	.tx_queue_prio = dwxgmac2_tx_queue_prio,
-	.rx_queue_routing = NULL,
+	.rx_queue_routing = dwxgmac2_rx_queue_routing,
 	.prog_mtl_rx_algorithms = dwxgmac2_prog_mtl_rx_algorithms,
 	.prog_mtl_tx_algorithms = dwxgmac2_prog_mtl_tx_algorithms,
 	.set_mtl_tx_queue_weight = dwxgmac2_set_mtl_tx_queue_weight,
-- 
2.34.1

