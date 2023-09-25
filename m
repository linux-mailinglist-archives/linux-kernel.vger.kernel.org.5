Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25BBA7ACE7A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 04:52:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbjIYCwM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 22:52:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbjIYCwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 22:52:10 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D554FB
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 19:52:03 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-577e62e2adfso3358028a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 19:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695610323; x=1696215123; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xqbrouaImx5KBoP6AYN1d+wBdtJOt9nHHasbW1/FriU=;
        b=X8A6zbP+K5TtNV3tpMuIrzAHno5Aqq0JNx+MkI4wTxqe4h/enuJoJhEBAfWYJrpRDV
         h7y3U57M2rbv+/jLviKiKqtxfH9z0U5+XUgDhAZfabInpOizExi4lEu8IXteSuXmj/RG
         gB1qEHQAEJ8k8ZvYAckUJ6d3AKOU3B/qx6svebR3lHJQIGDkli9PGPX1/9cxZ2AmnfiP
         4L7aPuSdLI8iHDKu0le3psQPvwsS7Fy4MMcwBgE6jTLGwraudIM48hjnwqTBy3SS0QR7
         NRX45b3cE1Odz6GgSo5rfYk7DycA+YAqMC7LnbdOm2iYDfZYGqjIHI1BhXCAP4HXoqWF
         lByA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695610323; x=1696215123;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xqbrouaImx5KBoP6AYN1d+wBdtJOt9nHHasbW1/FriU=;
        b=ZunEgwx1yj/IW0huIkfcSgXtZYRy+0ilixJX/RTHgeTsE6kHgyBxgj2HgE77hw7Nh6
         8FRiB0wL8mD7jh5uiehqbSevw93emxxHj3g5Tevb+xKM5RQtAXWdu09psxmiwOzCDW9j
         CsgBrYNF8jg7ewWCHKxpdCcHm4kg/B/hbvSS8Zx5t2JaVJ+fLK0JiVJwHZOpKq3uNgWN
         2zXaqEvCCWyP+brikXZ2xJSKkjl3okhVeMPy7fuvPIujh4fsOBGU3tghn9nr0qNt0w2m
         w4T6mROzohDOsQqViMaGPHnnlwLy/xEzxJd6KgeOMUi82joCGmWmHL182zYD+fw/ccvB
         X73g==
X-Gm-Message-State: AOJu0Yy3+iYHulbe81Ml15N/OQFqvFFu33aVDXGxho6ftgryfzJRhUh1
        YVukVkCWgpVJL2yCLimpjUJ2UzrpYi4=
X-Google-Smtp-Source: AGHT+IGC3u1JK+vxSE9Q5Ig8CHy4MoFD+p0J4AzBqJUhbEyNlIy0+NtQ7BuQkNU0p4SYdVc0vZoWyw==
X-Received: by 2002:a05:6a20:4421:b0:14e:429e:b0e3 with SMTP id ce33-20020a056a20442100b0014e429eb0e3mr4772065pzb.52.1695610322822;
        Sun, 24 Sep 2023 19:52:02 -0700 (PDT)
Received: from localhost.localdomain ([111.108.111.133])
        by smtp.gmail.com with ESMTPSA id j5-20020a170902da8500b001bb99e188fcsm7511962plx.194.2023.09.24.19.52.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Sep 2023 19:52:02 -0700 (PDT)
From:   Wei Gong <gongwei833x@gmail.com>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, Wei Gong <gongwei833x@gmail.com>
Subject: [PATCH v2] genirq: avoid long loops in handle_edge_irq
Date:   Mon, 25 Sep 2023 10:51:54 +0800
Message-Id: <20230925025154.37959-1-gongwei833x@gmail.com>
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
index dc94e0bf2c94..6da455e1a692 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -831,7 +831,8 @@ void handle_edge_irq(struct irq_desc *desc)
 		handle_irq_event(desc);
 
 	} while ((desc->istate & IRQS_PENDING) &&
-		 !irqd_irq_disabled(&desc->irq_data));
+		 !irqd_irq_disabled(&desc->irq_data) &&
+		 cpumask_test_cpu(smp_processor_id(), irq_data_get_affinity_mask(&desc->irq_data)));
 
 out_unlock:
 	raw_spin_unlock(&desc->lock);
-- 
2.32.1 (Apple Git-133)

