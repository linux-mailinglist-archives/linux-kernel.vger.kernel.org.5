Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE3E878E189
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 23:40:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242009AbjH3Vkl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 17:40:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242037AbjH3Vkk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 17:40:40 -0400
Received: from rere.qmqm.pl (rere.qmqm.pl [91.227.64.183])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E54ECFC
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 14:40:10 -0700 (PDT)
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 4Rbd330fnTzTw;
        Wed, 30 Aug 2023 23:38:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1693431535; bh=myJ3VN4kme6b3IyeciKx5wc/7mhpCeWqhBkhEBhrxQA=;
        h=Date:In-Reply-To:References:Subject:From:To:Cc:From;
        b=V0Vzy/vb1FI56RGjX/1c+/higRB1MqWSNbbmkAPVn6oS2hiGumONNuy5eFHyBt7G0
         2O7iqQAZuiUJlLT+SxIX5RBbJtg9AA+eoVpFn7QMIzC8TEBpuEYFrXtmEN2XV/2VOR
         yaRJWmHsLPqusX5noYPO0JiXbvOoVBlLuAql2VUGAkVzRmi+UW8fUdn4AyUrjofQey
         pDN1XSVIAPokAFoefVlyf6gSgbn9f3X/DHC9Zw3tJMVT79quyYsRgNR7e+dgmFdc3O
         mdANqOhrh7qOM4FjuBsY/pFDhX3ioB37SurwQZkrGYg+boH8jwgeDVZf0kXIcbMzD7
         WpvHd3CcUcL3A==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.103.8 at mail
Date:   Wed, 30 Aug 2023 23:38:54 +0200
Message-Id: <5fb938f4a07063fbca4893db2e6da1b63da87dc9.1693431144.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <cover.1693431144.git.mirq-linux@rere.qmqm.pl>
References: <cover.1693431144.git.mirq-linux@rere.qmqm.pl>
Subject: [PATCH 2/9] regulator/core: set_consumer_device_supply: remove
 `has_dev`
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

`has_dev` is only ever used once to check if the name is non-NULL.
Inline the check and make the intent obvious.

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 drivers/regulator/core.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index d440cd137c38..a467be1f198b 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -1726,16 +1726,10 @@ static int set_consumer_device_supply(struct regulator_dev *rdev,
 				      const char *supply)
 {
 	struct regulator_map *node, *new_node;
-	int has_dev;
 
 	if (supply == NULL)
 		return -EINVAL;
 
-	if (consumer_dev_name != NULL)
-		has_dev = 1;
-	else
-		has_dev = 0;
-
 	new_node = kzalloc(sizeof(struct regulator_map), GFP_KERNEL);
 	if (new_node == NULL)
 		return -ENOMEM;
@@ -1743,7 +1737,7 @@ static int set_consumer_device_supply(struct regulator_dev *rdev,
 	new_node->regulator = rdev;
 	new_node->supply = supply;
 
-	if (has_dev) {
+	if (consumer_dev_name != NULL) {
 		new_node->dev_name = kstrdup(consumer_dev_name, GFP_KERNEL);
 		if (new_node->dev_name == NULL) {
 			kfree(new_node);
-- 
2.39.2

