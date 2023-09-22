Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E0D27AAC5A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 10:17:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232574AbjIVIPj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 04:15:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232548AbjIVIPT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 04:15:19 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A475CE6
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 01:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        sang-engineering.com; h=from:to:cc:subject:date:message-id
        :in-reply-to:references:mime-version:content-transfer-encoding;
         s=k1; bh=QKeY3D1+RN2jWEiErP7FIt0WfM1XoXZIvIYk9D2iHHQ=; b=R5CTX7
        Cc74i2zTJPhTZQsdOeMPilA3jf6l5YB/BPNT6DjiamkKKichgIQfvpJdsnoedKbE
        jrn3ZzkBABs758k+TSlQGvnSPY1XaSI6U/U+/WB+HtbrZ7GH2S/bdT3cswVy+Mkv
        6k2Ql38LtDrlbxezTOyWSK/nAHdMmkjkx/loKRx+dhdN3H7sLv7ReV0oZ/kv2IqD
        phC8Ejx5aoFLgG/F2+O2baVF1078MLZnsyWFjF3W7FAtWbEmgwC5E0ZlF+JCjquV
        lLZUejURuSL91NjdLKERq+HLNKSwmIQRS0mnsKpIWGz/jNgIVgtCs2ZkkCM6oKKL
        u+zHtdccfllf9DRA==
Received: (qmail 1310895 invoked from network); 22 Sep 2023 10:04:28 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 22 Sep 2023 10:04:28 +0200
X-UD-Smtp-Session: l3s3148p1@J427Du4FZsIujntX
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-renesas-soc@vger.kernel.org
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] usb: typec: drop check because i2c_unregister_device() is NULL safe
Date:   Fri, 22 Sep 2023 10:04:18 +0200
Message-Id: <20230922080421.35145-2-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230922080421.35145-1-wsa+renesas@sang-engineering.com>
References: <20230922080421.35145-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No need to check the argument of i2c_unregister_device() because the
function itself does it.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
Build tested only. Please apply to your tree.

 drivers/usb/typec/anx7411.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/usb/typec/anx7411.c b/drivers/usb/typec/anx7411.c
index 221604f933a4..b12a07edc71b 100644
--- a/drivers/usb/typec/anx7411.c
+++ b/drivers/usb/typec/anx7411.c
@@ -1550,8 +1550,7 @@ static void anx7411_i2c_remove(struct i2c_client *client)
 	if (plat->workqueue)
 		destroy_workqueue(plat->workqueue);
 
-	if (plat->spi_client)
-		i2c_unregister_device(plat->spi_client);
+	i2c_unregister_device(plat->spi_client);
 
 	if (plat->typec.role_sw)
 		usb_role_switch_put(plat->typec.role_sw);
-- 
2.30.2

