Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB43B7C7944
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 00:09:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443006AbjJLWJC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 18:09:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235779AbjJLWJA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 18:09:00 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0023C9;
        Thu, 12 Oct 2023 15:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=dDElEQ/Hy78MZ6C3DN/kz0Nu3cGEbr0+ql35LbBENLU=; b=ZMjjYL+r3FfiVDPiMZmbEY8weu
        1M94xpXvKXTYtiPrzuoRtAl23GOobOiaK/R4kbcIfvbYCdhWI8gDH+VYEE9NXNqVosGV+FX8F+y+G
        KqpwXqxZG7zHOM1BuvN9/mHEVELa7gzBB1bLGmri9xucJQ078ETChmo2WkLvsmsPmEhrIsmbkEuWh
        e3ip3AjtGuNpBKbDdw71WZYvSsMS8Q4W/JflV7EPy8u7Seac+rOY05vV8CM+ets5MQjmT/684U/Ef
        kmVQ7re8m/0dVBPjRi8W7qiDmXxqoic1iiMmLpR66slohnV3e7xSoLwPG2G7wSiDVZUsXCSiGZuMs
        0Nb50CrQ==;
Received: from [50.53.46.231] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qr3rW-001xf1-2O;
        Thu, 12 Oct 2023 22:08:58 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        =?UTF-8?q?Michael=20B=C3=BCsch?= <m@bues.ch>,
        linux-wireless@vger.kernel.org, Kalle Valo <kvalo@kernel.org>
Subject: [PATCH] ssb: relax SSB_EMBEDDED dependencies
Date:   Thu, 12 Oct 2023 15:08:55 -0700
Message-ID: <20231012220856.23260-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a kconfig warning in a randconfig when CONFIG_PCI is not set:

WARNING: unmet direct dependencies detected for SSB_EMBEDDED
  Depends on [n]: SSB [=y] && SSB_DRIVER_MIPS [=y] && SSB_PCICORE_HOSTMODE [=n]
  Selected by [y]:
  - BCM47XX_SSB [=y] && BCM47XX [=y]

This is caused by arch/mips/bcm47xx/Kconfig's symbol BCM47XX_SSB
selecting SSB_EMBEDDED when CONFIG_PCI is not set.

This warning can be prevented by altering SSB_EMBEDDED to allow for
PCI=n or the former SSB_PCICORE_HOSTMODE.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Acked-by: Michael Büsch <m@bues.ch>
Cc: linux-wireless@vger.kernel.org
Cc: Kalle Valo <kvalo@kernel.org>
---
 drivers/ssb/Kconfig |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff -- a/drivers/ssb/Kconfig b/drivers/ssb/Kconfig
--- a/drivers/ssb/Kconfig
+++ b/drivers/ssb/Kconfig
@@ -134,7 +134,8 @@ config SSB_SFLASH
 # Assumption: We are on embedded, if we compile the MIPS core.
 config SSB_EMBEDDED
 	bool
-	depends on SSB_DRIVER_MIPS && SSB_PCICORE_HOSTMODE
+	depends on SSB_DRIVER_MIPS
+	depends on PCI=n || SSB_PCICORE_HOSTMODE
 	default y
 
 config SSB_DRIVER_EXTIF
