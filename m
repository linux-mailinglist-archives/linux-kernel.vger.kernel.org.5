Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FE1B75C3F3
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 12:02:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbjGUKCW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 06:02:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbjGUKCT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 06:02:19 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F1E0B7;
        Fri, 21 Jul 2023 03:02:18 -0700 (PDT)
Received: from kwepemm600005.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4R6lQn60gdzHqZp;
        Fri, 21 Jul 2023 17:59:45 +0800 (CST)
Received: from huawei.com (10.50.163.32) by kwepemm600005.china.huawei.com
 (7.193.23.191) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 21 Jul
 2023 18:02:15 +0800
From:   liulongfang <liulongfang@huawei.com>
To:     <gregkh@linuxfoundation.org>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] USB:bugfix a controller halt error
Date:   Fri, 21 Jul 2023 18:00:15 +0800
Message-ID: <20230721100015.27124-1-liulongfang@huawei.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.50.163.32]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600005.china.huawei.com (7.193.23.191)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On systems that use ECC memory. The ECC error of the memory will
cause the USB controller to halt. It causes the usb_control_msg()
operation to fail.
At this point, the returned buffer data is an abnormal value, and
continuing to use it will lead to incorrect results.

Therefore, it is necessary to judge the return value and exit.

Signed-off-by: liulongfang <liulongfang@huawei.com>
---
 drivers/usb/core/hub.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index a739403a9e45..6a43198be263 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -4891,6 +4891,16 @@ hub_port_init(struct usb_hub *hub, struct usb_device *udev, int port1,
 					USB_DT_DEVICE << 8, 0,
 					buf, GET_DESCRIPTOR_BUFSIZE,
 					initial_descriptor_timeout);
+				/* On systems that use ECC memory, ECC errors can
+				 * cause the USB controller to halt.
+				 * It causes this operation to fail. At this time,
+				 * the buf data is an abnormal value and needs to be exited.
+				 */
+				if (r < 0) {
+					kfree(buf);
+					goto fail;
+				}
+
 				switch (buf->bMaxPacketSize0) {
 				case 8: case 16: case 32: case 64: case 255:
 					if (buf->bDescriptorType ==
-- 
2.24.0

