Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8005B78E219
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 00:09:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244969AbjH3WJc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 18:09:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244924AbjH3WJX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 18:09:23 -0400
Received: from rere.qmqm.pl (rere.qmqm.pl [91.227.64.183])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95695E45
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 15:08:54 -0700 (PDT)
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 4Rbd35658Czv2;
        Wed, 30 Aug 2023 23:38:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1693431537; bh=2CekRNDkBbHu6pEmNg2eRQDOpdZjkPKnS4qq90AdQJU=;
        h=Date:In-Reply-To:References:Subject:From:To:Cc:From;
        b=GBV8lCbuzNK75jX0HPgbylECXFm+1rk+oBaStXHSdAWuSBThBI9eyuYW+I0TepxWC
         S5ygz5Pq0l3tx9y/Z0QRD13Pp+F8PK1/lwMup5o0N0RQ+joAC4Naa2p3fUNu0bdpFP
         0THNoJ1vzE7lcyf7Pds7YdK5FokuRgrVFQn/DyewCP6yYk11hW/pgsCZuW1eXKcmj7
         ++b17xbI/ssknVcbAHME21VE6ndzQi3cKEwjvJOfMo/ZVxIEa9H5aV9P4SwiQr5i9S
         qbedp26ET39Ajl+ObzaoSgFrvQ8emFs3P0Mvpt4Bbc9ak7v3rafRJx4Ix1G6V3sWpq
         rT2DP7pG3coPw==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.103.8 at mail
Date:   Wed, 30 Aug 2023 23:38:57 +0200
Message-Id: <5250762009b124470f07daa947f130ccff518f50.1693431144.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <cover.1693431144.git.mirq-linux@rere.qmqm.pl>
References: <cover.1693431144.git.mirq-linux@rere.qmqm.pl>
Subject: [PATCH 9/9] regulator/core: make regulator_class const
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

The `struct class` is passed only to class_register() and a const
pointer there.  Make the data also const.

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 drivers/regulator/core.c     | 3 ++-
 drivers/regulator/internal.h | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 8ab4de7cadcb..fedda29a2176 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -5797,7 +5797,7 @@ static const struct dev_pm_ops __maybe_unused regulator_pm_ops = {
 };
 #endif
 
-struct class regulator_class = {
+const struct class regulator_class = {
 	.name = "regulator",
 	.dev_release = regulator_dev_release,
 	.dev_groups = regulator_dev_groups,
@@ -5805,6 +5805,7 @@ struct class regulator_class = {
 	.pm = &regulator_pm_ops,
 #endif
 };
+
 /**
  * regulator_has_full_constraints - the system has fully specified constraints
  *
diff --git a/drivers/regulator/internal.h b/drivers/regulator/internal.h
index fb4433068d29..77a502141089 100644
--- a/drivers/regulator/internal.h
+++ b/drivers/regulator/internal.h
@@ -58,7 +58,7 @@ struct regulator {
 	struct dentry *debugfs;
 };
 
-extern struct class regulator_class;
+extern const struct class regulator_class;
 
 static inline struct regulator_dev *dev_to_rdev(struct device *dev)
 {
-- 
2.39.2

