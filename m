Return-Path: <linux-kernel+bounces-134438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FC3289B17E
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 15:24:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24C6C1F21231
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 13:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8253F7C6EB;
	Sun,  7 Apr 2024 13:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EcaU6Saa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D577C0A6;
	Sun,  7 Apr 2024 13:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712495556; cv=none; b=j1mBRXec3TFV1DO4cx1gam5xBnuAoXw6oXAGz/gRK1Snfr9nFnFoc5GNc610zF31T/k0CitkQzsYcbEm3yVI1SkCCdm5uPCrhp8txys5ZEkNsZF5JH6p2shz5SWN76SqclMsoVUdBjpcO7WqFqcyYTiWkek3xRxkGZ7pbVdzi4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712495556; c=relaxed/simple;
	bh=5dQENPDU1LKZC0egfvmacxAEkuYKX1j14Y4z/I/tTAM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UKxcGMrHRSlRn7zXxirzPEbEarnBl/dHtHTohmC6JVpbk/pbYokYEj78Bkp7bvDSUk2KGRASdIEvu+0fuKSLqVT6E9ku4AW9GKWsjgxTH2nd7vezlCWghlpnOZy4F/sE5fnYIyDf7fIhuW0DGHI0mkL5Q23yq0OCiSzd1Q+75+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EcaU6Saa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B467C433B1;
	Sun,  7 Apr 2024 13:12:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712495556;
	bh=5dQENPDU1LKZC0egfvmacxAEkuYKX1j14Y4z/I/tTAM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EcaU6SaaeoDGPHioksuM0JN4VrE1dLCRA0DhKss80oNnuiVaqZvO/ZTh9035dpfvH
	 m1mm8DF+SS9YjhtADYe/yGH+E/TITUDLmvAhvj7HbA1m2T8PkF5QQohLsnXY7r4kgt
	 aOnS9e0kv2kVUYfQMu5DpYIJ5awam3ON9/6HTbAlKvys1dLw2E5p40NKQpVzFgeZSf
	 /+nY0BABkIAt7QU5u/Tg6oTEPs5YAQZ/uOreJgqetd37vi4T/QuYEfhZWsMXD8wduN
	 LPYlkhkjSYtzJRoGbwfLgv/8pJBYRG41Ayi6ZL85njaRmkrsgJF7d2jsK9NaProRUd
	 2N3sEQ7xj9wJw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Justin Tee <justin.tee@broadcom.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>,
	james.smart@broadcom.com,
	dick.kennedy@broadcom.com,
	jejb@linux.ibm.com,
	linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 03/22] scsi: lpfc: Remove IRQF_ONESHOT flag from threaded IRQ handling
Date: Sun,  7 Apr 2024 09:12:02 -0400
Message-ID: <20240407131231.1051652-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240407131231.1051652-1-sashal@kernel.org>
References: <20240407131231.1051652-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.25
Content-Transfer-Encoding: 8bit

From: Justin Tee <justin.tee@broadcom.com>

[ Upstream commit 4623713e7ade46bfc63a3eade836f566ccbcd771 ]

IRQF_ONESHOT is found to mask HBA generated interrupts when thread_fn is
running.  As a result, some EQEs/CQEs miss timely processing resulting in
SCSI layer attempts to abort commands due to io_timeout.  Abort CQEs are
also not processed leading to the observations of hangs and spam of "0748
abort handler timed out waiting for aborting I/O" log messages.

Remove the IRQF_ONESHOT flag.  The cmpxchg and xchg atomic operations on
lpfc_queue->queue_claimed already protect potential parallel access to an
EQ/CQ should the thread_fn get interrupted by the primary irq handler.

Signed-off-by: Justin Tee <justin.tee@broadcom.com>
Link: https://lore.kernel.org/r/20240305200503.57317-4-justintee8345@gmail.com
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/lpfc/lpfc_init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/lpfc/lpfc_init.c b/drivers/scsi/lpfc/lpfc_init.c
index 2c336953e56ca..76c883cc66ed6 100644
--- a/drivers/scsi/lpfc/lpfc_init.c
+++ b/drivers/scsi/lpfc/lpfc_init.c
@@ -13051,7 +13051,7 @@ lpfc_sli4_enable_msix(struct lpfc_hba *phba)
 		rc = request_threaded_irq(eqhdl->irq,
 					  &lpfc_sli4_hba_intr_handler,
 					  &lpfc_sli4_hba_intr_handler_th,
-					  IRQF_ONESHOT, name, eqhdl);
+					  0, name, eqhdl);
 		if (rc) {
 			lpfc_printf_log(phba, KERN_WARNING, LOG_INIT,
 					"0486 MSI-X fast-path (%d) "
-- 
2.43.0


