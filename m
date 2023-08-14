Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E02077B086
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 06:37:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233168AbjHNEgt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 00:36:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233144AbjHNEgV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 00:36:21 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 956AEE75
        for <linux-kernel@vger.kernel.org>; Sun, 13 Aug 2023 21:36:19 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1bdbbede5d4so21247215ad.2
        for <linux-kernel@vger.kernel.org>; Sun, 13 Aug 2023 21:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1691987779; x=1692592579;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rb7jjFlFBeiFtDhi82C+yA5IC7ctDIMYcDjyXscM6+U=;
        b=RZvtVRADYrGV2dY0sTy4VXojVTw8w7cJxh8W0jxGK864I7waMUc/qcRBfQVmnP6+1E
         QlTJpNsL5N8G0A4N0oyPJ9D0AqiBj7mj2L59UCaJd2aLjugGuHY/9ZpbkG4gucVW3SF8
         oUz1AjNv0P5EgKHXmOomAtZD69ucp01EcQ+tk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691987779; x=1692592579;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rb7jjFlFBeiFtDhi82C+yA5IC7ctDIMYcDjyXscM6+U=;
        b=Kv0Qx5V16773o3aCaXCHVvUev7EhraAUyfvKBQcP0tmRUvV2LFNJN0wpWU+5Dl3pTo
         9L43kSrPPCi3Fzl4/7zOLCDEidFG0L+eyi569JVF3qFX+1INaZaD+eZKaI2vQS3m0g6R
         fhcu3NWqQF1sO/wIa7MCWIAFeu3zujp9AjgNSlo6LwIBSJ9t+pzbT0wgDYVwzXwb/fcl
         TFgMH5NWNibMMtzPTmpoBArEPAaJn87R4Q8zuQHM0qyfNPNtTMAa6EAL14fC13Sv1FaV
         3FDCitTBx4cSMYaNIb2GbmQJ3d3K3b3b6T6LUGSrVe7BbxK4W/5m3/ETcu9HBQtOmk1K
         +vPg==
X-Gm-Message-State: AOJu0Yx5yyu5FXRGJWIDRQaObF6GO/YijdLYokVq5ePwtqkuhOcvdKc+
        +1pIYdUqZhvhzKyaDu3A+AiGxg==
X-Google-Smtp-Source: AGHT+IFFOeB7bcX8lAGCZbD58ClWUlth4TAktXycek44ttpNJJcIE+/tUgmQPJT2SUn5/ez9oz3igw==
X-Received: by 2002:a17:902:ea04:b0:1bc:978f:5d26 with SMTP id s4-20020a170902ea0400b001bc978f5d26mr10766021plg.7.1691987779058;
        Sun, 13 Aug 2023 21:36:19 -0700 (PDT)
Received: from rekanorman3.syd.corp.google.com ([2401:fa00:9:14:4ae6:d1a4:27c2:80ff])
        by smtp.gmail.com with ESMTPSA id ju17-20020a170903429100b001bdb0483e65sm6761865plb.265.2023.08.13.21.36.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Aug 2023 21:36:18 -0700 (PDT)
From:   Reka Norman <rekanorman@chromium.org>
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        Daisuke Nojiri <dnojiri@chromium.org>,
        Stefan Adolfsson <sadolfsson@google.com>,
        Reka Norman <rekanorman@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org
Subject: [PATCH 7/9] media: cros-ec-cec: Allow specifying multiple HDMI connectors
Date:   Mon, 14 Aug 2023 14:29:16 +1000
Message-ID: <20230814043140.1108917-8-rekanorman@chromium.org>
X-Mailer: git-send-email 2.41.0.640.ga95def55d0-goog
In-Reply-To: <20230814043140.1108917-1-rekanorman@chromium.org>
References: <20230814043140.1108917-1-rekanorman@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the cec_dmi_match_table to allow specifying multiple HDMI
connectors for each device.

Signed-off-by: Reka Norman <rekanorman@chromium.org>
---

 .../media/cec/platform/cros-ec/cros-ec-cec.c  | 47 +++++++++++--------
 1 file changed, 28 insertions(+), 19 deletions(-)

