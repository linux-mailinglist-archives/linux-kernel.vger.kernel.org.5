Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4319E7D9C5A
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 16:56:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346194AbjJ0O4u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 10:56:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346154AbjJ0O4r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 10:56:47 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B805F1AA
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 07:56:44 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-40859c46447so15016735e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 07:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1698418603; x=1699023403; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8+oZn/+DkTur35XEXsmv1gHmKoky7ZxYfFrzG6EGHGk=;
        b=gbYLlXKpRCGjODQzP4YzuHK09B1pA/Jrn5TI7afazVr/imuRWtOUEZGAPF3tee9GWO
         42RF9W0mzB+FfQv+3+jKQorKFM1hwfmNdvA2xPLjXcLpl0IzgtpPt3FB7F2299v0tC4R
         wgjFvOnCKSBKCRSBINLr84w31LDQxzvqNCN10=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698418603; x=1699023403;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8+oZn/+DkTur35XEXsmv1gHmKoky7ZxYfFrzG6EGHGk=;
        b=sPsBrauKV9BQBRNdHljBFvmkAdfdussdM6hKjEEkA31ZMf8pcxUWyxCdMIHvReDEbz
         F3QabbeXC1k1OMqZZ+NrghN8FdHKMjyd8Q0syardqfDT2Zs9NQ65nY9JzyTFx4qot0Th
         okgNrE74Dqzrj/XljH+jJrBVPQmVcgSLeP2bSlWNa+zz4YGQIVHSSzymiuciZ144wfJJ
         dIgHzDM8wR9kt3F9KtJnzmbaAPV1BUK3bC2scV581OFA5a6AAntO+ImFZn6YobPABOLr
         QNjGQCK8LdN1N2WCuNF3yLjaIr2hXQhA/CH+8UuDrB8VMHSKZUQ52xH5TupXYWShuVZ8
         AVfA==
X-Gm-Message-State: AOJu0YwbtqvZ+RDAgEOmAG238EGEu0XiDNXEBNlHd/gXI+Ox2hYTktuT
        7HymcNNhqENuyNrw8RvvdU2/jGs1VXqoGSfk1EOv4Ctw
X-Google-Smtp-Source: AGHT+IECsVO3jFxbTWKboFDTojUECsrTdHwn5QugbirauXdqNDmmTQkiapVQ8yuZAwhD3h1lWz23Vg==
X-Received: by 2002:a05:600c:1f8c:b0:405:92f9:b090 with SMTP id je12-20020a05600c1f8c00b0040592f9b090mr2592120wmb.14.1698418602813;
        Fri, 27 Oct 2023 07:56:42 -0700 (PDT)
Received: from orzel1.c.googlers.com.com (110.121.148.146.bc.googleusercontent.com. [146.148.121.110])
        by smtp.gmail.com with ESMTPSA id p8-20020a05600c358800b0040472ad9a3dsm1815368wmq.14.2023.10.27.07.56.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Oct 2023 07:56:42 -0700 (PDT)
From:   =?UTF-8?q?Kornel=20Dul=C4=99ba?= <korneld@chromium.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Radoslaw Biernacki <biernacki@google.com>,
        Gwendal Grignou <gwendal@chromium.org>,
        =?UTF-8?q?Kornel=20Dul=C4=99ba?= <korneld@chromium.org>
Subject: [PATCH 1/2] mmc: cqhci: Add a quirk to clear stale TC
Date:   Fri, 27 Oct 2023 14:56:09 +0000
Message-ID: <20231027145623.2258723-2-korneld@chromium.org>
X-Mailer: git-send-email 2.42.0.820.g83a721a137-goog
In-Reply-To: <20231027145623.2258723-1-korneld@chromium.org>
References: <20231027145623.2258723-1-korneld@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fix addresses a stale task completion event issued right after the
CQE recovery. As it's a hardware issue the fix is done in form of a
quirk.

When error interrupt is received the driver runs recovery logic is run.
It halts the controller, clears all pending tasks, and then re-enables
it. On some platforms a stale task completion event is observed,
regardless of the CQHCI_CLEAR_ALL_TASKS bit being set.

