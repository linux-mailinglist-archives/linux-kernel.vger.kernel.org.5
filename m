Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A0BB77152C
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Aug 2023 15:07:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbjHFNHp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Aug 2023 09:07:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjHFNHh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Aug 2023 09:07:37 -0400
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FFC119A9;
        Sun,  6 Aug 2023 06:07:35 -0700 (PDT)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4RJfr41dY4z9sWC;
        Sun,  6 Aug 2023 15:07:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oltmanns.dev;
        s=MBO0001; t=1691327252;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9mBnj/sxnS9zwU8wD2TdC9KZuObHfj2Iut9ShLW7rE4=;
        b=wHuAxDd5BgHWIy6qClaImBiXiz/M/Zjisvencs4WrxtVHowJY7QMuX1AMU+ecZ6RXbfulk
        8hTzWQ6ad7Ggmczrn7uj9rN/7Bf6TMf5iqDGuLrkoi3BbJTLPDE0dYFZ+vpARcN2jW3Ixq
        9B10OAvjJwTRlakt27SFudJEyqhaDWn34pRokALYu2g3cihTnbLomOS20bdS1OybtyF2jG
        017Zgfc8AiebXjBRyOKLlJTOIfAjvcTwjuyq/oYP6Q9OW5nZN0QaUFUVaiSgWw3+6Vz4+s
        wK81Bvcr/X525oadT+CJnNL8wPSYuL67pAhsJIYJ1b8dTF5mi4LLwX3UhxVB9A==
From:   Frank Oltmanns <frank@oltmanns.dev>
Date:   Sun, 06 Aug 2023 15:06:49 +0200
Subject: [PATCH v5 04/11] clk: sunxi-ng: Add feature to find closest rate
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230806-pll-mipi_set_rate_parent-v5-4-db4f5ca33fc3@oltmanns.dev>
References: <20230806-pll-mipi_set_rate_parent-v5-0-db4f5ca33fc3@oltmanns.dev>
In-Reply-To: <20230806-pll-mipi_set_rate_parent-v5-0-db4f5ca33fc3@oltmanns.dev>
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
 b=owEB7QES/pANAwAIAZppogiUStPHAcsmYgBkz5sHEM2bFxC57sgboTsWggrljhrWXTJ1sKB8/
 d6pVtHgP3uJAbMEAAEIAB0WIQQC/SV7f5DmuaVET5aaaaIIlErTxwUCZM+bBwAKCRCaaaIIlErT
 x7EzC/45nGmbcJ73KqZZrpd0scAqn1wgPmLY7YmnJRLCFRL0DyJoyefI5555Tu7iOPHyDmTu8+P
 DyqrPk7HwfcRBIBpyUtqataoEnbSZxbx74lOU0MRqaLAkXdwSM7L9PTgvCF2Elg8/T+Mv8i+VB4
 ksXbh9Vn7mE4XAZULzw+A9msFsYJtZjbNI2nSX04jnWAFhJXk8ptnXbnh1LVxoejuQvFPgwxWHa
 CoWz02j7Idxjk7O9qYGP+o/ds4gSrARi+YbhWFmgQoFVbKs9nK86FgNhuiWNM3CfAfDt1jpMm5F
 h9wEhgYB9huYKxaEXMNVkVOvwp/5EsTHB/aiZiK24CDXhQl/BN1N1RBdMmpnaqq487fJdhQFquj
 poQjvpBgLT5b6M/xX7x+OcaX1JAN6hcNJ9bgnFErVqqAUNVOMKNTY1B85yQbHHGb+zsVGy3/+xJ
 Eja11qHPeLfmVbwGwxEkceJf4M5m/gY7BFG4G4myBa16v0GSXW0/W/1tSQEP+ZxVR4hdU=
X-Developer-Key: i=frank@oltmanns.dev; a=openpgp;
 fpr=02FD257B7F90E6B9A5444F969A69A208944AD3C7
X-Rspamd-Queue-Id: 4RJfr41dY4z9sWC
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

