Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6F297B9F1F
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 16:19:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232113AbjJEOSd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 10:18:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244345AbjJENxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 09:53:04 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 149757ECB;
        Thu,  5 Oct 2023 00:49:12 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-578e33b6fb7so442125a12.3;
        Thu, 05 Oct 2023 00:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696492151; x=1697096951; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z+shXokc3b1SA2zWfnMnBrWdVnpdHWbiNYj8YxjiEvU=;
        b=GwPOWyQXLWjt0gMeqbtH7MH09TVrU8FdgtirXbDp8jKarK8U0KC5nLYWajknACwLG9
         ds7E0GlgpHLc0iZJj5ThZPPYKj4oDVN4t55KBZfTlrV6x9/zxm7lLtlx+aaUEA/8bAb1
         DZppdof1/p6Mn5wERoglfYhZo4pgZuwC8EYN7qyA1IWRG19W9fUX2iF7HnqgieodPPN5
         a4LJlZZT6GIIOcBfhfmlAQUTZ3jW/1teS9PJIxAcRFZkadQ3NYu+NcGOvv1E5W9Dttk6
         VbK8rkKxQqKV97AddkPyPYA6fEN85e8HoX8vYroElORIpHKBKrUBazml4w+j++X+K57j
         U7ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696492151; x=1697096951;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z+shXokc3b1SA2zWfnMnBrWdVnpdHWbiNYj8YxjiEvU=;
        b=CRsyGrdpZ/LwEqpjTj7ImUK2NWr6dS2HYKvWr2Hw1NJl2sa0FjTXqygOZKVWTrbw6A
         QsodeOuqjXHYeezFxK3a0XSjVnDhqZwlQhqxJH+IDr/2T1rHpXBLRlXp+kj3xAZ8mD/v
         ZSrW5/QG1oExBTpiQFFpT3FZEhwodQsxvgug2HK97xsuB/GtC89/X+QQkO13jfE+poBU
         OuMZt6xvekvpEneKhFbQF/RIRoLtLlCPHLYg0lKPvquY9BHSI5tgFNV9BQ/SdeGVT+xr
         AEtQdfbUi7ezArFOlJOeDzNr9bjbZZWPV95m70/2ioE6atG19JCemUGbZ0UhG/u6Cvoz
         scmg==
X-Gm-Message-State: AOJu0Yz3IyWfyXltAietjKO/5IA7gT0QLO+Z7F7hgZ8tQP6FxW8b8fB8
        cm3elO0OuXKYZDkbi4+ySxI=
X-Google-Smtp-Source: AGHT+IFctSNXXRG6BjXN/xRDMVWMn9ZK2l+5Q7fGGJM5KNiZ1ViEQTsL+oyBbyLQdCa3dYEgDyLXuw==
X-Received: by 2002:a17:90a:c9:b0:274:46cd:5af2 with SMTP id v9-20020a17090a00c900b0027446cd5af2mr4174201pjd.34.1696492151357;
        Thu, 05 Oct 2023 00:49:11 -0700 (PDT)
Received: from 377044c6c369.cse.ust.hk (191host097.mobilenet.cse.ust.hk. [143.89.191.97])
        by smtp.gmail.com with ESMTPSA id y14-20020a17090a134e00b00277560ecd5dsm2772178pjf.46.2023.10.05.00.49.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 00:49:10 -0700 (PDT)
From:   Chengfeng Ye <dg573847474@gmail.com>
To:     3chas3@gmail.com, davem@davemloft.net, horms@kernel.org
Cc:     linux-atm-general@lists.sourceforge.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Chengfeng Ye <dg573847474@gmail.com>
Subject: [PATCH v2 1/2] atm: solos-pci: Fix potential deadlock on &cli_queue_lock
Date:   Thu,  5 Oct 2023 07:48:58 +0000
Message-Id: <20231005074858.65082-1-dg573847474@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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

To prevent the potential deadlock, the patch uses spin_lock_irqsave()
on the card->cli_queue_lock under process context code consistently
to prevent the possible deadlock scenario.

Fixes: 9c54004ea717 ("atm: Driver for Solos PCI ADSL2+ card.")
Signed-off-by: Chengfeng Ye <dg573847474@gmail.com>
---
V2: add fix tag, and slipt into two patches

 drivers/atm/solos-pci.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/atm/solos-pci.c b/drivers/atm/solos-pci.c
index 94fbc3abe60e..48cf9b36b61a 100644
--- a/drivers/atm/solos-pci.c
+++ b/drivers/atm/solos-pci.c
@@ -447,11 +447,12 @@ static ssize_t console_show(struct device *dev, struct device_attribute *attr,
 	struct atm_dev *atmdev = container_of(dev, struct atm_dev, class_dev);
 	struct solos_card *card = atmdev->dev_data;
 	struct sk_buff *skb;
+	unsigned long flags;
 	unsigned int len;
 
-	spin_lock(&card->cli_queue_lock);
+	spin_lock_irqsave(&card->cli_queue_lock, flags);
 	skb = skb_dequeue(&card->cli_queue[SOLOS_CHAN(atmdev)]);
-	spin_unlock(&card->cli_queue_lock);
+	spin_unlock_irqrestore(&card->cli_queue_lock, flags);
 	if(skb == NULL)
 		return sprintf(buf, "No data.\n");
 
-- 
2.17.1

