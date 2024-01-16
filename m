Return-Path: <linux-kernel+bounces-28041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BF0182F974
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 22:08:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1A41B27555
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 21:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E23B3143770;
	Tue, 16 Jan 2024 19:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j80mTLoF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E81143757;
	Tue, 16 Jan 2024 19:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705434963; cv=none; b=gohZOEbynfqNRb4jcPsJEY+ct5fL4FGEn7CI3t8qNdvglIjAFnaYr+2v1B3u5Y9Ru/XikB04N6SORcj0JW81d/lCjYN0HGzVm+kSTwy+N1/P35PH0xpH2LoLG9/oeHuyyuoykQbN/fUZ1YS53x3GNcUc9VomjcNzuHxKENHwoDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705434963; c=relaxed/simple;
	bh=0d1xuC+FaJReAAN4MpEAixpItb3vPQAcvsPcZYbl8jc=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=CXY+sTcOYCEIMXXqJX9F1fFqkBqo+bqSMsemONJ7UVYCRdkfqJK/bCPdm3PXIKhIRXA9qdFQDe7pH2cRVoWVdr+EgpeELl/bHmugotj39tsUczBj0w7iU5VzjZNt0RQnHGbPXM3kBFEvLUuIPlH9NahQqs00O3W/vfmhx+Bx5cA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j80mTLoF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24A05C433F1;
	Tue, 16 Jan 2024 19:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705434963;
	bh=0d1xuC+FaJReAAN4MpEAixpItb3vPQAcvsPcZYbl8jc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=j80mTLoFwTXiaqpmbTRFEuwWUqf1MUzOZc8NfUsYOBRamXoMR39tQSgMXcX2YS1Tm
	 cqxvV3NNYC0QpLLUoFjgB+8CsCJonXOkHU6fELPVsi/RAAVbNq2k5C/GuquX9vXqg4
	 IqsqcdN9TP1rfGrSonneMAJ5Tsib9HLS0gm8MZlLUtJMoZTFoAQ9NEnsisMRV6xlzB
	 heA5iQDiHISJ9g24gio7rUGm9HKJMeRt/R6UxnYv1gDWbZ9kkwk+uofQxmd8F90vy/
	 x1QZazM6M/S9BSO181kmZmXYKfrU2PIwvN9QXfqLKN0eENVjG4IX1js0UMpAM/l8vn
	 pejmdf2pRmRiA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hannes Reinecke <hare@suse.de>,
	Christoph Hellwig <hch@lst.de>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>,
	jejb@linux.ibm.com,
	linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 24/68] scsi: libfc: Don't schedule abort twice
Date: Tue, 16 Jan 2024 14:53:23 -0500
Message-ID: <20240116195511.255854-24-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116195511.255854-1-sashal@kernel.org>
References: <20240116195511.255854-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.73
Content-Transfer-Encoding: 8bit

From: Hannes Reinecke <hare@suse.de>

[ Upstream commit b57c4db5d23b9df0118a25e2441c9288edd73710 ]

The current FC error recovery is sending up to three REC (recovery) frames
in 10 second intervals, and as a final step sending an ABTS after 30
seconds for the command itself.  Unfortunately sending an ABTS is also the
action for the SCSI abort handler, and the default timeout for SCSI
commands is also 30 seconds. This causes two ABTS to be scheduled, with the
libfc one slightly earlier. The ABTS scheduled by SCSI EH then sees the
command to be already aborted, and will always return with a 'GOOD' status
irrespective on the actual result from the first ABTS.  This causes the
SCSI EH abort handler to always succeed, and SCSI EH never to be engaged.
Fix this by not issuing an ABTS when a SCSI command is present for the
exchange, but rather wait for the abort scheduled from SCSI EH.  And warn
if an abort is already scheduled to avoid similar errors in the future.

Signed-off-by: Hannes Reinecke <hare@suse.de>
Link: https://lore.kernel.org/r/20231129165832.224100-2-hare@kernel.org
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/libfc/fc_fcp.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/scsi/libfc/fc_fcp.c b/drivers/scsi/libfc/fc_fcp.c
index 945adca5e72f..3f189cedf6db 100644
--- a/drivers/scsi/libfc/fc_fcp.c
+++ b/drivers/scsi/libfc/fc_fcp.c
@@ -265,6 +265,11 @@ static int fc_fcp_send_abort(struct fc_fcp_pkt *fsp)
 	if (!fsp->seq_ptr)
 		return -EINVAL;
 
+	if (fsp->state & FC_SRB_ABORT_PENDING) {
+		FC_FCP_DBG(fsp, "abort already pending\n");
+		return -EBUSY;
+	}
+
 	this_cpu_inc(fsp->lp->stats->FcpPktAborts);
 
 	fsp->state |= FC_SRB_ABORT_PENDING;
@@ -1690,11 +1695,12 @@ static void fc_fcp_recovery(struct fc_fcp_pkt *fsp, u8 code)
 	fsp->status_code = code;
 	fsp->cdb_status = 0;
 	fsp->io_status = 0;
-	/*
-	 * if this fails then we let the scsi command timer fire and
-	 * scsi-ml escalate.
-	 */
-	fc_fcp_send_abort(fsp);
+	if (!fsp->cmd)
+		/*
+		 * Only abort non-scsi commands; otherwise let the
+		 * scsi command timer fire and scsi-ml escalate.
+		 */
+		fc_fcp_send_abort(fsp);
 }
 
 /**
-- 
2.43.0


