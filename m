Return-Path: <linux-kernel+bounces-23632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A9B282AF61
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 14:19:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACD0B2860B6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 13:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4EC12943F;
	Thu, 11 Jan 2024 13:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NslUajr5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C58528380;
	Thu, 11 Jan 2024 13:17:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72A99C43601;
	Thu, 11 Jan 2024 13:17:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704979073;
	bh=H6jAa/1qm3fcEGYYR8xZvaYjmIAWKwCFiXdEuAok+aI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NslUajr5yYffmjX0xTHEDPUKXWSepCDuYldFgyWbcAdo6zIEXGqzd6kP91UEd+rSt
	 sU/gFDHsL7z1EQrA8i25sU4Uznxit8SxZles95BNEwRi/0k7zB+CXrYd6e/x2npnwB
	 x4nQfId++/chpiz52ky0VzRiP+7I+p/mNp05AeRHY8CGnNGzj1SnZ0vqd4WT1JsyZN
	 /DJA94SQbwa9YyY+fMZz+GZ70EH3gcUM6+Fjug6lPtPyLQs6YBsHyIt26TN5KD5OXV
	 Gv8d+PvtHKyODKD0crVLUG7REoYcoqxVp/kxQdUK3VCUICVive9EI+w7Ap4R+ns3kP
	 apCZ8OYKBPNEA==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	jejb@linux.ibm.com,
	martin.petersen@oracle.com
Cc: linux-kernel@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	Adaptec OEM Raid Solutions <aacraid@microsemi.com>,
	"PMC-Sierra, Inc" <aacraid@pmc-sierra.com>
Subject: [PATCH 5/5] scsi: aacraid: aachba: Replace snprintf() with the safer scnprintf() variant
Date: Thu, 11 Jan 2024 13:17:26 +0000
Message-ID: <20240111131732.1815560-6-lee@kernel.org>
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
Cc: Adaptec OEM Raid Solutions <aacraid@microsemi.com>
Cc: "PMC-Sierra, Inc" <aacraid@pmc-sierra.com>
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/scsi/aacraid/aachba.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/aacraid/aachba.c b/drivers/scsi/aacraid/aachba.c
index 70e1cac1975eb..b22857c6f3f4f 100644
--- a/drivers/scsi/aacraid/aachba.c
+++ b/drivers/scsi/aacraid/aachba.c
@@ -1099,7 +1099,7 @@ static void get_container_serial_callback(void *context, struct fib * fibptr)
 			sp[0] = INQD_PDT_DA;
 			sp[1] = scsicmd->cmnd[2];
 			sp[2] = 0;
-			sp[3] = snprintf(sp+4, sizeof(sp)-4, "%08X",
+			sp[3] = scnprintf(sp+4, sizeof(sp)-4, "%08X",
 				le32_to_cpu(get_serial_reply->uid));
 			scsi_sg_copy_from_buffer(scsicmd, sp,
 						 sizeof(sp));
@@ -1169,8 +1169,8 @@ static int setinqserial(struct aac_dev *dev, void *data, int cid)
 	/*
 	 *	This breaks array migration.
 	 */
-	return snprintf((char *)(data), sizeof(struct scsi_inq) - 4, "%08X%02X",
-			le32_to_cpu(dev->adapter_info.serial[0]), cid);
+	return scnprintf((char *)(data), sizeof(struct scsi_inq) - 4, "%08X%02X",
+			 le32_to_cpu(dev->adapter_info.serial[0]), cid);
 }
 
 static inline void set_sense(struct sense_data *sense_data, u8 sense_key,
-- 
2.43.0.275.g3460e3d667-goog


