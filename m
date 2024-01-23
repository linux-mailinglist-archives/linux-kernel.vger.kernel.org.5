Return-Path: <linux-kernel+bounces-34787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD28F838775
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 07:33:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1DA2BB2479B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 06:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5B9058233;
	Tue, 23 Jan 2024 06:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GHSZvihP"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C17C15820E;
	Tue, 23 Jan 2024 06:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705991379; cv=none; b=I3hkAj2ldRTXT/OflaivMe0FZE9g2oI9HmZy2SHCt9vKH9RLYoR37O6GZHKfK9EXMTVZIGPpqZk1d3x6Z3etjd4nQa2Qm6/jmHv+lDzQJ2aeSz7IYfylXXpmvfiW+8M4jIMBufjGC5VftD9D08jeDqha4ub6iol2gybw77qUjzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705991379; c=relaxed/simple;
	bh=uz8FWmgFDWjvKrI3l9sPkyApF9fIhwWVfhb7VTDUjoQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bwkumNUOTCuJcrjhMpZeQKpOMa19uM7Lq40iPUHCqfBqjg14VAIZ+I5JsjBBqPLEoCbGp9Fsnztsu1j16FOGUt8BiN7uLw4NMOMrnTaL20uLO6ABXlAf7LzgvTZDB79PF4tme3UO8qiwskXOAerzq5OOtPLosJqsdIS41SFxp1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GHSZvihP; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6dbe5014eb5so975870b3a.0;
        Mon, 22 Jan 2024 22:29:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705991377; x=1706596177; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZoHKs7VxKps74j9oN7TAjTtWSS7AskQbfRgB27Vaj4g=;
        b=GHSZvihPUnjBXxjc/sUo+gLHMb9gMNkmdDu+mD3OPiPVRXURsG5JYdOqQZApE/OlJ8
         j0CeFWIFpGWuqgVmsPp+tXYxAZ/EfZLuvlnAf7llEZCTtFiBqwGTETsJtlYc66zmpt1f
         mf7OTJ3j2hGm9hjWaximQ/wUD31NxJS8Yh6UJ2W575cWvMSVsU1L413ERXUC49YQB+YZ
         U+sKJ/qrjCgq28POTul76zoEaautD9GBlQCyHLq6zPD0qrSpTIgioc2TS4C9jNJ9J0U0
         lmsNwqCDgk7fUN3lSyTP7bIh1K2Ev68ShzECF6sCDp8agobAe9j0fpIWAr2mkdomdqA+
         iHSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705991377; x=1706596177;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZoHKs7VxKps74j9oN7TAjTtWSS7AskQbfRgB27Vaj4g=;
        b=l8lS8tI8NmfUyIWPE4jzZQL/sj8epM8VnpUZLCOaRO3hkbtMpHmJBfPpHUdLGrM2Ty
         y0PFXMd7XhTZSdjA+/lDwH/SI7UcLrkCR3fB20woWBI/LUl3xriz0W5sBHyTBr1QG0XE
         Dl2+8K53/lbJ61kLEH+f8rfxrBBUOuTS0YPPFA8XX1vZ5ksJSCBgetZeBeKAyW4g7i6a
         7vGvlGh/TRLykO00tLLLbmrUnsMFmFJ6CIDiBWBNIN04BYx/B8uW8CjLolFMAZWHyYxn
         LiyWZAyoxFSJm5A6hCGN38NTAkOr5XXRL/HvWbSP4p5oOWqWy8UmgPi1VJOvzZZ+IDpq
         CvTg==
X-Gm-Message-State: AOJu0YzwTcixBx7FOAB30a6xlQWF+IfYtOuN3+yFe1xzRvkbaVYrA5aF
	UIfqawLSg3TBVtpfjUOmrZLLkUNo2iTxUkePG2KjcQjLrdaqWDNV
X-Google-Smtp-Source: AGHT+IGrKcTxIDOlCUSyiJbehWQCcM7RmRbluC7H8zra/AcqKXpCtNfzo+9STO2ljlCADDRe07Ml3A==
X-Received: by 2002:a05:6a00:802:b0:6db:e4b5:1e7d with SMTP id m2-20020a056a00080200b006dbe4b51e7dmr2127376pfk.41.1705991376548;
        Mon, 22 Jan 2024 22:29:36 -0800 (PST)
