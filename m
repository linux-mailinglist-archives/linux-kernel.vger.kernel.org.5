Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD0F27877FD
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 20:34:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243077AbjHXSeP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 14:34:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243069AbjHXSdq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 14:33:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A218D1BE5
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 11:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692901980;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6MSPeUOmvEq1eUUgwQ2syHQsuZQFtArlwfrE4/FiNFk=;
        b=MlFwLBFWJG6gjowEuFQCKNzg9JVCfTrGVQgaLU9iWtUcx6YAE/byFaQzduOJ8eq40QIEYL
        U/y0CXWakzmuxFykx5wNhtp3oMCy2S8oRXjdu3RVAivM0dool/YSaTvV8BBqzgr5cK+w9N
        7K5vl69YJnVD4EVnYD3wg5otyWehKKg=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613-fIwoh08cPwe46NH9gP9zAg-1; Thu, 24 Aug 2023 14:32:59 -0400
X-MC-Unique: fIwoh08cPwe46NH9gP9zAg-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-649fac91500so11618456d6.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 11:32:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692901979; x=1693506779;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6MSPeUOmvEq1eUUgwQ2syHQsuZQFtArlwfrE4/FiNFk=;
        b=gO+kZ/XapO2vwuN2Fsv0ujRD8EpWHkxxNsWHVYvLCvXHkelwrTP2XnwWjcO98w4esa
         8WN8KjE6AgaadsZEaZCR/FaPGfnK1d4MQCwl7/qSZctxXNro9nPpx65qE+oLKWYXZUNP
         ubYci8ZmUISxsueZQUo6a13olBJjXi97xeRL3pTJHikOCdFKi6vehjgW+RiS/u34saXK
         5eqOxnX6jiEl8nOyvhmgnpzpH5Td6U8uS8N7afNca4u6jQOYSS9CIfAxnjL9wyYbyXFo
         /h/CisMgYYfBtJKF2gPjyJn1MaUQ9y5pb1Y8kaFQNG96r6yN8k6yHjjfJwI+9jVcj2aJ
         sWwA==
X-Gm-Message-State: AOJu0YxlLZt82fjGdHByHM0c/Ygkz396VBIbl3DW924Ju+DfNI3KQlX8
        w54WD4KOCViWxQDo70vQSqc/FbsipgZeLaK0lC5lLJw6QBDrhC0erMaUEHy+bYgQYf1wqwZ7JPK
        Au2/Oo/sOAV1kqmhuHu9e1ZuG
X-Received: by 2002:a0c:e246:0:b0:647:2653:bcc with SMTP id x6-20020a0ce246000000b0064726530bccmr18915153qvl.13.1692901978980;
        Thu, 24 Aug 2023 11:32:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFOnxZtOm4Zbo/1b64keu9y2z8jyW5dWXMkNKbfmN/AXxPf8v016bCHVXCzjBnQUDUxKTav6w==
X-Received: by 2002:a0c:e246:0:b0:647:2653:bcc with SMTP id x6-20020a0ce246000000b0064726530bccmr18915120qvl.13.1692901978737;
        Thu, 24 Aug 2023 11:32:58 -0700 (PDT)
Received: from [192.168.1.165] ([2600:1700:1ff0:d0e0::37])
        by smtp.gmail.com with ESMTPSA id j17-20020a0ceb11000000b0064f77d37798sm4209qvp.5.2023.08.24.11.32.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Aug 2023 11:32:58 -0700 (PDT)
