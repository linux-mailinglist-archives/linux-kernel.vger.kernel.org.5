Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DC5B7549DB
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 17:43:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbjGOPnM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jul 2023 11:43:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbjGOPnK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jul 2023 11:43:10 -0400
Received: from out203-205-221-233.mail.qq.com (out203-205-221-233.mail.qq.com [203.205.221.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 474A22691
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jul 2023 08:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1689435486;
        bh=tH77A15Ade+v8Xa3lNIHljdaKcKR/DpW3s/OQ9AJ5WE=;
        h=From:To:Cc:Subject:Date;
        b=OCJOIkGhJUXxE85RdGXsQO7eWTeR78fLPkeSefJP7G5S5PWPGVl/mEDl/BuFqb95D
         EU94F0IJpH76umy4U5855TlgWV4MoAtK9qmeycXF9biQTtrS0sh14voRu59RGAg1EX
         ULOkRJpkqxLu1duQLQ0tgrFR5SahnyA5RKYjx8cw=
Received: from KernelDevBox.byted.org ([180.184.103.200])
        by newxmesmtplogicsvrszb6-0.qq.com (NewEsmtp) with SMTP
        id 9841C8C2; Sat, 15 Jul 2023 23:38:04 +0800
X-QQ-mid: xmsmtpt1689435484tpuwmxqwc
Message-ID: <tencent_01B5405B3460691E170AA1A81F1256375908@qq.com>
X-QQ-XMAILINFO: MyIXMys/8kCtqlzyZD5fZ66S5O1yMINElNdDOXiFXViD2bjV6oZcWseDr7zDdv
         ti9FENQv3bnbvkBoDIVJBYSOOclwxdKiONknmMyiLp7S1PvCnp12i1Olc2XYY3TzJHgYe96+NwI3
         g9i1Y2xQmqAYM998dHb7zKTFUuwQb+KQO/XT++pCw7t/5p1ZYaX+mpM6WlyyF7USDMBt7XR3MrZn
         gui5iU8SIZ+8eOFf7z/ybIMTINEmvmSqXqbE69zMUnBOgTDb+JoGrlvkZytKZx3t9Gv4HryWH99V
         lkJX6bz4pX8lR4HWV75Ou0i9g4IXfkjAk60LlKl+EPkt88linoGGjCQzcGCK6llhovjVl4REUt8a
         8DihDC5Jc/GgA6oA5ZaCcWxf0Nd3ASsUe+n+ZouJdryvip6sqFDdTWOe/85GYuynbSmY+IiInazK
         VIq2AzrnNRqPwbEuTIEl67qVhOmb/3Ltl/auJb85kbJIcfKkkQV0EkzO+kqOeyVCI9XrKZ5okZN4
         LcUooAI9LsPL+cuABBDBPJiJLYW7JgyhXroBJEI4+XLsRI00nZ9L/YjO4hPYEPefPmqdA3sD2y/Y
         5crWgbtDPYr3X2aW5ZX+eeK1TFRDQSO1a79PuvpQuyDJc3khcu6oQvJEh2gBHp9O1k5R2frlhYf6
         L5cWYrdANU59defCIOLdGzFEu9EibPtATSpY7O5PgifwhP5VZw0XuaWFpdrsMFH8ahmnKD5/lGXk
         hI6gRYUrPzNuLHN0EBbBziQDKMsBG0XRwBjOFXVgllpPi2xhj+PpW6bzQE0Ju6yYeDWSIKjHQWtq
         sqZVSTG+950J1xr7qjAiii6rL95biXX2PonFxbhAemlK6pWJJveXWNJh2xBm0EXu+994Qw828MtX
         IjHpOHWFNJOxyl39x8f7+dIQbVURmlLIZIXRqPuxN2YOCu1epiyldGPrMurHJlhYzW9hlzbPHpic
         JEg0LOWj4lCUSaE4aZlYGQCy5cAqt2142C6TSPsgNEfgjByksY8P07pQ2qX10fhIcT/Cc3+O4=
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
From:   Zhang Shurong <zhang_shurong@foxmail.com>
To:     vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zhang Shurong <zhang_shurong@foxmail.com>
Subject: [PATCH] dmaengine: mv_xor: fix to avoid potential NULL pointer dereference
Date:   Sat, 15 Jul 2023 23:38:03 +0800
X-OQ-MSGID: <20230715153803.2275585-1-zhang_shurong@foxmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_BLOCKED,RDNS_DYNAMIC,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

of_match_device() may fail and returns a NULL pointer.

Fix this by checking the return value of of_match_device().

Fixes: dd130c652cb7 ("dmaengine: mv_xor: use SoC type instead of directly the operation mode")
Signed-off-by: Zhang Shurong <zhang_shurong@foxmail.com>
---
 drivers/dma/mv_xor.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/dma/mv_xor.c b/drivers/dma/mv_xor.c
index 23b232b57518..317815ec1dd6 100644
--- a/drivers/dma/mv_xor.c
+++ b/drivers/dma/mv_xor.c
@@ -1333,6 +1333,9 @@ static int mv_xor_probe(struct platform_device *pdev)
 			of_match_device(mv_xor_dt_ids,
 					&pdev->dev);
 
+		if (!of_id)
+			return -ENODEV;
+
 		xordev->xor_type = (uintptr_t)of_id->data;
 	}
 
-- 
2.30.2