Received: from localhost.localdomain (2001-b400-e2ac-a4c6-7d2b-d8b3-ed27-1f50.emome-ip6.hinet.net. [2001:b400:e2ac:a4c6:7d2b:d8b3:ed27:1f50])
        by smtp.gmail.com with ESMTPSA id l10-20020a056a00140a00b006d9b2694b0csm10595188pfu.200.2024.01.22.22.29.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 22:29:36 -0800 (PST)
From: Victor Shih <victorshihgli@gmail.com>
To: ulf.hansson@linaro.org,
	adrian.hunter@intel.com
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	benchuanggli@gmail.com,
	HL.Liu@genesyslogic.com.tw,
	Greg.tu@genesyslogic.com.tw,
	takahiro.akashi@linaro.org,
	dlunev@chromium.org,
	Victor Shih <victorshihgli@gmail.com>,
	Ben Chuang <ben.chuang@genesyslogic.com.tw>,
	Victor Shih <victor.shih@genesyslogic.com.tw>
Subject: [PATCH V14 17/21] mmc: sdhci-uhs2: add irq() and others
Date: Tue, 23 Jan 2024 14:28:23 +0800
Message-Id: <20240123062827.8525-18-victorshihgli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240123062827.8525-1-victorshihgli@gmail.com>
References: <20240123062827.8525-1-victorshihgli@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Victor Shih <victor.shih@genesyslogic.com.tw>

This is a UHS-II version of sdhci's request() operation.
It handles UHS-II related command interrupts and errors.

Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
---

Updates in V14:
 - Use mmc_card_uhs2() to stead sdhci_uhs2_mode() in the
   sdhci_uhs2_complete_work(), sdhci_uhs2_irq() and
   sdhci_uhs2_thread_irq().

Updates in V13:
 - Re-order function to avoid declaration.
 - Remove unnecessary definitions.

Updates in V9:
 - Cancel export state of sdhci_set_mrq_done() function.

Updates in V8:
 - Forward declare struct mmc_request in sdhci_uhs2.h.
 - Remove forward declaration of sdhci_send_command().
 - Use mmc_dev() to simplify code in sdhci_request_done_dma().

Updates in V7:
 - Remove unnecessary functions.
 - Use sdhci_uhs2_mode() to simplify code in sdhci_uhs2_irq().
 - Modify descriptions in sdhci_uhs2_irq().
 - Cancel export state of some functions.

Updates in V6:
 - Remove unnecessary functions.
 - Add sdhci_uhs2_mode() in sdhci_uhs2_complete_work().
 - Add sdhci_uhs2_mode() in sdhci_uhs2_thread_irq().

---

 drivers/mmc/host/sdhci-uhs2.c | 215 ++++++++++++++++++++++++++++++++++
 drivers/mmc/host/sdhci-uhs2.h |   2 +
 drivers/mmc/host/sdhci.c      |  99 +++++++++-------
 drivers/mmc/host/sdhci.h      |   4 +
 4 files changed, 275 insertions(+), 45 deletions(-)

diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
index b47bcf6f890f..b083a80f37cc 100644
--- a/drivers/mmc/host/sdhci-uhs2.c
+++ b/drivers/mmc/host/sdhci-uhs2.c
@@ -903,6 +903,221 @@ static void sdhci_uhs2_request(struct mmc_host *mmc, struct mmc_request *mrq)
 	spin_unlock_irqrestore(&host->lock, flags);
 }
 
