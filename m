Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A573777000D
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 14:16:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbjHDMQr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 08:16:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbjHDMQq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 08:16:46 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7A4246B1
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 05:16:43 -0700 (PDT)
Received: from kwepemi500009.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RHPkM04ZTzGpnK;
        Fri,  4 Aug 2023 20:13:14 +0800 (CST)
Received: from huawei.com (10.67.175.85) by kwepemi500009.china.huawei.com
 (7.221.188.199) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 4 Aug
 2023 20:16:41 +0800
From:   Xia Fukun <xiafukun@huawei.com>
To:     <ilpo.jarvinen@linux.intel.com>, <andy.shevchenko@gmail.com>,
        <gregkh@linuxfoundation.org>, <heikki.krogerus@linux.intel.com>
CC:     <xiafukun@huawei.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] serial: 8250_dw: Fix assignment error of data in dw8250_probe()
Date:   Fri, 4 Aug 2023 20:16:07 +0800
Message-ID: <20230804121607.191203-1-xiafukun@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.175.85]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemi500009.china.huawei.com (7.221.188.199)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the "ri-override" property is present in the device,
data->msr_mask_on and UART_MSR_RI should be used for
OR-assignment. Fix the errors in it.

Fixes: 1bd8edba10e6 ("serial: 8250_dw: adapt to unified device property interface")
Signed-off-by: Xia Fukun <xiafukun@huawei.com>
---
 drivers/tty/serial/8250/8250_dw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index 7db51781289e..921b5f07828f 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -587,7 +587,7 @@ static int dw8250_probe(struct platform_device *pdev)
 
 	if (device_property_read_bool(dev, "ri-override")) {
 		/* Always report Ring indicator as inactive */
-		data->msr_mask_off |= UART_MSR_RI;
+		data->msr_mask_on |= UART_MSR_RI;
 		data->msr_mask_off |= UART_MSR_TERI;
 	}
 
-- 
2.17.1

