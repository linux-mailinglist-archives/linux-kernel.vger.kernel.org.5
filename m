Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E95247A6B68
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 21:20:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232740AbjISTUK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 15:20:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232549AbjISTUI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 15:20:08 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B61B4E6
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 12:20:02 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id af79cd13be357-773ae5d2b1fso320956885a.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 12:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hefring-com.20230601.gappssmtp.com; s=20230601; t=1695151202; x=1695756002; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tnm2Moa364NnFvHBWbJW5Miitr7z3kjIIDJjJlIthFQ=;
        b=jqd1UVw6vBz3BQwmehiHhdpaAtVrMwEIx/ar5/0g9Wx3/m7Ea565CyZjxQ/+h9vZK9
         KElcGoOJkimanqMoZrDGWQSghxPLpQ2nSX8Z5WIdLuqylb+0Ya57sQ558zPHcH+bzmGR
         SFxf7HOG9cWUV5bjWxacXbjmqNq6pPty72H/rMR/MGbXzmAii+4IkCIjl8O6F21tU4PO
         TZWYZ4AJ5bPChs3TQ62JZaNStG6gVxdmKqQFDhVBKbEIJ6h/n3C9OkhdtAE08IJeg2gn
         RCRZ00Ou1CdfXBoXKuDoMcOlch6zXH4vWB2hd/1HVmq/9YcEuXCrv/6UiYnDQhGnGm9J
         YYeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695151202; x=1695756002;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tnm2Moa364NnFvHBWbJW5Miitr7z3kjIIDJjJlIthFQ=;
        b=iADR6tfO3cwtorN8rGvxuV1TJiws0Sf/rh3cu2MkyTzygHraJpc7deRwjl4I6HcCvO
         IAKeUhxWH1didNffrL+q59zTzBl0i7SA2pZReB4EO4o8533gdjuL9FKAEZu+pB/dbWy+
         kwNlV4FvaFlRoHF6moyzJeIa3kicXbjNUaRvELU3C55TtN7HKmQI90OBRt+dEi/8gM7s
         B5TplLpwcT4PGh0nALn8Gpov17JVawuI2nWBgMPj6WgpsFTCuwjSi8InZuJ4v7EUQiE0
         iVF5V8+7EmVREjt0dVi3aI8EuwVhpMjrLgYqruRZf6a3RgSKLyLESt7zmQK/my/feOiY
         dxgA==
X-Gm-Message-State: AOJu0Yx+fbuZF3UUe6ZnKNKn2hGC4gYFGMYgBskT2wbmv0MCQST1dJCU
        GL2ENy9SBbdY1EWSjfp2NX3vuQ==
X-Google-Smtp-Source: AGHT+IEtMT18UqS7I4dDjLyzrmF1BJ/xA9i1ZcPz4h6w0cU5Wi2SCvT/zEEnS+t7MQZQTRvyYMQR/w==
X-Received: by 2002:a05:620a:288e:b0:76c:d958:d549 with SMTP id j14-20020a05620a288e00b0076cd958d549mr784459qkp.11.1695151201770;
        Tue, 19 Sep 2023 12:20:01 -0700 (PDT)
Received: from dell-precision-5540.lan ([2601:18c:8002:3d40:df77:9915:c17e:79])
        by smtp.gmail.com with ESMTPSA id x12-20020ae9f80c000000b0076c60b95b87sm4179704qkh.96.2023.09.19.12.20.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 12:20:01 -0700 (PDT)
From:   Ben Wolsieffer <ben.wolsieffer@hefring.com>
To:     linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Cc:     Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Christophe Roullier <christophe.roullier@st.com>,
        Ben Wolsieffer <ben.wolsieffer@hefring.com>
Subject: [PATCH 1/2] net: stmmac: dwmac-stm32: fix resume on STM32 MCU
Date:   Tue, 19 Sep 2023 12:45:35 -0400
Message-ID: <20230919164535.128125-3-ben.wolsieffer@hefring.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230919164535.128125-2-ben.wolsieffer@hefring.com>
References: <20230919164535.128125-2-ben.wolsieffer@hefring.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The STM32MP1 keeps clk_rx enabled during suspend, and therefore the
driver does not enable the clock in stm32_dwmac_init() if the device was
suspended. The problem is that this same code runs on STM32 MCUs, which
do disable clk_rx during suspend, causing the clock to never be
re-enabled on resume.

This patch adds a variant flag to indicate that clk_rx remains enabled
during suspend, and uses this to decide whether to enable the clock in
stm32_dwmac_init() if the device was suspended.

Fixes: 6528e02cc9ff ("net: ethernet: stmmac: add adaptation for stm32mp157c.")
Signed-off-by: Ben Wolsieffer <ben.wolsieffer@hefring.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
index 26ea8c687881..a0e276783e65 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
@@ -104,6 +104,7 @@ struct stm32_ops {
 	int (*parse_data)(struct stm32_dwmac *dwmac,
 			  struct device *dev);
 	u32 syscfg_eth_mask;
+	bool clk_rx_enable_in_suspend;
 };
 
 static int stm32_dwmac_init(struct plat_stmmacenet_data *plat_dat)
@@ -121,7 +122,8 @@ static int stm32_dwmac_init(struct plat_stmmacenet_data *plat_dat)
 	if (ret)
 		return ret;
 
-	if (!dwmac->dev->power.is_suspended) {
+	if (!dwmac->ops->clk_rx_enable_in_suspend ||
+	    !dwmac->dev->power.is_suspended) {
 		ret = clk_prepare_enable(dwmac->clk_rx);
 		if (ret) {
 			clk_disable_unprepare(dwmac->clk_tx);
@@ -513,7 +515,8 @@ static struct stm32_ops stm32mp1_dwmac_data = {
 	.suspend = stm32mp1_suspend,
 	.resume = stm32mp1_resume,
 	.parse_data = stm32mp1_parse_data,
-	.syscfg_eth_mask = SYSCFG_MP1_ETH_MASK
+	.syscfg_eth_mask = SYSCFG_MP1_ETH_MASK,
+	.clk_rx_enable_in_suspend = true
 };
 
 static const struct of_device_id stm32_dwmac_match[] = {
-- 
2.42.0