+/*****************************************************************************\
+ *                                                                           *
+ * Request done                                                              *
+ *                                                                           *
+\*****************************************************************************/
+
+static bool sdhci_uhs2_request_done(struct sdhci_host *host)
+{
+	unsigned long flags;
+	struct mmc_request *mrq;
+	int i;
+
+	spin_lock_irqsave(&host->lock, flags);
+
+	for (i = 0; i < SDHCI_MAX_MRQS; i++) {
+		mrq = host->mrqs_done[i];
+		if (mrq)
+			break;
+	}
+
+	if (!mrq) {
+		spin_unlock_irqrestore(&host->lock, flags);
+		return true;
+	}
+
+	/*
+	 * Always unmap the data buffers if they were mapped by
+	 * sdhci_prepare_data() whenever we finish with a request.
+	 * This avoids leaking DMA mappings on error.
+	 */
+	if (host->flags & SDHCI_REQ_USE_DMA)
+		sdhci_request_done_dma(host, mrq);
+
+	/*
+	 * The controller needs a reset of internal state machines
+	 * upon error conditions.
+	 */
+	if (sdhci_needs_reset(host, mrq)) {
+		/*
+		 * Do not finish until command and data lines are available for
+		 * reset. Note there can only be one other mrq, so it cannot
+		 * also be in mrqs_done, otherwise host->cmd and host->data_cmd
+		 * would both be null.
+		 */
+		if (host->cmd || host->data_cmd) {
+			spin_unlock_irqrestore(&host->lock, flags);
+			return true;
+		}
+
+		sdhci_uhs2_reset(host, SDHCI_UHS2_SW_RESET_SD);
+		host->pending_reset = false;
+	}
+
+	host->mrqs_done[i] = NULL;
+
+	spin_unlock_irqrestore(&host->lock, flags);
+
+	if (host->ops->request_done)
+		host->ops->request_done(host, mrq);
+	else
+		mmc_request_done(host->mmc, mrq);
+
+	return false;
+}
+
+static void sdhci_uhs2_complete_work(struct work_struct *work)
+{
+	struct sdhci_host *host = container_of(work, struct sdhci_host,
+					       complete_work);
+
+	if (!mmc_card_uhs2(host->mmc)) {
+		sdhci_complete_work(work);
+		return;
+	}
+
+	while (!sdhci_uhs2_request_done(host))
+		;
+}
+
+/*****************************************************************************\
+ *                                                                           *
+ * Interrupt handling                                                        *
+ *                                                                           *
+\*****************************************************************************/
+
+static void __sdhci_uhs2_irq(struct sdhci_host *host, u32 uhs2mask)
+{
+	struct mmc_command *cmd = host->cmd;
+
+	DBG("*** %s got UHS2 error interrupt: 0x%08x\n",
+	    mmc_hostname(host->mmc), uhs2mask);
+
+	if (uhs2mask & SDHCI_UHS2_INT_CMD_ERR_MASK) {
+		if (!host->cmd) {
+			pr_err("%s: Got cmd interrupt 0x%08x but no cmd.\n",
+			       mmc_hostname(host->mmc),
+			       (unsigned int)uhs2mask);
+			sdhci_dumpregs(host);
+			return;
+		}
+		host->cmd->error = -EILSEQ;
+		if (uhs2mask & SDHCI_UHS2_INT_CMD_TIMEOUT)
+			host->cmd->error = -ETIMEDOUT;
+	}
+
+	if (uhs2mask & SDHCI_UHS2_INT_DATA_ERR_MASK) {
+		if (!host->data) {
+			pr_err("%s: Got data interrupt 0x%08x but no data.\n",
+			       mmc_hostname(host->mmc),
+			       (unsigned int)uhs2mask);
+			sdhci_dumpregs(host);
+			return;
+		}
+
+		if (uhs2mask & SDHCI_UHS2_INT_DEADLOCK_TIMEOUT) {
+			pr_err("%s: Got deadlock timeout interrupt 0x%08x\n",
+			       mmc_hostname(host->mmc),
+			       (unsigned int)uhs2mask);
+			host->data->error = -ETIMEDOUT;
+		} else if (uhs2mask & SDHCI_UHS2_INT_ADMA_ERROR) {
+			pr_err("%s: ADMA error = 0x %x\n",
+			       mmc_hostname(host->mmc),
+			       sdhci_readb(host, SDHCI_ADMA_ERROR));
+			host->data->error = -EIO;
+		} else {
+			host->data->error = -EILSEQ;
+		}
+	}
+
+	if (host->data && host->data->error)
+		sdhci_uhs2_finish_data(host);
+	else
+		sdhci_finish_mrq(host, cmd->mrq);
+}
+
+u32 sdhci_uhs2_irq(struct sdhci_host *host, u32 intmask)
+{
+	u32 mask = intmask, uhs2mask;
+
+	if (!mmc_card_uhs2(host->mmc))
+		goto out;
+
+	if (intmask & SDHCI_INT_ERROR) {
+		uhs2mask = sdhci_readl(host, SDHCI_UHS2_INT_STATUS);
+		if (!(uhs2mask & SDHCI_UHS2_INT_ERROR_MASK))
+			goto cmd_irq;
+
+		/* Clear error interrupts */
+		sdhci_writel(host, uhs2mask & SDHCI_UHS2_INT_ERROR_MASK,
+			     SDHCI_UHS2_INT_STATUS);
+
+		/* Handle error interrupts */
+		__sdhci_uhs2_irq(host, uhs2mask);
+
+		/* Caller, sdhci_irq(), doesn't have to care about UHS-2 errors */
+		intmask &= ~SDHCI_INT_ERROR;
+		mask &= SDHCI_INT_ERROR;
+	}
+
+cmd_irq:
+	if (intmask & SDHCI_INT_CMD_MASK) {
+		/* Clear command interrupt */
+		sdhci_writel(host, intmask & SDHCI_INT_CMD_MASK, SDHCI_INT_STATUS);
+
+		/* Handle command interrupt */
+		if (intmask & SDHCI_INT_RESPONSE)
+			sdhci_uhs2_finish_command(host);
+
+		/* Caller, sdhci_irq(), doesn't have to care about UHS-2 commands */
+		intmask &= ~SDHCI_INT_CMD_MASK;
+		mask &= SDHCI_INT_CMD_MASK;
+	}
+
+	/* Clear already-handled interrupts. */
+	sdhci_writel(host, mask, SDHCI_INT_STATUS);
+
+out:
+	return intmask;
+}
+EXPORT_SYMBOL_GPL(sdhci_uhs2_irq);
+
+static irqreturn_t sdhci_uhs2_thread_irq(int irq, void *dev_id)
+{
+	struct sdhci_host *host = dev_id;
+	struct mmc_command *cmd;
+	unsigned long flags;
+	u32 isr;
+
+	if (!mmc_card_uhs2(host->mmc))
+		return sdhci_thread_irq(irq, dev_id);
+
+	while (!sdhci_uhs2_request_done(host))
+		;
+
+	spin_lock_irqsave(&host->lock, flags);
+
+	isr = host->thread_isr;
+	host->thread_isr = 0;
+
+	cmd = host->deferred_cmd;
+	if (cmd && !sdhci_uhs2_send_command_retry(host, cmd, flags))
+		sdhci_finish_mrq(host, cmd->mrq);
+
+	spin_unlock_irqrestore(&host->lock, flags);
+
+	if (isr & (SDHCI_INT_CARD_INSERT | SDHCI_INT_CARD_REMOVE)) {
+		struct mmc_host *mmc = host->mmc;
+
+		mmc->ops->card_event(mmc);
+		mmc_detect_change(mmc, msecs_to_jiffies(200));
+	}
+
+	return IRQ_HANDLED;
+}
+
 /*****************************************************************************\
  *                                                                           *
  * Driver init/exit                                                          *
diff --git a/drivers/mmc/host/sdhci-uhs2.h b/drivers/mmc/host/sdhci-uhs2.h
index e08aa60bf06b..beef08db0a16 100644
--- a/drivers/mmc/host/sdhci-uhs2.h
+++ b/drivers/mmc/host/sdhci-uhs2.h
@@ -176,10 +176,12 @@
 
 struct sdhci_host;
 struct mmc_command;
+struct mmc_request;
 
 void sdhci_uhs2_dump_regs(struct sdhci_host *host);
 void sdhci_uhs2_reset(struct sdhci_host *host, u16 mask);
 void sdhci_uhs2_set_timeout(struct sdhci_host *host, struct mmc_command *cmd);
 void sdhci_uhs2_clear_set_irqs(struct sdhci_host *host, u32 clear, u32 set);
+u32 sdhci_uhs2_irq(struct sdhci_host *host, u32 intmask);
 
 #endif /* __SDHCI_UHS2_H */
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 46b6502d4d19..842510c9162a 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1497,7 +1497,7 @@ static void sdhci_set_transfer_mode(struct sdhci_host *host,
 	sdhci_writew(host, mode, SDHCI_TRANSFER_MODE);
 }
 