diff --git a/drivers/media/cec/platform/cros-ec/cros-ec-cec.c b/drivers/media/cec/platform/cros-ec/cros-ec-cec.c
index c68ed5d4bda0..f2f397d9a6d8 100644
--- a/drivers/media/cec/platform/cros-ec/cros-ec-cec.c
+++ b/drivers/media/cec/platform/cros-ec/cros-ec-cec.c
@@ -284,38 +284,41 @@ static SIMPLE_DEV_PM_OPS(cros_ec_cec_pm_ops,
 #if IS_ENABLED(CONFIG_PCI) && IS_ENABLED(CONFIG_DMI)
 
 /*
- * The Firmware only handles a single CEC interface tied to a single HDMI
- * connector we specify along with the DRM device name handling the HDMI output
+ * Specify the DRM device name handling the HDMI output and the HDMI connector
+ * corresponding to each CEC port. The order of connectors must match the order
+ * in the EC (first connector is EC port 0, ...), and the number of connectors
+ * must match the number of ports in the EC (which can be queried using the
+ * EC_CMD_CEC_PORT_COUNT host command).
  */
 
 struct cec_dmi_match {
 	const char *sys_vendor;
 	const char *product_name;
 	const char *devname;
-	const char *conn;
+	const char *conns[EC_CEC_MAX_PORTS];
 };
 
 static const struct cec_dmi_match cec_dmi_match_table[] = {
 	/* Google Fizz */
-	{ "Google", "Fizz", "0000:00:02.0", "Port B" },
+	{ "Google", "Fizz", "0000:00:02.0", { "Port B" } },
 	/* Google Brask */
-	{ "Google", "Brask", "0000:00:02.0", "Port B" },
+	{ "Google", "Brask", "0000:00:02.0", { "Port B" } },
 	/* Google Moli */
-	{ "Google", "Moli", "0000:00:02.0", "Port B" },
+	{ "Google", "Moli", "0000:00:02.0", { "Port B" } },
 	/* Google Kinox */
-	{ "Google", "Kinox", "0000:00:02.0", "Port B" },
+	{ "Google", "Kinox", "0000:00:02.0", { "Port B" } },
 	/* Google Kuldax */
-	{ "Google", "Kuldax", "0000:00:02.0", "Port B" },
+	{ "Google", "Kuldax", "0000:00:02.0", { "Port B" } },
 	/* Google Aurash */
-	{ "Google", "Aurash", "0000:00:02.0", "Port B" },
+	{ "Google", "Aurash", "0000:00:02.0", { "Port B" } },
 	/* Google Gladios */
-	{ "Google", "Gladios", "0000:00:02.0", "Port B" },
+	{ "Google", "Gladios", "0000:00:02.0", { "Port B" } },
 	/* Google Lisbon */
-	{ "Google", "Lisbon", "0000:00:02.0", "Port B" },
+	{ "Google", "Lisbon", "0000:00:02.0", { "Port B" } },
 };
 
 static struct device *cros_ec_cec_find_hdmi_dev(struct device *dev,
-						const char **conn)
+						const char * const **conns)
 {
 	int i;
 
@@ -332,7 +335,7 @@ static struct device *cros_ec_cec_find_hdmi_dev(struct device *dev,
 			if (!d)
 				return ERR_PTR(-EPROBE_DEFER);
 			put_device(d);
-			*conn = m->conn;
+			*conns = m->conns;
 			return d;
 		}
 	}
@@ -346,7 +349,7 @@ static struct device *cros_ec_cec_find_hdmi_dev(struct device *dev,
 #else
 
 static struct device *cros_ec_cec_find_hdmi_dev(struct device *dev,
-						const char **conn)
+						const char * const **conns)
 {
 	return ERR_PTR(-ENODEV);
 }
@@ -388,7 +391,7 @@ static int cros_ec_cec_get_write_cmd_version(struct cros_ec_cec *cros_ec_cec)
 static int cros_ec_cec_init_port(struct device *dev,
 				 struct cros_ec_cec *cros_ec_cec,
 				 int port_num, struct device *hdmi_dev,
-				 const char *conn)
+				 const char * const *conns)
 {
 	struct cros_ec_cec_port *port;
 	int ret;
@@ -406,7 +409,13 @@ static int cros_ec_cec_init_port(struct device *dev,
 	if (IS_ERR(port->adap))
 		return PTR_ERR(port->adap);
 
-	port->notify = cec_notifier_cec_adap_register(hdmi_dev, conn,
+	if (!conns[port_num]) {
+		dev_err(dev, "no conn for port %d\n", port_num);
+		ret = -ENODEV;
+		goto out_probe_adapter;
+	}
+
+	port->notify = cec_notifier_cec_adap_register(hdmi_dev, conns[port_num],
 						      port->adap);
 	if (!port->notify) {
 		ret = -ENOMEM;
@@ -435,10 +444,10 @@ static int cros_ec_cec_probe(struct platform_device *pdev)
 	struct cros_ec_cec *cros_ec_cec;
 	struct cros_ec_cec_port *port;
 	struct device *hdmi_dev;
-	const char *conn = NULL;
+	const char * const *conns = NULL;
 	int ret;
 
-	hdmi_dev = cros_ec_cec_find_hdmi_dev(&pdev->dev, &conn);
+	hdmi_dev = cros_ec_cec_find_hdmi_dev(&pdev->dev, &conns);
 	if (IS_ERR(hdmi_dev))
 		return PTR_ERR(hdmi_dev);
 
@@ -460,7 +469,7 @@ static int cros_ec_cec_probe(struct platform_device *pdev)
 
 	for (int i = 0; i < cros_ec_cec->num_ports; i++) {
 		ret = cros_ec_cec_init_port(&pdev->dev, cros_ec_cec, i,
-					    hdmi_dev, conn);
+					    hdmi_dev, conns);
 		if (ret)
 			goto unregister_ports;
 	}
-- 
2.41.0.640.ga95def55d0-goog