From:   Andrew Halaney <ahalaney@redhat.com>
Date:   Thu, 24 Aug 2023 13:32:52 -0500
Subject: [PATCH net-next 1/7] net: stmmac: Use consistent variable name for
 subsecond increment
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230824-stmmac-subsecond-inc-cleanup-v1-1-e0b9f7c18b37@redhat.com>
References: <20230824-stmmac-subsecond-inc-cleanup-v1-0-e0b9f7c18b37@redhat.com>
In-Reply-To: <20230824-stmmac-subsecond-inc-cleanup-v1-0-e0b9f7c18b37@redhat.com>
To:     Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Richard Cochran <richardcochran@gmail.com>
Cc:     netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Andrew Halaney <ahalaney@redhat.com>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Subsecond increment is the name of the field being programmed.
Let's stop using a bunch of variations of that name and just
use sub_second_inc throughout.

Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
---
 drivers/net/ethernet/stmicro/stmmac/hwif.h            |  2 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c |  6 +++---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c     | 10 +++++-----
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.h b/drivers/net/ethernet/stmicro/stmmac/hwif.h
index 238f17c50a1e..bd607da65037 100644
--- a/drivers/net/ethernet/stmicro/stmmac/hwif.h
+++ b/drivers/net/ethernet/stmicro/stmmac/hwif.h
@@ -524,7 +524,7 @@ struct stmmac_ops {
 struct stmmac_hwtimestamp {
 	void (*config_hw_tstamping) (void __iomem *ioaddr, u32 data);
 	void (*config_sub_second_increment)(void __iomem *ioaddr, u32 ptp_clock,
-					   int gmac4, u32 *ssinc);
+					   int gmac4, u32 *sub_second_inc);
 	int (*init_systime) (void __iomem *ioaddr, u32 sec, u32 nsec);
 	int (*config_addend) (void __iomem *ioaddr, u32 addend);
 	int (*adjust_systime) (void __iomem *ioaddr, u32 sec, u32 nsec,
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c
index 540f6a4ec0b8..6dcf8582a70e 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c
@@ -24,7 +24,7 @@ static void config_hw_tstamping(void __iomem *ioaddr, u32 data)
 }
 
 static void config_sub_second_increment(void __iomem *ioaddr,
-		u32 ptp_clock, int gmac4, u32 *ssinc)
+		u32 ptp_clock, int gmac4, u32 *sub_second_inc)
 {
 	u32 value = readl(ioaddr + PTP_TCR);
 	unsigned long data;
@@ -56,8 +56,8 @@ static void config_sub_second_increment(void __iomem *ioaddr,
 
 	writel(reg_value, ioaddr + PTP_SSIR);
 
-	if (ssinc)
-		*ssinc = data;
+	if (sub_second_inc)
+		*sub_second_inc = data;
 }
 
 static void hwtstamp_correct_latency(struct stmmac_priv *priv)
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 7a9bbcf03ea5..67e4f65f0f68 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -836,7 +836,7 @@ int stmmac_init_tstamp_counter(struct stmmac_priv *priv, u32 systime_flags)
 {
 	bool xmac = priv->plat->has_gmac4 || priv->plat->has_xgmac;
 	struct timespec64 now;
-	u32 sec_inc = 0;
+	u32 sub_second_inc = 0;
 	u64 temp = 0;
 
 	if (!(priv->dma_cap.time_stamp || priv->dma_cap.atime_stamp))
@@ -848,16 +848,16 @@ int stmmac_init_tstamp_counter(struct stmmac_priv *priv, u32 systime_flags)
 	/* program Sub Second Increment reg */
 	stmmac_config_sub_second_increment(priv, priv->ptpaddr,
 					   priv->plat->clk_ptp_rate,
-					   xmac, &sec_inc);
-	temp = div_u64(1000000000ULL, sec_inc);
+					   xmac, &sub_second_inc);
+	temp = div_u64(1000000000ULL, sub_second_inc);
 
 	/* Store sub second increment for later use */
-	priv->sub_second_inc = sec_inc;
+	priv->sub_second_inc = sub_second_inc;
 
 	/* calculate default added value:
 	 * formula is :
 	 * addend = (2^32)/freq_div_ratio;
-	 * where, freq_div_ratio = 1e9ns/sec_inc
+	 * where, freq_div_ratio = 1e9ns/sub_second_inc
 	 */
 	temp = (u64)(temp << 32);
 	priv->default_addend = div_u64(temp, priv->plat->clk_ptp_rate);

-- 
2.41.0

