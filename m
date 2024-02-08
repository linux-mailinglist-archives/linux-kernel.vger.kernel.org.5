Return-Path: <linux-kernel+bounces-57649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C547D84DBC9
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 09:48:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8472D284F2D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 08:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FBBA6F08A;
	Thu,  8 Feb 2024 08:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j4F5tGSr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B786D1AA;
	Thu,  8 Feb 2024 08:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707381927; cv=none; b=gOj0INfpeSWwWToc24QmiiDLry8NlBiAQEY9hMeaBwKD3OKIJBil3JSbgy/7dYKYO8p/dEziCugKyqpMUkwcuK2tGUU9FZapljN+uUpUa5voYuvApDVyWFdClDtP4W3/GrnGQSy1myvwmfeKRfYLb+/Zscj92ewnAQbe5nlIai4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707381927; c=relaxed/simple;
	bh=kPQEC7JNk1nG41qzG8wfP+IddSOveAbpNnPvKYhI/4o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DmON6N66CxrLyQPExgsS1GkXVS0XCKK33xy4iG8FEYdtMLpnT+vEytHQK9GHTkPBvhvGcHriXJL+qaOI10BvgQQFnoBnL0VsJTMeAUSxzTzLUcvCNgM6Pna2RgERmqAvpCItbmFMDWy+4q6lECHYZs8u565QrL0GpOWYnN8zK6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j4F5tGSr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B7CAC43142;
	Thu,  8 Feb 2024 08:45:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707381927;
	bh=kPQEC7JNk1nG41qzG8wfP+IddSOveAbpNnPvKYhI/4o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=j4F5tGSrD6ALzwj7JwdKg6N+UE+nGeZW0wCkS9VI3EkJV0qqDGxmuGDBKLgCPQXMK
	 iXxeiPa/3/f5uaaaYz5302sabTiuOhOzBQ3WAaWPU5L3nrmQ7mLMjgeE5b6/rSNHZg
	 iOBrDaxlgdQvVyy39RRyZJxP7KnzZULipwN0HI4I836QMXbIwPxkcnvyE3dMNuAKcv
	 /N26Y1C+rCx8iia2dw6Yw1F7QLX21WKuKtqvIEz7S8E7EIR6k7+GxMV4cUwMjHV3Hw
	 MG2SyFuKMKPvNh/hYb4GI3gdbqqybdhXR1QuIXORcwlsinZAWiR9G7QXQ+uigjISdb
	 7dioSC5x11JAg==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	Finn Thain <fthain@linux-m68k.org>,
	Michael Schmitz <schmitzmic@gmail.com>,
	"James E.J. Bottomley" <jejb@linux.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	drew@colorado.edu,
	Tnx to <Thomas_Roesch@m2.maus.de>,
	linux-scsi@vger.kernel.org
Subject: [PATCH 03/10] scsi: NCR5380: Replace snprintf() with the safer scnprintf() variant
Date: Thu,  8 Feb 2024 08:44:15 +0000
Message-ID: <20240208084512.3803250-4-lee@kernel.org>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
In-Reply-To: <20240208084512.3803250-1-lee@kernel.org>
References: <20240208084512.3803250-1-lee@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is a general misunderstanding amongst engineers that {v}snprintf()
returns the length of the data *actually* encoded into the destination
array.  However, as per the C99 standard {v}snprintf() really returns
the length of the data that *would have been* written if there were
enough space for it.  This misunderstanding has led to buffer-overruns
in the past.  It's generally considered safer to use the {v}scnprintf()
variants in their place (or even sprintf() in simple cases).  So let's
do that.

Link: https://lwn.net/Articles/69419/
Link: https://github.com/KSPP/linux/issues/105
Signed-off-by: Lee Jones <lee@kernel.org>
---
Cc: Finn Thain <fthain@linux-m68k.org>
Cc: Michael Schmitz <schmitzmic@gmail.com>
Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: drew@colorado.edu
Cc: Tnx to <Thomas_Roesch@m2.maus.de>
Cc: linux-scsi@vger.kernel.org
---
 drivers/scsi/NCR5380.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/scsi/NCR5380.c b/drivers/scsi/NCR5380.c
index cea3a79d538e4..ea565e843c765 100644
--- a/drivers/scsi/NCR5380.c
+++ b/drivers/scsi/NCR5380.c
@@ -421,14 +421,14 @@ static int NCR5380_init(struct Scsi_Host *instance, int flags)
 	if (!hostdata->work_q)
 		return -ENOMEM;
 
-	snprintf(hostdata->info, sizeof(hostdata->info),
-		"%s, irq %d, io_port 0x%lx, base 0x%lx, can_queue %d, cmd_per_lun %d, sg_tablesize %d, this_id %d, flags { %s%s%s}",
-		instance->hostt->name, instance->irq, hostdata->io_port,
-		hostdata->base, instance->can_queue, instance->cmd_per_lun,
-		instance->sg_tablesize, instance->this_id,
-		hostdata->flags & FLAG_DMA_FIXUP     ? "DMA_FIXUP "     : "",
-		hostdata->flags & FLAG_NO_PSEUDO_DMA ? "NO_PSEUDO_DMA " : "",
-		hostdata->flags & FLAG_TOSHIBA_DELAY ? "TOSHIBA_DELAY " : "");
+	scnprintf(hostdata->info, sizeof(hostdata->info),
+		 "%s, irq %d, io_port 0x%lx, base 0x%lx, can_queue %d, cmd_per_lun %d, sg_tablesize %d, this_id %d, flags { %s%s%s}",
+		 instance->hostt->name, instance->irq, hostdata->io_port,
+		 hostdata->base, instance->can_queue, instance->cmd_per_lun,
+		 instance->sg_tablesize, instance->this_id,
+		 hostdata->flags & FLAG_DMA_FIXUP     ? "DMA_FIXUP "     : "",
+		 hostdata->flags & FLAG_NO_PSEUDO_DMA ? "NO_PSEUDO_DMA " : "",
+		 hostdata->flags & FLAG_TOSHIBA_DELAY ? "TOSHIBA_DELAY " : "");
 
 	NCR5380_write(INITIATOR_COMMAND_REG, ICR_BASE);
 	NCR5380_write(MODE_REG, MR_BASE);
-- 
2.43.0.594.gd9cf4e227d-goog


