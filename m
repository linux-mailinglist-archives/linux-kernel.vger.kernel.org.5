Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFE1C77247F
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 14:44:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233712AbjHGMo1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 08:44:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233310AbjHGMoO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 08:44:14 -0400
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 524FB171E;
        Mon,  7 Aug 2023 05:44:13 -0700 (PDT)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4RKGGd3KWYz9sRH;
        Mon,  7 Aug 2023 14:44:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oltmanns.dev;
        s=MBO0001; t=1691412249;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SpKQU05wR+7Zs/sksGtxQdVy5+eUWQjc5g03Nzug4Xk=;
        b=YSzCGQ4Syz7bR8eF3HMeo7fnHKJqIXHblM1V0ex+odQM0ldLRERyL0GToUrZPgUhQEaET1
        d1y9ac2Th+j9oafzR8g17440CeO6j6MDw9+2RcSY+XDO+9LtNGjo3Ieu78bhpc+8KIELs9
        PTAtBvWf0WzLrEdAJCVeRpVT1O3IQbchvHWGcPxs836PZ3fdF2M1VavWz4KkTS/FyZKdfL
        o6nCa+z3smSb9oMWZFVjG1duesNeB16t1S/TDRCgHT5G+gaCwRtDp0aevvTEkCcRp8QzEg
        6dpBDQ+yphhyppEABFYblL8G8fLUzpDpLJjbprpXqc/gq4R1K6l+GDEWmDBQTg==
From:   Frank Oltmanns <frank@oltmanns.dev>
Date:   Mon, 07 Aug 2023 14:43:37 +0200
Subject: [PATCH v6 04/11] clk: sunxi-ng: Add feature to find closest rate
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230807-pll-mipi_set_rate_parent-v6-4-f173239a4b59@oltmanns.dev>
References: <20230807-pll-mipi_set_rate_parent-v6-0-f173239a4b59@oltmanns.dev>
In-Reply-To: <20230807-pll-mipi_set_rate_parent-v6-0-f173239a4b59@oltmanns.dev>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=978; i=frank@oltmanns.dev;
 h=from:subject:message-id; bh=3x31nxdweRqT+uRnszwgErzuZSGTLRFbE2HuT6iJDYM=;
 b=owEB7QES/pANAwAIAZppogiUStPHAcsmYgBk0OcKptx+VTRV8LM09n7IP+MlgokpAXqh7GyWV
 5NLMCG+I3+JAbMEAAEIAB0WIQQC/SV7f5DmuaVET5aaaaIIlErTxwUCZNDnCgAKCRCaaaIIlErT
 x+Q8C/0QUESt8er0xSXZGFj4gSeR1/gStfxEEXlYQGN6XDpSOeG/O8gAyTweu7NP+voR/gfaa/S
 3Ip4qKq2GDZV99P7TjqA9CUtrMFeFtDZnyNEsxkqy8rISoO3s6iprYVI9G2jzbs1ddErXO/4me3
 SvCA3gzUjz5QYotvaayiDk0zRGg4dmOUUr0Co+uUzSzPgH5lp10nfrlyQQbf0Z6N2ujq+sBukqo
 dH1Jp9iHh4jMAyHLc441fK7/mYQDONILylxZIU11FsZr7iQobrO/H9WwDx8zSCVV2Jwp+lEONgi
 EeD9SiF3VRhj9XWgVFcKaK/A/zaHgmcnMag2WTOqBSlDAuIDBcBVdHZ88w6krU+nzOClJzVM/s0
 6JuDghuKA20IJUizfim/ibV+OCAEDmSgqQ6neCqaM0zh7RKT9HMjV9eG5AggDva0w4/YDnDQFUx
 cXGojKJ187asYObueRA+LEQcwr1BjkHF7IxpumWxGqttAA7L8icuF4f3c1q6EsW1a3leo=
X-Developer-Key: i=frank@oltmanns.dev; a=openpgp;
 fpr=02FD257B7F90E6B9A5444F969A69A208944AD3C7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>
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

