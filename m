Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89A1277221E
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 13:29:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232622AbjHGL3L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 07:29:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233264AbjHGL2p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 07:28:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E8595FEE;
        Mon,  7 Aug 2023 04:26:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0B4F161841;
        Mon,  7 Aug 2023 11:17:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CEE0C433C9;
        Mon,  7 Aug 2023 11:16:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691407019;
        bh=cwBHdp29+KXQfhU6rSZ1ufJNDTKuC3zk0WO2z1hIGTU=;
        h=From:To:Cc:Subject:Date:From;
        b=ovLaOhv55dh0aszjTH7N+AmnC6NtCKA1MaMN6DtSqOb4+qGiNHGFCd0A00AcqKMyU
         h40D/SMMZ+e3lTxmoIMos96ZTo6TEtpaNgeLbKi7xHaD81H2V7MNKjGvCrEP1iwMnJ
         3gzb8cXzdHrNItXddvlAJQBQOM+hn0H4NHOFlKgXhXWwIUUaxz97/Nb3XOrPFG8H7U
         IAJVqSZfkZQfJHBmhrigpCyMjIW6C5tB6z9P0ojdH3NBqCwqewApHfEdn33S0YXfix
         CBqdPm/gxqDbUG/GsEHkBz6IydLT/Ob+SsWszlHWftyXOcKh0MQXzKHCHA1qL5P8wo
         FiG/hRjIkciyw==
From:   Arnd Bergmann <arnd@kernel.org>
To:     =?UTF-8?q?Horia=20Geant=C4=83?= <horia.geanta@nxp.com>,
        Pankaj Gupta <pankaj.gupta@nxp.com>,
        Gaurav Jain <gaurav.jain@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
        Victoria Milhoan <vicki.milhoan@freescale.com>,
        Franck LENORMAND <franck.lenormand@nxp.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Vipul Kumar <vipul_kumar@mentor.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Dan Douglass <dan.douglass@nxp.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] crypto: caam: fix PM operations definition
Date:   Mon,  7 Aug 2023 13:16:43 +0200
Message-Id: <20230807111653.1794160-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The newly added PM operations use the deprecated SIMPLE_DEV_PM_OPS() macro,
causing a warning in some configurations:

drivers/crypto/caam/ctrl.c:828:12: error: 'caam_ctrl_resume' defined but not used [-Werror=unused-function]
  828 | static int caam_ctrl_resume(struct device *dev)
      |            ^~~~~~~~~~~~~~~~
drivers/crypto/caam/ctrl.c:818:12: error: 'caam_ctrl_suspend' defined but not used [-Werror=unused-function]
  818 | static int caam_ctrl_suspend(struct device *dev)
      |            ^~~~~~~~~~~~~~~~~
drivers/crypto/caam/jr.c:732:12: error: 'caam_jr_resume' defined but not used [-Werror=unused-function]
  732 | static int caam_jr_resume(struct device *dev)
      |            ^~~~~~~~~~~~~~
drivers/crypto/caam/jr.c:687:12: error: 'caam_jr_suspend' defined but not used [-Werror=unused-function]
  687 | static int caam_jr_suspend(struct device *dev)
      |            ^~~~~~~~~~~~~~~

Use the normal DEFINE_SIMPLE_DEV_PM_OPS() variant now, and use pm_ptr() to
completely eliminate the structure in configs without CONFIG_PM.

Fixes: 322d74752c28a ("crypto: caam - add power management support")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/crypto/caam/ctrl.c | 4 ++--
 drivers/crypto/caam/jr.c   | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/crypto/caam/ctrl.c b/drivers/crypto/caam/ctrl.c
index a7a4583107f41..2a228a36fa15a 100644
--- a/drivers/crypto/caam/ctrl.c
+++ b/drivers/crypto/caam/ctrl.c
@@ -841,7 +841,7 @@ static int caam_ctrl_resume(struct device *dev)
 	return ret;
 }
 
-static SIMPLE_DEV_PM_OPS(caam_ctrl_pm_ops, caam_ctrl_suspend, caam_ctrl_resume);
+static DEFINE_SIMPLE_DEV_PM_OPS(caam_ctrl_pm_ops, caam_ctrl_suspend, caam_ctrl_resume);
 
 /* Probe routine for CAAM top (controller) level */
 static int caam_probe(struct platform_device *pdev)
@@ -1138,7 +1138,7 @@ static struct platform_driver caam_driver = {
 	.driver = {
 		.name = "caam",
 		.of_match_table = caam_match,
-		.pm = &caam_ctrl_pm_ops,
+		.pm = pm_ptr(&caam_ctrl_pm_ops),
 	},
 	.probe       = caam_probe,
 };
diff --git a/drivers/crypto/caam/jr.c b/drivers/crypto/caam/jr.c
index 316180d26f8ae..767fbf052536a 100644
--- a/drivers/crypto/caam/jr.c
+++ b/drivers/crypto/caam/jr.c
@@ -794,7 +794,7 @@ static int caam_jr_resume(struct device *dev)
 	return 0;
 }
 
-static SIMPLE_DEV_PM_OPS(caam_jr_pm_ops, caam_jr_suspend, caam_jr_resume);
+static DEFINE_SIMPLE_DEV_PM_OPS(caam_jr_pm_ops, caam_jr_suspend, caam_jr_resume);
 
 static const struct of_device_id caam_jr_match[] = {
 	{
@@ -811,7 +811,7 @@ static struct platform_driver caam_jr_driver = {
 	.driver = {
 		.name = "caam_jr",
 		.of_match_table = caam_jr_match,
-		.pm = &caam_jr_pm_ops,
+		.pm = pm_ptr(&caam_jr_pm_ops),
 	},
 	.probe       = caam_jr_probe,
 	.remove      = caam_jr_remove,
-- 
2.39.2

