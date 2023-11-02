Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 329647DEDA1
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 08:49:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344777AbjKBHtk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 03:49:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjKBHtg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 03:49:36 -0400
Received: from mx.msync.work (mx.msync.work [62.182.159.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6E6D128;
        Thu,  2 Nov 2023 00:49:26 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BBE92147B81;
        Thu,  2 Nov 2023 07:49:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lexina.in; s=dkim;
        t=1698911364; h=from:subject:date:message-id:to:mime-version:
         content-transfer-encoding:in-reply-to:references;
        bh=7g9Pd3xFizPczsPF4psnwonGnJy6OcmmDqrxbFQxHFA=;
        b=M+uw87MkkWBDPTm4zcqCcvkJd1HPT1Mp+O3c6qIgnCLra9izQxIQo39ejYoKlNdR9sdnwU
        TDxY8sJRRkQeTJYXryyBrXgbOZuZwHGbbWSMFa9cA6S4mRdGXIQbtwUr58eEuO32ceqwkY
        MS2gNiBWZ9r1RVH/1URcfdsseaU0QvUNGL+Vx6Z1rGAVuue3J8oetuCMprR+f2lOnrCrcb
        vp0GgTtcpBBLxiEQ4w0kLqOeYEMJnYEopdtGWIeoEQg7YFRbV4hITOZGCZDlQvZz/aLaHR
        70WDEDufucemByUhdBL/q4Y3uZd3NCq1h/8EY+s402mHOB253Tfa6EIBCXt4Zg==
From:   Viacheslav Bocharov <adeep@lexina.in>
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH 2/4] firmware: meson_sm: Add chipid number sysfs entry
Date:   Thu,  2 Nov 2023 10:49:14 +0300
Message-Id: <20231102074916.3280809-3-adeep@lexina.in>
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

The Amlogic Meson SoC Secure Monitor implements a call to retrieve an
unique CHIP ID with CPU ID (128 bits length) starting from the GX
Family and all new families.

The chipid string is simply exposed as a sysfs entry under the firmware
sysfs directory.

Signed-off-by: Viacheslav Bocharov <adeep@lexina.in>
---
 drivers/firmware/meson/meson_sm.c | 54 ++++++++++++++++++++++++++++++-
 1 file changed, 53 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/meson/meson_sm.c b/drivers/firmware/meson/meson_sm.c
index c1c694b485ee..2820f4ac871b 100644
--- a/drivers/firmware/meson/meson_sm.c
+++ b/drivers/firmware/meson/meson_sm.c
@@ -240,9 +240,10 @@ struct meson_sm_firmware *meson_sm_get(struct device_node *sm_node)
 }
 EXPORT_SYMBOL_GPL(meson_sm_get);
 
-#define SM_CHIP_ID_LENGTH	119
+#define SM_CHIP_ID_LENGTH	128
 #define SM_CHIP_ID_OFFSET	4
 #define SM_CHIP_ID_SIZE		12
+#define SM_CHIP_IDv2_SIZE	16
 
 static ssize_t serial_show(struct device *dev, struct device_attribute *attr,
 			 char *buf)
@@ -274,8 +275,59 @@ static ssize_t serial_show(struct device *dev, struct device_attribute *attr,
 
 static DEVICE_ATTR_RO(serial);
 
+static ssize_t chipid_show(struct device *dev, struct device_attribute *attr,
+			 char *buf)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct meson_sm_firmware *fw;
+	uint8_t *id_buf;
+	int ret;
+
+	fw = platform_get_drvdata(pdev);
+
+	id_buf = kmalloc(SM_CHIP_ID_LENGTH, GFP_KERNEL);
+	if (!id_buf)
+		return -ENOMEM;
+
+	ret = meson_sm_call_read(fw, id_buf, SM_CHIP_ID_LENGTH, SM_GET_CHIP_ID,
+				 2, 0, 0, 0, 0);
+	if (ret < 0) {
+		kfree(id_buf);
+		return ret;
+	}
+
+	int version = *((unsigned int *)id_buf);
+
+	if (version == 2)
+		ret = scnprintf(buf, PAGE_SIZE, "%16phN\n", &id_buf[SM_CHIP_ID_OFFSET]);
+	else {
+		/**
+		 * Legacy 12-byte chip ID read out, transform data
+		 * to expected order format.
+		 */
+		uint8_t *buff;
+
+		buff = kmalloc(SM_CHIP_ID_LENGTH, GFP_KERNEL);
+		if (!buff)
+			return -ENOMEM;
+		((uint32_t *)buff)[0] = 0; // CPU_ID is empty
+		/* Transform into expected order for display */
+		ch = (uint8_t *)(id_buf + 4);
+		for (i = 0; i < 12; i++)
+			buff[i + 4] = ch[11 - i];
+		ret = scnprintf(buf, PAGE_SIZE, "%16phN\n", &buff);
+		kfree(buff);
+	}
+
+	kfree(id_buf);
+	return ret;
+}
+
+static DEVICE_ATTR_RO(chipid);
+
 static struct attribute *meson_sm_sysfs_attributes[] = {
 	&dev_attr_serial.attr,
+	&dev_attr_chipid.attr,
 	NULL,
 };
 
-- 
2.34.1

