Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 947EF756EA8
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 22:59:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbjGQU7N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 16:59:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjGQU7L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 16:59:11 -0400
Received: from smtp.smtpout.orange.fr (smtp-17.smtpout.orange.fr [80.12.242.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2C08A4
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 13:59:10 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id LVJCqUVoYFtSYLVJDqOY7F; Mon, 17 Jul 2023 22:59:09 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1689627549;
        bh=bBwLuFazUuxYCGfEXRFxeHu86Q9tYW1XepWJEFG929I=;
        h=From:To:Cc:Subject:Date;
        b=bBnCqgbyiMVdDcTfAiV13KWJ+nMAcHQ4A1fYFzfHrR4flM9hjIb/z63k1uiviOhM6
         umJvYXgXrfHZkSoCPKg5b96aLoLFeJnhF2m0q2r9tg5sxWpQpkArXzd+nbUR79ALxV
         ca1rahGgOJ3CdhL/0n4DLqs1o0UKGdWtc2luHACVxJWbQ3EBjRf0P7yIQXkTkv299I
         ZY1ATpTB8B8WT86vU8Ne42vutpWSbRU+MhQKEXiCEGtX8sDyiYIouanqZ8yyT2SZBk
         v3P3R36xMYJ8o4bLAu3iF9h9Vw6cJC/h84RxNyo842mIkyZQeN64qnQopMQni/22m7
         /DmDBYCK0Fs4A==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 17 Jul 2023 22:59:09 +0200
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Jorge Lopez <jorge.lopez2@hp.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH] platform/x86: hp-bioscfg: Fix another memory leaks in hp_populate_enumeration_elements_from_package()
Date:   Mon, 17 Jul 2023 22:59:05 +0200
Message-Id: <2a60147e2d555a77d348d1bdfec160bc936e1dc6.1689627531.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the check that both expected and read object type match fails, some
resource may still need to be released.

Add the missing kfree().

Fixes: 6b2770bfd6f9 ("platform/x86: hp-bioscfg: enum-attributes")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
/!\ Speculative /!\

   This patch is based on analysis of the surrounding code and should be
   reviewed with care !

/!\ Speculative /!\
---
 drivers/platform/x86/hp/hp-bioscfg/enum-attributes.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/platform/x86/hp/hp-bioscfg/enum-attributes.c b/drivers/platform/x86/hp/hp-bioscfg/enum-attributes.c
index dd173020c747..8e615ccfc9b5 100644
--- a/drivers/platform/x86/hp/hp-bioscfg/enum-attributes.c
+++ b/drivers/platform/x86/hp/hp-bioscfg/enum-attributes.c
@@ -164,6 +164,7 @@ static int hp_populate_enumeration_elements_from_package(union acpi_object *enum
 		if (expected_enum_types[eloc] != enum_obj[elem].type) {
 			pr_err("Error expected type %d for elem %d, but got type %d instead\n",
 			       expected_enum_types[eloc], elem, enum_obj[elem].type);
+			kfree(str_value);
 			return -EIO;
 		}
 
-- 
2.34.1

