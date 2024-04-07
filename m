Return-Path: <linux-kernel+bounces-134412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E742389B130
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 15:16:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 007861C211B3
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 13:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC3484EB5C;
	Sun,  7 Apr 2024 13:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YE8ssZom"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4CEA4DA11;
	Sun,  7 Apr 2024 13:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712495496; cv=none; b=GBi+x1+3wR799g7PicSjEJV72urcTR2DQznZwC5vcdrHgS2gs4LY92xO63QZ9ldh/0ixCuP8rWsSSIk6qeq+ilUGpaFwrrqNX895E8pLRxilHSK35mC1EEBGkExmbpt4Mq9WVu5lQx8TCM87sBWX0g4kvY0XdGzLGLFT8TiI/WY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712495496; c=relaxed/simple;
	bh=Mg80D3IUFip6k6UW1M+0qUD9cwdyJQ5td5WoAhNUomw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sicjYpLIC7J6puE3/w+jL13FRrl6c9DtfAwNwJrJPjRY/JvzsWzhJHp/vhtuCesUstM7/zjjed+qbHKid8v1yOFlOAbK3YPvvr6v6PWqsGh+uITVS8NW2M0qPCg1HDNuAd47eWau/gyx+bz5jb9ik1RjVyfLAKnv+9i43HS0Z4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YE8ssZom; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 799E2C433B1;
	Sun,  7 Apr 2024 13:11:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712495495;
	bh=Mg80D3IUFip6k6UW1M+0qUD9cwdyJQ5td5WoAhNUomw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YE8ssZombIwJv0aVNqrO7rkBE+xCgrpuozP9KgEXdMYx37bYV7+sU9Dy4Sb602lJw
	 PPNTN0bw5AbEY28ZLgh5QR+SPhXJ8q6Z+Jj7RxOnWN1SICjWgJ0isqIy3YYvF2FLCZ
	 Qh1d3Vy+L7Qe61luSbcXHlUciJ+u8xHkBgwYjU51y6xe4y2l6jjvebu2KSjV4d4ULc
	 M1WTA9NwYE2ccmBQWGulpY3fnWrock+Z2Oe43691LmTBFfqxkjwX52QT87M1gtq3Iq
	 rTsQhnP3lrq/dthiwkqcIVW/2eonkVsYwndkH5qFBC6M62Od+qqDzJQWwAIop1wqHC
	 wyv/g7Eb4PQCQ==
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
Subject: [PATCH AUTOSEL 6.8 03/25] scsi: lpfc: Remove IRQF_ONESHOT flag from threaded IRQ handling
Date: Sun,  7 Apr 2024 09:10:51 -0400
Message-ID: <20240407131130.1050321-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240407131130.1050321-1-sashal@kernel.org>
References: <20240407131130.1050321-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.4
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
index 70bcee64bc8c6..7820a1a7aa6d1 100644
--- a/drivers/scsi/lpfc/lpfc_init.c
+++ b/drivers/scsi/lpfc/lpfc_init.c
@@ -13047,7 +13047,7 @@ lpfc_sli4_enable_msix(struct lpfc_hba *phba)
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


