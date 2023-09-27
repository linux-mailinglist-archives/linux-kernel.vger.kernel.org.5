Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89F3C7B0B8C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 19:58:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbjI0R6e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 13:58:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbjI0R6J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 13:58:09 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3E2210F5;
        Wed, 27 Sep 2023 10:57:56 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-40572aeb6d0so82792905e9.1;
        Wed, 27 Sep 2023 10:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695837475; x=1696442275; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p2109S4Uz2+NkDCuRu0GcYLAXs7x3Far7ylOe5EHoOY=;
        b=m933ANgxGQiFXpCXC3/svDWVuqeg5IQTId42hA/fM0FJcK9KNZ61FcfSDHbJb89Dn9
         +5toSYVtp+9KgbFbHoGzIJ/oFCQdPxQcgvD6vC0JeOjY2zTX89bnNUHeuL+5M294glb9
         qZ6FjdvIdXc7J0B3fP62cUnVe5sQ8UmOnPOVUeSiGq7145azUXg2Hz64I668B6fsu9BF
         z2YG7Iqpmk5OfhkU1utDEyq3PclPNesQkTRjoaJgTY5y4dyv63xXfakARjZ/9LNQ+wqb
         SfG6GJHsWunODdlkhaevLNLBhzTVcstmS5OK/iM6r0PxPM1pGQQgZ9jowFV4CJ5WyhUw
         2b8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695837475; x=1696442275;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p2109S4Uz2+NkDCuRu0GcYLAXs7x3Far7ylOe5EHoOY=;
        b=PSi/Q3434HFH/X+n3GSg00cEUh+TEMtTOZyOPLVxeuRmC/iYqeLgkgxAIh+OIBjkcs
         PMMXQ3Ee4x++E3zSK2YdO+LTnPGdbVB/AwFY32ns1XdGL4e5OQFA2enCWgSmQUA0DbVH
         8htjeMeyIEBoAm3e9bOJU+Qvocz7yv66kjaYUL+VoRZckfYTiaZAS5ga5Nh8l2m/STCo
         ggmPWe+gpdEzW9tWIWBO9njOvltusubsutjyrWr6e6TOcqW6vMv0OEO/ch48fEB+yThe
         mC/wild8AluzP9qFFa2m+p+V3A6GLiZh17pzJIsmayDzPc5Gw2WjW1CqCw+nMJC0tTSL
         l1ow==
X-Gm-Message-State: AOJu0YyrqZme5IcvZSmci1cSkFiJATTiiLSC5xLnlVDO8jRMwRcobqYw
        5zu2a9DCLQvcFYwtcOq3zqzx3ytsnjrYTsiI4FI=
X-Google-Smtp-Source: AGHT+IEyA1kIm+4XHyPVDovtqS8aoOhNRFsAZnA/J3cBYYroo9LS1q548ikrMFrHYRDyfl6RPHB1og==
X-Received: by 2002:a5d:6782:0:b0:31f:b79a:c4b7 with SMTP id v2-20020a5d6782000000b0031fb79ac4b7mr2420469wru.24.1695837475101;
        Wed, 27 Sep 2023 10:57:55 -0700 (PDT)
Received: from primary.. ([212.34.12.50])
        by smtp.gmail.com with ESMTPSA id d4-20020a170906370400b0099bd8c1f67esm9654593ejc.109.2023.09.27.10.57.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 10:57:54 -0700 (PDT)
From:   Abdel Alkuor <alkuor@gmail.com>
To:     heikki.krogerus@linux.intel.com, krzysztof.kozlowski+dt@linaro.org,
        bryan.odonoghue@linaro.org
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, ryan.eleceng@gmail.com,
        robh+dt@kernel.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org, Abdel Alkuor <abdelalkuor@geotab.com>
Subject: [PATCH v7 14/14] USB: typec: tps6598x: Add status trace for tps25750
Date:   Wed, 27 Sep 2023 13:53:48 -0400
Message-Id: <20230927175348.18041-15-alkuor@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230927175348.18041-1-alkuor@gmail.com>
References: <20230927175348.18041-1-alkuor@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Abdel Alkuor <abdelalkuor@geotab.com>

tps25750 status register is a subset of tps6598x status register, hence
a trace for tps25750 status register is added.

Signed-off-by: Abdel Alkuor <abdelalkuor@geotab.com>
---
Changes in v7:
  - Add driver name to commit subject
Changes in v6:
 - Add trace status to tipd data factory
Changes in v5:
  - Incorporating tps25750 into tps6598x driver

 drivers/usb/typec/tipd/core.c  | 12 +++++++----
 drivers/usb/typec/tipd/trace.h | 37 ++++++++++++++++++++++++++++++++++
 2 files changed, 45 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
index c9c30de6e77a..59a4ba797a2c 100644
--- a/drivers/usb/typec/tipd/core.c
+++ b/drivers/usb/typec/tipd/core.c
@@ -109,6 +109,7 @@ struct tipd_data {
 	irq_handler_t irq_handler;
 	int (*register_port)(struct tps6598x *tps, struct fwnode_handle *node);
 	void (*trace_power_status)(u16 status);
+	void (*trace_status)(u32 status);
 };
 
 struct tps6598x {
@@ -468,7 +469,9 @@ static bool tps6598x_read_status(struct tps6598x *tps, u32 *status)
 		dev_err(tps->dev, "%s: failed to read status\n", __func__);
 		return false;
 	}
