Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CA7480BC99
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Dec 2023 19:50:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232007AbjLJSl6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 13:41:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjLJSl4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 13:41:56 -0500
Received: from smtp.smtpout.orange.fr (smtp-23.smtpout.orange.fr [80.12.242.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40CB7DF
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 10:42:01 -0800 (PST)
Received: from pop-os.home ([92.140.202.140])
        by smtp.orange.fr with ESMTPA
        id COkVr0Jjza8POCOkVrYw1e; Sun, 10 Dec 2023 19:41:59 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1702233719;
        bh=I4d7pDDCyjT9L0OHzm3kZ0ExqvKGHQ3K/sxp0Y597HM=;
        h=From:To:Cc:Subject:Date;
        b=ZaqfFfTj5/sK1oG0y6x+Yv/Iag8x3sqCmGofmIBzxwSpdXL5Rkmt9+jSBKtxXS/OC
         RL1LwO2tYWJjCsLvGWHXaGzc3rnOkKg7aQ7DqsE1sqxd+n5J75fxfbULD66wDgyMWu
         JJHtsqNmUmuzfNBjZBO0bE/x4TDxvvh4bzj8leLCfmQWL3quTXd58nkNBMAccvTS5A
         VNroBNT8ctYWqSqMkOAtFoJ2/IPe0buyvA/skTk/Huyax5gBS1zLDk7XwiEVTANqTX
         swNoW3P5nuxiqcBk5XMFchi7yII2xudGkKetzTtlk+szG1fH0HCULfHWKZGBR2ZcdX
         CFOIqgV6/NMBQ==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 10 Dec 2023 19:41:59 +0100
X-ME-IP: 92.140.202.140
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Olivia Mackall <olivia@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-crypto@vger.kernel.org
Subject: [PATCH] hwrng: virtio - Remove usage of the deprecated ida_simple_xx() API
Date:   Sun, 10 Dec 2023 19:41:51 +0100
Message-Id: <ff9912450e608388a73bd331b5e5e5c816131071.1702233701.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ida_alloc() and ida_free() should be preferred to the deprecated
ida_simple_get() and ida_simple_remove().

This is less verbose.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/char/hw_random/virtio-rng.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/char/hw_random/virtio-rng.c b/drivers/char/hw_random/virtio-rng.c
index 58d92d62ddfe..7a4b45393acb 100644
--- a/drivers/char/hw_random/virtio-rng.c
+++ b/drivers/char/hw_random/virtio-rng.c
@@ -135,7 +135,7 @@ static int probe_common(struct virtio_device *vdev)
 	if (!vi)
 		return -ENOMEM;
 
-	vi->index = index = ida_simple_get(&rng_index_ida, 0, 0, GFP_KERNEL);
+	vi->index = index = ida_alloc(&rng_index_ida, GFP_KERNEL);
 	if (index < 0) {
 		err = index;
 		goto err_ida;
@@ -166,7 +166,7 @@ static int probe_common(struct virtio_device *vdev)
 	return 0;
 
 err_find:
-	ida_simple_remove(&rng_index_ida, index);
+	ida_free(&rng_index_ida, index);
 err_ida:
 	kfree(vi);
 	return err;
@@ -184,7 +184,7 @@ static void remove_common(struct virtio_device *vdev)
 		hwrng_unregister(&vi->hwrng);
 	virtio_reset_device(vdev);
 	vdev->config->del_vqs(vdev);
-	ida_simple_remove(&rng_index_ida, vi->index);
+	ida_free(&rng_index_ida, vi->index);
 	kfree(vi);
 }
 
-- 
2.34.1

