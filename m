Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E6247BEC98
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 23:15:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378765AbjJIVPu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 17:15:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378682AbjJIVPN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 17:15:13 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4CA4D62;
        Mon,  9 Oct 2023 14:14:40 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C301C433C7;
        Mon,  9 Oct 2023 21:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696886080;
        bh=pRTsya/t7TdWrezPtSMk6IUt3fMvEjFpaEopjd4gbVI=;
        h=From:To:Cc:Subject:Date:From;
        b=o6sICD0Dp8hm9by3EoXOmN7rZyOxzy41mzWWZeA2edPwQKT4Z4j6XD/A4HeeLJ6vz
         lyn5Iv+WTYGaD3Cfvxl7or7KTR1OYRWCj/43eohEq8mCmXybQYcJ2l/qacVv9r7lw9
         6z7i3jOEbPWAgfT+VupGMt7hbz+o81sKpe7rr1lR/H1jujYnWjz7v5ldFMVt/9QwuD
         kh7L2NISfOSQ8WIkLOC6pEm2hc3WWoGMl9OjofWsTfD/lmLodu+ZoC63or6+IsxrAa
         nq+kC1GriFqr7nDM5vWByChxsWqzTD0rCqzyG3WwuJhNSvFs7ctF9W+l6bV8ca/GeP
         ICeXprpD6LE4g==
Received: (nullmailer pid 3246318 invoked by uid 1000);
        Mon, 09 Oct 2023 21:14:14 -0000
From:   Rob Herring <robh@kernel.org>
To:     Alain Volmat <alain.volmat@foss.st.com>,
        Mark Brown <broonie@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc:     linux-spi@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] spi: stm32: Explicitly include correct DT includes
Date:   Mon,  9 Oct 2023 16:13:44 -0500
Message-ID: <20231009211356.3242037-14-robh@kernel.org>
X-Mailer: git-send-email 2.42.0
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

The DT of_device.h and of_platform.h date back to the separate
of_platform_bus_type before it as merged into the regular platform bus.
As part of that merge prepping Arm DT support 13 years ago, they
"temporarily" include each other. They also include platform_device.h
and of.h. As a result, there's a pretty much random mix of those include
files used throughout the tree. In order to detangle these headers and
replace the implicit includes with struct declarations, users need to
explicitly include the correct includes.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/spi/spi-stm32.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-stm32.c b/drivers/spi/spi-stm32.c
index ef665f470c5b..e6e3e4ea29f9 100644
--- a/drivers/spi/spi-stm32.c
+++ b/drivers/spi/spi-stm32.c
@@ -13,7 +13,8 @@
 #include <linux/interrupt.h>
 #include <linux/iopoll.h>
 #include <linux/module.h>
-#include <linux/of_platform.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
 #include <linux/pinctrl/consumer.h>
 #include <linux/pm_runtime.h>
 #include <linux/reset.h>
-- 
2.42.0

