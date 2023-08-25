Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF126787E0D
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 04:53:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236112AbjHYCxE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 22:53:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242773AbjHYCw6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 22:52:58 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 896F3268E
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 19:52:29 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-68a4bcf8a97so401284b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 19:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692931948; x=1693536748;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m3+URBqZpZF2x77jWPMvlepFC5eyrNLor5lT2YRYaCA=;
        b=jwSGOFVLVU0xCoY5pLfoOIfVqNP8RbKX7XksFTPUAFAqV6iwheXJgNjC8ZtGGe6m1x
         CotQ0N88c1rbuo3NZtpi8JoLZhjBMz8TjxRUUiYVCMASj9wYBBpvCU/Yhl9LNYZRpeqt
         sNA4eLMBgnzgSrLHMhAFDs6rXjqpsxbWgdoVg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692931948; x=1693536748;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m3+URBqZpZF2x77jWPMvlepFC5eyrNLor5lT2YRYaCA=;
        b=G8nUdCQWwapph1mOH3ShXT6vdBX/6Fz9beFixdrWoCxbhjelf3ycg6gjoWwnB8JR02
         KhdFMqFuoYRnjgwqcIwF7j5+8Lqob99qK7iPK/m6lXw57oEI52LxHqbMiLK+NAfZFvIH
         FKw/nz0LBm/g/ebse1ANiesPP5Mx9HH0HzGhZOUkz3l/N6qVXLsV3KSFteBIJsn1G2TT
         c8CGs/UZtQvbYu58/42kwXYFE+sKq49r/u4nt7XJ8OrLb50Wq7b+oGsjPEtPrKp03S2t
         QqKwVpgp/UkczaFzUhAv0LSTIxmVWohrK82abhY1K3ItzhSRCxZQD0JLnftIlo1okOC7
         BeEg==
X-Gm-Message-State: AOJu0Yx5D85ne7Kf0N7izt3BCVQgr9119M1Njmgw0GCD8Y5PzvKQMyHM
        M/t86js7RWcZllWdjPJdJEs66A==
X-Google-Smtp-Source: AGHT+IEC1VIJWj32bHEOO6xQnrTuBhX+AC88P89p+LUarmfmkZr7HIRKlDIkSrMR0GjJYmfbF0GsRw==
X-Received: by 2002:a05:6a20:1447:b0:148:40cf:b832 with SMTP id a7-20020a056a20144700b0014840cfb832mr18251618pzi.18.1692931948099;
        Thu, 24 Aug 2023 19:52:28 -0700 (PDT)
Received: from rekanorman3.syd.corp.google.com ([2401:fa00:9:14:9fe1:d4b1:42cc:882f])
        by smtp.gmail.com with ESMTPSA id q10-20020a170902a3ca00b001bb0eebd90asm420847plb.245.2023.08.24.19.52.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Aug 2023 19:52:27 -0700 (PDT)
From:   Reka Norman <rekanorman@chromium.org>
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     Daisuke Nojiri <dnojiri@chromium.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Stefan Adolfsson <sadolfsson@google.com>,
        Reka Norman <rekanorman@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org
Subject: [PATCH v2 7/9] media: cros-ec-cec: Allow specifying multiple HDMI connectors
Date:   Fri, 25 Aug 2023 12:44:00 +1000
Message-ID: <20230825024735.1443836-8-rekanorman@chromium.org>
X-Mailer: git-send-email 2.42.0.rc2.253.gd59a3bf2b4-goog
In-Reply-To: <20230825024735.1443836-1-rekanorman@chromium.org>
References: <20230825024735.1443836-1-rekanorman@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the cec_dmi_match_table to allow specifying multiple HDMI
connectors for each device.

Signed-off-by: Reka Norman <rekanorman@chromium.org>
---

Changes in v2:
- Use NULL-terminated arrays for the conns field of cec_dmi_match

 .../media/cec/platform/cros-ec/cros-ec-cec.c  | 49 ++++++++++++-------
 1 file changed, 30 insertions(+), 19 deletions(-)

