Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2820D78BB1A
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 00:43:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234048AbjH1Wmq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 18:42:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234199AbjH1WmM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 18:42:12 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B465139;
        Mon, 28 Aug 2023 15:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=4eigGUxrdrCpyRfsWK1n2HYd03nY5w2QFJ6Q65waFT8=; b=jgzXEIMZURpG6S4DHt2vqrnTNM
        pGlfKDW+1h2m9u6eyNOv8Mk50DZsGdxLF/U3vddCQnXAH70ulEMgROJeDM9mUB0LPehkVMAhnvjlL
        M3LaOspUTBE26pLxeOOBMR21x5/LhUDVz2NWR2K5ERknMS/z/DFyUitsRFNOpzS+ZUWwy561nqecj
        E3NH48WTF+oK1m41SAJ7ky1AGc0AovisxACq7YTJPexxpag6sh78mbIAep5cxE1ITV4qK8bGisDAc
        7x6xoIBiy+fA3qjgjo3nKHUdIv+QGOWnimvFFl7bvNI9ZwTp9a9mc+i1EzQMXtu/KwISzSM3KjRX/
        aitDSMJQ==;
Received: from c-71-59-149-187.hsd1.or.comcast.net ([71.59.149.187] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qakvv-00AOCT-2L;
        Mon, 28 Aug 2023 22:42:07 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Jakob Hauser <jahau@rocketmail.com>,
        Sebastian Reichel <sre@kernel.org>, Lee Jones <lee@kernel.org>,
        linux-pm@vger.kernel.org
Subject: [PATCH] power: supply: rt5033_charger: recognize EXTCON setting
Date:   Mon, 28 Aug 2023 15:42:01 -0700
Message-ID: <20230828224201.26823-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CHARGER_RT5033 should honor the EXTCON setting to prevent these
build errors:

riscv64-linux-ld: drivers/power/supply/rt5033_charger.o: in function `.L33':
rt5033_charger.c:(.text.rt5033_charger_probe+0x578): undefined reference to `extcon_find_edev_by_node'
riscv64-linux-ld: drivers/power/supply/rt5033_charger.o: in function `.L0 ':
rt5033_charger.c:(.text.rt5033_charger_probe+0x64e): undefined reference to `devm_extcon_register_notifier_all'
riscv64-linux-ld: drivers/power/supply/rt5033_charger.o: in function `.L96':
rt5033_charger.c:(.text.rt5033_charger_extcon_work+0x32): undefined reference to `extcon_get_state'

Fixes: 12cc585f36b8 ("power: supply: rt5033_charger: Add cable detection and USB OTG supply")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jakob Hauser <jahau@rocketmail.com>
Cc: Sebastian Reichel <sre@kernel.org>
Cc: Lee Jones <lee@kernel.org>
Cc: linux-pm@vger.kernel.org
---
 drivers/power/supply/Kconfig |    1 +
 1 file changed, 1 insertion(+)

diff -- a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
--- a/drivers/power/supply/Kconfig
+++ b/drivers/power/supply/Kconfig
@@ -769,6 +769,7 @@ config BATTERY_RT5033
 config CHARGER_RT5033
 	tristate "RT5033 battery charger support"
 	depends on MFD_RT5033
+	depends on EXTCON || !EXTCON
 	help
 	  This adds support for battery charger in Richtek RT5033 PMIC.
 	  The device supports pre-charge mode, fast charge mode and
