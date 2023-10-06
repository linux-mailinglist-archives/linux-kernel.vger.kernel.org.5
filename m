Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A72EC7BC167
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 23:43:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233724AbjJFVnM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 17:43:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233504AbjJFVnK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 17:43:10 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B49C7CA
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 14:43:08 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF39DC433C7;
        Fri,  6 Oct 2023 21:43:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696628588;
        bh=ueT+PDq/dcVRZVlCN00GU9z103GTs29FEWL1o6CcU4U=;
        h=From:To:Cc:Subject:Date:From;
        b=WwmSMrz+9sq/ZkBRA6lUw48zeNBb8P7ryVSVAC5SocsMkZPe3oKjBkev7+qw0a6nh
         gyMnC5zP+LEG+ay1SjHZgVDmenbZosRzRSRkQ/GjqPAgjPc0WKNRLuuaTfikDySoHB
         fUPqsm6bPsUTEa8CIv6NhvY4bVtevCyutZxsyqQroavcnnA8x8Z2RD3U7UImKu5snu
         v22RBPHT3D0F809re4a9C/AgG1ABvdmw0NDup71DHFi4QoMBF0E0/zU8/yFb034zbI
         EgsQvm2njgfdAwlpPlrdYQJfxbfEZvH7+cW40Eak857UY8UdcfzDR+5cYHnf4OumlH
         6Fgdeko0K4kaw==
Received: (nullmailer pid 337927 invoked by uid 1000);
        Fri, 06 Oct 2023 21:43:07 -0000
From:   Rob Herring <robh@kernel.org>
To:     Corey Minyard <minyard@acm.org>
Cc:     openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ipmi: si: Use device_get_match_data()
Date:   Fri,  6 Oct 2023 16:42:52 -0500
Message-Id: <20231006214252.337588-1-robh@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use preferred device_get_match_data() instead of of_match_device() to
get the driver match data. With this, adjust the includes to explicitly
include the correct headers.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/char/ipmi/ipmi_si_platform.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/char/ipmi/ipmi_si_platform.c b/drivers/char/ipmi/ipmi_si_platform.c
index c3d8ac7873ba..cd2edd8f8a03 100644
--- a/drivers/char/ipmi/ipmi_si_platform.c
+++ b/drivers/char/ipmi/ipmi_si_platform.c
@@ -11,10 +11,11 @@
 
 #include <linux/types.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
-#include <linux/of_platform.h>
+#include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
+#include <linux/platform_device.h>
+#include <linux/property.h>
 #include <linux/acpi.h>
 #include "ipmi_si.h"
 #include "ipmi_dmi.h"
@@ -224,7 +225,6 @@ MODULE_DEVICE_TABLE(of, of_ipmi_match);
 
 static int of_ipmi_probe(struct platform_device *pdev)
 {
-	const struct of_device_id *match;
 	struct si_sm_io io;
 	struct resource resource;
 	const __be32 *regsize, *regspacing, *regshift;
@@ -237,10 +237,6 @@ static int of_ipmi_probe(struct platform_device *pdev)
 
 	dev_info(&pdev->dev, "probing via device tree\n");
 
-	match = of_match_device(of_ipmi_match, &pdev->dev);
-	if (!match)
-		return -ENODEV;
-
 	if (!of_device_is_available(np))
 		return -EINVAL;
 
@@ -269,7 +265,7 @@ static int of_ipmi_probe(struct platform_device *pdev)
 	}
 
 	memset(&io, 0, sizeof(io));
-	io.si_type	= (unsigned long) match->data;
+	io.si_type	= (enum si_type)device_get_match_data(&pdev->dev);
 	io.addr_source	= SI_DEVICETREE;
 	io.irq_setup	= ipmi_std_irq_setup;
 
-- 
2.40.1

