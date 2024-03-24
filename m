Return-Path: <linux-kernel+bounces-116078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B963B8899EC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:19:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C070B48217
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E218E28CE41;
	Mon, 25 Mar 2024 03:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MOfKFE4C"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E8D327B100;
	Sun, 24 Mar 2024 23:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323507; cv=none; b=G/ZCVQATzrb5L8OTaZkV9M+Bn5E51MOIXyd53X9p0YnFdqW/I65cYmLThc5FfJLuC78dcq+iGyneVzBmzYX3VYEEwueRzePFwRuCmkluU1kidXVp8LhC4FYy8uXL2BRjvcsYyzIVosskDCDxHFqWFESZVAk1xSuzp5Im6r5aSbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323507; c=relaxed/simple;
	bh=fkQUcbORkODKGwcIjJeKyjjU5hkBPC4MQG1SSmB4Lms=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dc9sv2jr1NNwMBnO5lVa0Q0W/ioFWD+M38sqYZw2r53pqnQmnz7g6f0dsJd0Ir04DKDVb0R1det4bx+2ir07GRwi3C1KJIvvNlEBXYIvSW46gsfVI/xFR11yf0/flkw0/JFTHC/fRVZUvN5naS8ncytTX+kCTJLTjJdHPSZ58r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MOfKFE4C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0644C433A6;
	Sun, 24 Mar 2024 23:38:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323506;
	bh=fkQUcbORkODKGwcIjJeKyjjU5hkBPC4MQG1SSmB4Lms=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MOfKFE4CwvttOpVEGIrqdz6zm8HJFnWnp1DNCPvyvZVeODto4QR883jon1F9NW4KJ
	 SHxAjRRSOmZSZ5AuGsRx0wy/PSYUxq2yOj4OUBN+Z2qj2dne2E+wjSuLGBOirfNG2/
	 kBUTWDSPuAiQEt3Bm12kE7jGqW+HWAN49tcHX8bDtIYS19HBBPvVn7iyJCX+QSAQ2T
	 OnGU1TGlcqmuTxKGEpP9PltqLHgeKrYFipvxqcn/GE4OZKjFSDDUbvxNLxQ3xRKA94
	 4tI4lP4Ls7ZvNBNQnWoTMH9L5QIs1bHU0OqVwz+AA8PurFrw0UJzmvBzclUm80twJN
	 9Al2u0k5KS0fA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Daniil Dulov <d.dulov@aladdin.ru>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 212/317] media: pvrusb2: remove redundant NULL check
Date: Sun, 24 Mar 2024 19:33:12 -0400
Message-ID: <20240324233458.1352854-213-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324233458.1352854-1-sashal@kernel.org>
References: <20240324233458.1352854-1-sashal@kernel.org>
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


