Return-Path: <linux-kernel+bounces-113328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44B33888372
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:10:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D92491F21FD8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82368195FC4;
	Sun, 24 Mar 2024 22:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cUNoVPMT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B33821959AD;
	Sun, 24 Mar 2024 22:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320129; cv=none; b=HgHSLfmfIjlmnYBfID+iHho0kzsknVHiaHa0NDLlWi8IGxQeyP2RSAgA38l4gjub6i7CsR5VFILd+wEsVvXEf6etiPVBicpsuwKxczjOMlARqHCa5mEmHJyByomW2Kz1iBCSz6m7g71yG3rSaMcZ1tof82Q1yOGS6P4TuT/ulLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320129; c=relaxed/simple;
	bh=8J2VO8R09ZLCYY05FLmoDdK50R8Wf5+5OrJMHEcST8w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b2XKbiBNmV3JAuOoSyRxEfFF7jdvlBZvkvHIn8KtkoRfn31xBLREjqXgf1MOuXkGNW+oF0Oy6SG00LQTBm0tDjOsE5eadCH4vu8ZI0GsYLTe3RRG/Hh5DdEMUtSdSmmP9XROjgRm6/wR45gBokvEbKaM0JVf/0ckge2LAbQ50U4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cUNoVPMT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2B97C433C7;
	Sun, 24 Mar 2024 22:42:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320129;
	bh=8J2VO8R09ZLCYY05FLmoDdK50R8Wf5+5OrJMHEcST8w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cUNoVPMT5vk+46JIMPirzWq3as8qhzIfq7mLv5cyYeN0lLw65FCRQX4qXfbluMkMO
	 dV1dbsnjN/XxKjs5LIGcsu8K9MIrXf+YiwGvIX92Nl0ZNmATySVscTCJdiOk4mnFrt
	 Fg5EHKxgTnB4rlTtEnV8b6h2wahuaYDEVePF0oN7KvuZ/qbQCaAllHKpEvtkz5+3gK
	 PP0B5EFsw0K/MN1LS5CcGS92qH41S3gj+SxD2DIxSnX990K1qyD277pLDS6GRI8pv9
	 Tmj3I8LZOJMMAhTgAv70Afg/HeaZsKq/0HBw70jGsxYj/3GdQ+XxQo3TqiMFExVbiG
	 wpwClVBVz9b9g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Changhuang Liang <changhuang.liang@starfivetech.com>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 437/715] staging: media: starfive: Set 16 bpp for capture_raw device
Date: Sun, 24 Mar 2024 18:30:16 -0400
Message-ID: <20240324223455.1342824-438-sashal@kernel.org>
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

From: Changhuang Liang <changhuang.liang@starfivetech.com>

[ Upstream commit a38cd27c9ee8c25308b71ea16393d0c231e9bde4 ]

For StarFive JH7110 Camera Subsystem, capture_raw video device output
raw10 pixelformat requires 16bit of alignment.

Fixes: e080f339c80a ("media: staging: media: starfive: camss: Add capture driver")
Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/staging/media/starfive/camss/stf-capture.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/media/starfive/camss/stf-capture.c b/drivers/staging/media/starfive/camss/stf-capture.c
index 70c24b050a1b5..ec5169e7b3918 100644
--- a/drivers/staging/media/starfive/camss/stf-capture.c
+++ b/drivers/staging/media/starfive/camss/stf-capture.c
@@ -20,28 +20,28 @@ static const struct stfcamss_format_info stf_wr_fmts[] = {
 		.pixelformat = V4L2_PIX_FMT_SRGGB10,
 		.planes = 1,
 		.vsub = { 1 },
-		.bpp = 10,
+		.bpp = 16,
 	},
 	{
 		.code = MEDIA_BUS_FMT_SGRBG10_1X10,
 		.pixelformat = V4L2_PIX_FMT_SGRBG10,
 		.planes = 1,
 		.vsub = { 1 },
-		.bpp = 10,
+		.bpp = 16,
 	},
 	{
 		.code = MEDIA_BUS_FMT_SGBRG10_1X10,
 		.pixelformat = V4L2_PIX_FMT_SGBRG10,
 		.planes = 1,
 		.vsub = { 1 },
-		.bpp = 10,
+		.bpp = 16,
 	},
 	{
 		.code = MEDIA_BUS_FMT_SBGGR10_1X10,
 		.pixelformat = V4L2_PIX_FMT_SBGGR10,
 		.planes = 1,
 		.vsub = { 1 },
-		.bpp = 10,
+		.bpp = 16,
 	},
 };
 
-- 
2.43.0


