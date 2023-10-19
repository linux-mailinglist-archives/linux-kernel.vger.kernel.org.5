Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A2237CF20B
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 10:09:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235146AbjJSIJZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 04:09:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232976AbjJSIJY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 04:09:24 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5A6812E
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 01:09:22 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id d75a77b69052e-41995d42c3bso46188671cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 01:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697702962; x=1698307762; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=g17DNvDuwsvkatPfQSbF1sKHfBdyAlQw+IX3K/EwR5U=;
        b=PK/5iYDhgaAWconkr7GJg/THsBsGSORleaGjiqPczpqNfdxAQrchBLsjXo27kINYCQ
         NUFWvt1Ft2TFPENu5OPDbaU+CyE1e6NkrPYXxPk8uWANeeKWMFvMZ981RYF4ACEflVo8
         M29sQF/8M4TixCudldiS5o1E3sD2ae/yG6OqMT9olwtIjSnTriBXfRsIgQbuY/UDCyEJ
         ZM5e/mkn+6sZxjhohXeqFwaQxZfki+a+TcFRbkDF8rSY+5XMB54tZbXRFCzhJGssgcWJ
         Gy+lABOl13ak5JGw6R6ykKhLz7rMSGUAurKXWiRQQHwiKAKka5m+rbdIKd8m1bogEqZ7
         tuOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697702962; x=1698307762;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g17DNvDuwsvkatPfQSbF1sKHfBdyAlQw+IX3K/EwR5U=;
        b=ZP1F//0Q7ZZ8zLn82uIoqE+wEtXYOWlbtsC3oRED7tkYmdBbHS4veSpVVsxt8fsxWb
         expXAI1nPheKBh09XQgmRSNNLKf8LSDokc/5mj5vYgL4SJjwTSGabPBxni5In/6eZEUl
         oTodTId68OrIP5hlOLCoUVjaqideuqWnsHLQycR+o2lZ/gwyeizImJUuvVmfTtYhokdf
         Muul1mtujuLTKltMWpcclsVb/8S+uuv2InwC2Awug51d3o6T9RKGmcyAuCPscIfCdbu8
         YZwd0qxCokWP+4QUBAD+s9Sdtj+l9+f38cLoxAEPtB9CbpupYFfYO02p0xmwT5fsdTmH
         RtNQ==
X-Gm-Message-State: AOJu0YwJksqBYKiTBGzHt/0dZ7VY5+MMOv62kFdJArGVfD3Yv6FljRJT
        9kI3paFE0nfHgUIcoJhAb9tr
X-Google-Smtp-Source: AGHT+IFVAMwbWArjNUqTZoAOuQleXKPUfyMwsHgWl3UXcVvb1tGg/tO0sR0kKy3KACX/kIEkab+49w==
X-Received: by 2002:a05:622a:83:b0:41b:8416:ea2a with SMTP id o3-20020a05622a008300b0041b8416ea2amr1895589qtw.40.1697702961759;
        Thu, 19 Oct 2023 01:09:21 -0700 (PDT)
Received: from localhost.localdomain ([117.202.186.25])
        by smtp.gmail.com with ESMTPSA id bq15-20020a05622a1c0f00b0041520676966sm573553qtb.47.2023.10.19.01.09.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 01:09:21 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     mhi@lists.linux.dev
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH] bus: mhi: ep: Add support for interrupt moderation timer
Date:   Thu, 19 Oct 2023 13:39:11 +0530
Message-Id: <20231019080911.57938-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MHI spec defines the interrupt moderation timer feature using which the
host can limit the number of interrupts being raised for an event ring by
the device. This feature allows the host to process multiple event ring
elements by a single IRQ from the device, thereby eliminating the need to
process IRQ for each element.

The INTMODT field in the event context array provides the value to be used
for delaying the IRQ generation from device. This value, along with the
Block Event Interrupt (BEI) flag of the TRE defines how IRQ is generated to
the host.

Support for interrupt moderation timer is implemented using delayed
workqueue in kernel. And a separate delayed work item is used for each
event ring.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/bus/mhi/ep/internal.h |  3 +++
 drivers/bus/mhi/ep/main.c     | 22 +++++++++++++++++++---
 drivers/bus/mhi/ep/ring.c     | 19 ++++++++++++++++++-
 3 files changed, 40 insertions(+), 4 deletions(-)

