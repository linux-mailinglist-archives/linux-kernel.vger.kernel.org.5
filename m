Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE9087FAD65
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 23:22:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234427AbjK0WWg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 17:22:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233867AbjK0WWI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 17:22:08 -0500
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a02:c205:3004:2154::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E0CA4C27;
        Mon, 27 Nov 2023 14:19:22 -0800 (PST)
Received: from p200301077700a9001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:107:7700:a900:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <andreas@kemnade.info>)
        id 1r7jwh-006myV-Sg; Mon, 27 Nov 2023 23:19:15 +0100
Received: from andi by aktux with local (Exim 4.96)
        (envelope-from <andreas@kemnade.info>)
        id 1r7jwh-000kAm-25;
        Mon, 27 Nov 2023 23:19:15 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        bcousson@baylibre.com, tony@atomide.com, andreas@kemnade.info,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org
Subject: [PATCH v2 5/6] mfd: twl4030-power: accept standard property for power controller
Date:   Mon, 27 Nov 2023 23:19:06 +0100
Message-Id: <20231127221907.177442-6-andreas@kemnade.info>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231127221907.177442-1-andreas@kemnade.info>
References: <20231127221907.177442-1-andreas@kemnade.info>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of only accepting the ti specific properties accept also
the standard property. For uniformity, search in the parent node
for the tag. The code for powering of is also isolated from the
rest in this file. So it is a pure Linux design decision to put it
here.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
 drivers/mfd/twl4030-power.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mfd/twl4030-power.c b/drivers/mfd/twl4030-power.c
index e35b0f788c504..3ef892e63b88f 100644
--- a/drivers/mfd/twl4030-power.c
+++ b/drivers/mfd/twl4030-power.c
@@ -686,6 +686,9 @@ static bool twl4030_power_use_poweroff(const struct twl4030_power_data *pdata,
 	if (of_property_read_bool(node, "ti,use_poweroff"))
 		return true;
 
+	if (of_device_is_system_power_controller(node->parent))
+		return true;
+
 	return false;
 }
 
-- 
2.39.2

