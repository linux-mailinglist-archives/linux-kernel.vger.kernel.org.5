Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AA337F41BA
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 10:33:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235122AbjKVJds (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 04:33:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231405AbjKVJdn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 04:33:43 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 380AFBD
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 01:33:40 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1r5jc2-00085x-4Y; Wed, 22 Nov 2023 10:33:38 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r5jc1-00AmQc-AB; Wed, 22 Nov 2023 10:33:37 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r5jc1-005agY-0o; Wed, 22 Nov 2023 10:33:37 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH] driver core: Emit reason for pending deferred probe
Date:   Wed, 22 Nov 2023 10:33:33 +0100
Message-ID: <20231122093332.274145-2-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1202; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=en0tOcLRymWWkepUNN7Xu3o/KYk6lyIo+CuxW/ghQKI=; b=owEBbAGT/pANAwAKAY+A+1h9Ev5OAcsmYgBlXcrsnDmhRsr78ilq0uIoGb/olddPAgUlUc2BZ zKiFP2z2eeJATIEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZV3K7AAKCRCPgPtYfRL+ Tm5hB/dnJhE0BjWlepcx5rcBsU02ecNq10eI0b7zEuYr7mhuncn1M6Ftny8hyOUw/XTGPKwtDQU jN+TvISrc2OAOgdZFcc5UNGeFaJjfUYBOUViksLPOsJC2VoOC/giQSiQVCQlR3lTwALjGT9/4ef Peyu5b6HW/TGxLCPTWU4TSR4+qQmdgq9vFSBx2NguOY1Qy0EKWTZjHAcHUO9ULsxQCXX4iYCV7o FE7HCcGlDMn+7z7Cvi9PYTP5D0we5Sf0EcBZLukv9aSo3rrH5Smg+LrdFn+IDPQBAulgCdXaG6z pjw6cAhDHI3d+/A7lr0e6Th2PPNA6YhRRo3JbGDM+uM88a0=
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ending a boot log with

	platform 3f202000.mmc: deferred probe pending

is already a nice hint about the problem. Sometimes there is a more
detailed error indicator available, add that to the output.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
Hello,

it's only compile tested, I created that patch while remote debugging an
issue by an irc user who provided the kernel log of a hung boot ending
in such output.

Best regards
Uwe

 drivers/base/dd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 0c3725c3eefa..85152537dbf1 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -313,7 +313,7 @@ static void deferred_probe_timeout_work_func(struct work_struct *work)
 
 	mutex_lock(&deferred_probe_mutex);
 	list_for_each_entry(p, &deferred_probe_pending_list, deferred_probe)
-		dev_info(p->device, "deferred probe pending\n");
+		dev_info(p->device, "deferred probe pending: %s", p->deferred_probe_reason ?: "(reason unknown)\n");
 	mutex_unlock(&deferred_probe_mutex);
 
 	fw_devlink_probing_done();

base-commit: 07b677953b9dca02928be323e2db853511305fa9
-- 
2.42.0

