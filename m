Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E87A777E779
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 19:21:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345175AbjHPRU7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 13:20:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345163AbjHPRUb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 13:20:31 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED1D726AB
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 10:20:26 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qWKBi-0002k8-Mk; Wed, 16 Aug 2023 19:20:06 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qWKBd-0015eP-F2; Wed, 16 Aug 2023 19:20:01 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qWKBc-00DYfr-LE; Wed, 16 Aug 2023 19:20:00 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Eddie James <eajames@linux.ibm.com>, Joel Stanley <joel@jms.id.au>,
        Jeremy Kerr <jk@ozlabs.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alistar Popple <alistair@popple.id.au>, linux-fsi@lists.ozlabs.org,
        kernel@pengutronix.de, linux-kernel@vger.kernel.org
Subject: [PATCH] fsi: i2cr: Switch to use struct i2c_driver's .probe()
Date:   Wed, 16 Aug 2023 19:19:44 +0200
Message-Id: <20230816171944.123705-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1051; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=wo9hR2BjWdL9hjjE317gsXX6geCTrTXD/PgBXWB4lVE=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBk3QUrJQVScMu9Tv9CBsX65YmoEuVxmhPtqCech k2h2iCtylGJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZN0FKwAKCRCPgPtYfRL+ TiMbB/9ubQpDNL8lOGZbjjNfqzdHBw4P+XV/vciE0nJd6okLHs/Vz07y9gAjN0TGsQOVZOmDwhf nmXblVOyLhdxJO7tKomTkhrh6ATwe/R4syEiAweb5nNZFtoNwjoHtz75FiiS/084zmRJwIQzUZo neBcFDE41E6GJ4IyyBoR3vYMKwc+eSn7xO1QnMt9flKLaAudEflH7y1LhtDPK7kjxPEyu1/nwaV CVTG7tVFCE3cv1/gmnlnYcQbqQkESs4Gvo54AG+wnVwiV/v1gv5MbKKwA6UHB6ITFAbItWcV2+p k0Tx0ZuDynWo3BawIqgNCEyOhVYXs8fij3uNXZjXlm+q3zFV
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

struct i2c_driver::probe_new is about to go away. Switch the driver to
use the probe callback with the same prototype.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
Hello,

this driver appeared in next just today. I intend to drop .probe_new
from struct i2c_driver after v6.6-rc1, so it would be great if this
patch would go in together with the commit adding this driver.

Thanks
Uwe

 drivers/fsi/fsi-master-i2cr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/fsi/fsi-master-i2cr.c b/drivers/fsi/fsi-master-i2cr.c
index 61659c27a973..40f1f4d231e5 100644
--- a/drivers/fsi/fsi-master-i2cr.c
+++ b/drivers/fsi/fsi-master-i2cr.c
@@ -301,7 +301,7 @@ static const struct of_device_id i2cr_ids[] = {
 MODULE_DEVICE_TABLE(of, i2cr_ids);
 
 static struct i2c_driver i2cr_driver = {
-	.probe_new = i2cr_probe,
+	.probe = i2cr_probe,
 	.remove = i2cr_remove,
 	.driver = {
 		.name = "fsi-master-i2cr",

base-commit: 53e89e3e4490d6630a68e61a3cb478e7a7f2ce8b
-- 
2.40.1

