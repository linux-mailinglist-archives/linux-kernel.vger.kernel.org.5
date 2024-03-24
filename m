Return-Path: <linux-kernel+bounces-115990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9A3488990F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:00:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16CA31C320B2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B8903998F7;
	Mon, 25 Mar 2024 03:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ta6TkNcX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E29A15EFAC;
	Sun, 24 Mar 2024 23:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322321; cv=none; b=HuLbWz1GdblIj4lz+Ijw6pb4BVHrLvUZfpodSiZ/1E9R6pL6nsCHr6XzXqt0D9F8lFkcy7qw6ct1m+h4RGo019HirypfzEDMjesrKEvbdBmM7Z9Cq2H0KTW3Zg5sTuFBdIdASp/Mw4qqLD7Hhyfo0be89TWp6PmmX7wx7RHMFns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322321; c=relaxed/simple;
	bh=vAioPwQOVXbK7PSHkg5qgEEJ8TIXQklEziFOCRAIHY0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W3VlFiXA55Lg6BHfxN3YN1uMN/I0ixeroQXnoQQR3o+2kePCcZvwPV+l/n9eJa46YhDjDmVj9irn1NDfMzhXJr8GiN4FUet0kqrnBF56DXxynhYmQa6DClBV85QxPgUNWgrLowIilOxA5p99WtcF9ahSP7KLriHr1l/9q3tJv7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ta6TkNcX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B130EC433C7;
	Sun, 24 Mar 2024 23:18:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322321;
	bh=vAioPwQOVXbK7PSHkg5qgEEJ8TIXQklEziFOCRAIHY0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ta6TkNcXAiy2y1YAXYCFooCJXWngEi5h1LOw/bhoTLZK1sqDFmaA384tK4ck4gBnT
	 P+tj2Fx7qfwIJrtd8Q32h9Kc56/86dwk4ZkHfQiUYc+CH/hHERjoegjsoxn614NYAZ
	 exmSS+gKu04R7yCDgnndOENJhL36GALMhBeGHv9eIQRSPyJUfOxpLCLwHPvWSosos7
	 0jhulSZfkUi9doQqgCG5O3fr1H0RwWlfTTMAwAYL0+wLCymJBa6dDr9OGw+sk5Cq77
	 5HAdSycZJ998Bi2ROnqZSYfg2P3E8pQABALkL5C6tOGOfZWZaQ5dA1CydfVCC8QWoT
	 vJv64acDmgEgA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Linu Cherian <lcherian@marvell.com>,
	Sunil Goutham <sgoutham@marvell.com>,
	Subbaraya Sundeep <sbhatta@marvell.com>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 404/451] octeontx2-af: Use matching wake_up API variant in CGX command interface
Date: Sun, 24 Mar 2024 19:11:20 -0400
Message-ID: <20240324231207.1351418-405-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
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
index 90be87dc105d3..e6fe599f7bf3a 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
@@ -1346,7 +1346,7 @@ static irqreturn_t cgx_fwi_event_handler(int irq, void *data)
 
 		/* Release thread waiting for completion  */
 		lmac->cmd_pend = false;
-		wake_up_interruptible(&lmac->wq_cmd_cmplt);
+		wake_up(&lmac->wq_cmd_cmplt);
 		break;
 	case CGX_EVT_ASYNC:
 		if (cgx_event_is_linkevent(event))
-- 
2.43.0


