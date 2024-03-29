Return-Path: <linux-kernel+bounces-124576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA3CE891A27
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 13:54:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65C2D281D9E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 12:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0216B13CAAD;
	Fri, 29 Mar 2024 12:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OvVl2VS2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37895156259;
	Fri, 29 Mar 2024 12:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711715444; cv=none; b=tC/7tNm8xL1zbwJCdQ1rImiUkkfb+HXZSNlRMENrY4Ez7oUEAJ9ZlnEgipYoexKIoF8fF8glxRE6xf5qjG3XduykMebugVL2oYzJhtKCOv/FR/1vMot7ty2Z6LvpVHKXx/SQK9X4DoFN1Xp7pZx7bQc4csdpuIfKtmkniXUJxck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711715444; c=relaxed/simple;
	bh=KJMusQBaZ2wXF4wyQ1/zdzTdGHxScgRaikU7zMTEy9s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qlQNLPt2IFYuRt4rdmgzhuNBbKwWfT/8A4BWs1rTN49updix4RW/4/fhZA+OtmtbPzVXUGd7AEtxfKn0NGXNl6XF7AIAsTlMzUZpH9WvO3coqogJ0pTEeD0qRcE+yCNaABvMMQH3hKQ7H32fZ+ozfIuwqd6S3S3oTQ/wbLsIZkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OvVl2VS2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9F7AC43390;
	Fri, 29 Mar 2024 12:30:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711715444;
	bh=KJMusQBaZ2wXF4wyQ1/zdzTdGHxScgRaikU7zMTEy9s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OvVl2VS2Zf+QTYI+Q1h3mhXmA+updaW6GTI5f8d0Yvj0G+x8qQN/1jDozry6N+UO6
	 pqlgXiDoJGrtDtkRI4o+pgxAaN+buiH7OyrwkN08NDAtteWEqzBSDH0BXyTMmzgE0a
	 BhXjG9ElDzCJB5zHIvDjBpjilZfKyYBUPNFAlHMo2JqhEslORWsJ5F7P4OSTMdfubg
	 RV7qr8IK3E5dwRzfVLQI/eCxV+PZmAi1/loqheyg6Babq0QC6pl6Z7oacpheCU0rJb
	 jp0oOAWLNZNtv48KC0a4P3WR+GsnRhL2T0VvWcovptz6nIcSF8WlyO53SbUsnanj8k
	 3g4QYwnzVb+fQ==
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
Subject: [PATCH AUTOSEL 6.6 25/52] ionic: set adminq irq affinity
Date: Fri, 29 Mar 2024 08:28:55 -0400
Message-ID: <20240329122956.3083859-25-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329122956.3083859-1-sashal@kernel.org>
References: <20240329122956.3083859-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.23
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
index adb0f9b01bb1e..4f05cddc65cb4 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_lif.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
@@ -3468,9 +3468,12 @@ static int ionic_lif_adminq_init(struct ionic_lif *lif)
 
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