diff --git a/drivers/media/cec/platform/cros-ec/cros-ec-cec.c b/drivers/media/cec/platform/cros-ec/cros-ec-cec.c
index 6989e63c05be..371699d599de 100644
--- a/drivers/media/cec/platform/cros-ec/cros-ec-cec.c
+++ b/drivers/media/cec/platform/cros-ec/cros-ec-cec.c
@@ -284,38 +284,43 @@ static SIMPLE_DEV_PM_OPS(cros_ec_cec_pm_ops,
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
+	const char *const *conns;
 };
 
+static const char *const fizz_conns[] = { "Port B", NULL };
+
 static const struct cec_dmi_match cec_dmi_match_table[] = {
 	/* Google Fizz */
-	{ "Google", "Fizz", "0000:00:02.0", "Port B" },
+	{ "Google", "Fizz", "0000:00:02.0", fizz_conns },
 	/* Google Brask */
-	{ "Google", "Brask", "0000:00:02.0", "Port B" },
+	{ "Google", "Brask", "0000:00:02.0", fizz_conns },
 	/* Google Moli */
-	{ "Google", "Moli", "0000:00:02.0", "Port B" },
+	{ "Google", "Moli", "0000:00:02.0", fizz_conns },
 	/* Google Kinox */
-	{ "Google", "Kinox", "0000:00:02.0", "Port B" },
+	{ "Google", "Kinox", "0000:00:02.0", fizz_conns },
 	/* Google Kuldax */
-	{ "Google", "Kuldax", "0000:00:02.0", "Port B" },
+	{ "Google", "Kuldax", "0000:00:02.0", fizz_conns },
 	/* Google Aurash */
-	{ "Google", "Aurash", "0000:00:02.0", "Port B" },
+	{ "Google", "Aurash", "0000:00:02.0", fizz_conns },
 	/* Google Gladios */
-	{ "Google", "Gladios", "0000:00:02.0", "Port B" },
+	{ "Google", "Gladios", "0000:00:02.0", fizz_conns },
 	/* Google Lisbon */
-	{ "Google", "Lisbon", "0000:00:02.0", "Port B" },
+	{ "Google", "Lisbon", "0000:00:02.0", fizz_conns },
 };
 
 static struct device *cros_ec_cec_find_hdmi_dev(struct device *dev,
-						const char **conn)
+						const char * const **conns)
 {
 	int i;
 
@@ -332,7 +337,7 @@ static struct device *cros_ec_cec_find_hdmi_dev(struct device *dev,
 			if (!d)
 				return ERR_PTR(-EPROBE_DEFER);
 			put_device(d);
-			*conn = m->conn;
+			*conns = m->conns;
 			return d;
 		}
 	}
@@ -346,7 +351,7 @@ static struct device *cros_ec_cec_find_hdmi_dev(struct device *dev,
 #else
 
 static struct device *cros_ec_cec_find_hdmi_dev(struct device *dev,
-						const char **conn)
+						const char * const **conns)
 {
 	return ERR_PTR(-ENODEV);
 }
@@ -388,7 +393,7 @@ static int cros_ec_cec_get_write_cmd_version(struct cros_ec_cec *cros_ec_cec)
 static int cros_ec_cec_init_port(struct device *dev,
 				 struct cros_ec_cec *cros_ec_cec,
 				 int port_num, struct device *hdmi_dev,
-				 const char *conn)
+				 const char * const *conns)
 {
 	struct cros_ec_cec_port *port;
 	int ret;
@@ -406,7 +411,13 @@ static int cros_ec_cec_init_port(struct device *dev,
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
@@ -435,10 +446,10 @@ static int cros_ec_cec_probe(struct platform_device *pdev)
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
 
@@ -460,7 +471,7 @@ static int cros_ec_cec_probe(struct platform_device *pdev)
 
 	for (int i = 0; i < cros_ec_cec->num_ports; i++) {
 		ret = cros_ec_cec_init_port(&pdev->dev, cros_ec_cec, i,
-					    hdmi_dev, conn);
+					    hdmi_dev, conns);
 		if (ret)
 			goto unregister_ports;
 	}
-- 
2.42.0.rc2.253.gd59a3bf2b4-goog

