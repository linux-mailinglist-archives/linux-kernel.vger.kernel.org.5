Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CB6B80BC66
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Dec 2023 18:42:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231861AbjLJRmr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 12:42:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232711AbjLJRlI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 12:41:08 -0500
Received: from smtp.smtpout.orange.fr (smtp-29.smtpout.orange.fr [80.12.242.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F73FFF
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 09:41:14 -0800 (PST)
Received: from pop-os.home ([92.140.202.140])
        by smtp.orange.fr with ESMTPA
        id CNnjro87trKXzCNnjrSMYO; Sun, 10 Dec 2023 18:41:12 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1702230072;
        bh=x7Q4NcLK40y5Q7ePxrJxb3SqI1bHDL9QSepFtUMOD10=;
        h=From:To:Cc:Subject:Date;
        b=Pc9BW6TFksYa1CEROk7anXD820o7hFq69nZ4E1iALGEExKqhPmIfQjNKsEChFtJ5Z
         qYeVhCs1LQvL7XSmYGMXPUXuZYaaZ2M5iw2j4NcqR7+R/YB6gI9tsQpDgQ151h1H4X
         o2laG87RbLnpBg6b8XqU/Jlj18zJd7RQYIDeWzSHD//Hk9p4mKj3ydR76xkjp0oz1G
         XTxFyzAkEv3O7g3cqagVvrD6zahuXOyZDrpxLZn/YvxShNecMuXsBxv/psXKIG4lDU
         CzYDIt9e3L971bbamm2JzXXpeuWIB2BtJXlCVrNFRQ2iqUO5Z6aWG+KF0ZiNH5UqTc
         JSOCXIC54YnLw==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 10 Dec 2023 18:41:12 +0100
X-ME-IP: 92.140.202.140
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Rodolfo Giometti <giometti@enneenne.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] pps: Remove usage of the deprecated ida_simple_xx() API
Date:   Sun, 10 Dec 2023 18:41:07 +0100
Message-Id: <5065a9fe3101dcb7ee0a79bde0ec84de03c637ec.1702230047.git.christophe.jaillet@wanadoo.fr>
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

ida_alloc() and ida_free() should be preferred to the deprecated
ida_simple_get() and ida_simple_remove().

This is less verbose.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/pps/clients/pps_parport.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pps/clients/pps_parport.c b/drivers/pps/clients/pps_parport.c
index 42f93d4c6ee3..af972cdc04b5 100644
--- a/drivers/pps/clients/pps_parport.c
+++ b/drivers/pps/clients/pps_parport.c
@@ -148,7 +148,7 @@ static void parport_attach(struct parport *port)
 		return;
 	}
 
-	index = ida_simple_get(&pps_client_index, 0, 0, GFP_KERNEL);
+	index = ida_alloc(&pps_client_index, GFP_KERNEL);
 	memset(&pps_client_cb, 0, sizeof(pps_client_cb));
 	pps_client_cb.private = device;
 	pps_client_cb.irq_func = parport_irq;
@@ -188,7 +188,7 @@ static void parport_attach(struct parport *port)
 err_unregister_dev:
 	parport_unregister_device(device->pardev);
 err_free:
-	ida_simple_remove(&pps_client_index, index);
+	ida_free(&pps_client_index, index);
 	kfree(device);
 }
 
@@ -208,7 +208,7 @@ static void parport_detach(struct parport *port)
 	pps_unregister_source(device->pps);
 	parport_release(pardev);
 	parport_unregister_device(pardev);
-	ida_simple_remove(&pps_client_index, device->index);
+	ida_free(&pps_client_index, device->index);
 	kfree(device);
 }
 
-- 
2.34.1

