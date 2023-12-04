Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 646D3803F65
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 21:33:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345805AbjLDUd3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 15:33:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345779AbjLDUdW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 15:33:22 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67884111
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 12:33:28 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0E0DC43391;
        Mon,  4 Dec 2023 20:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701722008;
        bh=jl9mkb3+8I4qmhnlzh34M7GhRZZUr41HM/ua32/te84=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fpm/RZDv1oxz2nwwbBAtu2ZUxFgTMQeW696xFxP6L84YuDYJX7qnqq45UTLM8m/Lo
         IyFNGNk2+u1A6LRA7pEG1u2vaRSd/7tmwxOWJYOYFQAw8TODiJCZSdAsFK48ISEFM3
         /k5bCmsWMOK5VAIRBAeMOIQgiaL7ScuNSqtjnsJ1J8D3MWmPaLr67LY3NKVbQug8gL
         RIbAo2BkNwfnhgZLDO7GMBUn9m2ZjbgQtYXGiPwcK65zBhQyfuIv/+fPFMNqAk2EpV
         Nzt+ui63sNRJOg4FIASqdS9ZqhzKpsq9OslnnBTbnFXR7MZO1EkSX9uBsPOjG3H5vB
         mBN0CsTUSFZeg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Charles Keepax <ckeepax@opensource.cirrus.com>,
        kernel test robot <lkp@intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <sashal@kernel.org>, rf@opensource.cirrus.com,
        alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
        linux-gpio@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 04/32] pinctrl: lochnagar: Don't build on MIPS
Date:   Mon,  4 Dec 2023 15:32:24 -0500
Message-ID: <20231204203317.2092321-4-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231204203317.2092321-1-sashal@kernel.org>
References: <20231204203317.2092321-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.4
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
index d6318cb57aff2..e7e827a8877a0 100644
--- a/drivers/pinctrl/cirrus/Kconfig
+++ b/drivers/pinctrl/cirrus/Kconfig
@@ -12,7 +12,8 @@ config PINCTRL_CS42L43
 
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

