Return-Path: <linux-kernel+bounces-27949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 729E482F836
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 21:40:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B1031C24626
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 20:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0888412EE75;
	Tue, 16 Jan 2024 19:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nq3qY44f"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B08574AB;
	Tue, 16 Jan 2024 19:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705434641; cv=none; b=laCeA/kbhWMNE65J+XGQQs6BLsP+pqbbEw+OEBVCz81OHP2Bj4snNxGGDQDH+gdSdxUP0wtRvm+PHGteecFN+t6CaWW/KrSd6nViX4rsXEnnRscy/dr0cvF4VFAoO23adrGD5Q5go9vCfCr50aic6wBl31s+BiOhisA20oajoek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705434641; c=relaxed/simple;
	bh=ucOR01tQxbSQYvNkQ21i1Zn9JGJ1tZOEd/21cZ/km/A=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=CqHjvbvc492w3EIn6CBWAsmeI8GkhX9ybH6N/waIwgNzZQTjGUA/hIKT8WJsEHJ8xOIxOjXEz9TKUEbfnuQUUFEEaE8+KrCFCq3yElYsOc/qie24Kwmd1cRiGyTl3f7lUi0I5R/fNwSeNDeyXr77yLRoD27EGntCnm+Fo4L20OE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nq3qY44f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 455BEC433C7;
	Tue, 16 Jan 2024 19:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705434641;
	bh=ucOR01tQxbSQYvNkQ21i1Zn9JGJ1tZOEd/21cZ/km/A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nq3qY44fe/dg8K2sOJGnqSvOkeOX82c4ifuU+OATEeQ0ASx0BUPFISJ27qDfXfiO3
	 RQewoPqyWbTT7XO7a8SqKa3gIQAHRfisuw+0/DNz6x4LMjqY/67fuXraE+zVdsDRzN
	 G9B/Pjw+FwtfLBg5DEEbyWvlwu/ds8XPIEUdlR9cU/dl9/haF0k990tmJVpni1ZtIG
	 EY9wgmI65jUlE1gOBFj9JVPJExpuJ6u9OtESSr6/nSoU8+oHNiVp8++qifmtpNJteT
	 AaUhkGxltiUhoYhMqrmslC3Oqk7pehz2N3d0PK2D82fCRXJkmVQRwBQmgcKwDOMQeb
	 Ca+S7y3xoJ/9Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hannes Reinecke <hare@suse.de>,
	Christoph Hellwig <hch@lst.de>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>,
	jejb@linux.ibm.com,
	linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 041/104] scsi: libfc: Fix up timeout error in fc_fcp_rec_error()
Date: Tue, 16 Jan 2024 14:46:07 -0500
Message-ID: <20240116194908.253437-41-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116194908.253437-1-sashal@kernel.org>
References: <20240116194908.253437-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.12
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
index 3f189cedf6db..05be0810b5e3 100644
--- a/drivers/scsi/libfc/fc_fcp.c
+++ b/drivers/scsi/libfc/fc_fcp.c
@@ -1676,7 +1676,7 @@ static void fc_fcp_rec_error(struct fc_fcp_pkt *fsp, struct fc_frame *fp)
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


