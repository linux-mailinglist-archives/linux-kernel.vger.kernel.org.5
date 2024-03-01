Return-Path: <linux-kernel+bounces-88580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7485586E3AC
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 15:46:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11E2D1F24BCF
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 14:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F188C41E4E;
	Fri,  1 Mar 2024 14:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="cpR+v1Mo"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA64F39AC7;
	Fri,  1 Mar 2024 14:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709304283; cv=none; b=SypqkX9LN+aQndsPG7CDua9uy+TpaGgWmeXQyjN5528+5I8rLqVLVdypIX50Cb9ruYnDgsC2wT6/LjIPsba9DONordMeX5mEmBDfH+VZE5QtAvJ4ssQgxWbHl5hniIEwz45fdkmE+2c3P+HLx+sEYaoGBrzMOpGcDsy/tVnQBKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709304283; c=relaxed/simple;
	bh=qJfz/gwS3bbppBLBLznSkEs8J38LclOY++ed9FAyW4Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rKu5jBLj4s1g8rNVfjO/LvvV9CSRzTThjKNXDSS2+TaS9idtn8nIJyyGqN9Qo3jvm3Ngw3+X+jfhBbnMpkaZNeFbzl7dAt3wRmUrMDfkt3PpppNizkRnNi9rJTAMyygbviwiSrMv1uhXq1s2PuaDDagktczbLDXg2+rSt378+mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=cpR+v1Mo; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1709304279;
	bh=qJfz/gwS3bbppBLBLznSkEs8J38LclOY++ed9FAyW4Q=;
	h=From:To:Cc:Subject:Date:From;
	b=cpR+v1MoxzSyZ6lE2WfINuZwTAYBlrrmfH2fZlwlpqnl3UV5U2zi80Sft1F+wlIza
	 YFi56/dnEPppzFXQYHQZUFdQ1GcGfWZ21JnCZkQU70h9mb/V/4RfMlokhUtpmSc0iV
	 Z+CBGPlKRnOZZ2zpUelWTHlw95mFgjTy9A0dGrBwGBgn38+mBJ/Wqh3aTvvybOEwa/
	 QLXrwa/gH5x+9UMkXBjoQej74zfqIkCUU6E7+5IzNphg0TDoin1J2xf5dU7O1IHZfc
	 zmEfTUhOmCFe8wDZBPJnIl9KJVTbKUoDp+MTUnxR168XTTMOIt8g9KODpWQNuVjrj4
	 D8K9pzwWn5ARg==
Received: from localhost.localdomain (broslavsky.collaboradmins.com [68.183.210.73])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id C580C3782076;
	Fri,  1 Mar 2024 14:44:34 +0000 (UTC)
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
To: James Smart <james.smart@broadcom.com>,
	Dick Kennedy <dick.kennedy@broadcom.com>,
	"James E.J. Bottomley" <jejb@linux.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Hannes Reinecke <hare@suse.com>
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
	kernel@collabora.com,
	kernel-janitors@vger.kernel.org,
	James Smart <jsmart2021@gmail.com>,
	linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: lpfc: correct size for wqe for memset
Date: Fri,  1 Mar 2024 19:44:58 +0500
Message-Id: <20240301144458.2810597-1-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The wqe is of type lpfc_wqe128. It should be memset with the same type.

Fixes: 6c621a2229b0 ("scsi: lpfc: Separate NVMET RQ buffer posting from IO resources SGL/iocbq/context")
Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
 drivers/scsi/lpfc/lpfc_nvmet.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/lpfc/lpfc_nvmet.c b/drivers/scsi/lpfc/lpfc_nvmet.c
index 8258b771bd009..29bc6cd10fd69 100644
--- a/drivers/scsi/lpfc/lpfc_nvmet.c
+++ b/drivers/scsi/lpfc/lpfc_nvmet.c
@@ -1586,7 +1586,7 @@ lpfc_nvmet_setup_io_context(struct lpfc_hba *phba)
 		wqe = &nvmewqe->wqe;
 
 		/* Initialize WQE */
-		memset(wqe, 0, sizeof(union lpfc_wqe));
+		memset(wqe, 0, sizeof(union lpfc_wqe128));
 
 		ctx_buf->iocbq->cmd_dmabuf = NULL;
 		spin_lock(&phba->sli4_hba.sgl_list_lock);
-- 
2.39.2


