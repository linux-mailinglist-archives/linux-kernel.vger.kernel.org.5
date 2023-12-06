Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A5D5806FE3
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 13:37:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378322AbjLFMhS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 07:37:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377925AbjLFMhR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 07:37:17 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07547D1
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 04:37:24 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0D26C433C9;
        Wed,  6 Dec 2023 12:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701866243;
        bh=rpE8tUM2R/1vhSlb7IqgfgIczGVZAD4AZUaewUYEnhI=;
        h=From:To:Cc:Subject:Date:From;
        b=RcwhKY5dkx9Ra+6ZK+fh2xWlEwOwFl2Uw0B/m5v5ovvziWI3hRlO9ai6VnyxAbMvD
         czgNL9W6WnTLezAjG9C7ktlYhjZ0/Ys3rIq1JVuCXEMozsspQiGWGP+Zt7lm7UZ6HD
         5stWmarfaqI1ioZHFJ/tfzfiQ6xm6Kdj8oT2wP088PshaGGDfeIp/aUSmPqUnomUTl
         XGIWpnhbLg4QoHCyyFEju904l8+NQHc0fnTom+IW+jXMUC++rq+YnUJ+PtuHQssq5l
         IlMwmyO993Kzr7qSwhLocupRq+e3c4wDXWG6yb2mMUBzrvJDIm9KoV2yw80+hqR3RS
         ARURZ/fpvvO5g==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] soc: qcom: stats: fix 64-bit division
Date:   Wed,  6 Dec 2023 13:37:06 +0100
Message-Id: <20231206123717.524009-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

Unguarded 64-bit division is not allowed on 32-bit kernels because this
is very slow. The result of trying anyway is a link failure:

arm-linux-gnueabi-ld: drivers/soc/qcom/qcom_stats.o: in function `qcom_ddr_stats_show':
qcom_stats.c:(.text+0x334): undefined reference to `__aeabi_uldivmod'

As this function is only used for debugging and not performance critical,
rewrite it to use div_u64() instead. ARCH_TIMER_FREQ is a multiple of
MSEC_PER_SEC anyway, so there is no loss in precisison.

Fixes: e84e61bdb97c ("soc: qcom: stats: Add DDR sleep stats")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/soc/qcom/qcom_stats.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/qcom/qcom_stats.c b/drivers/soc/qcom/qcom_stats.c
index 4763d62a8cb0..5ec8a754b22b 100644
--- a/drivers/soc/qcom/qcom_stats.c
+++ b/drivers/soc/qcom/qcom_stats.c
@@ -221,7 +221,7 @@ static int qcom_ddr_stats_show(struct seq_file *s, void *unused)
 
 	for (i = 0; i < ddr.entry_count; i++) {
 		/* Convert the period to ms */
-		entry[i].dur = mult_frac(MSEC_PER_SEC, entry[i].dur, ARCH_TIMER_FREQ);
+		entry[i].dur = div_u64(entry[i].dur, ARCH_TIMER_FREQ / MSEC_PER_SEC);
 	}
 
 	for (i = 0; i < ddr.entry_count; i++)
-- 
2.39.2

