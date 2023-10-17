Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76A577CC9A8
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 19:17:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234836AbjJQRRC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 13:17:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232644AbjJQRRA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 13:17:00 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A2B594;
        Tue, 17 Oct 2023 10:16:59 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-507c5249d55so473834e87.3;
        Tue, 17 Oct 2023 10:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697563017; x=1698167817; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IYoT3W04IrhjBaHMC+q53PN/kEQ0V1Lm63ZKZoqvGHY=;
        b=foo5A4QAnSrC3i0EcRw0Pbo+7xNtw5SgNIRClSV9/27tTIVUJJBUKrStge4dg1cNiH
         3KFonxr5OcHQWVeusoQa5IG+xRNONJ383rBkYlf3ziSAiqf4C0bOk39FC7Ri8cTRYa0x
         CASYHrY3B50D5xE6sM1BVF8M6PWgRg0okz98OO+sA+GDqcBoTR0dSZGLObOowwBWYPv+
         Nx4FPBTAGXxU0ydSVRK1AaphGy+7ZKOQAOSGVu1ZXXVnLS0MzbLiiON6T6qErN31zal7
         Ck/mWNVIqr1dCQI9dzQ7N+24pMEAFZCMw2iVcTW/Q0UFbMX7mpIpOafjC6q9CjjkXjI4
         EOCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697563017; x=1698167817;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IYoT3W04IrhjBaHMC+q53PN/kEQ0V1Lm63ZKZoqvGHY=;
        b=GKHyIW0KTr2W9tlLeMsQMjdex7Y3Ayo3NDzpNRrHhZRsSsN1LhfZ/rFPp5LCXFPhrD
         Csb3ibd0r0531zrOq0wIj6r9y4qOMzqpmcpYuLucZWECwk6hXaJGVwupv5xIz2gk9JTI
         DZcINHI7MkHLsmj2tfXof9f/ERCbZ6+hwyLB6NgE2MzRaSfHVNjVJqLoLh4CzgUAdeTx
         IjQ1L7HDw8tE1WZC80lrs4t5Wp3VRzhPCvk+NOhOkYmJMQVS4eTEsk0GkECX/0/oEwNl
         k99eyDON2ki0pLrYvRqn9/WCDjCFUQ3iZoaVwqiGaIhxK8j+6YaTBTBj+OYK1+FGYDNC
         9VKw==
X-Gm-Message-State: AOJu0Yyj6xLOERcDZmMt7skwAItM1El8bDRI0GxaeDsS9EWJ5kaiDKnk
        3cn1jj9sjY/6mJIhdMPoQfs=
X-Google-Smtp-Source: AGHT+IFbcy6/T16w7bhth7PlPONFUqvdynPhiYpb/v0yCKZWtTLTirhDYAVV1gtNts+zKzO4tBVnzQ==
X-Received: by 2002:a05:6512:3102:b0:507:9b70:1f0e with SMTP id n2-20020a056512310200b005079b701f0emr2460991lfb.24.1697563017147;
        Tue, 17 Oct 2023 10:16:57 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id iv13-20020a05600c548d00b004064cd71aa8sm2415838wmb.34.2023.10.17.10.16.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 10:16:56 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] thermal: lvts: make some read-only arrays static const
Date:   Tue, 17 Oct 2023 18:16:55 +0100
Message-Id: <20231017171655.177096-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Don't populate the read-only arrays on the stack, instead make them
static const. Make lvts_write_config parameters cmds and nr_cmds
const too.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/thermal/mediatek/lvts_thermal.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/mediatek/lvts_thermal.c
index 877a0e5ac3fd..b20e69cb466f 100644
--- a/drivers/thermal/mediatek/lvts_thermal.c
+++ b/drivers/thermal/mediatek/lvts_thermal.c
@@ -308,7 +308,7 @@ static int lvts_get_temp(struct thermal_zone_device *tz, int *temp)
 
 static void lvts_update_irq_mask(struct lvts_ctrl *lvts_ctrl)
 {
-	u32 masks[] = {
+	static const u32 masks[] = {
 		LVTS_MONINT_OFFSET_SENSOR0,
 		LVTS_MONINT_OFFSET_SENSOR1,
 		LVTS_MONINT_OFFSET_SENSOR2,
@@ -400,7 +400,7 @@ static irqreturn_t lvts_ctrl_irq_handler(struct lvts_ctrl *lvts_ctrl)
 {
 	irqreturn_t iret = IRQ_NONE;
 	u32 value;
-	u32 masks[] = {
+	static const u32 masks[] = {
 		LVTS_INT_SENSOR0,
 		LVTS_INT_SENSOR1,
 		LVTS_INT_SENSOR2,
@@ -781,7 +781,7 @@ static int lvts_ctrl_init(struct device *dev, struct lvts_domain *lvts_td,
  * each write in the configuration register must be separated by a
  * delay of 2 us.
  */
-static void lvts_write_config(struct lvts_ctrl *lvts_ctrl, u32 *cmds, int nr_cmds)
+static void lvts_write_config(struct lvts_ctrl *lvts_ctrl, const u32 *cmds, const int nr_cmds)
 {
 	int i;
 
@@ -865,7 +865,8 @@ static int lvts_ctrl_set_enable(struct lvts_ctrl *lvts_ctrl, int enable)
 
 static int lvts_ctrl_connect(struct device *dev, struct lvts_ctrl *lvts_ctrl)
 {
-	u32 id, cmds[] = { 0xC103FFFF, 0xC502FF55 };
+	u32 id;
+	static const u32 cmds[] = { 0xC103FFFF, 0xC502FF55 };
 
 	lvts_write_config(lvts_ctrl, cmds, ARRAY_SIZE(cmds));
 
@@ -889,7 +890,7 @@ static int lvts_ctrl_initialize(struct device *dev, struct lvts_ctrl *lvts_ctrl)
 	/*
 	 * Write device mask: 0xC1030000
 	 */
-	u32 cmds[] = {
+	static const u32 cmds[] = {
 		0xC1030E01, 0xC1030CFC, 0xC1030A8C, 0xC103098D, 0xC10308F1,
 		0xC10307A6, 0xC10306B8, 0xC1030500, 0xC1030420, 0xC1030300,
 		0xC1030030, 0xC10300F6, 0xC1030050, 0xC1030060, 0xC10300AC,
-- 
2.39.2

