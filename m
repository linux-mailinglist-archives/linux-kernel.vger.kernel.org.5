Return-Path: <linux-kernel+bounces-134427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B640D89B15C
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 15:21:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D315B20AD0
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 13:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10B4069DFB;
	Sun,  7 Apr 2024 13:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ugH7fR1y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4848E65E02;
	Sun,  7 Apr 2024 13:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712495521; cv=none; b=KGHEXawWDbwITsfDyYKALUpZ8rBo25lRVKX2ZtJI2YPUsfnXNcY/LFwfRurrSatIkLFylQzgwKM9Wvo6hQxVVVuv8CWugUgbYDLUSl3H4e/sqE2MkoWoyOq0jIJZxhFUHDN8/5J8WS4WxeQfWO/FN6FgaSbCRLbpZ++goBf2sT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712495521; c=relaxed/simple;
	bh=GvcEo2TtaGFeuJ0C6PQOnRmHWCvt0cLf3mBs6Q3kM9c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U5QEgbp5/4L3KJp9sqNCDnSwLE7igPF04LPIxpUQD4lh127UKJQvVN1diOg4o0VPpB7eWv+y/AuHkSsRQQiKJQhUvZvqD8oVb073RHgc2dOYrHMCglK8ZvFC5RvLfRgYegKfcFt1iGT0+ENteVPXj0lCLZTIaw/sYdiHGEIFXEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ugH7fR1y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 691BDC433C7;
	Sun,  7 Apr 2024 13:11:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712495520;
	bh=GvcEo2TtaGFeuJ0C6PQOnRmHWCvt0cLf3mBs6Q3kM9c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ugH7fR1yV5I8NkOdlZqRHCHRtW25dUiBHZPj8Y489W5c5e0q0UCDGMvYNARCPFqnh
	 VId5pZkdkYU1fylTwtAlaWJeUASkOTCLtfGInJoPCcqKXhrBirs9ePUiuEDK+oT9wM
	 cksDWMU8tHSPrCI5JwMJMEUjiOdw+zYjcAgsS00nQd3esJg4Xm0sJtRz0H2NqJijDP
	 HdO1vCyA4WvbJh9inAPiAyn/REd4k5CBDkI6VtX1IaUEkOTvXLwX12Ulf/bHxHPh1Q
	 eu5qwHrupDL+G70gEHPXsvFWbxczljDOKEjheKK6v15pKJndr8vGrmbdOHwZiKRSa3
	 IlCNyFF2/30eA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Sathya Prakash Veerichetty <sathya.prakash@broadcom.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>,
	kashyap.desai@broadcom.com,
	sumit.saxena@broadcom.com,
	sreekanth.reddy@broadcom.com,
	jejb@linux.ibm.com,
	chandrakanth.patil@broadcom.com,
	mpi3mr-linuxdrv.pdl@broadcom.com,
	linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.8 17/25] scsi: mpi3mr: Avoid memcpy field-spanning write WARNING
Date: Sun,  7 Apr 2024 09:11:05 -0400
Message-ID: <20240407131130.1050321-17-sashal@kernel.org>
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

From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>

[ Upstream commit 429846b4b6ce9853e0d803a2357bb2e55083adf0 ]

When the "storcli2 show" command is executed for eHBA-9600, mpi3mr driver
prints this WARNING message:

  memcpy: detected field-spanning write (size 128) of single field "bsg_reply_buf->reply_buf" at drivers/scsi/mpi3mr/mpi3mr_app.c:1658 (size 1)
  WARNING: CPU: 0 PID: 12760 at drivers/scsi/mpi3mr/mpi3mr_app.c:1658 mpi3mr_bsg_request+0x6b12/0x7f10 [mpi3mr]

The cause of the WARN is 128 bytes memcpy to the 1 byte size array "__u8
replay_buf[1]" in the struct mpi3mr_bsg_in_reply_buf. The array is intended
to be a flexible length array, so the WARN is a false positive.

To suppress the WARN, remove the constant number '1' from the array
declaration and clarify that it has flexible length. Also, adjust the
memory allocation size to match the change.

Suggested-by: Sathya Prakash Veerichetty <sathya.prakash@broadcom.com>
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Link: https://lore.kernel.org/r/20240323084155.166835-1-shinichiro.kawasaki@wdc.com
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/mpi3mr/mpi3mr_app.c    | 2 +-
 include/uapi/scsi/scsi_bsg_mpi3mr.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/mpi3mr/mpi3mr_app.c b/drivers/scsi/mpi3mr/mpi3mr_app.c
index 0380996b5ad27..55d590b919476 100644
--- a/drivers/scsi/mpi3mr/mpi3mr_app.c
+++ b/drivers/scsi/mpi3mr/mpi3mr_app.c
@@ -1644,7 +1644,7 @@ static long mpi3mr_bsg_process_mpt_cmds(struct bsg_job *job)
 	if ((mpirep_offset != 0xFF) &&
 	    drv_bufs[mpirep_offset].bsg_buf_len) {
 		drv_buf_iter = &drv_bufs[mpirep_offset];
-		drv_buf_iter->kern_buf_len = (sizeof(*bsg_reply_buf) - 1 +
+		drv_buf_iter->kern_buf_len = (sizeof(*bsg_reply_buf) +
 					   mrioc->reply_sz);
 		bsg_reply_buf = kzalloc(drv_buf_iter->kern_buf_len, GFP_KERNEL);
 
diff --git a/include/uapi/scsi/scsi_bsg_mpi3mr.h b/include/uapi/scsi/scsi_bsg_mpi3mr.h
index c72ce387286ad..30a5c1a593764 100644
--- a/include/uapi/scsi/scsi_bsg_mpi3mr.h
+++ b/include/uapi/scsi/scsi_bsg_mpi3mr.h
@@ -382,7 +382,7 @@ struct mpi3mr_bsg_in_reply_buf {
 	__u8	mpi_reply_type;
 	__u8	rsvd1;
 	__u16	rsvd2;
-	__u8	reply_buf[1];
+	__u8	reply_buf[];
 };
 
 /**
-- 
2.43.0


