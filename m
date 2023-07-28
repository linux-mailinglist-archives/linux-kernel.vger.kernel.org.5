Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25B12766AC0
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 12:34:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235227AbjG1KeL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 06:34:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235728AbjG1Kct (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 06:32:49 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8A7A59CB;
        Fri, 28 Jul 2023 03:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1690540260; x=1722076260;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=B/7MgzJUa31uT0LBQyycRu4Ocmuodf4u+DRY2fOJfW4=;
  b=h3wUSo6oguB8KHKqyOok9E8XVD6cjzLCrLPqNYua0JxzXiw9MJbZUQEy
   lZkf48rJo+GYfgIggAQxv9I66mBrf9DxaNfYCXVPU6p8L8d5PRU0P/iD4
   /Q0m9ZvTt+rAn855g+nqDe/sh142t0hVP0BmSY8zmPwlL3xoCKU6Ur4XO
   HxIS6UBMJp4jNftuhaWjV0xrS9q5vy2aiCVNKhYYnUmw5l0Y9URxYgyGE
   A5DAox49pYaLXz9IeSIeVY2kpEGNWQ0FNmjmYVf8LQNzCwoFwZxJC8dPA
   eXRANnauf7vd+nObAPaeBXHGQwg/BIr4uVx0RNe6k6Du7RWV6cirfkx87
   Q==;
X-IronPort-AV: E=Sophos;i="6.01,237,1684825200"; 
   d="scan'208";a="226623595"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 28 Jul 2023 03:30:40 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 28 Jul 2023 03:30:31 -0700
Received: from che-lt-i67070.amer.actel.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Fri, 28 Jul 2023 03:30:29 -0700
From:   Varshini Rajendran <varshini.rajendran@microchip.com>
To:     <sre@kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <varshini.rajendran@microchip.com>
Subject: [PATCH v3 44/50] power: reset: at91-reset: add reset support for sam9x7 SoC
Date:   Fri, 28 Jul 2023 16:00:23 +0530
Message-ID: <20230728103023.267539-1-varshini.rajendran@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add power reset support for SAM9X7 SoC.

Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
---
 drivers/power/reset/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
index fff07b2bd77b..518b232bfd3d 100644
--- a/drivers/power/reset/Kconfig
+++ b/drivers/power/reset/Kconfig
@@ -26,7 +26,7 @@ config POWER_RESET_AT91_POWEROFF
 config POWER_RESET_AT91_RESET
 	tristate "Atmel AT91 reset driver"
 	depends on ARCH_AT91
-	default SOC_AT91SAM9 || SOC_SAM9X60 || SOC_SAMA5
+	default SOC_AT91SAM9 || SOC_SAM9X60 || SOC_SAM9X7 || SOC_SAMA5
 	help
 	  This driver supports restart for Atmel AT91SAM9 and SAMA5
 	  SoCs
-- 
2.25.1

