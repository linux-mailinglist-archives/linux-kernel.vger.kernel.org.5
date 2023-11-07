Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA7E37E3F31
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 13:50:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232667AbjKGMuS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 07:50:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344345AbjKGMtc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 07:49:32 -0500
Received: from mail.nppct.ru (mail.nppct.ru [195.133.245.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8394913AF5
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 04:36:19 -0800 (PST)
Received: from mail.nppct.ru (localhost [127.0.0.1])
        by mail.nppct.ru (Postfix) with ESMTP id C011D1C0DB4
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 15:36:15 +0300 (MSK)
Authentication-Results: mail.nppct.ru (amavisd-new); dkim=pass (1024-bit key)
        reason="pass (just generated, assumed good)" header.d=nppct.ru
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nppct.ru; h=
        content-transfer-encoding:mime-version:x-mailer:message-id:date
        :date:subject:subject:to:from:from; s=dkim; t=1699360573; x=
        1700224574; bh=x6jysyZ5oZimszC/+KWYqfqt9dmO+sPqmSEiLu28WpI=; b=J
        iV0qAZeIgdJp13a2vKcTuf+PBzKnYdQyrtDViKNZqjzNxHq0yguncKnwVxhEBczY
        mzGFKXzuesk4tuUnvg6Xb89omDVJTgKVv6BpySWtatPFs80N7Iq3AtK5uVSRHWGo
        JNUfRhCxMwkPv+1HVx9IEskkQK+P1TRq1B18qsnDHY=
X-Virus-Scanned: Debian amavisd-new at mail.nppct.ru
Received: from mail.nppct.ru ([127.0.0.1])
        by mail.nppct.ru (mail.nppct.ru [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id jWjaalifFrqu for <linux-kernel@vger.kernel.org>;
        Tue,  7 Nov 2023 15:36:13 +0300 (MSK)
Received: from localhost.localdomain (mail.dev-ai-melanoma.ru [185.130.227.204])
        by mail.nppct.ru (Postfix) with ESMTPSA id 236B81C0CB3;
        Tue,  7 Nov 2023 15:36:12 +0300 (MSK)
From:   Andrey Shumilin <shum.sdl@nppct.ru>
To:     3chas3@gmail.com
Cc:     Andrey Shumilin <shum.sdl@nppct.ru>,
        linux-atm-general@lists.sourceforge.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org,
        khoroshilov@ispras.ru, ykarpov@ispras.ru, vmerzlyakov@ispras.ru,
        vefanov@ispras.ru
Subject: [PATCH] iphase: Adding a null pointer check
Date:   Tue,  7 Nov 2023 15:36:00 +0300
Message-Id: <20231107123600.14529-1-shum.sdl@nppct.ru>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
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

