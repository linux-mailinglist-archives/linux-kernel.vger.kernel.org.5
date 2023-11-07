Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A2747E4D5A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 00:28:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235630AbjKGX2Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 18:28:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235633AbjKGX2G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 18:28:06 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02F423A9B;
        Tue,  7 Nov 2023 15:25:06 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97A81C433C9;
        Tue,  7 Nov 2023 23:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699399506;
        bh=66eRZbbpn1d2Z8u3cIZs2EUHC8FbX3bz5i+CPEDxP5k=;
        h=From:To:Cc:Subject:Date:From;
        b=Td4TmcT33j8spMeJsadMh4pSksohY7dAIrbYHyYWF/iVq50QZRBRHN4AvetG8AmVg
         11qhre/V622oyzogqfT0dfZjWC3+lhW50U9904z3HaZgOW5zL/cbpS4geeS4MjxQjz
         rYdzLGmXaADnVkdLOH7SluOsesy/0Ew3I4098gBHhoSSHDMZlriK0yJ/KSoEvj42Fa
         fFvPvjd5oHgySmVjbG6mlgD50jeDY2o4KAJIar9gzmRIwSuINaIsVYBparjWjgUAHO
         dC3rmBHPPYFKrTOkQ2Ij79AwJBBQ0uWeT8GwMIQ9KqFrqTX5OGMfOc1mqNMiVoPbtD
         QNVIubZxP+icA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Yi Yang <yiyang13@huawei.com>, Jiri Slaby <jirislaby@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, davem@davemloft.net,
        sparclinux@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 1/5] tty: vcc: Add check for kstrdup() in vcc_probe()
Date:   Tue,  7 Nov 2023 18:24:56 -0500
Message-ID: <20231107232503.3776802-1-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.199
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yi Yang <yiyang13@huawei.com>

[ Upstream commit d81ffb87aaa75f842cd7aa57091810353755b3e6 ]

Add check for the return value of kstrdup() and return the error, if it
fails in order to avoid NULL pointer dereference.

Signed-off-by: Yi Yang <yiyang13@huawei.com>
Reviewed-by: Jiri Slaby <jirislaby@kernel.org>
Link: https://lore.kernel.org/r/20230904035220.48164-1-yiyang13@huawei.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/vcc.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/vcc.c b/drivers/tty/vcc.c
index 9ffd42e333b83..6b2d35ac6e3b3 100644
--- a/drivers/tty/vcc.c
+++ b/drivers/tty/vcc.c
@@ -587,18 +587,22 @@ static int vcc_probe(struct vio_dev *vdev, const struct vio_device_id *id)
 		return -ENOMEM;
 
 	name = kstrdup(dev_name(&vdev->dev), GFP_KERNEL);
+	if (!name) {
+		rv = -ENOMEM;
+		goto free_port;
+	}
 
 	rv = vio_driver_init(&port->vio, vdev, VDEV_CONSOLE_CON, vcc_versions,
 			     ARRAY_SIZE(vcc_versions), NULL, name);
 	if (rv)
-		goto free_port;
+		goto free_name;
 
 	port->vio.debug = vcc_dbg_vio;
 	vcc_ldc_cfg.debug = vcc_dbg_ldc;
 
 	rv = vio_ldc_alloc(&port->vio, &vcc_ldc_cfg, port);
 	if (rv)
-		goto free_port;
+		goto free_name;
 
 	spin_lock_init(&port->lock);
 
@@ -632,6 +636,11 @@ static int vcc_probe(struct vio_dev *vdev, const struct vio_device_id *id)
 		goto unreg_tty;
 	}
 	port->domain = kstrdup(domain, GFP_KERNEL);
+	if (!port->domain) {
+		rv = -ENOMEM;
+		goto unreg_tty;
+	}
+
 
 	mdesc_release(hp);
 
@@ -661,8 +670,9 @@ static int vcc_probe(struct vio_dev *vdev, const struct vio_device_id *id)
 	vcc_table_remove(port->index);
 free_ldc:
 	vio_ldc_free(&port->vio);
-free_port:
+free_name:
 	kfree(name);
+free_port:
 	kfree(port);
 
 	return rv;
-- 
2.42.0