-static bool sdhci_needs_reset(struct sdhci_host *host, struct mmc_request *mrq)
+bool sdhci_needs_reset(struct sdhci_host *host, struct mmc_request *mrq)
 {
 	return (!(host->flags & SDHCI_DEVICE_DEAD) &&
 		((mrq->cmd && mrq->cmd->error) ||
@@ -1505,6 +1505,7 @@ static bool sdhci_needs_reset(struct sdhci_host *host, struct mmc_request *mrq)
 		 (mrq->data && mrq->data->stop && mrq->data->stop->error) ||
 		 (host->quirks & SDHCI_QUIRK_RESET_AFTER_REQUEST)));
 }
+EXPORT_SYMBOL_GPL(sdhci_needs_reset);
 
 static void sdhci_set_mrq_done(struct sdhci_host *host, struct mmc_request *mrq)
 {
@@ -3111,6 +3112,53 @@ static const struct mmc_host_ops sdhci_ops = {
  *                                                                           *
 \*****************************************************************************/
 
+void sdhci_request_done_dma(struct sdhci_host *host, struct mmc_request *mrq)
+{
+	struct mmc_data *data = mrq->data;
+
+	if (data && data->host_cookie == COOKIE_MAPPED) {
+		if (host->bounce_buffer) {
+			/*
+			 * On reads, copy the bounced data into the
+			 * sglist
+			 */
+			if (mmc_get_dma_dir(data) == DMA_FROM_DEVICE) {
+				unsigned int length = data->bytes_xfered;
+
+				if (length > host->bounce_buffer_size) {
+					pr_err("%s: bounce buffer is %u bytes but DMA claims to have transferred %u bytes\n",
+					       mmc_hostname(host->mmc),
+					       host->bounce_buffer_size,
+					       data->bytes_xfered);
+					/* Cap it down and continue */
+					length = host->bounce_buffer_size;
+				}
+				dma_sync_single_for_cpu(mmc_dev(host->mmc),
+							host->bounce_addr,
+							host->bounce_buffer_size,
+							DMA_FROM_DEVICE);
+				sg_copy_from_buffer(data->sg,
+						    data->sg_len,
+						    host->bounce_buffer,
+						    length);
+			} else {
+				/* No copying, just switch ownership */
+				dma_sync_single_for_cpu(mmc_dev(host->mmc),
+							host->bounce_addr,
+							host->bounce_buffer_size,
+							mmc_get_dma_dir(data));
+			}
+		} else {
+			/* Unmap the raw data */
+			dma_unmap_sg(mmc_dev(host->mmc), data->sg,
+				     data->sg_len,
+				     mmc_get_dma_dir(data));
+		}
+		data->host_cookie = COOKIE_UNMAPPED;
+	}
+}
+EXPORT_SYMBOL_GPL(sdhci_request_done_dma);
+
 static bool sdhci_request_done(struct sdhci_host *host)
 {
 	unsigned long flags;
@@ -3175,48 +3223,7 @@ static bool sdhci_request_done(struct sdhci_host *host)
 			sdhci_set_mrq_done(host, mrq);
 		}
 
-		if (data && data->host_cookie == COOKIE_MAPPED) {
-			if (host->bounce_buffer) {
-				/*
-				 * On reads, copy the bounced data into the
-				 * sglist
-				 */
-				if (mmc_get_dma_dir(data) == DMA_FROM_DEVICE) {
-					unsigned int length = data->bytes_xfered;
-
-					if (length > host->bounce_buffer_size) {
-						pr_err("%s: bounce buffer is %u bytes but DMA claims to have transferred %u bytes\n",
-						       mmc_hostname(host->mmc),
-						       host->bounce_buffer_size,
-						       data->bytes_xfered);
-						/* Cap it down and continue */
-						length = host->bounce_buffer_size;
-					}
-					dma_sync_single_for_cpu(
-						mmc_dev(host->mmc),
-						host->bounce_addr,
-						host->bounce_buffer_size,
-						DMA_FROM_DEVICE);
-					sg_copy_from_buffer(data->sg,
-						data->sg_len,
-						host->bounce_buffer,
-						length);
-				} else {
-					/* No copying, just switch ownership */
-					dma_sync_single_for_cpu(
-						mmc_dev(host->mmc),
-						host->bounce_addr,
-						host->bounce_buffer_size,
-						mmc_get_dma_dir(data));
-				}
-			} else {
-				/* Unmap the raw data */
-				dma_unmap_sg(mmc_dev(host->mmc), data->sg,
-					     data->sg_len,
-					     mmc_get_dma_dir(data));
-			}
-			data->host_cookie = COOKIE_UNMAPPED;
-		}
+		sdhci_request_done_dma(host, mrq);
 	}
 
 	host->mrqs_done[i] = NULL;
@@ -3231,7 +3238,7 @@ static bool sdhci_request_done(struct sdhci_host *host)
 	return false;
 }
 
