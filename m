Return-Path: <linux-kernel+bounces-99110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2AB887838B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 16:28:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CA99284C9A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 15:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF9FB66B56;
	Mon, 11 Mar 2024 15:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cE5SyNdQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07D8C66B51;
	Mon, 11 Mar 2024 15:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710170081; cv=none; b=VDC11Jd0Lbj5KqyPObI1Rlc1zm4LHftTPd5+ERzfHxpSCVGsRq6WlkCCX4/UDFVRR3ep3pVRHy8WeFb61fszjxihWZItx7jwB8PSymFNlEK9BN/+9bXplZ4EpcIRRruUSqsA9MdRjJ5E/2pTgfbe5ajwckOBgJW/lEGGLCfQYGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710170081; c=relaxed/simple;
	bh=f2qTjhmMz1jFyOTLwRJOYcWLeZ31+lsP1caQS8kVENw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VzubTO+rlWxQ3g4d+Eml5+8BK/NUPkdJnWslrzTyfFuLnUz5RcP9rVqCrFSdsB8Bb/XvOdAPOgtMLpvIFM4OvsOVMUxUi74Rbi8xL7B9adAxlJrP80z7BBJZ+i6anTkloEvC2QszcJBLu37DqqwJcLN1yhGaK1oeJm5ha3XZ5/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cE5SyNdQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8EA7C43601;
	Mon, 11 Mar 2024 15:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710170080;
	bh=f2qTjhmMz1jFyOTLwRJOYcWLeZ31+lsP1caQS8kVENw=;
	h=From:To:Cc:Subject:Date:From;
	b=cE5SyNdQ/kHA8PkuCgoZytqmvswBD6gsPK3414vQ2ysPSrXe5f0JF4Ucb1A6OR+lI
	 6Rc91Xj8sU3QoRhlXZwUuSt1vu7CZ1pE/I9nv1MLAclq9nO7R3JK03Oj4Xr36xdRhL
	 x5AC6ZTpEsH1U/pil5FvuXeMUqaNeJ6ZUnHt5fqVBLtjcFn1VAUvIjiIdmUU02L+oC
	 xbIYLiidwUZJdSDjie9cViMb374NTSFPYYQqrmFU2f5At2dMZNP8yxM/nipdyC11mZ
	 1ot7i9SnHoLsGza4K0RKD6OeCjOWgN8IbrpQcl09bjV71En7mJuys286yRaw+qfpPh
	 +By35+YnywbVQ==
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
Subject: [PATCH AUTOSEL 5.10 1/3] scsi: mpt3sas: Prevent sending diag_reset when the controller is ready
Date: Mon, 11 Mar 2024 11:14:35 -0400
Message-ID: <20240311151438.318746-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.212
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
index 814ac25238058..105d781d0cacf 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_base.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_base.c
@@ -6357,7 +6357,9 @@ _base_wait_for_iocstate(struct MPT3SAS_ADAPTER *ioc, int timeout)
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


