Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B6687E07F9
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 19:20:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233132AbjKCST6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 14:19:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230219AbjKCSTy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 14:19:54 -0400
Received: from rs227.mailgun.us (rs227.mailgun.us [209.61.151.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E850DCF
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 11:19:46 -0700 (PDT)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=equiv.tech; q=dns/txt;
 s=mx; t=1699035585; x=1699042785; h=Content-Transfer-Encoding: Content-Type:
 MIME-Version: Message-Id: Date: Subject: Subject: Cc: To: To: From: From:
 Sender: Sender; bh=Aw3NIZOfJGjEMR/zbjqoZg8/cDgznkhoiJJtPHEZINM=;
 b=LZoxlEfK+ZMiQAEdQ6icHiIJqgspBOmZFb7F6voG0ic5MZQWdRv6sM0sE8D7O8qZoiZy2PeHkUOV3ap00Rt6e+tdxQV/05IEreoTLLGLg5NfNAsG7XiDBSyh0iSVv3Z+7b9nHJ6+bXNjQS1qhkXMNjdhTsfBmQ2gh8CojB4lBYQnn7ZZbdi08p4l1yu1+JEsFqoKjHQcW76T3jgk3jNy0aE70ulAQMwKOQQi9kAPAyvssRTlsSQK3OLECm6T+c7G5nWVBV4OpCsSZqI2rCu8wbvo/b3GV+zj8uiWWbAzb182Qe3SO9OF8MzoakITDfETyZS4GszJbuF4cayaD73/7g==
X-Mailgun-Sending-Ip: 209.61.151.227
X-Mailgun-Sid: WyI4ZWI3MiIsImxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmciLCI5M2Q1YWIiXQ==
Received: from mail.equiv.tech (equiv.tech [142.93.28.83]) by 0ae46d290350 with SMTP id
 654539c082847315b749a83f (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 03 Nov 2023 18:19:44 GMT
Sender: james@equiv.tech
From:   James Seo <james@equiv.tech>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     James Seo <james@equiv.tech>,
        Lukasz Stelmach <l.stelmach@samsung.com>,
        Armin Wolf <W_Armin@gmx.de>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC] hwmon: (hp-wmi-sensors) Fix failure to load on EliteDesk 800 G6
Date:   Fri,  3 Nov 2023 11:19:31 -0700
Message-Id: <20231103181931.677796-1-james@equiv.tech>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URI_TRY_3LD autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The EliteDesk 800 G6 stores a raw WMI string within the ACPI object in its
BIOS corresponding to one instance of HPBIOS_PlatformEvents.Name. This is
evidently a valid way of representing a WMI data item as far as the Microsoft
ACPI-WMI mapper is concerned, but is preventing the driver from loading.

As this seems quite rare, add a machine-limited workaround for now.

Reported-by: Lukasz Stelmach <l.stelmach@samsung.com>
Closes: https://lore.kernel.org/linux-hwmon/7850a0bd-60e7-88f8-1d6c-0bb0e3234fdc@roeck-us.net/
Signed-off-by: James Seo <james@equiv.tech>
---
Was converting to UTF-8 a good idea? There's also not much UTF-16 validation,
because at the moment it's only being done on one machine with a known input.
---
 drivers/hwmon/hp-wmi-sensors.c | 57 ++++++++++++++++++++++++++++++++--
 1 file changed, 55 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/hp-wmi-sensors.c b/drivers/hwmon/hp-wmi-sensors.c
index 17ae62f88bbf..c82a9bbf16ca 100644
--- a/drivers/hwmon/hp-wmi-sensors.c
+++ b/drivers/hwmon/hp-wmi-sensors.c
@@ -17,13 +17,17 @@
  *     Available: https://github.com/linuxhw/ACPI
  * [4] P. Rohár, "bmfdec - Decompile binary MOF file (BMF) from WMI buffer",
  *     2017. [Online]. Available: https://github.com/pali/bmfdec
+ * [5] Microsoft Corporation, "Driver-Defined WMI Data Items", 2017. [Online].
+ *     Available: https://learn.microsoft.com/en-us/windows-hardware/drivers/kernel/driver-defined-wmi-data-items
  */
 
 #include <linux/acpi.h>
 #include <linux/debugfs.h>
+#include <linux/dmi.h>
 #include <linux/hwmon.h>
 #include <linux/jiffies.h>
 #include <linux/mutex.h>
+#include <linux/nls.h>
 #include <linux/units.h>
 #include <linux/wmi.h>
 
@@ -52,6 +56,10 @@
 #define HP_WMI_MAX_PROPERTIES		32U
 #define HP_WMI_MAX_INSTANCES		32U
 
+/* DMI board names for machines requiring workarounds. */
+
+#define HP_WMI_BOARD_NAME_ELITEDESK_800_G6	"870C"
+
 enum hp_wmi_type {
 	HP_WMI_TYPE_OTHER			= 1,
 	HP_WMI_TYPE_TEMPERATURE			= 2,
@@ -412,6 +420,30 @@ static char *hp_wmi_strdup(struct device *dev, const char *src)
 	return dst;
 }
 
+/* hp_wmi_wstrdup - hp_wmi_strdup, but for a raw WMI string */
+static char *hp_wmi_wstrdup(struct device *dev, const u8 *buf)
+{
+	const wchar_t *src;
+	size_t len;
+	char *dst;
+	int i;
+
+	/* WMI strings are length-prefixed UTF-16. See [5]. */
+	src = (wchar_t *)buf;
+	len = min(*src++ / sizeof(*src), (size_t)HP_WMI_MAX_STR_SIZE - 1);
+	while (len && !src[len - 1])
+		len--;
+
+	dst = devm_kmalloc(dev, (len + 1) * sizeof(*dst), GFP_KERNEL);
+	if (!dst)
+		return NULL;
+
+	i = utf16s_to_utf8s(src, len, UTF16_LITTLE_ENDIAN, dst, len);
+	dst[i] = '\0';
+
+	return strim(dst);
+}
+
 /*
  * hp_wmi_get_wobj - poll WMI for a WMI object instance
  * @guid: WMI object GUID
@@ -442,6 +474,21 @@ static u8 hp_wmi_wobj_instance_count(const char *guid)
 	return clamp(count, 0, (int)HP_WMI_MAX_INSTANCES);
 }
 
+static bool is_raw_wmi_string(const acpi_object_type property_map[], int prop)
+{
+	const char *board_name;
+
+	if (property_map != hp_wmi_platform_events_property_map ||
+	    prop != HP_WMI_PLATFORM_EVENTS_PROPERTY_NAME)
+		return false;
+
+	board_name = dmi_get_system_info(DMI_BOARD_NAME);
+	if (!board_name)
+		return false;
+
+	return !strcmp(board_name, HP_WMI_BOARD_NAME_ELITEDESK_800_G6);
+}
+
 static int check_wobj(const union acpi_object *wobj,
 		      const acpi_object_type property_map[], int last_prop)
 {
@@ -462,8 +509,12 @@ static int check_wobj(const union acpi_object *wobj,
 	for (prop = 0; prop <= last_prop; prop++) {
 		type = elements[prop].type;
 		valid_type = property_map[prop];
-		if (type != valid_type)
+		if (type != valid_type) {
+			if (type == ACPI_TYPE_BUFFER &&
+			    is_raw_wmi_string(property_map, prop))
+				continue;
 			return -EINVAL;
+		}
 	}
 
 	return 0;
@@ -480,7 +531,9 @@ static int extract_acpi_value(struct device *dev,
 		break;
 
 	case ACPI_TYPE_STRING:
-		*out_string = hp_wmi_strdup(dev, strim(element->string.pointer));
+		*out_string = element->type == ACPI_TYPE_BUFFER ?
+			hp_wmi_wstrdup(dev, element->buffer.pointer) :
+			hp_wmi_strdup(dev, strim(element->string.pointer));
 		if (!*out_string)
 			return -ENOMEM;
 		break;

base-commit: 0f564130e5c76f1e5cf0008924f6a6cd138929d9
-- 
2.39.2

