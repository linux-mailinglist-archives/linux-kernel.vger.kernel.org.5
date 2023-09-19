Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FB9E7A5984
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 07:45:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231462AbjISFpf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 01:45:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231372AbjISFp3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 01:45:29 -0400
Received: from smtp.smtpout.orange.fr (smtp-29.smtpout.orange.fr [80.12.242.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC9C1119
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 22:45:23 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id iTY0qaEMmvRSUiTY0qPDf2; Tue, 19 Sep 2023 07:45:22 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1695102322;
        bh=+ONgWObKo5NbEUwKbwWBJxWXXFQ2LXOOuOi9XpmUiLY=;
        h=From:To:Cc:Subject:Date;
        b=Pr7fg7BKwrXGBU+UQzw7eYkyx/PDNBvtoAkngAPPXsLhm1ZpxMCssQ0iEcTs1lWYN
         zj+tiAENj5aXaJsXeKuGmwLGwwoWugDJGb7B1sxlGby9lVix2TywjY7YKqpTsCQdDa
         3Ho52N59jy9PTrCgkT3MpkmiNa41MSddiR5ihCz2xvolvYvnqxpOCK8+gheKZ/AyDg
         CREPMv9VDynsYCg3MEsJFIQcnCzIrUmyuvys0dDm/126g1NhPP/O7iwhIUjYR/oh3s
         tltzUHzsciDykl9nQkIR/DUqsdYaxKy3ws3a1oQ1iKySVcOgl5ksnlE8KBGyYaFymR
         49X7bCNOOqgkA==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Tue, 19 Sep 2023 07:45:22 +0200
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] stm class: Use memdup_user_nul() to simplify stm_char_policy_set_ioctl()
Date:   Tue, 19 Sep 2023 07:45:19 +0200
Message-Id: <b8fccac27d1ab1eb78525e12616b9279687cc27e.1695102301.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of hand-writing kzalloc(size+1) + copy_from_user(size), use
memdup_user_nul() that does the same with a few less lines of code.

This also saves a useless zeroing of the allocated memory.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/hwtracing/stm/core.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/hwtracing/stm/core.c b/drivers/hwtracing/stm/core.c
index 534fbefc7f6a..3ee98208ea8f 100644
--- a/drivers/hwtracing/stm/core.c
+++ b/drivers/hwtracing/stm/core.c
@@ -739,19 +739,11 @@ static int stm_char_policy_set_ioctl(struct stm_file *stmf, void __user *arg)
 	if (size < sizeof(*id) || size >= PATH_MAX + sizeof(*id))
 		return -EINVAL;
 
-	/*
-	 * size + 1 to make sure the .id string at the bottom is terminated,
-	 * which is also why memdup_user() is not useful here
-	 */
-	id = kzalloc(size + 1, GFP_KERNEL);
+	/* Make sure the .id string at the bottom is nul terminated. */
+	id = memdup_user_nul(arg, size);
 	if (!id)
 		return -ENOMEM;
 
-	if (copy_from_user(id, arg, size)) {
-		ret = -EFAULT;
-		goto err_free;
-	}
-
 	if (id->__reserved_0 || id->__reserved_1)
 		goto err_free;
 
-- 
2.34.1

