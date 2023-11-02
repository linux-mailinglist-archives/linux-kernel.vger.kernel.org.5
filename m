Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C8637DEDA4
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 08:49:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344770AbjKBHtq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 03:49:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234368AbjKBHtg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 03:49:36 -0400
Received: from mx.msync.work (mx.msync.work [62.182.159.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81D4512C;
        Thu,  2 Nov 2023 00:49:27 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 51175147AB3;
        Thu,  2 Nov 2023 07:49:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lexina.in; s=dkim;
        t=1698911365; h=from:subject:date:message-id:to:mime-version:
         content-transfer-encoding:in-reply-to:references;
        bh=DjHr33z5m71WBOI9v22JQkdNrW3bAbyGgJ/hgN+H1UM=;
        b=XjYThrOooEoCn2gOa0CXNbfolL9znTB9eHjNnAULCFsbKw17PTWQTw8tgyMwzZXXFGR0i6
        JLSM3sxt9joS5KLM3miIHWaRy7O9VU2BHfCYIiS/fWxBVtrR8qZvcSpQiyhac/HyS6g6qE
        PdJcKJFsxm1f6At4NLzWyhMAe2YYshagVOSQv31BuFBgRfDDLLD2ZLuH55RN3i+XqUFfR6
        hUybZQmu8JKHFkMP0a/LJ+3uxFSENmSxrRRbndDZ8qwovNjRg3VP/xAedcXHTZQEqnxWyk
        3AA1C4HYr/nrYiVzx1GxagiiuDoEUi4Bbv2ZHlHDlXWQ9RVLY84hZMvvVP/vgg==
From:   Viacheslav Bocharov <adeep@lexina.in>
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH 4/4] firmware: meson_sm: use meson_gx_socinfo for compatibility
Date:   Thu,  2 Nov 2023 10:49:16 +0300
Message-Id: <20231102074916.3280809-5-adeep@lexina.in>
In-Reply-To: <20231102074916.3280809-1-adeep@lexina.in>
References: <20231102074916.3280809-1-adeep@lexina.in>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use meson_gx_socinfo variable for chipid compatible call
from meson-gx-socinfo driver if available.

Signed-off-by: Viacheslav Bocharov <adeep@lexina.in>
---
 drivers/firmware/meson/meson_sm.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/meson/meson_sm.c b/drivers/firmware/meson/meson_sm.c
index 2820f4ac871b..29b53a8a6941 100644
--- a/drivers/firmware/meson/meson_sm.c
+++ b/drivers/firmware/meson/meson_sm.c
@@ -23,6 +23,10 @@
 
 #include <linux/firmware/meson/meson_sm.h>
 
+#ifdef CONFIG_MESON_GX_SOCINFO
+extern unsigned int meson_gx_socinfo;
+#endif
+
 struct meson_sm_cmd {
 	unsigned int index;
 	u32 smc_id;
@@ -310,7 +314,19 @@ static ssize_t chipid_show(struct device *dev, struct device_attribute *attr,
 		buff = kmalloc(SM_CHIP_ID_LENGTH, GFP_KERNEL);
 		if (!buff)
 			return -ENOMEM;
-		((uint32_t *)buff)[0] = 0; // CPU_ID is empty
+#ifdef CONFIG_MESON_GX_SOCINFO
+		uint8_t *ch;
+		int i;
+
+		((uint32_t *)buff)[0] =
+			((meson_gx_socinfo & 0xff000000)        |       // Family ID
+			((meson_gx_socinfo << 8) & 0xff0000)    |       // Chip Revision
+			((meson_gx_socinfo >> 8) & 0xff00));            // Package ID
+
+		((uint32_t *)buff)[0] = htonl(((uint32_t *)buff)[0]);
+#else
+		((uint32)t *)buff)[0] = 0;
+#endif
 		/* Transform into expected order for display */
 		ch = (uint8_t *)(id_buf + 4);
 		for (i = 0; i < 12; i++)
-- 
2.34.1

