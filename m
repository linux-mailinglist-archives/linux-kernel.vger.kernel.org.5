Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 874F5804076
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 21:57:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233783AbjLDU4u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 15:56:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235523AbjLDUkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 15:40:37 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0905244AA
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 12:37:27 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2349BC433C9;
        Mon,  4 Dec 2023 20:37:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701722246;
        bh=C2U2qrCynZxI56Zkj6LUzA8sFR5k/ZUF1IMLPjunjXM=;
        h=From:To:Cc:Subject:Date:From;
        b=Bo6GMe3Vv4RGooUoRtbfJ+7m5NxmOezW5RtYbz25Qgc9pR4xNt8TpHA5avxZgnEvL
         tqforuj19WmL8kTBO4y8OP1VV/7S9/DDUm9qkCLTZ+MzLRxbg+dKOfqDOTRpANX1zJ
         P3CLoZjTKoum9xHOwvAzBeHHGVbQIwy3FymTW+R3SD66p2FQTeFPxk6zuN5sCdKZWD
         n+4X+cp1iVrdqd6zLfhOWcOKW7fe/WITh1AJuY9K47ZuEqcFHXRuyqfOvyf8B+aV/Q
         /anQfW8qwV1f57v9y9KLP6GV/u/A7ZcnMh4ULo92zlCjaX9N9jfIBjaGsY/6tSZ580
         VJRZufTV+09rA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Charles Keepax <ckeepax@opensource.cirrus.com>,
        kernel test robot <lkp@intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <sashal@kernel.org>, rf@opensource.cirrus.com,
        alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
        linux-gpio@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 1/3] pinctrl: lochnagar: Don't build on MIPS
Date:   Mon,  4 Dec 2023 15:37:18 -0500
Message-ID: <20231204203723.2094942-1-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.262
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

From: Charles Keepax <ckeepax@opensource.cirrus.com>

[ Upstream commit 6588732445ff19f6183f0fa72ddedf67e5a5be32 ]

MIPS appears to define a RST symbol at a high level, which clashes
with some register naming in the driver. Since there is currently
no case for running this driver on MIPS devices simply cut off the
build of this driver on MIPS.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202311071303.JJMAOjy4-lkp@intel.com/
Suggested-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Link: https://lore.kernel.org/r/20231115162853.1891940-1-ckeepax@opensource.cirrus.com
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pinctrl/cirrus/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/cirrus/Kconfig b/drivers/pinctrl/cirrus/Kconfig
index 530426a74f751..b3cea8d56c4f6 100644
--- a/drivers/pinctrl/cirrus/Kconfig
+++ b/drivers/pinctrl/cirrus/Kconfig
@@ -1,7 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0-only
 config PINCTRL_LOCHNAGAR
 	tristate "Cirrus Logic Lochnagar pinctrl driver"
-	depends on MFD_LOCHNAGAR
+	# Avoid clash caused by MIPS defining RST, which is used in the driver
+	depends on MFD_LOCHNAGAR && !MIPS
 	select GPIOLIB
 	select PINMUX
 	select PINCONF
-- 
2.42.0

