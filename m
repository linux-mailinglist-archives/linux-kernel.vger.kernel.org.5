Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 385ED78E2DD
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 00:54:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239942AbjH3WyZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 18:54:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230166AbjH3WyX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 18:54:23 -0400
Received: from rere.qmqm.pl (rere.qmqm.pl [91.227.64.183])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3430CE75
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 15:53:56 -0700 (PDT)
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 4Rbd344GpXzjJ;
        Wed, 30 Aug 2023 23:38:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1693431536; bh=hkfhe/JYkH9cOp8sfK6wVmut5qBxlqVOGzXU+gWw05A=;
        h=Date:In-Reply-To:References:Subject:From:To:Cc:From;
        b=o9AhdExoWOHdimJ4LTYTZDhDpdYGM+By+cxe4w8a9N+N91u6n1y/nn72qhs/3raN8
         QBcxcCrfRQEfABvEcukG27T5ChutxzYYsi+fUf3FJIbfj8iNnp7UOKQx7e75bRBY7Z
         RifXQz78LnuhJivb0pBiJ3Gn5C9QVGQ/ZwtHc7jSMb1bXS9PHAcwnky6v0zrkgzM86
         UCBM2xNR8aQDV+OaJfik8rAMxloiH30KiSpMX7lH53csLdgwTueMct+Uh55R1iSUK2
         URkdGKGmhVIr0eXfKqR0BJzCUgwI5XnhOnA+XvKp5ORCuCamN57yW147swetuIUkZs
         CKrnucwUBMmBQ==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.103.8 at mail
Date:   Wed, 30 Aug 2023 23:38:56 +0200
Message-Id: <67b78825385762957b121db2c5d71b119517a7ce.1693431144.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <cover.1693431144.git.mirq-linux@rere.qmqm.pl>
References: <cover.1693431144.git.mirq-linux@rere.qmqm.pl>
Subject: [PATCH 6/9] regulator/core: remove regulator_init callback
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

There are no in-tree users. The only usage went away in 2019 in commit
8c44e448583c ("regulator: stpmic1: Simplify regulators registration").

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 include/linux/regulator/machine.h | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/include/linux/regulator/machine.h b/include/linux/regulator/machine.h
index 621b7f4a3639..2d4ae9c01cde 100644
--- a/include/linux/regulator/machine.h
+++ b/include/linux/regulator/machine.h
@@ -256,8 +256,7 @@ struct regulator_consumer_supply {
  * @num_consumer_supplies: Number of consumer device supplies.
  * @consumer_supplies: Consumer device supply configuration.
  *
- * @regulator_init: Callback invoked when the regulator has been registered.
- * @driver_data: Data passed to regulator_init.
+ * @driver_data: Pointer copied to regulator_dev.reg_data.
  */
 struct regulator_init_data {
 	const char *supply_regulator;        /* or NULL for system supply */
@@ -267,9 +266,7 @@ struct regulator_init_data {
 	int num_consumer_supplies;
 	struct regulator_consumer_supply *consumer_supplies;
 
-	/* optional regulator machine specific init */
-	int (*regulator_init)(void *driver_data);
-	void *driver_data;	/* core does not touch this */
+	void *driver_data;
 };
 
 #ifdef CONFIG_REGULATOR
-- 
2.39.2

