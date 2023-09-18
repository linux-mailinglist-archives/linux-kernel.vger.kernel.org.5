Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A3127A54A9
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 22:58:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230283AbjIRU6u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 16:58:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230264AbjIRU6i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 16:58:38 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27741126;
        Mon, 18 Sep 2023 13:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=E+y6i7Uy3ptI05N3BdEAal9Zna1e1py5vdDPokjWDf0=; b=MPSRdH5cuQwBb2HKMH1EW3ROFG
        DiEUEwpKkRIDsszmJCSZxx+BVpQkkbks8NhPN3rLQFjk3kHI7n0G0Ug4kRXIdtsSFgs71YWYwdjm6
        +KeUOpbEoxE4Ny9Addv56f7H/vGLxCLPnxuJCusBgMQFsHDrpTt0h/qRxhZLnVgkkakkWw242mdYC
        ieLV3HTX8iTkm0c4aC4jC4uism9GuXJcmLkt3O+hZe9tNwLv0lDeV5Gg8Wj0hokYcdvA0vdufXjiM
        Q1iSeEW+EkZnKZ9nOiCM/JJeSvoR2JT1xTy1W1d2EajQI3vWFhX1YRCHum7GHiEGKRQkBgZ1Pz8il
        EMI6ncVw==;
Received: from [2601:1c2:980:9ec0::9fed] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qiLK6-00GLLs-0j;
        Mon, 18 Sep 2023 20:58:26 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Nikita Travkin <nikita@trvn.ru>,
        Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org
Subject: [PATCH] power: supply: pm8916_lbc: observe EXTCON config setting
Date:   Mon, 18 Sep 2023 13:58:25 -0700
Message-ID: <20230918205825.25864-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.42.0
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

When CONFIG_EXTCON=m and CONFIG_CHARGER_PM8916_LBC=y, there are
build errors. Fix them by having CHARGER_PM8916_LBC depend on the
setting of EXTCON.

aarch64-linux-ld: drivers/power/supply/pm8916_lbc.o: in function `pm8916_lbc_charger_state_changed_irq':
pm8916_lbc.c:(.text+0xe8): undefined reference to `extcon_set_state_sync'
aarch64-linux-ld: drivers/power/supply/pm8916_lbc.o: in function `pm8916_lbc_charger_probe':
pm8916_lbc.c:(.text+0x638): undefined reference to `devm_extcon_dev_allocate'
aarch64-linux-ld: pm8916_lbc.c:(.text+0x650): undefined reference to `devm_extcon_dev_register'
aarch64-linux-ld: pm8916_lbc.c:(.text+0x688): undefined reference to `extcon_set_state_sync'

Fixes: f8d7a3d21160 ("power: supply: Add driver for pm8916 lbc")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Nikita Travkin <nikita@trvn.ru>
Cc: Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org
---
 drivers/power/supply/Kconfig |    1 +
 1 file changed, 1 insertion(+)

diff -- a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
--- a/drivers/power/supply/Kconfig
+++ b/drivers/power/supply/Kconfig
@@ -643,6 +643,7 @@ config BATTERY_PM8916_BMS_VM
 config CHARGER_PM8916_LBC
 	tristate "Qualcomm PM8916 Linear Battery Charger support"
 	depends on MFD_SPMI_PMIC || COMPILE_TEST
+	depends on EXTCON || !EXTCON
 	help
 	  Say Y here to add support for Linear Battery Charger block
 	  found in some Qualcomm PMICs such as PM8916. This hardware
