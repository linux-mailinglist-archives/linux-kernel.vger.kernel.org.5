Return-Path: <linux-kernel+bounces-116234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 41FEC88A477
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:28:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5FD67B2BDB6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 026D417F209;
	Mon, 25 Mar 2024 03:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uwwfoyPH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 664E917EB98;
	Sun, 24 Mar 2024 23:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324014; cv=none; b=ZOV5URQ6pSJgqH+XHjOKDQ6CE+/mPQYpMiOzpHoduHCemts04ZdfmaM759MKZhKcXhvJPXc1oUDRhJXYqRCXEEbG/7TkkxHaTceFMGSh9YnvxS+cTpZDecY3tpIepNx0zxyhhzmyY8vyYrSIoZJrZt0mQlHZLyqWf+LedlX7gPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324014; c=relaxed/simple;
	bh=LE8jwGkMU5Hm6hrhMTyPiG6zSNHB4RBSwMNNmbZ1gpw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pGkM5zOPyUFu6uiV/HKxITgrc2oT9TsLKFPJZVayca7y0d+fX/e49QFtvDsCJecLwwjFcOWOqCgxp/uMlOKEFjdf2Yav/cmP/Bof7zdBAxrnwO98MJRTnTME5CZxRd0vRembHmQXl0ad9OE3hhjnckD/pqt2xZ/bK3XWEfmPJTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uwwfoyPH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1575C433F1;
	Sun, 24 Mar 2024 23:46:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324013;
	bh=LE8jwGkMU5Hm6hrhMTyPiG6zSNHB4RBSwMNNmbZ1gpw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uwwfoyPHZm4vs8QJCizq/lNFlOy3B+A66U+x9pNNW+3XBhwnxyebR7oQbBoC0YNJE
	 DHPpRpRleEI59QRNv9yAHI5wusj6tB6LIK6v5mMtoikpnOLZkWFsoGASmMCeHIkvQt
	 rQ+C4tSf2N9zWahF8xETxYlzzSOJbJ4Y1u/lPNRizZskYgJDriO+pDxLP96ErGwV07
	 6iHV8JsvLci1or88fmscAke8J9FnsNrcLc5QeSuWFsd+sKY0M/aZK2otHFzTUe2l9L
	 HiCO9cPbHkd89qtwWWbMZOGeJU5YrGZWTIbMHZRWCZSCEoSmhZVauT+bBm0ze6+cOn
	 SfcXxyOc/68NQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ranjan Kumar <ranjan.kumar@broadcom.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 014/183] scsi: mpt3sas: Prevent sending diag_reset when the controller is ready
Date: Sun, 24 Mar 2024 19:43:47 -0400
Message-ID: <20240324234638.1355609-15-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234638.1355609-1-sashal@kernel.org>
References: <20240324234638.1355609-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Ranjan Kumar <ranjan.kumar@broadcom.com>

[ Upstream commit ee0017c3ed8a8abfa4d40e42f908fb38c31e7515 ]

If the driver detects that the controller is not ready before sending the
first IOC facts command, it will wait for a maximum of 10 seconds for it to
become ready. However, even if the controller becomes ready within 10
seconds, the driver will still issue a diagnostic reset.

Modify the driver to avoid sending a diag reset if the controller becomes
ready within the 10-second wait time.

Signed-off-by: Ranjan Kumar <ranjan.kumar@broadcom.com>
Link: https://lore.kernel.org/r/20240221071724.14986-1-ranjan.kumar@broadcom.com
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/mpt3sas/mpt3sas_base.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/mpt3sas/mpt3sas_base.c b/drivers/scsi/mpt3sas/mpt3sas_base.c
index e72f1dbc91f7f..04fa7337cb1ef 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_base.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_base.c
@@ -6040,7 +6040,9 @@ _base_wait_for_iocstate(struct MPT3SAS_ADAPTER *ioc, int timeout)
 		return -EFAULT;
 	}
 
- issue_diag_reset:
+	return 0;
+
+issue_diag_reset:
 	rc = _base_diag_reset(ioc);
 	return rc;
 }
-- 
2.43.0


