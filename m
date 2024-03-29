Return-Path: <linux-kernel+bounces-124615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E70E891A9C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:06:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 900C01C25841
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 13:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B910E15B541;
	Fri, 29 Mar 2024 12:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i8Ft3QOJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB4B15B14C;
	Fri, 29 Mar 2024 12:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711715553; cv=none; b=IK+wwVNmHVcAHtcpPnOVmic5pXr83h2UMUpQXjH7ht+7BVSmDNDCmlZdVOTy6oWt1hjF2Y/TL/GodNsXjpO0uvSX2KtDn+S8H8Tyk4xlHctgbJMICrrQ0vXy7VUp3RcYXpL/reoxHnRdgVHrfo34NHQTLzujGiF0T5woGGlUn/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711715553; c=relaxed/simple;
	bh=V85htiRzenTUy0PNh1A5N6H+p8aGUjz8kyLJxgAgmc0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T30n6pXLb4dooRilS3wq/yO6Iiv+RpBKeTCcrQK/Ryy5/KHEAum/k1WrJkQPcazOoGPjjUKWxBsCQe2E+w6oPnDVhAmRxn2zQhDlYTbQd0aBtmg/WCr0axgmhCETdcLQCJXkU/rbULcs1Xl6jdYfCv6rnwSRUAq5ueKOXgvFTMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i8Ft3QOJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2823CC43399;
	Fri, 29 Mar 2024 12:32:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711715552;
	bh=V85htiRzenTUy0PNh1A5N6H+p8aGUjz8kyLJxgAgmc0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i8Ft3QOJsqFOyd0onBRCzHT9Imin3KtZtZI9/lVa10L3gSQeB7JIP3wF+FevqjEfK
	 YNmepU0lC09iBqYSbz/7d0dyJVFlt+8R041CQGQ0IRHas4BaeEXjDxwSDafhPVDCgw
	 vuBVhBDHdksyEI8Q5JwMQfshOq1TKM+bd9TFkJbQ7o9roKPmepjUlBucAmdAJqUGBE
	 p50g1wqaUb9HETym2iLlnp9JMG3apzYG2xeZzXU8nLD9esXqA/paaKFa1Lb3OsNHfY
	 ObLHrrHnXYqKarE27IDRwYk2nzyHFLuJ5j9geo72qYrCzg9CJPIUYhqr2cjFQEx0fC
	 3jww0H3+Ge0Og==
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
Subject: [PATCH AUTOSEL 6.1 12/31] ionic: set adminq irq affinity
Date: Fri, 29 Mar 2024 08:31:31 -0400
Message-ID: <20240329123207.3085013-12-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329123207.3085013-1-sashal@kernel.org>
References: <20240329123207.3085013-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.83
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
index fcc3faecb0600..d33cf8ee7c336 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_lif.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
@@ -3216,9 +3216,12 @@ static int ionic_lif_adminq_init(struct ionic_lif *lif)
 
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


