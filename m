Return-Path: <linux-kernel+bounces-115124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32950888D42
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:44:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E35E028D28F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC58C1826E7;
	Mon, 25 Mar 2024 01:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aHoPLmNB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7009A181BBC;
	Sun, 24 Mar 2024 23:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324121; cv=none; b=UBgpqEYlnMBGZJ7YG0apny3Sou2xc2gNXTTNWVfufirAPp3uJL8TonZSYPdKvHMS1AyUFKgu6vO/czs+XLrr643Pm2Z1x4nZ2MLbzKbpoWucZTVkVefpnjepsgkYxhufXjnEJeGK6jdWLGNVVD3NdMXSPB+7A3uDDojZYP84R38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324121; c=relaxed/simple;
	bh=ugIhqE7GdCstWrrhe1fg0bgWC8eenvBUCJB2XR34C3k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mB4+6eodAYvf2UZ4P5cRVfvVTDibHgaQob78fDpAKYwg1LiF7oiRI4jzWAEBFhi2s0+hEGwJBDaLtJSA4y5/RsZdPm9ufIi7gdKYKWEOGSU9euXENfQseI4+QRW7PaR7IxsxIMWJ2ipLhDdLj98PvuZkLso7ST0QCleXJN+Swjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aHoPLmNB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9265C43394;
	Sun, 24 Mar 2024 23:48:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324120;
	bh=ugIhqE7GdCstWrrhe1fg0bgWC8eenvBUCJB2XR34C3k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aHoPLmNBzRRXjFungvJR2lP+MqC8qdIbC4H7aRtc+x+xdfca+mx+Sgb7+ApSwvMcX
	 XPgIDzZCxm0a1pOroQucDnPj7vQzsDedYkTBwJN6YEY8+783WzXpnWUEBAkhMVS4xm
	 FwKl8oi0qOpyioYvu+6cE2lgoNroFE/lrvZAFWCnawMbbKulvwatcCg0NHQxT4vUWC
	 LNTGyWeImiMxlxusPNs1BRbLfKFGN+mv+8Zxqhk/I85PkSa0OG2jarklGOvDPwMhPc
	 Gu7oAmBKBuAdLx8k/0cPPPYqgyYaS/EOl/CRsrZCUQdg2pNNe16+x+X/SNI7Z313gP
	 VpSmuSYomk0Zw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Daniil Dulov <d.dulov@aladdin.ru>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 118/183] media: go7007: add check of return value of go7007_read_addr()
Date: Sun, 24 Mar 2024 19:45:31 -0400
Message-ID: <20240324234638.1355609-119-sashal@kernel.org>
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

From: Daniil Dulov <d.dulov@aladdin.ru>

[ Upstream commit 0b70530ee740861f4776ff724fcc25023df1799a ]

If go7007_read_addr() returns error channel is not assigned a value.
In this case go to allocfail.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 866b8695d67e ("Staging: add the go7007 video driver")
Signed-off-by: Daniil Dulov <d.dulov@aladdin.ru>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/usb/go7007/go7007-usb.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/media/usb/go7007/go7007-usb.c b/drivers/media/usb/go7007/go7007-usb.c
index f889c9d740cd1..1cfe8371511d0 100644
--- a/drivers/media/usb/go7007/go7007-usb.c
+++ b/drivers/media/usb/go7007/go7007-usb.c
@@ -1198,7 +1198,9 @@ static int go7007_usb_probe(struct usb_interface *intf,
 				u16 channel;
 
 				/* read channel number from GPIO[1:0] */
-				go7007_read_addr(go, 0x3c81, &channel);
+				if (go7007_read_addr(go, 0x3c81, &channel))
+					goto allocfail;
+
 				channel &= 0x3;
 				go->board_id = GO7007_BOARDID_ADLINK_MPG24;
 				usb->board = board = &board_adlink_mpg24;
-- 
2.43.0


