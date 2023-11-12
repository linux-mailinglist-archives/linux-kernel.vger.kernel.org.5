Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 156447E8EE1
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Nov 2023 08:04:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230140AbjKLHE0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 02:04:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbjKLHEZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 02:04:25 -0500
Received: from smtp.smtpout.orange.fr (smtp-19.smtpout.orange.fr [80.12.242.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4C1A2D77
        for <linux-kernel@vger.kernel.org>; Sat, 11 Nov 2023 23:04:20 -0800 (PST)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id 24W0rp1dBgXzu24W0rWg1a; Sun, 12 Nov 2023 08:04:18 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1699772658;
        bh=0TwurGk4N8xQeF0I50WBdPaLE9khS76hRB9u8ImU++k=;
        h=From:To:Cc:Subject:Date;
        b=XEmgaPpTdQuZF/aHvzBpkgEAq0ntM1YMzVvOVVRUefQjYa3Ck9LJrTl2lgbbOOBhY
         4KqLFMXLrMcdlA1jj6Ocv6AQvyZ3uBOCOru3FIwC7UBg8US+Y0lnJ7QqQc85qhpxRU
         AWM2+fbv5ytvZ5dfyFXs/vWBO0J+SCoqO7MaQsqnb0mSUXlRTo0HGqTzHtmAdBoADL
         L1tPaKbr2VlmM0HX09RpmShrZMSiyZkVfTOSnFJlvXZ+f/gzfUE7X819CIyjuZCVuy
         B8mfUDGGZ/hJzfZ88OA4uYdmqlEOybGT6+jj2ILZlMhrx+ifZqowt7YpFcctlUoGz6
         jURZKhQWRe8/A==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 12 Nov 2023 08:04:18 +0100
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-tegra@vger.kernel.org
Subject: [PATCH] soc/tegra: pmc: Remove some old and deprecated functions and constants
Date:   Sun, 12 Nov 2023 08:04:14 +0100
Message-Id: <9d352be8797f01ffe6193da70e3d9d1e2684c6b4.1699772620.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These TEGRA_IO_RAIL_... functions and constants have been deprecated in
commit 21b499105178 ("soc/tegra: pmc: Add I/O pad voltage support") in
2016-11.

There seems to be no users since kernel 4.16.

Remove them now.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/soc/tegra/pmc.c | 24 ------------------------
 include/soc/tegra/pmc.h | 18 ------------------
 2 files changed, 42 deletions(-)

diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
index f432aa022ace..6dfcc7f50ece 100644
--- a/drivers/soc/tegra/pmc.c
+++ b/drivers/soc/tegra/pmc.c
@@ -1777,30 +1777,6 @@ static int tegra_io_pad_get_voltage(struct tegra_pmc *pmc, enum tegra_io_pad id)
 	return TEGRA_IO_PAD_VOLTAGE_3V3;
 }
 
-/**
- * tegra_io_rail_power_on() - enable power to I/O rail
- * @id: Tegra I/O pad ID for which to enable power
- *
- * See also: tegra_io_pad_power_enable()
- */
-int tegra_io_rail_power_on(unsigned int id)
-{
-	return tegra_io_pad_power_enable(id);
-}
-EXPORT_SYMBOL(tegra_io_rail_power_on);
-
-/**
- * tegra_io_rail_power_off() - disable power to I/O rail
- * @id: Tegra I/O pad ID for which to disable power
- *
- * See also: tegra_io_pad_power_disable()
- */
-int tegra_io_rail_power_off(unsigned int id)
-{
-	return tegra_io_pad_power_disable(id);
-}
-EXPORT_SYMBOL(tegra_io_rail_power_off);
-
 #ifdef CONFIG_PM_SLEEP
 enum tegra_suspend_mode tegra_pmc_get_suspend_mode(void)
 {
diff --git a/include/soc/tegra/pmc.h b/include/soc/tegra/pmc.h
index aadb845d281d..c545875d0ff1 100644
--- a/include/soc/tegra/pmc.h
+++ b/include/soc/tegra/pmc.h
@@ -148,10 +148,6 @@ enum tegra_io_pad {
 	TEGRA_IO_PAD_AO_HV,
 };
 
-/* deprecated, use TEGRA_IO_PAD_{HDMI,LVDS} instead */
-#define TEGRA_IO_RAIL_HDMI	TEGRA_IO_PAD_HDMI
-#define TEGRA_IO_RAIL_LVDS	TEGRA_IO_PAD_LVDS
-
 #ifdef CONFIG_SOC_TEGRA_PMC
 int tegra_powergate_power_on(unsigned int id);
 int tegra_powergate_power_off(unsigned int id);
@@ -164,10 +160,6 @@ int tegra_powergate_sequence_power_up(unsigned int id, struct clk *clk,
 int tegra_io_pad_power_enable(enum tegra_io_pad id);
 int tegra_io_pad_power_disable(enum tegra_io_pad id);
 
-/* deprecated, use tegra_io_pad_power_{enable,disable}() instead */
-int tegra_io_rail_power_on(unsigned int id);
-int tegra_io_rail_power_off(unsigned int id);
-
 void tegra_pmc_set_suspend_mode(enum tegra_suspend_mode mode);
 void tegra_pmc_enter_suspend_mode(enum tegra_suspend_mode mode);
 
@@ -211,16 +203,6 @@ static inline int tegra_io_pad_get_voltage(enum tegra_io_pad id)
 	return -ENOSYS;
 }
 
-static inline int tegra_io_rail_power_on(unsigned int id)
-{
-	return -ENOSYS;
-}
-
-static inline int tegra_io_rail_power_off(unsigned int id)
-{
-	return -ENOSYS;
-}
-
 static inline void tegra_pmc_set_suspend_mode(enum tegra_suspend_mode mode)
 {
 }
-- 
2.34.1

