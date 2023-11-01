Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BF0C7DDE8E
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 10:38:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230527AbjKAJiI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 05:38:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjKAJiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 05:38:07 -0400
Received: from smtp.smtpout.orange.fr (smtp-14.smtpout.orange.fr [80.12.242.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2313EF3
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 02:38:05 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id y7fmqyDrRdFbKy7fnqnDdw; Wed, 01 Nov 2023 10:38:03 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1698831483;
        bh=ad2YBC4kdC7h9yIQ+wHLqq1yakTOU/H6sF4OhosOPYI=;
        h=From:To:Cc:Subject:Date;
        b=Rk+wJHPWYeECroi7Y+yzItW+7eeAsQBmnZwcuGilA1G2EXtphCiOolBwEPBPvy0tA
         B+6fmnkP1O1nS8hfLaARQKPxd7pien4SUiq3UGMmOsVUDe6EO4L/08+rAojMtBjr+a
         D80s1PqL6T60vEjOh0CZ2vvFN2Ml3ui3ZjSNxTPxoOGwcOB5Ma54GwkwJ8Loy6FMn1
         fsnGw5mgMqx0ASLcvkvKKjCDw3Zk9kbXU7mp9+iAEwiyjNwEICdEoWs8+WxkaZWmsN
         BFtsHKnR236AGEUiLJD+No//GM1TFewr92SN4hEQPy83ktf/hQBymgzS9GRB+8P2Fu
         k03XqWn7PjICw==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Wed, 01 Nov 2023 10:38:03 +0100
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-input@vger.kernel.org
Subject: [PATCH] HID: sony: Remove usage of the deprecated ida_simple_xx() API
Date:   Wed,  1 Nov 2023 10:38:00 +0100
Message-Id: <19b538bc05c11747a3dd9fa204fde91942063d52.1698831460.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
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
 drivers/hid/hid-sony.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index ebc0aa4e4345..55c0ad61d524 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -1844,8 +1844,7 @@ static int sony_set_device_id(struct sony_sc *sc)
 	 * All others are set to -1.
 	 */
 	if (sc->quirks & SIXAXIS_CONTROLLER) {
-		ret = ida_simple_get(&sony_device_id_allocator, 0, 0,
-					GFP_KERNEL);
+		ret = ida_alloc(&sony_device_id_allocator, GFP_KERNEL);
 		if (ret < 0) {
 			sc->device_id = -1;
 			return ret;
@@ -1861,7 +1860,7 @@ static int sony_set_device_id(struct sony_sc *sc)
 static void sony_release_device_id(struct sony_sc *sc)
 {
 	if (sc->device_id >= 0) {
-		ida_simple_remove(&sony_device_id_allocator, sc->device_id);
+		ida_free(&sony_device_id_allocator, sc->device_id);
 		sc->device_id = -1;
 	}
 }
-- 
2.34.1

