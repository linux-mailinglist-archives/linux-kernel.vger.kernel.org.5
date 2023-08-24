Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C201F787800
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 20:34:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243096AbjHXSeR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 14:34:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243082AbjHXSdv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 14:33:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D8B519B0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 11:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692901982;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=thxHPyqpXjBOV26mQw4932uoaf4t0NSsG4y7+rk0Hj4=;
        b=gYa4tBS4f5oK40bQR6hGQM5vJLmEyh8YfSRCxWo7/SisVwV7IL6LzmSJq1wpMePpaiMyMI
        K28ti6ALn5+5ZkQdm2zixodxGQbSWe8upww+yk2k9u9jC3631LZJ8Z1DmAQipP/yvO86sU
        GBgMKvO94M7BslCERBd7ycU6m0d7WkY=
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com
 [209.85.160.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-483-7o7M4F2mM4aKVtHl2tR8Dw-1; Thu, 24 Aug 2023 14:33:00 -0400
X-MC-Unique: 7o7M4F2mM4aKVtHl2tR8Dw-1
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-1ccbcb5034aso101658fac.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 11:33:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692901980; x=1693506780;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=thxHPyqpXjBOV26mQw4932uoaf4t0NSsG4y7+rk0Hj4=;
        b=jUUcpkeSLDCTQQDZpm9wPEAgnsfwKx4e16JVSiFaQSELXXiCVmNAgbwwxAmxIyKUQQ
         joVQV6+ULC/b/GS2RN2S9+an5y6mGndqFs322kLzVLVqelr+7ixti2MPGthJ3DEYP0Ec
         Nvr9kbxpeg0O/k6rbdtkeVYUql0rue+xkNMjkRpmiia+G+2NdoPwvbdwodXWINV2T+O4
         7nXp9cHxsX08IsE8XaJg5oijee8s/k0vK7NkgKCSmhRVfxdRPBXFkQ4MPdEAvc0EN/2b
         GRqH5gDJi289wkoMFzg3Jc2nzO32FATUC9CLhu4V5eGdTHHIO6hnTPcmXt8i4Jfnlc3q
         uISw==
X-Gm-Message-State: AOJu0YyONr7o5II40k8r4N+HZNLtPWjF9j/ocYb0sp89E/SMOR+55bHv
        G9olBBvILRMofXInRH3RkBxIWujsheT2gnWsQdwCuSdQKNUoJi6xAH07K2CsExRbRzkQnsbjO6T
        r3WE57mqcL02Y8AiTykQhgUTo
X-Received: by 2002:a05:6870:b30e:b0:1c8:b870:4e62 with SMTP id a14-20020a056870b30e00b001c8b8704e62mr553972oao.52.1692901980218;
        Thu, 24 Aug 2023 11:33:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFNSmaNfEZS7WL931iN10lI15Wz+1s4J2mbWyoGTTDkdpLqrEtuCwFnkDMpqeyKk0MWFoSBXQ==
X-Received: by 2002:a05:6870:b30e:b0:1c8:b870:4e62 with SMTP id a14-20020a056870b30e00b001c8b8704e62mr553945oao.52.1692901979913;
        Thu, 24 Aug 2023 11:32:59 -0700 (PDT)
Received: from [192.168.1.165] ([2600:1700:1ff0:d0e0::37])
        by smtp.gmail.com with ESMTPSA id j17-20020a0ceb11000000b0064f77d37798sm4209qvp.5.2023.08.24.11.32.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Aug 2023 11:32:59 -0700 (PDT)
From:   Andrew Halaney <ahalaney@redhat.com>
Date:   Thu, 24 Aug 2023 13:32:53 -0500
Subject: [PATCH net-next 2/7] net: stmmac: Use NSEC_PER_SEC for hwtstamp
 calculations
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230824-stmmac-subsecond-inc-cleanup-v1-2-e0b9f7c18b37@redhat.com>
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
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This makes it more clear what unit conversions are happening.

Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c | 6 +++---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c     | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c
index 6dcf8582a70e..29fd51bb853d 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c
@@ -36,12 +36,12 @@ static void config_sub_second_increment(void __iomem *ioaddr,
 	 * to mid-range = 2^31 when the remainder of this division is zero,
 	 * which will make the accumulator overflow once every 2 ptp_clock
 	 * cycles, adding twice the number of nanoseconds of a clock cycle :
-	 * 2000000000ULL / ptp_clock.
+	 * 2 * NSEC_PER_SEC / ptp_clock.
 	 */
 	if (value & PTP_TCR_TSCFUPDT)
-		data = (2000000000ULL / ptp_clock);
+		data = (2 * NSEC_PER_SEC / ptp_clock);
 	else
-		data = (1000000000ULL / ptp_clock);
+		data = (NSEC_PER_SEC / ptp_clock);
 
 	/* 0.465ns accuracy */
 	if (!(value & PTP_TCR_TSCTRLSSR))
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 67e4f65f0f68..ba38ca284e26 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -849,7 +849,7 @@ int stmmac_init_tstamp_counter(struct stmmac_priv *priv, u32 systime_flags)
 	stmmac_config_sub_second_increment(priv, priv->ptpaddr,
 					   priv->plat->clk_ptp_rate,
 					   xmac, &sub_second_inc);
-	temp = div_u64(1000000000ULL, sub_second_inc);
+	temp = div_u64(NSEC_PER_SEC, sub_second_inc);
 
 	/* Store sub second increment for later use */
 	priv->sub_second_inc = sub_second_inc;

-- 
2.41.0

