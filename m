Return-Path: <linux-kernel+bounces-124518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16B6189193B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 13:37:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6128287846
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 12:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C154145326;
	Fri, 29 Mar 2024 12:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gCBZtoCa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6156144D34;
	Fri, 29 Mar 2024 12:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711715285; cv=none; b=JYpOEA3Wou1lbxpC9BIwzSfVF/lDrE1GcjLIVuqJe9AzG7X4B4x3Wg7tmqjxwYeHWD7ypFLnUHgDcSj6x/v75694YmCILyt8pwtE3FSCYiNVxiCnJbzpaERrU0X8jjQ/rIZ5B5mKyiMNVKrWlJ5XT/1FDr66WAeBkCGGtSZ0S2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711715285; c=relaxed/simple;
	bh=ptYgCYybEi2KK8iNMC95yfC3doBulxDb8Nt1a0I4w2A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FO4jyEDbd+86APb/qjKM3hEVNAWZVIX46XUuepG6tiEBslX6hz7Yv2/Uo6SWELbadOHedvZwPkaJNQ2aVurcD8u8v1PxHJo78XY90Ntpffg02RmHcvFIzfQxfrOfXnq1KLqDdaNoyBj4AT3xhMIfbLaipag9G4/wKbufBBBWiyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gCBZtoCa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C366EC433F1;
	Fri, 29 Mar 2024 12:28:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711715285;
	bh=ptYgCYybEi2KK8iNMC95yfC3doBulxDb8Nt1a0I4w2A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gCBZtoCaACERXSiDyvQzkCypzillJjxN6iQXrKPxIWyCvFlMsw+oYcJPOTTTUFwj2
	 Uvkrq9Vt6eZfADfDnZabmk2ftY7WdIFiOpkmJgIrxm79uGp0OLyKBvGcO/2nB6k3XH
	 wzXIhHG+l23/5D43khssiTI+MDO5VdqW65lybsj56vng7SEdAwP1YL+ZFNOZp3MYKL
	 TeG2roLyRfnqcQWFZkRVRDMI6YRILYk3+a5Lfw+vFSqQz+rFDtKmcpXogyLASAk9yQ
	 x0C9VsO78CFbeaZtDO13JA9VdAbH4z0lGWL91Udv/MqCGGYAkhx2JS38FTTqsGbMRt
	 tbn92M/TOdewA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Shannon Nelson <shannon.nelson@amd.com>,
	Brett Creeley <brett.creeley@amd.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>,
	drivers@pensando.io,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	nitya.sunkad@amd.com,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.8 37/68] ionic: set adminq irq affinity
Date: Fri, 29 Mar 2024 08:25:33 -0400
Message-ID: <20240329122652.3082296-37-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329122652.3082296-1-sashal@kernel.org>
References: <20240329122652.3082296-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.2
Content-Transfer-Encoding: 8bit

From: Shannon Nelson <shannon.nelson@amd.com>

[ Upstream commit c699f35d658f3c21b69ed24e64b2ea26381e941d ]

We claim to have the AdminQ on our irq0 and thus cpu id 0,
but we need to be sure we set the affinity hint to try to
keep it there.

Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
Reviewed-by: Brett Creeley <brett.creeley@amd.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/pensando/ionic/ionic_lif.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_lif.c b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
index fcb44ceeb6aa5..44d30115ded13 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_lif.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
@@ -3391,9 +3391,12 @@ static int ionic_lif_adminq_init(struct ionic_lif *lif)
 
 	napi_enable(&qcq->napi);
 
-	if (qcq->flags & IONIC_QCQ_F_INTR)
+	if (qcq->flags & IONIC_QCQ_F_INTR) {
+		irq_set_affinity_hint(qcq->intr.vector,
+				      &qcq->intr.affinity_mask);
 		ionic_intr_mask(idev->intr_ctrl, qcq->intr.index,
 				IONIC_INTR_MASK_CLEAR);
+	}
 
 	qcq->flags |= IONIC_QCQ_F_INITED;
 
-- 
2.43.0


