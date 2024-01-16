Return-Path: <linux-kernel+bounces-28104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6907282FA47
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 22:29:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8BE33B2778C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 21:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDD6863109;
	Tue, 16 Jan 2024 19:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bpqCqNn8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24846151CF3;
	Tue, 16 Jan 2024 19:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705435150; cv=none; b=a4+q/jhKWhKPCMYCyhBaJQPqP53EFNFrihFG1pp9hCIWrML/uTHVMC545qf8xwUqY1s3DCIuIhUJFnNINqJagcS9tS3mldiaKxsfIQGz2YJnSIt6OzWu3KRB/WPd2vD0erBfaRrRGdYgDLLWd632OyRWxMooKP6j3lHprj3o5sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705435150; c=relaxed/simple;
	bh=XvJrxavKFpadQ1zRnvzsj31y6FTZmRxkFS4XyewT05k=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=WRSfLt+8p9YuEjmCxLrNE3JsMmWEJk1aq8zewyKExAsq7HAEBFjE63l3WJoTAC1CUldJAI0K+4daamVt/tTRHu/ZkowONHS7XQEbJDLaEYq5zkrRmNqIIbxF0govA5PaHZp5/kcno3S6U+u8BNnM65ukBowRJ0rGPSVP1jmTMqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bpqCqNn8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 267BCC433C7;
	Tue, 16 Jan 2024 19:59:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705435150;
	bh=XvJrxavKFpadQ1zRnvzsj31y6FTZmRxkFS4XyewT05k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bpqCqNn8R2GyoUhWZ8vb+CQJdlq7UYg/OeJss75TXV7vS5s8wOv+ay9W2tsGtJ4an
	 AbGRiYDXufFwRKCYRxKYHBKdXUMJL2+aBXI8BezZtmnL2jFxFDW9c4FUWAajepwyjo
	 /lsQkPBMFetza+wsO4+Y8w7aUqRpdmfykSL7X1s1r3s6c5xgxNvEbH5cUpq0A3upK3
	 ZepAvHwG/9fCuw/j4Tc+nvua+RQbaLmCk1PsyaOAMpLdtzcj80GZR4VAgikZHSUOeD
	 wcs2IoPJfwusy75K6GOZI1faK963Js80nhtFZXPUqyb2GUF2B9X7tHzJE7jcsRFfbG
	 p7S6eT5at78Sw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hannes Reinecke <hare@suse.de>,
	Christoph Hellwig <hch@lst.de>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>,
	jejb@linux.ibm.com,
	linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 17/47] scsi: libfc: Fix up timeout error in fc_fcp_rec_error()
Date: Tue, 16 Jan 2024 14:57:20 -0500
Message-ID: <20240116195834.257313-17-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116195834.257313-1-sashal@kernel.org>
References: <20240116195834.257313-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.147
Content-Transfer-Encoding: 8bit

From: Hannes Reinecke <hare@suse.de>

[ Upstream commit 53122a49f49796beb2c4a1bb702303b66347e29f ]

We should set the status to FC_TIMED_OUT when a timeout error is passed to
fc_fcp_rec_error().

Signed-off-by: Hannes Reinecke <hare@suse.de>
Link: https://lore.kernel.org/r/20231129165832.224100-3-hare@kernel.org
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/libfc/fc_fcp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/libfc/fc_fcp.c b/drivers/scsi/libfc/fc_fcp.c
index a1015a81e86e..a6efbcc27181 100644
--- a/drivers/scsi/libfc/fc_fcp.c
+++ b/drivers/scsi/libfc/fc_fcp.c
@@ -1686,7 +1686,7 @@ static void fc_fcp_rec_error(struct fc_fcp_pkt *fsp, struct fc_frame *fp)
 		if (fsp->recov_retry++ < FC_MAX_RECOV_RETRY)
 			fc_fcp_rec(fsp);
 		else
-			fc_fcp_recovery(fsp, FC_ERROR);
+			fc_fcp_recovery(fsp, FC_TIMED_OUT);
 		break;
 	}
 	fc_fcp_unlock_pkt(fsp);
-- 
2.43.0