This results in either:
a) Spurious TC completion event for an empty slot.
b) Corrupted data being passed up the stack, as a result of premature
   completion for a newly added task.

To fix that re-enable the controller, clear task completion bits,
interrupt status register and halt it again.
This is done at the end of the recovery process, right before interrupts
are re-enabled.

Signed-off-by: Kornel Dulęba <korneld@chromium.org>
---
 drivers/mmc/host/cqhci-core.c | 42 +++++++++++++++++++++++++++++++++++
 drivers/mmc/host/cqhci.h      |  1 +
 2 files changed, 43 insertions(+)

diff --git a/drivers/mmc/host/cqhci-core.c b/drivers/mmc/host/cqhci-core.c
index b3d7d6d8d654..e534222df90c 100644
--- a/drivers/mmc/host/cqhci-core.c
+++ b/drivers/mmc/host/cqhci-core.c
@@ -1062,6 +1062,45 @@ static void cqhci_recover_mrqs(struct cqhci_host *cq_host)
 /* CQHCI could be expected to clear it's internal state pretty quickly */
 #define CQHCI_CLEAR_TIMEOUT		20
 
+/*
+ * During CQE recovery all pending tasks are cleared from the
+ * controller and its state is being reset.
+ * On some platforms the controller sets a task completion bit for
+ * a stale(previously cleared) task right after being re-enabled.
+ * This results in a spurious interrupt at best and corrupted data
+ * being passed up the stack at worst. The latter happens when
+ * the driver enqueues a new request on the problematic task slot
+ * before the "spurious" task completion interrupt is handled.
+ * To fix it:
+ * 1. Re-enable controller by clearing the halt flag.
+ * 2. Clear interrupt status and the task completion register.
+ * 3. Halt the controller again to be consistent with quirkless logic.
+ *
+ * This assumes that there are no pending requests on the queue.
+ */
+static void cqhci_quirk_clear_stale_tc(struct cqhci_host *cq_host)
+{
+	u32 reg;
+
+	WARN_ON(cq_host->qcnt);
+	cqhci_writel(cq_host, 0, CQHCI_CTL);
+	if ((cqhci_readl(cq_host, CQHCI_CTL) & CQHCI_HALT)) {
+		pr_err("%s: cqhci: CQE failed to exit halt state\n",
+			mmc_hostname(cq_host->mmc));
+	}
+	reg = cqhci_readl(cq_host, CQHCI_TCN);
+	cqhci_writel(cq_host, reg, CQHCI_TCN);
+	reg = cqhci_readl(cq_host, CQHCI_IS);
+	cqhci_writel(cq_host, reg, CQHCI_IS);
+
+	/*
+	 * Halt the controller again.
+	 * This is only needed so that we're consistent across quirk
+	 * and quirkless logic.
+	 */
+	cqhci_halt(cq_host->mmc, CQHCI_FINISH_HALT_TIMEOUT);
+}
+
 static void cqhci_recovery_finish(struct mmc_host *mmc)
 {
 	struct cqhci_host *cq_host = mmc->cqe_private;
@@ -1108,6 +1147,9 @@ static void cqhci_recovery_finish(struct mmc_host *mmc)
 	mmc->cqe_on = false;
 	spin_unlock_irqrestore(&cq_host->lock, flags);
 
+	if (cq_host->quirks & CQHCI_QUIRK_CLEAR_STALE_TC)
+		cqhci_quirk_clear_stale_tc(cq_host);
+
 	/* Ensure all writes are done before interrupts are re-enabled */
 	wmb();
 
diff --git a/drivers/mmc/host/cqhci.h b/drivers/mmc/host/cqhci.h
index 1a12e40a02e6..36131038c091 100644
--- a/drivers/mmc/host/cqhci.h
+++ b/drivers/mmc/host/cqhci.h
@@ -239,6 +239,7 @@ struct cqhci_host {
 
 	u32 quirks;
 #define CQHCI_QUIRK_SHORT_TXFR_DESC_SZ	0x1
+#define CQHCI_QUIRK_CLEAR_STALE_TC	0x2
 
 	bool enabled;
 	bool halted;
-- 
2.42.0.820.g83a721a137-goog

