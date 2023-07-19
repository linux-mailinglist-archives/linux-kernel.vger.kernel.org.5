Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E60F759E94
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 21:29:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231205AbjGST3C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 15:29:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229983AbjGST25 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 15:28:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 566271FCE;
        Wed, 19 Jul 2023 12:28:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DB779617F1;
        Wed, 19 Jul 2023 19:28:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72726C433C7;
        Wed, 19 Jul 2023 19:28:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689794920;
        bh=zbxMRwTgeG6WFkUycHaElwJs5J+MEQiEIcUpoBceR5Q=;
        h=From:To:Cc:Subject:Date:From;
        b=QW/X/Z/vmVffdAOE0IfBG1FBho+tAilMUuPSyQtly70Dj0EQbZarA9R5+ogrzjPkq
         FrJCvDh1MDfT+FYemfL37XYY6eRSFSM/8N0xnS8sFvi4xshg+0A7bAa2rWeuGC3GNS
         3jS9abVHxssmOTq2OfYL+7nDkEOefUBWvXBs8y0DWzeSGvPZ1zbIkZgN022pUjor9L
         QxXeLotFFE8TbBohn14NYyaM0IXCGGBBd28VYvKHLZ1bXe0yaJic9+k5o/9F6CbDkK
         UlVYCmT7BthFS8Yx1c8GdvX/mkqzYx4a38Dx61wKaxQoYmdw+F25f/IeJsgiwF+3OC
         XxCdzFvf3f0eg==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        "David S . Miller" <davem@davemloft.net>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] [v2] rtc: bq4802: add sparc dependency
Date:   Wed, 19 Jul 2023 21:28:18 +0200
Message-Id: <20230719192835.1025406-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
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

From: Arnd Bergmann <arnd@arndb.de>

The added HAS_IOPORT dependency might not actually be necessary as Geert
points out, but the driver is also only used on one architecture. Sparc
is also a special case here since it converts port numbers into virtual
addresses rather than having them mapped into a particular part of the
__iomem address space, so the difference is actually not important here.

Add a dependency on sparc, but allow compile-testing otherwise, to
make this clearer without anyone having to spend much time modernizing
the driver beyond that.

Reported-by: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: David S. Miller <davem@davemloft.net>
Link: https://lore.kernel.org/all/CAMuHMdWEx0F=fNei4Bz_JPkuvoaN-+zk08h0i8KnSi_VjO615g@mail.gmail.com/
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
v2: split dependency into two lines, as suggested by Geert
---
 drivers/rtc/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index 05f4b2d66290d..19c3eac474f7c 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -1196,6 +1196,7 @@ config RTC_DRV_MSM6242
 config RTC_DRV_BQ4802
 	tristate "TI BQ4802"
 	depends on HAS_IOMEM && HAS_IOPORT
+	depends on SPARC || COMPILE_TEST
 	help
 	  If you say Y here you will get support for the TI
 	  BQ4802 RTC chip.
-- 
2.39.2

