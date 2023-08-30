Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB7BB78E2E8
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 00:58:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344258AbjH3W6Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 18:58:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344001AbjH3W6O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 18:58:14 -0400
Received: from rere.qmqm.pl (rere.qmqm.pl [91.227.64.183])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C663DCEE
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 15:57:55 -0700 (PDT)
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 4Rbd336L6rzbv;
        Wed, 30 Aug 2023 23:38:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1693431535; bh=FYuckVdeNnQG0dQ1V8vJDI3IwA2LopJS6jGJcl/QN2s=;
        h=Date:In-Reply-To:References:Subject:From:To:Cc:From;
        b=rpEDtYWP2WNBQfERxLVeQc7Ps6AGTPfkf8U5JNfxiPD727bblYBeF5p5Nnj6yJBvp
         wuJxhmn2Cdiz377NkRD3ojJZJx/ecP7xcewtscz5zoqZ7ONZhqudU183/dOCY2hybv
         oroiQUs9bqypQN1oJsJjEVcA6OjfopOSsnOKUYO2VBbF9ntzNLoZm+2eIRgrHM/iQG
         X8fI+kn3oi3xzM9m0kqQDNHmoFTbOBpTFGOyOh3EE+/qtwrPYthFxjSSrhEOReDHCR
         aURefb3mOV2pzSATbAN32V2StpT8tgE5upWxUFUcmXpX/9hPNEr70l22eUxVAndYRz
         QEnOtg/IH9vsA==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.103.8 at mail
Date:   Wed, 30 Aug 2023 23:38:55 +0200
Message-Id: <e51b655230a90f5809d197d166fa0931ad186279.1693431144.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <cover.1693431144.git.mirq-linux@rere.qmqm.pl>
References: <cover.1693431144.git.mirq-linux@rere.qmqm.pl>
Subject: [PATCH 4/9] regulator/core: regulator_bulk_get: remove redundant NULL
 stores
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

On error, callers of regulator_bulk_get() pass the error up and don't
use the pointers in consumers[]. The function is documented to release
all regulators if any request fails.

Note: if an i-th regulator_get() failed only the i-th pointer was
cleared. This is another suggestion that the clearing was unnecessary.

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 drivers/regulator/core.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 3703aa3f5636..63d16fe59e84 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -4829,11 +4829,7 @@ static int _notifier_call_chain(struct regulator_dev *rdev,
 int _regulator_bulk_get(struct device *dev, int num_consumers,
 			struct regulator_bulk_data *consumers, enum regulator_get_type get_type)
 {
-	int i;
-	int ret;
-
-	for (i = 0; i < num_consumers; i++)
-		consumers[i].consumer = NULL;
+	int ret, i;
 
 	for (i = 0; i < num_consumers; i++) {
 		consumers[i].consumer = _regulator_get(dev,
@@ -4842,7 +4838,6 @@ int _regulator_bulk_get(struct device *dev, int num_consumers,
 			ret = dev_err_probe(dev, PTR_ERR(consumers[i].consumer),
 					    "Failed to get supply '%s'",
 					    consumers[i].supply);
-			consumers[i].consumer = NULL;
 			goto err;
 		}
 
-- 
2.39.2

