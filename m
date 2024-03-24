Return-Path: <linux-kernel+bounces-114437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AB53888B59
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:47:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A04C7B253BD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74D08178312;
	Sun, 24 Mar 2024 23:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BxExBxI3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6185156238;
	Sun, 24 Mar 2024 23:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321855; cv=none; b=uDVpEC+z7Ig4LkUx0Mu5pCFFfeaYqoX7yltLg6Fbl1SZEolAldL+UtzlW3CtOcCOwtHcsjHvkFGwJv0yGJDa1CbrQ90FqddmWi2iGW+cu5P6pewnm2yy99d3FJAJkOdBg3rfStDdtrR9q/Xn8VkPEASktC8c/+UcI2p4YXPeDXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321855; c=relaxed/simple;
	bh=SPECobL6eRbaGcUkWsjEHgv3Izr9FQwYKsUymyw/vcY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=quwfRY0oWHeGftK5iewVpPJq19akYGU77B0KfhRBzb9ehsKAmWZf/ch24FKte6wt8fwQnOwtXGdCM+s8Z1hgXuUD1TIEi1VVo0A5ce265b+FP5V/MnE7inY+hHwbLiR3k7bz8k7HSfpVfIGq98HkecS28kzciNlUNQsSuBd3eSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BxExBxI3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4F29C43399;
	Sun, 24 Mar 2024 23:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321854;
	bh=SPECobL6eRbaGcUkWsjEHgv3Izr9FQwYKsUymyw/vcY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BxExBxI3v2f0o+TP++4uTpggqsQ01nQiCL9bJya66dT629sS5pr+FB/ZqmfBUkQRO
	 LaU4lvY02BQkmeg8gUdAXDjalsvxgBecx7gIa0M6V0WAyxR/9uNr69X4uvoOYxA1l/
	 7xgnqXSO7QrbbKuwXWXnNGpCHAHkKmZkKINlDdM+eHlkdjxjowDJf+qPUMZpSCL8ov
	 3NI1fglaYpU+3VysfqgrqLVtiSJjGAEvJi9LAO9qymXP2rjSor0/HUZ3IE8+/p6q6s
	 7SjmPMUjTnIFG4byts8qPm1+0yCrNuIsnVamOvhEc/jyOHoKKNTMJ8o32EGa2+DDEG
	 rs1TMQMqv5GIg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Linu Cherian <lcherian@marvell.com>,
	Sunil Goutham <sgoutham@marvell.com>,
	Subbaraya Sundeep <sbhatta@marvell.com>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 583/638] octeontx2-af: Use matching wake_up API variant in CGX command interface
Date: Sun, 24 Mar 2024 19:00:20 -0400
Message-ID: <20240324230116.1348576-584-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
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
index e06f77ad6106b..6c18d3d2442eb 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
@@ -1340,7 +1340,7 @@ static irqreturn_t cgx_fwi_event_handler(int irq, void *data)
 
 		/* Release thread waiting for completion  */
 		lmac->cmd_pend = false;
-		wake_up_interruptible(&lmac->wq_cmd_cmplt);
+		wake_up(&lmac->wq_cmd_cmplt);
 		break;
 	case CGX_EVT_ASYNC:
 		if (cgx_event_is_linkevent(event))
-- 
2.43.0


