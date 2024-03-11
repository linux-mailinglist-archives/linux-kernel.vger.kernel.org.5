Return-Path: <linux-kernel+bounces-99061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A77858782FF
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 16:16:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9C9A1C2162C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 15:16:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B01F153819;
	Mon, 11 Mar 2024 15:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nH1hc/bm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF5BE535A8;
	Mon, 11 Mar 2024 15:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710169966; cv=none; b=I6/wJBf61qesBTobQgi18VQY/w4hKv1x8z62IULf+8KBHDGYfmOa3ZkjktdkDqvQRxQ/UoTv0zeYXfmAltLA8N5WsE9TQysSA3nla8EQu9I5WRCU09Ntth1A1AeQgK/51O+OgbR5aaNCrMnRcsRa9reyGEcDBh/gUY28h65rT4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710169966; c=relaxed/simple;
	bh=fcYzSLOFq5sMLBWQn8a4zJLsYwI3TPCX+aV1ze6z2EI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZPGjpQjMHlp9Pl1oKk0ZEBOZnj/5cdMEF6XxzkxLzJnXKKx5aIOqJerpR4w2AKGYZQZuKyakB5xJQVcTcc0tpfZ3Dks9SSOZ90+CYc+MiCcFHR/lqAua+e1RQ96d+yqQZia677SJiBjBvj80R9gOIJk5aqwBjEXXSoNLTLabCfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nH1hc/bm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CD7BC433F1;
	Mon, 11 Mar 2024 15:12:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710169965;
	bh=fcYzSLOFq5sMLBWQn8a4zJLsYwI3TPCX+aV1ze6z2EI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nH1hc/bmJYpavXfpK/sJBy5a5aNWd3uTyz9WtvV9t3iu3vtb2S1RWlzsGkeLQHX0q
	 jslO2QS2rDBef+FZbKn9caVU0OMpwJtwSJFQf2eAV3HaRas52lZ+kQEgt1TQhkAMOa
	 gPcqNqEeErmGthRupZ0eBOAoXlTMftEjci7towvDgOWRD6EIAkXfwMusLHvm5I7u54
	 IJEm6j6UeYL8mIV8VSrFV40C1ilnrPtm7xp5cXC0Rfx2WgxfyoS5bBcgJd3lslsMvp
	 7wjxSdUJcBxNdp1D3EZqerFcoJXeXx1nJyE//ZH2ihoOV9rXv5Gn4mA5Y67lB+9k2H
	 REnbj1amZ1iaQ==
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
Subject: [PATCH AUTOSEL 6.7 13/23] scsi: mpt3sas: Prevent sending diag_reset when the controller is ready
Date: Mon, 11 Mar 2024 11:11:53 -0400
Message-ID: <20240311151217.317068-13-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240311151217.317068-1-sashal@kernel.org>
References: <20240311151217.317068-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.9
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