diff --git a/drivers/bus/mhi/ep/internal.h b/drivers/bus/mhi/ep/internal.h
index a2125fa5fe2f..8c5cf2b67951 100644
--- a/drivers/bus/mhi/ep/internal.h
+++ b/drivers/bus/mhi/ep/internal.h
@@ -126,6 +126,7 @@ struct mhi_ep_ring {
 	union mhi_ep_ring_ctx *ring_ctx;
 	struct mhi_ring_element *ring_cache;
 	enum mhi_ep_ring_type type;
+	struct delayed_work intmodt_work;
 	u64 rbase;
 	size_t rd_offset;
 	size_t wr_offset;
@@ -135,7 +136,9 @@ struct mhi_ep_ring {
 	u32 ch_id;
 	u32 er_index;
 	u32 irq_vector;
+	u32 intmodt;
 	bool started;
+	bool irq_pending;
 };
 
 struct mhi_ep_cmd {
diff --git a/drivers/bus/mhi/ep/main.c b/drivers/bus/mhi/ep/main.c
index 834e7afadd64..78559a995b25 100644
--- a/drivers/bus/mhi/ep/main.c
+++ b/drivers/bus/mhi/ep/main.c
@@ -54,11 +54,27 @@ static int mhi_ep_send_event(struct mhi_ep_cntrl *mhi_cntrl, u32 ring_idx,
 	mutex_unlock(&mhi_cntrl->event_lock);
 
 	/*
-	 * Raise IRQ to host only if the BEI flag is not set in TRE. Host might
-	 * set this flag for interrupt moderation as per MHI protocol.
+	 * As per the MHI specification, section 4.3, Interrupt moderation:
+	 *
+	 * 1. If BEI flag is not set, cancel any pending intmodt work if started
+	 * for the event ring and raise IRQ immediately.
+	 *
+	 * 2. If both BEI and intmodt are set, and if no IRQ is pending for the
+	 * same event ring, start the IRQ delayed work as per the value of
+	 * intmodt. If previous IRQ is pending, then do nothing as the pending
+	 * IRQ is enough for the host to process the current event ring element.
+	 *
+	 * 3. If BEI is set and intmodt is not set, no need to raise IRQ.
 	 */
-	if (!bei)
+	if (!bei) {
+		if (READ_ONCE(ring->irq_pending))
+			cancel_delayed_work(&ring->intmod_work);
+
 		mhi_cntrl->raise_irq(mhi_cntrl, ring->irq_vector);
+	} else if (ring->intmodt && !READ_ONCE(ring->irq_pending)) {
+		WRITE_ONCE(ring->irq_pending, true);
+		schedule_delayed_work(&ring->intmod_work, msecs_to_jiffies(ring->intmodt));
+	}
 
 	return 0;
 
diff --git a/drivers/bus/mhi/ep/ring.c b/drivers/bus/mhi/ep/ring.c
index 115518ec76a4..a1071c13761b 100644
--- a/drivers/bus/mhi/ep/ring.c
+++ b/drivers/bus/mhi/ep/ring.c
@@ -157,6 +157,15 @@ void mhi_ep_ring_init(struct mhi_ep_ring *ring, enum mhi_ep_ring_type type, u32
 	}
 }
 
+static void mhi_ep_raise_irq(struct work_struct *work)
+{
+	struct mhi_ep_ring *ring = container_of(work, struct mhi_ep_ring, intmodt_work.work);
+	struct mhi_ep_cntrl *mhi_cntrl = ring->mhi_cntrl;
+
+	mhi_cntrl->raise_irq(mhi_cntrl, ring->irq_vector);
+	WRITE_ONCE(ring->irq_pending, false);
+}
+
 int mhi_ep_ring_start(struct mhi_ep_cntrl *mhi_cntrl, struct mhi_ep_ring *ring,
 			union mhi_ep_ring_ctx *ctx)
 {
@@ -173,8 +182,13 @@ int mhi_ep_ring_start(struct mhi_ep_cntrl *mhi_cntrl, struct mhi_ep_ring *ring,
 	if (ring->type == RING_TYPE_CH)
 		ring->er_index = le32_to_cpu(ring->ring_ctx->ch.erindex);
 
-	if (ring->type == RING_TYPE_ER)
+	if (ring->type == RING_TYPE_ER) {
 		ring->irq_vector = le32_to_cpu(ring->ring_ctx->ev.msivec);
+		ring->intmodt = FIELD_GET(EV_CTX_INTMODT_MASK,
+					  le32_to_cpu(ring->ring_ctx->ev.intmod));
+
+		INIT_DELAYED_WORK(&ring->intmodt_work, mhi_ep_raise_irq);
+	}
 
 	/* During ring init, both rp and wp are equal */
 	memcpy_fromio(&val, (void __iomem *) &ring->ring_ctx->generic.rp, sizeof(u64));
@@ -201,6 +215,9 @@ int mhi_ep_ring_start(struct mhi_ep_cntrl *mhi_cntrl, struct mhi_ep_ring *ring,
 
 void mhi_ep_ring_reset(struct mhi_ep_cntrl *mhi_cntrl, struct mhi_ep_ring *ring)
 {
+	if (ring->type == RING_TYPE_ER)
+		cancel_delayed_work_sync(&ring->intmodt_work);
+
 	ring->started = false;
 	kfree(ring->ring_cache);
 	ring->ring_cache = NULL;
-- 
2.25.1

