Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD717759738
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 15:41:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231411AbjGSNlL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 09:41:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbjGSNlJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 09:41:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7CAC123;
        Wed, 19 Jul 2023 06:41:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 49534611F9;
        Wed, 19 Jul 2023 13:41:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE736C433C8;
        Wed, 19 Jul 2023 13:41:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689774065;
        bh=YpVuGS+XXj+XzM8fY0/kAiTwEqae+AhksShMdzrc8r4=;
        h=From:To:Cc:Subject:Date:From;
        b=MfiEDZEBK5hXflZjq/HIOOMaIpOQriAU8van/W1YiJsG1kscjFwtYkaGu+lT49yqe
         qhjeTm9ACyLED08v4alO1R0YAqXg3xoFznJIrEE1zlBa8g7lsuj71vhOmabf5h5PvC
         l2CrLNgKt0Juh3j4Kb1g8UTTTkce11VVjGdg6HUC2PNxAWPeYmaoQfn8ti5el0CsAL
         MAyf+GFoP88xOrFViWsk4LvhQFRHDU8fWEnegmoICo8AhjcwsErWeoVAwANdfxugx2
         t47EZI6xto8Cf4Y4s3fFmvFZSUvL3hRAhJrS8X3pGjT5q/V8TNS9F1k8IViha25HXD
         qOZE7Tf+V/ATQ==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        "David S . Miller" <davem@davemloft.net>,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] rtc: bq4802: add sparc dependency
Date:   Wed, 19 Jul 2023 15:40:35 +0200
Message-Id: <20230719134058.2138934-1-arnd@kernel.org>
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
 drivers/rtc/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index 05f4b2d66290d..99e674d34823b 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -1195,7 +1195,7 @@ config RTC_DRV_MSM6242
 
 config RTC_DRV_BQ4802
 	tristate "TI BQ4802"
-	depends on HAS_IOMEM && HAS_IOPORT
+	depends on SPARC || (HAS_IOMEM && HAS_IOPORT && COMPILE_TEST)
 	help
 	  If you say Y here you will get support for the TI
 	  BQ4802 RTC chip.
-- 
2.39.2

