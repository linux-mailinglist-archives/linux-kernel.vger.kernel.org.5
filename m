Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC7F875651E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 15:35:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231681AbjGQNfJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 09:35:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231387AbjGQNfA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 09:35:00 -0400
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [IPv6:2001:67c:2050:0:465::101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE5AE198;
        Mon, 17 Jul 2023 06:34:52 -0700 (PDT)
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4R4NNn2wXfz9scd;
        Mon, 17 Jul 2023 15:34:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oltmanns.dev;
        s=MBO0001; t=1689600889;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9mBnj/sxnS9zwU8wD2TdC9KZuObHfj2Iut9ShLW7rE4=;
        b=P4IYBLXpzSKDpQDC3y/8eQEb7xIwNG2KeqYk9uYFHqXJh+SvwkbfijIZOWTyq9ScLuLh3t
        o5xviA0TEGMhMCOWCdOszeUF8aSM3UJbub59652i3lt0+Z3ZBWO8hNqLBs6b23oi7awO78
        QrEa2gpkhWFeXbp79PcSYhZvAGuo7OEv4nbjMtzXB+QyhUuzAjKlAw2N2E2rAmGLQVhURo
        rmuS65BPDo5/b0uqaXRVXzvHs9m4XQRfsll0LunNKgYXGrBfy65rz14MZtAFwPbrnhYaZa
        NBn+tMDFWOw8cTuhcciq8pqy5laq7dH7ozr/CLuFpClYY7eTl97GflWoNWpT0g==
From:   Frank Oltmanns <frank@oltmanns.dev>
Date:   Mon, 17 Jul 2023 15:34:29 +0200
Subject: [PATCH v4 05/11] clk: sunxi-ng: Add feature to find closest rate
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230717-pll-mipi_set_rate_parent-v4-5-04acf1d39765@oltmanns.dev>
References: <20230717-pll-mipi_set_rate_parent-v4-0-04acf1d39765@oltmanns.dev>
In-Reply-To: <20230717-pll-mipi_set_rate_parent-v4-0-04acf1d39765@oltmanns.dev>
To:     Maxime Ripard <mripard@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Andre Przywara <andre.przywara@arm.com>,
        Roman Beranek <me@crly.cz>
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Frank Oltmanns <frank@oltmanns.dev>
X-Developer-Signature: v=1; a=openpgp-sha256; l=925; i=frank@oltmanns.dev;
 h=from:subject:message-id; bh=gnSO2u9KSds+yso2ENUmK1fTBfjNRGShsPD5HpXqe+0=;
 b=owEB7QES/pANAwAIAZppogiUStPHAcsmYgBktUNnQaE7W76TYcfxfYnWsd1bG/r3SzYlXk8Rx
 EmA2MoX7ZmJAbMEAAEIAB0WIQQC/SV7f5DmuaVET5aaaaIIlErTxwUCZLVDZwAKCRCaaaIIlErT
 x492C/96NNmsav+tjwb4ER/kGeVV0NdFdh7BNDSmd/fCpHM4z0947Pi/8UHRgMHz+7i5n/xydyk
 oeKOFIEFZTCvA6MbQS7vcuS3szA4u72eOREafKEpwCLZRq6Tns0R2Z4r8lAuFZIs8bHf2QR86GB
 zy0yk0exP77FgUh3DycvDSpz/a0nuQZbzeqAjpPiVwre4TO0Bsez/lWMVGF5ZcnNSkA8KosGdsv
 mSSWmoYNU1YxO22J+r/Pg3HWIPW4k1TiQkOLTmK8Xcd7Nw67uGDQDpWLBxTC2t5sM+rCupVcwVf
 foXD7h21UYidnpg0wCaOc00SnWDTTxZzt9Kpewun2mYlfaP+dxmzqdG4QR2+qiwIgnoin3DDuYV
 avd/LnyHh1w7v3pkqXOSw4NjSoBzmpx3a1tm088tY9qsDf6JIAxH2CxsRFYu8NF+SXSQtWxwEtZ
 tGFLjGS0ANDgnLFddEki3/pMZqaDgig7bC+BgWgd+OyYJqGveWqPjK1Gs/mGAS1ne3RcE=
X-Developer-Key: i=frank@oltmanns.dev; a=openpgp;
 fpr=02FD257B7F90E6B9A5444F969A69A208944AD3C7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The default behaviour of clocks in the sunxi-ng driver is to select a
clock rate that is closest to but less than the requested rate.

Add the CCU_FEATURE_CLOSEST_RATE flag, which can be used to allow clocks
to find the closest rate instead.

Acked-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Frank Oltmanns <frank@oltmanns.dev>
---
 drivers/clk/sunxi-ng/ccu_common.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/sunxi-ng/ccu_common.h b/drivers/clk/sunxi-ng/ccu_common.h
index fbf16c6b896d..5ad219f041d5 100644
--- a/drivers/clk/sunxi-ng/ccu_common.h
+++ b/drivers/clk/sunxi-ng/ccu_common.h
@@ -18,6 +18,7 @@
 #define CCU_FEATURE_MMC_TIMING_SWITCH	BIT(6)
 #define CCU_FEATURE_SIGMA_DELTA_MOD	BIT(7)
 #define CCU_FEATURE_KEY_FIELD		BIT(8)
+#define CCU_FEATURE_CLOSEST_RATE	BIT(9)
 
 /* MMC timing mode switch bit */
 #define CCU_MMC_NEW_TIMING_MODE		BIT(30)

-- 
2.41.0

