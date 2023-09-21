Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E9107A9B08
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 20:53:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230256AbjIUSxK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 14:53:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230228AbjIUSwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 14:52:49 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BF4F8DEDC
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:54:36 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1c1e3a4a06fso10251625ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695318874; x=1695923674; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ntFYzRRPH6h7NTTrU5OlfJP05uG/LpkpMCjAuag4Kkc=;
        b=BTDhImtu+T1lIbYOfOgvjX2YZfyHJN7Fgg68GJuvFbhOop1OYwjm//OF0ijGv2SEts
         TXm6k4AijChwe0SCA3vchDb3kXSSNHUh4R//5gYprqXwFQ9trHf6/xDEIXzrq+BuqT4v
         v0DvXVCgX1RyM0L+10r5ivzwxpQWFkSmGxr93qWASUqpnW6QgIWH3os1l0tmSgeVw06m
         shsVaCnWypR5fd5S/HAnsVvGRiUC3dK4i2PoNDL7MbES38rxymcSeueG+pOFnOFjcRP7
         Y6eccHYrvdb4eDq5wCtvkThnM3EihCMnYbyWwwzBZBoyh8lJd+xSAw13iz1o6hVRmRiG
         YeFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695318874; x=1695923674;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ntFYzRRPH6h7NTTrU5OlfJP05uG/LpkpMCjAuag4Kkc=;
        b=vPt7WK9Vy+9fswCzvW+KkXgMKJvCfMz5CZeoEWhSeadpFT3hSmYAV3gxPY1uku1RuY
         8IUWmVrw/yQE6Xw3UVPzPrLgZGwU/ENlibfzBR+WTEDzMcGyp4k6cLvcF2AEKV51EYKe
         uPNFezK4MDOV/hU/3bM4C6iWoz28m1s4hE3r6voNJBbHw3yma2BJizFXuZFD+zTbNKG9
         UI/mbZ/YyclJKMVLN6hhaSSObILhEmzAYjXXCsCon97QxlODKzgvjD8zcVJeKt7NObiB
         2FTPhcYyIK1xbnnW4Nr4a6tnSqtzhC2Q4XiGBOq/euKr18LFArfFDsfih8W8Ul1foNNq
         szQw==
X-Gm-Message-State: AOJu0YywizPnxv+Y4Jb6YQ3DduqqySeYvLisxRb5L+Cn/bx2gq+9lDbc
        xJMlObrMJbjUwVSbP7oUJwjRy+ckYuw=
X-Google-Smtp-Source: AGHT+IHm6nVqzehFXY6vEF16SHpPlU7oBFFCAc51VIviyurfJg7vB7aYgvQo0m1cGdNkYQ/CBX38Ag==
X-Received: by 2002:a05:6808:1820:b0:3a8:43d5:878b with SMTP id bh32-20020a056808182000b003a843d5878bmr5338958oib.2.1695283316233;
        Thu, 21 Sep 2023 01:01:56 -0700 (PDT)
Received: from localhost.localdomain ([111.108.111.135])
        by smtp.gmail.com with ESMTPSA id fm1-20020a056a002f8100b00679a4b56e41sm735214pfb.43.2023.09.21.01.01.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Sep 2023 01:01:55 -0700 (PDT)
From:   Wei Gong <gongwei833x@gmail.com>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, Wei Gong <gongwei833x@gmail.com>
Subject: [PATCH] genirq: avoid long loops in handle_edge_irq
Date:   Thu, 21 Sep 2023 16:01:46 +0800
Message-Id: <20230921080146.37186-1-gongwei833x@gmail.com>
X-Mailer: git-send-email 2.32.1 (Apple Git-133)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When there are a large number of interrupts occurring on the tx
queue(irq smp_affinity=1) of the network card, changing the CPU
affinity of the tx queue (echo 2 > /proc/irq/xx/smp_affinity)
will cause handle_edge_irq to loop for a long time in the
do {} while() loop.

After setting the IRQ CPU affinity, the next interrupt will only
be activated when it arrives. Therefore, the next interrupt will
still be on CPU 0. When a new CPU affinity is activated on CPU 0,
subsequent interrupts will be processed on CPU 1.

       cpu 0                                cpu 1
  - handle_edge_irq
    - apic_ack_irq
      - irq_do_set_affinity
                                        - handle_edge_irq
    - do {
        - handle_irq_event
          - istate &= ~IRQS_PENDIN
          - IRQD_IRQ_INPROGRESS
          - spin_unlock()
                                          - spin_lock()
                                          - istate |= IRQS_PENDIN
          - handle_irq_event_percpu       - mask_ack_irq()
                                          - spin_unlock()
          - spin_unlock

      } while(IRQS_PENDIN &&
              !irq_disable)

Therefore, when determining whether to continue looping, we add a check
to see if the current CPU belongs to the affinity table of the interrupt.

Signed-off-by: Wei Gong <gongwei833x@gmail.com>
---
 kernel/irq/chip.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index dc94e0bf2c94..cafd395367c3 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -831,7 +831,8 @@ void handle_edge_irq(struct irq_desc *desc)
 		handle_irq_event(desc);
 
 	} while ((desc->istate & IRQS_PENDING) &&
-		 !irqd_irq_disabled(&desc->irq_data));
+		 !irqd_irq_disabled(&desc->irq_data) &&
+		 cpumask_test_cpu(smp_processor_id(), desc->irq_common_data.affinity));
 
 out_unlock:
 	raw_spin_unlock(&desc->lock);
-- 
2.32.1 (Apple Git-133)

