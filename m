Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51F4F8087F0
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 13:36:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379360AbjLGMfA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 07:35:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232583AbjLGMe5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 07:34:57 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83BA11705;
        Thu,  7 Dec 2023 04:35:00 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-6ce972ac39dso497056b3a.3;
        Thu, 07 Dec 2023 04:35:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701952500; x=1702557300; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kGs5SZ4OnkMZiDcFi+aS6xiXccmSR17E7aP+R5JAOfc=;
        b=gqyM0CBYwz3AmLW6QPFqmY/6rmO550vP09q5PGXwK17RLIg+hOqxMd/tiYu9Xdu4TX
         NtRtO1BSN1/E36vlIxG6PSg4KeKMS5yV6HrGRBQgQaZ+eUwqkaSQe07ET42JAnlIdEX4
         IOaE5a+qcrY/He8s9JbzqaHQV0nclfEKmjO+J6GkNZ/fkLdINN6H198yWCfEjGwddnvr
         qRyG+XKsV1XE7goyQYlTiRlezL8liRb/E3X48NVBarYwNre9eos3tvqMGvyJsc3JHohk
         Ov+Ny7NBoliE7YZi3hdI/h0kguAQ2ShehT5No9GS4/OBShgyMVqDVmlfKDNcDg79PE9S
         zzbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701952500; x=1702557300;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kGs5SZ4OnkMZiDcFi+aS6xiXccmSR17E7aP+R5JAOfc=;
        b=ehsPNBVWZ4f2VLlU5ELoIXRGN3hkMefL1BZx+qmG9Zdp8cQAskuukdsgfJqWgjxRdp
         C0dzjzp/pLT3sPfsQJcAKhOClBn1i2ctRcNWRfWxJnVtmAhgXqTkCJghraMfM7Um3r9U
         oX3c65/BEpwQ23eQoICN4qds5NG52hMm0R5S8sst09We6baa4lj3tIF1gMSoZe7QmLSZ
         ZLiBx0SLtwEVOhR6ZXp+pvaUQyLfsAGlAPpdAbPlfOIx/7azh+xwjFWv30jVBxFtBuPe
         TlWGZTeJj9fGsDQTJ8IIb5SeuJKIzqcrTCMkzMWgb3w3RdGUFuM9JvqmPhrYp3bxtQyE
         G6ug==
X-Gm-Message-State: AOJu0YxSrZuqR4nKZwp4uNR7MX9VfIgbFl2S9/2QN3G1jGAfzIOnKNec
        O7/GO3tyNZY3K4f0ECQLEeA=
X-Google-Smtp-Source: AGHT+IHkizdzukd/3UMo1my8tUuc2435KzvYh/Ksh2FFo+rEgwfutClT2v9L3QS+1oWeJ9N9yqtW7A==
X-Received: by 2002:a05:6a20:8fa5:b0:18f:97c:925c with SMTP id k37-20020a056a208fa500b0018f097c925cmr1761722pzj.65.1701952499679;
        Thu, 07 Dec 2023 04:34:59 -0800 (PST)
Received: from 377044c6c369.cse.ust.hk (191host097.mobilenet.cse.ust.hk. [143.89.191.97])
        by smtp.gmail.com with ESMTPSA id g1-20020aa79dc1000000b006cdd723bb6fsm1160300pfq.115.2023.12.07.04.34.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 04:34:59 -0800 (PST)
From:   Chengfeng Ye <dg573847474@gmail.com>
To:     3chas3@gmail.com, davem@davemloft.net, horms@kernel.org,
        kuba@kernel.org
Cc:     linux-atm-general@lists.sourceforge.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Chengfeng Ye <dg573847474@gmail.com>
Subject: [PATCH v3 2/2] atm: solos-pci: Fix potential deadlock on &tx_queue_lock
Date:   Thu,  7 Dec 2023 12:34:53 +0000
Message-Id: <20231207123453.42786-1-dg573847474@gmail.com>
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

As &card->tx_queue_lock is acquired under softirq context along the
following call chain from solos_bh(), other acquisition of the same
lock inside process context should disable at least bh to avoid double
lock.

<deadlock #2>
pclose()
--> spin_lock(&card->tx_queue_lock)
<interrupt>
   --> solos_bh()
   --> fpga_tx()
   --> spin_lock(&card->tx_queue_lock)

This flaw was found by an experimental static analysis tool I am
developing for irq-related deadlock.

To prevent the potential deadlock, the patch uses spin_lock_bh()
on &card->tx_queue_lock under process context code consistently to
prevent the possible deadlock scenario.

Fixes: 213e85d38912 ("solos-pci: clean up pclose() function")
Signed-off-by: Chengfeng Ye <dg573847474@gmail.com>
---
V3: change to spin_lock_bh()
V2: add fix tag, and slipt into two patches

 drivers/atm/solos-pci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/atm/solos-pci.c b/drivers/atm/solos-pci.c
index 95f768b28a5e..d3c30a28c410 100644
--- a/drivers/atm/solos-pci.c
+++ b/drivers/atm/solos-pci.c
@@ -956,14 +956,14 @@ static void pclose(struct atm_vcc *vcc)
 	struct pkt_hdr *header;
 
 	/* Remove any yet-to-be-transmitted packets from the pending queue */
-	spin_lock(&card->tx_queue_lock);
+	spin_lock_bh(&card->tx_queue_lock);
 	skb_queue_walk_safe(&card->tx_queue[port], skb, tmpskb) {
 		if (SKB_CB(skb)->vcc == vcc) {
 			skb_unlink(skb, &card->tx_queue[port]);
 			solos_pop(vcc, skb);
 		}
 	}
-	spin_unlock(&card->tx_queue_lock);
+	spin_unlock_bh(&card->tx_queue_lock);
 
 	skb = alloc_skb(sizeof(*header), GFP_KERNEL);
 	if (!skb) {
-- 
2.17.1

