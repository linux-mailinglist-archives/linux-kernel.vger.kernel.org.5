Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3671C76ACD5
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 11:23:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232859AbjHAJXb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 05:23:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233015AbjHAJXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 05:23:13 -0400
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F21C93C2F;
        Tue,  1 Aug 2023 02:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=BqbBR
        ygnNivDKtJsUxqFpisfRta6pDIOOG6ye7lk4xE=; b=MpTY6n142V6vKTBIQJRG/
        3HZ2o9Xsx00f6C4t0giDfO7HrYY6h094K/yrhV75IFSOpOkOs3RnR8N6obUGHV06
        tArb9kISJ7/BBvGhb2Pvl53jyPlL1aVAaCg4BcOybB0opVi1cfYOpsmLFNyMoal+
        izs/CquROycRewQGAvtx4s=
Received: from localhost.localdomain (unknown [39.144.138.221])
        by zwqz-smtp-mta-g5-2 (Coremail) with SMTP id _____wAHpHClyshkAPmxBw--.34257S2;
        Tue, 01 Aug 2023 17:04:38 +0800 (CST)
From:   xingtong_wu@163.com
To:     hdegoede@redhat.com, markgross@kernel.org,
        andriy.shevchenko@linux.intel.com, xingtong.wu@siemens.com,
        lee@kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     gerd.haeussler.ext@siemens.com, tobias.schaffner@siemens.com,
        kernel test robot <lkp@intel.com>
Subject: [PATCH 1/2] platform/x86/siemens: simatic-ipc: fix logic error in BX-59A
Date:   Tue,  1 Aug 2023 17:04:23 +0800
Message-Id: <20230801090423.4747-1-xingtong_wu@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230731071424.4663-2-xingtong_wu@163.com>
References: <20230731071424.4663-2-xingtong_wu@163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wAHpHClyshkAPmxBw--.34257S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7uw1xWr1Duw48KryxGryxGrg_yoW8GF47pF
        4rG3WIkrW5W34Utwn5Gay7ZFZ8Z3Z8KrW7GFy7AwnrZwnF9F1jqr12ya1fXFW7tr45Way3
        Wa9xtr43Gan8ur7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j61v3UUUUU=
X-Originating-IP: [39.144.138.221]
X-CM-SenderInfo: p0lqw35rqjs4rx6rljoofrz/1tbiTBe+0GI0aQoqpgABsN
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_BL,RCVD_IN_MSPIKE_L4,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "xingtong.wu" <xingtong.wu@siemens.com>

There is a bug in if statement that lead to logical error
and have influence to other IPC, it get correct now.

Fixes: b8af77951941 ("platform/x86/siemens: simatic-ipc: add new models BX-56A/BX-59A")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202307312322.Aa8upHWK-lkp@intel.com/
Signed-off-by: xingtong.wu <xingtong.wu@siemens.com>
---
 drivers/platform/x86/siemens/simatic-ipc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/siemens/simatic-ipc.c b/drivers/platform/x86/siemens/simatic-ipc.c
index 02c540cf4070..8ca6e277fa03 100644
--- a/drivers/platform/x86/siemens/simatic-ipc.c
+++ b/drivers/platform/x86/siemens/simatic-ipc.c
@@ -129,7 +129,7 @@ static int register_platform_devices(u32 station_id)
 		pdevname = KBUILD_MODNAME "_leds";
 		if (ledmode == SIMATIC_IPC_DEVICE_127E)
 			pdevname = KBUILD_MODNAME "_leds_gpio_apollolake";
-		if (ledmode == SIMATIC_IPC_DEVICE_227G || SIMATIC_IPC_DEVICE_BX_59A)
+		if (ledmode == SIMATIC_IPC_DEVICE_227G || ledmode == SIMATIC_IPC_DEVICE_BX_59A)
 			pdevname = KBUILD_MODNAME "_leds_gpio_f7188x";
 		if (ledmode == SIMATIC_IPC_DEVICE_BX_21A)
 			pdevname = KBUILD_MODNAME "_leds_gpio_elkhartlake";
-- 
2.25.1

