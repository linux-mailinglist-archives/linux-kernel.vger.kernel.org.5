Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF5E27525F7
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 17:01:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231254AbjGMPBq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 11:01:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232422AbjGMPB1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 11:01:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DDCF2706;
        Thu, 13 Jul 2023 08:01:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5D247618C5;
        Thu, 13 Jul 2023 15:01:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99DE6C433C9;
        Thu, 13 Jul 2023 15:01:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689260484;
        bh=sfmiO7castT7ell5jqLJUhNTWtiJ35JhwDwk7KkRsoA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NelBhBDYU1VCxkGX+R4lWxNyD6GFU7dn8CYivAJvkjrp/4IbkoEXJT1Izk7xFLer6
         XWQKXcUa4TxULl3Asd88+ui4GPlflFcszX8oc/7YRkqc6I+YfVmje20ShgrRI36udW
         4thM3nbKxciLFpFegF9ryWOETfAwqzzLLKvwgUiZr0O+UmRXIGikFkSc/t0XYKFUjZ
         ZDvn2gwJJy2JikDj4e84VBfyEoKwQXTk/5dXe7cO+YbIeg8bxs8SYLpsq9IPPE/H9K
         CZ9j8s7Y7yoEw/JGVhqpecmvDo1vWOwe/HMZK7yNbyduZUoisVPPdQwEC9auC2awe0
         jPbmfm79S692w==
Received: from johan by xi.lan with local (Exim 4.96)
        (envelope-from <johan+linaro@kernel.org>)
        id 1qJxor-0007vo-0y;
        Thu, 13 Jul 2023 17:01:25 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Tony Lindgren <tony@atomide.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-serial@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>, stable@vger.kernel.org,
        Matthias Kaehlcke <mka@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>
Subject: [PATCH 3/3] serial: qcom-geni: drop bogus runtime pm state update
Date:   Thu, 13 Jul 2023 16:57:41 +0200
Message-ID: <20230713145741.30390-4-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230713145741.30390-1-johan+linaro@kernel.org>
References: <20230713145741.30390-1-johan+linaro@kernel.org>
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

The runtime PM state should not be changed by drivers that do not
implement runtime PM even if it happens to work around a bug in PM core.

With the wake irq arming now fixed, drop the bogus runtime PM state
update which left the device in active state (and could potentially
prevent a parent device from suspending).

Fixes: f3974413cf02 ("tty: serial: qcom_geni_serial: Wakeup IRQ cleanup")
Cc: stable@vger.kernel.org      # 5.6
Cc: Matthias Kaehlcke <mka@chromium.org>
Cc: Stephen Boyd <swboyd@chromium.org>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/tty/serial/qcom_geni_serial.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index 88ed5bbe25a8..b825b05e6137 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -1681,13 +1681,6 @@ static int qcom_geni_serial_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	/*
-	 * Set pm_runtime status as ACTIVE so that wakeup_irq gets
-	 * enabled/disabled from dev_pm_arm_wake_irq during system
-	 * suspend/resume respectively.
-	 */
-	pm_runtime_set_active(&pdev->dev);
-
 	if (port->wakeup_irq > 0) {
 		device_init_wakeup(&pdev->dev, true);
 		ret = dev_pm_set_dedicated_wake_irq(&pdev->dev,
-- 
2.41.0

