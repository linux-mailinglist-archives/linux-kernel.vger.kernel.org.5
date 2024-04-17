Return-Path: <linux-kernel+bounces-148140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CE708A7E37
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 10:28:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 011451F21E05
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 08:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6D0F8061F;
	Wed, 17 Apr 2024 08:27:52 +0000 (UTC)
Received: from mail.nfschina.com (unknown [42.101.60.195])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 88FF36CDA8;
	Wed, 17 Apr 2024 08:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=42.101.60.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713342472; cv=none; b=JSK+vNlQWvp2Mkvj/H3ChGucSEIDh63A52k2+Ac/wWczdoMhjfJZHLB3USI/kAqFzfk7k5xOGcwd4U/wkvikQL6ulPfZ32yH4RJf91ssu2mZ92jPR9NW7SM3/NDzVhVFKaVGRajsKykhnyEHSJ+spkDQcOvzxvIx48S9/eFEWec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713342472; c=relaxed/simple;
	bh=CtQMNvV+gUrG6qOniXmLWrED15xV7xKGBBCUUCjRea8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HXh+V65edHhGcMu9QH448WEVtVMgkUdzm/oE720BmTqMYNGN7ekJe9nMLZzxNkDvRhbXbosEzRgLYZRZANV6j+69DO6p4LHvqDVXR5OOMk3co4jQU4fLLl0tCuVdQVGPcBQ6CcgGfMSSdwGn3xcOgc67voXa4p02uUYq7VYVBhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com; spf=pass smtp.mailfrom=nfschina.com; arc=none smtp.client-ip=42.101.60.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nfschina.com
Received: from localhost.localdomain (unknown [180.167.10.98])
	by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPSA id 8304B6061879B;
	Wed, 17 Apr 2024 16:27:30 +0800 (CST)
X-MD-Sfrom: suhui@nfschina.com
X-MD-SrcIP: 180.167.10.98
From: Su Hui <suhui@nfschina.com>
To: njavali@marvell.com,
	GR-QLogic-Storage-Upstream@marvell.com,
	jejb@linux.ibm.com,
	martin.petersen@oracle.com,
	nathan@kernel.org,
	ndesaulniers@google.com,
	morbo@google.com,
	justinstitt@google.com
Cc: Su Hui <suhui@nfschina.com>,
	rhicksted@marvell.com,
	hare@suse.de,
	himanshu.madhani@oracle.com,
	qutran@marvell.com,
	linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	kernel-janitors@vger.kernel.org
Subject: [PATCH] scsi: qla2xxx: edif: Fix an error code problem in qla24xx_sadb_update()
Date: Wed, 17 Apr 2024 16:27:01 +0800
Message-Id: <20240417082700.2238557-1-suhui@nfschina.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Clang Static Checker (scan-build) Warning:
drivers/scsi/qla2xxx/qla_edif.c:line 1568, column 3
Value stored to 'rval' is never read.

Return the error code rather than zero to dismiss this warning.

Fixes: dd30706e73b7 ("scsi: qla2xxx: edif: Add key update")
Signed-off-by: Su Hui <suhui@nfschina.com>
---
 drivers/scsi/qla2xxx/qla_edif.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/qla2xxx/qla_edif.c b/drivers/scsi/qla2xxx/qla_edif.c
index dcde55c8ee5d..6f1aac36a144 100644
--- a/drivers/scsi/qla2xxx/qla_edif.c
+++ b/drivers/scsi/qla2xxx/qla_edif.c
@@ -1836,7 +1836,7 @@ qla24xx_sadb_update(struct bsg_job *bsg_job)
 	bsg_job_done(bsg_job, bsg_reply->result,
 	    bsg_reply->reply_payload_rcv_len);
 
-	return 0;
+	return rval;
 }
 
 static void
-- 
2.30.2


