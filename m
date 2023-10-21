Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 693407D1B6F
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 08:53:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229472AbjJUGxr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Oct 2023 02:53:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjJUGxq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Oct 2023 02:53:46 -0400
Received: from smtp.smtpout.orange.fr (smtp-13.smtpout.orange.fr [80.12.242.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24052D71
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 23:53:43 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id u5reqyZLtd4Wtu5rfqqNO4; Sat, 21 Oct 2023 08:53:40 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1697871220;
        bh=q+6YiMf4FjJqpY2woNDtEvfJ1SZWEDzhFtZ1+ypv620=;
        h=From:To:Cc:Subject:Date;
        b=EysZyvuNjvivikTZz1HV6uPNxwar1FxYeIW3ZPl6RB94dHadJkAhx/cMu/4K4ad/V
         N1VEKRFwKHTh8ZUL5HRXQptbuvrhFE3V+gUP/lZ+2mpFJoKjKpgpcB9uEdNttXL8dW
         FEYGs7+OdgBqoZ86yNQ6UFX0tz2V0Lky44jfLSnysdNY4nth95725mV4TlqLVEiToW
         fvX6Z+teSxGjh1Tb5asFg2GSfGrbpwongRfMXRnXjDc4vAWv8GbbK2jydBIPoNdnTe
         0vl8DSe2v/n3hiR7lqTtgo/V7vctb5Qjlzc55Nkmgqm66B2/+EDwU8wGR/38okyH8y
         hSOtX7pWH5BaA==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 21 Oct 2023 08:53:40 +0200
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Helge Deller <deller@gmx.de>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: [PATCH] fbdev/offb: Simplify offb_init_fb()
Date:   Sat, 21 Oct 2023 08:53:37 +0200
Message-Id: <1c94c99117617c1a844f6551b7bca27f23c5f0c8.1697871190.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Turn a strcpy()+strncat()+'\0' into an equivalent snprintf().

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
This patch is *not* even compile tested because cross-compiling leads to
some errors like on my machine:
   cc1: error: cannot load plugin ./scripts/gcc-plugins/randomize_layout_plugin.so: ./scripts/gcc-plugins/randomize_layout_plugin.so: undefined symbol: _ZNK6frange6acceptERK14vrange_visitor

So review with care!
---
 drivers/video/fbdev/offb.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/video/fbdev/offb.c b/drivers/video/fbdev/offb.c
index dcb1b81d35db..b421b46d88ef 100644
--- a/drivers/video/fbdev/offb.c
+++ b/drivers/video/fbdev/offb.c
@@ -423,11 +423,9 @@ static void offb_init_fb(struct platform_device *parent, const char *name,
 	fix = &info->fix;
 	var = &info->var;
 
-	if (name) {
-		strcpy(fix->id, "OFfb ");
-		strncat(fix->id, name, sizeof(fix->id) - sizeof("OFfb "));
-		fix->id[sizeof(fix->id) - 1] = '\0';
-	} else
+	if (name)
+		snprintf(fix->id, sizeof(fix->id), "OFfb %s", name);
+	else
 		snprintf(fix->id, sizeof(fix->id), "OFfb %pOFn", dp);
 
 
-- 
2.34.1

