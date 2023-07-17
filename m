Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AA31755FD2
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 11:50:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231266AbjGQJur (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 05:50:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231283AbjGQJul (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 05:50:41 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1047F1985
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 02:50:28 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3fbd33a57dcso45028235e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 02:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689587426; x=1692179426;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e6AskIt6pGpEXyl/+af7zv317MVh1sWSoDRUXWvbhVc=;
        b=Fw+1GwRvicM3Vt+T5hPWTv1I4io4vyJUrswB9HRPg+TMsLY4TzvDkTokRWKePd3UaX
         ll0O8dcluZQntO0jzW3kSRzrorSK1V2f8SBVhVItDYextFguvdp3aqZP5IUsbOXcnfYw
         C/bUs9iiz3HlppXECd6bK9yib6OQ8AbNx2QrdlK+TOb6h34snN+e/JyK2xB10AMHUKOr
         GW2Qye/vaeGeQ1QsLAqJBvjmE+/tytsd1Pp6iqZYFf1mdBoi/RkgaHqvebLEEL28N22+
         9pQDPNbG4hwEdFoiwyUGWzK9PHVSkEL8QhmeOV6G95SMcPGwTl1lFbAWFd2xx5vOmRde
         UupA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689587426; x=1692179426;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e6AskIt6pGpEXyl/+af7zv317MVh1sWSoDRUXWvbhVc=;
        b=Dm1xj74SWyo5Pxc8MZTNt2LuZ8ZqYwrq3ElN1Wa1kr2e2epkMjvG/Nd1tGnFNubuAU
         Y5HIYQEHgwJXD1qjbodeCR0RVZbYlcRX0/KW+RoPxlY4VPHoyYjtBHITk3EOfrFaEXbG
         9e/SvpMNVbkAx8tb9mjQNw8BDloPInta4d5J1IeYhtZ6u48AVOaAF1V9bqQdybHSs9AG
         iOqGJ20hFUB7OO+sYBkQxFy9DNE3gNycGfqHKNrpw049z+fRxn/paXdydLrQ1ZMttTnB
         Yn80QH8XnmuLeoeTUdLNJpjs0jgful+y1W/vm/wWgygEshQSpPuSK0GnCob9qCnOqS4E
         QfHA==
X-Gm-Message-State: ABy/qLatSePoIPKJEHCOLc4d2XImy3yxd8JXIe3RZfgyGJXEk5otBzM0
        jGo/dtQyTUIJIeFR9kJ6zVth2JAYArPkwTxNLrY=
X-Google-Smtp-Source: APBJJlFcO2hUeFTyIiGMBaQOOPJbTFdAWOHHOtL+x6pYTXFTzTLiIOmpOQir+k0qINWk2OhUsNUflQ==
X-Received: by 2002:adf:f7d0:0:b0:313:f1c8:a963 with SMTP id a16-20020adff7d0000000b00313f1c8a963mr10656889wrq.2.1689587426286;
        Mon, 17 Jul 2023 02:50:26 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id s15-20020adff80f000000b00313f9a0c521sm18777975wrp.107.2023.07.17.02.50.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 02:50:25 -0700 (PDT)
Date:   Mon, 17 Jul 2023 12:50:20 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc:     linux1394-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] firewire: core: revert GFP_ATOMIC changes
Message-ID: <89fe5e6f-d6c3-42d6-bf86-3eb1f4193c1b@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This was recently changed from GFP_ATOMIC to GFP_KERNEL, but Smatch
complains that GFP_ATOMIC is still required:

drivers/firewire/core-topology.c:223 build_tree() warn: sleeping in atomic context

The problematic call trees are:

fw_core_handle_bus_reset() <- spin_lock_irqsave(&card->lock, flags);
-> build_tree()
   -> fw_node_create() <- sleeping allocation

fw_core_handle_bus_reset() <- spin_lock_irqsave(&card->lock, flags);
-> update_tree()
   -> fw_node_event()

This second call tree is a bit complicated because we event is not
FW_NODE_CREATED so we would have to hit a goto create; to hit the
bug.

Fixes: 06f45435d985 ("firewire: core: obsolete usage of GFP_ATOMIC at building node tree")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
From static analysis.  Smatch does not warn about fw_node_event()
because event can't be FW_NODE_CREATED.

 drivers/firewire/core-device.c   | 2 +-
 drivers/firewire/core-topology.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/firewire/core-device.c b/drivers/firewire/core-device.c
index a3104e35412c..aa597cda0d88 100644
--- a/drivers/firewire/core-device.c
+++ b/drivers/firewire/core-device.c
@@ -1211,7 +1211,7 @@ void fw_node_event(struct fw_card *card, struct fw_node *node, int event)
 		 * without actually having a link.
 		 */
  create:
-		device = kzalloc(sizeof(*device), GFP_KERNEL);
+		device = kzalloc(sizeof(*device), GFP_ATOMIC);
 		if (device == NULL)
 			break;
 
diff --git a/drivers/firewire/core-topology.c b/drivers/firewire/core-topology.c
index 88466b663482..f40c81534381 100644
--- a/drivers/firewire/core-topology.c
+++ b/drivers/firewire/core-topology.c
@@ -101,7 +101,7 @@ static struct fw_node *fw_node_create(u32 sid, int port_count, int color)
 {
 	struct fw_node *node;
 
-	node = kzalloc(struct_size(node, ports, port_count), GFP_KERNEL);
+	node = kzalloc(struct_size(node, ports, port_count), GFP_ATOMIC);
 	if (node == NULL)
 		return NULL;
 
-- 
2.39.2

