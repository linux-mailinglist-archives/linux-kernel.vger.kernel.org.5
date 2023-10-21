Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC1767D1EDD
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 20:04:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231356AbjJUSEF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Oct 2023 14:04:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232012AbjJUSED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Oct 2023 14:04:03 -0400
Received: from smtp.smtpout.orange.fr (smtp-13.smtpout.orange.fr [80.12.242.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C59E4121
        for <linux-kernel@vger.kernel.org>; Sat, 21 Oct 2023 11:04:00 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id uGKJqVjkbvhM3uGKKqJsb4; Sat, 21 Oct 2023 20:03:59 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1697911439;
        bh=WGG4h3fjFFGpf7YbjWTDEm1O70pn20++HFr6LfKdydw=;
        h=From:To:Cc:Subject:Date;
        b=az72N/+VVqLJjQfVTcgZ4ikmpD61YAW5vF1x8FXwB4ztn4zLiyLT8trgH+bnLdIIl
         Kj1fX7IhGKpLllE/jz9ugHU7aeEtzbsC/qLpem930KKhixLtBl1s+96flijMwKy8hm
         JGH6RpVsS9NGSv6SANu0DfjDyD6a/riJs5AkiPSvD9UPehB6FBBOm9oNxIIvHtU4WU
         pvzQDqQYtm0+MqsPrTGPxA06EGnG5nvU3FRIEeRirCWBenTNqxDqwt9sBsicrzJLq6
         HKAj/kO4BiNCT2eDRw55nOzwdhFi8R02vudrIFBFn4YBB5MBvT2CMyK2r6L7O10/kP
         /mw23XndOpY0g==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 21 Oct 2023 20:03:59 +0200
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     keescook@chromium.org,
        Michael Hennerich <michael.hennerich@analog.com>,
        Alexander Aring <alex.aring@gmail.com>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Marcel Holtmann <marcel@holtmann.org>
Cc:     linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Stefan Schmidt <stefan@osg.samsung.com>,
        linux-wpan@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH net] net: ieee802154: adf7242: Fix some potential buffer overflow in adf7242_stats_show()
Date:   Sat, 21 Oct 2023 20:03:53 +0200
Message-Id: <7ba06db8987298f082f83a425769fe6fa6715fe7.1697911385.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

strncat() usage in adf7242_debugfs_init() is wrong.
The size given to strncat() is the maximum number of bytes that can be
written, excluding the trailing NULL.

Here, the size that is passed, DNAME_INLINE_LEN, does not take into account
the size of "adf7242-" that is already in the array.

In order to fix it, use snprintf() instead.

Fixes: 7302b9d90117 ("ieee802154/adf7242: Driver for ADF7242 MAC IEEE802154")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/net/ieee802154/adf7242.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ieee802154/adf7242.c b/drivers/net/ieee802154/adf7242.c
index a03490ba2e5b..cc7ddc40020f 100644
--- a/drivers/net/ieee802154/adf7242.c
+++ b/drivers/net/ieee802154/adf7242.c
@@ -1162,9 +1162,10 @@ static int adf7242_stats_show(struct seq_file *file, void *offset)
 
 static void adf7242_debugfs_init(struct adf7242_local *lp)
 {
-	char debugfs_dir_name[DNAME_INLINE_LEN + 1] = "adf7242-";
+	char debugfs_dir_name[DNAME_INLINE_LEN + 1];
 
-	strncat(debugfs_dir_name, dev_name(&lp->spi->dev), DNAME_INLINE_LEN);
+	snprintf(debugfs_dir_name, sizeof(debugfs_dir_name),
+		 "adf7242-%s", dev_name(&lp->spi->dev));
 
 	lp->debugfs_root = debugfs_create_dir(debugfs_dir_name, NULL);
 
-- 
2.34.1

