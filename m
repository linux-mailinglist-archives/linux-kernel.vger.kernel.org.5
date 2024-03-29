Return-Path: <linux-kernel+bounces-124668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 94556891B31
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:19:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5123628C4CA
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 13:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A93516F826;
	Fri, 29 Mar 2024 12:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IhGRUzo3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5363716F280;
	Fri, 29 Mar 2024 12:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711715662; cv=none; b=EqWlPj65TjsqAbxfeBgCijEzbIVxJ837CRZQWEzzNTFWcPsc8zQhUwY1+aeHw/IttMSMPtaF8SNvRcZ87uasJ/oWf6KlxcnXgLYEMK+xfDaGGpPpct/QOaFrx4J9KrZ9z5rjB2AJWnBJq+OTodEEHQE3Tvn4xiEeSdJ9BgysFfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711715662; c=relaxed/simple;
	bh=o8CEApaJc28gcYrx9AH94R7RlN3n4bFaz10MOgRGg/s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Aaa7CO3ep7Y11DlWAg2IuyHlhpSdWwe+60XeLGBbOU5TwNvbu6CbVQn5jdhvaDQZo8TltojFBcOxARWrnr35v++JjTUA6W8wmWfbmsNTw0uQZuvuUmnvEsrjwi311rEdbpmgtb1kRwIL/QvAlyxDUV9ZfA6iG/3BzSWDhIZcs50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IhGRUzo3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCBBAC433C7;
	Fri, 29 Mar 2024 12:34:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711715662;
	bh=o8CEApaJc28gcYrx9AH94R7RlN3n4bFaz10MOgRGg/s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IhGRUzo3K/7paC/b1Cy+fQg9diUL0XyUwNJglrRnWoVDm+Fpl5R1TTF/drjpfuiiu
	 sgSWXXMTdOFYAYGFBnommB3NXnXbodmzZQkTXzou3YJ8F8UilfP6ebxfTKZudqn/tv
	 2Cgm0+Hu3Z2QiVQTZnjbAcHBCT9LtAn6Aft+BkZ21TpCo7tAz1XmOWFiOrajbsyGgw
	 pXWo5nZOCqJukFJTFBQt3S15CY190F1mSJE5oW3ldMiM69WWZiP0EtRWfRc7wyMNb5
	 WMAQDkjH9REpjzzdISO1kVQgX+4zz1u4RjodMwX0PqJdT5A3or5mE21nWJ5KLbiDCP
	 KqD7LuPG5xWmQ==
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
Subject: [PATCH AUTOSEL 5.10 08/17] ionic: set adminq irq affinity
Date: Fri, 29 Mar 2024 08:33:47 -0400
Message-ID: <20240329123405.3086155-8-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329123405.3086155-1-sashal@kernel.org>
References: <20240329123405.3086155-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.214
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
index 49c28134ac2cc..a37ca4b1e5665 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_lif.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
@@ -2708,9 +2708,12 @@ static int ionic_lif_adminq_init(struct ionic_lif *lif)
 
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


