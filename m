Return-Path: <linux-kernel+bounces-57652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C22484DBD0
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 09:49:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E8C01C24E9E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 08:49:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BD4B71B5A;
	Thu,  8 Feb 2024 08:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JYv3wWWf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DC7371B4D;
	Thu,  8 Feb 2024 08:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707381933; cv=none; b=mBW3B3d6pI8fMVCqMGsEJ1yCBoWlnRRpAhNhmUckW6SKupjNUijJkYQxxs39wFTbEFdyitu/mLXzWpCxKKlsk7uwoXybugGl/0xrnX8Rb2jRCG2hcjfldQEREL4NdFwbK4iihNJ4WiFjD9c+gpicmKEgotfOD9xJ2VLKEtRJx5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707381933; c=relaxed/simple;
	bh=PbzPd7ROc5va5PvBniGi9yT6iZxcViGR7FsGtUiYZPQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ax340BOOpImeQx4RMtE5KZ8gORbhvmtEyCceuXWAQwz3GV7QtcS30zAWS+bcRwBA5XxycrFrx15NGfQn+J5vBYHk+TDHnePeltwPi1rdUfYYr1ZqmmbiKz9P3eYhzaqEmtjPrdyiUiG2gb9k7RacFeGdEGDdUh2zy8MvBFhXLJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JYv3wWWf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECCBEC43394;
	Thu,  8 Feb 2024 08:45:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707381932;
	bh=PbzPd7ROc5va5PvBniGi9yT6iZxcViGR7FsGtUiYZPQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JYv3wWWfitgg/S4wiWCNHUkrl6YEq7UHvBTMANfUjrWE6exn3/m3eE4TUhkWPXN+Y
	 rRCC2FVaAkQZqV1mHCuFnaHh1E4JzU8l38xR/iT/qXy3v/vrN2OxQVG3lrZhMJjvCx
	 o4T+oxyev2+cxar+vWyjTi6fPg7ODFt8JIJFQLVx0HGBORpVmo99miUmNAWAEXz00J
	 mMdCOBIQwXoI84M6/sfhzlFbrNwoOdvX9cGpijg9bbVq5vEsPeuulOXxkJeOp03YD5
	 OMN6+cLmOLws/InUorErs1VlC3zfGGKrspeOEalGaY6iN4L2ycp8QkTyggjGOJ6JbQ
	 S9VvuxHfX7/Ug==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	"James E.J. Bottomley" <jejb@linux.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-scsi@vger.kernel.org
Subject: [PATCH 06/10] scsi: aha1542: Replace snprintf() with the safer scnprintf() variant
Date: Thu,  8 Feb 2024 08:44:18 +0000
Message-ID: <20240208084512.3803250-7-lee@kernel.org>
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
Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org
---
 drivers/scsi/aha1542.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/aha1542.c b/drivers/scsi/aha1542.c
index 9503996c63256..b5ec7887801a5 100644
--- a/drivers/scsi/aha1542.c
+++ b/drivers/scsi/aha1542.c
@@ -772,7 +772,7 @@ static struct Scsi_Host *aha1542_hw_init(const struct scsi_host_template *tpnt,
 		goto unregister;
 
 	if (sh->dma_channel != 0xFF)
-		snprintf(dma_info, sizeof(dma_info), "DMA %d", sh->dma_channel);
+		scnprintf(dma_info, sizeof(dma_info), "DMA %d", sh->dma_channel);
 	shost_printk(KERN_INFO, sh, "Adaptec AHA-1542 (SCSI-ID %d) at IO 0x%x, IRQ %d, %s\n",
 				sh->this_id, base_io, sh->irq, dma_info);
 	if (aha1542->bios_translation == BIOS_TRANSLATION_25563)
-- 
2.43.0.594.gd9cf4e227d-goog