-	trace_tps6598x_status(*status);
+
+	if (tps->cb.trace_status)
+		tps->cb.trace_status(*status);
 
 	return true;
 }
@@ -1173,18 +1176,21 @@ static const struct tipd_data cd321x_data = {
 	.irq_handler = cd321x_interrupt,
 	.register_port = tps6598x_register_port,
 	.trace_power_status = trace_tps6598x_power_status,
+	.trace_status = trace_tps6598x_status,
 };
 
 static const struct tipd_data tps6598x_data = {
 	.irq_handler = tps6598x_interrupt,
 	.register_port = tps6598x_register_port,
 	.trace_power_status = trace_tps6598x_power_status,
+	.trace_status = trace_tps6598x_status,
 };
 
 static const struct tipd_data tps25750_data = {
 	.irq_handler = tps25750_interrupt,
 	.register_port = tps25750_register_port,
 	.trace_power_status = trace_tps25750_power_status,
+	.trace_status = trace_tps25750_status,
 };
 
 static int tps6598x_probe(struct i2c_client *client)
@@ -1261,10 +1267,8 @@ static int tps6598x_probe(struct i2c_client *client)
 	if (ret)
 		goto err_reset_controller;
 
-	ret = tps6598x_read32(tps, TPS_REG_STATUS, &status);
-	if (ret < 0)
+	if (!tps6598x_read_status(tps, &status))
 		goto err_clear_mask;
-	trace_tps6598x_status(status);
 
 	/*
 	 * This fwnode has a "compatible" property, but is never populated as a
diff --git a/drivers/usb/typec/tipd/trace.h b/drivers/usb/typec/tipd/trace.h
index 739b0a2a867d..0669cca12ea1 100644
--- a/drivers/usb/typec/tipd/trace.h
+++ b/drivers/usb/typec/tipd/trace.h
@@ -91,6 +91,14 @@
 						      TPS_STATUS_USB_HOST_PRESENT_MASK | \
 						      TPS_STATUS_LEGACY_MASK))
 
+#define TPS25750_STATUS_FLAGS_MASK (GENMASK(31, 0) ^ (TPS_STATUS_CONN_STATE_MASK | \
+						      GENMASK(19, 7) | \
+						      TPS_STATUS_VBUS_STATUS_MASK | \
+						      TPS_STATUS_USB_HOST_PRESENT_MASK | \
+						      TPS_STATUS_LEGACY_MASK | \
+						      BIT(26) | \
+						      GENMASK(31, 28)))
+
 #define show_status_conn_state(status) \
 	__print_symbolic(TPS_STATUS_CONN_STATE((status)), \
 		{ TPS_STATUS_CONN_STATE_CONN_WITH_R_A,	"conn-Ra"  }, \
@@ -148,6 +156,14 @@
 		      { TPS_STATUS_HIGH_VOLAGE_WARNING,	"HIGH_VOLAGE_WARNING" }, \
 		      { TPS_STATUS_HIGH_LOW_VOLTAGE_WARNING, "HIGH_LOW_VOLTAGE_WARNING" })
 
+#define show_tps25750_status_flags(flags) \
+	__print_flags((flags & TPS25750_STATUS_FLAGS_MASK), "|", \
+		      { TPS_STATUS_PLUG_PRESENT,	"PLUG_PRESENT" }, \
+		      { TPS_STATUS_PLUG_UPSIDE_DOWN,	"UPSIDE_DOWN" }, \
+		      { TPS_STATUS_PORTROLE,		"PORTROLE" }, \
+		      { TPS_STATUS_DATAROLE,		"DATAROLE" }, \
+		      { TPS_STATUS_BIST,		"BIST" })
+
 #define show_power_status_source_sink(power_status) \
 	__print_symbolic(TPS_POWER_STATUS_SOURCESINK(power_status), \
 		{ 1, "sink" }, \
@@ -292,6 +308,27 @@ TRACE_EVENT(tps6598x_status,
 		    )
 );
 
+TRACE_EVENT(tps25750_status,
+	    TP_PROTO(u32 status),
+	    TP_ARGS(status),
+
+	    TP_STRUCT__entry(
+			     __field(u32, status)
+			     ),
+
+	    TP_fast_assign(
+			   __entry->status = status;
+			   ),
+
+	    TP_printk("conn: %s, vbus: %s, usb-host: %s, legacy: %s, flags: %s",
+		      show_status_conn_state(__entry->status),
+		      show_status_vbus_status(__entry->status),
+		      show_status_usb_host_present(__entry->status),
+		      show_status_legacy(__entry->status),
+		      show_tps25750_status_flags(__entry->status)
+		    )
+);
+
 TRACE_EVENT(tps6598x_power_status,
 	    TP_PROTO(u16 power_status),
 	    TP_ARGS(power_status),
-- 
2.34.1

