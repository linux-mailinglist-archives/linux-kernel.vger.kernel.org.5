Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C7A8787802
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 20:34:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243116AbjHXSeX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 14:34:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243101AbjHXSd5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 14:33:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B72931BF6
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 11:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692901988;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qzwAY3qfQtSXBG/JoTJUgqmvExN/Fjeet/g8tdk5k1I=;
        b=TL9fvLw+yqz3s/7odtWIpAK6orDDc5L4WsTsgNyPMRhkB8P+WF01UC5wKRMeyqXG55V0r8
        p1y8Em/jvelAmvKMOMD1fxDswIj8jfFcqeRUbsOZeqsG/skBuaLFUZoEaqB8zFn+zurMVZ
        vr0AsIYmcKuwi0lc58z4llPjbAB0YqM=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-464-x7ETsS2zMmiHg6alqRKLvg-1; Thu, 24 Aug 2023 14:33:07 -0400
X-MC-Unique: x7ETsS2zMmiHg6alqRKLvg-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-64aaa3c2bc2so1487276d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 11:33:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692901987; x=1693506787;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qzwAY3qfQtSXBG/JoTJUgqmvExN/Fjeet/g8tdk5k1I=;
        b=RjbZrgetXaoXL2M/cZ6nqPUeTSAraVr5OTGzFgNPyTs++f4b/6jxT3sYWR2xQX2GS4
         vAtnxV87oSaag50Xrk1KEpZXn3LttLhinxRObI5p9NoRQJ9Fw2/RbLhE6eLZJW2LVYMi
         P7ttvodM3vkRQmyPsbejgpRp3vKmWmQDJPGf8sYEAUSNZVcUhFS1njaApIs58E2m32qy
         AbEtFF1EsahTjOdpPZbR5Nlh8q8/sBWTnCPVIOQfrT4q0t4S0WAflLFeK/f05VDSdMi3
         rCq/Hk+o5WuAPtmgB7TzwLg0OK8OONrxl6l8c0Zdwc1ftpyfrk0XnWFgIyGhpdDjAML2
         SSLw==
X-Gm-Message-State: AOJu0YxcIq4RIie6FqdgCq0zpKVIs2uxtS8pkrXuf5Bz27It0Z4PWBox
        KnMdgk/HDaluAqIAFg9y9rx3GiA72ItOTQRoulnMsvAOpoC3epWPYPs0icmCpqU5ZIVmfzDQqSq
        2aJbzc/9oi6xsFrGSLaU/cmAq
X-Received: by 2002:a0c:cb8a:0:b0:64b:997f:5a73 with SMTP id p10-20020a0ccb8a000000b0064b997f5a73mr17312069qvk.0.1692901986875;
        Thu, 24 Aug 2023 11:33:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH0V6Mej9o119R+pmyxj+YFe+lm4pgu3DlavB9TMY9jyVspWXod0xr56aTpa4++K5uMfm7xpg==
X-Received: by 2002:a0c:cb8a:0:b0:64b:997f:5a73 with SMTP id p10-20020a0ccb8a000000b0064b997f5a73mr17312048qvk.0.1692901986627;
        Thu, 24 Aug 2023 11:33:06 -0700 (PDT)
Received: from [192.168.1.165] ([2600:1700:1ff0:d0e0::37])
        by smtp.gmail.com with ESMTPSA id j17-20020a0ceb11000000b0064f77d37798sm4209qvp.5.2023.08.24.11.33.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Aug 2023 11:33:06 -0700 (PDT)
From:   Andrew Halaney <ahalaney@redhat.com>
Date:   Thu, 24 Aug 2023 13:32:58 -0500
Subject: [PATCH net-next 7/7] net: stmmac: Make PTP reference clock
 references more clear
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230824-stmmac-subsecond-inc-cleanup-v1-7-e0b9f7c18b37@redhat.com>
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
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ptp_clock is an overloaded term, and in some instances it is used to
represent the clk_ptp_rate variable. Just use that name as it is
clear that it represents the rate of the PTP reference clock.

Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
---
 drivers/net/ethernet/stmicro/stmmac/hwif.h            |  5 +++--
 drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c | 10 +++++-----
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.h b/drivers/net/ethernet/stmicro/stmmac/hwif.h
index bd607da65037..ba92b10cff0e 100644
--- a/drivers/net/ethernet/stmicro/stmmac/hwif.h
+++ b/drivers/net/ethernet/stmicro/stmmac/hwif.h
@@ -523,8 +523,9 @@ struct stmmac_ops {
 /* PTP and HW Timer helpers */
 struct stmmac_hwtimestamp {
 	void (*config_hw_tstamping) (void __iomem *ioaddr, u32 data);
-	void (*config_sub_second_increment)(void __iomem *ioaddr, u32 ptp_clock,
-					   int gmac4, u32 *sub_second_inc);
+	void (*config_sub_second_increment)(void __iomem *ioaddr,
+					    u32 clk_ptp_rate,
+					    int gmac4, u32 *sub_second_inc);
 	int (*init_systime) (void __iomem *ioaddr, u32 sec, u32 nsec);
 	int (*config_addend) (void __iomem *ioaddr, u32 addend);
 	int (*adjust_systime) (void __iomem *ioaddr, u32 sec, u32 nsec,
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c
index 29fd51bb853d..cc0386ee6dee 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c
@@ -24,7 +24,7 @@ static void config_hw_tstamping(void __iomem *ioaddr, u32 data)
 }
 
 static void config_sub_second_increment(void __iomem *ioaddr,
-		u32 ptp_clock, int gmac4, u32 *sub_second_inc)
+		u32 clk_ptp_rate, int gmac4, u32 *sub_second_inc)
 {
 	u32 value = readl(ioaddr + PTP_TCR);
 	unsigned long data;
@@ -34,14 +34,14 @@ static void config_sub_second_increment(void __iomem *ioaddr,
 	 * increment to twice the number of nanoseconds of a clock cycle.
 	 * The calculation of the default_addend value by the caller will set it
 	 * to mid-range = 2^31 when the remainder of this division is zero,
-	 * which will make the accumulator overflow once every 2 ptp_clock
+	 * which will make the accumulator overflow once every 2 clk_ptp_rate
 	 * cycles, adding twice the number of nanoseconds of a clock cycle :
-	 * 2 * NSEC_PER_SEC / ptp_clock.
+	 * 2 * NSEC_PER_SEC / clk_ptp_rate.
 	 */
 	if (value & PTP_TCR_TSCFUPDT)
-		data = (2 * NSEC_PER_SEC / ptp_clock);
+		data = (2 * NSEC_PER_SEC / clk_ptp_rate);
 	else
-		data = (NSEC_PER_SEC / ptp_clock);
+		data = (NSEC_PER_SEC / clk_ptp_rate);
 
 	/* 0.465ns accuracy */
 	if (!(value & PTP_TCR_TSCTRLSSR))

-- 
2.41.0

