Return-Path: <linux-kernel+bounces-66617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B32D855F0D
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 11:20:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F355B287096
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 10:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC7306996F;
	Thu, 15 Feb 2024 10:20:41 +0000 (UTC)
Received: from cae.in-ulm.de (cae.in-ulm.de [217.10.14.231])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1609A69D01;
	Thu, 15 Feb 2024 10:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.10.14.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707992441; cv=none; b=l72mBWus2NGu0JRJzPvhDlwOGbXnlQnlx40wd0umcUUBDsvlntEfzAzs3JP5MKAubJlBQynrxLZ7wZOTrKnbz1WNZexL3RArArZwlCUfHA+cXw8jElwIKUYDEetPDU11sDOHNbaXxc2wXHi+AKzsogJPHrAjc+lz+siRTC4tT6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707992441; c=relaxed/simple;
	bh=MNzjTQVy8i+SjCyYirVZZm1jgkX/BUR/FaONBXox8oA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dk/YR2Bj/CD+KLZ0FMVdpGEiYYxpljC7KUcpVSB4doMsD6s4aYDK6uSgUsvNYkqL2wagRTiJDZlYhhqHam27tJ25AJ4ZXFfcV+X282rJTc4rtG2GvpRGTPuHFppkNBhfOM0O6dxjj5zCSre2aZe/cifjQsoGZpu2s6gEp8rhi2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c--e.de; spf=pass smtp.mailfrom=c--e.de; arc=none smtp.client-ip=217.10.14.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c--e.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=c--e.de
Received: by cae.in-ulm.de (Postfix, from userid 1000)
	id 1F8F61402E9; Thu, 15 Feb 2024 11:10:41 +0100 (CET)
From: "Christian A. Ehrhardt" <lk@c--e.de>
To: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: "Christian A. Ehrhardt" <lk@c--e.de>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Sing-Han Chen <singhanc@nvidia.com>,
	Haotien Hsu <haotienh@nvidia.com>,
	Utkarsh Patel <utkarsh.h.patel@intel.com>,
	"Jonathan Hunter" <jonathanh@nvidia.com>,
	"Wayne Chang" <waynec@nvidia.com>,
	"WK Tsai" <wtsai@nvidia.com>
Subject: [PATCH CFT] usb: ucsi_ccg: Fix command completion handling
Date: Thu, 15 Feb 2024 11:10:24 +0100
Message-Id: <20240215101024.764444-1-lk@c--e.de>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In case of a spurious or otherwise delayed interrupt
it is possible that CCI still reports the previous completion.
For this reason the UCSI spec provides different completion
bits for normal commands and for UCSI_ACK_CC_CI.

Only complete a sync command if the correct completion bit
is set.

This should avoid the need to clear out CCI before starting
a command. Thus remove this code.

Signed-off-by: Christian A. Ehrhardt <lk@c--e.de>
Fixes: e32fd989ac1c ("usb: typec: ucsi: ccg: Move to the new API")
---
Additional information:
A similar change for ucsi_acpi.c is here:
  https://lore.kernel.org/all/20240121204123.275441-3-lk@c--e.de/
This restores behaviour that ucsi.c had before moving to the new API.
I've seen timeouts with ucsi_acpi.c without that fix, often if there
were many port events (plug/unplug).

I do _not_ have CCG hardware to test this. So someone else will have to
provide a Tested-By tag or similar (hence the CFT in the subject).

But from looking at the code I think this change is needed for CCG,
too. Additionally, the recent change to CCG here
  https://lore.kernel.org/all/20240126030115.3791554-1-haotienh@nvidia.com/
seems to work around the same problem.

Clearing the cached CCI value should not be necessary with this
anymore and I suspect that it can potentially cause other problems.
However, I can send an update patch without this hunk if desired.


 drivers/usb/typec/ucsi/ucsi_ccg.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/drivers/usb/typec/ucsi/ucsi_ccg.c b/drivers/usb/typec/ucsi/ucsi_ccg.c
index dda7c7c94e08..9442307e0abd 100644
--- a/drivers/usb/typec/ucsi/ucsi_ccg.c
+++ b/drivers/usb/typec/ucsi/ucsi_ccg.c
@@ -616,14 +616,6 @@ static int ucsi_ccg_async_write(struct ucsi *ucsi, unsigned int offset,
 	struct ucsi_ccg *uc = ucsi_get_drvdata(ucsi);
 	u16 reg = CCGX_RAB_UCSI_DATA_BLOCK(offset);
 
-	/*
-	 * UCSI may read CCI instantly after async_write,
-	 * clear CCI to avoid caller getting wrong data before we get CCI from ISR
-	 */
-	spin_lock(&uc->op_lock);
-	uc->op_data.cci = 0;
-	spin_unlock(&uc->op_lock);
-
 	return ccg_write(uc, reg, val, val_len);
 }
 
@@ -708,9 +700,14 @@ static irqreturn_t ccg_irq_handler(int irq, void *data)
 err_clear_irq:
 	ccg_write(uc, CCGX_RAB_INTR_REG, &intr_reg, sizeof(intr_reg));
 
-	if (!ret && test_bit(DEV_CMD_PENDING, &uc->flags) &&
-	    cci & (UCSI_CCI_ACK_COMPLETE | UCSI_CCI_COMMAND_COMPLETE))
-		complete(&uc->complete);
+	if (!ret && test_bit(DEV_CMD_PENDING, &uc->flags)) {
+		bool ack = UCSI_COMMAND(uc->last_cmd_sent) == UCSI_ACK_CC_CI;
+
+		if (ack && (cci & UCSI_CCI_ACK_COMPLETE))
+			complete(&uc->complete);
+		if (!ack && (cci & UCSI_CCI_COMMAND_COMPLETE))
+			complete(&uc->complete);
+	}
 
 	return IRQ_HANDLED;
 }
-- 
2.40.1


