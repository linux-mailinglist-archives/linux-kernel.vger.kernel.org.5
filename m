Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B386B7FD97E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 15:34:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234343AbjK2Oej (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 09:34:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231195AbjK2Oeg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 09:34:36 -0500
Received: from m15.mail.163.com (m15.mail.163.com [45.254.50.219])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D6D5219A;
        Wed, 29 Nov 2023 06:34:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=5srYGa010zaXPgeYMU
        4ezpiryKXspoRb2NGozsAbp6M=; b=RixMxYKO/qJUdWCkylWy7m/RrTLJBq9eJj
        aXSL4WVeIjysSLrAZh0qTpmO7IaUu5XXTf3QFwR+I/QRqkbaPGmz4M76jKReCB8p
        cmynjGx3JagnSaslOPwFtPxDC7zAG8R2VbdXD89oPT5LcPDDf39X+t1ABWBztoFb
        SlWR2Kygg=
Received: from localhost.localdomain (unknown [39.144.190.126])
        by zwqz-smtp-mta-g1-2 (Coremail) with SMTP id _____wCn7274S2dl2svTAQ--.48522S2;
        Wed, 29 Nov 2023 22:34:34 +0800 (CST)
From:   Haoran Liu <liuhaoran14@163.com>
To:     geert+renesas@glider.be
Cc:     magnus.damm@gmail.com, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Haoran Liu <liuhaoran14@163.com>
Subject: [PATCH] [soc/renesas] renesas-soc: Add error handling in renesas_soc_init
Date:   Wed, 29 Nov 2023 06:34:31 -0800
Message-Id: <20231129143431.34459-1-liuhaoran14@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: _____wCn7274S2dl2svTAQ--.48522S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7KF17KFy8ZrW7GryfKr4DJwb_yoW8WFWrpa
        1kCws8AryUG3WxZ39xGa1xZ3WSya18KrWSkr1DKwn7u3WrXFyUtF12vFyY9r1UWFWv93WY
        qF4Uu345Ar1UCFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pR9a9xUUUUU=
X-Originating-IP: [39.144.190.126]
X-CM-SenderInfo: xolxxtxrud0iqu6rljoofrz/xtbBcgM3gletj5Wr-wAAsw
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch enhances the renesas_soc_init function in
drivers/soc/renesas/renesas-soc.c by adding error handling for the
of_property_read_string call. Previously, the function did not check
for failure cases of of_property_read_string, which could lead to
improper behavior if the required device tree properties were missing
or incorrect.

Although the error addressed by this patch may not occur in the current
environment, I still suggest implementing these error handling routines
if the function is not highly time-sensitive. As the environment evolves
or the code gets reused in different contexts, there's a possibility that
these errors might occur. Addressing them now can prevent potential
debugging efforts in the future, which could be quite resource-intensive.

Signed-off-by: Haoran Liu <liuhaoran14@163.com>
---
 drivers/soc/renesas/renesas-soc.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/renesas/renesas-soc.c b/drivers/soc/renesas/renesas-soc.c
index c732d4a5b26a..7a5f5c426118 100644
--- a/drivers/soc/renesas/renesas-soc.c
+++ b/drivers/soc/renesas/renesas-soc.c
@@ -487,7 +487,13 @@ static int __init renesas_soc_init(void)
 	}
 
 	np = of_find_node_by_path("/");
-	of_property_read_string(np, "model", &soc_dev_attr->machine);
+	ret = of_property_read_string(np, "model", &soc_dev_attr->machine);
+	if (ret) {
+		dev_err(dev, "Failed to read model property: %d\n", ret);
+		kfree(soc_dev_attr);
+		return ret;
+	}
+
 	of_node_put(np);
 
 	soc_dev_attr->family = kstrdup_const(family->name, GFP_KERNEL);
-- 
2.17.1

