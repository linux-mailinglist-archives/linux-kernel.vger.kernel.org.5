Return-Path: <linux-kernel+bounces-23630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0764382AF5D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 14:18:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C7B61C22E8F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 13:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AB611798D;
	Thu, 11 Jan 2024 13:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rJKft9gx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A373417752;
	Thu, 11 Jan 2024 13:17:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32B0AC41606;
	Thu, 11 Jan 2024 13:17:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704979069;
	bh=3DYVdyB50Ylc2Qxe9BWxLuvcVZRrn+c0FMmqUAOKf2E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rJKft9gx0/soSQGbtzOl1/IXYFF3UaKx/HP2arIXg1tyW6u6oPJQoQzsXyTagTBpM
	 tyPIx6D7sw1iCziXfxTwMCFOaK8YQGIYCJH3px7YFRNTybv25iBykMTmKQPQtfAonC
	 gbS713Aj3GF6LJV4tlrCNDGDu5h508WFLpA1g7xFlnhpkqP/fILSjdn3btBn9q9jUR
	 FykDmyJ2Ok/ITeU89OBImmySPjlq/u2bGZkQKEfJroKJppNTNcdlSWlxWzr6KeVL+D
	 5A8xssE/YwVlsUfhsIV/tEhRgEXbd5252bjno2Y3pxHFbMBqJsN/kOYf4khPC5M8nR
	 bDtkCkKBjL5nQ==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	jejb@linux.ibm.com,
	martin.petersen@oracle.com
Cc: linux-kernel@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	Adam Radford <aradford@gmail.com>,
	Joel Jacobson <linux@3ware.com>,
	de Melo <acme@conectiva.com.br>,
	Andre Hedrick <andre@suse.com>
Subject: [PATCH 3/5] scsi: 3w-xxxx: Remove snprintf() from sysfs call-backs and replace with sysfs_emit()
Date: Thu, 11 Jan 2024 13:17:24 +0000
Message-ID: <20240111131732.1815560-4-lee@kernel.org>
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
Cc: Joel Jacobson <linux@3ware.com>
Cc: de Melo <acme@conectiva.com.br>
Cc: Andre Hedrick <andre@suse.com>
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/scsi/3w-xxxx.c | 46 +++++++++++++++++++++---------------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/drivers/scsi/3w-xxxx.c b/drivers/scsi/3w-xxxx.c
index f39c9ec2e7810..13ddc97f5a623 100644
--- a/drivers/scsi/3w-xxxx.c
+++ b/drivers/scsi/3w-xxxx.c
@@ -496,28 +496,28 @@ static ssize_t tw_show_stats(struct device *dev, struct device_attribute *attr,
 	ssize_t len;
 
 	spin_lock_irqsave(tw_dev->host->host_lock, flags);
-	len = snprintf(buf, PAGE_SIZE, "3w-xxxx Driver version: %s\n"
-		       "Current commands posted:   %4d\n"
-		       "Max commands posted:       %4d\n"
-		       "Current pending commands:  %4d\n"
-		       "Max pending commands:      %4d\n"
-		       "Last sgl length:           %4d\n"
-		       "Max sgl length:            %4d\n"
-		       "Last sector count:         %4d\n"
-		       "Max sector count:          %4d\n"
-		       "SCSI Host Resets:          %4d\n"
-		       "AEN's:                     %4d\n", 
-		       TW_DRIVER_VERSION,
-		       tw_dev->posted_request_count,
-		       tw_dev->max_posted_request_count,
-		       tw_dev->pending_request_count,
-		       tw_dev->max_pending_request_count,
-		       tw_dev->sgl_entries,
-		       tw_dev->max_sgl_entries,
-		       tw_dev->sector_count,
-		       tw_dev->max_sector_count,
-		       tw_dev->num_resets,
-		       tw_dev->aen_count);
+	len = sysfs_emit(buf, "3w-xxxx Driver version: %s\n"
+			 "Current commands posted:   %4d\n"
+			 "Max commands posted:       %4d\n"
+			 "Current pending commands:  %4d\n"
+			 "Max pending commands:      %4d\n"
+			 "Last sgl length:           %4d\n"
+			 "Max sgl length:            %4d\n"
+			 "Last sector count:         %4d\n"
+			 "Max sector count:          %4d\n"
+			 "SCSI Host Resets:          %4d\n"
+			 "AEN's:                     %4d\n",
+			 TW_DRIVER_VERSION,
+			 tw_dev->posted_request_count,
+			 tw_dev->max_posted_request_count,
+			 tw_dev->pending_request_count,
+			 tw_dev->max_pending_request_count,
+			 tw_dev->sgl_entries,
+			 tw_dev->max_sgl_entries,
+			 tw_dev->sector_count,
+			 tw_dev->max_sector_count,
+			 tw_dev->num_resets,
+			 tw_dev->aen_count);
 	spin_unlock_irqrestore(tw_dev->host->host_lock, flags);
 	return len;
 } /* End tw_show_stats() */
@@ -1099,7 +1099,7 @@ static int tw_initconnection(TW_Device_Extension *tw_dev, int message_credits)
 	command_packet->request_id = request_id;
 	command_packet->status = 0x0;
 	command_packet->flags = 0x0;
-	command_packet->byte6.message_credits = message_credits; 
+	command_packet->byte6.message_credits = message_credits;
 	command_packet->byte8.init_connection.response_queue_pointer = 0x0;
 	command_que_value = tw_dev->command_packet_physical_address[request_id];
 
-- 
2.43.0.275.g3460e3d667-goog


