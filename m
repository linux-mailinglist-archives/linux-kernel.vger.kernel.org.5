Return-Path: <linux-kernel+bounces-115156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BFB6A888D7E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:50:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 751E81F2A56E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3862428ECAB;
	Mon, 25 Mar 2024 01:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YJzBUoCD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB062182776;
	Sun, 24 Mar 2024 23:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324178; cv=none; b=UQIIDQgYulDixqh8S8BKTep5Q+2r2Nys7zpguVRMk46c/kzPEsfOHvKIgmcwgFxnbYmD4dQxQdRTA8g7LUdAyl7Qgsv630eeAG8qDx7c0KnBOoUbw7DhmVwceOcXrhpuAGpqb0yUn6He2tZ8dqLS4nT0lpCw49iNB82LG2HQNTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324178; c=relaxed/simple;
	bh=r9UnBII3REuWbDqt5aQZvD52Fpe3UUiC0qCfsBdVK8c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z1Px0flztlRwhP5SUnluVyJ7CIDAIywePrcyH63Ak+r9+8R5cPGrJ1vvMYVRXmOPaIy2N7ueJXEmVa0mQficAiFX6IlLPP7DL/bAXz8U6q6i/LsZ/afqsQ0KerLoNS85q8HhZNl4h6bmaNtiXS9BUuZRUWigN2i3ZqOkWaCINbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YJzBUoCD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C200BC433F1;
	Sun, 24 Mar 2024 23:49:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324178;
	bh=r9UnBII3REuWbDqt5aQZvD52Fpe3UUiC0qCfsBdVK8c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YJzBUoCDdlVI8H/ZukPzAqQv9S/HS+LmJqIexU1WH+5SpFDGrN/EcA4fXqi/xKtQL
	 bZom1pweFrHMXPa4XRGivkFRj4Bi/jgCw6O6nZ9aUjplV7CMA14hmobrdX0C+f8SAF
	 qOcu7nDPGgSiQwQq2ftpEFR7ieRJ5vFtAi+HJm58sRlrqxyARtZ7+0u9MXT3W2TLGN
	 ILWgV978hDsnDxxikg9H0FAxh24T5CQksk1ZHEs+moW0D/OBg1jSzT3h1mzC8MtdxZ
	 fAs3TBa5851265/SrN2EO3/rBLn+DWojz9usqecAdFPu+Gll6cPnZx5eHywsWIaMhV
	 UCl4wTpd7gvyA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Linu Cherian <lcherian@marvell.com>,
	Sunil Goutham <sgoutham@marvell.com>,
	Subbaraya Sundeep <sbhatta@marvell.com>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 169/183] octeontx2-af: Use matching wake_up API variant in CGX command interface
Date: Sun, 24 Mar 2024 19:46:22 -0400
Message-ID: <20240324234638.1355609-170-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234638.1355609-1-sashal@kernel.org>
References: <20240324234638.1355609-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Linu Cherian <lcherian@marvell.com>

[ Upstream commit e642921dfeed1e15e73f78f2c3b6746f72b6deb2 ]

Use wake_up API instead of wake_up_interruptible, since
wait_event_timeout API is used for waiting on command completion.

Fixes: 1463f382f58d ("octeontx2-af: Add support for CGX link management")
Signed-off-by: Linu Cherian <lcherian@marvell.com>
Signed-off-by: Sunil Goutham <sgoutham@marvell.com>
Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/marvell/octeontx2/af/cgx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cgx.c b/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
index 54e9f6dc24ea0..910ed148e827e 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
@@ -582,7 +582,7 @@ static irqreturn_t cgx_fwi_event_handler(int irq, void *data)
 
 		/* Release thread waiting for completion  */
 		lmac->cmd_pend = false;
-		wake_up_interruptible(&lmac->wq_cmd_cmplt);
+		wake_up(&lmac->wq_cmd_cmplt);
 		break;
 	case CGX_EVT_ASYNC:
 		if (cgx_event_is_linkevent(event))
-- 
2.43.0


