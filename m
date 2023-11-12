Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 578717E91B3
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Nov 2023 17:55:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230178AbjKLQxB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 11:53:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjKLQw7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 11:52:59 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64C071BEF;
        Sun, 12 Nov 2023 08:52:53 -0800 (PST)
Received: from dslb-188-097-210-154.188.097.pools.vodafone-ip.de ([188.97.210.154] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1r2DhZ-0001WT-K8; Sun, 12 Nov 2023 17:52:49 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH] hwrng: virtio - remove #ifdef guards for PM functions
Date:   Sun, 12 Nov 2023 17:52:41 +0100
Message-Id: <20231112165241.176095-1-martin@kaiser.cx>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use pm_sleep_ptr for the freeze and restore functions instead of putting
them under #ifdef CONFIG_PM_SLEEP. The resulting code is slightly simpler.

pm_sleep_ptr lets the compiler see the functions but also allows removing
them as unused code if !CONFIG_PM_SLEEP.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
compile-tested only, I do not have this hardware

 drivers/char/hw_random/virtio-rng.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/char/hw_random/virtio-rng.c b/drivers/char/hw_random/virtio-rng.c
index e41a84e6b4b5..58d92d62ddfe 100644
--- a/drivers/char/hw_random/virtio-rng.c
+++ b/drivers/char/hw_random/virtio-rng.c
@@ -208,7 +208,6 @@ static void virtrng_scan(struct virtio_device *vdev)
 		vi->hwrng_register_done = true;
 }
 
-#ifdef CONFIG_PM_SLEEP
 static int virtrng_freeze(struct virtio_device *vdev)
 {
 	remove_common(vdev);
@@ -238,7 +237,6 @@ static int virtrng_restore(struct virtio_device *vdev)
 
 	return err;
 }
-#endif
 
 static const struct virtio_device_id id_table[] = {
 	{ VIRTIO_ID_RNG, VIRTIO_DEV_ANY_ID },
@@ -252,10 +250,8 @@ static struct virtio_driver virtio_rng_driver = {
 	.probe =	virtrng_probe,
 	.remove =	virtrng_remove,
 	.scan =		virtrng_scan,
-#ifdef CONFIG_PM_SLEEP
-	.freeze =	virtrng_freeze,
-	.restore =	virtrng_restore,
-#endif
+	.freeze =	pm_sleep_ptr(virtrng_freeze),
+	.restore =	pm_sleep_ptr(virtrng_restore),
 };
 
 module_virtio_driver(virtio_rng_driver);
-- 
2.39.2

