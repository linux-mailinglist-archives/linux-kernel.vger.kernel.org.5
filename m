Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CE8C75DE6F
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 22:07:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbjGVUHq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 16:07:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjGVUHn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 16:07:43 -0400
Received: from smtp.smtpout.orange.fr (smtp-30.smtpout.orange.fr [80.12.242.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B3CB2137
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jul 2023 13:07:39 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id NIsyqCllLulAmNIszqCc5G; Sat, 22 Jul 2023 22:07:31 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1690056451;
        bh=7S4ycyHIMkZJiLKQzCPxeyh+eo13SBWOIVq3MxxljJ4=;
        h=From:To:Cc:Subject:Date;
        b=H1cITbJGrQCdw/dC2WdazoyVY0mrYULO1Vall8mjmOZhUf2HpWZfD5DXrHO7Fn447
         iY3GHjnyT2VmoVdqX5leLbMcYQnneDP9YXuVSUKXMTUtiqDNTKVMS5T7Ki5SK2BOmi
         QRef6/MoHPpVKxzX+YnsLQdwSUYSUZ2FKJjF+2cn/z/VEHHKzXFzWMgX0gMqsrkdZ3
         x403vWMINEMsctZ55M0vSjPQ7iDnes1FYWLJwL77q3Wuum82zXi94W+cvARrsWfGrJ
         vAMGUCVychN9LGChTN1g0SOTA5QWooUmDW19fCFBSlB8ec//PDWhefBwKbFsNQBF4q
         9D9y0+LtrieXQ==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 22 Jul 2023 22:07:31 +0200
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] stm class: Use struct_size()
Date:   Sat, 22 Jul 2023 22:07:26 +0200
Message-Id: <d14d51f409c1e87fb87fa39869bdf7ce1b766120.1690056420.git.christophe.jaillet@wanadoo.fr>
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

Use struct_size() instead of hand-writing it, when allocating a structure
with a flex array.

This is less verbose, more robust and more informative.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
It will also be helpful if the __counted_by() annotation is added with a
Coccinelle script such as:
   https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/commit/?h=devel/counted_by&id=adc5b3cb48a049563dc673f348eab7b6beba8a9b
---
 drivers/hwtracing/stm/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwtracing/stm/core.c b/drivers/hwtracing/stm/core.c
index 534fbefc7f6a..2195310ab81c 100644
--- a/drivers/hwtracing/stm/core.c
+++ b/drivers/hwtracing/stm/core.c
@@ -863,7 +863,7 @@ int stm_register_device(struct device *parent, struct stm_data *stm_data,
 		return -EINVAL;
 
 	nmasters = stm_data->sw_end - stm_data->sw_start + 1;
-	stm = vzalloc(sizeof(*stm) + nmasters * sizeof(void *));
+	stm = vzalloc(struct_size(stm, masters, nmasters));
 	if (!stm)
 		return -ENOMEM;
 
-- 
2.34.1

