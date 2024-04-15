Return-Path: <linux-kernel+bounces-145162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E61318A5047
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 15:05:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15B291C2270D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 13:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89EB81332A7;
	Mon, 15 Apr 2024 12:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f0yaxQXr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4AC3133291;
	Mon, 15 Apr 2024 12:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713185460; cv=none; b=omKOgtAId8gT1L0Beq7OZEOQVLLtHCOIw831som85WzeuIsUbTbvKpK9VDV985qHqvNZcndACUM8ZEnp7uPbUfLQGS6CnqSe8HDK4GD/2T3j/RyUMamlPx8VaoRJuqGmxCj5N/Jo/ldqdqmB/pEOqvNqH92/jOAYWU2+L4krQxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713185460; c=relaxed/simple;
	bh=9tP4vu3mvUYXoTHFwss6fvV5B2eIIfBqAfbIRmkAF08=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CiX3yo7Mdd4QhQ2ujGXuYEkPylrCInoa5cUVfnqWo9x3KaxlgwIR1T191dJhlwwfSYtWMyCoLBZzpSKIqGPfQde7TCZ4E45QqoXPTs9LI8EtbS68zdk/tIkAT2qdl9Vbs8ub4dtej0YnWBTrYpu7PYri36TjQqJwKUakO+HGuyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f0yaxQXr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC33BC3277B;
	Mon, 15 Apr 2024 12:50:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713185460;
	bh=9tP4vu3mvUYXoTHFwss6fvV5B2eIIfBqAfbIRmkAF08=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f0yaxQXrDvEtd860tVtyHvHA+fQrMr9ihULveITUeje2KXtmm4kIOJpfQ/RDgovOY
	 N8MWw1Jksmf3mwHAAVnwXBceIvJ5bF+B5umPB6+egLPZWGV18heOsATqqL/gy6FRW7
	 kbwVEmTbQcHw6t1+xavZfxhEv/ARI1nWaZDV+brc9t6I4AQ4QoJq9+JO+GWzZV9CgQ
	 xJEXcJ4KeVABqZ1dXKjLhkmAjE/4XjZ8Chfk3l3Nji9Ur3mRC0U6ZE4hrEDa2b5P8V
	 B9Meh6wGxEHfLsmt6GAzLNwgIrTGOj+zBtcmPcvphwfAunFFQ0CTshiPMD0dZwqliX
	 XtGrubx+N+qqQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Adam Goldman <adamg@pobox.com>,
	Takashi Sakamoto <o-takashi@sakamocchi.jp>,
	Sasha Levin <sashal@kernel.org>,
	linux1394-devel@lists.sourceforge.net
Subject: [PATCH AUTOSEL 5.10 4/4] firewire: ohci: mask bus reset interrupts between ISR and bottom half
Date: Mon, 15 Apr 2024 06:04:57 -0400
Message-ID: <20240415100459.3127671-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240415100459.3127671-1-sashal@kernel.org>
References: <20240415100459.3127671-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.215
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
index 45d19cc0aeac0..9b2471d12783c 100644
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


