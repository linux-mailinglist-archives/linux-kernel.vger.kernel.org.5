Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACEA47E4D4F
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 00:27:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344387AbjKGX1o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 18:27:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344516AbjKGX1J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 18:27:09 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E94F30CF;
        Tue,  7 Nov 2023 15:24:49 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10998C433C9;
        Tue,  7 Nov 2023 23:24:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699399489;
        bh=qeUmJb38F8VSget3hlVLVnA1e/X50cj7G6L5KJmkZEU=;
        h=From:To:Cc:Subject:Date:From;
        b=eZzDmNnHI0kMWcNpw8ig/y2NLhy/fktKBt6Xr5LKOo1D/0IxWfPDFgvSRcl2WqIWV
         RFSrJLYrR85z9QrzUBQ83+GrQpDMBaNSVKZ9D4VyHmFu3H4fRWQExiP3CHW1iUlXLr
         g+R+/SzwY/FE22OEq1JdOUAjFyL07yzVXcoWImrjO01fZkGnp1TTiXry++nvNu980k
         35/vdHfDRTHWFAWIvhPEK3mbbkYtBZfvv+ipCdd5hF3PNuaoXDV3e/NYBbqi8CDrPl
         wfEFibUh/TfBfXBiC0Xu7ko2ue2nuPxClCP8OYoZDcwt8fGuz46ALu6Ul2edv0SQ9f
         A0w2e6Ohzajzw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Yi Yang <yiyang13@huawei.com>, Jiri Slaby <jirislaby@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, davem@davemloft.net,
        sparclinux@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 1/6] tty: vcc: Add check for kstrdup() in vcc_probe()
Date:   Tue,  7 Nov 2023 18:24:37 -0500
Message-ID: <20231107232446.3776662-1-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.137
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
index e11383ae1e7e3..71356d9684bac 100644
--- a/drivers/tty/vcc.c
+++ b/drivers/tty/vcc.c
@@ -578,18 +578,22 @@ static int vcc_probe(struct vio_dev *vdev, const struct vio_device_id *id)
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
 
@@ -623,6 +627,11 @@ static int vcc_probe(struct vio_dev *vdev, const struct vio_device_id *id)
 		goto unreg_tty;
 	}
 	port->domain = kstrdup(domain, GFP_KERNEL);
+	if (!port->domain) {
+		rv = -ENOMEM;
+		goto unreg_tty;
+	}
+
 
 	mdesc_release(hp);
 
@@ -652,8 +661,9 @@ static int vcc_probe(struct vio_dev *vdev, const struct vio_device_id *id)
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

