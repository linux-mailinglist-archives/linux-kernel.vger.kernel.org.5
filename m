Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 108827DBAB0
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 14:27:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233400AbjJ3N1n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 09:27:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232760AbjJ3N1l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 09:27:41 -0400
Received: from smtp.smtpout.orange.fr (smtp-22.smtpout.orange.fr [80.12.242.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91FE797
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 06:27:37 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id xSIoq4DJYLilFxSIpqpweO; Mon, 30 Oct 2023 14:27:35 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1698672455;
        bh=/DkN5aD3T5Ca9TtQI/yHLRzDeLFOsujUxsYE2YCrNlU=;
        h=From:To:Cc:Subject:Date;
        b=G7g6nIpo2eAt6Fz7quD13L6Gm0WeEBDbpvi0RJGBjXKcpZ/DjQCWzwqv1Gl94Ny3h
         2idDLo5gCuCq53k/KKKiHBbbfY7iDz8q27xlbLOO14yiW+GsHza75cm1yx5yOw1Ao6
         ibW7+WoTLu+LEh2x+VLRI4CbFOe4vC573ziiA9w3TVvjK/DDSEO2RNHU+2tSMdwiP6
         C9VIbwhQ4ild3H21VcKgM35kPS1bHYQfHJ9tydWYUTMJrpxSUvV3W/Moak3qPuXLHN
         FTkIQ6QrqnE1P5INGirV7puw3fhCYpZtInVGoB9xzjZVEMEEHuDC6ibJXK2v4pPf+n
         t/m2nhemHB+Pw==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 30 Oct 2023 14:27:35 +0100
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Tyler Hicks <code@tyhicks.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        ecryptfs@vger.kernel.org
Subject: [PATCH] ecryptfs: Simplify ecryptfs_crypto_api_algify_cipher_name()
Date:   Mon, 30 Oct 2023 14:27:32 +0100
Message-Id: <2c4bd387e8036854d3338400038fdde8dce3806a.1698672391.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use kasprintf() instead of hand writing it.
It is much less verbose.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 fs/ecryptfs/crypto.c | 21 ++++++---------------
 1 file changed, 6 insertions(+), 15 deletions(-)

diff --git a/fs/ecryptfs/crypto.c b/fs/ecryptfs/crypto.c
index 044863c0d824..00d795658cf5 100644
--- a/fs/ecryptfs/crypto.c
+++ b/fs/ecryptfs/crypto.c
@@ -23,6 +23,7 @@
 #include <linux/slab.h>
 #include <asm/unaligned.h>
 #include <linux/kernel.h>
+#include <linux/sprintf.h>
 #include <linux/xattr.h>
 #include "ecryptfs_kernel.h"
 
@@ -78,22 +79,12 @@ static int ecryptfs_crypto_api_algify_cipher_name(char **algified_name,
 						  char *cipher_name,
 						  char *chaining_modifier)
 {
-	int cipher_name_len = strlen(cipher_name);
-	int chaining_modifier_len = strlen(chaining_modifier);
-	int algified_name_len;
-	int rc;
+	*algified_name = kasprintf(GFP_KERNEL, "%s(%s)",
+				   chaining_modifier, cipher_name);
+	if (!(*algified_name))
+		return -ENOMEM;
 
-	algified_name_len = (chaining_modifier_len + cipher_name_len + 3);
-	(*algified_name) = kmalloc(algified_name_len, GFP_KERNEL);
-	if (!(*algified_name)) {
-		rc = -ENOMEM;
-		goto out;
-	}
-	snprintf((*algified_name), algified_name_len, "%s(%s)",
-		 chaining_modifier, cipher_name);
-	rc = 0;
-out:
-	return rc;
+	return 0;
 }
 
 /**
-- 
2.34.1

