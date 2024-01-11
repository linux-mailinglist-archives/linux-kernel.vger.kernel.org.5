Return-Path: <linux-kernel+bounces-23629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FB1E82AF5B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 14:18:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E1BDAB2278A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 13:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB02F17731;
	Thu, 11 Jan 2024 13:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K5zV6KKp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 443CB171DB;
	Thu, 11 Jan 2024 13:17:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55EDDC4166C;
	Thu, 11 Jan 2024 13:17:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704979066;
	bh=XJLd71FQv73RyiqjOnHemTblVqGG3FFf8Ltz19KUFnM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K5zV6KKpmN1BAubJtjMPYG0wmQDhPp7ZhFNwdBDDUf9/BUcBXkewRpfL/tM9MT4s5
	 EZYq29LaismkTeSByQeVK06bmxVSwwuclmkN8sGlVX+Z6GKa2ulG5dbTVPvA2TgafO
	 EM+nBRfYJoaLFcoC2DLoUhZnm2PTDYvRkuOuPv0MFr/937EjDU2GUa8/tawlxVU+js
	 k5Qr/74M6RtPyZeWljvp4SH901KMGZFJuNryOe2wf+fsHkQu2bBx5Q3PPgBD7SVIgF
	 KW7ZM9qVOIgn9kRkHTaHYGU9/cpjBpq/Uj/+xOfsOHR41aT03HiTIsYpxrl75Nz+q3
	 7VY7OPfXmeMQA==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	jejb@linux.ibm.com,
	martin.petersen@oracle.com
Cc: linux-kernel@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	Adam Radford <aradford@gmail.com>
Subject: [PATCH 2/5] scsi: 3w-sas: Remove snprintf() from sysfs call-backs and replace with sysfs_emit()
Date: Thu, 11 Jan 2024 13:17:23 +0000
Message-ID: <20240111131732.1815560-3-lee@kernel.org>
X-Mailer: git-send-email 2.43.0.275.g3460e3d667-goog
In-Reply-To: <20240111131732.1815560-1-lee@kernel.org>
References: <20240111131732.1815560-1-lee@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since snprintf() has the documented, but still rather strange trait of
returning the length of the data that *would have been* written to the
array if space were available, rather than the arguably more useful
length of data *actually* written, it is usually considered wise to use
something else instead in order to avoid confusion.

In the case of sysfs call-backs, new wrappers exist that do just that.

Link: https://lwn.net/Articles/69419/
Link: https://github.com/KSPP/linux/issues/105
Cc: Adam Radford <aradford@gmail.com>
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/scsi/3w-sas.c | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/scsi/3w-sas.c b/drivers/scsi/3w-sas.c
index 9bdb75dfdcd7c..caa6713a62a44 100644
--- a/drivers/scsi/3w-sas.c
+++ b/drivers/scsi/3w-sas.c
@@ -166,24 +166,24 @@ static ssize_t twl_show_stats(struct device *dev,
 	ssize_t len;
 
 	spin_lock_irqsave(tw_dev->host->host_lock, flags);
-	len = snprintf(buf, PAGE_SIZE, "3w-sas Driver version: %s\n"
-		       "Current commands posted:   %4d\n"
-		       "Max commands posted:       %4d\n"
-		       "Last sgl length:           %4d\n"
-		       "Max sgl length:            %4d\n"
-		       "Last sector count:         %4d\n"
-		       "Max sector count:          %4d\n"
-		       "SCSI Host Resets:          %4d\n"
-		       "AEN's:                     %4d\n",
-		       TW_DRIVER_VERSION,
-		       tw_dev->posted_request_count,
-		       tw_dev->max_posted_request_count,
-		       tw_dev->sgl_entries,
-		       tw_dev->max_sgl_entries,
-		       tw_dev->sector_count,
-		       tw_dev->max_sector_count,
-		       tw_dev->num_resets,
-		       tw_dev->aen_count);
+	len = sysfs_emit(buf, "3w-sas Driver version: %s\n"
+			 "Current commands posted:   %4d\n"
+			 "Max commands posted:       %4d\n"
+			 "Last sgl length:           %4d\n"
+			 "Max sgl length:            %4d\n"
+			 "Last sector count:         %4d\n"
+			 "Max sector count:          %4d\n"
+			 "SCSI Host Resets:          %4d\n"
+			 "AEN's:                     %4d\n",
+			 TW_DRIVER_VERSION,
+			 tw_dev->posted_request_count,
+			 tw_dev->max_posted_request_count,
+			 tw_dev->sgl_entries,
+			 tw_dev->max_sgl_entries,
+			 tw_dev->sector_count,
+			 tw_dev->max_sector_count,
+			 tw_dev->num_resets,
+			 tw_dev->aen_count);
 	spin_unlock_irqrestore(tw_dev->host->host_lock, flags);
 	return len;
 } /* End twl_show_stats() */
-- 
2.43.0.275.g3460e3d667-goog


