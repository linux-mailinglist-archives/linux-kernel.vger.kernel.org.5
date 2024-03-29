Return-Path: <linux-kernel+bounces-124686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C43F4891B64
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:24:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F20241C265A5
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 13:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D571F172BC4;
	Fri, 29 Mar 2024 12:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BBpS68+a"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B4E142905;
	Fri, 29 Mar 2024 12:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711715703; cv=none; b=dwdgGM9TTN0xYQ+3v51lIH/q+Ekb09AFSSU+J6Uc4pSVawKj9vjKNjPuQ4yMFNzcx6Eja/aP9IBFFCNi4tZfgdOef6X+aBNrbMfp82jPjy4Nk5COOA4NAph4j1+7O05+ymfAHhA9x9QiYeDCQe5LbqnIx3JpX6JrlUK7IjPI2rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711715703; c=relaxed/simple;
	bh=/ff5m3Zms0CWVB8orfwGazc8g2xENcIWok7CRnZDuBY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r7YCOCh3yp7czx0CGLY7jiVPNcB4Q1Gt2kbMmyR5qfzsSvvGRezEUfdb33PXPG5Bnhx+yM3ZLz43a7YCS44wScnoT4EtJ83hejcSc7la3tRteDALJ4sb9QkLpJpbQJS8xzTkhd8pAUVe8iiAG0QSZCoHJ0ENeBVBm1O1CE6P2uU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BBpS68+a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83EB3C433C7;
	Fri, 29 Mar 2024 12:35:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711715702;
	bh=/ff5m3Zms0CWVB8orfwGazc8g2xENcIWok7CRnZDuBY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BBpS68+axyXRek01E0ijZY8o+mB9r3sE3bn4BGojZvJFtYNtuwW3zhFFtL/vT6aSW
	 zXA1ZTiE6L1bvG5Z64h09rlbKh00A+HWWjdRByLRNlTPuEyifuYwuiJbsxUyaOoa0+
	 9h1NxPV4ipbGGJ4Cch8bht9Y32bXHK1pseTLw3R0I/1FsBzwF/smUpMib/cWsTPmd2
	 pBBs7Ca41l4bwEhdIAZkgShMuDY20I/yqaF0dFGS5CFtf5LPyUqaYkZof7aV5+ig/w
	 BqrMlK6N2Y+RTJVc5YpPdfVZYXqRFXwrFiwqY4O7RQAC4gAFFnQORTEA6GuXVCimMh
	 JW+1RraChE8yw==
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
Subject: [PATCH AUTOSEL 5.4 08/15] ionic: set adminq irq affinity
Date: Fri, 29 Mar 2024 08:34:31 -0400
Message-ID: <20240329123445.3086536-8-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329123445.3086536-1-sashal@kernel.org>
References: <20240329123445.3086536-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.273
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
index d718c1a6d5fc7..e7d868da6a380 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_lif.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
@@ -1874,9 +1874,12 @@ static int ionic_lif_adminq_init(struct ionic_lif *lif)
 
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


