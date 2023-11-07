Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C5F87E3B21
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 12:30:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233961AbjKGLat (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 06:30:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbjKGLas (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 06:30:48 -0500
X-Greylist: delayed 368 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 07 Nov 2023 03:30:42 PST
Received: from mail.nppct.ru (mail.nppct.ru [195.133.245.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DFAFEA
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 03:30:41 -0800 (PST)
Received: from mail.nppct.ru (localhost [127.0.0.1])
        by mail.nppct.ru (Postfix) with ESMTP id A787B1C0E46
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 14:24:29 +0300 (MSK)
Authentication-Results: mail.nppct.ru (amavisd-new); dkim=pass (1024-bit key)
        reason="pass (just generated, assumed good)" header.d=nppct.ru
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nppct.ru; h=
        content-transfer-encoding:mime-version:x-mailer:message-id:date
        :date:subject:subject:to:from:from; s=dkim; t=1699356268; x=
        1700220269; bh=x6jysyZ5oZimszC/+KWYqfqt9dmO+sPqmSEiLu28WpI=; b=Y
        9HccfJ/7sU3HQK+uVCl8IXpS3ZanMy63ECDpLEvA/dqgZMsRs0bH97cssrgnz1o0
        Ql6ckNs26oy+zX/aUL8XT8YQ7ivs+BX8E11aKqGYsAofST2cFeuqcH/s6Cu3/YQS
        VuKcfZguqtGs8sL8c2WrgCagRMsvHZk3fbfnU4P8Qk=
X-Virus-Scanned: Debian amavisd-new at mail.nppct.ru
Received: from mail.nppct.ru ([127.0.0.1])
        by mail.nppct.ru (mail.nppct.ru [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id d1B-XwSv2WzY for <linux-kernel@vger.kernel.org>;
        Tue,  7 Nov 2023 14:24:28 +0300 (MSK)
Received: from localhost.localdomain (mail.dev-ai-melanoma.ru [185.130.227.204])
        by mail.nppct.ru (Postfix) with ESMTPSA id C3F401C0859;
        Tue,  7 Nov 2023 14:24:27 +0300 (MSK)
From:   Andrey Shumilin <shum.sdl@nppct.ru>
To:     3chas3@gmail.com
Cc:     Andrey Shumilin <shum.sdl@nppct.ru>,
        linux-atm-general@lists.sourceforge.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Subject: [PATCH] iphase: Adding a null pointer check
Date:   Tue,  7 Nov 2023 14:24:19 +0300
Message-Id: <20231107112419.14404-1-shum.sdl@nppct.ru>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.7 required=5.0 tests=BAYES_05,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pointer <dev->desc_tbl[i].iavcc> is dereferenced on line 195.
Further in the code, it is checked for null on line 204.
It is proposed to add a check before dereferencing the pointer.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Andrey Shumilin <shum.sdl@nppct.ru>
---
 drivers/atm/iphase.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/atm/iphase.c b/drivers/atm/iphase.c
index 324148686953..596422fbfacc 100644
--- a/drivers/atm/iphase.c
+++ b/drivers/atm/iphase.c
@@ -192,6 +192,11 @@ static u16 get_desc (IADEV *dev, struct ia_vcc *iavcc) {
            i++;
            continue;
         }
+       if (!(iavcc_r = dev->desc_tbl[i].iavcc)) {
+	   printk("Fatal err, desc table vcc or skb is NULL\n");
+	   i++;
+	   continue;
+	}
         ltimeout = dev->desc_tbl[i].iavcc->ltimeout; 
         delta = jiffies - dev->desc_tbl[i].timestamp;
         if (delta >= ltimeout) {
-- 
2.30.2

