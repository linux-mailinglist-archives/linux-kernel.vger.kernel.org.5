Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3695D8087EA
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 13:36:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232640AbjLGMeq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 07:34:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232604AbjLGMem (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 07:34:42 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E07FF10C7;
        Thu,  7 Dec 2023 04:34:45 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1d06819a9cbso5961125ad.1;
        Thu, 07 Dec 2023 04:34:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701952485; x=1702557285; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XORpo+8lcz89CRmiL8wFYI/hY18FJ/e3tPn8ROqODEk=;
        b=JSx4jOPRLraJk8G0biNuad5XPq405S95GWR1LS0peT3WgFsmWjNBwytR2QR2/VyTVg
         Ow4OujdnYE1nogbnc27ipu439H6a+oiaC1Obvbvc1X09tAD077VOP4j35bRET0yQaPTG
         L0490k7aFuS5p94HcYGb3jcwUu1LbIi5VKUiiRaL+baJE97X4vje4vu1MPOxRnsV9X8L
         cszXrrwrcK+hKG5fqm+QOZl/Sb6vZrc2x4gQjYFebSMHqPf1wU9bY+NTk+0c72pzr9+i
         Z+6EZdTvaRJIBGXOT7JsyqrNiRlbAhc0N/qFe4gYE9RXeMdIKnVf6cCM93EZDIjXXfD2
         T/Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701952485; x=1702557285;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XORpo+8lcz89CRmiL8wFYI/hY18FJ/e3tPn8ROqODEk=;
        b=WkoOx2R2DvJlnxfsjgw+xTRM2N/MpSglMdHoX6vYlhe+4OWqzc/THDnuMUkg744NsR
         SY7ggOR0YJQSeQyq0D7KutfBr3l9ybrxcIEIbXBpC8bT7iDvcEfdvNKHnttv9Utzsa+B
         nW76ziAN2lv9HkGRt/6nRFnRxY6DZlMM55Eg6ao6X2x1Ae/g8362idrjx7/lG1rKYib+
         I170D7iTnq4ZMejUgXxHp6bX4A00Xm00J4iCtfKdKlNuvaS1Ss7/jinU6cvbMjxkCn16
         w5FUJifIOEavSLTefujX6z1HsTUAopc0+TPEBdBx+QU67xwT7VZiU85Oz8VBL2bgMBgm
         XbvQ==
X-Gm-Message-State: AOJu0Yzdo261DHb7q6KlJwOWR9931foui6BxQ0saz7+df4/mJ6SDJO2v
        E1tg+FKfsB2/wvttKVYQX9c=
X-Google-Smtp-Source: AGHT+IHpDHkN6PgB+SzwdDcnTntEvNLIVEOPgMUPsibzO3WvJirMTLa3s9xXDqzEc876pFm58/hLUA==
X-Received: by 2002:a17:903:2808:b0:1d0:75d8:6ce2 with SMTP id kp8-20020a170903280800b001d075d86ce2mr1706140plb.82.1701952485112;
        Thu, 07 Dec 2023 04:34:45 -0800 (PST)
Received: from 377044c6c369.cse.ust.hk (191host097.mobilenet.cse.ust.hk. [143.89.191.97])
        by smtp.gmail.com with ESMTPSA id i10-20020a170902c94a00b001cfad034756sm1288367pla.138.2023.12.07.04.34.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 04:34:44 -0800 (PST)
From:   Chengfeng Ye <dg573847474@gmail.com>
To:     3chas3@gmail.com, davem@davemloft.net, horms@kernel.org,
        kuba@kernel.org
Cc:     linux-atm-general@lists.sourceforge.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Chengfeng Ye <dg573847474@gmail.com>
Subject: [PATCH v3 1/2] atm: solos-pci: Fix potential deadlock on &cli_queue_lock
Date:   Thu,  7 Dec 2023 12:34:37 +0000
Message-Id: <20231207123437.42669-1-dg573847474@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As &card->cli_queue_lock is acquired under softirq context along the
following call chain from solos_bh(), other acquisition of the same
lock inside process context should disable at least bh to avoid double
lock.

<deadlock #1>
console_show()
--> spin_lock(&card->cli_queue_lock)
<interrupt>
   --> solos_bh()
   --> spin_lock(&card->cli_queue_lock)

This flaw was found by an experimental static analysis tool I am
developing for irq-related deadlock.

To prevent the potential deadlock, the patch uses spin_lock_bh()
on the card->cli_queue_lock under process context code consistently
to prevent the possible deadlock scenario.

Fixes: 9c54004ea717 ("atm: Driver for Solos PCI ADSL2+ card.")
Signed-off-by: Chengfeng Ye <dg573847474@gmail.com>
---
V3: change to spin_lock_bh()
V2: add fix tag, and slipt into two patches

 drivers/atm/solos-pci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/atm/solos-pci.c b/drivers/atm/solos-pci.c
index 94fbc3abe60e..95f768b28a5e 100644
--- a/drivers/atm/solos-pci.c
+++ b/drivers/atm/solos-pci.c
@@ -449,9 +449,9 @@ static ssize_t console_show(struct device *dev, struct device_attribute *attr,
 	struct sk_buff *skb;
 	unsigned int len;
 
-	spin_lock(&card->cli_queue_lock);
+	spin_lock_bh(&card->cli_queue_lock);
 	skb = skb_dequeue(&card->cli_queue[SOLOS_CHAN(atmdev)]);
-	spin_unlock(&card->cli_queue_lock);
+	spin_unlock_bh(&card->cli_queue_lock);
 	if(skb == NULL)
 		return sprintf(buf, "No data.\n");
 
-- 
2.17.1

