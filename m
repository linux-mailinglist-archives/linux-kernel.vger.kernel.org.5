Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0FD57F0ED2
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 10:17:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232526AbjKTJR6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 04:17:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232426AbjKTJR4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 04:17:56 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78FE0B8;
        Mon, 20 Nov 2023 01:17:53 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-6c4eb5fda3cso4292609b3a.2;
        Mon, 20 Nov 2023 01:17:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700471873; x=1701076673; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tdiBbtmZINpiK2wrkr8560HBNxLICLlfhPzVnTah2sg=;
        b=QAAs3+/buGiV2OByeKXZ0V808JyCUsftJJxgaVw0ZkGww/RaoMdaNtzbJW3MxSFSFb
         bGutLP1WLP/5oAtIc7kFD3HqWswTHMX045VYO4HIqPoO50ir1Uq1eXBqf4V6XJwh9QmZ
         +MZWwcWWnD7P4VGa/z+82PcAPs32hQPECYXI/V8CJnGENjVjDcAVRC58vaRqq8CpooSn
         36O5KuA4luU6aj8zFA/IwsyObHB+56TuEoxVPsGkUZc6jX1M2+EfKDnRV9t3FyJBsGyp
         nzPz/RhgpzDTvG+teo7TvOIeIG3u7NhSzDpGpvVYF7/uF824xasKkI+CtsWitbb/XFqN
         mHAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700471873; x=1701076673;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tdiBbtmZINpiK2wrkr8560HBNxLICLlfhPzVnTah2sg=;
        b=i8UKolgOIoDYUAiamlbcrLVsty2ykMJPwh+BkUUvqSz+uyB0w+LFvM5H+VRsw6vIRk
         455v3z2Rzroy4ci8l+b6v4Sn1I2NF35z8jBP5x+3OkV0YgX4J9YqPFTkBREV2V4lt2f6
         nwMLdPRmkGKh267+Md1eji/8O2ZJ3ovn9xcaP+hcfLkU0X685ltBE4BMIptMMRqoDZRu
         69YmCvnw2LTdw19vb1Uu3ccId6wdUL0jOr20rshdNulT5n/uOiN6R00ihCvWc1VqOed3
         GaYkNXGaLX5woBOWdjN7tO75hP5bvbl0EmikdEztbM0GT0VdeHQx4K7QTYPaUkMyRJt+
         qESQ==
X-Gm-Message-State: AOJu0YwLR09NWlYB9wttzqhD03Viku54H8cLvC0K5xf0YuCvjdpJeyQW
        u7BzlaOEPa0qVVyn0vuoXH8=
X-Google-Smtp-Source: AGHT+IEp+cuTi7iFRTT+hATic2jTuRdHoJOGZ8nbXlJYs561PX9JAj/1CEyo7iX6uiwbF8PlbiVoTA==
X-Received: by 2002:a05:6a20:4429:b0:188:75c:e69a with SMTP id ce41-20020a056a20442900b00188075ce69amr10006442pzb.4.1700471872866;
        Mon, 20 Nov 2023 01:17:52 -0800 (PST)
Received: from cosmo-ubuntu-2204.dhcpserver.bu9bmc.local (1-34-21-66.hinet-ip.hinet.net. [1.34.21.66])
        by smtp.gmail.com with ESMTPSA id j12-20020a056a00130c00b0068fece22469sm5582116pfu.4.2023.11.20.01.17.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 01:17:52 -0800 (PST)
From:   Cosmo Chou <chou.cosmo@gmail.com>
To:     brendan.higgins@linux.dev, benh@kernel.crashing.org,
        joel@jms.id.au, andi.shyti@kernel.org, andrew@codeconstruct.com.au,
        linux@roeck-us.net, wsa@kernel.org, jae.hyun.yoo@linux.intel.com
Cc:     linux-i2c@vger.kernel.org, openbmc@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        chou.cosmo@gmail.com, cosmo.chou@quantatw.com
Subject: [PATCH] i2c: aspeed: Acknowledge Tx ack late when in SLAVE_READ_PROCESSED
Date:   Mon, 20 Nov 2023 17:17:46 +0800
Message-Id: <20231120091746.2866232-1-chou.cosmo@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 2be6b47211e1 ("i2c: aspeed: Acknowledge most interrupts early
in interrupt handler") moved most interrupt acknowledgments to the
start of the interrupt handler to avoid race conditions. However,
slave Tx ack status shouldn't be cleared before SLAVE_READ_PROCESSED
is handled.

Acknowledge Tx ack status after handling SLAVE_READ_PROCESSED to fix
the problem that the next byte is not sent correctly.

Fixes: 2be6b47211e1 ("i2c: aspeed: Acknowledge most interrupts early in interrupt handler")
Signed-off-by: Cosmo Chou <chou.cosmo@gmail.com>
---
 drivers/i2c/busses/i2c-aspeed.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-aspeed.c b/drivers/i2c/busses/i2c-aspeed.c
index 28e2a5fc4528..c2d74e4b7e50 100644
--- a/drivers/i2c/busses/i2c-aspeed.c
+++ b/drivers/i2c/busses/i2c-aspeed.c
@@ -337,6 +337,12 @@ static u32 aspeed_i2c_slave_irq(struct aspeed_i2c_bus *bus, u32 irq_status)
 		break;
 	}
 
+	/* Ack Tx ack */
+	if (irq_handled & ASPEED_I2CD_INTR_TX_ACK) {
+		writel(ASPEED_I2CD_INTR_TX_ACK, bus->base + ASPEED_I2C_INTR_STS_REG);
+		readl(bus->base + ASPEED_I2C_INTR_STS_REG);
+	}
+
 	return irq_handled;
 }
 #endif /* CONFIG_I2C_SLAVE */
@@ -602,13 +608,18 @@ static u32 aspeed_i2c_master_irq(struct aspeed_i2c_bus *bus, u32 irq_status)
 static irqreturn_t aspeed_i2c_bus_irq(int irq, void *dev_id)
 {
 	struct aspeed_i2c_bus *bus = dev_id;
-	u32 irq_received, irq_remaining, irq_handled;
+	u32 irq_received, irq_remaining, irq_handled, irq_acked;
 
 	spin_lock(&bus->lock);
 	irq_received = readl(bus->base + ASPEED_I2C_INTR_STS_REG);
 	/* Ack all interrupts except for Rx done */
-	writel(irq_received & ~ASPEED_I2CD_INTR_RX_DONE,
-	       bus->base + ASPEED_I2C_INTR_STS_REG);
+	irq_acked = irq_received & ~ASPEED_I2CD_INTR_RX_DONE;
+#if IS_ENABLED(CONFIG_I2C_SLAVE)
+	/* shouldn't ack Slave Tx Ack before it's handled */
+	if (bus->slave_state == ASPEED_I2C_SLAVE_READ_PROCESSED)
+		irq_acked &= ~ASPEED_I2CD_INTR_TX_ACK;
+#endif
+	writel(irq_acked, bus->base + ASPEED_I2C_INTR_STS_REG);
 	readl(bus->base + ASPEED_I2C_INTR_STS_REG);
 	irq_received &= ASPEED_I2CD_INTR_RECV_MASK;
 	irq_remaining = irq_received;
-- 
2.34.1

