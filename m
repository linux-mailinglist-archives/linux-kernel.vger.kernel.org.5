Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49AB476AFFE
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 11:54:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232707AbjHAJyW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 05:54:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232249AbjHAJyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 05:54:20 -0400
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.215])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AF898BE;
        Tue,  1 Aug 2023 02:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=BQfXO
        CjZPrtRckyFX59tE8t/r09gbeMjp4tsbkFXRoA=; b=aJmyFCeU4s3ty/kyWq5+A
        fBbOzQwFswh9Tk+S8s2IEu/pY5qgOBdnECEVdZ3khAo7JfWHEQLBhovvJS6AYvdZ
        AZej76aK71UzFaXq6+OobHoVouAqsgCSG9PKSDcTB5GppAQYzEywykf4RI+tVkM8
        TbnkYcTw74vLpuF7dxH76Q=
Received: from localhost.localdomain (unknown [39.144.138.221])
        by zwqz-smtp-mta-g2-4 (Coremail) with SMTP id _____wAnrPhDy8hkKJqFBw--.35093S2;
        Tue, 01 Aug 2023 17:07:17 +0800 (CST)
From:   xingtong_wu@163.com
To:     hdegoede@redhat.com, markgross@kernel.org, xingtong.wu@siemens.com,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     gerd.haeussler.ext@siemens.com, tobias.schaffner@siemens.com,
        kernel test robot <lkp@intel.com>
Subject: [PATCH 2/2] platform/x86/siemens: simatic-ipc-batt: fix logic error for BX-59A
Date:   Tue,  1 Aug 2023 17:07:12 +0800
Message-Id: <20230801090712.4856-1-xingtong_wu@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230731072148.4781-1-xingtong_wu@163.com>
References: <20230731072148.4781-1-xingtong_wu@163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wAnrPhDy8hkKJqFBw--.35093S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7uw1xWr45KF13ZrW7tw4xWFg_yoW8GF1fpF
        4rAa10kFW5Ww4YywsrGay7ZF45Za13KrW7GFyqyw13Z3sFv3Wftr1fAa13ZrsIyr45Way5
        JF93trW3Ca1DZFUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jhPEfUUUUU=
X-Originating-IP: [39.144.138.221]
X-CM-SenderInfo: p0lqw35rqjs4rx6rljoofrz/1tbiTBe+0GI0aQoqpgACsO
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_BL,RCVD_IN_MSPIKE_L4,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "xingtong.wu" <xingtong.wu@siemens.com>

There is a bug in if statement that lead to logical error
and have influence to other IPC, it get correct now.

Fixes: c56beff20375 ("platform/x86/siemens: simatic-ipc-batt: add support for module BX-59A")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202308010001.BGYCSQrl-lkp@intel.com/
Signed-off-by: xingtong.wu <xingtong.wu@siemens.com>
---
 drivers/platform/x86/siemens/simatic-ipc-batt.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/siemens/simatic-ipc-batt.c b/drivers/platform/x86/siemens/simatic-ipc-batt.c
index d66b9969234b..e6c12c52843c 100644
--- a/drivers/platform/x86/siemens/simatic-ipc-batt.c
+++ b/drivers/platform/x86/siemens/simatic-ipc-batt.c
@@ -194,7 +194,8 @@ int simatic_ipc_batt_probe(struct platform_device *pdev, struct gpiod_lookup_tab
 
 	if (table->table[2].key) {
 		flags = GPIOD_OUT_HIGH;
-		if (priv.devmode == SIMATIC_IPC_DEVICE_BX_21A || SIMATIC_IPC_DEVICE_BX_59A)
+		if (priv.devmode == SIMATIC_IPC_DEVICE_BX_21A ||
+		    priv.devmode == SIMATIC_IPC_DEVICE_BX_59A)
 			flags = GPIOD_OUT_LOW;
 		priv.gpios[2] = devm_gpiod_get_index(dev, "CMOSBattery meter", 2, flags);
 		if (IS_ERR(priv.gpios[2])) {
-- 
2.25.1

