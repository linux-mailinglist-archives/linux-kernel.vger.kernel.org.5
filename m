Return-Path: <linux-kernel+bounces-113537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 432E388851F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:59:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3C4E2852D9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B00CE1C09D8;
	Sun, 24 Mar 2024 22:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jobbP03T"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA6E1C09BC;
	Sun, 24 Mar 2024 22:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320338; cv=none; b=tCqtvaFu0X4UOAmMZ0ocKwJ8W7BDXwKCQcjc230evdgKxouieLRXOWv75XWME35FwXZmkuj8baQKOXFT1aS6Dx83ogItAzOF4U6VYO+SmNASyA2ELWdAqXczTOfUQKCF2zKsY/sEULaKhhIuiOp4UAGmMKMvEy7MtgJ5QS8J+9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320338; c=relaxed/simple;
	bh=PYENx02CKZGs2pTnzPJ7cRTd7xeRIal9wjJ8Gx4KiIY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZG6n2iw1bVeM0MWctKSgrKRyrXmXP+GBjbP015ZwP46o9gJ+rhz9EP5jL7ylJSWWbMY12gp7DpNkJ8nmHCcjM5uGz5FVIpZPH+MUbBJapxLWBSY/dXTnewyL55AWK4dzyTXSx9uMBH9LMtJATWnKaorooNvze6ZmqbJNK9pv5xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jobbP03T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF20EC43399;
	Sun, 24 Mar 2024 22:45:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320338;
	bh=PYENx02CKZGs2pTnzPJ7cRTd7xeRIal9wjJ8Gx4KiIY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jobbP03Tlb+4i+2EjqZzPisaOS4ougWrY5i+wh6wU1mujTmXlKX0rzt2wd8QCJiA3
	 00iQYz7jHkIBesHPXTT2tVtnU3iELNarhV7jHTqYrrGhZnvsbRiWjO8eKnbPA4kHSm
	 m3d0faqLb7NujzeALUEvVtFmXpvqfYhecqw3eHn2rDnTplv9PfwfzD0n3w/LerjlVH
	 2ME0arb70c7Bl83pYlEGGLHhwZnSd4itnT+udNcBAcRMsiiZt+1+bXxG7VIfKG6fAg
	 QOtOkJyrSqR4He61Y7X6D1HwdRx6/BXZ3/9hJZKo5jIdV9ZWWdS5C62mT3M61lN3ZO
	 THZBCNwrWJxEA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Linu Cherian <lcherian@marvell.com>,
	Sunil Goutham <sgoutham@marvell.com>,
	Subbaraya Sundeep <sbhatta@marvell.com>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 646/715] octeontx2-af: Use matching wake_up API variant in CGX command interface
Date: Sun, 24 Mar 2024 18:33:45 -0400
Message-ID: <20240324223455.1342824-647-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
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
index 6c70c84986904..3c0f55b3e48ea 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
@@ -1338,7 +1338,7 @@ static irqreturn_t cgx_fwi_event_handler(int irq, void *data)
 
 		/* Release thread waiting for completion  */
 		lmac->cmd_pend = false;
-		wake_up_interruptible(&lmac->wq_cmd_cmplt);
+		wake_up(&lmac->wq_cmd_cmplt);
 		break;
 	case CGX_EVT_ASYNC:
 		if (cgx_event_is_linkevent(event))
-- 
2.43.0


