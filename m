Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C35F7E6595
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 09:50:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233659AbjKIIuj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 03:50:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbjKIIui (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 03:50:38 -0500
Received: from mx.msync.work (mx.msync.work [62.182.159.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA0C0210A;
        Thu,  9 Nov 2023 00:50:35 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 517661506C8;
        Thu,  9 Nov 2023 08:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lexina.in; s=dkim;
        t=1699519834; h=from:subject:date:message-id:to:mime-version:
         content-transfer-encoding; bh=cD6HIvwS1+eD7lmzk4U069SbWiB68SgbaID0yXccmhM=;
        b=aDZLp3j11jfHj1w+dkJjDQmX75SXmjAGrwYH6Y+rWWJgRthl68IQSJ3K8OSASbFeTYp66O
        /RK8a6rfbE0genlAmaLhir3mWSRvghogQ52JhRjFm30t3M296Z3zjqtd5pYUwVZzeP2EX7
        vpTxg+7Hg5iJ7xu1HKGBB65gZZ3kjtUSQ8mmumz+oYmT8d4BKPyf0ZhRzc9YGVIc4vqkhS
        PUylTPi1gEPSMk+Wzstc3R+giHWZgeWgAoemjqNTYq3/KRtgMUb3vuVzGnTVFt3xOtatL0
        S+1tLvIYO1HHk4sIHdadttgBE0YDcnnXLIj5VnFVnvBlsOgjXwXRB8n7OVv9eQ==
From:   Viacheslav Bocharov <adeep@lexina.in>
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH] firmware: meson-sm: change sprintf to scnprintf
Date:   Thu,  9 Nov 2023 11:50:29 +0300
Message-Id: <20231109085029.2079176-1-adeep@lexina.in>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

