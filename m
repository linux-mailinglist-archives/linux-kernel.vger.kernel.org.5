Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03FA57DEDA3
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 08:49:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344453AbjKBHto (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 03:49:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234353AbjKBHtg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 03:49:36 -0400
Received: from mx.msync.work (mx.msync.work [62.182.159.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 247E212B;
        Thu,  2 Nov 2023 00:49:27 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0DC4F147AB2;
        Thu,  2 Nov 2023 07:49:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lexina.in; s=dkim;
        t=1698911365; h=from:subject:date:message-id:to:mime-version:
         content-transfer-encoding:in-reply-to:references;
        bh=8Xr/QweSmgY7p0LBTNCDzfvzvoqHoF5yll89vV6bmZg=;
        b=HWBp2KY7I80PU4n4CtgZLFQoURpXPvDGu6OdKU5iycx0g+S4FtILtkBU9671+oV8PNuLG8
        hSPz04sYvUBGo8Um0j2QOafAylCkZiMhTehtGrc0Qo+Wx7s+V4WlLoPsQ4J6F9NuXaB/k4
        DnPVjxzyO8NKz7VPxEyps1+FwvsjJxT7PKGtJlZvQ5jzGNgHkNDSTJSAyiciLxmtBxDpyk
        ZGJE4S4W0FmmvuqUcSpYmbIMOAHCi36a455PzlAyYu1xmE70vuIVb1GO3qQmjX8d1ddNUC
        GeqOOxSmmLhZ1kzqkveRn6wP0H90y7HIxs/1JNP1UR67+xnX6Sk88PaMMVS/Ow==
From:   Viacheslav Bocharov <adeep@lexina.in>
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH 3/4] soc: amlogic: meson-gx-socinfo: export socinfo for use in other modules
Date:   Thu,  2 Nov 2023 10:49:15 +0300
Message-Id: <20231102074916.3280809-4-adeep@lexina.in>
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

Move socinfo variable to global scope and export it as meson_gx_socinfo.

Signed-off-by: Viacheslav Bocharov <adeep@lexina.in>
---
 drivers/soc/amlogic/meson-gx-socinfo.c | 34 +++++++++++++++-----------
 1 file changed, 20 insertions(+), 14 deletions(-)

diff --git a/drivers/soc/amlogic/meson-gx-socinfo.c b/drivers/soc/amlogic/meson-gx-socinfo.c
index 6abb730344ab..0517f96a383b 100644
--- a/drivers/soc/amlogic/meson-gx-socinfo.c
+++ b/drivers/soc/amlogic/meson-gx-socinfo.c
@@ -24,6 +24,10 @@
 #define SOCINFO_MINOR	GENMASK(15, 8)
 #define SOCINFO_MISC	GENMASK(7, 0)
 
+
+unsigned int meson_gx_socinfo;
+EXPORT_SYMBOL(meson_gx_socinfo);
+
 static const struct meson_gx_soc_id {
 	const char *name;
 	unsigned int id;
@@ -131,10 +135,10 @@ static int __init meson_gx_socinfo_init(void)
 	struct soc_device *soc_dev;
 	struct device_node *np;
 	struct regmap *regmap;
-	unsigned int socinfo;
 	struct device *dev;
 	int ret;
 
+	meson_gx_socinfo = 0;
 	/* look up for chipid node */
 	np = of_find_compatible_node(NULL, NULL, "amlogic,meson-gx-ao-secure");
 	if (!np)
@@ -160,11 +164,13 @@ static int __init meson_gx_socinfo_init(void)
 		return -ENODEV;
 	}
 
-	ret = regmap_read(regmap, AO_SEC_SOCINFO_OFFSET, &socinfo);
-	if (ret < 0)
+	ret = regmap_read(regmap, AO_SEC_SOCINFO_OFFSET, &meson_gx_socinfo);
+	if (ret < 0) {
+		meson_gx_socinfo = 0;
 		return ret;
+	}
 
-	if (!socinfo) {
+	if (!meson_gx_socinfo) {
 		pr_err("%s: invalid chipid value\n", __func__);
 		return -EINVAL;
 	}
@@ -175,13 +181,13 @@ static int __init meson_gx_socinfo_init(void)
 
 	soc_dev_attr->family = "Amlogic Meson";
 	soc_dev_attr->revision = kasprintf(GFP_KERNEL, "%x:%x - %x:%x",
-					   socinfo_to_major(socinfo),
-					   socinfo_to_minor(socinfo),
-					   socinfo_to_pack(socinfo),
-					   socinfo_to_misc(socinfo));
+					   socinfo_to_major(meson_gx_socinfo),
+					   socinfo_to_minor(meson_gx_socinfo),
+					   socinfo_to_pack(meson_gx_socinfo),
+					   socinfo_to_misc(meson_gx_socinfo));
 	soc_dev_attr->soc_id = kasprintf(GFP_KERNEL, "%s (%s)",
-					 socinfo_to_soc_id(socinfo),
-					 socinfo_to_package_id(socinfo));
+					 socinfo_to_soc_id(meson_gx_socinfo),
+					 socinfo_to_package_id(meson_gx_socinfo));
 
 	soc_dev = soc_device_register(soc_dev_attr);
 	if (IS_ERR(soc_dev)) {
@@ -194,10 +200,10 @@ static int __init meson_gx_socinfo_init(void)
 
 	dev_info(dev, "Amlogic Meson %s Revision %x:%x (%x:%x) Detected\n",
 			soc_dev_attr->soc_id,
-			socinfo_to_major(socinfo),
-			socinfo_to_minor(socinfo),
-			socinfo_to_pack(socinfo),
-			socinfo_to_misc(socinfo));
+			socinfo_to_major(meson_gx_socinfo),
+			socinfo_to_minor(meson_gx_socinfo),
+			socinfo_to_pack(meson_gx_socinfo),
+			socinfo_to_misc(meson_gx_socinfo));
 
 	return 0;
 }
-- 
2.34.1

