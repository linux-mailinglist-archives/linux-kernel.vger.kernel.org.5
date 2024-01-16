Return-Path: <linux-kernel+bounces-27984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0905D82F8AE
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 21:50:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 765BB284574
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 20:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3EFB136E1E;
	Tue, 16 Jan 2024 19:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pMlH/f6C"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31011136E10;
	Tue, 16 Jan 2024 19:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705434758; cv=none; b=OaGpjeoyCduuCG+VOVk5gkNhMPNrgUArYXiJD3UtWxhv5nJ6C2w54rYNvwBSuKjmwiPz1cU7OqWifeIvuhM1ST7ZmGzWcboGrWp9iPTdJxscq1e2Cu/n0d2JxhflQAepk0Ft5TTelpwaAFT/rgcdjHR9ypoBKd+cCI8k+GoVhbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705434758; c=relaxed/simple;
	bh=zltGWrDUUtDckp58rbsIjC9H/2WP+NdU30FGUapE6HI=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=LwGTa0IModB2CyWLS7a/gxVmm71Q1RoAJzcET7FlfpdgVNOX941zDL6aHNzqYO/n0KDGnxCFocKMCtqApPGjM9dtNlIrOixxS4bYvU6JLx68I1cmE4Fm8fNdPnPjvoLFmDKAjAWauzmggi4nhvRQ9rw4M23mkbPv2Fu/qcsBRq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pMlH/f6C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D021AC433C7;
	Tue, 16 Jan 2024 19:52:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705434758;
	bh=zltGWrDUUtDckp58rbsIjC9H/2WP+NdU30FGUapE6HI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pMlH/f6C+1EA61fI6FzjgkSBhLx6XdcIorFQRtTkKCkDtWWMxfGxFl71djFKTdSSl
	 rOjt0NntJ9p94YNWrSXHQTLnR/abfCmgcOzJbaEkooCx3UNIemErdNLckZ6LyzsfQQ
	 SllpJv7aojpO3Xbah93WAdHlDOifG/2xBjln84FvAPn0lv0Ib2lQdc8fG2VqRc95eJ
	 222UnB1jeRyzgck9SaZ5iklodqZONlMx0PTyI8acZZAatfkV0wVq7vRd7n2nazoxVy
	 dnQLz6Xl4Mjd2SB6ZoCIQ/IIo2vQoNOBq7rG9C0fQIn8BDGzlNREucSCZeQBir7f/Z
	 6EXR3+8PloBwg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Yihang Li <liyihang9@huawei.com>,
	Xiang Chen <chenxiang66@hisilicon.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>,
	jejb@linux.ibm.com,
	linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 073/104] scsi: hisi_sas: Set .phy_attached before notifing phyup event HISI_PHYE_PHY_UP_PM
Date: Tue, 16 Jan 2024 14:46:39 -0500
Message-ID: <20240116194908.253437-73-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116194908.253437-1-sashal@kernel.org>
References: <20240116194908.253437-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.12
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
index 089186fe1791..58f41d3001e2 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
@@ -1606,6 +1606,11 @@ static irqreturn_t phy_up_v3_hw(int phy_no, struct hisi_hba *hisi_hba)
 	}
 
 	phy->port_id = port_id;
+	spin_lock(&phy->lock);
+	/* Delete timer and set phy_attached atomically */
+	del_timer(&phy->timer);
+	phy->phy_attached = 1;
+	spin_unlock(&phy->lock);
 
 	/*
 	 * Call pm_runtime_get_noresume() which pairs with
@@ -1619,11 +1624,6 @@ static irqreturn_t phy_up_v3_hw(int phy_no, struct hisi_hba *hisi_hba)
 
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


