Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB9A779F5CE
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 02:05:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233285AbjINAF1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 20:05:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbjINAFZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 20:05:25 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC302E6A;
        Wed, 13 Sep 2023 17:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=ru4tgUXmNV0z0CNxeAwewwnktolUzJXXBFTYWbp6120=; b=CBnac8ezMmvKD2BY8KS5Y7mhVS
        XSmAkMgQobLem2gVa997F59XbtM/3WRYqONnoGEhwq6I+h0NEi39djQ3bQxAhQD/ufETRP43ghrym
        EjV+7mVT3PwkpTCshsCoA0bEDkyI6zeow6URcDI277wGvXCEL7Trd7Zd2jVL9C0LwykYwcq+myUpC
        U3rTlEO0BcdzSqG7Pvz9PxAiWpy2MPvjygbNCZrZ6mftlYTQw4OhB3vrkNkJX7LOt+2RJD99SI/VZ
        BOuPffSrYXUV+gjt8lDtcUygoWBDl0vtnsz6oVCSRz6KJ+1QelbWWa3xiT+4sHzTcvI3OGTtKmTB4
        Y/E0i8QQ==;
Received: from [2601:1c2:980:9ec0::9fed] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qgZrE-006vlO-37;
        Thu, 14 Sep 2023 00:05:21 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Rahul Rameshbabu <rrameshbabu@nvidia.com>,
        Jiri Kosina <jkosina@suse.cz>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org
Subject: [PATCH] HID: nvidia-shield: add LEDS_CLASS dependency
Date:   Wed, 13 Sep 2023 17:05:17 -0700
Message-ID: <20230914000517.16252-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The hid-nvidia-shield driver uses functions that are built
only when LEDS_CLASS is set, so make the driver depend on that
symbol to prevent build errors.

riscv32-linux-ld: drivers/hid/hid-nvidia-shield.o: in function `.L11':
hid-nvidia-shield.c:(.text+0x192): undefined reference to `led_classdev_unregister'
riscv32-linux-ld: drivers/hid/hid-nvidia-shield.o: in function `.L113':
hid-nvidia-shield.c:(.text+0xfa4): undefined reference to `led_classdev_register_ext'

Fixes: 09308562d4af ("HID: nvidia-shield: Initial driver implementation with Thunderstrike support")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Cc: Jiri Kosina <jkosina@suse.cz>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: linux-input@vger.kernel.org
---
 drivers/hid/Kconfig |    1 +
 1 file changed, 1 insertion(+)

diff -- a/drivers/hid/Kconfig b/drivers/hid/Kconfig
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -799,6 +799,7 @@ config HID_NVIDIA_SHIELD
 	tristate "NVIDIA SHIELD devices"
 	depends on USB_HID
 	depends on BT_HIDP
+	depends on LEDS_CLASS
 	help
 	  Support for NVIDIA SHIELD accessories.
 
