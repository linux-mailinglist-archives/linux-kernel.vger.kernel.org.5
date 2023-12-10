Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B62680BC75
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Dec 2023 18:52:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231969AbjLJRv4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 12:51:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbjLJRvy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 12:51:54 -0500
Received: from smtp.smtpout.orange.fr (smtp-19.smtpout.orange.fr [80.12.242.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BD88FC
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 09:51:57 -0800 (PST)
Received: from pop-os.home ([92.140.202.140])
        by smtp.orange.fr with ESMTPA
        id CNy4r77eNxqX7CNy4r8b6X; Sun, 10 Dec 2023 18:51:56 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1702230716;
        bh=I+oLHrfSteD1fM5wZcNGUaFi+cT/ZUrP8W7m+tITsR4=;
        h=From:To:Cc:Subject:Date;
        b=mkWMq5TBbq7Mt5b0vqjmNsCy44MG2vlYUyENYi5GtepUNxLqKPZnXgx5x90e79Xu4
         kK3Vk+ulADvk2FkP248VX7Nx2QyglnFw5TqYDsn7aN28tqEIrdMloZ/tBfOAmG2DDf
         JD5mPXyCkPWtBy3/fQJZosYogQcBjzVHqnHODhTGFHouy6YOb+U5QaYoo5F6B0faif
         slLqRoNkhCuRZx2G+d93TRM2X94o1VS/eKxPUpdPyykrBBfePH5piqer/h0nY4WPvy
         hJCBt1nMacbOMxAbnocPtbXHqgW195NJCgVcgIZOC0ptbTnaXsbiV3IvRJpOGXEn3r
         kN/rjptAc/3Ug==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 10 Dec 2023 18:51:56 +0100
X-ME-IP: 92.140.202.140
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        virtualization@lists.linux.dev
Subject: [PATCH] vdpa: Remove usage of the deprecated ida_simple_xx() API
Date:   Sun, 10 Dec 2023 18:51:50 +0100
Message-Id: <d7534cc4caf4ff9d6b072744352c1b69487779ea.1702230703.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/vdpa/vdpa.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
index a7612e0783b3..d0695680b282 100644
--- a/drivers/vdpa/vdpa.c
+++ b/drivers/vdpa/vdpa.c
@@ -131,7 +131,7 @@ static void vdpa_release_dev(struct device *d)
 	if (ops->free)
 		ops->free(vdev);
 
-	ida_simple_remove(&vdpa_index_ida, vdev->index);
+	ida_free(&vdpa_index_ida, vdev->index);
 	kfree(vdev->driver_override);
 	kfree(vdev);
 }
@@ -205,7 +205,7 @@ struct vdpa_device *__vdpa_alloc_device(struct device *parent,
 	return vdev;
 
 err_name:
-	ida_simple_remove(&vdpa_index_ida, vdev->index);
+	ida_free(&vdpa_index_ida, vdev->index);
 err_ida:
 	kfree(vdev);
 err:
-- 
2.34.1

