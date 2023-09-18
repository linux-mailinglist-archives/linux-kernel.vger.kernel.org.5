Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EE477A524D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 20:46:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229829AbjIRSrC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 14:47:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbjIRSrB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 14:47:01 -0400
Received: from smtp.smtpout.orange.fr (smtp-17.smtpout.orange.fr [80.12.242.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23F5C109
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 11:46:49 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id iJGfq2zsLGkZJiJGfqxMkN; Mon, 18 Sep 2023 20:46:46 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1695062806;
        bh=d+X2wITyFfL/y+Yy8uB6Xs65leRLSEF6uVDE/v7+kls=;
        h=From:To:Cc:Subject:Date;
        b=L1bEOuwOXWbx6/SttJuEJqrYcA9alZxHkKfVLjjvl+XixqZ4/xbo/VsEyz8I6RGp7
         Tag+J0AAVIrMLJ52s103AV5YaUdi6IZNBPT8xs3HN8fybRllCblVgPZPmGRPAlDEVs
         kBx8CRvTcUIu6LiSqYue2Czilo6R42ki/2DI+3eTAWWqGJw+u0pk3IGtPXr9T0yS57
         D19bErru1a31d+k8nJ5sqGwiaf/yhl3vMXtUeVKW9kM4IwZEDvWK6mQcIJwFmrJ6VK
         i73Fj9FxeOVbwurBKYYhlIUu0AAG9kLlCHa92qYkX3vp2Dh15WepmhTO5RNMLD9Kmr
         1gQR11uX9XaOA==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 18 Sep 2023 20:46:46 +0200
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Gerd Hoffmann <kraxel@redhat.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org
Subject: [PATCH] udmabuf: Fix a potential (and unlikely) access to unallocated memory
Date:   Mon, 18 Sep 2023 20:46:35 +0200
Message-Id: <3e37f05c7593f1016f0a46de188b3357cbbd0c0b.1695060389.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,FORGED_SPF_HELO,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,T_SPF_TEMPERROR autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If 'list_limit' is set to a very high value, 'lsize' computation could
overflow if 'head.count' is big enough.

In such a case, udmabuf_create() will access to memory beyond 'list'.

Use size_mul() to saturate the value, and have memdup_user() fail.

Fixes: fbb0de795078 ("Add udmabuf misc device")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/dma-buf/udmabuf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma-buf/udmabuf.c b/drivers/dma-buf/udmabuf.c
index c40645999648..fb4c4b5b3332 100644
--- a/drivers/dma-buf/udmabuf.c
+++ b/drivers/dma-buf/udmabuf.c
@@ -314,13 +314,13 @@ static long udmabuf_ioctl_create_list(struct file *filp, unsigned long arg)
 	struct udmabuf_create_list head;
 	struct udmabuf_create_item *list;
 	int ret = -EINVAL;
-	u32 lsize;
+	size_t lsize;
 
 	if (copy_from_user(&head, (void __user *)arg, sizeof(head)))
 		return -EFAULT;
 	if (head.count > list_limit)
 		return -EINVAL;
-	lsize = sizeof(struct udmabuf_create_item) * head.count;
+	lsize = size_mul(sizeof(struct udmabuf_create_item), head.count);
 	list = memdup_user((void __user *)(arg + sizeof(head)), lsize);
 	if (IS_ERR(list))
 		return PTR_ERR(list);
-- 
2.34.1

