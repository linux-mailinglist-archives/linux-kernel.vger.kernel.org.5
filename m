Return-Path: <linux-kernel+bounces-62661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F94785241F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 01:43:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C0F128230E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 00:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AB80626D6;
	Tue, 13 Feb 2024 00:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n1XSa6Yp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22946626A7;
	Tue, 13 Feb 2024 00:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707783692; cv=none; b=Wv5ui4+GmSVYBm0vm5FjSYsOONvFwLkCoKaZU9SZ8Bu+zN7dEf92nPU4A6rrI4yJ+PzPYGE0kSvYxw7z2HZ0OeV/IF32wZ5YE7UsTZHgfLwXTpZdpduwZk7D1wQAccmLT3vruRM5Wb57w5mObvJaHJgXJhigiEqvypx3fgh+Q94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707783692; c=relaxed/simple;
	bh=D5FmZorhaZefGTlqcT+FkW4aV8RoGBMwO9d0EJXg7IA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pS1y/ZTgAmokAIig5fT3UD+/TKo5z+l8IlyABd8VxB7+clOvQAT7ikvc3dVaJeBhBBWU3qlvwQ7FT16Fd6+AP60y5TxEJsQVArQ9GTjGf/ScOLwsXrktmAbmA9SMjITT88QBxkQ0nRZr3ZcH8mIbvajQkHWEPazqBWPSJwoV2Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n1XSa6Yp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70800C433C7;
	Tue, 13 Feb 2024 00:21:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707783691;
	bh=D5FmZorhaZefGTlqcT+FkW4aV8RoGBMwO9d0EJXg7IA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=n1XSa6YpXi1JQqIBO4OgwzXZ+2SFRNFtCEdwZaJIjTDr1CWEC6LmckwxRO+f1g7s+
	 4YyHp13+gphWi0WaM99KjaBp46oZXF7fvBqqBf4m8yjx0qv2FP/RqvVlXuvPMl+ybl
	 AWBRJwz39rTEJKFrAnfZuAcAdzm1FTFP361jyXAZalGnZKVz2LTl0uto35pXeOMvSL
	 TfxhpepDgHntA0FnQ/dLMxiPt9zZJUQiDU9TQkcVBTg/gfd6LzezDQaJM/aF2GzPx0
	 b2P1h5KALdi1iv443JJOD0xER7tQRH22jscLwCXnGRxVHB5AVQ0LtCL7hb2gT3CuNj
	 mYxLTPBDFOe2g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hannes Reinecke <hare@suse.de>,
	Daniel Wagner <dwagner@suse.de>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>,
	james.smart@broadcom.com,
	dick.kennedy@broadcom.com,
	jejb@linux.ibm.com,
	linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 30/51] scsi: lpfc: Use unsigned type for num_sge
Date: Mon, 12 Feb 2024 19:20:07 -0500
Message-ID: <20240213002052.670571-30-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240213002052.670571-1-sashal@kernel.org>
References: <20240213002052.670571-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.16
Content-Transfer-Encoding: 8bit

From: Hannes Reinecke <hare@suse.de>

[ Upstream commit d6c1b19153f92e95e5e1801d540e98771053afae ]

LUNs going into "failed ready running" state observed on >1T and on even
numbers of size (2T, 4T, 6T, 8T and 10T). The issue occurs when DIF is
enabled at the host.

The kernel logs:

  Cannot setup S/G List for HBAIO segs 1/1 SGL 512 SCSI 256: 3 0

The host lpfc driver is failing to setup scatter/gather list (protection
data) for the I/Os.

The return type lpfc_bg_setup_sgl()/lpfc_bg_setup_sgl_prot() causes the
compiler to remove the most significant bit. Use an unsigned type instead.

Signed-off-by: Hannes Reinecke <hare@suse.de>
[dwagner: added commit message]
Signed-off-by: Daniel Wagner <dwagner@suse.de>
Link: https://lore.kernel.org/r/20231220162658.12392-1-dwagner@suse.de
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/lpfc/lpfc_scsi.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc_scsi.c b/drivers/scsi/lpfc/lpfc_scsi.c
index d26941b131fd..bf879d81846b 100644
--- a/drivers/scsi/lpfc/lpfc_scsi.c
+++ b/drivers/scsi/lpfc/lpfc_scsi.c
@@ -1918,7 +1918,7 @@ lpfc_bg_setup_bpl_prot(struct lpfc_hba *phba, struct scsi_cmnd *sc,
  *
  * Returns the number of SGEs added to the SGL.
  **/
-static int
+static uint32_t
 lpfc_bg_setup_sgl(struct lpfc_hba *phba, struct scsi_cmnd *sc,
 		struct sli4_sge *sgl, int datasegcnt,
 		struct lpfc_io_buf *lpfc_cmd)
@@ -1926,8 +1926,8 @@ lpfc_bg_setup_sgl(struct lpfc_hba *phba, struct scsi_cmnd *sc,
 	struct scatterlist *sgde = NULL; /* s/g data entry */
 	struct sli4_sge_diseed *diseed = NULL;
 	dma_addr_t physaddr;
-	int i = 0, num_sge = 0, status;
-	uint32_t reftag;
+	int i = 0, status;
+	uint32_t reftag, num_sge = 0;
 	uint8_t txop, rxop;
 #ifdef CONFIG_SCSI_LPFC_DEBUG_FS
 	uint32_t rc;
@@ -2099,7 +2099,7 @@ lpfc_bg_setup_sgl(struct lpfc_hba *phba, struct scsi_cmnd *sc,
  *
  * Returns the number of SGEs added to the SGL.
  **/
-static int
+static uint32_t
 lpfc_bg_setup_sgl_prot(struct lpfc_hba *phba, struct scsi_cmnd *sc,
 		struct sli4_sge *sgl, int datacnt, int protcnt,
 		struct lpfc_io_buf *lpfc_cmd)
@@ -2123,8 +2123,8 @@ lpfc_bg_setup_sgl_prot(struct lpfc_hba *phba, struct scsi_cmnd *sc,
 	uint32_t rc;
 #endif
 	uint32_t checking = 1;
-	uint32_t dma_offset = 0;
-	int num_sge = 0, j = 2;
+	uint32_t dma_offset = 0, num_sge = 0;
+	int j = 2;
 	struct sli4_hybrid_sgl *sgl_xtra = NULL;
 
 	sgpe = scsi_prot_sglist(sc);
-- 
2.43.0


