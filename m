Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13F8B805E0A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 19:48:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345353AbjLESsd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 13:48:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235059AbjLESs0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 13:48:26 -0500
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71C90D62
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 10:48:31 -0800 (PST)
Received: by mail-il1-x12e.google.com with SMTP id e9e14a558f8ab-35d559a71d8so4595045ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 10:48:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1701802110; x=1702406910; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c83gTiuSNlfK6LuG6NDT4lKYycGtpFWRhFgpMEcF2f0=;
        b=Sd1uSfKeg/vkyrL7j+/8c8WoxdnHmQ94waLtsfDQly9ykwlOR7CW5OVXw9//l1UmB7
         sbdpANDp7hAgHPBb3XYD5a5jzrNuKK87Xlw2M3gKE1BcOed9zJmYRHsdmpzAmvKHwPRq
         IAl1Z0mGy1taoEqa7iD5PYMf+07ubTz/JQOkg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701802110; x=1702406910;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c83gTiuSNlfK6LuG6NDT4lKYycGtpFWRhFgpMEcF2f0=;
        b=qUy6ZHHJbI45yVdqf7AaLJj7PS/7iepZh7YuKA/Gjpv//dr8Pt78JqAAoJH91/dtxo
         hhSaPS/PmWpVgkKNNwFRklFsTiqctll9MXlRuRk5LWoBz35ot0LInoqtekf/LoTpkbJS
         o61cXPTS4VecKR7SD0lXw023DEMHylhxL4vpK0pR32ez3Pb4XRXF7Cdxgvi3P5cLxEMf
         InBrV/JwK/vB9iBYnT+nY8HzCM74yqWjS8MapV8awwfbhHxhZyoYnB0t7V2gXlDsJI/O
         MSQa/gD2ovxxjbtz5hzPaeoJ5rGbhKpxKeaMZnMa0x7RPlFH6hi8PpxdyJUMbk1ruqD0
         HaEA==
X-Gm-Message-State: AOJu0Yy9EmgYZh1HrDa7pyi1T5jX1S1sBA4xC9AI5Vcozm4ff+3D2n7B
        RjC5aGR9y3NnCGUyB+4b0/adXQ==
X-Google-Smtp-Source: AGHT+IGfGYG2l4gFdK0OsrZ02weECf9cy2uaEaj17cAMQGSoXntfIxayPGE2QlhNtQlxn10jqttbVw==
X-Received: by 2002:a05:6e02:2195:b0:35d:5550:76b7 with SMTP id j21-20020a056e02219500b0035d555076b7mr13324536ila.0.1701802110636;
        Tue, 05 Dec 2023 10:48:30 -0800 (PST)
Received: from lbrmn-mmayer.ric.broadcom.net ([192.19.161.248])
        by smtp.gmail.com with ESMTPSA id bd9-20020a656e09000000b0058ee60f8e4dsm8440189pgb.34.2023.12.05.10.48.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 10:48:29 -0800 (PST)
Received: by lbrmn-mmayer.ric.broadcom.net (Postfix, from userid 1000)
        id AD769D06; Tue,  5 Dec 2023 10:48:28 -0800 (PST)
From:   Markus Mayer <mmayer@broadcom.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Markus Mayer <mmayer@broadcom.com>,
        Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>,
        Device Tree Mailing List <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/4] memory: brcmstb_dpfe: support DPFE API v4
Date:   Tue,  5 Dec 2023 10:47:36 -0800
Message-ID: <20231205184741.3092376-4-mmayer@broadcom.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231205184741.3092376-1-mmayer@broadcom.com>
References: <20231205184741.3092376-1-mmayer@broadcom.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for version 4 of the DPFE API. This new version is largely
identical to version 3. The main difference is that all commands now
take the MHS version number as the first argument. Any other arguments
have been pushed down by one (i.e. what used to be arg0 in v3 is arg1 in
v4).

Signed-off-by: Markus Mayer <mmayer@broadcom.com>
---
 drivers/memory/brcmstb_dpfe.c | 31 ++++++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/drivers/memory/brcmstb_dpfe.c b/drivers/memory/brcmstb_dpfe.c
index 66876b409e59..0b0a9b85b605 100644
--- a/drivers/memory/brcmstb_dpfe.c
+++ b/drivers/memory/brcmstb_dpfe.c
@@ -37,6 +37,9 @@
 
 #define DRVNAME			"brcmstb-dpfe"
 
+/* Generic constants */
+#define MHS_VERSION		0x04000000
+
 /* DCPU register offsets */
 #define REG_DCPU_RESET		0x0
 #define REG_TO_DCPU_MBOX	0x10
@@ -301,6 +304,28 @@ static const struct dpfe_api dpfe_api_v3 = {
 	},
 };
 
+/* API v4 firmware commands */
+static struct dpfe_api dpfe_api_v4 = {
+	.version = 4,
+	.fw_name = NULL, /* We expect the firmware to have been downloaded! */
+	.sysfs_attrs = dpfe_v3_groups, /* Same as v3 */
+	.command = {
+		[DPFE_CMD_GET_INFO] = {
+			[MSG_HEADER] = DPFE_MSG_TYPE_COMMAND,
+			[MSG_COMMAND] = 0x0101,
+			[MSG_ARG_COUNT] = 2,
+			[MSG_ARG0] = MHS_VERSION,
+			[MSG_ARG0 + 1] = 1, /* Now the 2nd argument */
+		},
+		[DPFE_CMD_GET_REFRESH] = {
+			[MSG_HEADER] = DPFE_MSG_TYPE_COMMAND,
+			[MSG_COMMAND] = 0x0202,
+			[MSG_ARG_COUNT] = 1,
+			[MSG_ARG0] = MHS_VERSION,
+		},
+	},
+};
+
 static const char *get_error_text(unsigned int i)
 {
 	static const char * const error_text[] = {
@@ -929,8 +954,12 @@ static const struct of_device_id brcmstb_dpfe_of_match[] = {
 	{ .compatible = "brcm,dpfe-cpu-v1", .data = &dpfe_api_old_v2 },
 	{ .compatible = "brcm,dpfe-cpu-v2", .data = &dpfe_api_new_v2 },
 	{ .compatible = "brcm,dpfe-cpu-v3", .data = &dpfe_api_v3 },
+	{ .compatible = "brcm,dpfe-cpu-v4", .data = &dpfe_api_v4 },
 
-	/* API v3 is the default going forward */
+	/*
+	 * For historical reasons, API v3 is the default if nothing else is
+	 * specified.
+	 */
 	{ .compatible = "brcm,dpfe-cpu", .data = &dpfe_api_v3 },
 	{}
 };
-- 
2.43.0

