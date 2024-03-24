Return-Path: <linux-kernel+bounces-113861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 86CEE888702
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:49:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 19236B2497D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7ECD2081DF;
	Sun, 24 Mar 2024 23:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TSvjfe3V"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 444091E9F9C;
	Sun, 24 Mar 2024 22:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320907; cv=none; b=NMdr3/H0kI7d//x8PIyRCHgdDnLW26k+WvmZFby7359ejJif2kxF+Od4ZLbBUVup/foPZXc/ju6MmrPS06FXYOQ/0tlFfuc3eyewztX369GBCNZ4XtPD1nuQHggg/D96OspFnhDpq6AAFYNyCjbNuu7MaMC0tzS0s+oZgplnqYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320907; c=relaxed/simple;
	bh=BApVoZr1HWgG77uIAlP5say5xUHr6e9CzMP/GXvg8hE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GmFOWZjL1pcApkfuH6urtls1TA4C0dxDV44levA8ljI3458+xtxCeEwRg4z4NTBL3jrY+P9QSiUouJETEOfBsR3yktGqF2pjDQrm7jc6Z8f33ua0+m1ucNFFRcd3D5QavWcalcWOdSeeL1UnM1wEfXPRrzLjg14QflNvy4Q0Evg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TSvjfe3V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44E10C43390;
	Sun, 24 Mar 2024 22:55:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320906;
	bh=BApVoZr1HWgG77uIAlP5say5xUHr6e9CzMP/GXvg8hE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TSvjfe3V4IT2yMsJQLu9Hyn/EKyCPtWXeZp9scaK9yEEp13Q0k1ZkyhZ1nkY20ekI
	 D/q6BD/nlVbCwhLRG7jS1vcaDnHDD+v4t09hceGvyQfzopuqATkkVcVFzBHMsC0DPh
	 Od54GmkYYIjCdif7SBr2tooj9pKydczJe4OLhNY4brJLVRPGq31fwA4a22vznKS1+z
	 LZoj+pbowd3qZq0ItMfhKbtmi1M4F/aGpTA6c+ImXF2cE2QpE47nFmnRJU9e9+KNMp
	 h8rpdV8WJmgBQTDmO1AoeSGU4WhlAH/cwlBf/RPh3q5BM0T8H+mcfspLTcpvBT9ZN6
	 I5rgQViGJpPwg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Daniil Dulov <d.dulov@aladdin.ru>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 470/713] media: go7007: add check of return value of go7007_read_addr()
Date: Sun, 24 Mar 2024 18:43:16 -0400
Message-ID: <20240324224720.1345309-471-sashal@kernel.org>
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


