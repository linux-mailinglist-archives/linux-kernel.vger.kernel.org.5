Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22EB97877FE
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 20:34:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243086AbjHXSeQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 14:34:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243083AbjHXSdv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 14:33:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 477CB19BE
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 11:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692901987;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZLXDxLfpL9zLoWLRxApVYve11hS/OEKZe5Jy4SYblss=;
        b=D89olKtSfR2cYQvbsASFJfWvuU398byhR+5AemSdKcCMdSyJyEyPckXXqpGFsnLtdDXjIQ
        of6Ih/NSxHJ157Km0p5n0McNZltGJ6Sj3PbMCqdxyIPlst7xrQitts+KGfglK8P6Equ/pJ
        HzvVUbFCC9XUzhJFzMdqmY0vCo3l02I=
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com
 [209.85.160.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-611-_pkhuncZOEezRLgo4woftQ-1; Thu, 24 Aug 2023 14:33:06 -0400
X-MC-Unique: _pkhuncZOEezRLgo4woftQ-1
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-1c0ed186cf5so110053fac.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 11:33:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692901985; x=1693506785;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZLXDxLfpL9zLoWLRxApVYve11hS/OEKZe5Jy4SYblss=;
        b=GmHuy+3R/3/MOI3pXOq7HVyQ+pj3pBK8vxtI/1WzoFvhz+1+BRQWNUjML7yw/7GJck
         h3QmXB2BwSbmaTY8z6GFTMKlwssKpPVy+awbTvhHvHa80mH1LlQovzSzD/YE9x9t5cir
         T07YL92qVqTDK7xg1brzVOesQJzqeJE1uGjfqJg8P0JcPM29CeQ7ncjJf4gBTd8OlcFF
         yjaFZv6pWU6kncUew7q2ngCvoC/Sa8Ek5HeqaLL2Ztz5vleWwQ7gconHEaXthXs1nalU
         34AVPEWuzheZraPKlWuRhWb9hZBjpOuwcBNsW49XhvuoFbRoim8+nyxl8YUVDmkvYyYK
         IAFg==
X-Gm-Message-State: AOJu0YxIY23uFGJfCIHBaWaLceZY3jv+P5dmPyRkp3pmEK0qHO9SJ/Ls
        Lo5AcGosZF5fKDv1s8o2MF6U5wGOQbGfwIP3Rg6UwDQgED89YmfD2Og2Cg9WCBe3qPfaX7I3aTy
        CSeWwm4kY07+crIqHhD41Aklm
X-Received: by 2002:a05:6871:299:b0:1b4:60b3:98bc with SMTP id i25-20020a056871029900b001b460b398bcmr646681oae.2.1692901985290;
        Thu, 24 Aug 2023 11:33:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFbJca0VCeTskNWvGHD1H3TewlM9C3a0yafFFNkx3PrLHoWuGVt7iXKwhjuSJvnGG6tkI3pdg==
X-Received: by 2002:a05:6871:299:b0:1b4:60b3:98bc with SMTP id i25-20020a056871029900b001b460b398bcmr646661oae.2.1692901985092;
        Thu, 24 Aug 2023 11:33:05 -0700 (PDT)
Received: from [192.168.1.165] ([2600:1700:1ff0:d0e0::37])
        by smtp.gmail.com with ESMTPSA id j17-20020a0ceb11000000b0064f77d37798sm4209qvp.5.2023.08.24.11.33.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Aug 2023 11:33:04 -0700 (PDT)
From:   Andrew Halaney <ahalaney@redhat.com>
Date:   Thu, 24 Aug 2023 13:32:57 -0500
Subject: [PATCH net-next 6/7] net: stmmac: Fix comment about default addend
 calculation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230824-stmmac-subsecond-inc-cleanup-v1-6-e0b9f7c18b37@redhat.com>
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

The comment neglects that freq_div_ratio is the ratio between
the subsecond increment frequency and the clk_ptp_rate frequency.

Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index dfead0df6163..64185753865f 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -853,10 +853,12 @@ int stmmac_init_tstamp_counter(struct stmmac_priv *priv, u32 systime_flags)
 	/* Store sub second increment for later use */
 	priv->sub_second_inc = sub_second_inc;
 
-	/* calculate default addend value:
-	 * formula is :
-	 * addend = (2^32)/freq_div_ratio;
-	 * where, freq_div_ratio = 1e9ns/sub_second_inc
+	/* Calculate default addend so the accumulator overflows (2^32) in
+	 * sub_second_inc (ns). The addend is added to the accumulator
+	 * every clk_ptp cycle.
+	 *
+	 * addend = (2^32) / freq_div_ratio
+	 * where, freq_div_ratio = (1e9ns / sub_second_inc) / clk_ptp_rate
 	 */
 	temp = div_u64(NSEC_PER_SEC, sub_second_inc);
 	temp = temp << 32;

-- 
2.41.0

