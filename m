Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9C847DEEF9
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 10:33:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345658AbjKBJdt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 05:33:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjKBJdr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 05:33:47 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E1CC132;
        Thu,  2 Nov 2023 02:33:44 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1cc9391884aso361885ad.2;
        Thu, 02 Nov 2023 02:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698917624; x=1699522424; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Yl2RNYa6wlW4u+3YKDs7TAIJG8OkxNjGFmYJ+LCMi/c=;
        b=cMTdUm16+ZuKCmGFXtHZHYItZ8FSZtIFKx1U67jc3h8wbS6wGijBpQhQPC0TdmsEQV
         hG2XzZDIjnbpaefhKwctisygT4+hXhVtAO9F/cFLwf+xcP00pbNcydoETykLZBKXbwUH
         3jXyCoNTo8z6BzVh5M0lKG9nCQ5j4rSlsANl43r26heTcD/mmirFiDt4sye9q2+HIWn4
         mxf8x0tU2brEnVNHAcREnwwQIb2V2fq0+3Ys2o4XQy1BWahWgUW9CQE0l9KhZvTQ3Yp7
         WkAf50iLPhmeWwsyWjpWsc0o5eBBX+KdrMTc3NHbyUuz2qH/j6R8Hjpv2Lg/QV2sP53Y
         JDAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698917624; x=1699522424;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yl2RNYa6wlW4u+3YKDs7TAIJG8OkxNjGFmYJ+LCMi/c=;
        b=WVQ0botbuseVv31hNdnVKR7lFhcooyiPJ92q2aDq+/Zs3EvFGVc+hTmVe050cyMciE
         nYU6CF8854zSr4d2e7jMgHn0TP3hO3oFZCBVb8NrgDA4d4DOm+66/fz+4JEz4TeWsbVJ
         S5ESaPC8V5fQ25JYdk2QKHTqV9SyF2b5uIcbzVoEK9510+6eQl9qrVUchyderSmBJU/h
         K5yR4dUHN0XWW95l5IgQDnG1ZgXYb9WiGayKXPfAd2ABLXXepNFWjk8TOHcBvgylqWtP
         6TneGG/82NW2NHiBal6UBXi0k9UcbaCXvzgPkUEe3L4vcmYnVIriD5pBYIAEQQ01GS0h
         gK6g==
X-Gm-Message-State: AOJu0Yx13dvhEGlYkNVGmgSRRH3yNLSXfgsGll3MyziFCU7989LCC92T
        N/oSgwb8DOFbP0rmOPveh80=
X-Google-Smtp-Source: AGHT+IE9aiQsmhdgSw/hPL1ANVIjHhSdosoYt30VtelmHetz1ugFwnPKMeuPHRcl2RrWUnYdtKjWxA==
X-Received: by 2002:a17:902:cecb:b0:1cc:4ff3:c837 with SMTP id d11-20020a170902cecb00b001cc4ff3c837mr10989033plg.68.1698917623615;
        Thu, 02 Nov 2023 02:33:43 -0700 (PDT)
Received: from localhost.localdomain ([58.48.52.254])
        by smtp.gmail.com with ESMTPSA id i14-20020a17090332ce00b001c9ccbb8fdasm2675212plr.260.2023.11.02.02.33.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Nov 2023 02:33:43 -0700 (PDT)
From:   "xinglong.yang" <seanyang230@gmail.com>
X-Google-Original-From: "xinglong.yang" <xinglong.yang@cixtech.com>
To:     xinglong.yang@cixtech.com, rafael@kernel.org,
        daniel.lezcano@linaro.org, amitk@kernel.org, rui.zhang@intel.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] driver: thermal: simplify the traverse of sensor in thermal_zone.
Date:   Thu,  2 Nov 2023 17:33:34 +0800
Message-ID: <20231102093334.1363324-1-xinglong.yang@cixtech.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
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
 drivers/thermal/thermal_of.c | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
index e615f735f4c0..c800599e7ebd 100644
--- a/drivers/thermal/thermal_of.c
+++ b/drivers/thermal/thermal_of.c
@@ -185,7 +185,8 @@ static struct device_node *of_thermal_zone_find(struct device_node *sensor, int
 	 */
 	for_each_available_child_of_node(np, tz) {
 
-		int count, i;
+		int count;
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

