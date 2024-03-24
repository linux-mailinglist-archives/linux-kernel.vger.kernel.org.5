Return-Path: <linux-kernel+bounces-116214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 398F1889D98
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:48:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5508E2C460D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B175E3BD1EE;
	Mon, 25 Mar 2024 03:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FEL9H/Mm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A6E017DC13;
	Sun, 24 Mar 2024 23:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323842; cv=none; b=Sm+SsfN+zarfYfLR9+czJfyyopbC5O4Mhfj6bN0bl99CA/qISprtUcxPtW7jkehJ8bTZ9+0SLiEXMILOyJCVXIu+jsJohPZ2fL6U7fk+SdjRflRqX2k77cIuwnq+Y1WbEYjm75TBqv4IlkBkPSZ4KexvY3sm2/+hb57dboSkABo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323842; c=relaxed/simple;
	bh=qgJvgN2LHYJYDjN6bEkAEEGgxks64Tc9fbrS0uhs42A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OPN01S20gB3sewnDvH0kxfKChbt4YDqh7cK0kvzpbThY25QlSmwbS3nGemc8LcIUG0w6f1o+iYD/ZFskVKO7VUm95C588RzAY+KPguhzHSy4HXlUoF8PZXWdTsSrJVejdxXLY8aA+2/ITeJuUtOlkQop/01lOBiDVYcow5poXR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FEL9H/Mm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F9AAC43390;
	Sun, 24 Mar 2024 23:44:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323841;
	bh=qgJvgN2LHYJYDjN6bEkAEEGgxks64Tc9fbrS0uhs42A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FEL9H/Mmpl76d6jVruOMs/+6AOngj+7cNlRbeTo+OmG4IUF7MJi8l+kIxpAvIPm9V
	 YYwNYKczIWQSA3VLX2WhC0t5zCeFReGxc86CmS3GAjbvMlpjwVpuGVsNajhWCExxpC
	 M/V8lXvvEfzSxjA4gxbFAEfdrnK2TvEXaQ34m8L8JFDY0G+zdomGys4IO1PLQFSKP7
	 ZytVmb8nRD6EPMVY2nA3XSkGrwggxrJpY8DyZRksjfxMnJWYT+eI8YoB+Gl//130St
	 ef2nMIISnbH6TKPKCwXe2JZMmexBg5lT+p4tIVJ7I0c5fnBs9WCEB2W3VcYga/MzIx
	 QoeJxJqAIW/Bw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Linu Cherian <lcherian@marvell.com>,
	Sunil Goutham <sgoutham@marvell.com>,
	Subbaraya Sundeep <sbhatta@marvell.com>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 219/238] octeontx2-af: Use matching wake_up API variant in CGX command interface
Date: Sun, 24 Mar 2024 19:40:07 -0400
Message-ID: <20240324234027.1354210-220-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234027.1354210-1-sashal@kernel.org>
References: <20240324234027.1354210-1-sashal@kernel.org>
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
index c0a0a31272cc2..55dfe1a20bc99 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
@@ -714,7 +714,7 @@ static irqreturn_t cgx_fwi_event_handler(int irq, void *data)
 
 		/* Release thread waiting for completion  */
 		lmac->cmd_pend = false;
-		wake_up_interruptible(&lmac->wq_cmd_cmplt);
+		wake_up(&lmac->wq_cmd_cmplt);
 		break;
 	case CGX_EVT_ASYNC:
 		if (cgx_event_is_linkevent(event))
-- 
2.43.0


