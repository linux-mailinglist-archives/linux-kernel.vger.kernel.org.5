Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F30317FC46E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 20:49:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230158AbjK1Ttn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 14:49:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbjK1Ttm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 14:49:42 -0500
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27C1510F0;
        Tue, 28 Nov 2023 11:49:45 -0800 (PST)
Received: from francesco-nb.toradex.int (31-10-194-107.static.upc.ch [31.10.194.107])
        by mail11.truemail.it (Postfix) with ESMTPA id 47FC0206FC;
        Tue, 28 Nov 2023 20:49:42 +0100 (CET)
From:   Francesco Dolcini <francesco@dolcini.it>
To:     Maximilian Luz <luzmaximilian@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Mark Gross <markgross@kernel.org>
Cc:     Francesco Dolcini <francesco.dolcini@toradex.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: [PATCH v1] platform/surface: aggregator: fix recv_buf() return value
Date:   Tue, 28 Nov 2023 20:49:35 +0100
Message-Id: <20231128194935.11350-1-francesco@dolcini.it>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Francesco Dolcini <francesco.dolcini@toradex.com>

Serdev recv_buf() callback is supposed to return the amount of bytes
consumed, therefore an int in between 0 and count.

Do not return negative number in case of issue, when
ssam_controller_receive_buf() returns ESHUTDOWN just returns 0, e.g. no
bytes consumed, this keep the exact same behavior as it was before.

This fixes a potential WARN in serdev-ttyport.c:ttyport_receive_buf().

Cc: <stable@vger.kernel.org>
Fixes: c167b9c7e3d6 ("platform/surface: Add Surface Aggregator subsystem")
Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
 drivers/platform/surface/aggregator/core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/surface/aggregator/core.c b/drivers/platform/surface/aggregator/core.c
index 1a6373dea109..6152be38398c 100644
--- a/drivers/platform/surface/aggregator/core.c
+++ b/drivers/platform/surface/aggregator/core.c
@@ -231,9 +231,12 @@ static int ssam_receive_buf(struct serdev_device *dev, const unsigned char *buf,
 			    size_t n)
 {
 	struct ssam_controller *ctrl;
+	int ret;
 
 	ctrl = serdev_device_get_drvdata(dev);
-	return ssam_controller_receive_buf(ctrl, buf, n);
+	ret = ssam_controller_receive_buf(ctrl, buf, n);
+
+	return ret < 0 ? 0 : ret;
 }
 
 static void ssam_write_wakeup(struct serdev_device *dev)
-- 
2.25.1

