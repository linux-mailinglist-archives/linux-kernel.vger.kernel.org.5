Return-Path: <linux-kernel+bounces-124643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE107891AEB
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:13:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77951286CD5
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 13:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47442161320;
	Fri, 29 Mar 2024 12:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZyvXoiTJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 851BB161310;
	Fri, 29 Mar 2024 12:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711715616; cv=none; b=Gp8oRECTVQ6vLq4PLnIj+0F2VE/MesgNKqkcWjb1jAhRCSuOcBDPRLELvFvGJ+V9NnjnS0kJ81jdTzcRhQZCVU/ooYyLPX+IGcjoCIx8PA1d/bHEZqKPU4fFqwobSqgBTDoZWYiPPOOJ2Dbf+xEO1tcMoc4Gzbtkfp2bzkUJ56g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711715616; c=relaxed/simple;
	bh=8yynqQQWOVGMt8bEI4dlD+HewKoejyPsAI0N4aR84Nc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iWR1whkxs9nSOldIk9qvKxdQWpMTYDsdvzMf/GZPKC7v3seLRGTJc5jRaWzNj3wB2/AS1bXXeOQEPed4vatCifh/qfGS7472efT6jitMlkskXicGennBxQ3FuWBkoYtjioYq1hoPzfMZZ9rcsp+VDFAGd9Ud3LXAgJ7O4nk45lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZyvXoiTJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAB74C433F1;
	Fri, 29 Mar 2024 12:33:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711715616;
	bh=8yynqQQWOVGMt8bEI4dlD+HewKoejyPsAI0N4aR84Nc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZyvXoiTJUdpopfezjCnv9TJs7fylavGoXgDvYjfWovVQSg6k1t2ka+AhxSsAT/EtM
	 usM0PCAZrGW0dTwK77dERWBSzKeszbotZvWiy/uDifZCnZDsKEia7MugbfzF0T6wNj
	 qWzl/FQPWHKa/UXRX774UdUfkrYPos0JYpdskJiQTTNYYm4SKW8e1vgYDbLRQs4uPt
	 1hnjZShRQeOPEZpep2k5JfiVUZneguA3iHvUhWMnYxAp9V2dz6aNSx3R08ZgBWt9jK
	 3ScS3k/SK92je0XpLSNBqCAKhvkIh2mTQbCvrc2Fzsz4VyD9g2jXccxBmgFJuVtFHS
	 G32DoEobQyzMA==
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
Subject: [PATCH AUTOSEL 5.15 09/20] ionic: set adminq irq affinity
Date: Fri, 29 Mar 2024 08:32:57 -0400
Message-ID: <20240329123316.3085691-9-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329123316.3085691-1-sashal@kernel.org>
References: <20240329123316.3085691-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.153
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
index 63181866809fd..1f84ba638e6eb 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_lif.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
@@ -3232,9 +3232,12 @@ static int ionic_lif_adminq_init(struct ionic_lif *lif)
 
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


