Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3AA47DED9B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 08:49:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344066AbjKBHte (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 03:49:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjKBHtc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 03:49:32 -0400
Received: from mx.msync.work (mx.msync.work [62.182.159.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACBD6102;
        Thu,  2 Nov 2023 00:49:26 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 25750147B80;
        Thu,  2 Nov 2023 07:49:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lexina.in; s=dkim;
        t=1698911364; h=from:subject:date:message-id:to:mime-version:
         content-transfer-encoding:in-reply-to:references;
        bh=cD6HIvwS1+eD7lmzk4U069SbWiB68SgbaID0yXccmhM=;
        b=XXDo3QUDQez6r8fp1+UL4OuCuhJxp2tWksc8eDpgFkHOaUPxZJmoa2+uMCxI5iTvhJknNt
        t1x3grkVoj+J7HAnFgMqjusL1kqqsSE+jw5avzCrhUfSgMcLwbbUpNod1Yx0ysl1s3sI5G
        WbWE6IDGiJuNqYaJSgsAN/38CTqhT6dwlqmEHzLb7EZzT3FKdYzCsILoDyT42qMeGxLRPt
        DWDGpmYr3M79+0X97AwRpev0DNOthfXdFNMtzclvZG9X2BWqJnjV4mdUxiJwv4pfMiU99r
        2crUzil/ADrHYLiCALecVnT5Kj5DsE0OnN/8toOwhpcVAoBCStukjn9c3wCYKg==
From:   Viacheslav Bocharov <adeep@lexina.in>
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH 1/4] firmware: meson-sm: change sprintf to scnprintf
Date:   Thu,  2 Nov 2023 10:49:13 +0300
Message-Id: <20231102074916.3280809-2-adeep@lexina.in>
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

Update sprintf in serial_show frunction to scnprintf command to
prevent sysfs buffer overflow (buffer always is PAGE_SIZE bytes).

Signed-off-by: Viacheslav Bocharov <adeep@lexina.in>
---
 drivers/firmware/meson/meson_sm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/meson/meson_sm.c b/drivers/firmware/meson/meson_sm.c
index ed60f1103053..c1c694b485ee 100644
--- a/drivers/firmware/meson/meson_sm.c
+++ b/drivers/firmware/meson/meson_sm.c
@@ -265,7 +265,7 @@ static ssize_t serial_show(struct device *dev, struct device_attribute *attr,
 		return ret;
 	}
 
-	ret = sprintf(buf, "%12phN\n", &id_buf[SM_CHIP_ID_OFFSET]);
+	ret = scnprintf(buf, PAGE_SIZE, "%12phN\n", &id_buf[SM_CHIP_ID_OFFSET]);
 
 	kfree(id_buf);
 
-- 
2.34.1

