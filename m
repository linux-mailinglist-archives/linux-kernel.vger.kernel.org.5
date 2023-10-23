Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D6C57D35EF
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 13:57:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234508AbjJWL5A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 07:57:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234521AbjJWL44 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 07:56:56 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D43310EB
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 04:56:53 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10AA5C433C7;
        Mon, 23 Oct 2023 11:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698062212;
        bh=bJRfXy2TRIDrKcAouw/75Fhv7CzjeSwcjJuB4GB6vlU=;
        h=From:To:Cc:Subject:Date:From;
        b=Mn5kib3BI3Gy5PE0SXj5IdYJs0wnU7kITW871Jj8vLdJmT2LGr2tOiqQa76DwNmi6
         1XOj9sUw7IYJa3/r0DzX2Co2JHDaw1J4JDlItVZQGRMNLEp/AQ+SpHni+2OCfvX769
         OIBxqx+53J5hl2qsEFPnCdk3L7rp0JFRfPXLjdF7UfXdXptDwyXXcB3biQRAaZuSKT
         Heh7ippAW/AN5okuoG1+BfX/9T8E2qSGCCbtpb3ARSzN3MKbLQG8Uw+9ifgZUB/KCt
         AAx6U0dYzE7zSiPy0x4fITSAHy3lQ4cLcZIbTLy4YhA96634LhF6BdrmHoIy9ZffZe
         +TfNqzT14RhkQ==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Dipen Patel <dipenp@nvidia.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, timestamp@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH] hte: tegra194: add GPIOLIB dependency
Date:   Mon, 23 Oct 2023 13:56:41 +0200
Message-Id: <20231023115646.3573494-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The driver started calling into a few interfaces that are part of GPIOLIB and
don't have stub implementations otherwise:

drivers/hte/hte-tegra194.c: In function 'tegra_hte_line_xlate':
drivers/hte/hte-tegra194.c:424:48: error: implicit declaration of function 'gpio_device_get_base'; did you mean 'gpio_device_get_desc'? [-Werror=implicit-function-declaration]
  424 |                 line_id = desc->attr.line_id - gpio_device_get_base(gs->gdev);
      |                                                ^~~~~~~~~~~~~~~~~~~~
      |                                                gpio_device_get_desc

Add a Kconfig dependency to only allow building when this is defined.

Fixes: dc850faa28ee0 ("hte: tegra194: don't access struct gpio_chip")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/hte/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hte/Kconfig b/drivers/hte/Kconfig
index 083e67492bf2e..641af722b555d 100644
--- a/drivers/hte/Kconfig
+++ b/drivers/hte/Kconfig
@@ -17,6 +17,7 @@ if HTE
 config HTE_TEGRA194
 	tristate "NVIDIA Tegra194 HTE Support"
 	depends on (ARCH_TEGRA_194_SOC || COMPILE_TEST)
+	depends on GPIOLIB
 	help
 	  Enable this option for integrated hardware timestamping engine also
 	  known as generic timestamping engine (GTE) support on NVIDIA Tegra194
-- 
2.39.2

