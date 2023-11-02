Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4C4E7DEC85
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 06:52:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232278AbjKBFvn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 01:51:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230319AbjKBFvm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 01:51:42 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC9D3116;
        Wed,  1 Nov 2023 22:51:38 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id 5614622812f47-3b3e13fc1f7so358764b6e.0;
        Wed, 01 Nov 2023 22:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698904298; x=1699509098; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1rNVTOYzg1T8LSeT98N14So2HKEm2/4/i4nFsHZ5hrA=;
        b=IvTmaMLW8ZR6fjUHcABC37Jm8e1wrkvYmGcEHlOcSvw/Wj/36VJ2iAcPwiy8eTZzhS
         qNa1NOrJs3N2rYf5Gm+AZPXRBwQy0I/F7ra3lT6hlv+lRU4lgJ66ffchpU8o+vqG/bT1
         vcVf0PF8ftGks4Wo///eHMIpek1ERSpYpSf1BdMz+I1B5iaHOQNhYNaoYzZe3I/sadLI
         UxjDMxleagv2iekYp3Vd2A8gMrVxbAuViuRG6TUSY8TMcLdDhHQlv1Lx48iIopW+TtQJ
         UQHINgdSueCnAh2c2qUuUHEc15rUte0KJBO57AOFOOYVh7B9X94YRf0QiezO5zCPerJr
         9/xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698904298; x=1699509098;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1rNVTOYzg1T8LSeT98N14So2HKEm2/4/i4nFsHZ5hrA=;
        b=mcit172+NevKZZzkFn+RnPWds+IMtvdd1jbe0lYwZT5oXAA5+SYE0VHZHViJZBXwK6
         9/+m6/1Jo4oiPlT5RrT+3w6LAiwqOnDF3LdTPVAwBm6z+AjFGtboHpXbya+lyxybS2cm
         WhpZxcIsnAssMctXxtq1WUy1NzBWi+zZsXAef9uhP+72D+V4HXCVn7DVy5lhS6la7Zkv
         n5PJPRqMZHK9q3RBZA2/Wbfz9Sc30+RzsjCbxOA1Gu5Z99R87BxyOFgqvZzk7mBxeQ6U
         +mZcQT5mKGqSr/qOqdyyRqoKaYkDSrSXbD4xAD/5lgxCmdX+dWhDh+iwI9rtvdw4SLrr
         fmxw==
X-Gm-Message-State: AOJu0YzZIVztQzYA/W5WjYR7WYbR8zVB9+yXXIP52lG4X4KpVXalMq4e
        n160CxaU13APAwZKptn77dg=
X-Google-Smtp-Source: AGHT+IHYMFpEG3Jl5+tmBRGQz8dDUvy6BpTDMmz4f3y6MvPNlpNgM3G12CxKGKU1/VE7HETeK0eWeQ==
X-Received: by 2002:a05:6808:1528:b0:3b5:75e7:bcea with SMTP id u40-20020a056808152800b003b575e7bceamr6458060oiw.57.1698904298091;
        Wed, 01 Nov 2023 22:51:38 -0700 (PDT)
Received: from localhost.localdomain ([58.48.52.254])
        by smtp.gmail.com with ESMTPSA id i10-20020aa787ca000000b0069337938be8sm2090023pfo.110.2023.11.01.22.51.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Nov 2023 22:51:37 -0700 (PDT)
From:   "xinglong.yang" <seanyang230@gmail.com>
X-Google-Original-From: "xinglong.yang" <xinglong.yang@cixtech.com>
To:     xinglong.yang@cixtech.com, rafael@kernel.org,
        daniel.lezcano@linaro.org, amitk@kernel.org, rui.zhang@intel.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] driver: thermal: simplify the traverse of sensor in thermal_zone.
Date:   Thu,  2 Nov 2023 13:51:20 +0800
Message-ID: <20231102055120.1192015-1-xinglong.yang@cixtech.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The number of sensor in a thermal zone needs to be greater than zero
and equal to one. Add the opinion when the number of sensor is greater
than one in a thermal zone.

There is also no need to traverse the sensor in the thermal zone,
because there is only one sensor on one thermal zone.

Signed-off-by: xinglong.yang <xinglong.yang@cixtech.com>
---
 drivers/thermal/thermal_of.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
index e615f735f4c0..a405754c42cd 100644
--- a/drivers/thermal/thermal_of.c
+++ b/drivers/thermal/thermal_of.c
@@ -186,6 +186,7 @@ static struct device_node *of_thermal_zone_find(struct device_node *sensor, int
 	for_each_available_child_of_node(np, tz) {
 
 		int count, i;
+		int ret;
 
 		count = of_count_phandle_with_args(tz, "thermal-sensors",
 						   "#thermal-sensor-cells");
@@ -193,26 +194,25 @@ static struct device_node *of_thermal_zone_find(struct device_node *sensor, int
 			pr_err("%pOFn: missing thermal sensor\n", tz);
 			tz = ERR_PTR(-EINVAL);
 			goto out;
+		} else if (count > 1) {
+			pr_err("%pOFn: number of thermal sensor greater than one\n", tz);
+			tz = ERR_PTR(-EINVAL);
+			goto out;
 		}
 
-		for (i = 0; i < count; i++) {
-
-			int ret;
-
-			ret = of_parse_phandle_with_args(tz, "thermal-sensors",
-							 "#thermal-sensor-cells",
-							 i, &sensor_specs);
-			if (ret < 0) {
-				pr_err("%pOFn: Failed to read thermal-sensors cells: %d\n", tz, ret);
-				tz = ERR_PTR(ret);
-				goto out;
-			}
+		ret = of_parse_phandle_with_args(tz, "thermal-sensors",
+						 "#thermal-sensor-cells",
+						 0, &sensor_specs);
+		if (ret < 0) {
+			pr_err("%pOFn: Failed to read thermal-sensors cells: %d\n", tz, ret);
+			tz = ERR_PTR(ret);
+			goto out;
+		}
 
-			if ((sensor == sensor_specs.np) && id == (sensor_specs.args_count ?
-								  sensor_specs.args[0] : 0)) {
-				pr_debug("sensor %pOFn id=%d belongs to %pOFn\n", sensor, id, tz);
-				goto out;
-			}
+		if ((sensor == sensor_specs.np) && id == (sensor_specs.args_count ?
+							  sensor_specs.args[0] : 0)) {
+			pr_debug("sensor %pOFn id=%d belongs to %pOFn\n", sensor, id, tz);
+			goto out;
 		}
 	}
 	tz = ERR_PTR(-ENODEV);
-- 
2.42.0

