Return-Path: <linux-kernel+bounces-115234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19E59888DE1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:00:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B50D1C2AB9C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9A853120D0;
	Mon, 25 Mar 2024 01:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ogRCzPAO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15CE22D892;
	Sun, 24 Mar 2024 23:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324331; cv=none; b=ZX/A8Agusp6FpsmBEA1cU5nUhup4Korbng8BZ8pjjRm911w+EahdTYDAU5ZhiClCiZeZi5P6XVEZo5kRRmnQfd8zwtWBtgMEb3AJhSnbdRyuIIcQWw9BlmUjFHTC8jJGhJv7EB50cJPKUjQkVghE+9qCyuFEtqaN2RwchC2tLSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324331; c=relaxed/simple;
	bh=OKnaw5oQbcHWIiwkqxdEnLd9NQl2MIeN415S5Zds2L8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lKuTxZ5/1lMKcHwZh9vcVhqGIe775F5oVzk95yzMa6X86ozkn1D7Azx37GF0gSi1L1W3VoECZLSasbWmBkhP7OU4T9Q08DChzT7cM2pwgZfEiWCxq2x2XuxwI2MXNkg3uYInh9kMpqVj5RU2oXrpeNYT/8M/JC0jAWIHUQVrWXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ogRCzPAO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBA61C433C7;
	Sun, 24 Mar 2024 23:52:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324330;
	bh=OKnaw5oQbcHWIiwkqxdEnLd9NQl2MIeN415S5Zds2L8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ogRCzPAOn9FmxbxwJZWMRw+yu2GveHbvxhgOQqfzmDbzsOwXQZbq6UqVQrcQ9iNif
	 HVp9jqdu78jy7jqVEMEK0JH7limPBYSvRHzgVrnFtHgSzIJsQ6CXvQ2mGgtE28FGes
	 fqP2rEX7mCgyqQ04DPps+KwigwBhFuxQSU2qkZeNKPj3Ue6XH/pfEfwY5ljwDm2+fn
	 RyM8AvkCrb/jxQYjHxBWSEM3d0WC+PXZMbPVQNdGOYvqZ2CnUCpCuUUn3gpPA/J3Ym
	 oAFOgi9a1lUSjwYWAprzijyVfFirTi6tIxQxtvqUwRhq/hVD99Fbcho6ivnANA0Ugv
	 biqYDq/aED60w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Daniil Dulov <d.dulov@aladdin.ru>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 101/148] media: go7007: add check of return value of go7007_read_addr()
Date: Sun, 24 Mar 2024 19:49:25 -0400
Message-ID: <20240324235012.1356413-102-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324235012.1356413-1-sashal@kernel.org>
References: <20240324235012.1356413-1-sashal@kernel.org>
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
index b84a6f6548610..957c07479713f 100644
--- a/drivers/media/usb/go7007/go7007-usb.c
+++ b/drivers/media/usb/go7007/go7007-usb.c
@@ -1206,7 +1206,9 @@ static int go7007_usb_probe(struct usb_interface *intf,
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


