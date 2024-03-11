Return-Path: <linux-kernel+bounces-99082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AA2E87833D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 16:22:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F35F1F272DA
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 15:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A23275F579;
	Mon, 11 Mar 2024 15:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sj2YDuPg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFA935F486;
	Mon, 11 Mar 2024 15:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710170009; cv=none; b=dyj5oeLtQmiJryPWdV8BJMpiNcbHaXo1liJuGE/bjj3AjoBZiiiyLsukASlcE4NWPQi7ivVsjbs3rbKcUs5z/1q7DPjR4TAbXYXwfXmdHDd/P7H/yJGsDuzMh4CCmLehiAwqd2saFZ+WN24ozATD8ZBDp6ux1SwNIF9XQ/scbQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710170009; c=relaxed/simple;
	bh=fcYzSLOFq5sMLBWQn8a4zJLsYwI3TPCX+aV1ze6z2EI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZOTCsd5dpZ2nWQLDwA2Maa+pheMjqY0fIIunSgYHWlzZzAVpSAVV761WOoca3FQVzZqfw5Mqk2f5dBh9ft8rH/71madNuDYvEIOf8xOSpT2dyNcLSaAlvHSHB1kU166w9g45gCatORWRhg98uHwtI5PbBVVtz3lN0lCHOpWiOII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sj2YDuPg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EE79C4166B;
	Mon, 11 Mar 2024 15:13:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710170008;
	bh=fcYzSLOFq5sMLBWQn8a4zJLsYwI3TPCX+aV1ze6z2EI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Sj2YDuPg8HFa0cGq19wTZOhq6jhNEaYBRFY/OMTcnKAluLJE0wLlV+BmT3DTtqVd2
	 0ilJsRvDiVtc3zkeIrdqQAkeHrA+MfH47nS/sdvwjS3bQhKEBsVn+uMNgdfzP2MREB
	 Mz1txhpJP0rz1GsBSmwidsYQpMyLBbd4Q15XdhWHY9JaIaaaeF/Pzj2TPiUo4zpoGG
	 uyS7pTBtsa833L/ac0a0qqyYZjwdSObYVJBgLH+QTgl7NlNzsxnW4omlCjCJUY4dR9
	 PAKbF7cLJQlz82KWN1dOWLhTktzUlJ8ra1YfuBfaX8JI5DSQ/h2ii05/gf8aQ5y7O9
	 OAu9EE0z4hrpQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ranjan Kumar <ranjan.kumar@broadcom.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>,
	sathya.prakash@broadcom.com,
	sreekanth.reddy@broadcom.com,
	suganath-prabu.subramani@broadcom.com,
	jejb@linux.ibm.com,
	MPT-FusionLinux.pdl@broadcom.com,
	linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 08/17] scsi: mpt3sas: Prevent sending diag_reset when the controller is ready
Date: Mon, 11 Mar 2024 11:12:59 -0400
Message-ID: <20240311151314.317776-8-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240311151314.317776-1-sashal@kernel.org>
References: <20240311151314.317776-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.21
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


