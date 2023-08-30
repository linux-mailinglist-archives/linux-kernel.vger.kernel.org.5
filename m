Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8124A78E284
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 00:47:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241389AbjH3Wrw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 18:47:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232242AbjH3Wrt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 18:47:49 -0400
Received: from rere.qmqm.pl (rere.qmqm.pl [91.227.64.183])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D929A1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 15:47:41 -0700 (PDT)
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 4Rbd353Q2Qztn;
        Wed, 30 Aug 2023 23:38:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1693431537; bh=0FOuVXjqnIye1fzsxyeQ7447oMaVJyrA0BRuBkQGje8=;
        h=Date:In-Reply-To:References:Subject:From:To:Cc:From;
        b=pgSHbI7ytH98CI1tYlJpnH7Asw+T6ndG0u35fEbIv/z3L+QX7klUPLUuzDz+a3Ct+
         tNUSBj9gAJxv+6xBFq3V8DloPeUlGFhdwqkmjiC8XGxULU0Oxr/BaqMfmUG64dAh9z
         +HRkbyBTpoCjMkysZAxCZ6lgWWiik36oClne+ULXFWgg9lXbEqe2lZVgSeeWQbxnuI
         ztHmNYC1ZMpi2N92Y9XAR43QqN6oYsedU+L5pzMfeACfe145FMoET+A4WXjwDXdI7v
         Wfk+2wtC2ctVLigF31jOvnRhqac7+uYxYj6ykC8ld++FfKPXjTwyQwZ6ZrJjiZLRuz
         tqmU+NI6fAKlA==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.103.8 at mail
Date:   Wed, 30 Aug 2023 23:38:57 +0200
Message-Id: <edbe125df73698f44e6c0697b7c45dc5acb2d455.1693431144.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <cover.1693431144.git.mirq-linux@rere.qmqm.pl>
References: <cover.1693431144.git.mirq-linux@rere.qmqm.pl>
Subject: [PATCH 8/9] regulator/core: set_consumer_device_supply: avoid copying
 const data
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

As consumer_dev_name might as well be const, don't copy it if not
required.

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 drivers/regulator/core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 7c4ba090d88d..8ab4de7cadcb 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -1735,7 +1735,7 @@ static int set_consumer_device_supply(struct regulator_dev *rdev,
 	new_node->supply = supply;
 
 	if (consumer_dev_name != NULL) {
-		new_node->dev_name = kstrdup(consumer_dev_name, GFP_KERNEL);
+		new_node->dev_name = kstrdup_const(consumer_dev_name, GFP_KERNEL);
 		if (new_node->dev_name == NULL) {
 			kfree(new_node);
 			return -ENOMEM;
@@ -1770,7 +1770,7 @@ static int set_consumer_device_supply(struct regulator_dev *rdev,
 
 fail:
 	mutex_unlock(&regulator_list_mutex);
-	kfree(new_node->dev_name);
+	kfree_const(new_node->dev_name);
 	kfree(new_node);
 	return -EBUSY;
 }
@@ -1782,7 +1782,7 @@ static void unset_regulator_supplies(struct regulator_dev *rdev)
 	list_for_each_entry_safe(node, n, &regulator_map_list, list) {
 		if (rdev == node->regulator) {
 			list_del(&node->list);
-			kfree(node->dev_name);
+			kfree_const(node->dev_name);
 			kfree(node);
 		}
 	}
-- 
2.39.2

