Return-Path: <linux-kernel+bounces-28151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F67F82FADC
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 22:42:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE2CF28B383
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 21:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B141815B96E;
	Tue, 16 Jan 2024 20:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SssbEaa4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F08D415B104;
	Tue, 16 Jan 2024 20:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705435283; cv=none; b=BA48n1D/eeOFUM/8q74gcMmxm2zQw1L9PwAkFnegDDmRbY2fT5TUtrsiP0yhfbBwtTWBq6QpX0FjJbbE09u/WNO+eVl6FOARr6khnbsw2VwMwYNq9YdGaPxVyYcOEPefmF/q9BgOwEqbYprsokIOj3DBIjMMX6njo76Ytu704Q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705435283; c=relaxed/simple;
	bh=DZ9RAMXJhdm5yCZtydaw8uNgsPmizjmf20oqtU0zTYg=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=UF2uwjitzAX3O4mYEVCR1rG73BVfF36z75ExBkNtW4dKIKJADeoEcqf840oWQljCdf2zD/s15Yy2giI45hWVfuWlKpyV3Ofc3C6BMIdm1CEHSENrBiBuWobXoV3mRiAownXBox5VhQORYvzZP8n44QF56aSKB2+mvRIh555eGkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SssbEaa4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F156CC433C7;
	Tue, 16 Jan 2024 20:01:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705435282;
	bh=DZ9RAMXJhdm5yCZtydaw8uNgsPmizjmf20oqtU0zTYg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SssbEaa4Dqd0vdY4i3ouzva/5kKNvScPSc4ugCTUZ3e8zWd9WTtlkoKkEU+KHCP9r
	 HlPoF9mxeAEyeR6LUApEUclx4vqoqa795Tx674rfxnTdYMLOqefsmKDelxNvbRv74X
	 eMhNhjVESL5DuPkQitOsT6f/5ThBnMMKVpr1LViF2OaacOMIQveRXN+BxCgZs2z9gL
	 eewr/8PElZQHs3ft5knw8bT09LIVAKhsjwsqbdyo8/YmxuYZhX+gkAtFQB2+CkQBPI
	 IYVynLxMzrULWqjhhPchi9HfnVY3NGEyZTF9R9cJ1uymj4JD+u8utGi8JKJZ1lvlmM
	 YULQcfHJOZpWg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hannes Reinecke <hare@suse.de>,
	Christoph Hellwig <hch@lst.de>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>,
	jejb@linux.ibm.com,
	linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 15/44] scsi: libfc: Don't schedule abort twice
Date: Tue, 16 Jan 2024 14:59:44 -0500
Message-ID: <20240116200044.258335-15-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116200044.258335-1-sashal@kernel.org>
References: <20240116200044.258335-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.208
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
index 7cfeb6886237..6f005ada489b 100644
--- a/drivers/scsi/libfc/fc_fcp.c
+++ b/drivers/scsi/libfc/fc_fcp.c
@@ -270,6 +270,11 @@ static int fc_fcp_send_abort(struct fc_fcp_pkt *fsp)
 	if (!fsp->seq_ptr)
 		return -EINVAL;
 
+	if (fsp->state & FC_SRB_ABORT_PENDING) {
+		FC_FCP_DBG(fsp, "abort already pending\n");
+		return -EBUSY;
+	}
+
 	per_cpu_ptr(fsp->lp->stats, get_cpu())->FcpPktAborts++;
 	put_cpu();
 
@@ -1700,11 +1705,12 @@ static void fc_fcp_recovery(struct fc_fcp_pkt *fsp, u8 code)
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


