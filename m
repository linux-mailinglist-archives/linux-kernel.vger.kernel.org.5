Return-Path: <linux-kernel+bounces-115960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34FA28894E7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:11:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4017296682
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A48AA26802B;
	Mon, 25 Mar 2024 03:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jod0NAwJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F23001FDA27;
	Sun, 24 Mar 2024 23:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322224; cv=none; b=ZXBofWlTgjG79BdCwLvY4/tlx3xmjRrzajtlmgQw0kX4Kad/cmuevX8THMd4N8GXTfWgq2QRAfrV+gTZUjFjT5xuYtiOJSNKyBgDSRCZUoOxuiUlW/rOGQNqvSEdW/OFMVWjPg8XWJAI0hxbz4+iDmjb7ldUr2siRdUlrEMbos8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322224; c=relaxed/simple;
	bh=lh1tWZ+Q5ip5maxsWS3cRTsoCijckQtevMH31uUa3aI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mxitt/lcznzeG8jDSC7l9PYrA5glans2je3uRaYVIH4uA1GUOxhAqxFB/wvbmBXm6NM4PaBklqeTIKfMBVFd78+LZIfOHZsocsLkibxZmfSREBSpTEKcYOetbjkVfbZg4e0yBqMDcpPhMnGMjzXFpFQYl1hbYfyhsDHw9EH+s0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jod0NAwJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CD0DC433F1;
	Sun, 24 Mar 2024 23:17:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322222;
	bh=lh1tWZ+Q5ip5maxsWS3cRTsoCijckQtevMH31uUa3aI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jod0NAwJiNEr3xWMEitMbiW8+MqN5qe5CCF4KGvaarJoa5VJdlBzd+3XC2l0NFi6+
	 yAB/ZPZy7xPsLkZweU8lakKMy0LLyRzZt6UoxCQogQeW+B/QI/llq1A5R0DKA+TTYe
	 tR6ShrYqWmRv1UIZ4Y13IAo3LBr1DQjn0F0OnggbPYKfeUL3MVnAdCUFmArcDEcv+z
	 ZdFgEkAWNw5GIQHQzNtsc2QkIt/M1SCF27MCnDNl1moIbOKKjAQoEj6o2r/kXYPpgA
	 mdkeRKtqZN4QyOZ4MCpVA4l3W4JEKQCA1400XBuSbL7QlEe2BJ9aZckYLsdp/8MCnq
	 jsIbq7bnN/ihA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Daniil Dulov <d.dulov@aladdin.ru>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 303/451] media: pvrusb2: remove redundant NULL check
Date: Sun, 24 Mar 2024 19:09:39 -0400
Message-ID: <20240324231207.1351418-304-sashal@kernel.org>
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

[ Upstream commit 95ac1210fb2753f968ebce0730d4fbc553c2a3dc ]

Pointer dip->stream cannot be NULL due to a shift, thus remove redundant
NULL check.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: c74e0062684b ("V4L/DVB (5059): Pvrusb2: Be smarter about mode restoration")
Signed-off-by: Daniil Dulov <d.dulov@aladdin.ru>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/usb/pvrusb2/pvrusb2-v4l2.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/media/usb/pvrusb2/pvrusb2-v4l2.c b/drivers/media/usb/pvrusb2/pvrusb2-v4l2.c
index c04ab7258d645..d195bd6a2248b 100644
--- a/drivers/media/usb/pvrusb2/pvrusb2-v4l2.c
+++ b/drivers/media/usb/pvrusb2/pvrusb2-v4l2.c
@@ -1198,11 +1198,6 @@ static void pvr2_v4l2_dev_init(struct pvr2_v4l2_dev *dip,
 		dip->minor_type = pvr2_v4l_type_video;
 		nr_ptr = video_nr;
 		caps |= V4L2_CAP_VIDEO_CAPTURE | V4L2_CAP_AUDIO;
-		if (!dip->stream) {
-			pr_err(KBUILD_MODNAME
-				": Failed to set up pvrusb2 v4l video dev due to missing stream instance\n");
-			return;
-		}
 		break;
 	case VFL_TYPE_VBI:
 		dip->config = pvr2_config_vbi;
-- 
2.43.0


