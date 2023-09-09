Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B297B7993D3
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 02:38:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345808AbjIIAid (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 20:38:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345673AbjIIAiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 20:38:07 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4C7326A6;
        Fri,  8 Sep 2023 17:37:42 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15C70C43140;
        Sat,  9 Sep 2023 00:36:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694219805;
        bh=gH5RnOU3S/zIDKWxNrKo/0R6An1UDhmtPV1y8wIs4p4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NuHzW2BXwjYP/5ExZ2tAOict/a1gr0Q1DxtQUNRYrFxy5NLitps5aJT8SJO1N92ST
         JC/KfhHtHEFvhYkrKMLQxpegYx3VoQoxRJFu4dOjYT4Dhxj273wc/iU/gqvwrSmcK4
         f6hp467X3OXZBYOpGRC8KCxjU1O/duk4iwm+cg4siMJ5M5G6nI2KMpvENkXv00b2pI
         +NKurwU79pA4VxDCOmfJgG992TVsxwhNxWQRlk3O4gmUaFZOgr2VtaWRh/asREFhuV
         fmdTnHvbASOkxWufVvv5feTs6OEpInZx2tsvuLfcaqAICHEpXvfVEDJ95yWH5wtSPb
         fZBeDpKwXE4tA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ladislav Michl <ladis@linux-mips.org>,
        Linux Kernel Functional Testing <lkft@linaro.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, tsbogend@alpha.franken.de,
        linux-mips@vger.kernel.org
Subject: [PATCH AUTOSEL 6.5 20/28] usb: dwc3: dwc3-octeon: Verify clock divider
Date:   Fri,  8 Sep 2023 20:35:54 -0400
Message-Id: <20230909003604.3579407-20-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230909003604.3579407-1-sashal@kernel.org>
References: <20230909003604.3579407-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.5.2
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ladislav Michl <ladis@linux-mips.org>

[ Upstream commit fb57f829beefd4b3746f1b23d51e80ed5d4bb87b ]

Although valid USB clock divider will be calculated for all valid
Octeon core frequencies, make code formally correct limiting
divider not to be greater that 7 so it fits into H_CLKDIV_SEL
field.

Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
Closes: https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20230808/testrun/18882876/suite/build/test/gcc-8-cavium_octeon_defconfig/log
Acked-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Link: https://lore.kernel.org/r/ZNIM7tlBNdHFzXZG@lenoch
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/mips/cavium-octeon/octeon-usb.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/mips/cavium-octeon/octeon-usb.c b/arch/mips/cavium-octeon/octeon-usb.c
index 2add435ad0387..165e032d08647 100644
--- a/arch/mips/cavium-octeon/octeon-usb.c
+++ b/arch/mips/cavium-octeon/octeon-usb.c
@@ -243,11 +243,11 @@ static int dwc3_octeon_get_divider(void)
 	while (div < ARRAY_SIZE(clk_div)) {
 		uint64_t rate = octeon_get_io_clock_rate() / clk_div[div];
 		if (rate <= 300000000 && rate >= 150000000)
-			break;
+			return div;
 		div++;
 	}
 
-	return div;
+	return -EINVAL;
 }
 
 static int dwc3_octeon_config_power(struct device *dev, void __iomem *base)
@@ -374,6 +374,10 @@ static int dwc3_octeon_clocks_start(struct device *dev, void __iomem *base)
 
 	/* Step 4b: Select controller clock frequency. */
 	div = dwc3_octeon_get_divider();
+	if (div < 0) {
+		dev_err(dev, "clock divider invalid\n");
+		return div;
+	}
 	val = dwc3_octeon_readq(uctl_ctl_reg);
 	val &= ~USBDRD_UCTL_CTL_H_CLKDIV_SEL;
 	val |= FIELD_PREP(USBDRD_UCTL_CTL_H_CLKDIV_SEL, div);
-- 
2.40.1

