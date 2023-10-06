Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 940EA7BC171
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 23:44:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233730AbjJFVof (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 17:44:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233759AbjJFVod (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 17:44:33 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BABFDB
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 14:44:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46C59C433C7;
        Fri,  6 Oct 2023 21:44:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696628671;
        bh=UOwYY4Wdrq3qaLX+ulY/AMB64MrwJnjkGbdwZBFe+cQ=;
        h=From:To:Cc:Subject:Date:From;
        b=RZ2kN0AUd6/zzh5L2ZWT9+G1ByFse8EGnk93FT1xyuGuiUcVJJWFmjvQFwkPYMQ6b
         /8f3y6OOtmXkQEvO7Ri5xTxH8PPRgYf7E2b/e7LbHLMFaW+ZrGXb6qf89dDwun0xme
         ffrUtPzoJFVo9RxkfSOh6OllDq75uTrQP3JoI7opI/gF4UX9I0kg/1rzzygKEKZYc9
         Ui8PF6gzqjI007PHyR7lGS9DzJVw3bhPRxicyKau98Ktc4pMUcUF+bxFAtMdkFiH8q
         JNjkO7Z9gykrEMCPLncN+aK03GKG6NkfxHjGy7QBktiwhP7znvGMAeIOUMFhHgG351
         E/zesisGisnDw==
Received: (nullmailer pid 339633 invoked by uid 1000);
        Fri, 06 Oct 2023 21:44:30 -0000
From:   Rob Herring <robh@kernel.org>
To:     Chas Williams <3chas3@gmail.com>
Cc:     linux-atm-general@lists.sourceforge.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] atm: fore200e: Drop unnecessary of_match_device()
Date:   Fri,  6 Oct 2023 16:44:21 -0500
Message-Id: <20231006214421.339445-1-robh@kernel.org>
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

It is not necessary to call of_match_device() in probe. If we made it to
probe, then we've already successfully matched.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/atm/fore200e.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/atm/fore200e.c b/drivers/atm/fore200e.c
index fb2be3574c26..50d8ce20ae5b 100644
--- a/drivers/atm/fore200e.c
+++ b/drivers/atm/fore200e.c
@@ -36,7 +36,7 @@
 
 #ifdef CONFIG_SBUS
 #include <linux/of.h>
-#include <linux/of_device.h>
+#include <linux/platform_device.h>
 #include <asm/idprom.h>
 #include <asm/openprom.h>
 #include <asm/oplib.h>
@@ -2520,18 +2520,12 @@ static int fore200e_init(struct fore200e *fore200e, struct device *parent)
 }
 
 #ifdef CONFIG_SBUS
-static const struct of_device_id fore200e_sba_match[];
 static int fore200e_sba_probe(struct platform_device *op)
 {
-	const struct of_device_id *match;
 	struct fore200e *fore200e;
 	static int index = 0;
 	int err;
 
-	match = of_match_device(fore200e_sba_match, &op->dev);
-	if (!match)
-		return -EINVAL;
-
 	fore200e = kzalloc(sizeof(struct fore200e), GFP_KERNEL);
 	if (!fore200e)
 		return -ENOMEM;
-- 
2.40.1

