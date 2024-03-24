Return-Path: <linux-kernel+bounces-113330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62EDA888376
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:11:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3A221F228C2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 507BF45979;
	Sun, 24 Mar 2024 22:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fFBv5zeO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B964195FE8;
	Sun, 24 Mar 2024 22:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320131; cv=none; b=ErFtPPzHpWcgKJneqfRMQbsKRbc93sNK6iEg9l/8d7r6nmtJknBbIKUqWx2ZHG2tOOXUhaf2sF1vXBbK0ILaG59q82dY6Pwq3/VNEeE0ZokEtkl5RDStiDYxQF39bJdGGsIc+efEZuOvNdwxzsleQtcnFjPrUaahi72/3vuOCmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320131; c=relaxed/simple;
	bh=BApVoZr1HWgG77uIAlP5say5xUHr6e9CzMP/GXvg8hE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OfzYc5DM7510KdNfswhWrgLboHY9609j5j2dyMuoNaaT7C/eokGXElhX+LliS5VffUAE6nzeKTYaKV06x2ioxHPlA6Kj+R2sRwvi0WTHJVg9gcm8Z7O5l7ZP8O5/5bmzWz4BLa2iCAGJPWPGMD9DkanR0Y8AJN2iiPRQYI01HVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fFBv5zeO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF8EAC433C7;
	Sun, 24 Mar 2024 22:42:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320131;
	bh=BApVoZr1HWgG77uIAlP5say5xUHr6e9CzMP/GXvg8hE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fFBv5zeOaVRaELDr7aTUmkBrWutTFG3IUUm7KLWUl1gVCKWQXalzCHeX6EzjCVEFk
	 2Rassr2G2mk99BG86kOmYR7QqBvFBXf8BH3uwIEysRkg0KoURSbse/28FcGY033Fgc
	 nQ2XbSr0s56Q9ual878uLLC3X9PqYp1rDs8OsaM6A1At8JWTRlAn/TZv2L607aCoKQ
	 T8bs3W9jYcEzJrzsB3DPbrxdCz4UMYGhYXF1YhJ5yvXr7eNbVb8/3DpJUHRJuMQTNf
	 zqURhypq9oYQrTb7Yjp3QwYdtL0PBAaSsIhT01al93KFR0PfZmrtAk1fkE/fXxzAdk
	 SlTfvI+6YMo+Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Daniil Dulov <d.dulov@aladdin.ru>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 439/715] media: go7007: add check of return value of go7007_read_addr()
Date: Sun, 24 Mar 2024 18:30:18 -0400
Message-ID: <20240324223455.1342824-440-sashal@kernel.org>
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
index eeb85981e02b6..762c13e49bfa5 100644
--- a/drivers/media/usb/go7007/go7007-usb.c
+++ b/drivers/media/usb/go7007/go7007-usb.c
@@ -1201,7 +1201,9 @@ static int go7007_usb_probe(struct usb_interface *intf,
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


