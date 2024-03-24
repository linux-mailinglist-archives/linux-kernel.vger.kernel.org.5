Return-Path: <linux-kernel+bounces-115312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6127D889AAE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:33:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8572B1C33541
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 261281DCC9D;
	Mon, 25 Mar 2024 02:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PR+EnOr/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C53C17FBD5;
	Sun, 24 Mar 2024 22:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320500; cv=none; b=c8lgFv4SeWbAnzulFImR2TSH2QwyQ60RTgcL1akCtvhuPneUds+WiOFK7+yl5x0Wgdw7wvTGrtV7NAcL0o0JlYHYjb5etZDph1wudVb5TiaVr8tt56xkhh5Jg/nV7saGXIJU5S034FQNxQovZgZJKH6s7ZDv6FijYCZ9xSSkZSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320500; c=relaxed/simple;
	bh=fcYzSLOFq5sMLBWQn8a4zJLsYwI3TPCX+aV1ze6z2EI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eta26/otKTTPvFB5EabiglySw7olIoVnp52ApFvTgJ1RcIhTjaHxJ3BSx8RtGYa4tsEwzo1SRPSdHTXzmaPY3E96dQoWAaWQ9XORwGwW5xm+dzdFe5Ywa9z+PKq9LA7eSlaT0tU0FmimHdijlk76GFtSLSpBaUju6Via6g4LzNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PR+EnOr/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 044E4C433C7;
	Sun, 24 Mar 2024 22:48:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320500;
	bh=fcYzSLOFq5sMLBWQn8a4zJLsYwI3TPCX+aV1ze6z2EI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PR+EnOr/NI8iDeFStYQD71CgeSpbSMgSzNzF/KI8yFDWlQdalV1pw3BPeghKyGpxK
	 4NqPZ0fGX3HHo/vfuzBtCJtjxCNyt8YzhLdfvtT23N9ALbUpIOcTYylssXKhrobPZ/
	 n4d3HR189FQA/9KdrDo2GxwMA7RqBPBsi1M0/xPKXxmgmFxhXZppDSp8M2igXucyPX
	 b7FfWVMg1VEZrIucTl8S8ieui6RW9+snQj7G6ehbh/fqUgwBsKSKh5omxXAOhE+5Yk
	 m2RGxjyQftx5cQPWlPnAuvEvxcF54/V4KS03Y67GOw7ErE2Rtmgd/sOrWYqZZP4kJw
	 KZKM53vjdP0iQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ranjan Kumar <ranjan.kumar@broadcom.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 060/713] scsi: mpt3sas: Prevent sending diag_reset when the controller is ready
Date: Sun, 24 Mar 2024 18:36:26 -0400
Message-ID: <20240324224720.1345309-61-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
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