-static void sdhci_complete_work(struct work_struct *work)
+void sdhci_complete_work(struct work_struct *work)
 {
 	struct sdhci_host *host = container_of(work, struct sdhci_host,
 					       complete_work);
@@ -3239,6 +3246,7 @@ static void sdhci_complete_work(struct work_struct *work)
 	while (!sdhci_request_done(host))
 		;
 }
+EXPORT_SYMBOL_GPL(sdhci_complete_work);
 
 static void sdhci_timeout_timer(struct timer_list *t)
 {
@@ -3694,7 +3702,7 @@ static irqreturn_t sdhci_irq(int irq, void *dev_id)
 	return result;
 }
 
-static irqreturn_t sdhci_thread_irq(int irq, void *dev_id)
+irqreturn_t sdhci_thread_irq(int irq, void *dev_id)
 {
 	struct sdhci_host *host = dev_id;
 	struct mmc_command *cmd;
@@ -3724,6 +3732,7 @@ static irqreturn_t sdhci_thread_irq(int irq, void *dev_id)
 
 	return IRQ_HANDLED;
 }
+EXPORT_SYMBOL_GPL(sdhci_thread_irq);
 
 /*****************************************************************************\
  *                                                                           *
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 0e03dc4dacb7..1485e4f1ff49 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -832,6 +832,7 @@ bool sdhci_data_line_cmd(struct mmc_command *cmd);
 void sdhci_mod_timer(struct sdhci_host *host, struct mmc_request *mrq, unsigned long timeout);
 void sdhci_initialize_data(struct sdhci_host *host, struct mmc_data *data);
 void sdhci_prepare_dma(struct sdhci_host *host, struct mmc_data *data);
+bool sdhci_needs_reset(struct sdhci_host *host, struct mmc_request *mrq);
 void __sdhci_finish_mrq(struct sdhci_host *host, struct mmc_request *mrq);
 void sdhci_finish_mrq(struct sdhci_host *host, struct mmc_request *mrq);
 void __sdhci_finish_data_common(struct sdhci_host *host);
@@ -862,6 +863,9 @@ void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios);
 int sdhci_start_signal_voltage_switch(struct mmc_host *mmc,
 				      struct mmc_ios *ios);
 void sdhci_enable_sdio_irq(struct mmc_host *mmc, int enable);
+void sdhci_request_done_dma(struct sdhci_host *host, struct mmc_request *mrq);
+void sdhci_complete_work(struct work_struct *work);
+irqreturn_t sdhci_thread_irq(int irq, void *dev_id);
 void sdhci_adma_write_desc(struct sdhci_host *host, void **desc,
 			   dma_addr_t addr, int len, unsigned int cmd);
 
-- 
2.25.1


