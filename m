Return-Path: <linux-kernel+bounces-115958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C5FC889CCF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:29:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96C41B46641
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 664A2392805;
	Mon, 25 Mar 2024 03:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nbFsb5Fp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C1721FDA13;
	Sun, 24 Mar 2024 23:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322222; cv=none; b=hppaV+AWbg/QCzKjQ6zz9OpS2GuvuCAtmW3Qedqg8WE2gCCO84gF2+BAnix01u/PF5y0NliWkX9QKt3IGWlNqLsP+uwMF12Ukkomvcb3D5+gmo+WxHjbonaunh1c8Al38a/bvmURZ93ZVMonZZNHTZHjB12MAUBdjUE994XTNR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322222; c=relaxed/simple;
	bh=BApVoZr1HWgG77uIAlP5say5xUHr6e9CzMP/GXvg8hE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SxmUTf12FOh3I8pTdIRgNlTqyyFKofhcXofNxE1x1K30zsgpQYkQXdNe7D0ezm50bbwrQdEbhm2w+2ZeAplP0PaEF7Mr08NF/4CrEPpnhnI3rGOEr0kLY8r7yxsROyXAv8AxgSBuXkwNc0WlAjPteTrYe7ckRDmKN4MAcAFqYjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nbFsb5Fp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 596B3C433C7;
	Sun, 24 Mar 2024 23:17:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322222;
	bh=BApVoZr1HWgG77uIAlP5say5xUHr6e9CzMP/GXvg8hE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nbFsb5FpEKkuxwE8U1+uvtmYo6MS9HHcLgaMyHDGwnkM3m8LuR86CAJvS74bR3tc3
	 e5ZcEnqqmbJij2Jyj6AxVaRWbHuq37e05mGAbY6bMESgEuVAuU9QfN0nGIriLAMF9a
	 k1+9aIwtBzFEj/gRQK/QtUSCGbtLHGl+NGg1h75kmxA8EO84A4wfeR1hs0AB4x4IkM
	 b/TvxY0t1Oa4BDTgeBYeKI6P+ckpMLp5djufedAHVYuKPgOmHnb2tw0XuUxy8DWYC5
	 jaIqHJf2d+Lj3/6YqtDKgN16NeRgOAhKKihsfwthRQC0cSZxQKFlRjSAS6kKQDMheJ
	 DdfERoffcZhSw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Daniil Dulov <d.dulov@aladdin.ru>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 302/451] media: go7007: add check of return value of go7007_read_addr()
Date: Sun, 24 Mar 2024 19:09:38 -0400
Message-ID: <20240324231207.1351418-303-sashal@kernel.org>
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


