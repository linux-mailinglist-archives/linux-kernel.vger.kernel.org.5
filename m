Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C7867DDE77
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 10:33:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbjKAJdn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 05:33:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjKAJdm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 05:33:42 -0400
Received: from smtp.smtpout.orange.fr (smtp-22.smtpout.orange.fr [80.12.242.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C054C2
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 02:33:39 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id y7bUqR7n2QRiPy7bUqGpjn; Wed, 01 Nov 2023 10:33:37 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1698831217;
        bh=Lk6by+apJlXOTJCfTgHSgCgxJ2Nx6rTRDAgAWtwwfU4=;
        h=From:To:Cc:Subject:Date;
        b=BbVBnsZmRk2OMHr0SyJFrkLIzjmbNG6017Q+W8zqghSIP2TMIyMLZArrpLCPxvnF5
         4x7t+NAHTlbmCfMcwD5W2LI8bqKszLrscaC2+j+/BbVhqNtNHs1TRVGKHVHnac8zEz
         dgajdDB/wKaW5JtsL4GXQnfLhIqLFiSY5OcL/a3tOQvqv31nOLhYOLl9c3hJpVXB9D
         IlCfF5Xk+5iRalotiMUMGdCId+VOoxodLNLCrWDIYUOFKqhidUyWi9xLgpZ52Dxpeq
         Ff1cGFU0RPUELO5nH2cwprGhHxZSZ421QjYbTQkJ0KasVPcsglOikh5gQ7kC0Ij1Lf
         S+tGPGydgTuIQ==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Wed, 01 Nov 2023 10:33:37 +0100
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] base: soc: Remove usage of the deprecated ida_simple_xx() API
Date:   Wed,  1 Nov 2023 10:33:33 +0100
Message-Id: <f0ef849446c9b3df7d6b16b1a58d089b4c17276c.1698831191.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/base/soc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/base/soc.c b/drivers/base/soc.c
index 8dec5228fde3..c741d0845852 100644
--- a/drivers/base/soc.c
+++ b/drivers/base/soc.c
@@ -106,7 +106,7 @@ static void soc_release(struct device *dev)
 {
 	struct soc_device *soc_dev = container_of(dev, struct soc_device, dev);
 
-	ida_simple_remove(&soc_ida, soc_dev->soc_dev_num);
+	ida_free(&soc_ida, soc_dev->soc_dev_num);
 	kfree(soc_dev->dev.groups);
 	kfree(soc_dev);
 }
@@ -155,7 +155,7 @@ struct soc_device *soc_device_register(struct soc_device_attribute *soc_dev_attr
 	soc_attr_groups[1] = soc_dev_attr->custom_attr_group;
 
 	/* Fetch a unique (reclaimable) SOC ID. */
-	ret = ida_simple_get(&soc_ida, 0, 0, GFP_KERNEL);
+	ret = ida_alloc(&soc_ida, GFP_KERNEL);
 	if (ret < 0)
 		goto out3;
 	soc_dev->soc_dev_num = ret;
-- 
2.34.1

