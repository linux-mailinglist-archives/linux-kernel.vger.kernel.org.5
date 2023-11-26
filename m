Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A867F7F91C9
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Nov 2023 09:09:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbjKZIIg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 03:08:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjKZIId (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 03:08:33 -0500
Received: from smtp.smtpout.orange.fr (smtp-30.smtpout.orange.fr [80.12.242.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE77011B
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 00:08:39 -0800 (PST)
Received: from pop-os.home ([92.140.202.140])
        by smtp.orange.fr with ESMTPA
        id 7ABkrYL9QVgeS7ABtr7Ror; Sun, 26 Nov 2023 09:08:39 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1700986119;
        bh=lh71l96E6zVf9+1IM040Rgb2giV9A1CJHlxg8pa/sT4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=pXlPEQDb8VmLZKUDWPEkg5SPAXTKe8Pw0JQXpfdEqlBz1yixrApVXYGyRNe8ZnpDF
         UoZuNFKpft6AVYekTzvYwyPX39x7c1y61/y+ep6xQ5LbArwjVD5iz2DWZwAJjoMch5
         onCEt6jb+Y0+r1KtbnWYe3My637GRNU2tyrsctscZ+bZamd2Z38JEPEIkrITexykV/
         6cJVhdLRh4sGpMhIfAYu53utWZ7lCChICy7ceGXGdovEDugAzgAyiNzBvDH4mpOJ3Y
         H6AeOYumd5NIVpddrxPODXrTPtxJSnV2f+sSMOWruquMRuvaemiEW9Qj5tUhj00Dux
         3Dz/L1NriyoEg==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 26 Nov 2023 09:08:39 +0100
X-ME-IP: 92.140.202.140
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Peter Rosin <peda@axentia.se>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 2/2] mux: Slightly reorder 'struct mux_chip'
Date:   Sun, 26 Nov 2023 09:08:12 +0100
Message-Id: <90be77e27b96d47acc9f20416d8fdc01f9cb601b.1700986053.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <d17bd9b622dbe3f7cb2f18736ef3138a6927f86c.1700986053.git.christophe.jaillet@wanadoo.fr>
References: <d17bd9b622dbe3f7cb2f18736ef3138a6927f86c.1700986053.git.christophe.jaillet@wanadoo.fr>
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

Based on pahole, 2 holes can be combined in the 'struct mux_chip'. This
saves 8 bytes in the structure on my x86_64.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 include/linux/mux/driver.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/mux/driver.h b/include/linux/mux/driver.h
index c29e9b7fb17b..09d519af521b 100644
--- a/include/linux/mux/driver.h
+++ b/include/linux/mux/driver.h
@@ -56,15 +56,15 @@ struct mux_control {
 /**
  * struct mux_chip -	Represents a chip holding mux controllers.
  * @controllers:	Number of mux controllers handled by the chip.
- * @dev:		Device structure.
  * @id:			Used to identify the device internally.
+ * @dev:		Device structure.
  * @ops:		Mux controller operations.
  * @mux:		Array of mux controllers that are handled.
  */
 struct mux_chip {
 	unsigned int controllers;
-	struct device dev;
 	int id;
+	struct device dev;
 
 	const struct mux_control_ops *ops;
 
-- 
2.34.1

