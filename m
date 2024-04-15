Return-Path: <linux-kernel+bounces-145157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8354F8A5039
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 15:04:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 114201F21CA0
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 13:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29969131725;
	Mon, 15 Apr 2024 12:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iK/lUZOw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C42A131197;
	Mon, 15 Apr 2024 12:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713185450; cv=none; b=PTaYnYRdQLKtY8n3vINWreLKz5/qlvLEKHrUyjPcfpLekAG1ywoPPs5ZXoMlwuYMsLM0zjQr2aaBNCBVm93WFb+ixTNJW5+KGlJugrlgh3W3tC5lO/GjaU5RzgaEKZJAU7lhqxgUVPawmPQizgVYPcMRP2LvpTq8sCx1XKlxG3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713185450; c=relaxed/simple;
	bh=nw55+VOpSKCFU5z9iBHcAaveAuSjI2mNzuzQYI+vTic=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CE9Be13q2Emjd9I8vuQBlHp4yubpkXoloyG0g4P6qpV1aUbyJBpehbmUYUZ8F+rbQdM0SHuX7y25eNIfaI9n6+lQWUfbX2SAO1ouDSwSdZ1fOi/8V/NtBZbzKLIVikWd+BEl95K62ZGmdETYVmO+uLrrUwOcqStXQ8XIubTPhdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iK/lUZOw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F389BC3277B;
	Mon, 15 Apr 2024 12:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713185449;
	bh=nw55+VOpSKCFU5z9iBHcAaveAuSjI2mNzuzQYI+vTic=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iK/lUZOw95G5d1CP46KqjoPv1FC+2khdHMnLPz7vRaOO/q9KCKPdCoGZOkfZen3ov
	 B+3HiLJALiOqw26DhQIQ1SAWcbP/RtWwhrqtmYJPxhJeJjjjannEPjCjyxPx6Qa+9+
	 R51XAoKHA24SFZgjnau43ljPfwmPbhXN7v+mRwD8G1+U17n0sjq1BuuQQTzag/zfN/
	 S3WxwtSVKbAuUPy3LZ8atg2PXsRAfKsBqMMguWTsabXGVCH3N77Bx4bFjxyJcp5oq/
	 mZFYQI3rgumPxPPhxG9l2Wao3wMCIodvxLdbVVbnQ+p01+hqnQtm6SCCKdRoLupSHt
	 4944UXHrOur9Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Adam Goldman <adamg@pobox.com>,
	Takashi Sakamoto <o-takashi@sakamocchi.jp>,
	Sasha Levin <sashal@kernel.org>,
	linux1394-devel@lists.sourceforge.net
Subject: [PATCH AUTOSEL 5.15 4/4] firewire: ohci: mask bus reset interrupts between ISR and bottom half
Date: Mon, 15 Apr 2024 06:04:46 -0400
Message-ID: <20240415100449.3127574-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240415100449.3127574-1-sashal@kernel.org>
References: <20240415100449.3127574-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.155
Content-Transfer-Encoding: 8bit

From: Adam Goldman <adamg@pobox.com>

[ Upstream commit 752e3c53de0fa3b7d817a83050b6699b8e9c6ec9 ]

In the FireWire OHCI interrupt handler, if a bus reset interrupt has
occurred, mask bus reset interrupts until bus_reset_work has serviced and
cleared the interrupt.

Normally, we always leave bus reset interrupts masked. We infer the bus
reset from the self-ID interrupt that happens shortly thereafter. A
scenario where we unmask bus reset interrupts was introduced in 2008 in
a007bb857e0b26f5d8b73c2ff90782d9c0972620: If
OHCI_PARAM_DEBUG_BUSRESETS (8) is set in the debug parameter bitmask, we
will unmask bus reset interrupts so we can log them.

irq_handler logs the bus reset interrupt. However, we can't clear the bus
reset event flag in irq_handler, because we won't service the event until
later. irq_handler exits with the event flag still set. If the
corresponding interrupt is still unmasked, the first bus reset will
usually freeze the system due to irq_handler being called again each
time it exits. This freeze can be reproduced by loading firewire_ohci
with "modprobe firewire_ohci debug=-1" (to enable all debugging output).
Apparently there are also some cases where bus_reset_work will get called
soon enough to clear the event, and operation will continue normally.

This freeze was first reported a few months after a007bb85 was committed,
but until now it was never fixed. The debug level could safely be set
to -1 through sysfs after the module was loaded, but this would be
ineffectual in logging bus reset interrupts since they were only
unmasked during initialization.

irq_handler will now leave the event flag set but mask bus reset
interrupts, so irq_handler won't be called again and there will be no
freeze. If OHCI_PARAM_DEBUG_BUSRESETS is enabled, bus_reset_work will
unmask the interrupt after servicing the event, so future interrupts
will be caught as desired.

As a side effect to this change, OHCI_PARAM_DEBUG_BUSRESETS can now be
enabled through sysfs in addition to during initial module loading.
However, when enabled through sysfs, logging of bus reset interrupts will
be effective only starting with the second bus reset, after
bus_reset_work has executed.

Signed-off-by: Adam Goldman <adamg@pobox.com>
Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/firewire/ohci.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/firewire/ohci.c b/drivers/firewire/ohci.c
index 667ff40f39353..7d94e1cbc0ed3 100644
--- a/drivers/firewire/ohci.c
+++ b/drivers/firewire/ohci.c
@@ -2049,6 +2049,8 @@ static void bus_reset_work(struct work_struct *work)
 
 	ohci->generation = generation;
 	reg_write(ohci, OHCI1394_IntEventClear, OHCI1394_busReset);
+	if (param_debug & OHCI_PARAM_DEBUG_BUSRESETS)
+		reg_write(ohci, OHCI1394_IntMaskSet, OHCI1394_busReset);
 
 	if (ohci->quirks & QUIRK_RESET_PACKET)
 		ohci->request_generation = generation;
@@ -2115,12 +2117,14 @@ static irqreturn_t irq_handler(int irq, void *data)
 		return IRQ_NONE;
 
 	/*
-	 * busReset and postedWriteErr must not be cleared yet
+	 * busReset and postedWriteErr events must not be cleared yet
 	 * (OHCI 1.1 clauses 7.2.3.2 and 13.2.8.1)
 	 */
 	reg_write(ohci, OHCI1394_IntEventClear,
 		  event & ~(OHCI1394_busReset | OHCI1394_postedWriteErr));
 	log_irqs(ohci, event);
+	if (event & OHCI1394_busReset)
+		reg_write(ohci, OHCI1394_IntMaskClear, OHCI1394_busReset);
 
 	if (event & OHCI1394_selfIDComplete)
 		queue_work(selfid_workqueue, &ohci->bus_reset_work);
-- 
2.43.0


