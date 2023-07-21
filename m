Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1E5975D5CE
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 22:34:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbjGUUeY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 16:34:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbjGUUeV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 16:34:21 -0400
Received: from smtp.smtpout.orange.fr (smtp-29.smtpout.orange.fr [80.12.242.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 21295C6
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 13:34:19 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id Mwhvq5N2CulAmMwhvq9ybY; Fri, 21 Jul 2023 22:26:38 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1689971198;
        bh=8TlOW+i79X0brpTGnWxr2cgo7GT+cXEmcXkyUiXUr/c=;
        h=From:To:Cc:Subject:Date;
        b=q8nE5wnerM1zY4vlDUqKnIWEiPsY3DSxVfmpL3T8RXWClfJRx5wuGC6u0RyP+htlD
         dTpbYW0pjWzxizupLBbpyHsmudrgb5ir7L9KALWKU3k6OTAW5FRJj6XFaJ3FVIJTHx
         RIwgJlU/seNHcFsy21xJ5JFJoZt0m3PegFZ4FfLkHfOE+66lemqS/KbUWccKxCZHYs
         TmEuilF7hV7AFGnhVHjw0C0QYkUfaCMflb4eIQU/fQBa33vJOUXpt8tWjPXOF0TBwg
         c6I8LMKezmF5PBZnNsjMQo+s+JdCc3na4BxbkrTmBsz8x+rx8pqrYYNBmVEjqE1C6i
         qdpGTVXo/TT3w==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Fri, 21 Jul 2023 22:26:38 +0200
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     akpm@linux-foundation.org, andriy.shevchenko@linux.intel.com,
        Tomas Winkler <tomas.winkler@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] mei: pxp: Keep a const qualifier when calling mei_cldev_send()
Date:   Fri, 21 Jul 2023 22:26:27 +0200
Message-Id: <23c078181575e65ff660f993bc6eb38753b3d5e7.1689971167.git.christophe.jaillet@wanadoo.fr>
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

The API has been fixed in commit 0912ef4855e8 ("mei: constify passed
buffers and structures"), so there is no more need to drop the const
qualifier and the comment can be removed as-well.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/misc/mei/pxp/mei_pxp.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/misc/mei/pxp/mei_pxp.c b/drivers/misc/mei/pxp/mei_pxp.c
index 3bf560bbdee0..2dcb9169e404 100644
--- a/drivers/misc/mei/pxp/mei_pxp.c
+++ b/drivers/misc/mei/pxp/mei_pxp.c
@@ -40,8 +40,7 @@ mei_pxp_send_message(struct device *dev, const void *message, size_t size)
 
 	cldev = to_mei_cl_device(dev);
 
-	/* temporary drop const qualifier till the API is fixed */
-	byte = mei_cldev_send(cldev, (u8 *)message, size);
+	byte = mei_cldev_send(cldev, message, size);
 	if (byte < 0) {
 		dev_dbg(dev, "mei_cldev_send failed. %zd\n", byte);
 		return byte;
-- 
2.34.1

