Return-Path: <linux-kernel+bounces-28063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ACEC82F9B8
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 22:15:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1B0FB296E9
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 21:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 134DF1487C2;
	Tue, 16 Jan 2024 19:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IabkCL7G"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5000E1482F2;
	Tue, 16 Jan 2024 19:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705435019; cv=none; b=GfX5VxyeO3lgGKuHH2lcw11HTVB14HSDWton7NmgOJeDwRIQg5VsqzMy4pnrnKdSVOh+lzG+7Bd+r3MDcW1Ep13LMUhfIjf2M2cpxlEH4XxkfE8PhT2ZokL7U6FVfBSq74Zhtw6RxODTvle/IEG39HM74eDqi+RnOKFyenOf8gM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705435019; c=relaxed/simple;
	bh=cyUEYiXVo5TD95IWupR3lgOIJfMm8WJPRzLURz7qXpQ=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=mu0YnsCUZ5MFZXtHNVQrNl+bOUJPne3lw8eY8ySNJr6dVZACN72RxMjbXaXsN4Y5SRN3kfYh+qeHLKnfU/lQSiU75/4cllIVm0JB2EnggJzeRzMPC3lLjIJZtxi7ung2g/p6+JIc8LKllG2gmZHpwJhKPIn5J1ZG0Pm63C7SHh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IabkCL7G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C326C43609;
	Tue, 16 Jan 2024 19:56:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705435018;
	bh=cyUEYiXVo5TD95IWupR3lgOIJfMm8WJPRzLURz7qXpQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IabkCL7GbJg9/9zqTWlCHK/oq0XwbX/dqTs7IwngAptfU1VS99kbuvUjm4o0Jqad/
	 4J1ZNFhlqdVDGNyi0367q7nrhIThixR2Xdn9rwTLqmx2/uPQCg0JmKQfGoyW9XJdwu
	 I60DZCRhnd38AgNQl5VSZqK1QZZVGdaAxWEqA5t19/kzQwkF1pIiEVbbzzX//0D0RC
	 14DbfRbxg9XgM8b9XNU52Wkrr2rwcn5+c/Q9gE3IQKS2PQr3VCtT6YjemIx6UkLzrx
	 /iQJ1OLowtZa0VZ1HlvPS3+HN81suTL2bNYQgAle+QgUpY5eW6qJqDWiKQhR5xFL9Q
	 CYJJn8HiDjnJg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Yihang Li <liyihang9@huawei.com>,
	Xiang Chen <chenxiang66@hisilicon.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>,
	jejb@linux.ibm.com,
	linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 45/68] scsi: hisi_sas: Set .phy_attached before notifing phyup event HISI_PHYE_PHY_UP_PM
Date: Tue, 16 Jan 2024 14:53:44 -0500
Message-ID: <20240116195511.255854-45-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116195511.255854-1-sashal@kernel.org>
References: <20240116195511.255854-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.73
Content-Transfer-Encoding: 8bit

From: Yihang Li <liyihang9@huawei.com>

[ Upstream commit ce26497c745d0541aec930d5211b431a1c26af97 ]

Currently in directly attached scenario, the phyup event
HISI_PHYE_PHY_UP_PM is notified before .phy_attached is set - this may
cause the phyup work hisi_sas_bytes_dmaed() execution failed and the
attached device will not be found.

To fix it, set .phy_attached before notifing phyup event.

Signed-off-by: Yihang Li <liyihang9@huawei.com>
Signed-off-by: Xiang Chen <chenxiang66@hisilicon.com>
Link: https://lore.kernel.org/r/1702525516-51258-2-git-send-email-chenxiang66@hisilicon.com
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
index c4305ec38ebf..81a2365dc091 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
@@ -1565,6 +1565,11 @@ static irqreturn_t phy_up_v3_hw(int phy_no, struct hisi_hba *hisi_hba)
 	}
 
 	phy->port_id = port_id;
+	spin_lock(&phy->lock);
+	/* Delete timer and set phy_attached atomically */
+	del_timer(&phy->timer);
+	phy->phy_attached = 1;
+	spin_unlock(&phy->lock);
 
 	/*
 	 * Call pm_runtime_get_noresume() which pairs with
@@ -1578,11 +1583,6 @@ static irqreturn_t phy_up_v3_hw(int phy_no, struct hisi_hba *hisi_hba)
 
 	res = IRQ_HANDLED;
 
-	spin_lock(&phy->lock);
-	/* Delete timer and set phy_attached atomically */
-	del_timer(&phy->timer);
-	phy->phy_attached = 1;
-	spin_unlock(&phy->lock);
 end:
 	if (phy->reset_completion)
 		complete(phy->reset_completion);
-- 
2.43.0


