Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C494678E2E7
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 00:58:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344268AbjH3W6S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 18:58:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344145AbjH3W6O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 18:58:14 -0400
Received: from rere.qmqm.pl (rere.qmqm.pl [91.227.64.183])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C66B5CF1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 15:57:55 -0700 (PDT)
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 4Rbd332tgczVr;
        Wed, 30 Aug 2023 23:38:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1693431535; bh=UOv5UYiic2OEW7Z/lmCvmB0e7M+FtpAGvPx/Numsyn0=;
        h=Date:In-Reply-To:References:Subject:From:To:Cc:From;
        b=PwjvjomKydj5Jeq8khsxnUiioahd7pSmcddd2rAMKxWz4By16vFZ3oft6gRf8OOQe
         iiM8Lr0v+IZzRiVdsv6nSBVKe4o0HcVrCPNnfSqT2m+P1iG2dHEIs3c1jbjq8/b282
         hwY7zjuS0RSL/c+vYBXrK+z+W+/lJPJ6YEragdyxyWbvYwXfdfnoO5f/lpuuzyuCEf
         l5VGuP9PF0LX3/pjHa6xUcL9j6X5fX0MQzwaZg/lQEV8atS0V2JRXVvKI/D7DRGH+U
         Bi3SQFjeJcid+pkm7H/48c3+ygtWcLdyO2DzwkAq6e56g3ZoIwF86q2cKkMDUxsILs
         kQcvcuxDi5zPw==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.103.8 at mail
Date:   Wed, 30 Aug 2023 23:38:55 +0200
Message-Id: <40d2eabfa435b0a8850a1c2264d4b9bf63b6fb74.1693431144.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <cover.1693431144.git.mirq-linux@rere.qmqm.pl>
References: <cover.1693431144.git.mirq-linux@rere.qmqm.pl>
Subject: [PATCH 3/9] regulator/core: of_get_child_regulator: remove goto
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Because of_node_put() handles NULL properly (like kfree() et al)
we can call it also after the loop ends (due to child == NULL).
This makes the gotos redundant.

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 drivers/regulator/core.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index a467be1f198b..3703aa3f5636 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -426,18 +426,15 @@ static struct device_node *of_get_child_regulator(struct device_node *parent,
 
 	for_each_child_of_node(parent, child) {
 		regnode = of_parse_phandle(child, prop_name, 0);
+		if (regnode)
+			break;
 
-		if (!regnode) {
-			regnode = of_get_child_regulator(child, prop_name);
-			if (regnode)
-				goto err_node_put;
-		} else {
-			goto err_node_put;
-		}
+		regnode = of_get_child_regulator(child, prop_name);
+		if (regnode)
+			break;
 	}
-	return NULL;
 
-err_node_put:
+	/* Release the node if the loop was exited early. */
 	of_node_put(child);
 	return regnode;
 }
-- 
2.39.2

