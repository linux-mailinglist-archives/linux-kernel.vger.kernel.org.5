Return-Path: <linux-kernel+bounces-115015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 299EF888C8C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:24:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6C4F28EDDE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F8FD284D92;
	Mon, 25 Mar 2024 00:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E6ticShk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40AC517C6A9;
	Sun, 24 Mar 2024 23:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323781; cv=none; b=DLvZ5VMSDP7lT1Z3/jnFymWwidRUzgidG2GUsJXPD8IbhFNCSSpBXDvXOwUbpIXk7mMooFmc5Zo/bLZYdIb1uBsKZvJFESFAlUUDzJwL+CiufvWPlAAUvGzVNXeQXCil8OofriihbwutTYYU9mtdiGJw2kovO9n9bq/tPAYo9rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323781; c=relaxed/simple;
	bh=fkQUcbORkODKGwcIjJeKyjjU5hkBPC4MQG1SSmB4Lms=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OUZr2yevjf/4tmcYfW9scoX6F65fapJWbZ8TYCOhCzaVAeTA7ljtWgwEu4odvjj5ptEmtcBMi89CSCq5iMR+2EMad3pBMwOucrzcIC6PAD06hbIAt3WHqlaSllY54uGUS6rV61uwLuqeIVDsP5v3aJ9uj/C1Z7WC1hQstdYZSGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E6ticShk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 819DFC433C7;
	Sun, 24 Mar 2024 23:42:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323780;
	bh=fkQUcbORkODKGwcIjJeKyjjU5hkBPC4MQG1SSmB4Lms=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=E6ticShkGwMeEs2o8MMN3Bj3vwQMxQGJo5IuJ6JQUnnUg075FU+PasyqVcTidcipN
	 AgR38GZdadzZWQ+1Zv+hAyKW2PLuSPqBWmCCT6XKBy7J7kHgvwK93eW3805H9hGBSo
	 lhFDKcmgd7K+FGdx1453y7Tqkc5aPcX7LmpUS9eVCfoNib5UlOgm+OUkIDvoJSoFpI
	 J95+055VJFTWZ6HkxZiHKsp/7jrSdOHan75bm7CpzYlCuv4yfsgB7PJ5rDFdOfTLtv
	 69IVLTJf2rytAeZZ4EC/Xi6c3H0RrsokF296VNURL9Yuovx0bdPV7QeUAZz4PQ49jT
	 +stYk7WqbHGDw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Daniil Dulov <d.dulov@aladdin.ru>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 156/238] media: pvrusb2: remove redundant NULL check
Date: Sun, 24 Mar 2024 19:39:04 -0400
Message-ID: <20240324234027.1354210-157-sashal@kernel.org>
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
index 9657c18833116..c872868becbdc 100644
--- a/drivers/media/usb/pvrusb2/pvrusb2-v4l2.c
+++ b/drivers/media/usb/pvrusb2/pvrusb2-v4l2.c
@@ -1202,11 +1202,6 @@ static void pvr2_v4l2_dev_init(struct pvr2_v4l2_dev *dip,
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


