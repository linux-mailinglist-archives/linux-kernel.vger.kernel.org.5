Return-Path: <linux-kernel+bounces-28192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EDE582FB64
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 22:54:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39CF228CC4D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 21:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 394BF16506C;
	Tue, 16 Jan 2024 20:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KY2wYtVK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7275041C9B;
	Tue, 16 Jan 2024 20:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705435417; cv=none; b=anUGgAkZSRPBhJWCJD0Bt8WaHFIHxYe2oeT8tIcpSgjQhengRqYQDPe2ZpEwuCTvFeUC3o0V/omTHB63ibGhpJsw8Q+oDqmRuewdsemjqYlgCBKHB7Rx01Fg6VNOI5kep87PrJdpJ8vttzVUmkN8pndDD4qCvXb7Wb6ioqexggA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705435417; c=relaxed/simple;
	bh=rNdwqpK7StCpC0MHcoohvQYSoSgAG0hxdSGXfp0F0Wg=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=ds+fj0zsNJXR/OrTKt4Ci/qoqZsqdfA5UIVZgiG0qEfvkeXgnV0AiDDE86yzfL5DYZbVomQ7iTIzDJIxj/FxLXKl9/H636m+A349iJUKuHDURuhYqFPgKaVxTsvTJYARuqFRQqqjqIclZ6/OTciyXGjfINVYT+zqdl1tX4D8uwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KY2wYtVK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 219F2C43390;
	Tue, 16 Jan 2024 20:03:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705435417;
	bh=rNdwqpK7StCpC0MHcoohvQYSoSgAG0hxdSGXfp0F0Wg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KY2wYtVKJTGI6P+QQjKdCrElvGYSnmDYF1KvsArMG0OiSnwRNTG//UuLdccOMJrNV
	 3LQMwkwJpHe/knyk+KfxVblaAO+BB/dfMhhtiOo+wZYZSNszSwtzyRkGPF4VzJumB0
	 VhIfDIUKShyKfB0xjueCC+ruLkTvvGt3MmiCSPAqgounAGiWfr0ICmRPfbg02326W/
	 ekenK0PdfodXEa/X8v87JAlkjax30wvc+88h2gRqehzZfuk2ymD+2e5PrE5vZJkoqj
	 lNGBGQXbG+AYtYXdTRQAos0nW6jd3+NVdYq42t0Ht7d0TQOmyYofR/tsmhAGdI64zv
	 v9tA6w0aWNSTQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hannes Reinecke <hare@suse.de>,
	Christoph Hellwig <hch@lst.de>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>,
	jejb@linux.ibm.com,
	linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 12/31] scsi: libfc: Don't schedule abort twice
Date: Tue, 16 Jan 2024 15:02:21 -0500
Message-ID: <20240116200310.259340-12-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116200310.259340-1-sashal@kernel.org>
References: <20240116200310.259340-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.267
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
index bf2cc9656e19..22e286f920f4 100644
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
 
@@ -1698,11 +1703,12 @@ static void fc_fcp_recovery(struct fc_fcp_pkt *fsp, u8 code)
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


