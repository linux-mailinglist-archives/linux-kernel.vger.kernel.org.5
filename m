Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37E57756C03
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 20:28:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229458AbjGQS2f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 14:28:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230426AbjGQS1p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 14:27:45 -0400
Received: from smtp.smtpout.orange.fr (smtp-25.smtpout.orange.fr [80.12.242.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A59FF10FE
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 11:27:20 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id LSvbqI3jtF3kiLSvbqbtkE; Mon, 17 Jul 2023 20:26:36 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1689618396;
        bh=kBD2e0F/GIE7mK1/X5V+wBc0M2ODYA/DNmvWog50OLg=;
        h=From:To:Cc:Subject:Date;
        b=c1l4uAXRziFcIhZT/t3Uw/UFXsl+TJwWix1ioOHeSFvIFZ6DvWr09QihTxIxMORD5
         qiy2AkAG0rwxrD7bHwlK6v+QGRf5d926XyNIIXXXHhDXiewD38cEIdXOhNtdx3pSKK
         KZAeM2NoF4FONJIcI6vMp7klOWKasReRg2alhAB68YcWU9vZoVxsZ6qTaGph2HaAjz
         /J7fYhPtqYRm0853vRvKbGfrfrUEEJ1TC++bONStiH/XybNJoceTPF6vvRrYaFlvhV
         G05HgPkR5sCzGXUMY9dY50jihldp77gvgYN7fMSdtKBOBvrdxMz4MWcYtddRYeFrXs
         fIpjneF9msctw==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 17 Jul 2023 20:26:36 +0200
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Saravana Kannan <saravanak@google.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] driver core: Fix an error handling path in fw_devlink_create_devlink()
Date:   Mon, 17 Jul 2023 20:26:30 +0200
Message-Id: <858b140b276ceab52a84ce0d4f924b0c411560d1.1689618373.git.christophe.jaillet@wanadoo.fr>
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

All error handling paths go to 'out', except this one. Be consistent and
also branch to 'out' here.

Fixes: 74c782cff77b ("driver core: fw_devlink: Handle suppliers that don't use driver core")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
/!\ Speculative /!\

   This patch is based on analysis of the surrounding code and should be
   reviewed with care !

   If the patch is wrong, maybe a comment in the code could explain why.

/!\ Speculative /!\
---
 drivers/base/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 3dff5037943e..854c1fab742c 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -2107,7 +2107,8 @@ static int fw_devlink_create_devlink(struct device *con,
 	    fwnode_ancestor_init_without_drv(sup_handle)) {
 		dev_dbg(con, "Not linking %pfwf - might never become dev\n",
 			sup_handle);
-		return -EINVAL;
+		ret = -EINVAL;
+		goto out;
 	}
 
 	ret = -EAGAIN;
-- 
2.34.1

