Return-Path: <linux-kernel+bounces-114044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01C18888F27
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:38:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3326D1C2B63E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A34422EADF;
	Sun, 24 Mar 2024 23:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZJK+x1oC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A9E12FF7F;
	Sun, 24 Mar 2024 23:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321327; cv=none; b=FvadXKV/N0N1mMfGAmAU0ZLlFAEHQcPjfKGuk9RlvPu7iK0FLr6CvnwJ2UJB3ZlCA0s5HWP7pGACEPM9iDZPHxpo5BLb7Uj59eAZf8CJqHoPCHAjb4kOtduwISFBLdZcz3I5KuWWcayXNR6N51GBniurWX241S8CNBt6oH0MCYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321327; c=relaxed/simple;
	bh=fcYzSLOFq5sMLBWQn8a4zJLsYwI3TPCX+aV1ze6z2EI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BYNR0GUsBzPCikkEYHnV3mMXLukor+gu7hZaFpwjrRDEa8dCyzOVkEGjKRfaTxUEfU7OT2UtUPW4J/UeS17BinLwnAspHg5L8QhSGsyxqxthg39xPARcEHrmWHG7sqBBAtMdVnEzgTcz8ueF/lb1oFyRp73f8bkFTYb1oTYryJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZJK+x1oC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6117AC43390;
	Sun, 24 Mar 2024 23:02:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321326;
	bh=fcYzSLOFq5sMLBWQn8a4zJLsYwI3TPCX+aV1ze6z2EI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZJK+x1oC7CEezlg9py5FyNwuUIFFheHfPzzwY/CuqtkISqZDlkCHWI/+iVEtrdKXE
	 7P7jqkvdhkzExluMPUyj4pfeoAnQ9kayEQcZSHz8y70Gsm6hev2IVIaQL3uVNXkOtM
	 S2rW1uAq7SKl3CDPPMvUSgDX6DHFKP8OqlOSa7UMGIY4pa7QO0sfMsgvbQFna/j3wB
	 SPPYX0s5WX9Gk1q/KMntVBZoRwEhb9nBtKfTcxspQlMH9T3A9SP9Ha2OoC43Qn0pSu
	 nagKNFs7RqRBv754/lg0FPsIwKN/o3UOPHA2V2z8YROqIUSZpnYuvYTB5MfS2uYETl
	 p7u7ipWXLxsPQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ranjan Kumar <ranjan.kumar@broadcom.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 049/638] scsi: mpt3sas: Prevent sending diag_reset when the controller is ready
Date: Sun, 24 Mar 2024 18:51:26 -0400
Message-ID: <20240324230116.1348576-50-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
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
index a75f670bf5519..aa29e250cf15f 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_base.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_base.c
@@ -7387,7 +7387,9 @@ _base_wait_for_iocstate(struct MPT3SAS_ADAPTER *ioc, int timeout)
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


