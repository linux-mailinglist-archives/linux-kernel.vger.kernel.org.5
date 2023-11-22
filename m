Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65FCD7F4808
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 14:42:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235173AbjKVNmy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 08:42:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235134AbjKVNmq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 08:42:46 -0500
Received: from mx2.securetransport.de (mx2.securetransport.de [188.68.39.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 696B11A5;
        Wed, 22 Nov 2023 05:42:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dh-electronics.com;
        s=dhelectronicscom; t=1700660501;
        bh=YWU5KKna9LF+cw9m3t3tNTIYdzG8MPLSctxria30Q7Q=;
        h=From:To:CC:Subject:Date:From;
        b=xp/xdxvem75my776Lxc2/FpgqkD6OY6JZg/mLbFV/5iX42prIvXoCo81ocDoLPn5K
         dacD5xhLLmyitNIgpSkyAnPt6dNe1/J4VVGUEVqblLLFqiaPiIE9F7fWa7yuqoB3yp
         JBAaeb8AeKqePwlppZGeiEUMT9ON40dBkUJCJ17MTfuTNpES594M4ApxkNbHZaUgco
         QdDXZ2+AJ81T6WpvfVURa+bQtxzMtTUMfpDFpYjTG10p0UuuChupTKcl+8HDVa7aRY
         MOCNw8/HD/MZQ3NYqeOwMAEZxzDM4LwwKca3hnde5/af3uqspAuAqqjQF83g4rDAKR
         S1tQc6ln2/1CA==
From:   Christoph Niedermaier <cniedermaier@dh-electronics.com>
To:     <linux-arm-kernel@lists.infradead.org>
CC:     Christoph Niedermaier <cniedermaier@dh-electronics.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        =?UTF-8?q?S=C3=A9bastien=20Szymanski?= 
        <sebastien.szymanski@armadeus.com>, Stefan Agner <stefan@agner.ch>,
        Shawn Guo <shawnguo@kernel.org>, Marek Vasut <marex@denx.de>,
        Fabio Estevam <festevam@denx.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH V2] cpufreq: imx6q: Only disabling 792MHz OPP for i.MX6ULL types below 792MHz
Date:   Wed, 22 Nov 2023 14:41:13 +0100
Message-ID: <20231122134113.63670-1-cniedermaier@dh-electronics.com>
X-klartext: yes
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For a 900MHz i.MX6ULL CPU the 792MHz OPP is disabled. There is no
convincing reason to disable this OPP. If a CPU can run at 900MHz,
it should also be able to cope with 792MHz. Looking at the voltage
level of 792MHz in [1] (page 24, table 10. "Operating Ranges") the
current defined OPP is above the minimum. So the voltage level
shouldn't be a problem. However in [2] (page 24, table 10.
"Operating Ranges"), it is not mentioned that 792MHz OPP isn't
allowed. Change it to only disable 792MHz OPP for i.MX6ULL types
below 792 MHz.

[1] https://www.nxp.com/docs/en/data-sheet/IMX6ULLIEC.pdf
[2] https://www.nxp.com/docs/en/data-sheet/IMX6ULLCEC.pdf

Fixes: 0aa9abd4c212 ("cpufreq: imx6q: check speed grades for i.MX6ULL")
Signed-off-by: Christoph Niedermaier <cniedermaier@dh-electronics.com>
Reviewed-by: Marek Vasut <marex@denx.de>
Reviewed-by: Fabio Estevam <festevam@denx.de>
---
V2: - Improve the commit message
    - Add Fixes tag
    - Add Reviewed-by tag
---
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Sébastien Szymanski <sebastien.szymanski@armadeus.com>
Cc: Stefan Agner <stefan@agner.ch>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Marek Vasut <marex@denx.de>
Cc: Fabio Estevam <festevam@denx.de>
Cc: NXP Linux Team <linux-imx@nxp.com>
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
---
 drivers/cpufreq/imx6q-cpufreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/imx6q-cpufreq.c b/drivers/cpufreq/imx6q-cpufreq.c
index 494d044b9e72..33728c242f66 100644
--- a/drivers/cpufreq/imx6q-cpufreq.c
+++ b/drivers/cpufreq/imx6q-cpufreq.c
@@ -327,7 +327,7 @@ static int imx6ul_opp_check_speed_grading(struct device *dev)
 			imx6x_disable_freq_in_opp(dev, 696000000);
 
 	if (of_machine_is_compatible("fsl,imx6ull")) {
-		if (val != OCOTP_CFG3_6ULL_SPEED_792MHZ)
+		if (val < OCOTP_CFG3_6ULL_SPEED_792MHZ)
 			imx6x_disable_freq_in_opp(dev, 792000000);
 
 		if (val != OCOTP_CFG3_6ULL_SPEED_900MHZ)
-- 
2.11.0

