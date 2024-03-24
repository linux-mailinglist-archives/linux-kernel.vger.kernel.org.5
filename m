Return-Path: <linux-kernel+bounces-113954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39F68888EF3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:31:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF9781F27914
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1590021AFF6;
	Sun, 24 Mar 2024 23:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OduZTzPI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EAA41F1ADA;
	Sun, 24 Mar 2024 22:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321085; cv=none; b=RokX0JOhxu4Jptjo98tHaOrKyx591sVsHCUp+wRED1znLcmOJJLy2UO1KXtJe4MnqnsZHEBUSMnPlDIRu1Y2FZEMBeufisYFLSrNj/KOXVjO5ZVuR1TMLhR8ZAsJvJRGhv408clYQ13I/deNMt4CHKIZRyZgb6jvZ/YXbx7OadM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321085; c=relaxed/simple;
	bh=PYENx02CKZGs2pTnzPJ7cRTd7xeRIal9wjJ8Gx4KiIY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kh5MeMWl20bkdOxgCsKtz00lWnli+bIZPm3B+CFnAPc+J/yBf4G0zg8b79GJ2deOd57I2XFXgNmtn4GDvk6oQXH9ta8QEz10F9b5b2Jgzc6q8hHLQ9ZCQIq9u7j7dUDtX4j4O/UKowbvMn0EKlDgA/bt+CmR3DmZ2TwYArr6fG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OduZTzPI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB3BDC433F1;
	Sun, 24 Mar 2024 22:58:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321084;
	bh=PYENx02CKZGs2pTnzPJ7cRTd7xeRIal9wjJ8Gx4KiIY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OduZTzPIljbhxU1LLhwNTFwAm3j7apx+5BfdsxsMHnvhq3+lgG42avD/i92nMUUPx
	 lumt7GMgcb2+KrmUe+ptxeNCJAxwARw857tDMc0CkSXEzH2Oz4p9ov7acAkW2WXoH7
	 JDBPP0FcuK7fl9iDZC0gdtwXzKQgRAkL9Z2y5TeBePPRDHO7spJ/GsSyLld4MCNvTe
	 NNj9VoXAxZ7AxiY0PAa4nc2qJms3rOcqzLVT0Gi/BBX8VAwLVzfjvD2Va08xSDVA3/
	 9zfhuPDGxC2w942i3u0AkxSkk3/fKNenc3bvO/iwyMXzh/aBhGKI+7v3lbGOZVMKnn
	 +gVMWduRpTIyQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Linu Cherian <lcherian@marvell.com>,
	Sunil Goutham <sgoutham@marvell.com>,
	Subbaraya Sundeep <sbhatta@marvell.com>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 648/713] octeontx2-af: Use matching wake_up API variant in CGX command interface
Date: Sun, 24 Mar 2024 18:46:14 -0400
Message-ID: <20240324224720.1345309-649-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
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


