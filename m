Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6C977B180C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 12:06:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230455AbjI1KGy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 06:06:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230246AbjI1KGv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 06:06:51 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44B0D95
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 03:06:50 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-690ba63891dso9915684b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 03:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695895610; x=1696500410; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JOLCDbuRg5WAvArGgdnVXPEciKhPCkovAWJeDLxP5T0=;
        b=Ad+mMY4q3/dTW6qKr1K3CbkW+0IaU94Lgkh+kBSag9ihUAxGyHutKrj20uFZzkMCaU
         5mzqIYyEEICi8gXkCaLCEn/GBi9YJFNPoEjzJ/zcc3DlXR4IPMGpettDxQvUMgGj3nWL
         4fj/rgHjb1Vn3n0Wf43bS6YUWCj094Nb/CpOew2t++gL/bDxlM/z6wV+nxJ/2UPcMNpY
         dDiFqJWjvepj9IsKN4v00wWH0XiwYIqNXW7YJtE++vKl5JyeeP714DDPdQdHHe0WUVdG
         ELp0eCHApJk6m32goOf1j3J332wjyXbBg+rGvIzeP/EeOKMLa/eiC0/AsYRubNaK4M4b
         z5ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695895610; x=1696500410;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JOLCDbuRg5WAvArGgdnVXPEciKhPCkovAWJeDLxP5T0=;
        b=IWE1lL4pvT1WjL19m/3j4V8HwcKFzvUWzGvm7H2IRPESP/pYz4VESHHAuNlGwVX6yP
         mrExTj+1uK5GK7WNd3JI1/i63FZct2sPNVwfvPr60QvEsl34z5x/at0tNFtTvuLtgz/5
         /KzPCgFgwdKsuNEZZgcrLNpZvaqhN7YAdw8RMEZNKI55Q7x8R6uffk41vM1zjcrmfwIl
         Qre4izSbfHFGRamzV7yXAF7I4bSakl1b1KznKKF+qcU86bMPSKQKtqKCelM02lLI6M0A
         BHz96j6ITdA5D+2bakvzrWaCpmB3/a61trVyN4SfCpq6JD/TJeUDMcomipFhE3ZWV507
         CPew==
X-Gm-Message-State: AOJu0YyX4DrtZlfT+KkmrF6OY8TPHxbDVItlF1pRDrGfUnxYu++6VbCx
        XIGh1aHb/tR5XbKG78/NPyRgkNR0EcnSnQ==
X-Google-Smtp-Source: AGHT+IH2gUlVxLRrf6Rrd65xgA4UV3DNC/EmxkMzPW2TfP8DWpL9C4aw+kcv5q1ZskDKb/OppgUgCg==
X-Received: by 2002:a05:6a20:dd85:b0:14c:4deb:7120 with SMTP id kw5-20020a056a20dd8500b0014c4deb7120mr485155pzb.62.1695895609617;
        Thu, 28 Sep 2023 03:06:49 -0700 (PDT)
Received: from localhost.localdomain ([111.108.111.133])
        by smtp.gmail.com with ESMTPSA id z5-20020a1709027e8500b001c613b4aa33sm3166306pla.287.2023.09.28.03.06.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Sep 2023 03:06:49 -0700 (PDT)
From:   Wei Gong <gongwei833x@gmail.com>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, Wei Gong <gongwei833x@gmail.com>
Subject: [PATCH v3] genirq: avoid long loops in handle_edge_irq
Date:   Thu, 28 Sep 2023 18:06:38 +0800
Message-Id: <20230928100638.42116-1-gongwei833x@gmail.com>
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
 kernel/irq/chip.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index dc94e0bf2c94..a457490bd965 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -831,7 +831,9 @@ void handle_edge_irq(struct irq_desc *desc)
 		handle_irq_event(desc);
 
 	} while ((desc->istate & IRQS_PENDING) &&
-		 !irqd_irq_disabled(&desc->irq_data));
+		 !irqd_irq_disabled(&desc->irq_data) &&
+		 cpumask_test_cpu(smp_processor_id(),
+				   irq_data_get_effective_affinity_mask(&desc->irq_data)));
 
 out_unlock:
 	raw_spin_unlock(&desc->lock);
-- 
2.32.1 (Apple Git-133)

