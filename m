Return-Path: <linux-kernel+bounces-99097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00A34878368
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 16:25:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE09A2847B5
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 15:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F05D6481AB;
	Mon, 11 Mar 2024 15:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tAbOqo9+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D8C481A7;
	Mon, 11 Mar 2024 15:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710170046; cv=none; b=qrowSXvSxJqSzt+3ZBt+5Ancf4gCzqTldJzdAsuwtTVkgIG3TTaFU7nA9tRuG6mvE85f9Cw6LNzjSV2rkOzF9cY8+VcBaU7ie/PszdQLWEInOTe+/dhaPro9KCj7N/pIi2TulvcgmstRh8J71380WTjENDjhWN+2H2gz+4Jq2kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710170046; c=relaxed/simple;
	bh=vko/+J46uPjjVxQ7eGm2PmvehHWRDiGajfhump5oooI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XBXhBhVMBuBhqBpjwhb5BmfOsyZxRJmhIjFA7HcWKn7oUyWlnKXWNBa8z0203VJiuPxnVi1Hr9X1Ti3Y8ESZtMgCkGkE0f8Fn34eAoT90KuVTvuMPBtmTM/DgVB0eJoALUYLZ7HzDIzvepOaElw0ITG3tGJ6NPodJJDHx5yJcyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tAbOqo9+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0C94C43394;
	Mon, 11 Mar 2024 15:14:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710170046;
	bh=vko/+J46uPjjVxQ7eGm2PmvehHWRDiGajfhump5oooI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tAbOqo9+xmGLoKK42RN4u4gI91kwGO4rrJq+7ergpYa99hrp0eTumhD9jhQ3fODF+
	 ZHybuWbAiefVJYD+7TMHyj4UrnL7/LkrNl8+9nuDKphFgL1pojW9PmVBNzr3+n5+CN
	 0xE6W0NWKxGhJFHgTNbE2JPZ8YgZNDUl7QyRjrP6u+jjlIqP55omMJV6y3Z/ZVLlYP
	 U/B/IdMFS3YjiOFzEstc3v3fnq+Yy4eD9uOFy7KluXiKS3M1MG2HCeSTl5LyvJKfKS
	 cPJcvsOiONzmo4GUT505dfKRo0dSlk24X+tHnaUJ8ybC8eKeKN9xnEewnwDeV3I2UI
	 a8uSSEaEM2F8Q==
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
Subject: [PATCH AUTOSEL 6.1 06/13] scsi: mpt3sas: Prevent sending diag_reset when the controller is ready
Date: Mon, 11 Mar 2024 11:13:41 -0400
Message-ID: <20240311151354.318293-6-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240311151354.318293-1-sashal@kernel.org>
References: <20240311151354.318293-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.81
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
index 809be43f440dc..8e6ac08e553bb 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_base.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_base.c
@@ -7398,7 +7398,9 @@ _base_wait_for_iocstate(struct MPT3SAS_ADAPTER *ioc, int timeout)
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


